.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

;################
;#Specifications#
;################

;Keyboard
;========
;1|2|3|4
;Q|W|E|R
;A|S|D|F
;Z|X|C|V

;Display
;=======
screenWidth = 64
screenHeight = 32
pixels = screenWidth * screenHeight

.data
;Memory 
;======
;4KB RAM
memory BYTE 4096 dup(0)
;Starts at 0x200
pc WORD 200h
;Graphics
graphics BYTE pixels dup(0)

;Registers
;=========
;V Registers
vreg BYTE 16 dup(?)
vx BYTE 0
vy BYTE 0
;I Register
I WORD 0
;Stack
stack_pointer BYTE 0
virtual_stack WORD 16 dup(0)

;Fontset
;=======
;Hexadecimal 0-F line by line
fontset BYTE 0F0h, 90h, 90h,90h, 0F0h
		BYTE	 20h, 60h, 20h, 20h, 70h 
		BYTE	 0F0h, 10h, 0F0h, 80h, 0F0h
		BYTE	 0F0h, 10h, 0F0h, 10h, 0F0h
		BYTE	 90h, 90h, 0F0h, 10h, 10h
		BYTE	 0F0h, 80h, 0F0h, 10h, 0F0h
		BYTE	 0F0h, 80h, 0F0h, 90h, 0F0h
		BYTE	 0F0h, 10h, 20h, 40h, 40h 
		BYTE	 0F0h, 90h, 0F0h, 90h, 0F0h
		BYTE	 0F0h, 90h, 0F0h, 10h, 0F0h
		BYTE	 0F0h, 90h, 0F0h, 90h, 90h
		BYTE	 0E0h, 90h, 0E0h, 90h, 0E0h
		BYTE	 0F0h, 80h, 80h, 80h, 0F0h
		BYTE	 0E0h, 90h, 90h, 90h, 0E0h
		BYTE	 0F0h, 80h, 0F0h, 80h, 0F0h
		BYTE	 0F0h, 80h, 0F0h, 80h, 80h

;Timers
;======
delayTimer BYTE 0
soundTimer BYTE 0				;When sountTimer does not equal 0, sound is buzzing.

;Instruction Variables;
;======================
;For easy addressing in
;Opcode decoding.
;Trust me. They are useful
;SNNN
;SXYN
;First 4 bits
S BYTE 0
;Last 12 bits
NNN WORD 0
;Last 8 bits
NN WORD 0
;Last 4 bits
N BYTE 0
;Second 4 bits
x BYTE 0
;Third 4 bits
Y BYTE 0

;Others
;======
;Opcode Holder
opcode WORD 0
;Drawing Flag
drawFlag BYTE 0


.code
CPU_INIT PROTO

main proc
	;SET UP SCREEN
	;LOAD GAME INTO MEMORY
	INVOKE CPU_INIT
	;GAME LOOP
gameLoop:


	
	jmp gameLoop

exit: 
	invoke ExitProcess, 0
main endp

CPU_INIT PROC
	mov ecx, 90
	mov esi, OFFSET memory
	mov edi, OFFSET fontset
l:
	mov al, [edi]
	mov [esi], al
	inc esi
	inc edi
	loop l
	ret
CPU_INIT ENDP



end main