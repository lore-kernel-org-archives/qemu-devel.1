Received: from eggs.gnu.org ([2001:4830:134:3::10]:42045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dSRE3-0001RE-Fw
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 13:03:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dSRDy-0005W9-Hb
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 13:02:59 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dSRDx-0005KD-PE
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 13:02:54 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  4 Jul 2017 18:02:43 +0100
Message-Id: <1499187763-8211-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1499187763-8211-1-git-send-email-peter.maydell@linaro.org>
References: <1499187763-8211-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 3/3] hw: Use new
 memory_region_allocate_aux_memory() function
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

Use the new utility function memory_region_allocate_aux_memory()
instead of manually calling memory_region_init_ram() and then
vmstate_register_ram_global().

Patch automatically created using the included coccinelle script:
 spatch --in-place -sp_file scripts/coccinelle/allocate_aux_mem.cocci -dir hw

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
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
 scripts/coccinelle/allocate_aux_mem.cocci | 14 ++++++++++++++
 57 files changed, 168 insertions(+), 256 deletions(-)
 create mode 100644 scripts/coccinelle/allocate_aux_mem.cocci

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 0050626..92c57bb 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -276,9 +276,8 @@ Exynos4210State *exynos4210_init(MemoryRegion *system_mem)
                                 &s->chipid_mem);
 
     /* Internal ROM */
-    memory_region_init_ram(&s->irom_mem, NULL, "exynos4210.irom",
-                           EXYNOS4210_IROM_SIZE, &error_fatal);
-    vmstate_register_ram_global(&s->irom_mem);
+    memory_region_allocate_aux_memory(&s->irom_mem, NULL, "exynos4210.irom",
+                                      EXYNOS4210_IROM_SIZE);
     memory_region_set_readonly(&s->irom_mem, true);
     memory_region_add_subregion(system_mem, EXYNOS4210_IROM_BASE_ADDR,
                                 &s->irom_mem);
@@ -292,9 +291,8 @@ Exynos4210State *exynos4210_init(MemoryRegion *system_mem)
                                 &s->irom_alias_mem);
 
     /* Internal RAM */
-    memory_region_init_ram(&s->iram_mem, NULL, "exynos4210.iram",
-                           EXYNOS4210_IRAM_SIZE, &error_fatal);
-    vmstate_register_ram_global(&s->iram_mem);
+    memory_region_allocate_aux_memory(&s->iram_mem, NULL, "exynos4210.iram",
+                                      EXYNOS4210_IRAM_SIZE);
     memory_region_add_subregion(system_mem, EXYNOS4210_IRAM_BASE_ADDR,
                                 &s->iram_mem);
 
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 6240b26..dbe2395 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -110,18 +110,16 @@ static void exynos4_boards_init_ram(Exynos4BoardState *s,
     unsigned long mem_size = ram_size;
 
     if (mem_size > EXYNOS4210_DRAM_MAX_SIZE) {
-        memory_region_init_ram(&s->dram1_mem, NULL, "exynos4210.dram1",
-                               mem_size - EXYNOS4210_DRAM_MAX_SIZE,
-                               &error_fatal);
-        vmstate_register_ram_global(&s->dram1_mem);
+        memory_region_allocate_aux_memory(&s->dram1_mem, NULL,
+                                          "exynos4210.dram1",
+                                          mem_size - EXYNOS4210_DRAM_MAX_SIZE);
         memory_region_add_subregion(system_mem, EXYNOS4210_DRAM1_BASE_ADDR,
                                     &s->dram1_mem);
         mem_size = EXYNOS4210_DRAM_MAX_SIZE;
     }
 
-    memory_region_init_ram(&s->dram0_mem, NULL, "exynos4210.dram0", mem_size,
-                           &error_fatal);
-    vmstate_register_ram_global(&s->dram0_mem);
+    memory_region_allocate_aux_memory(&s->dram0_mem, NULL, "exynos4210.dram0",
+                                      mem_size);
     memory_region_add_subregion(system_mem, EXYNOS4210_DRAM0_BASE_ADDR,
                                 &s->dram0_mem);
 }
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index ca3eca1..492acc9 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -276,9 +276,8 @@ static void integratorcm_init(Object *obj)
     s->cm_init = 0x00000112;
     s->cm_refcnt_offset = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), 24,
                                    1000);
-    memory_region_init_ram(&s->flash, obj, "integrator.flash", 0x100000,
-                           &error_fatal);
-    vmstate_register_ram_global(&s->flash);
+    memory_region_allocate_aux_memory(&s->flash, obj, "integrator.flash",
+                                      0x100000);
 
     memory_region_init_io(&s->iomem, obj, &integratorcm_ops, s,
                           "integratorcm", 0x00800000);
diff --git a/hw/arm/mainstone.c b/hw/arm/mainstone.c
index f962236..b50bb6e 100644
--- a/hw/arm/mainstone.c
+++ b/hw/arm/mainstone.c
@@ -128,9 +128,8 @@ static void mainstone_common_init(MemoryRegion *address_space_mem,
 
     /* Setup CPU & memory */
     mpu = pxa270_init(address_space_mem, mainstone_binfo.ram_size, cpu_model);
-    memory_region_init_ram(rom, NULL, "mainstone.rom", MAINSTONE_ROM,
-                           &error_fatal);
-    vmstate_register_ram_global(rom);
+    memory_region_allocate_aux_memory(rom, NULL, "mainstone.rom",
+                                      MAINSTONE_ROM);
     memory_region_set_readonly(rom, true);
     memory_region_add_subregion(address_space_mem, 0, rom);
 
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 9c710f7..42ed8fb 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1604,9 +1604,8 @@ static void musicpal_init(MachineState *machine)
                                          MP_RAM_DEFAULT_SIZE);
     memory_region_add_subregion(address_space_mem, 0, ram);
 
-    memory_region_init_ram(sram, NULL, "musicpal.sram", MP_SRAM_SIZE,
-                           &error_fatal);
-    vmstate_register_ram_global(sram);
+    memory_region_allocate_aux_memory(sram, NULL, "musicpal.sram",
+                                      MP_SRAM_SIZE);
     memory_region_add_subregion(address_space_mem, MP_SRAM_BASE, sram);
 
     dev = sysbus_create_simple(TYPE_MV88W8618_PIC, MP_PIC_BASE,
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 54582bd..d4eea48 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -3880,9 +3880,8 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *system_memory,
     memory_region_allocate_system_memory(&s->emiff_ram, NULL, "omap1.dram",
                                          s->sdram_size);
     memory_region_add_subregion(system_memory, OMAP_EMIFF_BASE, &s->emiff_ram);
-    memory_region_init_ram(&s->imif_ram, NULL, "omap1.sram", s->sram_size,
-                           &error_fatal);
-    vmstate_register_ram_global(&s->imif_ram);
+    memory_region_allocate_aux_memory(&s->imif_ram, NULL, "omap1.sram",
+                                      s->sram_size);
     memory_region_add_subregion(system_memory, OMAP_IMIF_BASE, &s->imif_ram);
 
     omap_clkm_init(system_memory, 0xfffece00, 0xe1008000, s);
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index 91f5733..5ba09b5 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -2278,9 +2278,8 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sysmem,
     memory_region_allocate_system_memory(&s->sdram, NULL, "omap2.dram",
                                          s->sdram_size);
     memory_region_add_subregion(sysmem, OMAP2_Q2_BASE, &s->sdram);
-    memory_region_init_ram(&s->sram, NULL, "omap2.sram", s->sram_size,
-                           &error_fatal);
-    vmstate_register_ram_global(&s->sram);
+    memory_region_allocate_aux_memory(&s->sram, NULL, "omap2.sram",
+                                      s->sram_size);
     memory_region_add_subregion(sysmem, OMAP2_SRAM_BASE, &s->sram);
 
     s->l4 = omap_l4_init(sysmem, OMAP2_L4_BASE, 54);
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index 5d74026..8430701 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -123,9 +123,8 @@ static void sx1_init(MachineState *machine, const int version)
                            machine->cpu_model);
 
     /* External Flash (EMIFS) */
