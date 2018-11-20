Received: from eggs.gnu.org ([2001:4830:134:3::10]:57631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gPDXj-00005u-DE
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 16:26:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gPDXf-0005a7-FT
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 16:26:47 -0500
From: Aaron Lindsay <aaron@os.amperecomputing.com>
Date: Tue, 20 Nov 2018 21:26:26 +0000
Message-ID: <20181120212553.8480-1-aaron@os.amperecomputing.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v8 00/13] More fully implement ARM PMUv3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <aaron@os.amperecomputing.com>

The ARM PMU implementation currently contains a basic cycle counter, but
it is often useful to gather counts of other events, filter them based
on execution mode, and/or be notified on counter overflow. These patches
flesh out the implementations of various PMU registers including
PM[X]EVCNTR and PM[X]EVTYPER, add a struct definition to represent
arbitrary counter types, implement mode filtering, send interrupts on
counter overflow, and add instruction, cycle, and software increment
events.

Since v7 [1] I have made the following changes:
* Updated pmu_op_start/finish to not be called upon migration under KVM
* Added a patch updating PMCEID* to be 64-bit registers for AArch64 and
  added PMCEID2/3 for AArch32
* Changed get_pmceid() return two full 64-bit register values (since the
  underlying registers are now 64-bit post-ARMv8.1)
* Updated the comment for pmu_op_start/finish to match the
  implementation
* Added a check so the pmu_timer is not freed if it was not originally
  allocated

[1] - https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg00837.html

Aaron Lindsay (13):
  migration: Add post_save function to VMStateDescription
  target/arm: Reorganize PMCCNTR accesses
  target/arm: Swap PMU values before/after migrations
  target/arm: Filter cycle counter based on PMCCFILTR_EL0
  target/arm: Allow AArch32 access for PMCCFILTR
  target/arm: Implement PMOVSSET
  target-arm: Make PMCEID[01]_EL0 64 bit registers, add PMCEID[23]
  target/arm: Add array for supported PMU events, generate
    PMCEID[01]_EL0
  target/arm: Finish implementation of PM[X]EVCNTR and PM[X]EVTYPER
  target/arm: PMU: Add instruction and cycle events
  target/arm: PMU: Set PMCR.N to 4
  target/arm: Implement PMSWINC
  target/arm: Send interrupts on PMU counter overflow

 docs/devel/migration.rst    |   9 +-
 include/migration/vmstate.h |   1 +
 migration/vmstate.c         |  13 +-
 target/arm/cpu.c            |  28 +-
 target/arm/cpu.h            |  71 +++-
 target/arm/cpu64.c          |   4 -
 target/arm/helper.c         | 801 ++++++++++++++++++++++++++++++++----
 target/arm/machine.c        |  24 ++
 8 files changed, 846 insertions(+), 105 deletions(-)

--=20
2.19.1
