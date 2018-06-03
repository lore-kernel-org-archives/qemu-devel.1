Received: from eggs.gnu.org ([2001:4830:134:3::10]:60416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fPGgQ-0000dt-Pn
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 20:15:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fPGgN-0006ol-B6
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 20:15:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:47440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fPGgN-0006mO-0x
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 20:15:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fPGgL-0006iH-Dy
	for <qemu-devel@nongnu.org>; Sun, 03 Jun 2018 00:15:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 63CAA2E80C7
	for <qemu-devel@nongnu.org>; Sun,  3 Jun 2018 00:15:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 Jun 2018 00:05:36 -0000
From: Haskell Pointer <1774830@bugs.launchpad.net>
Reply-To: Bug 1774830 <1774830@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152798433644.32292.11286299257318650919.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1774830] [NEW] qemu monitor disassembled memory
 dump produces incorrect output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

Greetings,

I've been using qemu-system-aarch64 to do some low-level programming
targeting the raspberry pi 3. While I was debugging a problem in my code
I noticed a very confusing inconsistency that I think is very likely a
bug somewhere in how qemu's monitor produces its disassembled output.

Here's my version output (installed via homebrew on macOS 10.13.4)

$ qemu-system-aarch64 --version
QEMU emulator version 2.12.0
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

Some system information (macOS 10.13.4):

$ uname -a
Darwin Lillith.local 17.5.0 Darwin Kernel Version 17.5.0: Fri Apr 13 19:32:=
32 PDT 2018; root:xnu-4570.51.2~1/RELEASE_X86_64 x86_64

Here's an example of the problem I am seeing:

qemu-system-aarch64 -S -M raspi3 -kernel kernel8.img -monitor stdio
QEMU 2.12.0 monitor - type 'help' for more information
(qemu) x /32x 0x80000
0000000000080000: 0xd53800a1 0x92400421 0xb4000061 0xd503205f
0000000000080010: 0x17ffffff 0x58000161 0x9100003f 0x58000161
0000000000080020: 0x180000e2 0x34000082 0xf800843f 0x51000442
0000000000080030: 0x35ffffa2 0xd2806763 0x17ffffff 0x00000000
0000000000080040: 0x00080000 0x00000000 0x00080050 0x00000000
0000000000080050: 0x00000000 0x00000000 0x00000000 0x00000000
0000000000080060: 0x00000000 0x00000000 0x00000000 0x00000000
0000000000080070: 0x00000000 0x00000000 0x00000000 0x00000000
(qemu) x /32i 0x80000
0x00080000:  d53800a1  mrs      x1, mpidr_el1
0x00080004:  92400421  and      x1, x1, #3
0x00080008:  b4000061  cbz      x1, #0x80014
0x0008000c:  d503205f  wfe
0x00080010:  17ffffff  b        #0x8000c
0x00080014:  58000161  ldr      x1, #0x80040
0x00080018:  9100003f  mov      sp, x1
0x0008001c:  58000161  ldr      x1, #0x80048
0x00080020:  92400421  and      x1, x1, #3
0x00080024:  b4000061  cbz      x1, #0x80030
0x00080028:  d503205f  wfe
0x0008002c:  17ffffff  b        #0x80028
0x00080030:  58000161  ldr      x1, #0x8005c
0x00080034:  9100003f  mov      sp, x1
0x00080038:  58000161  ldr      x1, #0x80064
0x0008003c:  180000e2  ldr      w2, #0x80058
0x00080040:  34000082  cbz      w2, #0x80050
0x00080044:  f800843f  str      xzr, [x1], #8
0x00080048:  51000442  sub      w2, w2, #1
0x0008004c:  35ffffa2  cbnz     w2, #0x80040
0x00080050:  d2806763  movz     x3, #0x33b
0x00080054:  17ffffff  b        #0x80050
0x00080058:  00000000  .byte    0x00, 0x00, 0x00, 0x00
0x0008005c:  00080000  .byte    0x00, 0x00, 0x08, 0x00
0x00080060:  00000000  .byte    0x00, 0x00, 0x00, 0x00
0x00080064:  00080050  .byte    0x50, 0x00, 0x08, 0x00
0x00080068:  00000000  .byte    0x00, 0x00, 0x00, 0x00
0x0008006c:  00000000  .byte    0x00, 0x00, 0x00, 0x00
0x00080070:  00000000  .byte    0x00, 0x00, 0x00, 0x00
0x00080074:  00000000  .byte    0x00, 0x00, 0x00, 0x00
0x00080078:  00000000  .byte    0x00, 0x00, 0x00, 0x00
0x0008007c:  00000000  .byte    0x00, 0x00, 0x00, 0x00

