Received: from eggs.gnu.org ([209.51.188.92]:34238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNep-0004L6-Ly
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:57:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNen-0000zv-W3
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:57:51 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:35804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGNen-0000ym-EJ
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:57:49 -0400
Received: by mail-wr1-x431.google.com with SMTP id w1so26953421wrp.2
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:57:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2019 13:57:18 +0100
Message-Id: <20190416125744.27770-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/26] target/arm: Implement M profile floating
 point
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org

This patchset implements floating point support for the
M-profile Arm cores and enables it for the Cortex-M4 and
Cortex-M33 (both of which should really have an FPU).

The floating point instructions for M-profile are basically
the same as for A-profile (with some minor differences like
not having all the VFP sysregs, and definitely not having
the old VFP length/stride handling). The major differences are
in the exception handling:
 * on exception entry and exit we may want to stack and
   unstack FP registers, as we do for integer registers
 * M-profile supports a "lazy stacking" mode, which means that
   on exception entry we do not stack the FP registers that
   the calling convention requires us to preserve, but just
   reserve space for them. Then if the exception handler
   executes an FP instruction we spill the FP registers to
   the stack only at that point

There are also two M-profile-only instructions, VLLDM and
VLSTM, which are for guest code to actively trigger the
lazy-stacking.

Most interesting bit to review is probably whether I got the
handling of the new TB flag bits right (in patches 18, 19
and 23), since they have a kind of self-clearing property
that's a bit non-standard.

thanks
-- PMM

Peter Maydell (26):
  target/arm: Make sure M-profile FPSCR RES0 bits are not settable
  hw/intc/armv7m_nvic: Allow reading of M-profile MVFR* registers
  target/arm: Implement dummy versions of M-profile FP-related registers
  target/arm: Disable most VFP sysregs for M-profile
  target/arm: Honour M-profile FP enable bits
  target/arm: Decode FP instructions for M profile
  target/arm: Clear CONTROL_S.SFPA in SG insn if FPU present
  target/arm: Handle SFPA and FPCA bits in reads and writes of CONTROL
  target/arm/helper: don't return early for STKOF faults during stacking
  target/arm: Handle floating point registers in exception entry
  target/arm: Implement v7m_update_fpccr()
  target/arm: Clear CONTROL.SFPA in BXNS and BLXNS
  target/arm: Clean excReturn bits when tail chaining
  target/arm: Allow for floating point in callee stack integrity check
  target/arm: Handle floating point registers in exception return
  target/arm: Move NS TBFLAG from bit 19 to bit 6
  target/arm: Overlap VECSTRIDE and XSCALE_CPAR TB flags
  target/arm: Set FPCCR.S when executing M-profile floating point insns
  target/arm: Activate M-profile floating point context when FPCCR.ASPEN
    is set
  target/arm: New helper function arm_v7m_mmu_idx_all()
  target/arm: New function armv7m_nvic_set_pending_lazyfp()
  target/arm: Add lazy-FP-stacking support to v7m_stack_write()
  target/arm: Implement M-profile lazy FP state preservation
  target/arm: Implement VLSTM for v7M CPUs with an FPU
  target/arm: Implement VLLDM for v7M CPUs with an FPU
  target/arm: Enable FPU for Cortex-M4 and Cortex-M33

 target/arm/cpu.h        |  95 ++++-
 target/arm/helper.h     |   5 +
 target/arm/translate.h  |   3 +
 hw/intc/armv7m_nvic.c   | 261 ++++++++++++
 target/arm/cpu.c        |  20 +
 target/arm/helper.c     | 873 +++++++++++++++++++++++++++++++++++++---
 target/arm/machine.c    |  16 +
 target/arm/translate.c  | 150 ++++++-
 target/arm/vfp_helper.c |   8 +
 9 files changed, 1350 insertions(+), 81 deletions(-)

-- 
2.20.1
