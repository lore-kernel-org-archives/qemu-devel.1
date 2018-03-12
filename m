Received: from eggs.gnu.org ([2001:4830:134:3::10]:44766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evU35-0005EK-4B
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:28:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evU31-0004az-Q2
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:27:59 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:49247)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1evU31-0004SA-GU
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:27:55 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 12 Mar 2018 21:27:17 +0100
Message-Id: <20180312202728.23790-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 00/11] implement 680x0 FPU (part 5)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>, Richard Henderson <rth@twiddle.net>

Implement fcosh, fsinh, ftanh, fatanh, facos, fasin,
fatan, fsincos, fcos, fsin, ftan.

This is the last series to implement FPU instructions for 680x0...

As previously, all the floatx80 functions are copied from "Previous",
the NeXT Computer Emulator, and written by Andreas Grabher.

I did not improve or clean up the code, it's a simple port of
Andreas' work from "Previous".

I think this series will need some improvemants in the future:
for intance sin and cos functions can be merged in sincos
function (and we have unmodified "adjn" variable in floatx80_cos()
and floatx80_sin() that can be removed otherwise).

"Previous" code I have ported to QEMU can be found in (r844):

  http://svn.code.sf.net/p/previous/code/trunk/src/softfloat/

"Previous" code is a C implementation of m68040 assembly language functions
found in ($NetBSD: copyright.s,v 1.2 1994/10/26 07:48:57 cgd Exp)

  https://ftp.netbsd.org/pub/NetBSD/NetBSD-current/src/sys/arch/m68k/fpsp/

All the original work is under SoftFloat-2a license, and additional work
under BSD license or GPL-v2-or-later license.

All softfloat new functions are added in target/m68k as they are derived
from m68k code.

I have compared results of these instructions from a real m68040 and from
QEMU, and they match (sincos differs [1] because in QEMU we compute it as
sin and cos, and on m68040 sin and cos results differ also with
sincos results. It looks like a rounding problem, perhaps a bug in m68040
FPU? or in my test program?)

I know this will need more work, but for the moment I only would
like to provide these new instructions to the maintream of QEMU.

[1] Example:

sincos -6.125952 -> (0.156586, 0.987664)

QEMU:

  sincos c0010000c407cd1182c2bb27 -> 3ffc0000a05812beea449a4d
                                     3ffe0000fcd791d65887d19a
  sin c0010000c407cd1182c2bb27    -> 3ffc0000a05812beea449a4d
  cos c0010000c407cd1182c2bb27    -> 3ffe0000fcd791d65887d19a

m68040:

  sincos c0010000c407cd1182c2bb27 -> 3ffc0000a05812beea449a4d
                                     3ffe0000fcd791d65887d199 <<--
  sin c0010000c407cd1182c2bb27    -> 3ffc0000a05812beea449a4d
  cos c0010000c407cd1182c2bb27    -> 3ffe0000fcd791d65887d19a

test program is basically:

    register long double a, sin, cos, pi;
    long double step;

    asm("fmovecr #0, %0" : "=f" (pi));
    step = pi / 1024;
    for (a = -2*pi; a <= 2*pi; a+= step) {
        asm("fsincos.x %2, %0, %1" : "=f" (cos), "=f" (sin) : "f" (a));
        print_result(a, sin, cos);
        asm("fsin.x %1, %0" : "=f" (sin) : "f" (a));
        asm("fcos.x %1, %0" : "=f" (cos) : "f" (a));
        print_result(a, sin, cos);
    }

Laurent Vivier (11):
  target/m68k: implement ftan
  target/m68k: implement fsin
  target/m68k: implement fcos
  target/m68k: implement fsincos
  target/m68k: implement fatan
  target/m68k: implement fasin
  target/m68k: implement facos
  target/m68k: implement fatanh
  target/m68k: implement ftanh
  target/m68k: implement fsinh
  target/m68k: implement fcosh

 target/m68k/fpu_helper.c            |   61 ++
 target/m68k/helper.h                |   11 +
 target/m68k/softfloat.c             | 1637 +++++++++++++++++++++++++++++++++++
 target/m68k/softfloat.h             |   11 +
 target/m68k/softfloat_fpsp_tables.h |  267 ++++++
 target/m68k/translate.c             |   38 +
 6 files changed, 2025 insertions(+)

-- 
2.14.3