-    memory_region_init_ram(flash, NULL, "omap_sx1.flash0-0", flash_size,
-                           &error_fatal);
-    vmstate_register_ram_global(flash);
+    memory_region_allocate_aux_memory(flash, NULL, "omap_sx1.flash0-0",
+                                      flash_size);
     memory_region_set_readonly(flash, true);
     memory_region_add_subregion(address_space, OMAP_CS0_BASE, flash);
 
@@ -167,9 +166,8 @@ static void sx1_init(MachineState *machine, const int version)
     if ((version == 1) &&
             (dinfo = drive_get(IF_PFLASH, 0, fl_idx)) != NULL) {
         MemoryRegion *flash_1 = g_new(MemoryRegion, 1);
-        memory_region_init_ram(flash_1, NULL, "omap_sx1.flash1-0", flash1_size,
-                               &error_fatal);
-        vmstate_register_ram_global(flash_1);
+        memory_region_allocate_aux_memory(flash_1, NULL, "omap_sx1.flash1-0",
+                                          flash1_size);
         memory_region_set_readonly(flash_1, true);
         memory_region_add_subregion(address_space, OMAP_CS1_BASE, flash_1);
 
diff --git a/hw/arm/palm.c b/hw/arm/palm.c
index 7f46073..e114b24 100644
--- a/hw/arm/palm.c
+++ b/hw/arm/palm.c
@@ -214,9 +214,7 @@ static void palmte_init(MachineState *machine)
     mpu = omap310_mpu_init(address_space_mem, sdram_size, cpu_model);
 
     /* External Flash (EMIFS) */
-    memory_region_init_ram(flash, NULL, "palmte.flash", flash_size,
-                           &error_fatal);
-    vmstate_register_ram_global(flash);
+    memory_region_allocate_aux_memory(flash, NULL, "palmte.flash", flash_size);
     memory_region_set_readonly(flash, true);
     memory_region_add_subregion(address_space_mem, OMAP_CS0_BASE, flash);
 
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index 629e6c6..66a6d39 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -2073,13 +2073,11 @@ PXA2xxState *pxa270_init(MemoryRegion *address_space,
     s->reset = qemu_allocate_irq(pxa2xx_reset, s, 0);
 
     /* SDRAM & Internal Memory Storage */
-    memory_region_init_ram(&s->sdram, NULL, "pxa270.sdram", sdram_size,
-                           &error_fatal);
-    vmstate_register_ram_global(&s->sdram);
+    memory_region_allocate_aux_memory(&s->sdram, NULL, "pxa270.sdram",
+                                      sdram_size);
     memory_region_add_subregion(address_space, PXA2XX_SDRAM_BASE, &s->sdram);
-    memory_region_init_ram(&s->internal, NULL, "pxa270.internal", 0x40000,
-                           &error_fatal);
-    vmstate_register_ram_global(&s->internal);
+    memory_region_allocate_aux_memory(&s->internal, NULL, "pxa270.internal",
+                                      0x40000);
     memory_region_add_subregion(address_space, PXA2XX_INTERNAL_BASE,
                                 &s->internal);
 
@@ -2205,13 +2203,11 @@ PXA2xxState *pxa255_init(MemoryRegion *address_space, unsigned int sdram_size)
     s->reset = qemu_allocate_irq(pxa2xx_reset, s, 0);
 
     /* SDRAM & Internal Memory Storage */
-    memory_region_init_ram(&s->sdram, NULL, "pxa255.sdram", sdram_size,
-                           &error_fatal);
-    vmstate_register_ram_global(&s->sdram);
+    memory_region_allocate_aux_memory(&s->sdram, NULL, "pxa255.sdram",
+                                      sdram_size);
     memory_region_add_subregion(address_space, PXA2XX_SDRAM_BASE, &s->sdram);
-    memory_region_init_ram(&s->internal, NULL, "pxa255.internal",
-                           PXA2XX_INTERNAL_SIZE, &error_fatal);
-    vmstate_register_ram_global(&s->internal);
+    memory_region_allocate_aux_memory(&s->internal, NULL, "pxa255.internal",
+                                      PXA2XX_INTERNAL_SIZE);
     memory_region_add_subregion(address_space, PXA2XX_INTERNAL_BASE,
                                 &s->internal);
 
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index b7d4753..93011d3 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -143,15 +143,13 @@ static void realview_init(MachineState *machine,
         ram_lo = g_new(MemoryRegion, 1);
         low_ram_size = ram_size - 0x20000000;
         ram_size = 0x20000000;
-        memory_region_init_ram(ram_lo, NULL, "realview.lowmem", low_ram_size,
-                               &error_fatal);
-        vmstate_register_ram_global(ram_lo);
+        memory_region_allocate_aux_memory(ram_lo, NULL, "realview.lowmem",
+                                          low_ram_size);
         memory_region_add_subregion(sysmem, 0x20000000, ram_lo);
     }
 
-    memory_region_init_ram(ram_hi, NULL, "realview.highmem", ram_size,
-                           &error_fatal);
-    vmstate_register_ram_global(ram_hi);
+    memory_region_allocate_aux_memory(ram_hi, NULL, "realview.highmem",
+                                      ram_size);
     low_ram_size = ram_size;
     if (low_ram_size > 0x10000000)
       low_ram_size = 0x10000000;
@@ -345,9 +343,7 @@ static void realview_init(MachineState *machine,
        startup code.  I guess this works on real hardware because the
        BootROM happens to be in ROM/flash or in memory that isn't clobbered
        until after Linux boots the secondary CPUs.  */
-    memory_region_init_ram(ram_hack, NULL, "realview.hack", 0x1000,
-                           &error_fatal);
-    vmstate_register_ram_global(ram_hack);
+    memory_region_allocate_aux_memory(ram_hack, NULL, "realview.hack", 0x1000);
     memory_region_add_subregion(sysmem, SMP_BOOT_ADDR, ram_hack);
 
     realview_binfo.ram_size = ram_size;
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index 93bde14..f0f7a7e 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -919,8 +919,7 @@ static void spitz_common_init(MachineState *machine,
 
     sl_flash_register(mpu, (model == spitz) ? FLASH_128M : FLASH_1024M);
 
-    memory_region_init_ram(rom, NULL, "spitz.rom", SPITZ_ROM, &error_fatal);
-    vmstate_register_ram_global(rom);
+    memory_region_allocate_aux_memory(rom, NULL, "spitz.rom", SPITZ_ROM);
     memory_region_set_readonly(rom, true);
     memory_region_add_subregion(address_space_mem, 0, rom);
 
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index cf6e7be..69ae63e 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1288,15 +1288,12 @@ static void stellaris_init(const char *kernel_filename, const char *cpu_model,
     sram_size = ((board->dc0 >> 18) + 1) * 1024;
 
     /* Flash programming is done via the SCU, so pretend it is ROM.  */
-    memory_region_init_ram(flash, NULL, "stellaris.flash", flash_size,
-                           &error_fatal);
-    vmstate_register_ram_global(flash);
+    memory_region_allocate_aux_memory(flash, NULL, "stellaris.flash",
+                                      flash_size);
     memory_region_set_readonly(flash, true);
     memory_region_add_subregion(system_memory, 0, flash);
 
-    memory_region_init_ram(sram, NULL, "stellaris.sram", sram_size,
-                           &error_fatal);
-    vmstate_register_ram_global(sram);
+    memory_region_allocate_aux_memory(sram, NULL, "stellaris.sram", sram_size);
     memory_region_add_subregion(system_memory, 0x20000000, sram);
 
     nvic = armv7m_init(system_memory, flash_size, NUM_IRQ_LINES,
diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index 6e1260d..183e15b 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -95,22 +95,18 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     MemoryRegion *flash = g_new(MemoryRegion, 1);
     MemoryRegion *flash_alias = g_new(MemoryRegion, 1);
 
-    memory_region_init_ram(flash, NULL, "STM32F205.flash", FLASH_SIZE,
-                           &error_fatal);
+    memory_region_allocate_aux_memory(flash, NULL, "STM32F205.flash",
+                                      FLASH_SIZE);
     memory_region_init_alias(flash_alias, NULL, "STM32F205.flash.alias",
                              flash, 0, FLASH_SIZE);
 
-    vmstate_register_ram_global(flash);
-
     memory_region_set_readonly(flash, true);
     memory_region_set_readonly(flash_alias, true);
 
     memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, flash);
     memory_region_add_subregion(system_memory, 0, flash_alias);
 
-    memory_region_init_ram(sram, NULL, "STM32F205.sram", SRAM_SIZE,
-                           &error_fatal);
-    vmstate_register_ram_global(sram);
+    memory_region_allocate_aux_memory(sram, NULL, "STM32F205.sram", SRAM_SIZE);
     memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, sram);
 
     armv7m = DEVICE(&s->armv7m);
diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index 2421b81..392d431 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -234,8 +234,7 @@ static void tosa_init(MachineState *machine)
 
     mpu = pxa255_init(address_space_mem, tosa_binfo.ram_size);
 
-    memory_region_init_ram(rom, NULL, "tosa.rom", TOSA_ROM, &error_fatal);
-    vmstate_register_ram_global(rom);
+    memory_region_allocate_aux_memory(rom, NULL, "tosa.rom", TOSA_ROM);
     memory_region_set_readonly(rom, true);
     memory_region_add_subregion(address_space_mem, 0, rom);
 
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index c6b1e67..7c3f930 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -390,9 +390,7 @@ static void a15_daughterboard_init(const VexpressMachineState *vms,
     /* 0x2b060000: SP805 watchdog: not modelled */
     /* 0x2b0a0000: PL341 dynamic memory controller: not modelled */
     /* 0x2e000000: system SRAM */
-    memory_region_init_ram(sram, NULL, "vexpress.a15sram", 0x10000,
-                           &error_fatal);
-    vmstate_register_ram_global(sram);
+    memory_region_allocate_aux_memory(sram, NULL, "vexpress.a15sram", 0x10000);
     memory_region_add_subregion(sysmem, 0x2e000000, sram);
 
     /* 0x7ffb0000: DMA330 DMA controller: not modelled */
@@ -673,15 +671,11 @@ static void vexpress_common_init(MachineState *machine)
     }
 
     sram_size = 0x2000000;
-    memory_region_init_ram(sram, NULL, "vexpress.sram", sram_size,
-                           &error_fatal);
-    vmstate_register_ram_global(sram);
+    memory_region_allocate_aux_memory(sram, NULL, "vexpress.sram", sram_size);
     memory_region_add_subregion(sysmem, map[VE_SRAM], sram);
 
     vram_size = 0x800000;
-    memory_region_init_ram(vram, NULL, "vexpress.vram", vram_size,
-                           &error_fatal);
-    vmstate_register_ram_global(vram);
+    memory_region_allocate_aux_memory(vram, NULL, "vexpress.vram", vram_size);
     memory_region_add_subregion(sysmem, map[VE_VIDEORAM], vram);
 
     /* 0x4e000000 LAN9118 Ethernet */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 010f724..be8c24b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1155,8 +1155,7 @@ static void create_secure_ram(VirtMachineState *vms,
     hwaddr base = vms->memmap[VIRT_SECURE_MEM].base;
     hwaddr size = vms->memmap[VIRT_SECURE_MEM].size;
 
-    memory_region_init_ram(secram, NULL, "virt.secure-ram", size, &error_fatal);
-    vmstate_register_ram_global(secram);
+    memory_region_allocate_aux_memory(secram, NULL, "virt.secure-ram", size);
     memory_region_add_subregion(secure_sysmem, base, secram);
 
     nodename = g_strdup_printf("/secram@%" PRIx64, base);
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 3985356..2ae3882 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -204,9 +204,8 @@ static void zynq_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, 0, ext_ram);
 
     /* 256K of on-chip memory */
-    memory_region_init_ram(ocm_ram, NULL, "zynq.ocm_ram", 256 << 10,
-                           &error_fatal);
-    vmstate_register_ram_global(ocm_ram);
+    memory_region_allocate_aux_memory(ocm_ram, NULL, "zynq.ocm_ram",
+                                      256 << 10);
     memory_region_add_subregion(address_space_mem, 0xFFFC0000, ocm_ram);
 
     DriveInfo *dinfo = drive_get(IF_PFLASH, 0, 0);
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 64f52f8..af0654a 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -226,9 +226,8 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < XLNX_ZYNQMP_NUM_OCM_BANKS; i++) {
         char *ocm_name = g_strdup_printf("zynqmp.ocm_ram_bank_%d", i);
 
-        memory_region_init_ram(&s->ocm_ram[i], NULL, ocm_name,
-                               XLNX_ZYNQMP_OCM_RAM_SIZE, &error_fatal);
-        vmstate_register_ram_global(&s->ocm_ram[i]);
+        memory_region_allocate_aux_memory(&s->ocm_ram[i], NULL, ocm_name,
+                                          XLNX_ZYNQMP_OCM_RAM_SIZE);
         memory_region_add_subregion(get_system_memory(),
                                     XLNX_ZYNQMP_OCM_RAM_0_ADDRESS +
                                         i * XLNX_ZYNQMP_OCM_RAM_SIZE,
diff --git a/hw/block/onenand.c b/hw/block/onenand.c
index ddf5492..ed4a2af 100644
--- a/hw/block/onenand.c
+++ b/hw/block/onenand.c
@@ -807,9 +807,8 @@ static int onenand_initfn(SysBusDevice *sbd)
     }
     s->otp = memset(g_malloc((64 + 2) << PAGE_SHIFT),
                     0xff, (64 + 2) << PAGE_SHIFT);
-    memory_region_init_ram(&s->ram, OBJECT(s), "onenand.ram",
-                           0xc000 << s->shift, &error_fatal);
-    vmstate_register_ram_global(&s->ram);
+    memory_region_allocate_aux_memory(&s->ram, OBJECT(s), "onenand.ram",
+                                      0xc000 << s->shift);
     ram = memory_region_get_ram_ptr(&s->ram);
     s->boot[0] = ram + (0x0000 << s->shift);
     s->boot[1] = ram + (0x8000 << s->shift);
diff --git a/hw/cris/axis_dev88.c b/hw/cris/axis_dev88.c
index 60df887..498d8c7 100644
--- a/hw/cris/axis_dev88.c
+++ b/hw/cris/axis_dev88.c
@@ -281,9 +281,8 @@ void axisdev88_init(MachineState *machine)
 
     /* The ETRAX-FS has 128Kb on chip ram, the docs refer to it as the 
        internal memory.  */
-    memory_region_init_ram(phys_intmem, NULL, "axisdev88.chipram", INTMEM_SIZE,
-                           &error_fatal);
-    vmstate_register_ram_global(phys_intmem);
+    memory_region_allocate_aux_memory(phys_intmem, NULL, "axisdev88.chipram",
+                                      INTMEM_SIZE);
     memory_region_add_subregion(address_space_mem, 0x38000000, phys_intmem);
 
       /* Attach a NAND flash to CS1.  */
diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index 1de15a1..dc1d3b7 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -311,10 +311,9 @@ static void cg3_realizefn(DeviceState *dev, Error **errp)
         }
     }
 
-    memory_region_init_ram(&s->vram_mem, NULL, "cg3.vram", s->vram_size,
-                           &error_fatal);
+    memory_region_allocate_aux_memory(&s->vram_mem, NULL, "cg3.vram",
+                                      s->vram_size);
     memory_region_set_log(&s->vram_mem, true, DIRTY_MEMORY_VGA);
-    vmstate_register_ram_global(&s->vram_mem);
     sysbus_init_mmio(sbd, &s->vram_mem);
 
     sysbus_init_irq(sbd, &s->irq);
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 9d254ef..6fae318 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1578,9 +1578,8 @@ static void sm501_init(SM501State *s, DeviceState *dev,
                   s->local_mem_size_index);
 
     /* local memory */
-    memory_region_init_ram(&s->local_mem_region, OBJECT(dev), "sm501.local",
-                           get_local_mem_size(s), &error_fatal);
-    vmstate_register_ram_global(&s->local_mem_region);
+    memory_region_allocate_aux_memory(&s->local_mem_region, OBJECT(dev),
+                                      "sm501.local", get_local_mem_size(s));
     memory_region_set_log(&s->local_mem_region, true, DIRTY_MEMORY_VGA);
     s->local_mem = memory_region_get_ram_ptr(&s->local_mem_region);
 
diff --git a/hw/display/tc6393xb.c b/hw/display/tc6393xb.c
index 92f7120..966ee6b 100644
--- a/hw/display/tc6393xb.c
+++ b/hw/display/tc6393xb.c
@@ -586,9 +586,8 @@ TC6393xbState *tc6393xb_init(MemoryRegion *sysmem, uint32_t base, qemu_irq irq)
     memory_region_init_io(&s->iomem, NULL, &tc6393xb_ops, s, "tc6393xb", 0x10000);
     memory_region_add_subregion(sysmem, base, &s->iomem);
 
-    memory_region_init_ram(&s->vram, NULL, "tc6393xb.vram", 0x100000,
-                           &error_fatal);
-    vmstate_register_ram_global(&s->vram);
+    memory_region_allocate_aux_memory(&s->vram, NULL, "tc6393xb.vram",
+                                      0x100000);
     s->vram_ptr = memory_region_get_ram_ptr(&s->vram);
     memory_region_add_subregion(sysmem, base + 0x100000, &s->vram);
     s->scr_width = 480;
diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 6593c1d..d5f6ce1 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -812,9 +812,8 @@ static void tcx_realizefn(DeviceState *dev, Error **errp)
     uint8_t *vram_base;
     char *fcode_filename;
 
-    memory_region_init_ram(&s->vram_mem, OBJECT(s), "tcx.vram",
-                           s->vram_size * (1 + 4 + 4), &error_fatal);
-    vmstate_register_ram_global(&s->vram_mem);
+    memory_region_allocate_aux_memory(&s->vram_mem, OBJECT(s), "tcx.vram",
+                                      s->vram_size * (1 + 4 + 4));
     memory_region_set_log(&s->vram_mem, true, DIRTY_MEMORY_VGA);
     vram_base = memory_region_get_ram_ptr(&s->vram_mem);
 
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index c989cef..298a0f8 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1239,9 +1239,8 @@ static void vmsvga_init(DeviceState *dev, struct vmsvga_state_s *s,
     s->vga.con = graphic_console_init(dev, 0, &vmsvga_ops, s);
 
     s->fifo_size = SVGA_FIFO_SIZE;
-    memory_region_init_ram(&s->fifo_ram, NULL, "vmsvga.fifo", s->fifo_size,
-                           &error_fatal);
-    vmstate_register_ram_global(&s->fifo_ram);
+    memory_region_allocate_aux_memory(&s->fifo_ram, NULL, "vmsvga.fifo",
+                                      s->fifo_size);
     s->fifo_ptr = memory_region_get_ram_ptr(&s->fifo_ram);
 
     vga_common_init(&s->vga, OBJECT(dev), true);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 224fe58..2cc6686 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1442,9 +1442,8 @@ void pc_memory_init(PCMachineState *pcms,
     pc_system_firmware_init(rom_memory, !pcmc->pci_enabled);
 
     option_rom_mr = g_malloc(sizeof(*option_rom_mr));
-    memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
-                           &error_fatal);
-    vmstate_register_ram_global(option_rom_mr);
+    memory_region_allocate_aux_memory(option_rom_mr, NULL, "pc.rom",
+                                      PC_ROM_SIZE);
     memory_region_add_subregion_overlap(rom_memory,
                                         PC_ROM_MIN_VGA,
                                         option_rom_mr,
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index f915ad0..6a47df2 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -57,9 +57,8 @@ static void pc_isa_bios_init(MemoryRegion *rom_memory,
     /* map the last 128KB of the BIOS in ISA space */
     isa_bios_size = MIN(flash_size, 128 * 1024);
     isa_bios = g_malloc(sizeof(*isa_bios));
-    memory_region_init_ram(isa_bios, NULL, "isa-bios", isa_bios_size,
-                           &error_fatal);
-    vmstate_register_ram_global(isa_bios);
+    memory_region_allocate_aux_memory(isa_bios, NULL, "isa-bios",
+                                      isa_bios_size);
     memory_region_add_subregion_overlap(rom_memory,
                                         0x100000 - isa_bios_size,
                                         isa_bios,
@@ -195,8 +194,7 @@ static void old_pc_system_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw)
         goto bios_error;
     }
     bios = g_malloc(sizeof(*bios));
-    memory_region_init_ram(bios, NULL, "pc.bios", bios_size, &error_fatal);
-    vmstate_register_ram_global(bios);
+    memory_region_allocate_aux_memory(bios, NULL, "pc.bios", bios_size);
     if (!isapc_ram_fw) {
         memory_region_set_readonly(bios, true);
     }
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index cffa7e2..8355d01 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -212,10 +212,8 @@ static void xen_ram_init(PCMachineState *pcms,
          */
         block_len = (1ULL << 32) + pcms->above_4g_mem_size;
     }
-    memory_region_init_ram(&ram_memory, NULL, "xen.ram", block_len,
-                           &error_fatal);
+    memory_region_allocate_aux_memory(&ram_memory, NULL, "xen.ram", block_len);
     *ram_memory_p = &ram_memory;
-    vmstate_register_ram_global(&ram_memory);
 
     memory_region_init_alias(&ram_640k, NULL, "xen.ram.640k",
                              &ram_memory, 0, 0xa0000);
diff --git a/hw/input/milkymist-softusb.c b/hw/input/milkymist-softusb.c
index 40dfca1..f84bb51 100644
--- a/hw/input/milkymist-softusb.c
+++ b/hw/input/milkymist-softusb.c
@@ -256,14 +256,12 @@ static int milkymist_softusb_init(SysBusDevice *dev)
     sysbus_init_mmio(dev, &s->regs_region);
 
     /* register pmem and dmem */
-    memory_region_init_ram(&s->pmem, OBJECT(s), "milkymist-softusb.pmem",
-                           s->pmem_size, &error_fatal);
-    vmstate_register_ram_global(&s->pmem);
+    memory_region_allocate_aux_memory(&s->pmem, OBJECT(s),
+                                      "milkymist-softusb.pmem", s->pmem_size);
     s->pmem_ptr = memory_region_get_ram_ptr(&s->pmem);
     sysbus_init_mmio(dev, &s->pmem);
-    memory_region_init_ram(&s->dmem, OBJECT(s), "milkymist-softusb.dmem",
-                           s->dmem_size, &error_fatal);
-    vmstate_register_ram_global(&s->dmem);
+    memory_region_allocate_aux_memory(&s->dmem, OBJECT(s),
+                                      "milkymist-softusb.dmem", s->dmem_size);
     s->dmem_ptr = memory_region_get_ram_ptr(&s->dmem);
     sysbus_init_mmio(dev, &s->dmem);
 
diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index 142bab9..db19119 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -60,8 +60,7 @@ static void an5206_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, 0, ram);
 
     /* Internal SRAM.  */
-    memory_region_init_ram(sram, NULL, "an5206.sram", 512, &error_fatal);
-    vmstate_register_ram_global(sram);
+    memory_region_allocate_aux_memory(sram, NULL, "an5206.sram", 512);
     memory_region_add_subregion(address_space_mem, AN5206_RAMBAR_ADDR, sram);
 
     mcf5206_init(address_space_mem, AN5206_MBAR_ADDR, cpu);
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 6563518..b06d8a4 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -248,8 +248,7 @@ static void mcf5208evb_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, 0x40000000, ram);
 
     /* Internal SRAM.  */
-    memory_region_init_ram(sram, NULL, "mcf5208.sram", 16384, &error_fatal);
-    vmstate_register_ram_global(sram);
+    memory_region_allocate_aux_memory(sram, NULL, "mcf5208.sram", 16384);
     memory_region_add_subregion(address_space_mem, 0x80000000, sram);
 
     /* Internal peripherals.  */
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index 4968bdb..4bd68e4 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -96,14 +96,13 @@ petalogix_ml605_init(MachineState *machine)
     object_property_set_bool(OBJECT(cpu), true, "realized", &error_abort);
 
     /* Attach emulated BRAM through the LMB.  */
-    memory_region_init_ram(phys_lmb_bram, NULL, "petalogix_ml605.lmb_bram",
-                           LMB_BRAM_SIZE, &error_fatal);
-    vmstate_register_ram_global(phys_lmb_bram);
+    memory_region_allocate_aux_memory(phys_lmb_bram, NULL,
+                                      "petalogix_ml605.lmb_bram",
+                                      LMB_BRAM_SIZE);
     memory_region_add_subregion(address_space_mem, 0x00000000, phys_lmb_bram);
 
-    memory_region_init_ram(phys_ram, NULL, "petalogix_ml605.ram", ram_size,
-                           &error_fatal);
-    vmstate_register_ram_global(phys_ram);
+    memory_region_allocate_aux_memory(phys_ram, NULL, "petalogix_ml605.ram",
+                                      ram_size);
     memory_region_add_subregion(address_space_mem, MEMORY_BASEADDR, phys_ram);
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 423bcd7..cf218bf 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -75,15 +75,13 @@ petalogix_s3adsp1800_init(MachineState *machine)
     object_property_set_bool(OBJECT(cpu), true, "realized", &error_abort);
 
     /* Attach emulated BRAM through the LMB.  */
-    memory_region_init_ram(phys_lmb_bram, NULL,
-                           "petalogix_s3adsp1800.lmb_bram", LMB_BRAM_SIZE,
-                           &error_fatal);
-    vmstate_register_ram_global(phys_lmb_bram);
+    memory_region_allocate_aux_memory(phys_lmb_bram, NULL,
+                                      "petalogix_s3adsp1800.lmb_bram",
+                                      LMB_BRAM_SIZE);
     memory_region_add_subregion(sysmem, 0x00000000, phys_lmb_bram);
 
-    memory_region_init_ram(phys_ram, NULL, "petalogix_s3adsp1800.ram",
-                           ram_size, &error_fatal);
-    vmstate_register_ram_global(phys_ram);
+    memory_region_allocate_aux_memory(phys_ram, NULL,
+                                      "petalogix_s3adsp1800.ram", ram_size);
     memory_region_add_subregion(sysmem, ddr_base, phys_ram);
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index dbe2805..3211301 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -294,9 +294,7 @@ static void mips_fulong2e_init(MachineState *machine)
 
     /* allocate RAM */
     memory_region_allocate_system_memory(ram, NULL, "fulong2e.ram", ram_size);
-    memory_region_init_ram(bios, NULL, "fulong2e.bios", bios_size,
-                           &error_fatal);
-    vmstate_register_ram_global(bios);
+    memory_region_allocate_aux_memory(bios, NULL, "fulong2e.bios", bios_size);
     memory_region_set_readonly(bios, true);
 
     memory_region_add_subregion(address_space_mem, 0, ram);
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index 1cef581..a692172 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -175,9 +175,8 @@ static void mips_jazz_init(MachineState *machine,
                                          machine->ram_size);
     memory_region_add_subregion(address_space, 0, ram);
 
-    memory_region_init_ram(bios, NULL, "mips_jazz.bios", MAGNUM_BIOS_SIZE,
-                           &error_fatal);
-    vmstate_register_ram_global(bios);
+    memory_region_allocate_aux_memory(bios, NULL, "mips_jazz.bios",
+                                      MAGNUM_BIOS_SIZE);
     memory_region_set_readonly(bios, true);
     memory_region_init_alias(bios2, NULL, "mips_jazz.bios", bios,
                              0, MAGNUM_BIOS_SIZE);
@@ -242,9 +241,8 @@ static void mips_jazz_init(MachineState *machine,
         {
             /* Simple ROM, so user doesn't have to provide one */
             MemoryRegion *rom_mr = g_new(MemoryRegion, 1);
-            memory_region_init_ram(rom_mr, NULL, "g364fb.rom", 0x80000,
-                                   &error_fatal);
-            vmstate_register_ram_global(rom_mr);
+            memory_region_allocate_aux_memory(rom_mr, NULL, "g364fb.rom",
+                                              0x80000);
             memory_region_set_readonly(rom_mr, true);
             uint8_t *rom = memory_region_get_ram_ptr(rom_mr);
             memory_region_add_subregion(address_space, 0x60000000, rom_mr);
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
index 1b91195..1a891c2 100644
--- a/hw/mips/mips_mipssim.c
+++ b/hw/mips/mips_mipssim.c
@@ -177,9 +177,8 @@ mips_mipssim_init(MachineState *machine)
     /* Allocate RAM. */
     memory_region_allocate_system_memory(ram, NULL, "mips_mipssim.ram",
                                          ram_size);
-    memory_region_init_ram(bios, NULL, "mips_mipssim.bios", BIOS_SIZE,
-                           &error_fatal);
-    vmstate_register_ram_global(bios);
+    memory_region_allocate_aux_memory(bios, NULL, "mips_mipssim.bios",
+                                      BIOS_SIZE);
     memory_region_set_readonly(bios, true);
 
     memory_region_add_subregion(address_space_mem, 0, ram);
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index f4de9fc..910a613 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -236,9 +236,8 @@ void mips_r4k_init(MachineState *machine)
 #endif
     if ((bios_size > 0) && (bios_size <= BIOS_SIZE)) {
         bios = g_new(MemoryRegion, 1);
-        memory_region_init_ram(bios, NULL, "mips_r4k.bios", BIOS_SIZE,
-                               &error_fatal);
-        vmstate_register_ram_global(bios);
+        memory_region_allocate_aux_memory(bios, NULL, "mips_r4k.bios",
+                                          BIOS_SIZE);
         memory_region_set_readonly(bios, true);
         memory_region_add_subregion(get_system_memory(), 0x1fc00000, bios);
 
diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
index 3069834..ab074ea 100644
--- a/hw/moxie/moxiesim.c
+++ b/hw/moxie/moxiesim.c
@@ -128,12 +128,10 @@ static void moxiesim_init(MachineState *machine)
     qemu_register_reset(main_cpu_reset, cpu);
 
     /* Allocate RAM. */
-    memory_region_init_ram(ram, NULL, "moxiesim.ram", ram_size, &error_fatal);
-    vmstate_register_ram_global(ram);
+    memory_region_allocate_aux_memory(ram, NULL, "moxiesim.ram", ram_size);
     memory_region_add_subregion(address_space_mem, ram_base, ram);
 
-    memory_region_init_ram(rom, NULL, "moxie.rom", 128*0x1000, &error_fatal);
-    vmstate_register_ram_global(rom);
+    memory_region_allocate_aux_memory(rom, NULL, "moxie.rom", 128 * 0x1000);
     memory_region_add_subregion(get_system_memory(), 0x1000, rom);
 
     if (kernel_filename) {
diff --git a/hw/net/milkymist-minimac2.c b/hw/net/milkymist-minimac2.c
index c3a12e1..c799d96 100644
--- a/hw/net/milkymist-minimac2.c
+++ b/hw/net/milkymist-minimac2.c
@@ -466,9 +466,9 @@ static int milkymist_minimac2_init(SysBusDevice *sbd)
     sysbus_init_mmio(sbd, &s->regs_region);
 
     /* register buffers memory */
-    memory_region_init_ram(&s->buffers, OBJECT(dev), "milkymist-minimac2.buffers",
-                           buffers_size, &error_fatal);
-    vmstate_register_ram_global(&s->buffers);
+    memory_region_allocate_aux_memory(&s->buffers, OBJECT(dev),
+                                      "milkymist-minimac2.buffers",
+                                      buffers_size);
     s->rx0_buf = memory_region_get_ram_ptr(&s->buffers);
     s->rx1_buf = s->rx0_buf + MINIMAC2_BUFFER_SIZE;
     s->tx_buf = s->rx1_buf + MINIMAC2_BUFFER_SIZE;
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index fc0d096..a2fb536 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -119,8 +119,7 @@ static void openrisc_sim_init(MachineState *machine)
     }
 
     ram = g_malloc(sizeof(*ram));
-    memory_region_init_ram(ram, NULL, "openrisc.ram", ram_size, &error_fatal);
-    vmstate_register_ram_global(ram);
+    memory_region_allocate_aux_memory(ram, NULL, "openrisc.ram", ram_size);
     memory_region_add_subregion(get_system_memory(), 0, ram);
 
     cpu_openrisc_pic_init(cpu);
diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index 900a6ed..4bff52a 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -304,8 +304,7 @@ static void raven_realize(PCIDevice *d, Error **errp)
     d->config[0x0D] = 0x10; // latency_timer
     d->config[0x34] = 0x00; // capabilities_pointer
 
-    memory_region_init_ram(&s->bios, OBJECT(s), "bios", BIOS_SIZE,
-                           &error_fatal);
+    memory_region_allocate_aux_memory(&s->bios, OBJECT(s), "bios", BIOS_SIZE);
     memory_region_set_readonly(&s->bios, true);
     memory_region_add_subregion(get_system_memory(), (uint32_t)(-BIOS_SIZE),
                                 &s->bios);
@@ -334,8 +333,6 @@ static void raven_realize(PCIDevice *d, Error **errp)
             return;
         }
     }
-
-    vmstate_register_ram_global(&s->bios);
 }
 
 static const VMStateDescription vmstate_raven = {
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index bae1c0a..8d2e585 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -204,9 +204,8 @@ static void ppc_core99_init(MachineState *machine)
     memory_region_add_subregion(get_system_memory(), 0, ram);
 
     /* allocate and load BIOS */
-    memory_region_init_ram(bios, NULL, "ppc_core99.bios", BIOS_SIZE,
-                           &error_fatal);
-    vmstate_register_ram_global(bios);
+    memory_region_allocate_aux_memory(bios, NULL, "ppc_core99.bios",
+                                      BIOS_SIZE);
 
     if (bios_name == NULL)
         bios_name = PROM_FILENAME;
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 97bb854..6fd7c4a 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -141,9 +141,8 @@ static void ppc_heathrow_init(MachineState *machine)
     memory_region_add_subregion(sysmem, 0, ram);
 
     /* allocate and load BIOS */
-    memory_region_init_ram(bios, NULL, "ppc_heathrow.bios", BIOS_SIZE,
-                           &error_fatal);
-    vmstate_register_ram_global(bios);
+    memory_region_allocate_aux_memory(bios, NULL, "ppc_heathrow.bios",
+                                      BIOS_SIZE);
 
     if (bios_name == NULL)
         bios_name = PROM_FILENAME;
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index d01798f..ea3bada 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -218,9 +218,7 @@ static void ref405ep_init(MachineState *machine)
                         33333333, &pic, kernel_filename == NULL ? 0 : 1);
     /* allocate SRAM */
     sram_size = 512 * 1024;
-    memory_region_init_ram(sram, NULL, "ef405ep.sram", sram_size,
-                           &error_fatal);
-    vmstate_register_ram_global(sram);
+    memory_region_allocate_aux_memory(sram, NULL, "ef405ep.sram", sram_size);
     memory_region_add_subregion(sysmem, 0xFFF00000, sram);
     /* allocate and load BIOS */
 #ifdef DEBUG_BOARD_INIT
@@ -253,9 +251,8 @@ static void ref405ep_init(MachineState *machine)
         printf("Load BIOS from file\n");
 #endif
         bios = g_new(MemoryRegion, 1);
-        memory_region_init_ram(bios, NULL, "ef405ep.bios", BIOS_SIZE,
-                               &error_fatal);
-        vmstate_register_ram_global(bios);
+        memory_region_allocate_aux_memory(bios, NULL, "ef405ep.bios",
+                                          BIOS_SIZE);
 
         if (bios_name == NULL)
             bios_name = BIOS_FILENAME;
@@ -554,9 +551,8 @@ static void taihu_405ep_init(MachineState *machine)
         if (bios_name == NULL)
             bios_name = BIOS_FILENAME;
         bios = g_new(MemoryRegion, 1);
-        memory_region_init_ram(bios, NULL, "taihu_405ep.bios", BIOS_SIZE,
-                               &error_fatal);
-        vmstate_register_ram_global(bios);
+        memory_region_allocate_aux_memory(bios, NULL, "taihu_405ep.bios",
+                                          BIOS_SIZE);
         filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
         if (filename) {
             bios_size = load_image(filename, memory_region_get_ram_ptr(bios));
diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index fc32e96..3ca4f1b 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -978,9 +978,8 @@ static void ppc405_ocm_init(CPUPPCState *env)
 
     ocm = g_malloc0(sizeof(ppc405_ocm_t));
     /* XXX: Size is 4096 or 0x04000000 */
-    memory_region_init_ram(&ocm->isarc_ram, NULL, "ppc405.ocm", 4096,
-                           &error_fatal);
-    vmstate_register_ram_global(&ocm->isarc_ram);
+    memory_region_allocate_aux_memory(&ocm->isarc_ram, NULL, "ppc405.ocm",
+                                      4096);
     memory_region_init_alias(&ocm->dsarc_ram, NULL, "ppc405.dsarc", &ocm->isarc_ram,
                              0, 4096);
     qemu_register_reset(&ocm_reset, ocm);
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 83d6023..9896d42 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -266,14 +266,13 @@ static void assign_storage(SCLPDevice *sclp, SCCB *sccb)
                 this_subregion_size = mhd->standby_subregion_size;
             }
 
-            memory_region_init_ram(standby_ram, NULL, id, this_subregion_size,
-                                   &error_fatal);
+            memory_region_allocate_aux_memory(standby_ram, NULL, id,
+                                              this_subregion_size);
             /* This is a hack to make memory hotunplug work again. Once we have
              * subdevices, we have to unparent them when unassigning memory,
              * instead of doing it via the ref count of the MemoryRegion. */
             object_ref(OBJECT(standby_ram));
             object_unparent(OBJECT(standby_ram));
-            vmstate_register_ram_global(standby_ram);
             memory_region_add_subregion(sysmem, offset, standby_ram);
         }
         /* The specified subregion is no longer in standby */
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index e6fc74e..1c33a29 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -259,8 +259,7 @@ static void r2d_init(MachineState *machine)
     qemu_register_reset(main_cpu_reset, reset_info);
 
     /* Allocate memory space */
-    memory_region_init_ram(sdram, NULL, "r2d.sdram", SDRAM_SIZE, &error_fatal);
-    vmstate_register_ram_global(sdram);
+    memory_region_allocate_aux_memory(sdram, NULL, "r2d.sdram", SDRAM_SIZE);
     memory_region_add_subregion(address_space_mem, SDRAM_BASE, sdram);
     /* Register peripherals */
     s = sh7750_init(cpu, address_space_mem);
diff --git a/hw/sh4/shix.c b/hw/sh4/shix.c
index fd00cc5..59a32b5 100644
--- a/hw/sh4/shix.c
+++ b/hw/sh4/shix.c
@@ -63,17 +63,14 @@ static void shix_init(MachineState *machine)
     }
 
     /* Allocate memory space */
