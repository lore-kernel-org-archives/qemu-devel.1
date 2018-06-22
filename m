Received: from eggs.gnu.org ([2001:4830:134:3::10]:54223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1fWSjZ-000252-Id
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:32:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1fWSjY-0005Pp-Oe
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:32:41 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Date: Fri, 22 Jun 2018 16:32:14 -0400
Message-Id: <1529699547-17044-1-git-send-email-alindsay@codeaurora.org>
Subject: [Qemu-devel] [PATCH v5 00/13] More fully implement ARM PMUv3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: qemu-devel@nongnu.org, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <aclindsa@gmail.com>, Aaron Lindsay <alindsay@codeaurora.org>

The ARM PMU implementation currently contains a basic cycle counter, but it is
often useful to gather counts of other events and filter them based on
execution mode. These patches flesh out the implementations of various PMU
registers including PM[X]EVCNTR and PM[X]EVTYPER, add a struct definition to
represent arbitrary counter types, implement mode filtering, send interrupts on
counter overflow, and add instruction, cycle, and software increment events.

Since v4 I've added improved V7VE handling with Peter's direction, fixed up a
few patch staging issues, and fixed a bug causing cycle counter overflow to be
checked every instruction.

-Aaron

Aaron Lindsay (13):
  target/arm: Reorganize PMCCNTR accesses
  target/arm: Filter cycle counter based on PMCCFILTR_EL0
  target/arm: Allow AArch32 access for PMCCFILTR
  target/arm: Add ARM_FEATURE_V7VE for v7 Virtualization Extensions
  target/arm: Remove redundant DIV detection for KVM
  target/arm: Implement PMOVSSET
  target/arm: Add array for supported PMU events, generate PMCEID[01]
  target/arm: Finish implementation of PM[X]EVCNTR and PM[X]EVTYPER
  target/arm: PMU: Add instruction and cycle events
  target/arm: PMU: Set PMCR.N to 4
  target/arm: Implement PMSWINC
  target/arm: Mark PMINTENSET accesses as possibly doing IO
  target/arm: Send interrupts on PMU counter overflow

 target/arm/cpu.c    |  49 +++-
 target/arm/cpu.h    |  71 +++++-
 target/arm/cpu64.c  |   2 -
 target/arm/helper.c | 702 +++++++++++++++++++++++++++++++++++++++++++++-------
 target/arm/kvm32.c  |  27 +-
 5 files changed, 720 insertions(+), 131 deletions(-)

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
