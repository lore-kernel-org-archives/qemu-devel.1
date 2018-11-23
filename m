Received: from eggs.gnu.org ([2001:4830:134:3::10]:43766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCif-0007yR-Qt
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCia-00036N-QM
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:09 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:55755)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gQCia-00034b-33
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:04 -0500
Received: by mail-wm1-x334.google.com with SMTP id y139so12074211wmc.5
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 06:46:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 23 Nov 2018 15:45:21 +0100
Message-Id: <20181123144558.5048-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 v2 00/37] tcg: Assorted cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com

This includes everything queued so far -- softmmu out-of-line
patches, bswap cleanups, and (new) eliminating all scratch
registers from x86 user-only memops.

This tree is now at

  https://github.com/rth7680/qemu.git tcg-next-for-4.0

for future tcg/riscv/ rebasing.


r~


Richard Henderson (37):
  tcg/i386: Always use %ebp for TCG_AREG0
  tcg/i386: Move TCG_REG_CALL_STACK from define to enum
  tcg: Return success from patch_reloc
  tcg: Add TCG_TARGET_NEED_LDST_OOL_LABELS
  tcg/i386: Add constraints for r8 and r9
  tcg/i386: Return a base register from tcg_out_tlb_load
  tcg/i386: Change TCG_REG_L[01] to not overlap function arguments
  tcg/i386: Force qemu_ld/st arguments into fixed registers
  tcg/i386: Use TCG_TARGET_NEED_LDST_OOL_LABELS
  tcg/aarch64: Add constraints for x0, x1, x2
  tcg/aarch64: Parameterize the temps for tcg_out_tlb_read
  tcg/aarch64: Parameterize the temp for tcg_out_goto_long
  tcg/aarch64: Use B not BL for tcg_out_goto_long
  tcg/aarch64: Use TCG_TARGET_NEED_LDST_OOL_LABELS
  tcg/arm: Parameterize the temps for tcg_out_tlb_read
  tcg/arm: Add constraints for R0-R5
  tcg/arm: Reduce the number of temps for tcg_out_tlb_read
  tcg/arm: Force qemu_ld/st arguments into fixed registers
  tcg/arm: Use TCG_TARGET_NEED_LDST_OOL_LABELS
  tcg/ppc: Parameterize the temps for tcg_out_tlb_read
  tcg/ppc: Split out tcg_out_call_int
  tcg/ppc: Add constraints for R7-R8
  tcg/ppc: Change TCG_TARGET_CALL_ALIGN_ARGS to bool
  tcg/ppc: Force qemu_ld/st arguments into fixed registers
  tcg/ppc: Use TCG_TARGET_NEED_LDST_OOL_LABELS
  tcg: Clean up generic bswap32
  tcg: Clean up generic bswap64
  tcg/optimize: Optimize bswap
  tcg: Add TCG_TARGET_HAS_MEMORY_BSWAP
  tcg/i386: Adjust TCG_TARGET_HAS_MEMORY_BSWAP
  tcg/aarch64: Set TCG_TARGET_HAS_MEMORY_BSWAP to false
  tcg/arm: Set TCG_TARGET_HAS_MEMORY_BSWAP to false for user-only
  tcg/i386: Propagate is64 to tcg_out_qemu_ld_direct
  tcg/i386: Restrict user-only qemu_st_i32 values to q-regs
  tcg/i386: Add setup_guest_base_seg for FreeBSD
  tcg/i386: Require segment syscalls to succeed
  tcg/i386: Remove L constraint

 tcg/aarch64/tcg-target.h     |   3 +-
 tcg/arm/tcg-target.h         |   7 +-
 tcg/i386/tcg-target.h        |  19 +-
 tcg/mips/tcg-target.h        |   1 +
 tcg/ppc/tcg-target.h         |   3 +-
 tcg/s390/tcg-target.h        |   1 +
 tcg/sparc/tcg-target.h       |   1 +
 tcg/tcg.h                    |   5 +
 tcg/tci/tcg-target.h         |   2 +
 accel/tcg/translate-all.c    |  15 +-
 tcg/aarch64/tcg-target.inc.c | 369 ++++++++--------
 tcg/arm/tcg-target.inc.c     | 643 +++++++++++++--------------
 tcg/i386/tcg-target.inc.c    | 821 ++++++++++++++++++++---------------
 tcg/mips/tcg-target.inc.c    |  29 +-
 tcg/optimize.c               |  12 +
 tcg/ppc/tcg-target.inc.c     | 562 +++++++++++++-----------
 tcg/s390/tcg-target.inc.c    |  37 +-
 tcg/sparc/tcg-target.inc.c   |  13 +-
 tcg/tcg-ldst-ool.inc.c       |  95 ++++
 tcg/tcg-op.c                 | 215 ++++++---
 tcg/tcg-pool.inc.c           |   5 +-
 tcg/tcg.c                    |  36 +-
 tcg/tci/tcg-target.inc.c     |   3 +-
 23 files changed, 1628 insertions(+), 1269 deletions(-)
 create mode 100644 tcg/tcg-ldst-ool.inc.c

-- 
2.17.2
