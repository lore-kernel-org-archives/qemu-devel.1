Received: from eggs.gnu.org ([2001:4830:134:3::10]:40028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dagVm-0006HZ-2U
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 06:59:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dagVl-0000Fb-6q
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 06:59:22 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Jul 2017 11:59:05 +0100
Message-Id: <1501153150-19984-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.10 0/5] M profile MPU bugfixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

This patchset fixes some bugs in the M profile MPU code:
 * the guest shouldn't be able to make system space executable
 * PPB region accesses should not be subject to MPU lookups
 * we were not resetting the PMSAv7 MPU state for M profile CPUs
 * we weren't migrating the MPU_RNR state

The renaming from cp15.c6_rgnr to pmsav7.rnr is not strictly
necessary for 2.10, but it doesn't affect many places in the code
and it restores the invariant that no mutable M profile CPU
state is stored in env->cp15.something fields.

thanks
-- PMM

Peter Maydell (5):
  target/arm: Don't do MPU lookups for addresses in M profile PPB region
  target/arm: Don't allow guest to make System space executable for M
    profile
  target/arm: Rename cp15.c6_rgnr to pmsav7.rnr
  target/arm: Move PMSAv7 reset into arm_cpu_reset() so M profile MPUs
    get reset
  target/arm: Migrate MPU_RNR register state for M profile cores

 hw/intc/armv7m_nvic.c | 14 +++++------
 target/arm/cpu.c      | 14 +++++++++++
 target/arm/cpu.h      |  3 +--
 target/arm/helper.c   | 67 +++++++++++++++++++++++++++++++++++----------------
 target/arm/machine.c  | 30 ++++++++++++++++++++++-
 5 files changed, 97 insertions(+), 31 deletions(-)

-- 
2.7.4
