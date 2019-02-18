Received: from eggs.gnu.org ([209.51.188.92]:44571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gviTU-0008Dj-2z
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:56:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gviTP-0000r7-FJ
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:56:42 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 18 Feb 2019 13:56:13 +0100
Message-Id: <20190218125615.18970-9-armbru@redhat.com>
In-Reply-To: <20190218125615.18970-1-armbru@redhat.com>
References: <20190218125615.18970-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 08/10] pflash: Clean up after commit
 368a354f02b part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-ppc@nongnu.org

QOMification left parameter @qdev unused in pflash_cfi01_register()
and pflash_cfi02_register().  All callers pass NULL.  Remove.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/arm/collie.c                          | 4 ++--
 hw/arm/digic_boards.c                    | 2 +-
 hw/arm/gumstix.c                         | 4 ++--
 hw/arm/mainstone.c                       | 2 +-
 hw/arm/musicpal.c                        | 4 ++--
 hw/arm/omap_sx1.c                        | 4 ++--
 hw/arm/versatilepb.c                     | 2 +-
 hw/arm/xilinx_zynq.c                     | 2 +-
 hw/arm/z2.c                              | 3 +--
 hw/block/pflash_cfi01.c                  | 2 +-
 hw/block/pflash_cfi02.c                  | 2 +-
 hw/i386/pc_sysfw.c                       | 2 +-
 hw/lm32/lm32_boards.c                    | 4 ++--
 hw/lm32/milkymist.c                      | 2 +-
 hw/microblaze/petalogix_ml605_mmu.c      | 3 +--
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 2 +-
 hw/mips/mips_malta.c                     | 2 +-
 hw/mips/mips_r4k.c                       | 2 +-
 hw/ppc/ppc405_boards.c                   | 6 +++---
 hw/ppc/sam460ex.c                        | 2 +-
 hw/ppc/virtex_ml507.c                    | 2 +-
 hw/sh4/r2d.c                             | 2 +-
 include/hw/block/flash.h                 | 4 ++--
 23 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index 48b732c176..cbc4400f8e 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -36,12 +36,12 @@ static void collie_init(MachineState *machine)
     s = sa1110_init(sysmem, collie_binfo.ram_size, machine->cpu_type);
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
-    pflash_cfi01_register(SA_CS0, NULL, "collie.fl1", 0x02000000,
+    pflash_cfi01_register(SA_CS0, "collie.fl1", 0x02000000,
                     dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                     (64 * 1024), 512, 4, 0x00, 0x00, 0x00, 0x00, 0);
 
     dinfo = drive_get(IF_PFLASH, 0, 1);
-    pflash_cfi01_register(SA_CS1, NULL, "collie.fl2", 0x02000000,
+    pflash_cfi01_register(SA_CS1, "collie.fl2", 0x02000000,
                     dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                     (64 * 1024), 512, 4, 0x00, 0x00, 0x00, 0x00, 0);
 
diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index 9f11dcd11f..15a00a1be3 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -129,7 +129,7 @@ static void digic4_add_k8p3215uqb_rom(DigicBoardState *s, hwaddr addr,
 #define FLASH_K8P3215UQB_SIZE (4 * 1024 * 1024)
 #define FLASH_K8P3215UQB_SECTOR_SIZE (64 * 1024)
 
-    pflash_cfi02_register(addr, NULL, "pflash", FLASH_K8P3215UQB_SIZE,
+    pflash_cfi02_register(addr, "pflash", FLASH_K8P3215UQB_SIZE,
                           NULL, FLASH_K8P3215UQB_SECTOR_SIZE,
                           FLASH_K8P3215UQB_SIZE / FLASH_K8P3215UQB_SECTOR_SIZE,
                           DIGIC4_ROM_MAX_SIZE / FLASH_K8P3215UQB_SIZE,
diff --git a/hw/arm/gumstix.c b/hw/arm/gumstix.c
index 56cb763c4e..304dbeab2f 100644
--- a/hw/arm/gumstix.c
+++ b/hw/arm/gumstix.c
@@ -72,7 +72,7 @@ static void connex_init(MachineState *machine)
 #else
     be = 0;
 #endif
-    if (!pflash_cfi01_register(0x00000000, NULL, "connext.rom", connex_rom,
+    if (!pflash_cfi01_register(0x00000000, "connext.rom", connex_rom,
                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                                sector_len, connex_rom / sector_len,
                                2, 0, 0, 0, 0, be)) {
@@ -109,7 +109,7 @@ static void verdex_init(MachineState *machine)
 #else
     be = 0;
 #endif
-    if (!pflash_cfi01_register(0x00000000, NULL, "verdex.rom", verdex_rom,
+    if (!pflash_cfi01_register(0x00000000, "verdex.rom", verdex_rom,
                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                                sector_len, verdex_rom / sector_len,
                                2, 0, 0, 0, 0, be)) {
diff --git a/hw/arm/mainstone.c b/hw/arm/mainstone.c
index 0beb5c426b..2a1c1072db 100644
--- a/hw/arm/mainstone.c
+++ b/hw/arm/mainstone.c
@@ -148,7 +148,7 @@ static void mainstone_common_init(MemoryRegion *address_space_mem,
             exit(1);
         }
 
-        if (!pflash_cfi01_register(mainstone_flash_base[i], NULL,
+        if (!pflash_cfi01_register(mainstone_flash_base[i],
                                    i ? "mainstone.flash1" : "mainstone.flash0",
                                    MAINSTONE_FLASH,
                                    blk_by_legacy_dinfo(dinfo),
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index d22532a11c..ecca0e6f64 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1636,14 +1636,14 @@ static void musicpal_init(MachineState *machine)
          * image is smaller than 32 MB.
          */
 #ifdef TARGET_WORDS_BIGENDIAN
-        pflash_cfi02_register(0x100000000ULL-MP_FLASH_SIZE_MAX, NULL,
+        pflash_cfi02_register(0x100000000ULL-MP_FLASH_SIZE_MAX,
                               "musicpal.flash", flash_size,
                               blk, 0x10000, (flash_size + 0xffff) >> 16,
                               MP_FLASH_SIZE_MAX / flash_size,
                               2, 0x00BF, 0x236D, 0x0000, 0x0000,
                               0x5555, 0x2AAA, 1);
 #else
-        pflash_cfi02_register(0x100000000ULL-MP_FLASH_SIZE_MAX, NULL,
+        pflash_cfi02_register(0x100000000ULL-MP_FLASH_SIZE_MAX,
                               "musicpal.flash", flash_size,
                               blk, 0x10000, (flash_size + 0xffff) >> 16,
                               MP_FLASH_SIZE_MAX / flash_size,
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index 84550f0236..b1128777cf 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -152,7 +152,7 @@ static void sx1_init(MachineState *machine, const int version)
 #endif
 
     if ((dinfo = drive_get(IF_PFLASH, 0, fl_idx)) != NULL) {
-        if (!pflash_cfi01_register(OMAP_CS0_BASE, NULL,
+        if (!pflash_cfi01_register(OMAP_CS0_BASE,
                                    "omap_sx1.flash0-1", flash_size,
                                    blk_by_legacy_dinfo(dinfo),
                                    sector_size, flash_size / sector_size,
@@ -176,7 +176,7 @@ static void sx1_init(MachineState *machine, const int version)
         memory_region_add_subregion(address_space,
                                 OMAP_CS1_BASE + flash1_size, &cs[1]);
 
-        if (!pflash_cfi01_register(OMAP_CS1_BASE, NULL,
+        if (!pflash_cfi01_register(OMAP_CS1_BASE,
                                    "omap_sx1.flash1-1", flash1_size,
                                    blk_by_legacy_dinfo(dinfo),
                                    sector_size, flash1_size / sector_size,
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 22b09a1e61..82c5277462 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -365,7 +365,7 @@ static void versatile_init(MachineState *machine, int board_id)
     /* 0x34000000 NOR Flash */
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
-    if (!pflash_cfi01_register(VERSATILE_FLASH_ADDR, NULL, "versatile.flash",
+    if (!pflash_cfi01_register(VERSATILE_FLASH_ADDR, "versatile.flash",
                           VERSATILE_FLASH_SIZE,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                           VERSATILE_FLASH_SECT_SIZE,
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 57497b0c4d..1fa4a77728 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -205,7 +205,7 @@ static void zynq_init(MachineState *machine)
     DriveInfo *dinfo = drive_get(IF_PFLASH, 0, 0);
 
     /* AMD */
-    pflash_cfi02_register(0xe2000000, NULL, "zynq.pflash", FLASH_SIZE,
+    pflash_cfi02_register(0xe2000000, "zynq.pflash", FLASH_SIZE,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                           FLASH_SECTOR_SIZE,
                           FLASH_SIZE/FLASH_SECTOR_SIZE, 1,
diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index 697a822f1e..54e6caee9f 100644
--- a/hw/arm/z2.c
+++ b/hw/arm/z2.c
@@ -324,8 +324,7 @@ static void z2_init(MachineState *machine)
         exit(1);
     }
 
-    if (!pflash_cfi01_register(Z2_FLASH_BASE,
-                               NULL, "z2.flash0", Z2_FLASH_SIZE,
+    if (!pflash_cfi01_register(Z2_FLASH_BASE, "z2.flash0", Z2_FLASH_SIZE,
                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                                sector_len, Z2_FLASH_SIZE / sector_len,
                                4, 0, 0, 0, 0, be)) {
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 43dbb7db26..f2a4b16a34 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -921,7 +921,7 @@ static void pflash_cfi01_register_types(void)
 type_init(pflash_cfi01_register_types)
 
 PFlashCFI01 *pflash_cfi01_register(hwaddr base,
-                                   DeviceState *qdev, const char *name,
+                                   const char *name,
                                    hwaddr size,
                                    BlockBackend *blk,
                                    uint32_t sector_len, int nb_blocs,
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index e9c76d6cfb..73491aafe6 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -717,7 +717,7 @@ static void pflash_cfi02_register_types(void)
 type_init(pflash_cfi02_register_types)
 
 PFlashCFI02 *pflash_cfi02_register(hwaddr base,
-                                   DeviceState *qdev, const char *name,
+                                   const char *name,
                                    hwaddr size,
                                    BlockBackend *blk,
                                    uint32_t sector_len, int nb_blocs,
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 67e55342f6..9a5be54a85 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -160,7 +160,7 @@ static void pc_system_flash_init(MemoryRegion *rom_memory)
 
         /* pflash_cfi01_register() creates a deep copy of the name */
         snprintf(name, sizeof name, "system.flash%d", unit);
-        system_flash = pflash_cfi01_register(phys_addr, NULL /* qdev */, name,
+        system_flash = pflash_cfi01_register(phys_addr, name,
                                              size, blk, sector_size,
                                              size >> sector_bits,
                                              1      /* width */,
diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
index 05157f8eab..f726355309 100644
--- a/hw/lm32/lm32_boards.c
+++ b/hw/lm32/lm32_boards.c
@@ -114,7 +114,7 @@ static void lm32_evr_init(MachineState *machine)
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
     /* Spansion S29NS128P */
-    pflash_cfi02_register(flash_base, NULL, "lm32_evr.flash", flash_size,
+    pflash_cfi02_register(flash_base, "lm32_evr.flash", flash_size,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                           flash_sector_size, flash_size / flash_sector_size,
                           1, 2, 0x01, 0x7e, 0x43, 0x00, 0x555, 0x2aa, 1);
@@ -207,7 +207,7 @@ static void lm32_uclinux_init(MachineState *machine)
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
     /* Spansion S29NS128P */
-    pflash_cfi02_register(flash_base, NULL, "lm32_uclinux.flash", flash_size,
+    pflash_cfi02_register(flash_base, "lm32_uclinux.flash", flash_size,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                           flash_sector_size, flash_size / flash_sector_size,
                           1, 2, 0x01, 0x7e, 0x43, 0x00, 0x555, 0x2aa, 1);
diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
index b080cf1ca9..ece7e3b699 100644
--- a/hw/lm32/milkymist.c
+++ b/hw/lm32/milkymist.c
@@ -121,7 +121,7 @@ milkymist_init(MachineState *machine)
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
     /* Numonyx JS28F256J3F105 */
-    pflash_cfi01_register(flash_base, NULL, "milkymist.flash", flash_size,
+    pflash_cfi01_register(flash_base, "milkymist.flash", flash_size,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                           flash_sector_size, flash_size / flash_sector_size,
                           2, 0x00, 0x89, 0x00, 0x1d, 1);
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index c730878d25..74bcc14cda 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -107,8 +107,7 @@ petalogix_ml605_init(MachineState *machine)
     dinfo = drive_get(IF_PFLASH, 0, 0);
     /* 5th parameter 2 means bank-width
      * 10th paremeter 0 means little-endian */
-    pflash_cfi01_register(FLASH_BASEADDR,
-                          NULL, "petalogix_ml605.flash", FLASH_SIZE,
+    pflash_cfi01_register(FLASH_BASEADDR, "petalogix_ml605.flash", FLASH_SIZE,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                           64 * KiB, FLASH_SIZE >> 16,
                           2, 0x89, 0x18, 0x0000, 0x0, 0);
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index b9f0b0d06e..a07b7f8edf 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -88,7 +88,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
     pflash_cfi01_register(FLASH_BASEADDR,
-                          NULL, "petalogix_s3adsp1800.flash", FLASH_SIZE,
+                          "petalogix_s3adsp1800.flash", FLASH_SIZE,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                           64 * KiB, FLASH_SIZE >> 16,
                           1, 0x89, 0x18, 0x0000, 0x0, 1);
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 65cdda4881..76b81b7402 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1273,7 +1273,7 @@ void mips_malta_init(MachineState *machine)
                blk_name(dinfo->bdrv), fl_sectors);
     }
 #endif
-    fl = pflash_cfi01_register(FLASH_ADDRESS, NULL, "mips_malta.bios",
+    fl = pflash_cfi01_register(FLASH_ADDRESS, "mips_malta.bios",
                                FLASH_SIZE,
                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                                65536, fl_sectors,
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index a015a6d14e..0b9df466e7 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -235,7 +235,7 @@ void mips_r4k_init(MachineState *machine)
         load_image_targphys(filename, 0x1fc00000, BIOS_SIZE);
     } else if ((dinfo = drive_get(IF_PFLASH, 0, 0)) != NULL) {
         uint32_t mips_rom = 0x00400000;
-        if (!pflash_cfi01_register(0x1fc00000, NULL, "mips_r4k.bios", mips_rom,
+        if (!pflash_cfi01_register(0x1fc00000, "mips_r4k.bios", mips_rom,
                                    blk_by_legacy_dinfo(dinfo),
                                    sector_len, mips_rom / sector_len,
                                    4, 0, 0, 0, 0, be)) {
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index 728154aebb..a54627903d 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -193,7 +193,7 @@ static void ref405ep_init(MachineState *machine)
 #endif
         bios_size = 0x80000;
         pflash_cfi02_register(0xFFF80000,
-                              NULL, "ef405ep.bios", bios_size,
+                              "ef405ep.bios", bios_size,
                               dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                               65536, bios_size / 65536, 1,
                               2, 0x0001, 0x22DA, 0x0000, 0x0000, 0x555, 0x2AA,
@@ -484,7 +484,7 @@ static void taihu_405ep_init(MachineState *machine)
 #endif
         bios_size = 2 * MiB;
         pflash_cfi02_register(0xFFE00000,
-                              NULL, "taihu_405ep.bios", bios_size,
+                              "taihu_405ep.bios", bios_size,
                               dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                               65536, bios_size / 65536, 1,
                               4, 0x0001, 0x22DA, 0x0000, 0x0000, 0x555, 0x2AA,
@@ -526,7 +526,7 @@ static void taihu_405ep_init(MachineState *machine)
 #ifdef DEBUG_BOARD_INIT
         printf("Register application flash\n"
 #endif
-        pflash_cfi02_register(0xfc000000, NULL, "taihu_405ep.flash", bios_size,
+        pflash_cfi02_register(0xfc000000, "taihu_405ep.flash", bios_size,
                               dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                               65536, bios_size / 65536, 1,
                               4, 0x0001, 0x22DA, 0x0000, 0x0000, 0x555, 0x2AA,
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index ca8d7ab9c6..a989a8c439 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -95,7 +95,7 @@ static int sam460ex_load_uboot(void)
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
     if (!pflash_cfi01_register(FLASH_BASE | ((hwaddr)FLASH_BASE_H << 32),
-                               NULL, "sam460ex.flash", FLASH_SIZE,
+                               "sam460ex.flash", FLASH_SIZE,
                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                                65536, FLASH_SIZE / 65536,
                                1, 0x89, 0x18, 0x0000, 0x0, 1)) {
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 5a711cb3d9..d2085a839c 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -227,7 +227,7 @@ static void virtex_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, ram_base, phys_ram);
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
-    pflash_cfi01_register(PFLASH_BASEADDR, NULL, "virtex.flash", FLASH_SIZE,
+    pflash_cfi01_register(PFLASH_BASEADDR, "virtex.flash", FLASH_SIZE,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                           64 * KiB, FLASH_SIZE >> 16,
                           1, 0x89, 0x18, 0x0000, 0x0, 1);
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index ed18d1f351..abd3b67c28 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -297,7 +297,7 @@ static void r2d_init(MachineState *machine)
      * FLASH_SIZE / 4 bytes anyway.  The current code does so too, but
      * whether it's the right size is anybody's guess.
      */
-    pflash_cfi02_register(0x0, NULL, "r2d.flash", FLASH_SIZE / 4,
+    pflash_cfi02_register(0x0, "r2d.flash", FLASH_SIZE / 4,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                           16 * KiB, FLASH_SIZE >> 16,
                           1, 4, 0x0000, 0x0000, 0x0000, 0x0000,
diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
index 1078dc7238..464a72f11b 100644
--- a/include/hw/block/flash.h
+++ b/include/hw/block/flash.h
@@ -14,7 +14,7 @@
 typedef struct PFlashCFI01 PFlashCFI01;
 
 PFlashCFI01 *pflash_cfi01_register(hwaddr base,
-                                   DeviceState *qdev, const char *name,
+                                   const char *name,
                                    hwaddr size,
                                    BlockBackend *blk,
                                    uint32_t sector_len, int nb_blocs,
@@ -33,7 +33,7 @@ MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *fl);
 typedef struct PFlashCFI02 PFlashCFI02;
 
 PFlashCFI02 *pflash_cfi02_register(hwaddr base,
-                                   DeviceState *qdev, const char *name,
+                                   const char *name,
                                    hwaddr size,
                                    BlockBackend *blk,
                                    uint32_t sector_len, int nb_blocs,
-- 
2.17.2
