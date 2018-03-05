Received: from eggs.gnu.org ([2001:4830:134:3::10]:41319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esoHe-0003Q8-6e
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:28:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esoHb-0006vb-Uh
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:27:58 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  5 Mar 2018 08:27:09 -0300
Message-Id: <20180305112732.26471-8-f4bug@amsat.org>
In-Reply-To: <20180305112732.26471-1-f4bug@amsat.org>
References: <20180305112732.26471-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 07/30] hw/arm: use the BYTE-based definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Antony Pavlov <antonynpavlov@gmail.com>, Andrzej Zaborowski <balrogg@gmail.com>, Jan Kiszka <jan.kiszka@web.de>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, Peter Chubb <peter.chubb@nicta.com.au>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 include/hw/arm/stm32f205_soc.h |  4 ++--
 hw/arm/boot.c                  |  6 +++---
 hw/arm/collie.c                |  4 ++--
 hw/arm/digic_boards.c          |  6 +++---
 hw/arm/gumstix.c               |  2 +-
 hw/arm/integratorcp.c          |  2 +-
 hw/arm/mainstone.c             |  2 +-
 hw/arm/musicpal.c              |  8 ++++----
 hw/arm/omap_sx1.c              |  8 ++++----
 hw/arm/raspi.c                 |  4 ++--
 hw/arm/stellaris.c             |  4 ++--
 hw/arm/versatilepb.c           |  4 ++--
 hw/arm/vexpress.c              |  6 +++---
 hw/arm/virt.c                  |  4 ++--
 hw/arm/xilinx_zynq.c           |  4 ++--
 hw/misc/aspeed_sdmc.c          |  8 ++++----
 hw/misc/imx7_gpr.c             |  2 +-
 hw/misc/omap_gpmc.c            |  4 ++--
 hw/ssi/aspeed_smc.c            | 28 ++++++++++++++--------------
 19 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/include/hw/arm/stm32f205_soc.h b/include/hw/arm/stm32f205_soc.h
index 922a733f88..e30ae33c65 100644
--- a/include/hw/arm/stm32f205_soc.h
+++ b/include/hw/arm/stm32f205_soc.h
@@ -43,9 +43,9 @@
 #define STM_NUM_SPIS 3
 
 #define FLASH_BASE_ADDRESS 0x08000000
-#define FLASH_SIZE (1024 * 1024)
+#define FLASH_SIZE (1 * M_BYTE)
 #define SRAM_BASE_ADDRESS 0x20000000
-#define SRAM_SIZE (128 * 1024)
+#define SRAM_SIZE (128 * K_BYTE)
 
 typedef struct STM32F205State {
     /*< private >*/
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 6d0c92ab88..51df96a6c8 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -1015,7 +1015,7 @@ static void arm_load_kernel_notify(Notifier *notifier, void *data)
      * the initrd at 128MB.
      */
     info->initrd_start = info->loader_start +
-        MIN(info->ram_size / 2, 128 * 1024 * 1024);
+        MIN(info->ram_size / 2, 128 * M_BYTE);
 
     /* Assume that raw images are linux kernels, and ELF images are not.  */
     kernel_size = arm_load_elf(info, &elf_entry, &elf_low_addr,
@@ -1102,13 +1102,13 @@ static void arm_load_kernel_notify(Notifier *notifier, void *data)
                  *
                  * Let's play safe and prealign it to 2MB to give us some space.
                  */
-                align = 2 * 1024 * 1024;
+                align = 2 * M_BYTE;
             } else {
                 /*
                  * Some 32bit kernels will trash anything in the 4K page the
                  * initrd ends in, so make sure the DTB isn't caught up in that.
                  */
-                align = 4096;
+                align = 4 * K_BYTE;
             }
 
             /* Place the DTB after the initrd in memory with alignment. */
diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index f8c566e2e5..1695863629 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -39,12 +39,12 @@ static void collie_init(MachineState *machine)
     dinfo = drive_get(IF_PFLASH, 0, 0);
     pflash_cfi01_register(SA_CS0, NULL, "collie.fl1", 0x02000000,
                     dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                    (64 * 1024), 512, 4, 0x00, 0x00, 0x00, 0x00, 0);
+                    64 * K_BYTE, 512, 4, 0x00, 0x00, 0x00, 0x00, 0);
 
     dinfo = drive_get(IF_PFLASH, 0, 1);
     pflash_cfi01_register(SA_CS1, NULL, "collie.fl2", 0x02000000,
                     dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                    (64 * 1024), 512, 4, 0x00, 0x00, 0x00, 0x00, 0);
