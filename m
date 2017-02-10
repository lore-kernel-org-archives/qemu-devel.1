Received: from eggs.gnu.org ([2001:4830:134:3::10]:40168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cc3iv-00064b-4k
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 00:26:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cc3iu-0001Ur-4Y
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 00:26:21 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 10 Feb 2017 16:25:50 +1100
Message-Id: <1486704360-27361-1-git-send-email-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH V2 00/10] target/ppc: Implement
 POWER9 pseries tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, agraf@suse.de, qemu-devel@nongnu.org, sam.bobroff@au1.ibm.com, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

This is V2 of the patch series to implement tcg emulation support for a
POWER9 cpu model for the pseries machine type running a legacy kernel.
That is a kernel which doesn't use the new radix mmu mode or the new hash
mmu mode with segment tables.

To use a POWER9 cpu provide the command line option "-cpu POWER9".

This series attempts to avoid precluding KVM-HV support for the POWER9
cpu model but doesn't attempt to support KVM-PR or the powernv machine
for the POWER9 cpu model as these aren't currently supported or
implemented and further code changes will be required in the event these
are implemented.

This series will be followed shortly by one to implement radix support and
currently trying to boot a kernel with support for radix with this series
will fail on the H_REGISTER_PROCESS_TABLE hcall.

The changes from V1 are as follows:

 - Drop patches which have already been merged.
 - Instead of allocating a whole partition table we allocate a single
   entry in the sPAPRMachineState and access it via the virtual hypv.
 - Changes to how we handle SDR1 and renaming of associated functions.
 - Drop patch to use the new pte format, guest kernels expect the old
   format anyway, so this will only be applicable when POWER9 powernv
   support is added, so delay adding support for this until then.
 - Rename the mmu fault handler to ppc64_v3_handle_mmu_fault.
 - Move segment table searching into the fault handler instead of in
   slb_lookup().
 - Move adding the POWER9 pseries cpu model to the end of the series.

Suraj Jitindar Singh (10):
  target/ppc/POWER9: Add ISAv3.00 MMU definition
  target/ppc: Fix LPCR DPFD mask define
  target/ppc/POWER9: Adapt LPCR handling for POWER9
  target/ppc/POWER9: Direct all instr and data storage interrupts to the
    hypv
  target/ppc: Add patb_entry to sPAPRMachineState
  target/ppc: Don't use SDR1 when running under a POWER9 cpu model
  target/ppc/POWER9: Add POWER9 mmu fault handler
  target/ppc/POWER9: Add POWER9 pa-features definition
  target/ppc/POWER9: Add cpu_has_work function for POWER9
  hw/ppc/spapr: Add POWER9 to pseries cpu models

 hw/ppc/spapr.c              | 37 ++++++++++++++++++
 hw/ppc/spapr_cpu_core.c     |  3 ++
 include/hw/ppc/spapr.h      |  1 +
 target/ppc/cpu-qom.h        |  5 ++-
 target/ppc/cpu.h            | 24 +++++++++++-
 target/ppc/kvm.c            |  2 +-
 target/ppc/machine.c        |  4 +-
 target/ppc/misc_helper.c    |  3 +-
 target/ppc/mmu-hash64.c     | 49 +++++++++++++++++++++---
 target/ppc/mmu-hash64.h     |  2 +-
 target/ppc/mmu.h            | 50 +++++++++++++++++++++++++
 target/ppc/mmu_helper.c     | 54 +++++++++++++++++++++++++--
 target/ppc/translate.c      |  7 +++-
 target/ppc/translate_init.c | 91 +++++++++++++++++++++++++++++++++++++++------
 14 files changed, 302 insertions(+), 30 deletions(-)
 create mode 100644 target/ppc/mmu.h

-- 
2.5.5