-    memory_region_init_ram(rom, NULL, "shix.rom", 0x4000, &error_fatal);
-    vmstate_register_ram_global(rom);
+    memory_region_allocate_aux_memory(rom, NULL, "shix.rom", 0x4000);
     memory_region_set_readonly(rom, true);
     memory_region_add_subregion(sysmem, 0x00000000, rom);
-    memory_region_init_ram(&sdram[0], NULL, "shix.sdram1", 0x01000000,
-                           &error_fatal);
-    vmstate_register_ram_global(&sdram[0]);
+    memory_region_allocate_aux_memory(&sdram[0], NULL, "shix.sdram1",
+                                      0x01000000);
     memory_region_add_subregion(sysmem, 0x08000000, &sdram[0]);
-    memory_region_init_ram(&sdram[1], NULL, "shix.sdram2", 0x01000000,
-                           &error_fatal);
-    vmstate_register_ram_global(&sdram[1]);
+    memory_region_allocate_aux_memory(&sdram[1], NULL, "shix.sdram2",
+                                      0x01000000);
     memory_region_add_subregion(sysmem, 0x0c000000, &sdram[1]);
 
     /* Load BIOS in 0 (and access it through P2, 0xA0000000) */
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index f415997..a8c6301 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -159,8 +159,7 @@ static void leon3_generic_hw_init(MachineState *machine)
 
     /* Allocate BIOS */
     prom_size = 8 * 1024 * 1024; /* 8Mb */
