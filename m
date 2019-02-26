Received: from eggs.gnu.org ([209.51.188.92]:57405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkE-0004Sn-4m
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:53:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUjz-0000fo-9E
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:53:19 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:14 +1100
Message-Id: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/50] ppc-for-4.0 queue 20190226
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit ef80b99ce7ffbd66b3efd493f4ca99f8abf59e=
79:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-next-22=
0219-1' into staging (2019-02-25 14:04:20 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-4.0-20190226

for you to fetch changes up to b268a6162da8ef9daa6384f24d4b95a0385081eb:

  ppc/pnv: use IEC binary prefixes to represent sizes (2019-02-26 14:20:3=
0 +1100)

----------------------------------------------------------------
ppc patch queue 2019-02-26

Next set of patches for ppc and spapr.  There's a lot in this one:
 * Support "STOP light" states on POWER9
 * Add support for HVI interrupts on POWER9 (powernv machine)
 * CVE-2019-8934: Don't leak host model and serial information to the gue=
st
 * Tests and cleanups for various hot unplug options
 * Hash and radix MMU implementation on POWER9 for powernv machine
 * PCI Host Bridge hotplug support for pseries machine
 * Allow larger kernels and initrds for powernv machine

Plus a handful of miscellaneous fixes and cleanups.

The cpu hotplug tests and cleanups from David Hildenbrand aren't
solely power related.  However the consensus amongst Michael Tsirkin,
David Hildenbrand, Cornelia Huck and myself was that it made most
sense to come in via my tree.

----------------------------------------------------------------
Benjamin Herrenschmidt (21):
      target/ppc: Fix nip on power management instructions
      target/ppc: Don't clobber MSR:EE on PM instructions
      target/ppc: Fix support for "STOP light" states on POWER9
      target/ppc: Move "wakeup reset" code to a separate function
      target/ppc: Rename "in_pm_state" to "resume_as_sreset"
      target/ppc: Add POWER9 exception model
      target/ppc: Detect erroneous condition in interrupt delivery
      target/ppc: Add Hypervisor Virtualization Interrupt on POWER9
      target/ppc: Add POWER9 external interrupt model
      target/ppc: Add support for LPCR:HEIC on POWER9
      target/ppc/spapr: Set LPCR:HR when using Radix mode
      target/ppc/mmu: Use LPCR:HR to chose radix vs. hash translation
      target/ppc: Re-enable RMLS on POWER9 for virtual hypervisors
      target/ppc: Fix #include guard in mmu-book3s-v3.h
      target/ppc: Fix ordering of hash MMU accesses
      target/ppc: Add basic support for "new format" HPTE as found on POW=
ER9
      target/ppc: Fix synchronization of mttcg with broadcast TLB flushes
      target/ppc: Flush the TLB locally when the LPIDR is written
      target/ppc: Rename PATB/PATBE -> PATE
      target/ppc: Support for POWER9 native hash
      target/ppc: Basic POWER9 bare-metal radix MMU support

C=C3=A9dric Le Goater (1):
      ppc/xive: xive does not have a POWER7 interrupt model

David Hildenbrand (6):
      cpus: Properly release the iothread lock when killing a dummy VCPU
      spapr: support memory unplug for qtest
      tests/device-plug: Add a simple PCI unplug request test
      tests/device-plug: Add CCW unplug test for s390x
      tests/device-plug: Add CPU core unplug request test for spapr
      tests/device-plug: Add memory unplug request test for spapr

Greg Kurz (11):
      spapr_drc: Allow FDT fragment to be added later
      spapr: Generate FDT fragment for LMBs at configure connector time
      spapr: Generate FDT fragment for CPUs at configure connector time
      spapr/pci: Generate FDT fragment at configure connector time
      spapr/drc: Drop spapr_drc_attach() fdt argument
      xics: Write source state to KVM at claim time
      spapr: Expose the name of the interrupt controller node
      spapr_irq: Expose the phandle of the interrupt controller
      spapr_pci: add PHB unrealize
      spapr: add hotplug hooks for PHB hotplug
      tests/device-plug: Add PHB unplug request test for spapr

Michael Roth (5):
      spapr: create DR connectors for PHBs
      spapr_events: add support for phb hotplug events
      spapr_pci: provide node start offset via spapr_populate_pci_dt()
      spapr_pci: add ibm, my-drc-index property for PHB hotplug
      spapr: enable PHB hotplug for default pseries machine type

Murilo Opsfelder Araujo (3):
      ppc/pnv: increase kernel size limit to 256MiB
      ppc/pnv: add INITRD_MAX_SIZE constant
      ppc/pnv: use IEC binary prefixes to represent sizes

Nathan Fontenot (1):
      spapr: populate PHB DRC entries for root DT node

Prasad J Pandit (1):
      ppc: add host-serial and host-model machine attributes (CVE-2019-89=
34)

Thomas Huth (1):
      hw/ppc: Use object_initialize_child for correct reference counting

 cpus.c                          |   1 +
 hw/intc/spapr_xive.c            |  20 +-
 hw/intc/xics.c                  |   7 +
 hw/intc/xics_kvm.c              |  74 +++++---
 hw/intc/xics_spapr.c            |   2 +-
 hw/intc/xive.c                  |   4 +-
 hw/ppc/pnv.c                    |  22 ++-
 hw/ppc/pnv_psi.c                |   4 +-
 hw/ppc/ppc.c                    |  44 ++++-
 hw/ppc/spapr.c                  | 406 +++++++++++++++++++++++++++++++++-=
------
 hw/ppc/spapr_drc.c              |  51 ++++-
 hw/ppc/spapr_events.c           |   3 +
 hw/ppc/spapr_hcall.c            |  68 ++-----
 hw/ppc/spapr_irq.c              |  42 ++++-
 hw/ppc/spapr_ovec.c             |   6 +
 hw/ppc/spapr_pci.c              | 135 ++++++++++---
 hw/ppc/spapr_rtas.c             |   6 +-
 include/hw/pci-host/spapr.h     |  11 +-
 include/hw/ppc/ppc.h            |   2 +
 include/hw/ppc/spapr.h          |  13 +-
 include/hw/ppc/spapr_drc.h      |  17 +-
 include/hw/ppc/spapr_irq.h      |   2 +
 include/hw/ppc/spapr_xive.h     |   3 +
 include/hw/ppc/xics.h           |   1 +
 include/hw/ppc/xics_spapr.h     |   2 +
 target/ppc/cpu-qom.h            |   5 +
 target/ppc/cpu.h                |  33 +++-
 target/ppc/excp_helper.c        | 164 ++++++++++------
 target/ppc/helper.h             |   1 +
 target/ppc/helper_regs.h        |  27 +--
 target/ppc/misc_helper.c        |  15 ++
 target/ppc/mmu-book3s-v3.c      |  29 ++-
 target/ppc/mmu-book3s-v3.h      |  78 +++++++-
 target/ppc/mmu-hash32.c         |   6 +
 target/ppc/mmu-hash64.c         |  39 +++-
 target/ppc/mmu-hash64.h         |  22 +--
 target/ppc/mmu-radix64.c        |  95 ++++++++--
 target/ppc/mmu-radix64.h        |   4 +-
 target/ppc/mmu_helper.c         |   9 +-
 target/ppc/translate.c          |  28 ++-
 target/ppc/translate_init.inc.c |  41 +++-
 tests/Makefile.include          |   4 +
 tests/device-plug-test.c        | 178 ++++++++++++++++++
 43 files changed, 1362 insertions(+), 362 deletions(-)
 create mode 100644 tests/device-plug-test.c
