Received: from eggs.gnu.org ([209.51.188.92]:35996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6f-0000Xu-Im
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:09:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6b-0004lx-NA
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:09:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h3T6X-0004gC-Lg
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:09:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2DF8B307D762
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 22:09:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-92.ams2.redhat.com
	[10.36.116.92])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 511E35D706
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 22:08:59 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 11 Mar 2019 23:08:31 +0100
Message-Id: <20190311220843.4026-16-armbru@redhat.com>
In-Reply-To: <20190311220843.4026-1-armbru@redhat.com>
References: <20190311220843.4026-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/27] pflash: Clean up after commit 368a354f02b, part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Our pflash devices are simplistically modelled has having
"num-blocks" sectors of equal size "sector-length".  Real hardware
commonly has sectors of different sizes.  How our "sector-length"
property is related to the physical device's multiple sector sizes
is unclear.

Helper functions pflash_cfi01_register() and pflash_cfi02_register()
create a pflash device, set properties including "sector-length" and
"num-blocks", and realize.  They take parameters @size, @sector_len
and @nb_blocs.

QOMification left parameter @size unused.  Obviously, @size should
match @sector_len and @nb_blocs, i.e. size =3D=3D sector_len * nb_blocs.
All callers satisfy this.

Remove @nb_blocs and compute it from @size and @sector_len.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Message-Id: <20190308094610.21210-16-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/collie.c                          | 5 +++--
 hw/arm/digic_boards.c                    | 1 -
 hw/arm/gumstix.c                         | 6 ++----
 hw/arm/mainstone.c                       | 3 +--
 hw/arm/musicpal.c                        | 4 ++--
 hw/arm/omap_sx1.c                        | 6 ++----
 hw/arm/versatilepb.c                     | 1 -
 hw/arm/xilinx_zynq.c                     | 5 ++---
 hw/arm/z2.c                              | 3 +--
 hw/block/pflash_cfi01.c                  | 5 +++--
 hw/block/pflash_cfi02.c                  | 5 +++--
 hw/i386/pc_sysfw.c                       | 6 +-----
 hw/lm32/lm32_boards.c                    | 4 ++--
 hw/lm32/milkymist.c                      | 3 +--
 hw/microblaze/petalogix_ml605_mmu.c      | 3 +--
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 3 +--
 hw/mips/mips_malta.c                     | 2 +-
 hw/mips/mips_r4k.c                       | 3 +--
 hw/ppc/ppc405_boards.c                   | 6 +++---
 hw/ppc/sam460ex.c                        | 3 +--
 hw/ppc/virtex_ml507.c                    | 3 +--
 hw/sh4/r2d.c                             | 3 +--
 include/hw/block/flash.h                 | 4 ++--
 23 files changed, 35 insertions(+), 52 deletions(-)

diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index 3707b6b598..d12604c573 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -9,6 +9,7 @@
  * GNU GPL, version 2 or (at your option) any later version.
  */
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "hw/boards.h"
@@ -37,12 +38,12 @@ static void collie_init(MachineState *machine)
     dinfo =3D drive_get(IF_PFLASH, 0, 0);
     pflash_cfi01_register(SA_CS0, "collie.fl1", 0x02000000,
                     dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                    (64 * 1024), 512, 4, 0x00, 0x00, 0x00, 0x00, 0);
+                    64 * KiB, 4, 0x00, 0x00, 0x00, 0x00, 0);
=20
     dinfo =3D drive_get(IF_PFLASH, 0, 1);
     pflash_cfi01_register(SA_CS1, "collie.fl2", 0x02000000,
                     dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                    (64 * 1024), 512, 4, 0x00, 0x00, 0x00, 0x00, 0);
+                    64 * KiB, 4, 0x00, 0x00, 0x00, 0x00, 0);
=20
     sysbus_create_simple("scoop", 0x40800000, NULL);