-    memory_region_init_ram(prom, NULL, "Leon3.bios", prom_size, &error_fatal);
-    vmstate_register_ram_global(prom);
+    memory_region_allocate_aux_memory(prom, NULL, "Leon3.bios", prom_size);
     memory_region_set_readonly(prom, true);
     memory_region_add_subregion(address_space_mem, 0x00000000, prom);
 
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 0faff46..3562f07 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -590,9 +590,8 @@ static void idreg_init1(Object *obj)
     IDRegState *s = MACIO_ID_REGISTER(obj);
     SysBusDevice *dev = SYS_BUS_DEVICE(obj);
 
-    memory_region_init_ram(&s->mem, obj,
-                           "sun4m.idreg", sizeof(idreg_data), &error_fatal);
-    vmstate_register_ram_global(&s->mem);
+    memory_region_allocate_aux_memory(&s->mem, obj, "sun4m.idreg",
+                                      sizeof(idreg_data));
     memory_region_set_readonly(&s->mem, true);
     sysbus_init_mmio(dev, &s->mem);
 }
@@ -631,8 +630,7 @@ static void afx_init1(Object *obj)
     AFXState *s = TCX_AFX(obj);
     SysBusDevice *dev = SYS_BUS_DEVICE(obj);
 
-    memory_region_init_ram(&s->mem, obj, "sun4m.afx", 4, &error_fatal);
-    vmstate_register_ram_global(&s->mem);
+    memory_region_allocate_aux_memory(&s->mem, obj, "sun4m.afx", 4);
     sysbus_init_mmio(dev, &s->mem);
 }
 
