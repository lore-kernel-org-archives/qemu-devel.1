Received: from eggs.gnu.org ([2001:4830:134:3::10]:50253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1f8XNA-0002cf-VY
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:38:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1f8XN8-0002g2-Jd
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:38:40 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Date: Tue, 17 Apr 2018 16:37:44 -0400
Message-Id: <1523997485-1905-1-git-send-email-alindsay@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 00/21] More fully implement ARM PMUv3
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

The ARM PMU implementation currently contains a basic cycle counter, but =
it is
often useful to gather counts of other events and filter them based on
execution mode. These patches flesh out the implementations of various PM=
U
registers including PM[X]EVCNTR and PM[X]EVTYPER, add a struct definition=
 to
represent arbitrary counter types, implement mode filtering, send interru=
pts on
counter overflow, and add instruction, cycle, and software increment even=
ts.

Notable changes since v3:

* Detect counter overflow and send interrupts accordingly (adds a 'shadow=
' copy
  of both PMCCNTR and general-purpose counters, possibly/probably Doing I=
t
  Wrong)
* Update counter filtering code to more closely resemble the ARM document=
ation
  in form and functionality=20
* Don't mix EL change hooks and KVM
* Don't call gen_io_start/end if not actually using icount
* Reorganized a few of the patches to more logically group changes
* Clarify and otherwise improve a few comments
* There are also a number of less significant changes scattered around

Thanks,
Aaron

Aaron Lindsay (21):
  target/arm: Check PMCNTEN for whether PMCCNTR is enabled
  target/arm: Treat PMCCNTR as alias of PMCCNTR_EL0
  target/arm: Reorganize PMCCNTR accesses
  target/arm: Mask PMU register writes based on PMCR_EL0.N
  target/arm: Fetch GICv3 state directly from CPUARMState
  target/arm: Support multiple EL change hooks
  target/arm: Add pre-EL change hooks
  target/arm: Allow EL change hooks to do IO
  target/arm: Fix bitmask for PMCCFILTR writes
  target/arm: Filter cycle counter based on PMCCFILTR_EL0
  target/arm: Allow AArch32 access for PMCCFILTR
  target/arm: Make PMOVSCLR and PMUSERENR 64 bits wide
  target/arm: Add ARM_FEATURE_V7VE for v7 Virtualization Extensions
  target/arm: Implement PMOVSSET
  target/arm: Add array for supported PMU events, generate PMCEID[01]
  target/arm: Finish implementation of PM[X]EVCNTR and PM[X]EVTYPER
  target/arm: PMU: Add instruction and cycle events
  target/arm: PMU: Set PMCR.N to 4
  target/arm: Implement PMSWINC
  target/arm: Mark PMINTENSET accesses as possibly doing IO
  target/arm: Send interrupts on PMU counter overflow

 hw/intc/arm_gicv3_cpuif.c  |  10 +-
 target/arm/cpu.c           |  68 +++-
 target/arm/cpu.h           | 119 +++++--
 target/arm/cpu64.c         |   2 -
 target/arm/helper.c        | 752 ++++++++++++++++++++++++++++++++++++++-=
------
 target/arm/internals.h     |  14 +-
 target/arm/op_helper.c     |   8 +
 target/arm/translate-a64.c |   6 +
 target/arm/translate.c     |  12 +
 9 files changed, 834 insertions(+), 157 deletions(-)

--=20
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies=
, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
