Received: from eggs.gnu.org ([2001:4830:134:3::10]:47001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d2zFW-0002Se-DT
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 08:07:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d2zFV-0004Z2-7C
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 08:07:18 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Apr 2017 13:06:57 +0100
Message-Id: <1493122030-32191-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 00/13] armv7m: Implement MPU support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>

This patchset implements support for the MPU in our v7M cores. 
Support is on the same level as that for the R profile MPU: it works,
but regions smaller than 1K in size are not supported. It likely
has some missing corner-case features.

The patchset can be divided into three parts:

 * patches 1..3 are the RFC I sent out yesterday which refactors the
   mmuidx handling so that M profile can use different semantics for
   the mmu indexes (only very minor change to the RFC: I used some
   symbolic constants rather than hardcoding masks with 7 and ~7,
   tweaked a few expressions, etc)
 * patches 4..7 clean up our handling of whether the MPU
   exists or not, since we weren't consistent about whether
   ARM_FEATURE_MPU meant "PMSA, not VMSA" or "PMSA and MPU is
   present".  We rename the feature bit to ARM_FEATURE_PMSA and use
   the has_mpu flag to indicate whether a PMSA core has an MPU
   implemented or not
 * patches 8..13 implement the MPU support proper.  Most of this is
   Michael Davidsaver's code, but I've tidied it up, fixed a few
   bugs, and reimplemented the HFNMIENA support

Testing has been light -- I have a few basic MPU tests at
https://git.linaro.org/people/peter.maydell/m-profile-tests.git
but otherwise don't have anything to hand that exercises the MPU.

I wanted to get this patchset out to the list before I go off
on my break; I will come back and follow up on review comments
when I get back in June.

thanks
-- PMM

Michael Davidsaver (4):
  armv7m: Improve "-d mmu" tracing for PMSAv7 MPU
  armv7m: Implement M profile default memory map
  armv7m: Classify faults as MemManage or BusFault
  arm: add MPU support to M profile CPUs

Peter Maydell (9):
  arm: Use the mmu_idx we're passed in arm_cpu_do_unaligned_access()
  arm: Add support for M profile CPUs having different MMU index
    semantics
  arm: Use different ARMMMUIdx values for M profile
  arm: Clean up handling of no-MPU PMSA CPUs
  arm: Don't clear ARM_FEATURE_PMSA for no-mpu configs
  arm: Don't let no-MPU PMSA cores write to SCTLR.M
  arm: Remove unnecessary check on cpu->pmsav7_dregion
  arm: All M profile cores are PMSA
  arm: Implement HFNMIENA support for M profile MPU

 target/arm/cpu.h           | 118 ++++++++++++++--
 target/arm/translate.h     |   2 +-
 hw/intc/armv7m_nvic.c      | 104 ++++++++++++++
 target/arm/cpu.c           |  26 +++-
 target/arm/helper.c        | 332 +++++++++++++++++++++++++++++++--------------
 target/arm/machine.c       |   7 +-
 target/arm/op_helper.c     |   3 +-
 target/arm/translate-a64.c |  18 ++-
 target/arm/translate.c     |  14 +-
 9 files changed, 484 insertions(+), 140 deletions(-)

-- 
2.7.4
