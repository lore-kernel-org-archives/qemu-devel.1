Received: from eggs.gnu.org ([2001:4830:134:3::10]:43602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1eww13-0005YP-7C
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 16:31:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1eww12-0002rr-56
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 16:31:53 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Date: Fri, 16 Mar 2018 16:30:58 -0400
Message-Id: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
Subject: [Qemu-devel] [PATCH v3 00/22] More fully implement ARM PMUv3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: qemu-devel@nongnu.org, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <alindsay@codeaurora.org>

The ARM PMU implementation currently contains a basic cycle counter, but it is
often useful to gather counts of other events and filter them based on
execution mode. These patches flesh out the implementations of various PMU
registers including PM[X]EVCNTR and PM[X]EVTYPER, add a struct definition to
represent arbitrary counter types, implement mode filtering, and add
instruction, cycle, and software increment events.

I aim to eventually add raising interrupts on counter overflow, but that is not
covered by this patchset. I think I have a reasonable grasp of the mechanics of
*how* to raise them, but am curious if anyone has thoughts on how to determine
*when* to raise them - we don't want to call into PMU code every time an
instruction is executed to check if any instruction counters have overflowed,
etc. The main candidate I've seen for doing this so far would be to set up a
QEMUTimer, but I haven't fully explored it. Does that seem plausible? Any
other/better ideas?


Changes from v2:

* Many minor fixups (splitting patches, style/comment fixes, etc.)
* Save off current cycle count during operations which may change whether a
  counter is enabled, ensuring time isn't lost (update to patch 5)
* Added the ability to have more than one el_change_hook, added hooks before EL
  changes (patches 7-9)
* Added proper handling of can_do_io during code-gen before and after the
  el_change_hooks (patch 8)
* Split off PMOVSSET register definitions so they are only enabled for v7ve+
  (added patch 15, update to 16)

Thanks for any feedback,
Aaron
 

Aaron Lindsay (22):
  target/arm: A53: Initialize PMCEID[01]
  target/arm: A15 PMCEID0 initialization style nit
  target/arm: Check PMCNTEN for whether PMCCNTR is enabled
  target/arm: Treat PMCCNTR as alias of PMCCNTR_EL0
  target/arm: Reorganize PMCCNTR read, write, sync
  target/arm: Mask PMU register writes based on PMCR_EL0.N
  target/arm: Fetch GICv3 state directly from CPUARMState
  target/arm: Support multiple EL change hooks
  target/arm: Add pre-EL change hooks
  target/arm: Allow EL change hooks to do IO
  target/arm: Fix bitmask for PMCCFILTR writes
  target/arm: Filter cycle counter based on PMCCFILTR_EL0
  target/arm: Allow AArch32 access for PMCCFILTR
  target/arm: Make PMOVSCLR 64 bits wide
  target/arm: Add ARM_FEATURE_V7VE for v7 Virtualization Extensions
  target/arm: Implement PMOVSSET
  target/arm: Split arm_ccnt_enabled into generic pmu_counter_enabled
  target/arm: Add array for supported PMU events, generate PMCEID[01]
  target/arm: Finish implementation of PM[X]EVCNTR and PM[X]EVTYPER
  target/arm: PMU: Add instruction and cycle events
  target/arm: PMU: Set PMCR.N to 4
  target/arm: Implement PMSWINC

 hw/intc/arm_gicv3_cpuif.c  |  10 +-
 target/arm/cpu.c           |  40 ++-
 target/arm/cpu.h           | 102 +++++---
 target/arm/cpu64.c         |   2 +
 target/arm/helper.c        | 616 ++++++++++++++++++++++++++++++++++++++-------
 target/arm/internals.h     |  14 +-
 target/arm/op_helper.c     |   8 +
 target/arm/translate-a64.c |   2 +
 target/arm/translate.c     |   4 +
 9 files changed, 651 insertions(+), 147 deletions(-)

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
