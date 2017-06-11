Received: from eggs.gnu.org ([2001:4830:134:3::10]:37157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dKC6Q-0001yc-5t
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 19:17:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dKC6M-0007zv-Vh
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 19:17:02 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:60680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dKC6M-0007zX-K5
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 19:16:58 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 12 Jun 2017 01:16:26 +0200
Message-Id: <20170611231633.32582-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v4 0/7] target-m68k: implement 680x0 FPU
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

This series modifies the original ColdFire FPU implementation
to use floatx80 instead of float64 internally as this
is the native datatype for 680x0. I didn't keep the float64
type for ColdFire, but if someone thinks it's required I
can update this series in this way.

The series also adds the FPU status and control registers.

The floatx80 datatype used here is not exactly the same as the
one used by 680x0 for its extended precision data type, because
normally the signaling bit of 680x0 NAN is the MSB of the mantissa
minus one and in floatx80 it is the MSB.

We also add the gdb server parts to read the new FPU registers.
A strange thing happens here: while the gdb client running remotely
from a debian etch-m68k has no issue working with 96bit FPU registers
(the 680x0 extended precision data type), new gdbs (from a debian unstable
and gdb for cross-compiled environment) don't expect this FPU registers
size. But it seems like a bug in gdb, not in this implementation.

v4:
    this is only a subset of v3
    add a patch to move fmove CR to a function
    use "FPReg *" instead of FP0/FP1 temporaries
    fcmp/ftst take old FPSR register from parameters
    and return the new one
    add R-b from Richard

v3:
    fix fsave opcode
    Add comment to define "unnormalized" number
    Correctly define pickNaN()

v2:
    complete rework of the series
    force single precision in ColdFire mode
    add "forced" precision instructions (fsmove, fdmove, fsadd, ...)
    fixed Fcc.

Laurent Vivier (7):
  softfloat: define 680x0 specific values
  target-m68k: move FPU helpers to fpu_helper.c
  target-m68k: define ext_opsize
  target-m68k: move fmove CR to a function
  target-m68k: use floatx80 internally
  target-m68k: define 96bit FP registers for gdb on 680x0
  target-m68k: add FPCR and FPSR

 configure                  |   2 +-
 fpu/softfloat-specialize.h |  34 +-
 gdb-xml/m68k-fp.xml        |  21 ++
 target/m68k/Makefile.objs  |   2 +-
 target/m68k/cpu.c          |   9 +-
 target/m68k/cpu.h          |  42 ++-
 target/m68k/fpu_helper.c   | 207 ++++++++++
 target/m68k/helper.c       | 165 ++++----
 target/m68k/helper.h       |  38 +-
 target/m68k/qregs.def      |   2 +-
 target/m68k/translate.c    | 918 +++++++++++++++++++++++++++++++--------------
 11 files changed, 1031 insertions(+), 409 deletions(-)
 create mode 100644 gdb-xml/m68k-fp.xml
 create mode 100644 target/m68k/fpu_helper.c

-- 
2.9.4
