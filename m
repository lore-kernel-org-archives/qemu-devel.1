Received: from eggs.gnu.org ([2001:4830:134:3::10]:45519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWJPn-0000aQ-Lo
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:35:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWJPm-0003Lf-A1
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:35:39 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 22 Jun 2018 20:35:03 +1000
Message-Id: <20180622103528.28598-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/25] ppc-for-3.0 queue 2018-06-22
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 46012db666990ff2eed1d3dc199ab8006439a9=
3b:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180619' into =
staging (2018-06-20 09:51:30 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-3.0-20180622

for you to fetch changes up to e5ca28ecab5c69b7578e22391a66c97c3979ffd8:

  spapr: Don't rewrite mmu capabilities in KVM mode (2018-06-22 14:19:07 =
+1000)

----------------------------------------------------------------
ppc patch queue 2018-06-22

Another assorted patch of patches for ppc and spapr.
    * Rework of guest pagesize handling for ppc, which avoids guest
      visibly different behaviour between accelerators
    * A number of Pnv cleanups, working towards more complete POWER9
      support
    * Migration of VPA data, a significant bugfix

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      pseries: Update SLOF firmware image to qemu-slof-20180621

BALATON Zoltan (3):
      ppc4xx_i2c: Remove unimplemented sdata and intr registers
      ppc4xx_i2c: Implement directcntl register
      target/ppc: Add missing opcode for icbt on PPC440

C=C3=A9dric Le Goater (6):
      ppc/pnv: introduce a new intc_create() operation to the chip model
      ppc/pnv: introduce a new isa_create() operation to the chip model
      ppc/pnv: introduce Pnv8Chip and Pnv9Chip models
      ppc/pnv: consolidate the creation of the ISA bus device tree
      spapr: split the IRQ allocation sequence
      spapr: remove unused spapr_irq routines

David Gibson (9):
      target/ppc: Allow cpu compatiblity checks based on type, not instan=
ce
      spapr: Compute effective capability values earlier
      spapr: Add cpu_apply hook to capabilities
      target/ppc: Add kvmppc_hpt_needs_host_contiguous_pages() helper
      spapr: Maximum (HPT) pagesize property
      spapr: Use maximum page size capability to simplify memory backend =
checking
      target/ppc: Add ppc_hash64_filter_pagesizes()
      spapr: Limit available pagesizes to provide a consistent guest envi=
ronment
      spapr: Don't rewrite mmu capabilities in KVM mode

Greg Kurz (2):
      spapr_cpu_core: migrate per-CPU data
      spapr_cpu_core: migrate VPA related state

John Arbuckle (1):
      fpu_helper.c: fix helper_fpscr_clrbit() function

Sebastian Bauer (1):
      sm501: Fix hardware cursor color conversion

 default-configs/ppc-softmmu.mak    |   1 +
 default-configs/ppcemb-softmmu.mak |   1 +
 hw/display/sm501.c                 |   6 +-
 hw/i2c/ppc4xx_i2c.c                |  30 ++-
 hw/ppc/pnv.c                       | 383 +++++++++++++++++++++++--------=
------
 hw/ppc/pnv_core.c                  |  18 +-
 hw/ppc/pnv_lpc.c                   |  30 ++-
 hw/ppc/spapr.c                     | 122 ++++++------
 hw/ppc/spapr_caps.c                | 158 +++++++++++++--
 hw/ppc/spapr_cpu_core.c            |  91 ++++++++-
 hw/ppc/spapr_events.c              |  18 +-
 hw/ppc/spapr_pci.c                 |  23 ++-
 hw/ppc/spapr_vio.c                 |  10 +-
 include/hw/i2c/ppc4xx_i2c.h        |   8 +-
 include/hw/ppc/pnv.h               |  26 ++-
 include/hw/ppc/pnv_lpc.h           |   3 +-
 include/hw/ppc/spapr.h             |  19 +-
 include/hw/ppc/spapr_cpu_core.h    |   1 +
 pc-bios/README                     |   2 +-
 pc-bios/slof.bin                   | Bin 913880 -> 924840 bytes
 roms/SLOF                          |   2 +-
 target/ppc/compat.c                |  27 ++-
 target/ppc/cpu.h                   |   4 +
 target/ppc/fpu_helper.c            |  28 +++
 target/ppc/kvm.c                   | 146 +++++++-------
 target/ppc/kvm_ppc.h               |  11 +-
 target/ppc/mmu-hash64.c            |  59 ++++++
 target/ppc/mmu-hash64.h            |   3 +
 target/ppc/translate.c             |   2 +
 29 files changed, 865 insertions(+), 367 deletions(-)