Please notice that between 0x80004 thru 0x8001c is repeated for some
reason in the /32i formatted output which also causes the addresses for
the following bytes to also be incorrect.

Just in order to keep things as clear as possible, I'll also attach the
binary shown above but disassembled by objdump instead of qemu.

$ aarch64-elf-objdump -d kernel8.elf

kernel8.elf:     file format elf64-littleaarch64

Disassembly of section .text:

0000000000080000 <_start>:
=C2=A0=C2=A0=C2=A080000:	d53800a1 	mrs	x1, mpidr_el1
=C2=A0=C2=A0=C2=A080004:	92400421 	and	x1, x1, #0x3
=C2=A0=C2=A0=C2=A080008:	b4000061 	cbz	x1, 80014 <_start+0x14>
=C2=A0=C2=A0=C2=A08000c:	d503205f 	wfe
=C2=A0=C2=A0=C2=A080010:	17ffffff 	b	8000c <_start+0xc>
=C2=A0=C2=A0=C2=A080014:	58000161 	ldr	x1, 80040 <_start+0x40>
=C2=A0=C2=A0=C2=A080018:	9100003f 	mov	sp, x1
=C2=A0=C2=A0=C2=A08001c:	58000161 	ldr	x1, 80048 <_start+0x48>
=C2=A0=C2=A0=C2=A080020:	180000e2 	ldr	w2, 8003c <_start+0x3c>
=C2=A0=C2=A0=C2=A080024:	34000082 	cbz	w2, 80034 <_start+0x34>
=C2=A0=C2=A0=C2=A080028:	f800843f 	str	xzr, [x1], #8
=C2=A0=C2=A0=C2=A08002c:	51000442 	sub	w2, w2, #0x1
=C2=A0=C2=A0=C2=A080030:	35ffffa2 	cbnz	w2, 80024 <_start+0x24>
=C2=A0=C2=A0=C2=A080034:	d2806763 	mov	x3, #0x33b                 	// #827
=C2=A0=C2=A0=C2=A080038:	17ffffff 	b	80034 <_start+0x34>
=C2=A0=C2=A0=C2=A08003c:	00000000 	.word	0x00000000
=C2=A0=C2=A0=C2=A080040:	00080000 	.word	0x00080000
=C2=A0=C2=A0=C2=A080044:	00000000 	.word	0x00000000
=C2=A0=C2=A0=C2=A080048:	00080050 	.word	0x00080050
=C2=A0=C2=A0=C2=A08004c:	00000000 	.word	0x00000000

Hopefully this is helpful information, please let me know if I left out
anything really important. Thank you!

** Affects: qemu
     Importance: Undecided
         Status: New

** Description changed:

  Greetings,
  =

  I've been using qemu-system-aarch64 to do some low-level programming
  targeting the raspberry pi 3. While I was debugging a problem in my code
  I noticed a very confusing inconsistency that I think is very likely a
- bug somewhere in how qemu's monitor produces it's disassembled output.
+ bug somewhere in how qemu's monitor produces its disassembled output.
  =

  Here's my version output (installed via homebrew on macOS 10.13.4)
  =

  $ qemu-system-aarch64 --version
  QEMU emulator version 2.12.0
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
  =

  Some system information (macOS 10.13.4):
  =

  $ uname -a
  Darwin Lillith.local 17.5.0 Darwin Kernel Version 17.5.0: Fri Apr 13 19:3=
2:32 PDT 2018; root:xnu-4570.51.2~1/RELEASE_X86_64 x86_64
  =

  Here's an example of the problem I am seeing:
  =

  qemu-system-aarch64 -S -M raspi3 -kernel kernel8.img -monitor stdio
  QEMU 2.12.0 monitor - type 'help' for more information
  (qemu) x /32x 0x80000
  0000000000080000: 0xd53800a1 0x92400421 0xb4000061 0xd503205f
  0000000000080010: 0x17ffffff 0x58000161 0x9100003f 0x58000161
  0000000000080020: 0x180000e2 0x34000082 0xf800843f 0x51000442
  0000000000080030: 0x35ffffa2 0xd2806763 0x17ffffff 0x00000000
  0000000000080040: 0x00080000 0x00000000 0x00080050 0x00000000
  0000000000080050: 0x00000000 0x00000000 0x00000000 0x00000000
  0000000000080060: 0x00000000 0x00000000 0x00000000 0x00000000
  0000000000080070: 0x00000000 0x00000000 0x00000000 0x00000000
  (qemu) x /32i 0x80000
  0x00080000:  d53800a1  mrs      x1, mpidr_el1
  0x00080004:  92400421  and      x1, x1, #3
  0x00080008:  b4000061  cbz      x1, #0x80014