=20
diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index 15a00a1be3..304e4d1a29 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -131,7 +131,6 @@ static void digic4_add_k8p3215uqb_rom(DigicBoardState=
 *s, hwaddr addr,
=20
     pflash_cfi02_register(addr, "pflash", FLASH_K8P3215UQB_SIZE,
                           NULL, FLASH_K8P3215UQB_SECTOR_SIZE,
-                          FLASH_K8P3215UQB_SIZE / FLASH_K8P3215UQB_SECTO=
R_SIZE,
                           DIGIC4_ROM_MAX_SIZE / FLASH_K8P3215UQB_SIZE,
                           4,
                           0x00EC, 0x007E, 0x0003, 0x0001,
diff --git a/hw/arm/gumstix.c b/hw/arm/gumstix.c
index 304dbeab2f..79886ce378 100644
--- a/hw/arm/gumstix.c
+++ b/hw/arm/gumstix.c
@@ -74,8 +74,7 @@ static void connex_init(MachineState *machine)
 #endif
     if (!pflash_cfi01_register(0x00000000, "connext.rom", connex_rom,
                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL=
,
-                               sector_len, connex_rom / sector_len,
-                               2, 0, 0, 0, 0, be)) {
+                               sector_len, 2, 0, 0, 0, 0, be)) {
         error_report("Error registering flash memory");
         exit(1);
     }
@@ -111,8 +110,7 @@ static void verdex_init(MachineState *machine)
 #endif
     if (!pflash_cfi01_register(0x00000000, "verdex.rom", verdex_rom,
                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL=
,
-                               sector_len, verdex_rom / sector_len,
-                               2, 0, 0, 0, 0, be)) {
+                               sector_len, 2, 0, 0, 0, 0, be)) {
         error_report("Error registering flash memory");
         exit(1);
     }
diff --git a/hw/arm/mainstone.c b/hw/arm/mainstone.c
index 2a1c1072db..e96738ad26 100644
--- a/hw/arm/mainstone.c
+++ b/hw/arm/mainstone.c
@@ -152,8 +152,7 @@ static void mainstone_common_init(MemoryRegion *addre=
ss_space_mem,
                                    i ? "mainstone.flash1" : "mainstone.f=
lash0",
                                    MAINSTONE_FLASH,
                                    blk_by_legacy_dinfo(dinfo),
-                                   sector_len, MAINSTONE_FLASH / sector_=
len,
-                                   4, 0, 0, 0, 0, be)) {
+                                   sector_len, 4, 0, 0, 0, 0, be)) {
             error_report("Error registering flash memory");
             exit(1);
         }
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 3cccc4866b..93ec3c5698 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1637,14 +1637,14 @@ static void musicpal_init(MachineState *machine)
 #ifdef TARGET_WORDS_BIGENDIAN
         pflash_cfi02_register(0x100000000ULL - MP_FLASH_SIZE_MAX,
                               "musicpal.flash", flash_size,
-                              blk, 0x10000, (flash_size + 0xffff) >> 16,
+                              blk, 0x10000,
                               MP_FLASH_SIZE_MAX / flash_size,
                               2, 0x00BF, 0x236D, 0x0000, 0x0000,
                               0x5555, 0x2AAA, 1);
 #else
         pflash_cfi02_register(0x100000000ULL - MP_FLASH_SIZE_MAX,
                               "musicpal.flash", flash_size,
-                              blk, 0x10000, (flash_size + 0xffff) >> 16,
+                              blk, 0x10000,
                               MP_FLASH_SIZE_MAX / flash_size,
                               2, 0x00BF, 0x236D, 0x0000, 0x0000,
                               0x5555, 0x2AAA, 0);
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index b1128777cf..95a4fe7e7f 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -155,8 +155,7 @@ static void sx1_init(MachineState *machine, const int=
 version)
         if (!pflash_cfi01_register(OMAP_CS0_BASE,
                                    "omap_sx1.flash0-1", flash_size,
                                    blk_by_legacy_dinfo(dinfo),
-                                   sector_size, flash_size / sector_size=
,
-                                   4, 0, 0, 0, 0, be)) {
+                                   sector_size, 4, 0, 0, 0, 0, be)) {
             fprintf(stderr, "qemu: Error registering flash memory %d.\n"=
,
                            fl_idx);
         }
@@ -179,8 +178,7 @@ static void sx1_init(MachineState *machine, const int=
 version)
         if (!pflash_cfi01_register(OMAP_CS1_BASE,
                                    "omap_sx1.flash1-1", flash1_size,
                                    blk_by_legacy_dinfo(dinfo),
-                                   sector_size, flash1_size / sector_siz=
e,
-                                   4, 0, 0, 0, 0, be)) {
+                                   sector_size, 4, 0, 0, 0, 0, be)) {
             fprintf(stderr, "qemu: Error registering flash memory %d.\n"=
,
                            fl_idx);
         }
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 82c5277462..d67181810a 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -369,7 +369,6 @@ static void versatile_init(MachineState *machine, int=
 board_id)
                           VERSATILE_FLASH_SIZE,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                           VERSATILE_FLASH_SECT_SIZE,