@@ -698,9 +696,8 @@ static void prom_init1(Object *obj)
     PROMState *s = OPENPROM(obj);
     SysBusDevice *dev = SYS_BUS_DEVICE(obj);
 
-    memory_region_init_ram(&s->prom, obj, "sun4m.prom", PROM_SIZE_MAX,
-                           &error_fatal);
-    vmstate_register_ram_global(&s->prom);
+    memory_region_allocate_aux_memory(&s->prom, obj, "sun4m.prom",
+                                      PROM_SIZE_MAX);
     memory_region_set_readonly(&s->prom, true);
     sysbus_init_mmio(dev, &s->prom);
 }
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 69f565d..e481806 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -334,9 +334,8 @@ static void prom_init1(Object *obj)
     PROMState *s = OPENPROM(obj);
     SysBusDevice *dev = SYS_BUS_DEVICE(obj);
 
-    memory_region_init_ram(&s->prom, obj, "sun4u.prom", PROM_SIZE_MAX,
-                           &error_fatal);
-    vmstate_register_ram_global(&s->prom);
+    memory_region_allocate_aux_memory(&s->prom, obj, "sun4u.prom",
+                                      PROM_SIZE_MAX);
     memory_region_set_readonly(&s->prom, true);
     sysbus_init_mmio(dev, &s->prom);
 }
