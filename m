Received: from eggs.gnu.org ([2001:4830:134:3::10]:43175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drpgv-0003KK-5g
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:13:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drpgu-0006Lt-7L
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:13:45 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2017 19:13:47 +0100
Message-Id: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 00/19] ARMv8M: support security extn in the NVIC
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

This patchset is another lump of v8M support. It mostly
covers the NVIC, which has extensive changes to handle the
fact that some exceptions are now banked. It sits on top of
the set of minor fixes that I sent out the other day.

(I have a chunk of patches that follow on from this to add
the security extension support to exception entry and exit
code, thus using the API changes made for the acknowledge
and complete functions in the last patch. They need a little
bit more baking, though, and 19 patches is enough as it is.)

Testing status: I'm pretty happy that these patches are the
right shape, but they might have minor bugs in the details.
(My uvisor test case won't currently run very far because
it wants the SG instruction.)
They shouldn't break v7M code, though, and it seems better to
me to move things into master and bugfix them later if necessary
rather than hold onto an enormous stack of patches that's
unreviewably large.

thanks
-- PMM

Peter Maydell (19):
  target/arm: Implement MSR/MRS access to NS banked registers
  nvic: Add banked exception states
  nvic: Add cached vectpending_is_s_banked state
  nvic: Add cached vectpending_prio state
  nvic: Implement AIRCR changes for v8M
  nvic: Make ICSR.RETTOBASE handle banked exceptions
  nvic: Implement NVIC_ITNS<n> registers
  nvic: Handle banked exceptions in nvic_recompute_state()
  nvic: Make set_pending and clear_pending take a secure parameter
  nvic: Make SHPR registers banked
  nvic: Compare group priority for escalation to HF
  nvic: In escalation to HardFault, support HF not being priority -1
  nvic: Implement v8M changes to fixed priority exceptions
  nvic: Disable the non-secure HardFault if AIRCR.BFHFNMINS is clear
  nvic: Handle v8M changes in nvic_exec_prio()
  target/arm: Handle banking in negative-execution-priority check in
    cpu_mmu_index()
  nvic: Make ICSR banked for v8M
  nvic: Make SHCSR banked for v8M
  nvic: Support banked exceptions in acknowledge and complete

 include/hw/intc/armv7m_nvic.h |  33 +-
 target/arm/cpu.h              |  62 ++-
 hw/intc/armv7m_nvic.c         | 909 +++++++++++++++++++++++++++++++++++-------
 target/arm/cpu.c              |   7 +
 target/arm/helper.c           | 142 ++++++-
 hw/intc/trace-events          |  13 +-
 6 files changed, 996 insertions(+), 170 deletions(-)

-- 
2.7.4
