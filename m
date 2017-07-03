Received: from eggs.gnu.org ([2001:4830:134:3::10]:48935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dS48t-0002nS-3m
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:24:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dS48p-00010d-Uz
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:24:07 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:61551)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dS48p-000107-KY
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:24:03 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon,  3 Jul 2017 18:23:24 +0200
Message-Id: <20170703162328.24474-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 0/4] target/m68k: implement 680x0 FPU (part 3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

We start by defining the floatx80 value of infinity on m68k, as
it differs from the standard one (0x0000000000000000 instead of
0x8000000000000000). This patch superseds the patch I have
already sent that defines a "floatx80_default_inf" whereas
we have already a "floatx80_infinity": we should use
it instead.

Then we define the trigonometric function using the libm
functions. To do that, we need to introduce functions
to convert to and from floatx80 and "long double".
We use ldexpl()/frexpl() to extract exponent and
mantissa from the "long double" value. The function
to convert is also used in m68k_cpu_dump_state() to
display the value of FPU registers.

In the same way, we define fmod/frem using libm
fmodl() and remainderl().

And finally, we define fgetexp/fgetman/fscale.
For these three functions, I've tried to compare
the result with a real 68040 as most as possible.

Laurent Vivier (4):
  softfloat: use floatx80_infinity in softfloat
  target/m68k: add FPU trigonometric instructions
  target/m68k: add fmod/frem
  target-m68k: add fscale, fgetman and fgetexp

 fpu/softfloat-specialize.h |  14 ++
 fpu/softfloat.c            |  38 +++--
 include/fpu/softfloat.h    |   9 +-
 target/m68k/cpu.h          |   2 +
 target/m68k/fpu_helper.c   | 369 +++++++++++++++++++++++++++++++++++++++++++++
 target/m68k/helper.h       |  22 +++
 target/m68k/translate.c    |  88 +++++++++--
 7 files changed, 513 insertions(+), 29 deletions(-)

-- 
2.9.4
