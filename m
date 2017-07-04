Received: from eggs.gnu.org ([2001:4830:134:3::10]:41994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dSRDy-0001OP-DR
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 13:02:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dSRDx-0005Ts-5R
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 13:02:54 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dSRDw-0005KD-Sg
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 13:02:53 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  4 Jul 2017 18:02:40 +0100
Message-Id: <1499187763-8211-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/3] Add new utility function
 memory_region_allocate_aux_memory()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

Many board models and several devices need to create auxiliary
regions of RAM (in addition to the main lump of 'system' memory),
to model static RAMs, video memory, ROMs, etc. Currently they do
this with a sequence like:
       memory_region_init_ram(sram, NULL, "sram", 0x10000, &error_fatal);
       vmstate_register_ram_global(sram);

but the need for the second function call is not obvious and if
omitted the bug is subtle (possible migration failure). This series
wraps the two calls up into a single new function
memory_region_allocate_aux_memory(), named to parallel the existing
memory_region_allocate_system_memory().

Patch 1 documents memory_region_allocate_system_memory() which
has a couple of non-obvious wrinkles. Patch 2 implements the new
utility function. Patch 3 changes a lot of callsites to use it
with the aid of the included coccinelle patch. (I think most
of the remaining callsites of vmstate_register_ram_global() are
not changed just because they report the error up to their caller
rather than using error_fatal. I'm not sure what kind of error you
might get back that wasn't "out of memory", which we usually make
fatal anyway, so perhaps we could change those callsites too.)

thanks
-- PMM

Peter Maydell (3):
  include/hw/boards.h: Document memory_region_allocate_system_memory()
  memory.h: Add new utility function memory_region_allocate_aux_memory()
  hw: Use new memory_region_allocate_aux_memory() function

 include/exec/memory.h                     | 23 +++++++++++++++++++++++
 include/hw/boards.h                       | 29 +++++++++++++++++++++++++++++
 hw/arm/exynos4210.c                       | 10 ++++------
 hw/arm/exynos4_boards.c                   | 12 +++++-------
 hw/arm/integratorcp.c                     |  5 ++---
 hw/arm/mainstone.c                        |  5 ++---
 hw/arm/musicpal.c                         |  5 ++---
 hw/arm/omap1.c                            |  5 ++---
 hw/arm/omap2.c                            |  5 ++---
 hw/arm/omap_sx1.c                         | 10 ++++------
 hw/arm/palm.c                             |  4 +---
 hw/arm/pxa2xx.c                           | 20 ++++++++------------
 hw/arm/realview.c                         | 14 +++++---------
 hw/arm/spitz.c                            |  3 +--
 hw/arm/stellaris.c                        |  9 +++------
 hw/arm/stm32f205_soc.c                    | 10 +++-------
 hw/arm/tosa.c                             |  3 +--
 hw/arm/vexpress.c                         | 12 +++---------
 hw/arm/virt.c                             |  3 +--
 hw/arm/xilinx_zynq.c                      |  5 ++---
 hw/arm/xlnx-zynqmp.c                      |  5 ++---
 hw/block/onenand.c                        |  5 ++---
 hw/cris/axis_dev88.c                      |  5 ++---
 hw/display/cg3.c                          |  5 ++---
 hw/display/sm501.c                        |  5 ++---
 hw/display/tc6393xb.c                     |  5 ++---
 hw/display/tcx.c                          |  5 ++---
 hw/display/vmware_vga.c                   |  5 ++---
 hw/i386/pc.c                              |  5 ++---
 hw/i386/pc_sysfw.c                        |  8 +++-----
 hw/i386/xen/xen-hvm.c                     |  4 +---
 hw/input/milkymist-softusb.c              | 10 ++++------
 hw/m68k/an5206.c                          |  3 +--
 hw/m68k/mcf5208.c                         |  3 +--
 hw/microblaze/petalogix_ml605_mmu.c       | 11 +++++------
 hw/microblaze/petalogix_s3adsp1800_mmu.c  | 12 +++++-------
 hw/mips/mips_fulong2e.c                   |  4 +---
 hw/mips/mips_jazz.c                       | 10 ++++------
 hw/mips/mips_mipssim.c                    |  5 ++---
 hw/mips/mips_r4k.c                        |  5 ++---
 hw/moxie/moxiesim.c                       |  6 ++----
 hw/net/milkymist-minimac2.c               |  6 +++---
 hw/openrisc/openrisc_sim.c                |  3 +--
 hw/pci-host/prep.c                        |  5 +----
 hw/ppc/mac_newworld.c                     |  5 ++---
 hw/ppc/mac_oldworld.c                     |  5 ++---
 hw/ppc/ppc405_boards.c                    | 14 +++++---------
 hw/ppc/ppc405_uc.c                        |  5 ++---
 hw/s390x/sclp.c                           |  5 ++---
 hw/sh4/r2d.c                              |  3 +--
 hw/sh4/shix.c                             | 13 +++++--------
 hw/sparc/leon3.c                          |  3 +--
 hw/sparc/sun4m.c                          | 13 +++++--------
 hw/sparc64/sun4u.c                        | 10 ++++------
 hw/tricore/tricore_testboard.c            | 30 ++++++++++++------------------
 hw/unicore32/puv3.c                       |  4 +---
 hw/xtensa/sim.c                           |  6 ++----
 hw/xtensa/xtfpga.c                        | 14 +++++---------
 memory.c                                  |  8 ++++++++
 scripts/coccinelle/allocate_aux_mem.cocci | 14 ++++++++++++++
 60 files changed, 228 insertions(+), 256 deletions(-)
 create mode 100644 scripts/coccinelle/allocate_aux_mem.cocci

-- 
2.7.4
