Received: from eggs.gnu.org ([209.51.188.92]:38148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8O-0000OD-Ll
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:01:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8N-0007Cu-4M
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:01:44 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  4 Feb 2019 20:00:47 +1100
Message-Id: <20190204090124.26191-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/37] ppc-for-4.0 queue 20190204
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit b3fc0af1ff5e922d4dd7c875394dbd26dc7313=
b4:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into sta=
ging (2019-02-01 17:58:27 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-4.0-20190204

for you to fetch changes up to 53adb9d43e1abba187387a51f238e878e934c647:

  mmap-alloc: fix hugetlbfs misaligned length in ppc64 (2019-02-04 18:44:=
20 +1100)

----------------------------------------------------------------
ppc patch queue 2019-02-04

Here's the next batch of ppc target and spapr related changes.
Highlights are:
 * A number of endianness handling cleanups from Mark Cave-Ayland
 * Updated Mac VGA driver
 * Updated SLOF image
 * Some XIVE cleanups and small fixes
 * ppc4xx cleanups and fixes from BALATON Zoltan

There are a few chances not technically in the ppc target code:
 * Several MAINTAINERS updates
 * Fixes for unmapping of hugepages on power hosts

The latter is included because it's primarily of interest for ppc KVM set=
ups.

----------------------------------------------------------------
Alexey Kardashevskiy (3):
      pseries: Update SLOF firmware image
      spapr: Drop unused parameters from fdt building helper
      spapr_pci: Fix endianness in assigned-addresses property

BALATON Zoltan (7):
      smbus: Add a helper to generate SPD EEPROM data
      sam460ex: Clean up SPD EEPROM creation
      ppc4xx: Use ram_addr_t in ppc4xx_sdram_adjust()
      ppc4xx: Rename ppc4xx_sdram_t in ppc440_uc.c to ppc440_sdram_t
      ppc4xx: Pass array index to function instead of pointer into the ar=
ray
      sam460ex: Fix support for memory larger than 1GB
      ppc440: Avoid reporting error when reading non-existent RAM slot

C=C3=A9dric Le Goater (6):
      ppc/xive: fix remaining XiveFabric names
      spapr/vio: remove the "irq" property"
      xive: add a get_tctx() method to the XiveRouter
      ppc/pnv: introduce a CPU machine_data
      spapr: move the interrupt presenters under machine_data
      ppc: remove the interrupt presenters from under PowerPCCPU

David Hildenbrand (1):
      spapr/pci: Fix primary bus number for PCI bridges

Greg Kurz (2):
      target/ppc/kvm: Drop useless include directive
      spapr: Forbid setting ic-mode for old machine types

Mark Cave-Ayland (10):
      target/ppc: implement complete set of Vsr* macros
      MAINTAINERS: add myself as maintainer for Mac Old World and New Wor=
ld machines
      QemuMacDrivers: update qemu_vga.ndrv to 90c488d built from submodul=
e
      target/ppc: rework vmrg{l,h}{b,h,w} instructions to use Vsr* macros
      target/ppc: rework vmul{e,o}{s,u}{b,h,w} instructions to use Vsr* m=
acros
      target/ppc: eliminate use of HI_IDX and LO_IDX macros from int_help=
er.c
      target/ppc: eliminate use of EL_IDX macros from int_helper.c
      target/ppc: simplify VEXT_SIGNED macro in int_helper.c
      target/ppc: remove ROTRu32 and ROTRu64 macros from int_helper.c
      target/ppc: remove various HOST_WORDS_BIGENDIAN hacks in int_helper=
.c

Murilo Opsfelder Araujo (2):
      mmap-alloc: unfold qemu_ram_mmap()
      mmap-alloc: fix hugetlbfs misaligned length in ppc64

Thomas Huth (6):
      hw/ppc/spapr: Encode the SCSI channel (bus) in the SRP LUNs
      hw/ppc: Move ppc40x_*reset() functions from ppc405_uc.c to ppc.c
      MAINTAINERS: XIVE is an interrupt controller, not a machine
      MAINTAINERS: Merge the two e500 sections
      hw/ppc/spapr: Add support for "-vga cirrus"
      hw/ppc: Don't include m48t59.h if it is not necessary

 MAINTAINERS                     |  35 ++-
 exec.c                          |   4 +-
 hw/i2c/smbus_eeprom.c           | 129 ++++++++++
 hw/intc/spapr_xive.c            |   9 +
 hw/intc/xics_spapr.c            |  11 +-
 hw/intc/xive.c                  |  22 +-
 hw/ppc/Makefile.objs            |   3 +-
 hw/ppc/mac_newworld.c           |   1 -
 hw/ppc/mac_oldworld.c           |   1 -
 hw/ppc/pnv.c                    |   7 +-
 hw/ppc/pnv_core.c               |  12 +-
 hw/ppc/ppc.c                    |  58 ++++-
 hw/ppc/ppc405_uc.c              |  58 -----
 hw/ppc/ppc440_bamboo.c          |   2 +-
 hw/ppc/ppc440_uc.c              |  76 +++---
 hw/ppc/ppc4xx_devs.c            |  48 ++--
 hw/ppc/ppc_booke.c              |   1 -
 hw/ppc/sam460ex.c               | 181 ++------------
 hw/ppc/spapr.c                  |  23 +-
 hw/ppc/spapr_cpu_core.c         |   8 +-
 hw/ppc/spapr_irq.c              |  17 +-
 hw/ppc/spapr_pci.c              |   7 +-
 hw/ppc/spapr_vio.c              |  47 +---
 include/hw/i2c/smbus.h          |   3 +
 include/hw/ppc/pnv_core.h       |   9 +
 include/hw/ppc/ppc4xx.h         |   2 +-
 include/hw/ppc/spapr_cpu_core.h |   2 +
 include/hw/ppc/xive.h           |  59 ++---
 include/qemu/mmap-alloc.h       |   2 +-
 pc-bios/README                  |   2 +-
 pc-bios/qemu_vga.ndrv           | Bin 14752 -> 18752 bytes
 pc-bios/slof.bin                | Bin 974544 -> 926392 bytes
 qemu-deprecated.texi            |   6 -
 roms/QemuMacDrivers             |   2 +-
 roms/SLOF                       |   2 +-
 target/ppc/cpu.h                |   5 -
 target/ppc/int_helper.c         | 523 ++++++++++++++++------------------=
------
 target/ppc/internal.h           |   9 +-
 target/ppc/kvm.c                |   1 -
 util/mmap-alloc.c               |  73 ++++--
 util/oslib-posix.c              |   2 +-
 41 files changed, 684 insertions(+), 778 deletions(-)
