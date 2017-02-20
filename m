Received: from eggs.gnu.org ([2001:4830:134:3::10]:39719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cffDZ-0008Re-S5
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 23:04:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cffDZ-0002Ug-0J
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 23:04:53 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Mon, 20 Feb 2017 15:04:28 +1100
Message-Id: <1487563478-22265-1-git-send-email-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH V3 00/10] target/ppc: Implement
 POWER9 pseries tcg legacy support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, agraf@suse.de, qemu-devel@nongnu.org, sam.bobroff@au1.ibm.com, sjitindarsingh@gmail.com

This is V3 of the patch series to implement tcg emulation support for a
POWER9 cpu model for the pseries machine type running a legacy kernel.
That is a kernel which doesn't use the new radix mmu mode or the new hash
mmu mode with segment tables.

To use a POWER9 cpu provide the command line option "-cpu POWER9".

This series attempts to avoid precluding KVM-HV support for the POWER9
cpu model but doesn't attempt to support KVM-PR or the powernv machine
for the POWER9 cpu model as these aren't currently supported or
implemented and further code changes will be required in the event these
are implemented.

This series is used as a base to implement radix support.

The changes from V2 are as follows:

 - Only migrate the partition table entry on non-zero value
 - Change how register generation works to simplify adding/removing
   registers
 - Rename mmu.h -> mmu-book3s-v3.h
 - Error report and abort on attempt to use segment tables

Suraj Jitindar Singh (10):
  target/ppc/POWER9: Add ISAv3.00 MMU definition
  target/ppc: Fix LPCR DPFD mask define
  target/ppc/POWER9: Adapt LPCR handling for POWER9
  target/ppc/POWER9: Direct all instr and data storage interrupts to the
    hypv
  target/ppc: Add patb_entry to sPAPRMachineState
  target/ppc: Don't gen an SDR1 on POWER9 and rework register creation
  target/ppc/POWER9: Add POWER9 mmu fault handler
  target/ppc/POWER9: Add POWER9 pa-features definition
  target/ppc/POWER9: Add cpu_has_work function for POWER9
  hw/ppc/spapr: Add POWER9 to pseries cpu models

 hw/ppc/spapr.c              |  47 ++++++
 hw/ppc/spapr_cpu_core.c     |   3 +
 include/hw/ppc/spapr.h      |   1 +
 target/ppc/cpu-qom.h        |   5 +-
 target/ppc/cpu.h            |  21 ++-
 target/ppc/mmu-book3s-v3.h  |  50 ++++++
 target/ppc/mmu-hash64.c     |  53 +++++-
 target/ppc/mmu-hash64.h     |   4 +-
 target/ppc/mmu_helper.c     |  44 ++++-
 target/ppc/translate.c      |   7 +-
 target/ppc/translate_init.c | 391 ++++++++++++++++++++++++++++++--------------
 11 files changed, 485 insertions(+), 141 deletions(-)
 create mode 100644 target/ppc/mmu-book3s-v3.h

-- 
2.5.5
