Received: from eggs.gnu.org ([2001:4830:134:3::10]:49358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1dy7DV-0002Nv-7j
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 22:09:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1dy7DU-0004uf-5D
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 22:09:21 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Date: Fri, 29 Sep 2017 22:08:17 -0400
Message-Id: <1506737310-21880-1-git-send-email-alindsay@codeaurora.org>
Subject: [Qemu-devel] [PATCH v2 00/13] More fully implement ARM PMUv3
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, Wei Huang <wei@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Spradling <mspradli@codeaurora.org>, Aaron Lindsay <alindsay@codeaurora.org>, Digant Desai <digantd@codeaurora.org>
List-ID: <qemu-devel.nongnu.org>

The ARM PMU implementation currently contains a basic cycle counter, but it is
often useful to gather counts of other events and filter them based on
execution mode. These patches flesh out the implementations of various PMU
registers including PM[X]EVCNTR and PM[X]EVTYPER, add a struct definition to
represent arbitrary counter types, implement mode filtering, and add
instruction, cycle, and software increment events.

I am particularly interested in feedback on the following two patches because I
think I'm likely Doing It Wrong:
 [1] target/arm: Filter cycle counter based on PMCCFILTR_EL0
 [2] target/arm: PMU: Add instruction and cycle events

In order to implement mode filtering in an event-driven way, [1] adds a pair of
calls to pmu_sync() surrounding every update to a register/variable which may
affect whether any counter is currently filtered. These pmu_sync() calls
ultimately call cpu_get_icount_raw() for enabled instruction and cycle counters
when using icount. Unfortunately, cpu->can_do_io may otherwise be zero for
these calls so the current implementation in [2] temporarily sets can_do_io to
1. I haven't see any ill side effects from this in my testing, but it doesn't
seem like the right way to handle this.

I would like to eventually add sending interrupts on counter overflow.
Suggestions for the best direction to handle this are most welcome.  

Thanks for any feedback,
Aaron

Aaron Lindsay (13):
  target/arm: A53: Initialize PMCEID[0]
  target/arm: Check PMCNTEN for whether PMCCNTR is enabled
  target/arm: Reorganize PMCCNTR read, write, sync
  target/arm: Mask PMU register writes based on PMCR_EL0.N
  target/arm: Allow AArch32 access for PMCCFILTR
  target/arm: Filter cycle counter based on PMCCFILTR_EL0
  target/arm: Implement PMOVSSET
  target/arm: Split arm_ccnt_enabled into generic pmu_counter_enabled
  target/arm: Add array for supported PMU events, generate PMCEID[01]
  target/arm: Finish implementation of PM[X]EVCNTR and PM[X]EVTYPER
  target/arm: PMU: Add instruction and cycle events
  target/arm: PMU: Set PMCR.N to 4
  target/arm: Implement PMSWINC

 target/arm/cpu.c       |  10 +-
 target/arm/cpu.h       |  34 +++-
 target/arm/cpu64.c     |   2 +
 target/arm/helper.c    | 535 +++++++++++++++++++++++++++++++++++++++++--------
 target/arm/kvm64.c     |   2 +
 target/arm/machine.c   |   2 +
 target/arm/op_helper.c |   4 +
 7 files changed, 500 insertions(+), 89 deletions(-)

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