- 0x0008000c:  d503205f  wfe      =

+ 0x0008000c:  d503205f  wfe
  0x00080010:  17ffffff  b        #0x8000c
  0x00080014:  58000161  ldr      x1, #0x80040
  0x00080018:  9100003f  mov      sp, x1
  0x0008001c:  58000161  ldr      x1, #0x80048
  0x00080020:  92400421  and      x1, x1, #3
  0x00080024:  b4000061  cbz      x1, #0x80030
- 0x00080028:  d503205f  wfe      =

+ 0x00080028:  d503205f  wfe
  0x0008002c:  17ffffff  b        #0x80028
  0x00080030:  58000161  ldr      x1, #0x8005c
  0x00080034:  9100003f  mov      sp, x1
  0x00080038:  58000161  ldr      x1, #0x80064
  0x0008003c:  180000e2  ldr      w2, #0x80058
  0x00080040:  34000082  cbz      w2, #0x80050
  0x00080044:  f800843f  str      xzr, [x1], #8
  0x00080048:  51000442  sub      w2, w2, #1
  0x0008004c:  35ffffa2  cbnz     w2, #0x80040
  0x00080050:  d2806763  movz     x3, #0x33b
  0x00080054:  17ffffff  b        #0x80050
  0x00080058:  00000000  .byte    0x00, 0x00, 0x00, 0x00
  0x0008005c:  00080000  .byte    0x00, 0x00, 0x08, 0x00
  0x00080060:  00000000  .byte    0x00, 0x00, 0x00, 0x00
  0x00080064:  00080050  .byte    0x50, 0x00, 0x08, 0x00
  0x00080068:  00000000  .byte    0x00, 0x00, 0x00, 0x00
  0x0008006c:  00000000  .byte    0x00, 0x00, 0x00, 0x00
  0x00080070:  00000000  .byte    0x00, 0x00, 0x00, 0x00
  0x00080074:  00000000  .byte    0x00, 0x00, 0x00, 0x00
  0x00080078:  00000000  .byte    0x00, 0x00, 0x00, 0x00
  0x0008007c:  00000000  .byte    0x00, 0x00, 0x00, 0x00
  =

  Please notice that between 0x80004 thru 0x8001c is repeated for some
  reason in the /32i formatted output which also causes the addresses for
  the following bytes to also be incorrect.
  =

  Just in order to keep things as clear as possible, I'll also attach the
  binary shown above but disassembled by objdump instead of qemu.
  =

  $ aarch64-elf-objdump -d kernel8.elf
  =

  kernel8.elf:     file format elf64-littleaarch64
  =

- =

  Disassembly of section .text:
  =

  0000000000080000 <_start>:
-    80000:	d53800a1 	mrs	x1, mpidr_el1
-    80004:	92400421 	and	x1, x1, #0x3
-    80008:	b4000061 	cbz	x1, 80014 <_start+0x14>
-    8000c:	d503205f 	wfe
-    80010:	17ffffff 	b	8000c <_start+0xc>
-    80014:	58000161 	ldr	x1, 80040 <_start+0x40>
-    80018:	9100003f 	mov	sp, x1
-    8001c:	58000161 	ldr	x1, 80048 <_start+0x48>
-    80020:	180000e2 	ldr	w2, 8003c <_start+0x3c>
-    80024:	34000082 	cbz	w2, 80034 <_start+0x34>
-    80028:	f800843f 	str	xzr, [x1], #8
-    8002c:	51000442 	sub	w2, w2, #0x1
-    80030:	35ffffa2 	cbnz	w2, 80024 <_start+0x24>
-    80034:	d2806763 	mov	x3, #0x33b                 	// #827
-    80038:	17ffffff 	b	80034 <_start+0x34>
-    8003c:	00000000 	.word	0x00000000
-    80040:	00080000 	.word	0x00080000
-    80044:	00000000 	.word	0x00000000
-    80048:	00080050 	.word	0x00080050
-    8004c:	00000000 	.word	0x00000000
+ =C2=A0=C2=A0=C2=A080000:	d53800a1 	mrs	x1, mpidr_el1
+ =C2=A0=C2=A0=C2=A080004:	92400421 	and	x1, x1, #0x3
+ =C2=A0=C2=A0=C2=A080008:	b4000061 	cbz	x1, 80014 <_start+0x14>
+ =C2=A0=C2=A0=C2=A08000c:	d503205f 	wfe
+ =C2=A0=C2=A0=C2=A080010:	17ffffff 	b	8000c <_start+0xc>
+ =C2=A0=C2=A0=C2=A080014:	58000161 	ldr	x1, 80040 <_start+0x40>
+ =C2=A0=C2=A0=C2=A080018:	9100003f 	mov	sp, x1
+ =C2=A0=C2=A0=C2=A08001c:	58000161 	ldr	x1, 80048 <_start+0x48>
+ =C2=A0=C2=A0=C2=A080020:	180000e2 	ldr	w2, 8003c <_start+0x3c>
+ =C2=A0=C2=A0=C2=A080024:	34000082 	cbz	w2, 80034 <_start+0x34>
+ =C2=A0=C2=A0=C2=A080028:	f800843f 	str	xzr, [x1], #8
+ =C2=A0=C2=A0=C2=A08002c:	51000442 	sub	w2, w2, #0x1
+ =C2=A0=C2=A0=C2=A080030:	35ffffa2 	cbnz	w2, 80024 <_start+0x24>
+ =C2=A0=C2=A0=C2=A080034:	d2806763 	mov	x3, #0x33b                 	// #827
+ =C2=A0=C2=A0=C2=A080038:	17ffffff 	b	80034 <_start+0x34>
+ =C2=A0=C2=A0=C2=A08003c:	00000000 	.word	0x00000000
+ =C2=A0=C2=A0=C2=A080040:	00080000 	.word	0x00080000
+ =C2=A0=C2=A0=C2=A080044:	00000000 	.word	0x00000000
+ =C2=A0=C2=A0=C2=A080048:	00080050 	.word	0x00080050
+ =C2=A0=C2=A0=C2=A08004c:	00000000 	.word	0x00000000
  =

  Hopefully this is helpful information, please let me know if I left out
  anything really important. Thank you!

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1774830

Title:
  qemu monitor disassembled memory dump produces incorrect output

Status in QEMU:
  New

Bug description:
  Greetings,

  I've been using qemu-system-aarch64 to do some low-level programming
  targeting the raspberry pi 3. While I was debugging a problem in my
  code I noticed a very confusing inconsistency that I think is very
  likely a bug somewhere in how qemu's monitor produces its disassembled
  output.

  Here's my version output (installed via homebrew on macOS 10.13.4)

  $ qemu-system-aarch64 --version
  QEMU emulator version 2.12.0
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

  Some system information (macOS 10.13.4):

  $ uname -a
  Darwin Lillith.local 17.5.0 Darwin Kernel Version 17.5.0: Fri Apr 13 19:3=
