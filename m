Received: from eggs.gnu.org ([2001:4830:134:3::10]:40166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQe3S-00026J-Ok
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 14:20:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQe3P-0002cY-Kl
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 14:20:38 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33665)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQe3P-0002c3-D1
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 14:20:35 -0400
Received: by mail-qt0-x241.google.com with SMTP id c20so12282894qte.0
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 11:20:35 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <57ad91ad-7cc4-913f-7f45-c5906779bedf@amsat.org>
Date: Thu, 29 Jun 2017 15:20:31 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] disas: Disassembler disagrees with translator over
 instruction decoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Paolo Bonzini <pbonzini@redhat.com>

I got this "Disassembler disagrees with translator over instruction 
decoding" message asking to get reported here.

What happens here is coreboot incorrectly emits a Pentium2 instruction 
while I'm running qemu with a Pentium cpu. I didn't know what to expect 
but got this error message, then qemu keep looping using 100% cpu.

--

Use coreboot commit 08bb837268fb6d5ce84d07c8d9fe0ef4d56ac479, build 
default config which is QEMU:

coreboot$ make
     ...
     CBFS       coreboot.rom
Built emulation/qemu-i440fx (QEMU x86 i440fx/piix4)

Run this BIOS with a Pentium cpu, enabling in_asm debugging:

coreboot$ qemu-system-i386 -nographic \
	-cpu pentium -d in_asm,cpu_reset \
	-bios build/coreboot.rom
[...]

IN:
0x00000000fffc1728:  push   %ebx
0x00000000fffc1729:  sub    $0x8,%esp
0x00000000fffc172c:  cmpl   $0x0,0xd0d00
0x00000000fffc1733:  mov    0x10(%esp),%ebx
0x00000000fffc1737:  je     0xfffc1785

----------------
IN:
0x00000000fffc1785:  add    $0x8,%esp
0x00000000fffc1788:  mov    %ebx,%eax
0x00000000fffc178a:  pop    %ebx
0x00000000fffc178b:  ret

----------------
IN:
0x00000000fffc1c08:  mov    %ebx,(%eax)
0x00000000fffc1c0a:  add    $0x10,%esp
0x00000000fffc1c0d:  add    $0x8,%esp
0x00000000fffc1c10:  pop    %ebx
0x00000000fffc1c11:  ret

----------------
IN:
0x00000000fffc0e88:  call   0xfffc17dc

----------------
IN:
0x00000000fffc17dc:  sub    $0x28,%esp
0x00000000fffc17df:  mov    $0x402,%edx
0x00000000fffc17e4:  in     (%dx),%al
0x00000000fffc17e5:  mov    %al,0x1b(%esp)
0x00000000fffc17e9:  push   $0xd0d04
0x00000000fffc17ee:  call   0xfffc1728

----------------
IN:
0x00000000fffc17f3:  add    $0x10,%esp
0x00000000fffc17f6:  xor    %edx,%edx
0x00000000fffc17f8:  cmpb   $0xe9,0xf(%esp)
0x00000000fffc17fd:  sete   %dl
0x00000000fffc1800:  mov    %edx,(%eax)
0x00000000fffc1802:  mov    $0xfffc365f,%edx
0x00000000fffc1807:  mov    $0xfffc3656,%eax
0x00000000fffc180c:  push   $0x402
0x00000000fffc1811:  cmovne %edx,%eax
Disassembler disagrees with translator over instruction decoding
Please report this to qemu-devel@nongnu.org

Triple fault
CPU Reset (CPU 0)
EAX=fffc3656 EBX=00000000 ECX=00000000 EDX=fffc365f
ESI=fffffe52 EDI=fffc01e4 EBP=000a0000 ESP=0009ff98
EIP=fffc1811 EFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=0
ES =0010 00000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
CS =0008 00000000 ffffffff 00cf9b00 DPL=0 CS32 [-RA]
SS =0010 00000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
DS =0010 00000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
FS =0010 00000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
GS =0010 00000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
LDT=0000 00000000 0000ffff 00008200 DPL=0 LDT
TR =0000 00000000 0000ffff 00008b00 DPL=0 TSS32-busy
GDT=     fffc0200 0000001f
IDT=     00000000 00000000
CR0=60000011 CR2=00000000 CR3=00000000 CR4=00000000
DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 
DR3=0000000000000000
DR6=00000000ffff0ff0 DR7=0000000000000400
CCS=000000e9 CCD=00000016 CCO=SUBB
EFER=0000000000000000
FCW=037f FSW=0000 [ST=0] FTW=00 MXCSR=00001f80
FPR0=0000000000000000 0000 FPR1=0000000000000000 0000
FPR2=0000000000000000 0000 FPR3=0000000000000000 0000
FPR4=0000000000000000 0000 FPR5=0000000000000000 0000
FPR6=0000000000000000 0000 FPR7=0000000000000000 0000
XMM00=00000000000000000000000000000000 
XMM01=00000000000000000000000000000000
XMM02=00000000000000000000000000000000 
XMM03=00000000000000000000000000000000
XMM04=00000000000000000000000000000000 
XMM05=00000000000000000000000000000000
XMM06=00000000000000000000000000000000 
XMM07=00000000000000000000000000000000
----------------
IN:
0x00000000fffc1bf0:  cmp    $0x10000000,%eax
0x00000000fffc1bf5:  ja     0xfffc1c12

----------------
IN:
0x00000000fffc1bf7:  cmp    %edx,%eax
0x00000000fffc1bf9:  jne    0xfffc1c12

QEMU 2.8.1 monitor - type 'help' for more information
(qemu) q

also same with today's master 454d7dc9bc13e46084e0612076e6952c40f4afeb:

QEMU 2.9.50 monitor - type 'help' for more information
(qemu) q

in disas.c:

254     if (count < 0)
255         break;
256         if (size < count) {
257             fprintf(out,
258                     "Disassembler disagrees with translator over 
instruction "
259                     "decoding\n"
260                     "Please report this to qemu-devel@nongnu.org\n");
261             break;
262         }
263     }

This was added in commit 754d00ae3a1bfabb6069b59f72cdec1dee99ea0b from 
2009 with svn message:

"Safety net for the cases where disassembler/translator disagree over 
instruction decoding"

Regards,

Phil.
