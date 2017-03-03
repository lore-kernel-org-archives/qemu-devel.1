Received: from eggs.gnu.org ([2001:4830:134:3::10]:44126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjdqR-000835-BH
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:25:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjdqQ-0001HO-BK
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:25:27 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  3 Mar 2017 14:24:50 +1100
Message-Id: <20170303032507.16142-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 00/17] ppc-for-2.9 queue 20170303
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, sjitindarsingh@gmail.com, sam.bobroff@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit ecb24d334af1a98ef0329f4b3b0e14ae8cb8770d:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tgt-20170302' into staging (2017-03-02 22:06:41 +0000)

are available in the git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.9-20170303

for you to fetch changes up to 992d7e976c7eca2b3129cd4bae4a0d350a8065fa:

  target/ppc: rewrite f[n]m[add,sub] using float64_muladd (2017-03-03 11:38:33 +1100)

----------------------------------------------------------------
ppc patch queuye for 2017-03-03

This will probably be my last pull request before the hard freeze.  It
has some new work, but that has all been posted in draft before the
soft freeze, so I think it's reasonable to include in qemu-2.9.

This batch has:
    * A substantial amount of POWER9 work
        * Implements the legacy (hash) MMU for POWER9
	* Some more preliminaries for implementing the POWER9 radix
          MMU
	* POWER9 has_work
	* Basic POWER9 compatibility mode handling
	* Removal of some premature tests
    * Some cleanups and fixes to the existing MMU code to make the
      POWER9 work simpler
    * A bugfix for TCG multiply adds on power
    * Allow pseries guests to access PCIe extended config space

This also includes a code-motion not strictly in ppc code - moving
getrampagesize() from ppc code to exec.c.  This will make some future
VFIO improvements easier, Paolo said it was ok to merge via my tree.

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      exec, kvm, target-ppc: Move getrampagesize() to common code

David Gibson (3):
      powernv: Don't test POWER9 CPU yet
      target/ppc/POWER9: Add POWERPC_MMU_V3 bit
      spapr_pci: Advertise access to PCIe extended config space

Nikunj A Dadhania (1):
      target/ppc: rewrite f[n]m[add,sub] using float64_muladd

Sam Bobroff (1):
      spapr: Small cleanup of PPC MMU enums

Suraj Jitindar Singh (11):
      target/ppc: Add POWER9/ISAv3.00 to compat_table
      target/ppc: Add patb_entry to sPAPRMachineState
      target/ppc: Don't gen an SDR1 on POWER9 and rework register creation
      target/ppc/POWER9: Add POWER9 mmu fault handler
      target/ppc/POWER9: Add POWER9 pa-features definition
      target/ppc/POWER9: Add cpu_has_work function for POWER9
      hw/ppc/spapr: Add POWER9 to pseries cpu models
      target/ppc: Add Instruction Authority Mask Register Check
      target/ppc: Add execute permission checking to access authority check
      target/ppc: Move no-execute and guarded page checking into new function
      target/ppc: Rework hash mmu page fault code and add defines for clarity

 exec.c                      |  82 ++++++++++
 hw/ppc/spapr.c              |  55 ++++++-
 hw/ppc/spapr_cpu_core.c     |   3 +
 hw/ppc/spapr_pci.c          |   4 +
 include/exec/ram_addr.h     |   1 +
 include/hw/ppc/spapr.h      |   1 +
 include/qemu/mmap-alloc.h   |   2 +
 target/ppc/Makefile.objs    |   2 +-
 target/ppc/compat.c         |  16 +-
 target/ppc/cpu-qom.h        |  16 +-
 target/ppc/cpu.h            |  17 +++
 target/ppc/fpu_helper.c     | 213 ++++++--------------------
 target/ppc/kvm.c            | 117 ++------------
 target/ppc/mmu-book3s-v3.c  |  37 +++++
 target/ppc/mmu-book3s-v3.h  |  50 ++++++
 target/ppc/mmu-hash64.c     | 117 ++++++++++----
 target/ppc/mmu_helper.c     |  82 +++++-----
 target/ppc/translate.c      |  19 +--
 target/ppc/translate_init.c | 364 +++++++++++++++++++++++++++++---------------
 tests/boot-serial-test.c    |   2 +-
 tests/pnv-xscom-test.c      |   5 +-
 util/mmap-alloc.c           |  25 +++
 22 files changed, 735 insertions(+), 495 deletions(-)
 create mode 100644 target/ppc/mmu-book3s-v3.c
 create mode 100644 target/ppc/mmu-book3s-v3.h