2:32 PDT 2018; root:xnu-4570.51.2~1/RELEASE_X86_64 x86_64

  Here's an example of the problem I am seeing:

  qemu-system-aarch64 -S -M raspi3 -kernel kernel8.img -monitor stdio
  QEMU 2.12.0 monitor - type 'help' for more information
  (qemu) x /32x 0x80000
  0000000000080000: 0xd53800a1 0x92400421 0xb4000061 0xd503205f
  0000000000080010: 0x17ffffff 0x58000161 0x9100003f 0x58000161
  0000000000080020: 0x180000e2 0x34000082 0xf800843f 0x51000442
  0000000000080030: 0x35ffffa2 0xd2806763 0x17ffffff 0x00000000
  0000000000080040: 0x00080000 0x00000000 0x00080050 0x00000000
  0000000000080050: 0x00000000 0x00000000 0x00000000 0x00000000
  0000000000080060: 0x00000000 0x00000000 0x00000000 0x00000000
  0000000000080070: 0x00000000 0x00000000 0x00000000 0x00000000
  (qemu) x /32i 0x80000
  0x00080000:  d53800a1  mrs      x1, mpidr_el1
  0x00080004:  92400421  and      x1, x1, #3
  0x00080008:  b4000061  cbz      x1, #0x80014
  0x0008000c:  d503205f  wfe
  0x00080010:  17ffffff  b        #0x8000c
  0x00080014:  58000161  ldr      x1, #0x80040
  0x00080018:  9100003f  mov      sp, x1
  0x0008001c:  58000161  ldr      x1, #0x80048
  0x00080020:  92400421  and      x1, x1, #3
  0x00080024:  b4000061  cbz      x1, #0x80030
  0x00080028:  d503205f  wfe
  0x0008002c:  17ffffff  b        #0x80028
  0x00080030:  58000161  ldr      x1, #0x8005c
  0x00080034:  9100003f  mov      sp, x1
  0x00080038:  58000161  ldr      x1, #0x80064
  0x0008003c:  180000e2  ldr      w2, #0x80058
  0x00080040:  34000082  cbz      w2, #0x80050
  0x00080044:  f800843f  str      xzr, [x1], #8
  0x00080048:  51000442  sub      w2, w2, #1
  0x0008004c:  35ffffa2  cbnz     w2, #0x80040
  0x00080050:  d2806763  movz     x3, #0x33b
  0x00080054:  17ffffff  b        #0x80050
  0x00080058:  00000000  .byte    0x00, 0x00, 0x00, 0x00
  0x0008005c:  00080000  .byte    0x00, 0x00, 0x08, 0x00
  0x00080060:  00000000  .byte    0x00, 0x00, 0x00, 0x00
  0x00080064:  00080050  .byte    0x50, 0x00, 0x08, 0x00
  0x00080068:  00000000  .byte    0x00, 0x00, 0x00, 0x00
  0x0008006c:  00000000  .byte    0x00, 0x00, 0x00, 0x00
  0x00080070:  00000000  .byte    0x00, 0x00, 0x00, 0x00
  0x00080074:  00000000  .byte    0x00, 0x00, 0x00, 0x00
  0x00080078:  00000000  .byte    0x00, 0x00, 0x00, 0x00
  0x0008007c:  00000000  .byte    0x00, 0x00, 0x00, 0x00

  Please notice that between 0x80004 thru 0x8001c is repeated for some
  reason in the /32i formatted output which also causes the addresses
  for the following bytes to also be incorrect.

  Just in order to keep things as clear as possible, I'll also attach
  the binary shown above but disassembled by objdump instead of qemu.

  $ aarch64-elf-objdump -d kernel8.elf

  kernel8.elf:     file format elf64-littleaarch64

  Disassembly of section .text:

  0000000000080000 <_start>:
  =C2=A0=C2=A0=C2=A080000:	d53800a1 	mrs	x1, mpidr_el1
  =C2=A0=C2=A0=C2=A080004:	92400421 	and	x1, x1, #0x3
  =C2=A0=C2=A0=C2=A080008:	b4000061 	cbz	x1, 80014 <_start+0x14>
  =C2=A0=C2=A0=C2=A08000c:	d503205f 	wfe
  =C2=A0=C2=A0=C2=A080010:	17ffffff 	b	8000c <_start+0xc>
  =C2=A0=C2=A0=C2=A080014:	58000161 	ldr	x1, 80040 <_start+0x40>
  =C2=A0=C2=A0=C2=A080018:	9100003f 	mov	sp, x1
  =C2=A0=C2=A0=C2=A08001c:	58000161 	ldr	x1, 80048 <_start+0x48>
  =C2=A0=C2=A0=C2=A080020:	180000e2 	ldr	w2, 8003c <_start+0x3c>
  =C2=A0=C2=A0=C2=A080024:	34000082 	cbz	w2, 80034 <_start+0x34>
  =C2=A0=C2=A0=C2=A080028:	f800843f 	str	xzr, [x1], #8
  =C2=A0=C2=A0=C2=A08002c:	51000442 	sub	w2, w2, #0x1
  =C2=A0=C2=A0=C2=A080030:	35ffffa2 	cbnz	w2, 80024 <_start+0x24>
  =C2=A0=C2=A0=C2=A080034:	d2806763 	mov	x3, #0x33b                 	// #827
  =C2=A0=C2=A0=C2=A080038:	17ffffff 	b	80034 <_start+0x34>
  =C2=A0=C2=A0=C2=A08003c:	00000000 	.word	0x00000000
  =C2=A0=C2=A0=C2=A080040:	00080000 	.word	0x00080000
  =C2=A0=C2=A0=C2=A080044:	00000000 	.word	0x00000000
  =C2=A0=C2=A0=C2=A080048:	00080050 	.word	0x00080050
  =C2=A0=C2=A0=C2=A08004c:	00000000 	.word	0x00000000

  Hopefully this is helpful information, please let me know if I left
  out anything really important. Thank you!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1774830/+subscriptions
