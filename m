Received: from eggs.gnu.org ([2001:4830:134:3::10]:59227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzZt-0001RT-La
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzZs-0001yf-DP
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:05 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 27 Apr 2018 19:20:37 +1000
Message-Id: <20180427092126.24812-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/49] ppc-for-2.13 queue 20180427
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit ca92651697bdb2f15b36d347a498fbc31f4a48=
93:

  Merge remote-tracking branch 'remotes/iwj/tags/for-upstream.depriv-2' i=
nto staging (2018-04-26 19:22:09 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.13-20180427

for you to fetch changes up to 6233b679cae8741890f981c9dd6570d47715141e:

  Clear mem_path if we fall back to anonymous RAM allocation (2018-04-27 =
18:05:23 +1000)

----------------------------------------------------------------
ppc patch queue 2018-04-27

Here's the first batch of ppc patches for 2.13.  This has a lot of
stuff that's accumulated during the 2.12 freeze.  Highlights are:

    * Many improvements for the Uninorth PCI host bridge for Mac
      machine types
    * Preliminary helpers improve handling of multiple backing
      pagesizes (not strictly ppc related, but have acks and aimed to
      allow future ppc changes)
    * Cleanups to pseries cpu initialization
    * Cleanups to hash64 MMU handling
    * Assorted bugfixes and improvements

----------------------------------------------------------------
BALATON Zoltan (1):
      target/ppc: Fix reserved bit mask of dstst instruction

Bharata B Rao (1):
      spapr: Support ibm,dynamic-memory-v2 property

David Gibson (19):
      spapr: Introduce pseries-2.13 machine type
      Make qemu_mempath_getpagesize() accept NULL
      Add host_memory_backend_pagesize() helper
      target/ppc: Standardize instance_init and realize function names
      target/ppc: Simplify cpu valid check in ppc_cpu_realize
      target/ppc: Pass cpu instead of env to ppc_create_page_sizes_prop()
      target/ppc: Avoid taking "env" parameter to mmu-hash64 functions
      target/ppc: Remove fallback 64k pagesize information
      target/ppc: Move page size setup to helper function
      target/ppc: Split page size information into a separate allocation
      target/ppc: Make hash64_opts field mandatory for 64-bit hash MMUs
      target/ppc: Move 1T segment and AMR options to PPCHash64Options
      target/ppc: Fold ci_large_pages flag into PPCHash64Options
      target/ppc: Remove unnecessary POWERPC_MMU_V3 flag from mmu_model
      target/ppc: Get rid of POWERPC_MMU_VER() macros
      target/ppc: Fold slb_nr into PPCHash64Options
      target/ppc: Don't bother with MSR_EP in cpu_ppc_set_papr()
      spapr: Set compatibility mode before the rest of spapr_cpu_reset()
      Clear mem_path if we fall back to anonymous RAM allocation

Greg Kurz (2):
      spapr: drop useless sanity check in spapr_irq_alloc*()
      spapr: drop useless dynamic sysbus device sanity check

Igor Mammedov (1):
      ppc: e500: switch E500 based machines to full machine definition

Mark Cave-Ayland (22):
      uninorth: trivial style fixups
      uninorth: remove second set of uninorth token registers
      uninorth: QOMify PCI and AGP host bridges
      uninorth: remove stray PCIBus realize from mac_newworld.c
      uninorth: move uninorth definitions into uninorth.h
      uninorth: alter pci_pmac_init() and pci_pmac_u3_init() to return un=
inorth device
      heathrow: remove obsolete heathow_init() function
      grackle: general tidy-up and QOMify
      grackle: remove deprecated pci_grackle_init() function
      grackle: move PCI IO (ISA) memory region into the grackle device
      mac_oldworld: remove pics IRQ array and wire up macio to heathrow d=
irectly
      mac_oldworld: move wiring of macio IRQs to macio_oldworld_realize()
      uninorth: move PCI mmio memory region initialisation into init func=
tion
      uninorth: introduce temporary pic_irqs device property
      uninorth: move PCI host bridge bus initialisation into device reali=
ze
      uninorth: fix PCI and AGP bus mixup
      uninorth: enable internal PCI host bridge
      uninorth: remove obsolete pci_pmac_init() function
      uninorth: remove obsolete pci_pmac_u3_init() function
      uninorth: use object link to pass OpenPIC object to uninorth
      uninorth: move PCI IO (ISA) memory region into the uninorth device
      uninorth: rename UNINState to UNINHostState

Michael Matz (1):
      ppc: Fix size of ppc64 xer register

Serhii Popovych (2):
      Revert "spapr: Don't allow memory hotplug to memory less nodes"
      spapr: Add ibm,max-associativity-domains property

 backends/hostmem.c               |  18 ++
 docs/specs/ppc-spapr-hotplug.txt |  19 +++
 exec.c                           |  20 +--
 hw/intc/heathrow_pic.c           |  23 +--
 hw/misc/macio/macio.c            |  37 ++--
 hw/pci-host/grackle.c            | 103 +++++------
 hw/pci-host/uninorth.c           | 357 ++++++++++++++++++++-------------=
------
 hw/ppc/e500.c                    | 119 +++++++------
 hw/ppc/e500.h                    |  29 +++-
 hw/ppc/e500plat.c                |  64 ++++---
 hw/ppc/fdt.c                     |   7 +-
 hw/ppc/mac.h                     |  27 +--
 hw/ppc/mac_newworld.c            |  68 ++++++--
 hw/ppc/mac_oldworld.c            |  51 +++---
 hw/ppc/mpc8544ds.c               |  47 ++++--
 hw/ppc/pnv.c                     |   9 +-
 hw/ppc/spapr.c                   | 330 +++++++++++++++++++++++++--------=
---
 hw/ppc/spapr_cpu_core.c          |  11 +-
 include/hw/compat.h              |   2 +
 include/hw/intc/heathrow_pic.h   |   2 +-
 include/hw/misc/macio/macio.h    |   1 -
 include/hw/pci-host/uninorth.h   |  56 ++++++
 include/hw/ppc/fdt.h             |   2 +-
 include/hw/ppc/spapr_ovec.h      |   1 +
 include/sysemu/hostmem.h         |   2 +
 numa.c                           |   1 +
 target/ppc/cpu-qom.h             |  27 +--
 target/ppc/cpu.h                 |  30 +---
 target/ppc/gdbstub.c             |  14 +-
 target/ppc/kvm.c                 |  41 ++---
 target/ppc/machine.c             |  23 ++-
 target/ppc/mmu-hash64.c          | 152 ++++++++++++-----
 target/ppc/mmu-hash64.h          |  48 +++++-
 target/ppc/mmu_helper.c          |  24 +--
 target/ppc/translate.c           |  14 +-
 target/ppc/translate_init.c      | 137 ++++-----------
 util/mmap-alloc.c                |  26 +--
 37 files changed, 1132 insertions(+), 810 deletions(-)
 create mode 100644 include/hw/pci-host/uninorth.h
