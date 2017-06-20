Received: from eggs.gnu.org ([2001:4830:134:3::10]:55350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dNQ81-0008AJ-PT
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 16:52:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dNQ7w-0004Cd-WA
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 16:52:01 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:62269)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dNQ7w-0004CE-Ji
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 16:51:56 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 20 Jun 2017 22:51:15 +0200
Message-Id: <20170620205121.26515-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v5 0/6] target-m68k: implement 680x0 FPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

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

v5:
    rebase, some patches are now part of master
    call cpu_m68k_set_fpcr() in XX_fpu_gdb_set_reg()
    generate unimplemented data type exception for
    packed data type, and only on coldfire, for extended
    data type
    remove QEMU_FPCR/QEMU_FPSR
    rework gen_op_fmove_fcr()
    replace cpu_abort(...) by qemu_log_mask(LOG_UNIMP, ...)
    add a patch to reset FPU registers
    add a patch to manage FPU registers in ucontext (linux-user)

Note: I will replace floatx80 by a floatx96, later, once we
      have a working linux-user qemu-m68k.

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

Laurent Vivier (6):
  target-m68k: move fmove CR to a function
  target-m68k: initialize FPU registers
  target-m68k: use floatx80 internally
  target-m68k: define 96bit FP registers for gdb on 680x0
  target-m68k: add FPCR and FPSR
  target-m68k,linux-user: manage FP registers in ucontext

 configure                |   2 +-
 gdb-xml/m68k-fp.xml      |  21 +
 linux-user/signal.c      |  41 ++
 target/m68k/cpu.c        |   9 +-
 target/m68k/cpu.h        |  58 ++-
 target/m68k/fpu_helper.c | 180 ++++++---
 target/m68k/helper.c     |  77 +++-
 target/m68k/helper.h     |  38 +-
 target/m68k/qregs.def    |   1 -
 target/m68k/translate.c  | 983 ++++++++++++++++++++++++++++++++---------------
 10 files changed, 1025 insertions(+), 385 deletions(-)
 create mode 100644 gdb-xml/m68k-fp.xml

-- 
2.9.4
