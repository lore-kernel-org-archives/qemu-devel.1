Received: from eggs.gnu.org ([2001:4830:134:3::10]:46297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cTxQR-0002KO-Rb
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 16:05:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cTxQM-0006h2-VU
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 16:05:47 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:54388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cTxQM-0006ft-FK
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 16:05:42 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 18 Jan 2017 22:05:14 +0100
Message-Id: <1484773521-16530-1-git-send-email-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 0/7] target-m68k: implement 680x0 FPU
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

Laurent Vivier (7):
  target-m68k: move FPU helpers to fpu_helper.c
  target-m68k: define ext_opsize
  softfloat: define 680x0 specific values
  target-m68k: use floatx80 internally
  target-m68k: add fmovem
  target-m68k: introduce fscc.
  target-m68k: implements more FPU instructions

 configure                  |    2 +-
 fpu/softfloat-specialize.h |   30 +-
 gdb-xml/m68k-fp.xml        |   21 +
 target/m68k/Makefile.objs  |    2 +-
 target/m68k/cpu.c          |   13 +-
 target/m68k/cpu.h          |   75 ++-
 target/m68k/fpu_helper.c   |  765 +++++++++++++++++++++++++++
 target/m68k/helper.c       |  165 +++---
 target/m68k/helper.h       |   57 +-
 target/m68k/qregs.def      |    4 +-
 target/m68k/translate.c    | 1244 ++++++++++++++++++++++++++++++++------------
 11 files changed, 1930 insertions(+), 448 deletions(-)
 create mode 100644 gdb-xml/m68k-fp.xml
 create mode 100644 target/m68k/fpu_helper.c

-- 
2.7.4