@@ -377,9 +376,8 @@ static void ram_realize(DeviceState *dev, Error **errp)
     RamDevice *d = SUN4U_RAM(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
-    memory_region_init_ram(&d->ram, OBJECT(d), "sun4u.ram", d->size,
-                           &error_fatal);
-    vmstate_register_ram_global(&d->ram);
+    memory_region_allocate_aux_memory(&d->ram, OBJECT(d), "sun4u.ram",
+                                      d->size);
     sysbus_init_mmio(sbd, &d->ram);
 }
 
diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboard.c
index 8910bf0..ce843df 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -80,24 +80,18 @@ static void tricore_testboard_init(MachineState *machine, int board_id)
         exit(1);
     }
     env = &cpu->env;
-    memory_region_init_ram(ext_cram, NULL, "powerlink_ext_c.ram", 2*1024*1024,
-                           &error_fatal);
-    vmstate_register_ram_global(ext_cram);
-    memory_region_init_ram(ext_dram, NULL, "powerlink_ext_d.ram", 4*1024*1024,
-                           &error_fatal);
-    vmstate_register_ram_global(ext_dram);
-    memory_region_init_ram(int_cram, NULL, "powerlink_int_c.ram", 48*1024,
-                           &error_fatal);
-    vmstate_register_ram_global(int_cram);
-    memory_region_init_ram(int_dram, NULL, "powerlink_int_d.ram", 48*1024,
-                           &error_fatal);
-    vmstate_register_ram_global(int_dram);
-    memory_region_init_ram(pcp_data, NULL, "powerlink_pcp_data.ram", 16*1024,
-                           &error_fatal);
-    vmstate_register_ram_global(pcp_data);
-    memory_region_init_ram(pcp_text, NULL, "powerlink_pcp_text.ram", 32*1024,
-                           &error_fatal);
-    vmstate_register_ram_global(pcp_text);
+    memory_region_allocate_aux_memory(ext_cram, NULL, "powerlink_ext_c.ram",
+                                      2 * 1024 * 1024);
+    memory_region_allocate_aux_memory(ext_dram, NULL, "powerlink_ext_d.ram",
+                                      4 * 1024 * 1024);
+    memory_region_allocate_aux_memory(int_cram, NULL, "powerlink_int_c.ram",
+                                      48 * 1024);
+    memory_region_allocate_aux_memory(int_dram, NULL, "powerlink_int_d.ram",
+                                      48 * 1024);
+    memory_region_allocate_aux_memory(pcp_data, NULL,
+                                      "powerlink_pcp_data.ram", 16 * 1024);
+    memory_region_allocate_aux_memory(pcp_text, NULL,
+                                      "powerlink_pcp_text.ram", 32 * 1024);
 
     memory_region_add_subregion(sysmem, 0x80000000, ext_cram);
     memory_region_add_subregion(sysmem, 0xa1000000, ext_dram);
diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
index 032078fd..56d0bc8 100644
--- a/hw/unicore32/puv3.c
+++ b/hw/unicore32/puv3.c
@@ -78,9 +78,7 @@ static void puv3_board_init(CPUUniCore32State *env, ram_addr_t ram_size)
     MemoryRegion *ram_memory = g_new(MemoryRegion, 1);
 
     /* SDRAM at address zero.  */
-    memory_region_init_ram(ram_memory, NULL, "puv3.ram", ram_size,
-                           &error_fatal);
-    vmstate_register_ram_global(ram_memory);
+    memory_region_allocate_aux_memory(ram_memory, NULL, "puv3.ram", ram_size);
     memory_region_add_subregion(get_system_memory(), 0, ram_memory);
 }
 
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 5521e91..5fddc5c 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -48,10 +48,8 @@ static void xtensa_create_memory_regions(const XtensaMemory *memory,
 
         g_string_printf(num_name, "%s%u", name, i);
         m = g_new(MemoryRegion, 1);
-        memory_region_init_ram(m, NULL, num_name->str,
-                               memory->location[i].size,
-                               &error_fatal);
-        vmstate_register_ram_global(m);
+        memory_region_allocate_aux_memory(m, NULL, num_name->str,
+                                          memory->location[i].size);
         memory_region_add_subregion(get_system_memory(),
                                     memory->location[i].addr, m);
     }
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index d5ac080..f4dbb15 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -147,9 +147,7 @@ static void lx60_net_init(MemoryRegion *address_space,
             sysbus_mmio_get_region(s, 1));
 
     ram = g_malloc(sizeof(*ram));
