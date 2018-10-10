Received: from eggs.gnu.org ([2001:4830:134:3::10]:39397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aclindsa@gmail.com>) id 1gALFT-0002nU-Sc
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 16:38:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aclindsa@gmail.com>) id 1gALFR-0002NO-BL
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 16:38:26 -0400
From: Aaron Lindsay <aclindsa@gmail.com>
Date: Wed, 10 Oct 2018 16:37:21 -0400
Message-Id: <20181010203735.27918-1-aclindsa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 00/14] More fully implement ARM PMUv3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: qemu-devel@nongnu.org, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <aclindsa@gmail.com>

The ARM PMU implementation currently contains a basic cycle counter, but
it is often useful to gather counts of other events, filter them based
on execution mode, and/or be notified on counter overflow. These patches
flesh out the implementations of various PMU registers including
PM[X]EVCNTR and PM[X]EVTYPER, add a struct definition to represent
arbitrary counter types, implement mode filtering, send interrupts on
counter overflow, and add instruction, cycle, and software increment
events.

Since v5 [1] I have:
* Taken a first pass at addressing migration
* Restructured the list of supported events, and ensured they're all
  initialized 
* Fixed aliasing for PMOVSSET
* Added ARM_CP_IO for PMINTENCLR and PMINTENCLR_EL1
* Addressed a few non-code issues (comment style, patch staging,
  spelling, etc.)

[1] - https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg06830.html

Aaron Lindsay (14):
  target/arm: Mark PMINTENCLR and PMINTENCLR_EL1 accesses as possibly
    doing IO
  target/arm: Mask PMOVSR writes based on supported counters
  migration: Add post_save function to VMStateDescription
  target/arm: Swap PMU values before/after migrations
  target/arm: Reorganize PMCCNTR accesses
  target/arm: Filter cycle counter based on PMCCFILTR_EL0
  target/arm: Allow AArch32 access for PMCCFILTR
  target/arm: Implement PMOVSSET
  target/arm: Add array for supported PMU events, generate PMCEID[01]
  target/arm: Finish implementation of PM[X]EVCNTR and PM[X]EVTYPER
  target/arm: PMU: Add instruction and cycle events
  target/arm: PMU: Set PMCR.N to 4
  target/arm: Implement PMSWINC
  target/arm: Send interrupts on PMU counter overflow

 docs/devel/migration.rst    |   9 +-
 include/migration/vmstate.h |   1 +
 migration/vmstate.c         |  10 +-
 target/arm/cpu.c            |  28 +-
 target/arm/cpu.h            |  68 +++-
 target/arm/cpu64.c          |   2 -
 target/arm/helper.c         | 781 ++++++++++++++++++++++++++++++++----
 target/arm/machine.c        |  19 +
 8 files changed, 817 insertions(+), 101 deletions(-)

-- 
2.19.1
