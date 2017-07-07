Received: from eggs.gnu.org ([2001:4830:134:3::10]:54516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dTUTX-0005x6-96
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:43:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dTUTT-00044e-7y
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:43:19 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dTUTS-00040L-In
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:43:15 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  7 Jul 2017 15:42:53 +0100
Message-Id: <1499438577-7674-8-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1499438577-7674-1-git-send-email-peter.maydell@linaro.org>
References: <1499438577-7674-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 07/11] hw: Use new memory_region_init_{ram, rom,
 rom_device}() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Use the new functions memory_region_init_{ram,rom,rom_device}()
instead of manually calling the _nomigrate() version and then
vmstate_register_ram_global().

Patch automatically created using coccinelle script:
 spatch --in-place -sp_file scripts/coccinelle/memory-region-init-ram.cocci -dir hw

(As it turns out, there are no instances of the rom and
rom_device functions that are caught by this script.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/exynos4210.c                      |  6 ++----
 hw/arm/exynos4_boards.c                  |  6 ++----
 hw/arm/fsl-imx25.c                       |  3 +--
 hw/arm/fsl-imx31.c                       |  3 +--
 hw/arm/fsl-imx6.c                        |  3 +--
 hw/arm/mainstone.c                       |  3 +--
 hw/arm/musicpal.c                        |  3 +--
 hw/arm/omap1.c                           |  3 +--
 hw/arm/omap2.c                           |  3 +--
 hw/arm/omap_sx1.c                        |  8 +++-----
 hw/arm/palm.c                            |  3 +--
 hw/arm/pxa2xx.c                          | 12 ++++--------
 hw/arm/realview.c                        |  9 +++------
 hw/arm/spitz.c                           |  3 +--
 hw/arm/stellaris.c                       |  6 ++----
 hw/arm/stm32f205_soc.c                   |  7 ++-----
 hw/arm/tosa.c                            |  3 +--
 hw/arm/vexpress.c                        |  9 +++------
 hw/arm/virt.c                            |  4 ++--
 hw/arm/xilinx_zynq.c                     |  3 +--
 hw/arm/xlnx-zynqmp.c                     |  3 +--
 hw/cris/axis_dev88.c                     |  5 ++---
 hw/display/cg3.c                         |  3 +--
 hw/display/tc6393xb.c                    |  3 +--
 hw/display/vmware_vga.c                  |  3 +--
 hw/i386/pc.c                             |  3 +--
 hw/i386/pc_sysfw.c                       |  6 ++----
 hw/i386/xen/xen-hvm.c                    |  3 +--
 hw/m68k/an5206.c                         |  3 +--
 hw/m68k/mcf5208.c                        |  3 +--
 hw/microblaze/petalogix_ml605_mmu.c      |  6 ++----
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  6 ++----
 hw/mips/mips_fulong2e.c                  |  3 +--
 hw/mips/mips_jazz.c                      |  6 ++----
 hw/mips/mips_mipssim.c                   |  3 +--
 hw/mips/mips_r4k.c                       |  3 +--
 hw/moxie/moxiesim.c                      |  6 ++----
 hw/nios2/10m50_devboard.c                |  8 ++++----
 hw/openrisc/openrisc_sim.c               |  3 +--
 hw/ppc/mac_newworld.c                    |  3 +--
 hw/ppc/mac_oldworld.c                    |  3 +--
 hw/ppc/ppc405_boards.c                   |  9 +++------
 hw/ppc/ppc405_uc.c                       |  3 +--
 hw/s390x/sclp.c                          |  3 +--
 hw/sh4/r2d.c                             |  3 +--
 hw/sh4/shix.c                            |  9 +++------
 hw/sparc/leon3.c                         |  3 +--
 hw/tricore/tricore_testboard.c           | 26 ++++++++++----------------
 hw/unicore32/puv3.c                      |  3 +--
 hw/xtensa/sim.c                          |  6 ++----
 hw/xtensa/xtfpga.c                       |  6 ++----
 51 files changed, 89 insertions(+), 167 deletions(-)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index a12615c..0380360 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -276,9 +276,8 @@ Exynos4210State *exynos4210_init(MemoryRegion *system_mem)
                                 &s->chipid_mem);
 
     /* Internal ROM */
-    memory_region_init_ram_nomigrate(&s->irom_mem, NULL, "exynos4210.irom",
+    memory_region_init_ram(&s->irom_mem, NULL, "exynos4210.irom",
                            EXYNOS4210_IROM_SIZE, &error_fatal);
-    vmstate_register_ram_global(&s->irom_mem);
     memory_region_set_readonly(&s->irom_mem, true);
     memory_region_add_subregion(system_mem, EXYNOS4210_IROM_BASE_ADDR,
                                 &s->irom_mem);
@@ -292,9 +291,8 @@ Exynos4210State *exynos4210_init(MemoryRegion *system_mem)
                                 &s->irom_alias_mem);
 
     /* Internal RAM */