-                          VERSATILE_FLASH_SIZE / VERSATILE_FLASH_SECT_SI=
ZE,
                           4, 0x0089, 0x0018, 0x0000, 0x0, 0)) {
         fprintf(stderr, "qemu: Error registering flash memory.\n");
     }
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 1fa4a77728..b3b8215759 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -207,10 +207,9 @@ static void zynq_init(MachineState *machine)
     /* AMD */
     pflash_cfi02_register(0xe2000000, "zynq.pflash", FLASH_SIZE,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                          FLASH_SECTOR_SIZE,
-                          FLASH_SIZE/FLASH_SECTOR_SIZE, 1,
+                          FLASH_SECTOR_SIZE, 1,
                           1, 0x0066, 0x0022, 0x0000, 0x0000, 0x0555, 0x2=
aa,
-                              0);
+                          0);
=20
     dev =3D qdev_create(NULL, "xilinx,zynq_slcr");
     qdev_init_nofail(dev);
diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index 6c1d36588c..1f906ef20b 100644
--- a/hw/arm/z2.c
+++ b/hw/arm/z2.c
@@ -325,8 +325,7 @@ static void z2_init(MachineState *machine)
=20
     if (!pflash_cfi01_register(Z2_FLASH_BASE, "z2.flash0", Z2_FLASH_SIZE=
,
                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL=
,
-                               sector_len, Z2_FLASH_SIZE / sector_len,
-                               4, 0, 0, 0, 0, be)) {
+                               sector_len, 4, 0, 0, 0, 0, be)) {
         error_report("Error registering flash memory");
         exit(1);
     }
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index bd42487c0a..9d1c356eb6 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -940,7 +940,7 @@ PFlashCFI01 *pflash_cfi01_register(hwaddr base,
                                    const char *name,
                                    hwaddr size,
                                    BlockBackend *blk,
-                                   uint32_t sector_len, int nb_blocs,
+                                   uint32_t sector_len,
                                    int bank_width,
                                    uint16_t id0, uint16_t id1,
                                    uint16_t id2, uint16_t id3,
@@ -951,7 +951,8 @@ PFlashCFI01 *pflash_cfi01_register(hwaddr base,
     if (blk) {
         qdev_prop_set_drive(dev, "drive", blk, &error_abort);
     }
-    qdev_prop_set_uint32(dev, "num-blocks", nb_blocs);
+    assert(size % sector_len =3D=3D 0);
+    qdev_prop_set_uint32(dev, "num-blocks", size / sector_len);
     qdev_prop_set_uint64(dev, "sector-length", sector_len);
     qdev_prop_set_uint8(dev, "width", bank_width);
     qdev_prop_set_bit(dev, "big-endian", !!be);
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 8f09d31fad..c9db430611 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -727,7 +727,7 @@ PFlashCFI02 *pflash_cfi02_register(hwaddr base,
                                    const char *name,
                                    hwaddr size,
                                    BlockBackend *blk,
-                                   uint32_t sector_len, int nb_blocs,
+                                   uint32_t sector_len,
                                    int nb_mappings, int width,
                                    uint16_t id0, uint16_t id1,
                                    uint16_t id2, uint16_t id3,
@@ -740,7 +740,8 @@ PFlashCFI02 *pflash_cfi02_register(hwaddr base,
     if (blk) {
         qdev_prop_set_drive(dev, "drive", blk, &error_abort);
     }
-    qdev_prop_set_uint32(dev, "num-blocks", nb_blocs);
+    assert(size % sector_len =3D=3D 0);
+    qdev_prop_set_uint32(dev, "num-blocks", size / sector_len);
     qdev_prop_set_uint32(dev, "sector-length", sector_len);
     qdev_prop_set_uint8(dev, "width", width);
     qdev_prop_set_uint8(dev, "mappings", nb_mappings);
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 9a5be54a85..34727c5b1f 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -110,16 +110,13 @@ static void pc_system_flash_init(MemoryRegion *rom_=
memory)
     int64_t size;
     char *fatal_errmsg =3D NULL;
     hwaddr phys_addr =3D 0x100000000ULL;
-    int sector_bits, sector_size;
+    uint32_t sector_size =3D 4096;
     PFlashCFI01 *system_flash;
     MemoryRegion *flash_mem;
     char name[64];
     void *flash_ptr;
     int ret, flash_size;
=20
-    sector_bits =3D 12;
-    sector_size =3D 1 << sector_bits;
-
     for (unit =3D 0;
          (unit < FLASH_MAP_UNIT_MAX &&
           (pflash_drv =3D drive_get(IF_PFLASH, 0, unit)) !=3D NULL);
@@ -162,7 +159,6 @@ static void pc_system_flash_init(MemoryRegion *rom_me=
mory)
         snprintf(name, sizeof name, "system.flash%d", unit);
         system_flash =3D pflash_cfi01_register(phys_addr, name,
                                              size, blk, sector_size,
-                                             size >> sector_bits,
                                              1      /* width */,
                                              0x0000 /* id0 */,
                                              0x0000 /* id1 */,
diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
index b71179cd9d..b820c9114b 100644
--- a/hw/lm32/lm32_boards.c
+++ b/hw/lm32/lm32_boards.c
@@ -115,7 +115,7 @@ static void lm32_evr_init(MachineState *machine)
     /* Spansion S29NS128P */
     pflash_cfi02_register(flash_base, "lm32_evr.flash", flash_size,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                          flash_sector_size, flash_size / flash_sector_s=
ize,
+                          flash_sector_size,
                           1, 2, 0x01, 0x7e, 0x43, 0x00, 0x555, 0x2aa, 1)=
;
=20
     /* create irq lines */
@@ -208,7 +208,7 @@ static void lm32_uclinux_init(MachineState *machine)
     /* Spansion S29NS128P */
     pflash_cfi02_register(flash_base, "lm32_uclinux.flash", flash_size,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                          flash_sector_size, flash_size / flash_sector_s=
ize,
+                          flash_sector_size,
                           1, 2, 0x01, 0x7e, 0x43, 0x00, 0x555, 0x2aa, 1)=
;
=20
     /* create irq lines */
diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
index c5f58c2425..689e633199 100644
--- a/hw/lm32/milkymist.c
+++ b/hw/lm32/milkymist.c
@@ -122,8 +122,7 @@ milkymist_init(MachineState *machine)
     /* Numonyx JS28F256J3F105 */
     pflash_cfi01_register(flash_base, "milkymist.flash", flash_size,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                          flash_sector_size, flash_size / flash_sector_s=
ize,
-                          2, 0x00, 0x89, 0x00, 0x1d, 1);
+                          flash_sector_size, 2, 0x00, 0x89, 0x00, 0x1d, =
1);
=20
     /* create irq lines */
     env->pic_state =3D lm32_pic_init(qemu_allocate_irq(cpu_irq_handler, =
cpu, 0));
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogi=
x_ml605_mmu.c
index 9ccbafbe44..a907604116 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -108,8 +108,7 @@ petalogix_ml605_init(MachineState *machine)
      * 10th paremeter 0 means little-endian */
     pflash_cfi01_register(FLASH_BASEADDR, "petalogix_ml605.flash", FLASH=
_SIZE,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                          64 * KiB, FLASH_SIZE >> 16,
-                          2, 0x89, 0x18, 0x0000, 0x0, 0);
+                          64 * KiB, 2, 0x89, 0x18, 0x0000, 0x0, 0);
=20
=20
     dev =3D qdev_create(NULL, "xlnx.xps-intc");
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/pet=
alogix_s3adsp1800_mmu.c
index fa9c6a1ac9..88ce570f9a 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -89,8 +89,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
     pflash_cfi01_register(FLASH_BASEADDR,
                           "petalogix_s3adsp1800.flash", FLASH_SIZE,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                          64 * KiB, FLASH_SIZE >> 16,
-                          1, 0x89, 0x18, 0x0000, 0x0, 1);
+                          64 * KiB, 1, 0x89, 0x18, 0x0000, 0x0, 1);
=20
     dev =3D qdev_create(NULL, "xlnx.xps-intc");
     qdev_prop_set_uint32(dev, "kind-of-intr",
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 69182962ef..439665ab45 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1264,7 +1264,7 @@ void mips_malta_init(MachineState *machine)
     fl =3D pflash_cfi01_register(FLASH_ADDRESS, "mips_malta.bios",
                                FLASH_SIZE,
                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL=
,
-                               65536, FLASH_SIZE >> 16,
+                               65536,
                                4, 0x0000, 0x0000, 0x0000, 0x0000, be);
     bios =3D pflash_cfi01_get_memory(fl);
     fl_idx++;
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index 0b9df466e7..93dbf76bb4 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -237,8 +237,7 @@ void mips_r4k_init(MachineState *machine)
         uint32_t mips_rom =3D 0x00400000;
         if (!pflash_cfi01_register(0x1fc00000, "mips_r4k.bios", mips_rom=
,
                                    blk_by_legacy_dinfo(dinfo),
-                                   sector_len, mips_rom / sector_len,
-                                   4, 0, 0, 0, 0, be)) {
+                                   sector_len, 4, 0, 0, 0, 0, be)) {
             fprintf(stderr, "qemu: Error registering flash memory.\n");
         }
     } else if (!qtest_enabled()) {
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index 43be8b68d9..13318a9faf 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -184,7 +184,7 @@ static void ref405ep_init(MachineState *machine)
         pflash_cfi02_register((uint32_t)(-bios_size),
                               "ef405ep.bios", bios_size,
                               dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                              64 * KiB, bios_size / (64 * KiB), 1,
+                              64 * KiB, 1,
                               2, 0x0001, 0x22DA, 0x0000, 0x0000, 0x555, =
0x2AA,
                               1);
     } else
@@ -450,7 +450,7 @@ static void taihu_405ep_init(MachineState *machine)
         pflash_cfi02_register(0xFFE00000,
                               "taihu_405ep.bios", bios_size,
                               dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                              64 * KiB, bios_size / (64 * KiB), 1,
+                              64 * KiB, 1,
                               4, 0x0001, 0x22DA, 0x0000, 0x0000, 0x555, =
0x2AA,
                               1);
         fl_idx++;
@@ -486,7 +486,7 @@ static void taihu_405ep_init(MachineState *machine)
         bios_size =3D 32 * MiB;
         pflash_cfi02_register(0xfc000000, "taihu_405ep.flash", bios_size=
,
                               dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                              64 * KiB, bios_size / (64 * KiB), 1,
+                              64 * KiB, 1,
                               4, 0x0001, 0x22DA, 0x0000, 0x0000, 0x555, =
0x2AA,
                               1);
         fl_idx++;
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 9af6018c7d..fbcddc5b00 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -115,8 +115,7 @@ static int sam460ex_load_uboot(void)
     if (!pflash_cfi01_register(FLASH_BASE | ((hwaddr)FLASH_BASE_H << 32)=
,
                                "sam460ex.flash", FLASH_SIZE,
                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL=
,
-                               64 * KiB, FLASH_SIZE / (64 * KiB),
-                               1, 0x89, 0x18, 0x0000, 0x0, 1)) {
+                               64 * KiB, 1, 0x89, 0x18, 0x0000, 0x0, 1))=
 {
         error_report("Error registering flash memory");
         /* XXX: return an error instead? */
         exit(1);
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 2e87a1abd6..0e4c7409e0 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -228,8 +228,7 @@ static void virtex_init(MachineState *machine)
     dinfo =3D drive_get(IF_PFLASH, 0, 0);
     pflash_cfi01_register(PFLASH_BASEADDR, "virtex.flash", FLASH_SIZE,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                          64 * KiB, FLASH_SIZE >> 16,
-                          1, 0x89, 0x18, 0x0000, 0x0, 1);
+                          64 * KiB, 1, 0x89, 0x18, 0x0000, 0x0, 1);
=20
     cpu_irq =3D (qemu_irq *) &env->irq_inputs[PPC40x_INPUT_INT];
     dev =3D qdev_create(NULL, "xlnx.xps-intc");
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 7d89c6db06..0bcb769c85 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -299,8 +299,7 @@ static void r2d_init(MachineState *machine)
     dinfo =3D drive_get(IF_PFLASH, 0, 0);
     pflash_cfi02_register(0x0, "r2d.flash", FLASH_SIZE,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                          64 * KiB, FLASH_SIZE >> 16,
-                          1, 2, 0x0001, 0x227e, 0x2220, 0x2200,
+                          64 * KiB, 1, 2, 0x0001, 0x227e, 0x2220, 0x2200=
,
                           0x555, 0x2aa, 0);
=20
     /* NIC: rtl8139 on-board, and 2 slots. */
diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
index 3e48901c84..914932eaec 100644
--- a/include/hw/block/flash.h
+++ b/include/hw/block/flash.h
@@ -17,7 +17,7 @@ PFlashCFI01 *pflash_cfi01_register(hwaddr base,
                                    const char *name,
                                    hwaddr size,
                                    BlockBackend *blk,
-                                   uint32_t sector_len, int nb_blocs,
+                                   uint32_t sector_len,
                                    int width,
                                    uint16_t id0, uint16_t id1,
                                    uint16_t id2, uint16_t id3,
@@ -36,7 +36,7 @@ PFlashCFI02 *pflash_cfi02_register(hwaddr base,
                                    const char *name,
                                    hwaddr size,
                                    BlockBackend *blk,
-                                   uint32_t sector_len, int nb_blocs,
+                                   uint32_t sector_len,
                                    int nb_mappings,
                                    int width,
                                    uint16_t id0, uint16_t id1,
--=20
2.17.2
