Received: from eggs.gnu.org ([2001:4830:134:3::10]:46418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gJjyW-0004QH-ES
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:51:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gJjyU-0000GS-2C
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:51:48 -0500
From: Aaron Lindsay <aaron@os.amperecomputing.com>
Date: Mon, 5 Nov 2018 18:51:25 +0000
Message-ID: <20181105185046.2802-1-aaron@os.amperecomputing.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v7 00/12] More fully implement ARM PMUv3
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

Since v6 [1] I have made the following changes:
* Use cpu_get_host_ticks() for the cycle counter value for user mode
* Re-staged "PMU: Set PMCR.N to 4" so that the value of the pmcrn local
  variable matches the architectural value of PMCR.N
* Re-ordered "Reorganize PMCCNTR accesses" to come first to eliminate
  the churn of *_op_start/finish function names and definitions
* Use extract64 and ARRAY_SIZE macros where applicable
* Add a return value to the post_save migration function

[1] - https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02036.html

Aaron Lindsay (12):
  migration: Add post_save function to VMStateDescription
  target/arm: Reorganize PMCCNTR accesses
  target/arm: Swap PMU values before/after migrations
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
 migration/vmstate.c         |  13 +-
 target/arm/cpu.c            |  28 +-
 target/arm/cpu.h            |  68 +++-
 target/arm/cpu64.c          |   4 -
 target/arm/helper.c         | 774 ++++++++++++++++++++++++++++++++----
 target/arm/machine.c        |  20 +
 8 files changed, 816 insertions(+), 101 deletions(-)

--=20
2.19.1