+                    64 * K_BYTE, 512, 4, 0x00, 0x00, 0x00, 0x00, 0);
 
     sysbus_create_simple("scoop", 0x40800000, NULL);
 
diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index 9f11dcd11f..04e52e776f 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -126,8 +126,8 @@ static void digic_load_rom(DigicBoardState *s, hwaddr addr,
 static void digic4_add_k8p3215uqb_rom(DigicBoardState *s, hwaddr addr,
                                       const char *def_filename)
 {
-#define FLASH_K8P3215UQB_SIZE (4 * 1024 * 1024)
-#define FLASH_K8P3215UQB_SECTOR_SIZE (64 * 1024)
+#define FLASH_K8P3215UQB_SIZE (4 * M_BYTE)
+#define FLASH_K8P3215UQB_SECTOR_SIZE (64 * K_BYTE)
 
     pflash_cfi02_register(addr, NULL, "pflash", FLASH_K8P3215UQB_SIZE,
                           NULL, FLASH_K8P3215UQB_SECTOR_SIZE,
@@ -141,7 +141,7 @@ static void digic4_add_k8p3215uqb_rom(DigicBoardState *s, hwaddr addr,
 }
 
 static DigicBoard digic4_board_canon_a1100 = {
-    .ram_size = 64 * 1024 * 1024,
+    .ram_size = 64 * M_BYTE,
     .add_rom1 = digic4_add_k8p3215uqb_rom,
     .rom1_def_filename = "canon-a1100-rom1.bin",
 };
diff --git a/hw/arm/gumstix.c b/hw/arm/gumstix.c
index ea2a3c532d..fc15df1d12 100644
--- a/hw/arm/gumstix.c
+++ b/hw/arm/gumstix.c
@@ -47,7 +47,7 @@
 #include "sysemu/qtest.h"
 #include "cpu.h"
 
-static const int sector_len = 128 * 1024;
+static const int sector_len = 128 * K_BYTE;
 
 static void connex_init(MachineState *machine)
 {
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index e8303b83be..4e711194ef 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -609,7 +609,7 @@ static void integratorcp_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, 0x80000000, ram_alias);
 
     dev = qdev_create(NULL, TYPE_INTEGRATOR_CM);
-    qdev_prop_set_uint32(dev, "memsz", ram_size >> 20);
+    qdev_prop_set_uint32(dev, "memsz", ram_size / M_BYTE);
     qdev_init_nofail(dev);
     sysbus_mmio_map((SysBusDevice *)dev, 0, 0x10000000);
 
diff --git a/hw/arm/mainstone.c b/hw/arm/mainstone.c
index 4215c025fc..37c21ed6d0 100644
--- a/hw/arm/mainstone.c
+++ b/hw/arm/mainstone.c
@@ -115,7 +115,7 @@ static void mainstone_common_init(MemoryRegion *address_space_mem,
                                   MachineState *machine,
                                   enum mainstone_model_e model, int arm_id)
 {
-    uint32_t sector_len = 256 * 1024;
+    uint32_t sector_len = 256 * K_BYTE;
     hwaddr mainstone_flash_base[] = { MST_FLASH_0, MST_FLASH_1 };
     PXA2xxState *mpu;
     DeviceState *mst_irq;
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 38d7322a19..d6d1ce75c5 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -62,8 +62,8 @@
 #define MP_SRAM_BASE            0xC0000000
 #define MP_SRAM_SIZE            0x00020000
 
-#define MP_RAM_DEFAULT_SIZE     32*1024*1024
-#define MP_FLASH_SIZE_MAX       32*1024*1024
+#define MP_RAM_DEFAULT_SIZE     (32 * M_BYTE)
+#define MP_FLASH_SIZE_MAX       (32 * M_BYTE)
 
 #define MP_TIMER1_IRQ           4
 #define MP_TIMER2_IRQ           5
@@ -1625,8 +1625,8 @@ static void musicpal_init(MachineState *machine)
         BlockBackend *blk = blk_by_legacy_dinfo(dinfo);
 
         flash_size = blk_getlength(blk);
-        if (flash_size != 8*1024*1024 && flash_size != 16*1024*1024 &&
-            flash_size != 32*1024*1024) {
+        if (flash_size != 8 * M_BYTE && flash_size != 16 * M_BYTE &&
+            flash_size != 32 * M_BYTE) {
             error_report("Invalid flash image size");
             exit(1);
         }
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index eccc19c77b..729af8bb80 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -88,10 +88,10 @@ static const MemoryRegionOps static_ops = {
 };
 
 #define sdram_size	0x02000000
-#define sector_size	(128 * 1024)
-#define flash0_size	(16 * 1024 * 1024)
-#define flash1_size	( 8 * 1024 * 1024)
-#define flash2_size	(32 * 1024 * 1024)
+#define sector_size (128 * K_BYTE)
+#define flash0_size (16 * M_BYTE)
+#define flash1_size (8 * M_BYTE)
+#define flash2_size (32 * M_BYTE)
 #define total_ram_v1	(sdram_size + flash0_size + flash1_size + OMAP15XX_SRAM_SIZE)
 #define total_ram_v2	(sdram_size + flash2_size + OMAP15XX_SRAM_SIZE)
 
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index a37881433c..4b54fa5ad4 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -183,7 +183,7 @@ static void raspi2_machine_init(MachineClass *mc)
     mc->max_cpus = BCM2836_NCPUS;
     mc->min_cpus = BCM2836_NCPUS;
     mc->default_cpus = BCM2836_NCPUS;
-    mc->default_ram_size = 1024 * 1024 * 1024;
+    mc->default_ram_size = 1 * G_BYTE;
     mc->ignore_memory_transaction_failures = true;
 };
 DEFINE_MACHINE("raspi2", raspi2_machine_init)
@@ -206,7 +206,7 @@ static void raspi3_machine_init(MachineClass *mc)
     mc->max_cpus = BCM2836_NCPUS;
     mc->min_cpus = BCM2836_NCPUS;
     mc->default_cpus = BCM2836_NCPUS;
-    mc->default_ram_size = 1024 * 1024 * 1024;
+    mc->default_ram_size = 1 * G_BYTE;
 }
 DEFINE_MACHINE("raspi3", raspi3_machine_init)
 #endif
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index de7c0fc4a6..8ff7567126 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1284,8 +1284,8 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     MemoryRegion *flash = g_new(MemoryRegion, 1);
     MemoryRegion *system_memory = get_system_memory();
 
-    flash_size = (((board->dc0 & 0xffff) + 1) << 1) * 1024;
-    sram_size = ((board->dc0 >> 18) + 1) * 1024;
+    flash_size = (((board->dc0 & 0xffff) + 1) << 1) * K_BYTE;
+    sram_size = ((board->dc0 >> 18) + 1) * K_BYTE;
 
     /* Flash programming is done via the SCU, so pretend it is ROM.  */
     memory_region_init_ram(flash, NULL, "stellaris.flash", flash_size,
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 418792cd02..041f12beb7 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -26,8 +26,8 @@
 #include "hw/char/pl011.h"
 
 #define VERSATILE_FLASH_ADDR 0x34000000
-#define VERSATILE_FLASH_SIZE (64 * 1024 * 1024)
-#define VERSATILE_FLASH_SECT_SIZE (256 * 1024)
+#define VERSATILE_FLASH_SIZE (64 * M_BYTE)
+#define VERSATILE_FLASH_SECT_SIZE (256 * K_BYTE)
 
 /* Primary interrupt controller.  */
 
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 9fad79177a..7b12dfca41 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -45,8 +45,8 @@
 #include "hw/cpu/a15mpcore.h"
 
 #define VEXPRESS_BOARD_ID 0x8e0
-#define VEXPRESS_FLASH_SIZE (64 * 1024 * 1024)
-#define VEXPRESS_FLASH_SECT_SIZE (256 * 1024)
+#define VEXPRESS_FLASH_SIZE (64 * M_BYTE)
+#define VEXPRESS_FLASH_SECT_SIZE (256 * K_BYTE)
 
 /* Number of virtio transports to create (0..8; limited by
  * number of available IRQ lines).
@@ -355,7 +355,7 @@ static void a15_daughterboard_init(const VexpressMachineState *vms,
          * warning if we are on a host where ram_addr_t is 32 bits.
          */
         uint64_t rsz = ram_size;
-        if (rsz > (30ULL * 1024 * 1024 * 1024)) {
+        if (rsz > 30 * G_BYTE) {
             error_report("vexpress-a15: cannot model more than 30GB RAM");
             exit(1);
         }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index dbb3c8036a..8202a428e0 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -110,7 +110,7 @@ static ARMPlatformBusSystemParams platform_bus_params;
  * terabyte of physical address space.)
  */
 #define RAMLIMIT_GB 255
-#define RAMLIMIT_BYTES (RAMLIMIT_GB * 1024ULL * 1024 * 1024)
+#define RAMLIMIT_BYTES (RAMLIMIT_GB * G_BYTE)
 
 /* Addresses and sizes of our components.
  * 0..128MB is space for a flash device so we can run bootrom code such as UEFI.
@@ -783,7 +783,7 @@ static void create_one_flash(const char *name, hwaddr flashbase,
     DriveInfo *dinfo = drive_get_next(IF_PFLASH);
     DeviceState *dev = qdev_create(NULL, "cfi.pflash01");
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    const uint64_t sectorlength = 256 * 1024;
+    const uint64_t sectorlength = 256 * K_BYTE;
 
     if (dinfo) {
         qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo),
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 0f76333770..7a68503e68 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -40,8 +40,8 @@
 #define NUM_QSPI_FLASHES 2
 #define NUM_QSPI_BUSSES 2
 
-#define FLASH_SIZE (64 * 1024 * 1024)
-#define FLASH_SECTOR_SIZE (128 * 1024)
+#define FLASH_SIZE (64 * M_BYTE)
+#define FLASH_SECTOR_SIZE (128 * K_BYTE)
 
 #define IRQ_OFFSET 32 /* pic interrupts start from index 32 */
 
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 0df008e52a..eaf090b7b1 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -149,7 +149,7 @@ static const MemoryRegionOps aspeed_sdmc_ops = {
 
 static int ast2400_rambits(AspeedSDMCState *s)
 {
-    switch (s->ram_size >> 20) {
+    switch (s->ram_size / M_BYTE) {
     case 64:
         return ASPEED_SDMC_DRAM_64MB;
     case 128:
@@ -165,13 +165,13 @@ static int ast2400_rambits(AspeedSDMCState *s)
     /* use a common default */
     warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 256M",
                 s->ram_size);
-    s->ram_size = 256 << 20;
+    s->ram_size = 256 * M_BYTE;
     return ASPEED_SDMC_DRAM_256MB;
 }
 
 static int ast2500_rambits(AspeedSDMCState *s)
 {
-    switch (s->ram_size >> 20) {
+    switch (s->ram_size / M_BYTE) {
     case 128:
         return ASPEED_SDMC_AST2500_128MB;
     case 256:
@@ -187,7 +187,7 @@ static int ast2500_rambits(AspeedSDMCState *s)
     /* use a common default */
     warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 512M",
                 s->ram_size);
-    s->ram_size = 512 << 20;
+    s->ram_size = 512 * M_BYTE;
     return ASPEED_SDMC_AST2500_512MB;
 }
 
diff --git a/hw/misc/imx7_gpr.c b/hw/misc/imx7_gpr.c
index c2a9df29c6..3d46bdbd09 100644
--- a/hw/misc/imx7_gpr.c
+++ b/hw/misc/imx7_gpr.c
@@ -98,7 +98,7 @@ static void imx7_gpr_init(Object *obj)
     IMX7GPRState *s = IMX7_GPR(obj);
 
     memory_region_init_io(&s->mmio, obj, &imx7_gpr_ops, s,
-                          TYPE_IMX7_GPR, 64 * 1024);
+                          TYPE_IMX7_GPR, 64 * K_BYTE);
     sysbus_init_mmio(sd, &s->mmio);
 }
 
diff --git a/hw/misc/omap_gpmc.c b/hw/misc/omap_gpmc.c
index 84f9e4c612..af6b620e3e 100644
--- a/hw/misc/omap_gpmc.c
+++ b/hw/misc/omap_gpmc.c
@@ -850,11 +850,11 @@ struct omap_gpmc_s *omap_gpmc_init(struct omap_mpu_state_s *mpu,
                               &omap_nand_ops,
                               &s->cs_file[cs],
                               "omap-nand",
-                              256 * 1024 * 1024);
+                              256 * M_BYTE);
     }
 
     memory_region_init_io(&s->prefetch.iomem, NULL, &omap_prefetch_ops, s,
-                          "omap-gpmc-prefetch", 256 * 1024 * 1024);
+                          "omap-gpmc-prefetch", 256 * M_BYTE);
     return s;
 }
 
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 5059396bc6..b51cb6c0a9 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -149,35 +149,35 @@
  * Segment Address Registers.
  */
 static const AspeedSegments aspeed_segments_legacy[] = {
-    { 0x10000000, 32 * 1024 * 1024 },
+    { 0x10000000, 32 * M_BYTE },
 };
 
 static const AspeedSegments aspeed_segments_fmc[] = {
-    { 0x20000000, 64 * 1024 * 1024 }, /* start address is readonly */
-    { 0x24000000, 32 * 1024 * 1024 },
-    { 0x26000000, 32 * 1024 * 1024 },
-    { 0x28000000, 32 * 1024 * 1024 },
-    { 0x2A000000, 32 * 1024 * 1024 }
+    { 0x20000000,  64 * M_BYTE }, /* start address is readonly */
+    { 0x24000000,  32 * M_BYTE },
+    { 0x26000000,  32 * M_BYTE },
+    { 0x28000000,  32 * M_BYTE },
+    { 0x2A000000,  32 * M_BYTE }
 };
 
 static const AspeedSegments aspeed_segments_spi[] = {
-    { 0x30000000, 64 * 1024 * 1024 },
+    { 0x30000000,  64 * M_BYTE },
 };
 
 static const AspeedSegments aspeed_segments_ast2500_fmc[] = {
-    { 0x20000000, 128 * 1024 * 1024 }, /* start address is readonly */
-    { 0x28000000,  32 * 1024 * 1024 },
-    { 0x2A000000,  32 * 1024 * 1024 },
+    { 0x20000000, 128 * M_BYTE }, /* start address is readonly */
+    { 0x28000000,  32 * M_BYTE },
+    { 0x2A000000,  32 * M_BYTE },
 };
 
 static const AspeedSegments aspeed_segments_ast2500_spi1[] = {
-    { 0x30000000, 32 * 1024 * 1024 }, /* start address is readonly */
-    { 0x32000000, 96 * 1024 * 1024 }, /* end address is readonly */
+    { 0x30000000,  32 * M_BYTE }, /* start address is readonly */
+    { 0x32000000,  96 * M_BYTE }, /* end address is readonly */
 };
 
 static const AspeedSegments aspeed_segments_ast2500_spi2[] = {
-    { 0x38000000, 32 * 1024 * 1024 }, /* start address is readonly */
-    { 0x3A000000, 96 * 1024 * 1024 }, /* end address is readonly */
+    { 0x38000000,  32 * M_BYTE }, /* start address is readonly */
+    { 0x3A000000,  96 * M_BYTE }, /* end address is readonly */
 };
 
 static const AspeedSMCController controllers[] = {
-- 
2.16.2
