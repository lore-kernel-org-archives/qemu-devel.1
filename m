Received: from eggs.gnu.org ([2001:4830:134:3::10]:35859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fXYDs-0005gN-Cz
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 16:36:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fXYDp-0000RY-Ay
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 16:36:28 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:35045)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fXYDp-0000Qy-1C
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 16:36:25 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 25 Jun 2018 22:35:58 +0200
Message-Id: <20180625203559.21370-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 0/1] target/m68k: correctly disassemble move16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>

"move16 %a0@+,%a1@" and "fmovel (cpid=3) %a0@-,%fpcr" share the same opcode...
but QEMU executes move16 (and M68040 too).

You can try:

--------------8<--------------------------------------- move16.S
        .data

src:
        .long 0x01020304, 0x05060708, 0x090a0b0c, 0x0d0e0f00
dst:
        .long 0, 0, 0, 0

        .text
        .globl _start
_start:
        lea src,%a0
        lea dst,%a1

        .fopt id=3
        fmovel -(%a0),%fpcr
        move16 (%a0)+, (%a1)+

        move.l #0,%d1
        move.l #1, %d0
        trap #0
--------------8<--------------------------------------- move16.S

m68k-linux-gnu-gcc -g -m68040 -nostartfiles  -nodefaultlibs \
                   -nostdlib -o move16 move16.S

m68k-linux-gnu-objdump -d move16

move16:     file format elf32-m68k

Disassembly of section .text:

800000b8 <_start>:
800000b8:	41f9 8000 20d4 	lea 800020d4 <src>,%a0
800000be:	43f9 8000 20e4 	lea 800020e4 <dst>,%a1
800000c4:	f620 9000      	move16 %a0@+,%a1@+
800000c8:	f620 9000      	move16 %a0@+,%a1@+
800000cc:	7200           	moveq #0,%d1
800000ce:	7001           	moveq #1,%d0
800000d0:	4e40           	trap #0

qemu-m68k -d in_asm ./move16

----------------
IN:
0x800000b8:  lea 0x800020d4,%a0
0x800000be:  lea 0x800020e4,%a1
0x800000c4:  fmovel (cpid=3) %a0@-,%fpcr
0x800000c8:  fmovel (cpid=3) %a0@-,%fpcr
0x800000cc:  moveq #0,%d1
0x800000ce:  moveq #1,%d0
0x800000d0:  trap #0

This patch backports the fix from binutils to only match FPU instructions
with coprocessor ID 1.

Laurent Vivier (1):
  target/m68k: correctly disassemble move16

 disas/m68k.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

-- 
2.14.4