-    memory_region_init_ram(ram, OBJECT(s), "open_eth.ram", 16384,
-                           &error_fatal);
-    vmstate_register_ram_global(ram);
+    memory_region_allocate_aux_memory(ram, OBJECT(s), "open_eth.ram", 16384);
     memory_region_add_subregion(address_space, buffers, ram);
 }
 
@@ -249,9 +247,8 @@ static void lx_init(const LxBoardDesc *board, MachineState *machine)
     }
 
     ram = g_malloc(sizeof(*ram));
-    memory_region_init_ram(ram, NULL, "lx60.dram", machine->ram_size,
-                           &error_fatal);
-    vmstate_register_ram_global(ram);
+    memory_region_allocate_aux_memory(ram, NULL, "lx60.dram",
+                                      machine->ram_size);
     memory_region_add_subregion(system_memory, 0, ram);
 
     system_io = g_malloc(sizeof(*system_io));
@@ -292,9 +289,8 @@ static void lx_init(const LxBoardDesc *board, MachineState *machine)
         uint32_t cur_lowmem = QEMU_ALIGN_UP(lowmem_end / 2, 4096);
 
         rom = g_malloc(sizeof(*rom));
-        memory_region_init_ram(rom, NULL, "lx60.sram", board->sram_size,
-                               &error_fatal);
-        vmstate_register_ram_global(rom);
+        memory_region_allocate_aux_memory(rom, NULL, "lx60.sram",
+                                          board->sram_size);
         memory_region_add_subregion(system_memory, 0xfe000000, rom);
 
         if (kernel_cmdline) {
diff --git a/scripts/coccinelle/allocate_aux_mem.cocci b/scripts/coccinelle/allocate_aux_mem.cocci
new file mode 100644
index 0000000..eab5313
--- /dev/null
+++ b/scripts/coccinelle/allocate_aux_mem.cocci
@@ -0,0 +1,14 @@
+// Replace by-hand memory_region_init_ram/vmstate_register_ram_global
+// code sequences with use of the new memory_region_allocate_aux_memory
+// utility function.
+
+@@
+expression MR;
+expression OWNER;
+expression NAME;
+expression SIZE;
+@@
+-memory_region_init_ram(MR, OWNER, NAME, SIZE, &error_fatal);
++memory_region_allocate_aux_memory(MR, OWNER, NAME, SIZE);
+ ...
+-vmstate_register_ram_global(MR);
-- 
2.7.4