-    memory_region_init_ram_nomigrate(&s->iram_mem, NULL, "exynos4210.iram",
+    memory_region_init_ram(&s->iram_mem, NULL, "exynos4210.iram",
                            EXYNOS4210_IRAM_SIZE, &error_fatal);
-    vmstate_register_ram_global(&s->iram_mem);
     memory_region_add_subregion(system_mem, EXYNOS4210_IRAM_BASE_ADDR,
                                 &s->iram_mem);
 
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index c3b0d2e..7c03ed3 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -110,18 +110,16 @@ static void exynos4_boards_init_ram(Exynos4BoardState *s,
     unsigned long mem_size = ram_size;
 
     if (mem_size > EXYNOS4210_DRAM_MAX_SIZE) {
-        memory_region_init_ram_nomigrate(&s->dram1_mem, NULL, "exynos4210.dram1",
+        memory_region_init_ram(&s->dram1_mem, NULL, "exynos4210.dram1",
                                mem_size - EXYNOS4210_DRAM_MAX_SIZE,
                                &error_fatal);
-        vmstate_register_ram_global(&s->dram1_mem);
         memory_region_add_subregion(system_mem, EXYNOS4210_DRAM1_BASE_ADDR,
                                     &s->dram1_mem);
         mem_size = EXYNOS4210_DRAM_MAX_SIZE;
     }
 
-    memory_region_init_ram_nomigrate(&s->dram0_mem, NULL, "exynos4210.dram0", mem_size,
+    memory_region_init_ram(&s->dram0_mem, NULL, "exynos4210.dram0", mem_size,
                            &error_fatal);
-    vmstate_register_ram_global(&s->dram0_mem);
     memory_region_add_subregion(system_mem, EXYNOS4210_DRAM0_BASE_ADDR,
                                 &s->dram0_mem);
 }
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index cebe0ec..8cff3c1 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -267,7 +267,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
                                 &s->rom[1]);
 
     /* initialize internal RAM (128 KB) */
-    memory_region_init_ram_nomigrate(&s->iram, NULL, "imx25.iram", FSL_IMX25_IRAM_SIZE,
+    memory_region_init_ram(&s->iram, NULL, "imx25.iram", FSL_IMX25_IRAM_SIZE,
                            &err);
     if (err) {
         error_propagate(errp, err);
@@ -275,7 +275,6 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX25_IRAM_ADDR,
                                 &s->iram);
-    vmstate_register_ram_global(&s->iram);
 
     /* internal RAM (128 KB) is aliased over 128 MB - 128 KB */
     memory_region_init_alias(&s->iram_alias, NULL, "imx25.iram_alias",
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 6c2823a..9027875 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -239,7 +239,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
                                 &s->rom);
 
     /* initialize internal RAM (16 KB) */
-    memory_region_init_ram_nomigrate(&s->iram, NULL, "imx31.iram", FSL_IMX31_IRAM_SIZE,
+    memory_region_init_ram(&s->iram, NULL, "imx31.iram", FSL_IMX31_IRAM_SIZE,
                            &err);
     if (err) {
         error_propagate(errp, err);
@@ -247,7 +247,6 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX31_IRAM_ADDR,
                                 &s->iram);
-    vmstate_register_ram_global(&s->iram);
 
     /* internal RAM (16 KB) is aliased over 256 MB - 16 KB */
     memory_region_init_alias(&s->iram_alias, NULL, "imx31.iram_alias",
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index e00b2f9..576c663 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -419,7 +419,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                 &s->caam);
 
     /* OCRAM memory */
-    memory_region_init_ram_nomigrate(&s->ocram, NULL, "imx6.ocram", FSL_IMX6_OCRAM_SIZE,
+    memory_region_init_ram(&s->ocram, NULL, "imx6.ocram", FSL_IMX6_OCRAM_SIZE,
                            &err);
     if (err) {
         error_propagate(errp, err);
@@ -427,7 +427,6 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX6_OCRAM_ADDR,
                                 &s->ocram);
-    vmstate_register_ram_global(&s->ocram);
 
     /* internal OCRAM (256 KB) is aliased over 1 MB */
     memory_region_init_alias(&s->ocram_alias, NULL, "imx6.ocram_alias",
diff --git a/hw/arm/mainstone.c b/hw/arm/mainstone.c
index 4ade8a2..fb268e6 100644
--- a/hw/arm/mainstone.c
+++ b/hw/arm/mainstone.c
@@ -128,9 +128,8 @@ static void mainstone_common_init(MemoryRegion *address_space_mem,
 
     /* Setup CPU & memory */
     mpu = pxa270_init(address_space_mem, mainstone_binfo.ram_size, cpu_model);
-    memory_region_init_ram_nomigrate(rom, NULL, "mainstone.rom", MAINSTONE_ROM,
+    memory_region_init_ram(rom, NULL, "mainstone.rom", MAINSTONE_ROM,
                            &error_fatal);
-    vmstate_register_ram_global(rom);
     memory_region_set_readonly(rom, true);
     memory_region_add_subregion(address_space_mem, 0, rom);
 
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index ee5dfed..7e8ab31 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1604,9 +1604,8 @@ static void musicpal_init(MachineState *machine)
                                          MP_RAM_DEFAULT_SIZE);
     memory_region_add_subregion(address_space_mem, 0, ram);
 
-    memory_region_init_ram_nomigrate(sram, NULL, "musicpal.sram", MP_SRAM_SIZE,
+    memory_region_init_ram(sram, NULL, "musicpal.sram", MP_SRAM_SIZE,
                            &error_fatal);
-    vmstate_register_ram_global(sram);
     memory_region_add_subregion(address_space_mem, MP_SRAM_BASE, sram);
 
     dev = sysbus_create_simple(TYPE_MV88W8618_PIC, MP_PIC_BASE,
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index f4afb88..3d15ff6 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -3880,9 +3880,8 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *system_memory,
     memory_region_allocate_system_memory(&s->emiff_ram, NULL, "omap1.dram",
                                          s->sdram_size);
     memory_region_add_subregion(system_memory, OMAP_EMIFF_BASE, &s->emiff_ram);
-    memory_region_init_ram_nomigrate(&s->imif_ram, NULL, "omap1.sram", s->sram_size,
+    memory_region_init_ram(&s->imif_ram, NULL, "omap1.sram", s->sram_size,
                            &error_fatal);
-    vmstate_register_ram_global(&s->imif_ram);
     memory_region_add_subregion(system_memory, OMAP_IMIF_BASE, &s->imif_ram);
 
     omap_clkm_init(system_memory, 0xfffece00, 0xe1008000, s);
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index 504bfe1..bbf0b7e 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -2278,9 +2278,8 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sysmem,
     memory_region_allocate_system_memory(&s->sdram, NULL, "omap2.dram",
                                          s->sdram_size);
     memory_region_add_subregion(sysmem, OMAP2_Q2_BASE, &s->sdram);
-    memory_region_init_ram_nomigrate(&s->sram, NULL, "omap2.sram", s->sram_size,
+    memory_region_init_ram(&s->sram, NULL, "omap2.sram", s->sram_size,
                            &error_fatal);
-    vmstate_register_ram_global(&s->sram);
     memory_region_add_subregion(sysmem, OMAP2_SRAM_BASE, &s->sram);
 
     s->l4 = omap_l4_init(sysmem, OMAP2_L4_BASE, 54);
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index d70c6b6..9809106 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -123,9 +123,8 @@ static void sx1_init(MachineState *machine, const int version)
                            machine->cpu_model);
 
     /* External Flash (EMIFS) */
-    memory_region_init_ram_nomigrate(flash, NULL, "omap_sx1.flash0-0", flash_size,
+    memory_region_init_ram(flash, NULL, "omap_sx1.flash0-0", flash_size,
                            &error_fatal);
-    vmstate_register_ram_global(flash);
     memory_region_set_readonly(flash, true);
     memory_region_add_subregion(address_space, OMAP_CS0_BASE, flash);
 
@@ -167,9 +166,8 @@ static void sx1_init(MachineState *machine, const int version)
     if ((version == 1) &&
             (dinfo = drive_get(IF_PFLASH, 0, fl_idx)) != NULL) {
         MemoryRegion *flash_1 = g_new(MemoryRegion, 1);
-        memory_region_init_ram_nomigrate(flash_1, NULL, "omap_sx1.flash1-0", flash1_size,
-                               &error_fatal);
-        vmstate_register_ram_global(flash_1);
+        memory_region_init_ram(flash_1, NULL, "omap_sx1.flash1-0",
+                               flash1_size, &error_fatal);
         memory_region_set_readonly(flash_1, true);
         memory_region_add_subregion(address_space, OMAP_CS1_BASE, flash_1);
 
diff --git a/hw/arm/palm.c b/hw/arm/palm.c
index abacdff..64cf8ca 100644
--- a/hw/arm/palm.c
+++ b/hw/arm/palm.c
@@ -214,9 +214,8 @@ static void palmte_init(MachineState *machine)
     mpu = omap310_mpu_init(address_space_mem, sdram_size, cpu_model);
 
     /* External Flash (EMIFS) */
-    memory_region_init_ram_nomigrate(flash, NULL, "palmte.flash", flash_size,
+    memory_region_init_ram(flash, NULL, "palmte.flash", flash_size,
                            &error_fatal);
-    vmstate_register_ram_global(flash);
     memory_region_set_readonly(flash, true);
     memory_region_add_subregion(address_space_mem, OMAP_CS0_BASE, flash);
 
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index ae46659..6fa8cf3 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -2073,13 +2073,11 @@ PXA2xxState *pxa270_init(MemoryRegion *address_space,
     s->reset = qemu_allocate_irq(pxa2xx_reset, s, 0);
 
     /* SDRAM & Internal Memory Storage */
-    memory_region_init_ram_nomigrate(&s->sdram, NULL, "pxa270.sdram", sdram_size,
+    memory_region_init_ram(&s->sdram, NULL, "pxa270.sdram", sdram_size,
                            &error_fatal);
-    vmstate_register_ram_global(&s->sdram);
     memory_region_add_subregion(address_space, PXA2XX_SDRAM_BASE, &s->sdram);
-    memory_region_init_ram_nomigrate(&s->internal, NULL, "pxa270.internal", 0x40000,
+    memory_region_init_ram(&s->internal, NULL, "pxa270.internal", 0x40000,
                            &error_fatal);
-    vmstate_register_ram_global(&s->internal);
     memory_region_add_subregion(address_space, PXA2XX_INTERNAL_BASE,
                                 &s->internal);
 
@@ -2205,13 +2203,11 @@ PXA2xxState *pxa255_init(MemoryRegion *address_space, unsigned int sdram_size)
     s->reset = qemu_allocate_irq(pxa2xx_reset, s, 0);
 
     /* SDRAM & Internal Memory Storage */
-    memory_region_init_ram_nomigrate(&s->sdram, NULL, "pxa255.sdram", sdram_size,
+    memory_region_init_ram(&s->sdram, NULL, "pxa255.sdram", sdram_size,
                            &error_fatal);
-    vmstate_register_ram_global(&s->sdram);
     memory_region_add_subregion(address_space, PXA2XX_SDRAM_BASE, &s->sdram);
-    memory_region_init_ram_nomigrate(&s->internal, NULL, "pxa255.internal",
+    memory_region_init_ram(&s->internal, NULL, "pxa255.internal",
                            PXA2XX_INTERNAL_SIZE, &error_fatal);
-    vmstate_register_ram_global(&s->internal);
     memory_region_add_subregion(address_space, PXA2XX_INTERNAL_BASE,
                                 &s->internal);
 
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index a5e8f86..76ff557 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -143,15 +143,13 @@ static void realview_init(MachineState *machine,
         ram_lo = g_new(MemoryRegion, 1);
         low_ram_size = ram_size - 0x20000000;
         ram_size = 0x20000000;
-        memory_region_init_ram_nomigrate(ram_lo, NULL, "realview.lowmem", low_ram_size,
+        memory_region_init_ram(ram_lo, NULL, "realview.lowmem", low_ram_size,
                                &error_fatal);
-        vmstate_register_ram_global(ram_lo);
         memory_region_add_subregion(sysmem, 0x20000000, ram_lo);
     }
 
-    memory_region_init_ram_nomigrate(ram_hi, NULL, "realview.highmem", ram_size,
+    memory_region_init_ram(ram_hi, NULL, "realview.highmem", ram_size,
                            &error_fatal);
-    vmstate_register_ram_global(ram_hi);
     low_ram_size = ram_size;
     if (low_ram_size > 0x10000000)
       low_ram_size = 0x10000000;
@@ -345,9 +343,8 @@ static void realview_init(MachineState *machine,
        startup code.  I guess this works on real hardware because the
        BootROM happens to be in ROM/flash or in memory that isn't clobbered
        until after Linux boots the secondary CPUs.  */
-    memory_region_init_ram_nomigrate(ram_hack, NULL, "realview.hack", 0x1000,
+    memory_region_init_ram(ram_hack, NULL, "realview.hack", 0x1000,
                            &error_fatal);
-    vmstate_register_ram_global(ram_hack);
     memory_region_add_subregion(sysmem, SMP_BOOT_ADDR, ram_hack);
 
     realview_binfo.ram_size = ram_size;
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index f89584c..7f588ce 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -919,8 +919,7 @@ static void spitz_common_init(MachineState *machine,
 
     sl_flash_register(mpu, (model == spitz) ? FLASH_128M : FLASH_1024M);
 
-    memory_region_init_ram_nomigrate(rom, NULL, "spitz.rom", SPITZ_ROM, &error_fatal);
-    vmstate_register_ram_global(rom);
+    memory_region_init_ram(rom, NULL, "spitz.rom", SPITZ_ROM, &error_fatal);
     memory_region_set_readonly(rom, true);
     memory_region_add_subregion(address_space_mem, 0, rom);
 
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index ce23f36..408c1a1 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1288,15 +1288,13 @@ static void stellaris_init(const char *kernel_filename, const char *cpu_model,
     sram_size = ((board->dc0 >> 18) + 1) * 1024;
 
     /* Flash programming is done via the SCU, so pretend it is ROM.  */
-    memory_region_init_ram_nomigrate(flash, NULL, "stellaris.flash", flash_size,
+    memory_region_init_ram(flash, NULL, "stellaris.flash", flash_size,
                            &error_fatal);
-    vmstate_register_ram_global(flash);
     memory_region_set_readonly(flash, true);
     memory_region_add_subregion(system_memory, 0, flash);
 
-    memory_region_init_ram_nomigrate(sram, NULL, "stellaris.sram", sram_size,
+    memory_region_init_ram(sram, NULL, "stellaris.sram", sram_size,
                            &error_fatal);
-    vmstate_register_ram_global(sram);
     memory_region_add_subregion(system_memory, 0x20000000, sram);
 
     nvic = armv7m_init(system_memory, flash_size, NUM_IRQ_LINES,
diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index 2e9dff1..f61e735 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -95,22 +95,19 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     MemoryRegion *flash = g_new(MemoryRegion, 1);
     MemoryRegion *flash_alias = g_new(MemoryRegion, 1);
 
-    memory_region_init_ram_nomigrate(flash, NULL, "STM32F205.flash", FLASH_SIZE,
+    memory_region_init_ram(flash, NULL, "STM32F205.flash", FLASH_SIZE,
                            &error_fatal);
     memory_region_init_alias(flash_alias, NULL, "STM32F205.flash.alias",
                              flash, 0, FLASH_SIZE);
 
-    vmstate_register_ram_global(flash);
-
     memory_region_set_readonly(flash, true);
     memory_region_set_readonly(flash_alias, true);
 
     memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, flash);
     memory_region_add_subregion(system_memory, 0, flash_alias);
 
-    memory_region_init_ram_nomigrate(sram, NULL, "STM32F205.sram", SRAM_SIZE,
+    memory_region_init_ram(sram, NULL, "STM32F205.sram", SRAM_SIZE,
                            &error_fatal);
-    vmstate_register_ram_global(sram);
     memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, sram);
 
     armv7m = DEVICE(&s->armv7m);
diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index bfd1153..8b757ff 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -234,8 +234,7 @@ static void tosa_init(MachineState *machine)
 
     mpu = pxa255_init(address_space_mem, tosa_binfo.ram_size);
 
-    memory_region_init_ram_nomigrate(rom, NULL, "tosa.rom", TOSA_ROM, &error_fatal);
-    vmstate_register_ram_global(rom);
+    memory_region_init_ram(rom, NULL, "tosa.rom", TOSA_ROM, &error_fatal);
     memory_region_set_readonly(rom, true);
     memory_region_add_subregion(address_space_mem, 0, rom);
 
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 874d885..528c65d 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -390,9 +390,8 @@ static void a15_daughterboard_init(const VexpressMachineState *vms,
     /* 0x2b060000: SP805 watchdog: not modelled */
     /* 0x2b0a0000: PL341 dynamic memory controller: not modelled */
     /* 0x2e000000: system SRAM */
-    memory_region_init_ram_nomigrate(sram, NULL, "vexpress.a15sram", 0x10000,
+    memory_region_init_ram(sram, NULL, "vexpress.a15sram", 0x10000,
                            &error_fatal);
-    vmstate_register_ram_global(sram);
     memory_region_add_subregion(sysmem, 0x2e000000, sram);
 
     /* 0x7ffb0000: DMA330 DMA controller: not modelled */
@@ -673,15 +672,13 @@ static void vexpress_common_init(MachineState *machine)
     }
 
     sram_size = 0x2000000;
-    memory_region_init_ram_nomigrate(sram, NULL, "vexpress.sram", sram_size,
+    memory_region_init_ram(sram, NULL, "vexpress.sram", sram_size,
                            &error_fatal);
-    vmstate_register_ram_global(sram);
     memory_region_add_subregion(sysmem, map[VE_SRAM], sram);
 
     vram_size = 0x800000;
-    memory_region_init_ram_nomigrate(vram, NULL, "vexpress.vram", vram_size,
+    memory_region_init_ram(vram, NULL, "vexpress.vram", vram_size,
                            &error_fatal);
-    vmstate_register_ram_global(vram);
     memory_region_add_subregion(sysmem, map[VE_VIDEORAM], vram);
 
     /* 0x4e000000 LAN9118 Ethernet */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 30f010a..31739d7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1155,8 +1155,8 @@ static void create_secure_ram(VirtMachineState *vms,
     hwaddr base = vms->memmap[VIRT_SECURE_MEM].base;
     hwaddr size = vms->memmap[VIRT_SECURE_MEM].size;
 
-    memory_region_init_ram_nomigrate(secram, NULL, "virt.secure-ram", size, &error_fatal);
-    vmstate_register_ram_global(secram);
+    memory_region_init_ram(secram, NULL, "virt.secure-ram", size,
+                           &error_fatal);
     memory_region_add_subregion(secure_sysmem, base, secram);
 
     nodename = g_strdup_printf("/secram@%" PRIx64, base);
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 8ae6535..6b11a75 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -204,9 +204,8 @@ static void zynq_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, 0, ext_ram);
 
     /* 256K of on-chip memory */
-    memory_region_init_ram_nomigrate(ocm_ram, NULL, "zynq.ocm_ram", 256 << 10,
+    memory_region_init_ram(ocm_ram, NULL, "zynq.ocm_ram", 256 << 10,
                            &error_fatal);
-    vmstate_register_ram_global(ocm_ram);
     memory_region_add_subregion(address_space_mem, 0xFFFC0000, ocm_ram);
 
     DriveInfo *dinfo = drive_get(IF_PFLASH, 0, 0);
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index d6f73d7..9eceadb 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -226,9 +226,8 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < XLNX_ZYNQMP_NUM_OCM_BANKS; i++) {
         char *ocm_name = g_strdup_printf("zynqmp.ocm_ram_bank_%d", i);
 
-        memory_region_init_ram_nomigrate(&s->ocm_ram[i], NULL, ocm_name,
+        memory_region_init_ram(&s->ocm_ram[i], NULL, ocm_name,
                                XLNX_ZYNQMP_OCM_RAM_SIZE, &error_fatal);
-        vmstate_register_ram_global(&s->ocm_ram[i]);
         memory_region_add_subregion(get_system_memory(),
                                     XLNX_ZYNQMP_OCM_RAM_0_ADDRESS +
                                         i * XLNX_ZYNQMP_OCM_RAM_SIZE,
diff --git a/hw/cris/axis_dev88.c b/hw/cris/axis_dev88.c
index 8a2564d..80674f6 100644
--- a/hw/cris/axis_dev88.c
+++ b/hw/cris/axis_dev88.c
@@ -281,9 +281,8 @@ void axisdev88_init(MachineState *machine)
 
     /* The ETRAX-FS has 128Kb on chip ram, the docs refer to it as the 
        internal memory.  */
-    memory_region_init_ram_nomigrate(phys_intmem, NULL, "axisdev88.chipram", INTMEM_SIZE,
-                           &error_fatal);
-    vmstate_register_ram_global(phys_intmem);
+    memory_region_init_ram(phys_intmem, NULL, "axisdev88.chipram",
+                           INTMEM_SIZE, &error_fatal);
     memory_region_add_subregion(address_space_mem, 0x38000000, phys_intmem);
 
       /* Attach a NAND flash to CS1.  */
diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index 54439b2..e069c44 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -311,10 +311,9 @@ static void cg3_realizefn(DeviceState *dev, Error **errp)
         }
     }
 
-    memory_region_init_ram_nomigrate(&s->vram_mem, NULL, "cg3.vram", s->vram_size,
+    memory_region_init_ram(&s->vram_mem, NULL, "cg3.vram", s->vram_size,
                            &error_fatal);
     memory_region_set_log(&s->vram_mem, true, DIRTY_MEMORY_VGA);
-    vmstate_register_ram_global(&s->vram_mem);
     sysbus_init_mmio(sbd, &s->vram_mem);
 
     sysbus_init_irq(sbd, &s->irq);
diff --git a/hw/display/tc6393xb.c b/hw/display/tc6393xb.c
index 762e370..74d10af 100644
--- a/hw/display/tc6393xb.c
+++ b/hw/display/tc6393xb.c
@@ -586,9 +586,8 @@ TC6393xbState *tc6393xb_init(MemoryRegion *sysmem, uint32_t base, qemu_irq irq)
     memory_region_init_io(&s->iomem, NULL, &tc6393xb_ops, s, "tc6393xb", 0x10000);
     memory_region_add_subregion(sysmem, base, &s->iomem);
 
-    memory_region_init_ram_nomigrate(&s->vram, NULL, "tc6393xb.vram", 0x100000,
+    memory_region_init_ram(&s->vram, NULL, "tc6393xb.vram", 0x100000,
                            &error_fatal);
-    vmstate_register_ram_global(&s->vram);
     s->vram_ptr = memory_region_get_ram_ptr(&s->vram);
     memory_region_add_subregion(sysmem, base + 0x100000, &s->vram);
     s->scr_width = 480;
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 120b0dd..4a64b41 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1239,9 +1239,8 @@ static void vmsvga_init(DeviceState *dev, struct vmsvga_state_s *s,
     s->vga.con = graphic_console_init(dev, 0, &vmsvga_ops, s);
 
     s->fifo_size = SVGA_FIFO_SIZE;
-    memory_region_init_ram_nomigrate(&s->fifo_ram, NULL, "vmsvga.fifo", s->fifo_size,
+    memory_region_init_ram(&s->fifo_ram, NULL, "vmsvga.fifo", s->fifo_size,
                            &error_fatal);
-    vmstate_register_ram_global(&s->fifo_ram);
     s->fifo_ptr = memory_region_get_ram_ptr(&s->fifo_ram);
 
     vga_common_init(&s->vga, OBJECT(dev), true);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 72c03ec..b0420e2 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1442,9 +1442,8 @@ void pc_memory_init(PCMachineState *pcms,
     pc_system_firmware_init(rom_memory, !pcmc->pci_enabled);
 
     option_rom_mr = g_malloc(sizeof(*option_rom_mr));
-    memory_region_init_ram_nomigrate(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
+    memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
                            &error_fatal);
-    vmstate_register_ram_global(option_rom_mr);
     memory_region_add_subregion_overlap(rom_memory,
                                         PC_ROM_MIN_VGA,
                                         option_rom_mr,
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index fbfd0c4..6b18374 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -57,9 +57,8 @@ static void pc_isa_bios_init(MemoryRegion *rom_memory,
     /* map the last 128KB of the BIOS in ISA space */
     isa_bios_size = MIN(flash_size, 128 * 1024);
     isa_bios = g_malloc(sizeof(*isa_bios));
-    memory_region_init_ram_nomigrate(isa_bios, NULL, "isa-bios", isa_bios_size,
+    memory_region_init_ram(isa_bios, NULL, "isa-bios", isa_bios_size,
                            &error_fatal);
-    vmstate_register_ram_global(isa_bios);
     memory_region_add_subregion_overlap(rom_memory,
                                         0x100000 - isa_bios_size,
                                         isa_bios,
@@ -195,8 +194,7 @@ static void old_pc_system_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw)
         goto bios_error;
     }
     bios = g_malloc(sizeof(*bios));
-    memory_region_init_ram_nomigrate(bios, NULL, "pc.bios", bios_size, &error_fatal);
-    vmstate_register_ram_global(bios);
+    memory_region_init_ram(bios, NULL, "pc.bios", bios_size, &error_fatal);
     if (!isapc_ram_fw) {
         memory_region_set_readonly(bios, true);
     }
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 55ec96d..3d951a3 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -212,10 +212,9 @@ static void xen_ram_init(PCMachineState *pcms,
          */
         block_len = (1ULL << 32) + pcms->above_4g_mem_size;
     }
-    memory_region_init_ram_nomigrate(&ram_memory, NULL, "xen.ram", block_len,
+    memory_region_init_ram(&ram_memory, NULL, "xen.ram", block_len,
                            &error_fatal);
     *ram_memory_p = &ram_memory;
-    vmstate_register_ram_global(&ram_memory);
 
     memory_region_init_alias(&ram_640k, NULL, "xen.ram.640k",
                              &ram_memory, 0, 0xa0000);
diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index 6fd3c6f..c762441 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -60,8 +60,7 @@ static void an5206_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, 0, ram);
 
     /* Internal SRAM.  */
-    memory_region_init_ram_nomigrate(sram, NULL, "an5206.sram", 512, &error_fatal);
-    vmstate_register_ram_global(sram);
+    memory_region_init_ram(sram, NULL, "an5206.sram", 512, &error_fatal);
     memory_region_add_subregion(address_space_mem, AN5206_RAMBAR_ADDR, sram);
 
     mcf5206_init(address_space_mem, AN5206_MBAR_ADDR, cpu);
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index f4abe1d..f4b1387 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -248,8 +248,7 @@ static void mcf5208evb_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, 0x40000000, ram);
 
     /* Internal SRAM.  */
-    memory_region_init_ram_nomigrate(sram, NULL, "mcf5208.sram", 16384, &error_fatal);
-    vmstate_register_ram_global(sram);
+    memory_region_init_ram(sram, NULL, "mcf5208.sram", 16384, &error_fatal);
     memory_region_add_subregion(address_space_mem, 0x80000000, sram);
 
     /* Internal peripherals.  */
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index fb022cd..b664dc0 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -96,14 +96,12 @@ petalogix_ml605_init(MachineState *machine)
     object_property_set_bool(OBJECT(cpu), true, "realized", &error_abort);
 
     /* Attach emulated BRAM through the LMB.  */
-    memory_region_init_ram_nomigrate(phys_lmb_bram, NULL, "petalogix_ml605.lmb_bram",
+    memory_region_init_ram(phys_lmb_bram, NULL, "petalogix_ml605.lmb_bram",
                            LMB_BRAM_SIZE, &error_fatal);
-    vmstate_register_ram_global(phys_lmb_bram);
     memory_region_add_subregion(address_space_mem, 0x00000000, phys_lmb_bram);
 
-    memory_region_init_ram_nomigrate(phys_ram, NULL, "petalogix_ml605.ram", ram_size,
+    memory_region_init_ram(phys_ram, NULL, "petalogix_ml605.ram", ram_size,
                            &error_fatal);
-    vmstate_register_ram_global(phys_ram);
     memory_region_add_subregion(address_space_mem, MEMORY_BASEADDR, phys_ram);
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index d71fcd5..5cb4deb 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -75,15 +75,13 @@ petalogix_s3adsp1800_init(MachineState *machine)
     object_property_set_bool(OBJECT(cpu), true, "realized", &error_abort);
 
     /* Attach emulated BRAM through the LMB.  */
-    memory_region_init_ram_nomigrate(phys_lmb_bram, NULL,
+    memory_region_init_ram(phys_lmb_bram, NULL,
                            "petalogix_s3adsp1800.lmb_bram", LMB_BRAM_SIZE,
                            &error_fatal);
-    vmstate_register_ram_global(phys_lmb_bram);
     memory_region_add_subregion(sysmem, 0x00000000, phys_lmb_bram);
 
-    memory_region_init_ram_nomigrate(phys_ram, NULL, "petalogix_s3adsp1800.ram",
+    memory_region_init_ram(phys_ram, NULL, "petalogix_s3adsp1800.ram",
                            ram_size, &error_fatal);
-    vmstate_register_ram_global(phys_ram);
     memory_region_add_subregion(sysmem, ddr_base, phys_ram);
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index def3717..3f3cb32 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -294,9 +294,8 @@ static void mips_fulong2e_init(MachineState *machine)
 
     /* allocate RAM */
     memory_region_allocate_system_memory(ram, NULL, "fulong2e.ram", ram_size);
-    memory_region_init_ram_nomigrate(bios, NULL, "fulong2e.bios", bios_size,
+    memory_region_init_ram(bios, NULL, "fulong2e.bios", bios_size,
                            &error_fatal);
-    vmstate_register_ram_global(bios);
     memory_region_set_readonly(bios, true);
 
     memory_region_add_subregion(address_space_mem, 0, ram);
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index fcf0529..533a7b7 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -175,9 +175,8 @@ static void mips_jazz_init(MachineState *machine,
                                          machine->ram_size);
     memory_region_add_subregion(address_space, 0, ram);
 
-    memory_region_init_ram_nomigrate(bios, NULL, "mips_jazz.bios", MAGNUM_BIOS_SIZE,
+    memory_region_init_ram(bios, NULL, "mips_jazz.bios", MAGNUM_BIOS_SIZE,
                            &error_fatal);
-    vmstate_register_ram_global(bios);
     memory_region_set_readonly(bios, true);
     memory_region_init_alias(bios2, NULL, "mips_jazz.bios", bios,
                              0, MAGNUM_BIOS_SIZE);
@@ -242,9 +241,8 @@ static void mips_jazz_init(MachineState *machine,
         {
             /* Simple ROM, so user doesn't have to provide one */
             MemoryRegion *rom_mr = g_new(MemoryRegion, 1);
-            memory_region_init_ram_nomigrate(rom_mr, NULL, "g364fb.rom", 0x80000,
+            memory_region_init_ram(rom_mr, NULL, "g364fb.rom", 0x80000,
                                    &error_fatal);
-            vmstate_register_ram_global(rom_mr);
             memory_region_set_readonly(rom_mr, true);
             uint8_t *rom = memory_region_get_ram_ptr(rom_mr);
             memory_region_add_subregion(address_space, 0x60000000, rom_mr);
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
index da8dd81..6990b1b 100644
--- a/hw/mips/mips_mipssim.c
+++ b/hw/mips/mips_mipssim.c
@@ -177,9 +177,8 @@ mips_mipssim_init(MachineState *machine)
     /* Allocate RAM. */
     memory_region_allocate_system_memory(ram, NULL, "mips_mipssim.ram",
                                          ram_size);
-    memory_region_init_ram_nomigrate(bios, NULL, "mips_mipssim.bios", BIOS_SIZE,
+    memory_region_init_ram(bios, NULL, "mips_mipssim.bios", BIOS_SIZE,
                            &error_fatal);
-    vmstate_register_ram_global(bios);
     memory_region_set_readonly(bios, true);
 
     memory_region_add_subregion(address_space_mem, 0, ram);
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index a2f790b..690874b 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -236,9 +236,8 @@ void mips_r4k_init(MachineState *machine)
 #endif
     if ((bios_size > 0) && (bios_size <= BIOS_SIZE)) {
         bios = g_new(MemoryRegion, 1);
-        memory_region_init_ram_nomigrate(bios, NULL, "mips_r4k.bios", BIOS_SIZE,
+        memory_region_init_ram(bios, NULL, "mips_r4k.bios", BIOS_SIZE,
                                &error_fatal);
-        vmstate_register_ram_global(bios);
         memory_region_set_readonly(bios, true);
         memory_region_add_subregion(get_system_memory(), 0x1fc00000, bios);
 
diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
index e18fb74..df3f124 100644
--- a/hw/moxie/moxiesim.c
+++ b/hw/moxie/moxiesim.c
@@ -128,12 +128,10 @@ static void moxiesim_init(MachineState *machine)
     qemu_register_reset(main_cpu_reset, cpu);
 
     /* Allocate RAM. */
-    memory_region_init_ram_nomigrate(ram, NULL, "moxiesim.ram", ram_size, &error_fatal);
-    vmstate_register_ram_global(ram);
+    memory_region_init_ram(ram, NULL, "moxiesim.ram", ram_size, &error_fatal);
     memory_region_add_subregion(address_space_mem, ram_base, ram);
 
-    memory_region_init_ram_nomigrate(rom, NULL, "moxie.rom", 128*0x1000, &error_fatal);
-    vmstate_register_ram_global(rom);
+    memory_region_init_ram(rom, NULL, "moxie.rom", 128 * 0x1000, &error_fatal);
     memory_region_add_subregion(get_system_memory(), 0x1000, rom);
 
     if (kernel_filename) {
diff --git a/hw/nios2/10m50_devboard.c b/hw/nios2/10m50_devboard.c
index 4f1ea2d..b6868b8 100644
--- a/hw/nios2/10m50_devboard.c
+++ b/hw/nios2/10m50_devboard.c
@@ -57,19 +57,19 @@ static void nios2_10m50_ghrd_init(MachineState *machine)
     int i;
 
     /* Physical TCM (tb_ram_1k) with alias at 0xc0000000 */
-    memory_region_init_ram_nomigrate(phys_tcm, NULL, "nios2.tcm", tcm_size, &error_abort);
+    memory_region_init_ram(phys_tcm, NULL, "nios2.tcm", tcm_size,
+                           &error_abort);
     memory_region_init_alias(phys_tcm_alias, NULL, "nios2.tcm.alias",
                              phys_tcm, 0, tcm_size);
-    vmstate_register_ram_global(phys_tcm);
     memory_region_add_subregion(address_space_mem, tcm_base, phys_tcm);
     memory_region_add_subregion(address_space_mem, 0xc0000000 + tcm_base,
                                 phys_tcm_alias);
 
     /* Physical DRAM with alias at 0xc0000000 */
-    memory_region_init_ram_nomigrate(phys_ram, NULL, "nios2.ram", ram_size, &error_abort);
+    memory_region_init_ram(phys_ram, NULL, "nios2.ram", ram_size,
+                           &error_abort);
     memory_region_init_alias(phys_ram_alias, NULL, "nios2.ram.alias",
                              phys_ram, 0, ram_size);
-    vmstate_register_ram_global(phys_ram);
     memory_region_add_subregion(address_space_mem, ram_base, phys_ram);
     memory_region_add_subregion(address_space_mem, 0xc0000000 + ram_base,
                                 phys_ram_alias);
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 73d8d7a..e1eeffc 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -119,8 +119,7 @@ static void openrisc_sim_init(MachineState *machine)
     }
 
     ram = g_malloc(sizeof(*ram));
-    memory_region_init_ram_nomigrate(ram, NULL, "openrisc.ram", ram_size, &error_fatal);
-    vmstate_register_ram_global(ram);
+    memory_region_init_ram(ram, NULL, "openrisc.ram", ram_size, &error_fatal);
     memory_region_add_subregion(get_system_memory(), 0, ram);
 
     cpu_openrisc_pic_init(cpu);
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 0b35ef1..3056d5f 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -204,9 +204,8 @@ static void ppc_core99_init(MachineState *machine)
     memory_region_add_subregion(get_system_memory(), 0, ram);
 
     /* allocate and load BIOS */
-    memory_region_init_ram_nomigrate(bios, NULL, "ppc_core99.bios", BIOS_SIZE,
+    memory_region_init_ram(bios, NULL, "ppc_core99.bios", BIOS_SIZE,
                            &error_fatal);
-    vmstate_register_ram_global(bios);
 
     if (bios_name == NULL)
         bios_name = PROM_FILENAME;
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index ac604cb..f2ae60a 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -141,9 +141,8 @@ static void ppc_heathrow_init(MachineState *machine)
     memory_region_add_subregion(sysmem, 0, ram);
 
     /* allocate and load BIOS */
-    memory_region_init_ram_nomigrate(bios, NULL, "ppc_heathrow.bios", BIOS_SIZE,
+    memory_region_init_ram(bios, NULL, "ppc_heathrow.bios", BIOS_SIZE,
                            &error_fatal);
-    vmstate_register_ram_global(bios);
 
     if (bios_name == NULL)
         bios_name = PROM_FILENAME;
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index c0146e8..e92db2c 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -218,9 +218,8 @@ static void ref405ep_init(MachineState *machine)
                         33333333, &pic, kernel_filename == NULL ? 0 : 1);
     /* allocate SRAM */
     sram_size = 512 * 1024;
-    memory_region_init_ram_nomigrate(sram, NULL, "ef405ep.sram", sram_size,
+    memory_region_init_ram(sram, NULL, "ef405ep.sram", sram_size,
                            &error_fatal);
-    vmstate_register_ram_global(sram);
     memory_region_add_subregion(sysmem, 0xFFF00000, sram);
     /* allocate and load BIOS */
 #ifdef DEBUG_BOARD_INIT
@@ -253,9 +252,8 @@ static void ref405ep_init(MachineState *machine)
         printf("Load BIOS from file\n");
 #endif
         bios = g_new(MemoryRegion, 1);
-        memory_region_init_ram_nomigrate(bios, NULL, "ef405ep.bios", BIOS_SIZE,
+        memory_region_init_ram(bios, NULL, "ef405ep.bios", BIOS_SIZE,
                                &error_fatal);
-        vmstate_register_ram_global(bios);
 
         if (bios_name == NULL)
             bios_name = BIOS_FILENAME;
@@ -554,9 +552,8 @@ static void taihu_405ep_init(MachineState *machine)
         if (bios_name == NULL)
             bios_name = BIOS_FILENAME;
         bios = g_new(MemoryRegion, 1);
-        memory_region_init_ram_nomigrate(bios, NULL, "taihu_405ep.bios", BIOS_SIZE,
+        memory_region_init_ram(bios, NULL, "taihu_405ep.bios", BIOS_SIZE,
                                &error_fatal);
-        vmstate_register_ram_global(bios);
         filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
         if (filename) {
             bios_size = load_image(filename, memory_region_get_ram_ptr(bios));
diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index d5cf07e..f6fe3e6 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -978,9 +978,8 @@ static void ppc405_ocm_init(CPUPPCState *env)
 
     ocm = g_malloc0(sizeof(ppc405_ocm_t));
     /* XXX: Size is 4096 or 0x04000000 */
-    memory_region_init_ram_nomigrate(&ocm->isarc_ram, NULL, "ppc405.ocm", 4096,
+    memory_region_init_ram(&ocm->isarc_ram, NULL, "ppc405.ocm", 4096,
                            &error_fatal);
-    vmstate_register_ram_global(&ocm->isarc_ram);
     memory_region_init_alias(&ocm->dsarc_ram, NULL, "ppc405.dsarc", &ocm->isarc_ram,
                              0, 4096);
     qemu_register_reset(&ocm_reset, ocm);
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 6e7c0ba..9253dbb 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -266,14 +266,13 @@ static void assign_storage(SCLPDevice *sclp, SCCB *sccb)
                 this_subregion_size = mhd->standby_subregion_size;
             }
 
-            memory_region_init_ram_nomigrate(standby_ram, NULL, id, this_subregion_size,
+            memory_region_init_ram(standby_ram, NULL, id, this_subregion_size,
                                    &error_fatal);
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
index 82e3b19..a0462ad 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -259,8 +259,7 @@ static void r2d_init(MachineState *machine)
     qemu_register_reset(main_cpu_reset, reset_info);
 
     /* Allocate memory space */
-    memory_region_init_ram_nomigrate(sdram, NULL, "r2d.sdram", SDRAM_SIZE, &error_fatal);
-    vmstate_register_ram_global(sdram);
+    memory_region_init_ram(sdram, NULL, "r2d.sdram", SDRAM_SIZE, &error_fatal);
     memory_region_add_subregion(address_space_mem, SDRAM_BASE, sdram);
     /* Register peripherals */
     s = sh7750_init(cpu, address_space_mem);
diff --git a/hw/sh4/shix.c b/hw/sh4/shix.c
index bf0d8c3..e22eaf0 100644
--- a/hw/sh4/shix.c
+++ b/hw/sh4/shix.c
@@ -63,17 +63,14 @@ static void shix_init(MachineState *machine)
     }
 
     /* Allocate memory space */
-    memory_region_init_ram_nomigrate(rom, NULL, "shix.rom", 0x4000, &error_fatal);
-    vmstate_register_ram_global(rom);
+    memory_region_init_ram(rom, NULL, "shix.rom", 0x4000, &error_fatal);
     memory_region_set_readonly(rom, true);
     memory_region_add_subregion(sysmem, 0x00000000, rom);
-    memory_region_init_ram_nomigrate(&sdram[0], NULL, "shix.sdram1", 0x01000000,
+    memory_region_init_ram(&sdram[0], NULL, "shix.sdram1", 0x01000000,
                            &error_fatal);
-    vmstate_register_ram_global(&sdram[0]);
     memory_region_add_subregion(sysmem, 0x08000000, &sdram[0]);
-    memory_region_init_ram_nomigrate(&sdram[1], NULL, "shix.sdram2", 0x01000000,
+    memory_region_init_ram(&sdram[1], NULL, "shix.sdram2", 0x01000000,
                            &error_fatal);
-    vmstate_register_ram_global(&sdram[1]);
     memory_region_add_subregion(sysmem, 0x0c000000, &sdram[1]);
 
     /* Load BIOS in 0 (and access it through P2, 0xA0000000) */
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 6758ba6..d5ff188 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -159,8 +159,7 @@ static void leon3_generic_hw_init(MachineState *machine)
 
     /* Allocate BIOS */
     prom_size = 8 * 1024 * 1024; /* 8Mb */
-    memory_region_init_ram_nomigrate(prom, NULL, "Leon3.bios", prom_size, &error_fatal);
-    vmstate_register_ram_global(prom);
+    memory_region_init_ram(prom, NULL, "Leon3.bios", prom_size, &error_fatal);
     memory_region_set_readonly(prom, true);
     memory_region_add_subregion(address_space_mem, 0x00000000, prom);
 
diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboard.c
index 94b185e..6c57423 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -80,24 +80,18 @@ static void tricore_testboard_init(MachineState *machine, int board_id)
         exit(1);
     }
     env = &cpu->env;
-    memory_region_init_ram_nomigrate(ext_cram, NULL, "powerlink_ext_c.ram", 2*1024*1024,
+    memory_region_init_ram(ext_cram, NULL, "powerlink_ext_c.ram",
+                           2 * 1024 * 1024, &error_fatal);
+    memory_region_init_ram(ext_dram, NULL, "powerlink_ext_d.ram",
+                           4 * 1024 * 1024, &error_fatal);
+    memory_region_init_ram(int_cram, NULL, "powerlink_int_c.ram", 48 * 1024,
                            &error_fatal);
-    vmstate_register_ram_global(ext_cram);
-    memory_region_init_ram_nomigrate(ext_dram, NULL, "powerlink_ext_d.ram", 4*1024*1024,
+    memory_region_init_ram(int_dram, NULL, "powerlink_int_d.ram", 48 * 1024,
                            &error_fatal);
-    vmstate_register_ram_global(ext_dram);
-    memory_region_init_ram_nomigrate(int_cram, NULL, "powerlink_int_c.ram", 48*1024,
-                           &error_fatal);
-    vmstate_register_ram_global(int_cram);
-    memory_region_init_ram_nomigrate(int_dram, NULL, "powerlink_int_d.ram", 48*1024,
-                           &error_fatal);
-    vmstate_register_ram_global(int_dram);
-    memory_region_init_ram_nomigrate(pcp_data, NULL, "powerlink_pcp_data.ram", 16*1024,
-                           &error_fatal);
-    vmstate_register_ram_global(pcp_data);
-    memory_region_init_ram_nomigrate(pcp_text, NULL, "powerlink_pcp_text.ram", 32*1024,
-                           &error_fatal);
-    vmstate_register_ram_global(pcp_text);
+    memory_region_init_ram(pcp_data, NULL, "powerlink_pcp_data.ram",
+                           16 * 1024, &error_fatal);
+    memory_region_init_ram(pcp_text, NULL, "powerlink_pcp_text.ram",
+                           32 * 1024, &error_fatal);
 
     memory_region_add_subregion(sysmem, 0x80000000, ext_cram);
     memory_region_add_subregion(sysmem, 0xa1000000, ext_dram);
diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
index 291d75f..e9d1a60 100644
--- a/hw/unicore32/puv3.c
+++ b/hw/unicore32/puv3.c
@@ -78,9 +78,8 @@ static void puv3_board_init(CPUUniCore32State *env, ram_addr_t ram_size)
     MemoryRegion *ram_memory = g_new(MemoryRegion, 1);
 
     /* SDRAM at address zero.  */
-    memory_region_init_ram_nomigrate(ram_memory, NULL, "puv3.ram", ram_size,
+    memory_region_init_ram(ram_memory, NULL, "puv3.ram", ram_size,
                            &error_fatal);
-    vmstate_register_ram_global(ram_memory);
     memory_region_add_subregion(get_system_memory(), 0, ram_memory);
 }
 
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 3c6447b..249cd1e 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -48,10 +48,8 @@ static void xtensa_create_memory_regions(const XtensaMemory *memory,
 
         g_string_printf(num_name, "%s%u", name, i);
         m = g_new(MemoryRegion, 1);
-        memory_region_init_ram_nomigrate(m, NULL, num_name->str,
-                               memory->location[i].size,
-                               &error_fatal);
-        vmstate_register_ram_global(m);
+        memory_region_init_ram(m, NULL, num_name->str,
+                               memory->location[i].size, &error_fatal);
         memory_region_add_subregion(get_system_memory(),
                                     memory->location[i].addr, m);
     }
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 0c91c37..635a4d4 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -249,9 +249,8 @@ static void lx_init(const LxBoardDesc *board, MachineState *machine)
     }
 
     ram = g_malloc(sizeof(*ram));
-    memory_region_init_ram_nomigrate(ram, NULL, "lx60.dram", machine->ram_size,
+    memory_region_init_ram(ram, NULL, "lx60.dram", machine->ram_size,
                            &error_fatal);
-    vmstate_register_ram_global(ram);
     memory_region_add_subregion(system_memory, 0, ram);
 
     system_io = g_malloc(sizeof(*system_io));
@@ -292,9 +291,8 @@ static void lx_init(const LxBoardDesc *board, MachineState *machine)
         uint32_t cur_lowmem = QEMU_ALIGN_UP(lowmem_end / 2, 4096);
 
         rom = g_malloc(sizeof(*rom));
-        memory_region_init_ram_nomigrate(rom, NULL, "lx60.sram", board->sram_size,
+        memory_region_init_ram(rom, NULL, "lx60.sram", board->sram_size,
                                &error_fatal);
-        vmstate_register_ram_global(rom);
         memory_region_add_subregion(system_memory, 0xfe000000, rom);
 
         if (kernel_cmdline) {
-- 
2.7.4
