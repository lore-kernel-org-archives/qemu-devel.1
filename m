Received: from eggs.gnu.org ([2001:4830:134:3::10]:51015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cYGVh-0002jf-MZ
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:17:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cYGVd-00023s-Lp
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:17:01 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:56054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cYGVd-00023a-Bb
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:16:57 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 30 Jan 2017 19:16:18 +0100
Message-Id: <20170130181634.13934-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 00/16] target-m68k: implement 680x0 FPU
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

The series also adds the FPU status and control registers and
several floating point instructions.

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

After this series is applied, qemu-m68k can run a debian etch-m68k
or a debian unstable chroot.

v2:
    complete rework of the series
    force single precision in ColdFire mode
    add "forced" precision instructions (fsmove, fdmove, fsadd, ...)
    fixed Fcc.

Laurent Vivier (16):
  softfloat: define 680x0 specific values
  softloat: disable floatx80_invalid_encoding() for m68k
  target-m68k: move FPU helpers to fpu_helper.c
  target-m68k: define ext_opsize
  target-m68k: use floatx80 internally
  target-m68k: add FPCR and FPSR
  target-m68k: manage FPU exceptions
  target-m68k: define 96bit FP registers for gdb on 680x0
  target-m68k: add fmovem
  target-m68k: add fscc.
  target-m68k: add fmovecr
  target-m68k: add fscale, fgetman, fgetexp and fmod
  target-m68k: add fsglmul and fsgldiv
  target-m68k: add explicit single and double precision operations
  target-m68k: add more FPU instructions
  target-m68k: add fsincos

 configure                  |    2 +-
 fpu/softfloat-specialize.h |   30 +-
 fpu/softfloat.c            |   20 +
 gdb-xml/m68k-fp.xml        |   21 +
 include/fpu/softfloat.h    |   15 -
 target/m68k/Makefile.objs  |    2 +-
 target/m68k/cpu.c          |   13 +-
 target/m68k/cpu.h          |   75 ++-
 target/m68k/fpu_helper.c   |  972 ++++++++++++++++++++++++++++++++
 target/m68k/helper.c       |  165 +++---
 target/m68k/helper.h       |   73 ++-
 target/m68k/qregs.def      |    4 +-
 target/m68k/translate.c    | 1316 +++++++++++++++++++++++++++++++++-----------
 13 files changed, 2238 insertions(+), 470 deletions(-)
 create mode 100644 gdb-xml/m68k-fp.xml
 create mode 100644 target/m68k/fpu_helper.c

-- 
2.9.3
