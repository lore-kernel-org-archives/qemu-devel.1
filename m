Received: from eggs.gnu.org ([2001:4830:134:3::10]:46914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1e9YjY-0001WX-HC
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 11:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1e9YjW-0007d7-8q
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 11:45:44 -0400
Received: from relay2.gtri.gatech.edu ([130.207.199.168]:52470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1e9YjW-0007bk-1Y
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 11:45:42 -0400
From: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
Date: Tue, 31 Oct 2017 11:44:07 -0400
Message-ID: <20171031154407.4184-3-michael.nawrocki@gtri.gatech.edu>
In-Reply-To: <20171031154407.4184-1-michael.nawrocki@gtri.gatech.edu>
References: <20171031154407.4184-1-michael.nawrocki@gtri.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/2] Add support for flash interleaving of AMD
 chips
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jan.kiszka@web.de, edgar.iglesias@gmail.com, alistair.francis@xilinx.com, michael@walle.cc, david@gibson.dropbear.id.au, magnus.damm@gmail.com, Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>

Flash interleaving is partially supported using the new interleave_num
parameter, which indicates how many "devices" comprise the flash array.
The supported flash access pattern is one where commands are sent to all
devices simultaneously and the read result is duplicated according to
the interleave number. For example, given a flash array of width 8,
interleave 4, the command sequence

0x00AA00AA00AA00AA
0x0055005500550055
0x0090009000900090

sends the auto-select command sequence. If a read to address 0 is
issued, the user would expect the following: 0x0001000100010001 to
identify the AMD device array.

Issuing commands to individual members of the flash array is not
supported.

Signed-off-by: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
---
 hw/arm/digic_boards.c    |  2 +-
 hw/arm/musicpal.c        |  4 ++--
 hw/arm/xilinx_zynq.c     |  2 +-
 hw/block/pflash_cfi02.c  | 38 +++++++++++++++++++++++++++++++++++++-
 hw/lm32/lm32_boards.c    |  4 ++--
 hw/ppc/ppc405_boards.c   | 15 ++++++---------
 hw/sh4/r2d.c             |  2 +-
 include/hw/block/flash.h |  1 +
 8 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index 9f11dcd11f..7f039a989a 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -133,7 +133,7 @@ static void digic4_add_k8p3215uqb_rom(DigicBoardState *s, hwaddr addr,
                           NULL, FLASH_K8P3215UQB_SECTOR_SIZE,
                           FLASH_K8P3215UQB_SIZE / FLASH_K8P3215UQB_SECTOR_SIZE,
                           DIGIC4_ROM_MAX_SIZE / FLASH_K8P3215UQB_SIZE,
-                          4,
+                          4, 1,
                           0x00EC, 0x007E, 0x0003, 0x0001,
                           0x0555, 0x2aa, 0);
 
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index b648770882..5d98cd1eac 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1640,14 +1640,14 @@ static void musicpal_init(MachineState *machine)
                               "musicpal.flash", flash_size,
                               blk, 0x10000, (flash_size + 0xffff) >> 16,
                               MP_FLASH_SIZE_MAX / flash_size,
-                              2, 0x00BF, 0x236D, 0x0000, 0x0000,
+                              2, 1, 0x00BF, 0x236D, 0x0000, 0x0000,
                               0x5555, 0x2AAA, 1);
 #else
         pflash_cfi02_register(0x100000000ULL-MP_FLASH_SIZE_MAX, NULL,
                               "musicpal.flash", flash_size,
                               blk, 0x10000, (flash_size + 0xffff) >> 16,
                               MP_FLASH_SIZE_MAX / flash_size,
-                              2, 0x00BF, 0x236D, 0x0000, 0x0000,
+                              2, 1, 0x00BF, 0x236D, 0x0000, 0x0000,
                               0x5555, 0x2AAA, 0);
 #endif
 
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 1836a4ed45..ea85333104 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -210,7 +210,7 @@ static void zynq_init(MachineState *machine)
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                           FLASH_SECTOR_SIZE,
                           FLASH_SIZE/FLASH_SECTOR_SIZE, 1,
-                          1, 0x0066, 0x0022, 0x0000, 0x0000, 0x0555, 0x2aa,
+                          1, 1, 0x0066, 0x0022, 0x0000, 0x0000, 0x0555, 0x2aa,
                               0);
 
     dev = qdev_create(NULL, "xilinx,zynq_slcr");
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 0aed0ab218..b0f86584c5 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -28,11 +28,28 @@
  * - unlock bypass command
  * - CFI queries
  *
- * It does not support flash interleaving.
  * It does not implement boot blocs with reduced size
  * It does not implement software data protection as found in many real chips
  * It does not implement erase suspend/resume commands
  * It does not implement multiple sectors erase
+ *
+ * Flash interleaving is partially supported using the interleave_num
+ * parameter, which indicates how many "devices" comprise the flash array.
+ * The supported flash access pattern is one where commands are sent to all
+ * devices simultaneously and the read result is duplicated according to the
+ * interleave number. For example, given a flash array of width 8,
+ * interleave 4, the command sequence
+ *
+ * 0x00AA00AA00AA00AA
+ * 0x0055005500550055
+ * 0x0090009000900090
+ *
+ * sends the auto-select command sequence. If a read to address 0 is
+ * issued, the user would expect the following:
+ * 0x0001000100010001
+ * to identify the AMD device array.
+ *
+ * Issuing commands to individual members of the flash array is not supported.
  */
 
 #include "qemu/osdep.h"
@@ -97,6 +114,7 @@ struct pflash_t {
     int read_counter; /* used for lazy switch-back to rom mode */
     char *name;
     void *storage;
+    uint8_t interleave_num; /* number of devices that comprise the array */
 };
 
 /*
@@ -144,6 +162,8 @@ static uint64_t pflash_read(pflash_t *pfl, hwaddr offset,
     hwaddr boff;
     uint64_t ret;
     uint8_t *p;
+    int i;
+    uint8_t intlv_shift = (pfl->width / pfl->interleave_num) << 3;
 
     DPRINTF("%s: offset " TARGET_FMT_plx "\n", __func__, offset);
     ret = -1;
@@ -231,6 +251,10 @@ static uint64_t pflash_read(pflash_t *pfl, hwaddr offset,
         case 0x00:
         case 0x01:
             ret = boff & 0x01 ? pfl->ident1 : pfl->ident0;
+            for (i = 1; i < pfl->interleave_num; ++i) {
+                ret = (ret << intlv_shift) | ret;
+            }
+
             break;
         case 0x02:
             ret = 0x00; /* Pretend all sectors are unprotected */
@@ -241,6 +265,9 @@ static uint64_t pflash_read(pflash_t *pfl, hwaddr offset,
             if (ret == (uint8_t)-1) {
                 goto flash_read;
             }
+            for (i = 1; i < pfl->interleave_num; ++i) {
+                ret <<= intlv_shift;
+            }
             break;
         default:
             goto flash_read;
@@ -253,6 +280,9 @@ static uint64_t pflash_read(pflash_t *pfl, hwaddr offset,
     case 0x30:
         /* Status register read */
         ret = pfl->status;
+        for (i = 1; i < pfl->interleave_num; ++i) {
+            ret <<= intlv_shift;
+        }
         DPRINTF("%s: status %" PRIx64 "\n", __func__, ret);
         /* Toggle bit 6 */
         pfl->status ^= 0x40;
@@ -263,6 +293,9 @@ static uint64_t pflash_read(pflash_t *pfl, hwaddr offset,
             ret = 0;
         else
             ret = pfl->cfi_table[boff];
+        for (i = 1; i < pfl->interleave_num; ++i) {
+            ret <<= intlv_shift;
+        }
         break;
     }
 
@@ -745,6 +778,7 @@ static Property pflash_cfi02_properties[] = {
     DEFINE_PROP_UINT16("unlock-addr0", struct pflash_t, unlock_addr0, 0),
     DEFINE_PROP_UINT16("unlock-addr1", struct pflash_t, unlock_addr1, 0),
     DEFINE_PROP_STRING("name", struct pflash_t, name),
+    DEFINE_PROP_UINT8("interleave_num", struct pflash_t, interleave_num, 1),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -776,6 +810,7 @@ pflash_t *pflash_cfi02_register(hwaddr base,
                                 hwaddr size,
                                 BlockBackend *blk, uint32_t sector_len,
                                 int nb_blocs, int nb_mappings, int width,
+                                int interleave_num,
                                 uint16_t id0, uint16_t id1,
                                 uint16_t id2, uint16_t id3,
                                 uint16_t unlock_addr0, uint16_t unlock_addr1,
@@ -798,6 +833,7 @@ pflash_t *pflash_cfi02_register(hwaddr base,
     qdev_prop_set_uint16(dev, "unlock-addr0", unlock_addr0);
     qdev_prop_set_uint16(dev, "unlock-addr1", unlock_addr1);
     qdev_prop_set_string(dev, "name", name);
+    qdev_prop_set_uint32(dev, "interleave_num", MAX(interleave_num, 1));
     qdev_init_nofail(dev);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
index 002d638edd..523121142f 100644
--- a/hw/lm32/lm32_boards.c
+++ b/hw/lm32/lm32_boards.c
@@ -116,7 +116,7 @@ static void lm32_evr_init(MachineState *machine)
     pflash_cfi02_register(flash_base, NULL, "lm32_evr.flash", flash_size,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                           flash_sector_size, flash_size / flash_sector_size,
-                          1, 2, 0x01, 0x7e, 0x43, 0x00, 0x555, 0x2aa, 1);
+                          1, 2, 1, 0x01, 0x7e, 0x43, 0x00, 0x555, 0x2aa, 1);
 
     /* create irq lines */
     env->pic_state = lm32_pic_init(qemu_allocate_irq(cpu_irq_handler, cpu, 0));
@@ -209,7 +209,7 @@ static void lm32_uclinux_init(MachineState *machine)
     pflash_cfi02_register(flash_base, NULL, "lm32_uclinux.flash", flash_size,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                           flash_sector_size, flash_size / flash_sector_size,
-                          1, 2, 0x01, 0x7e, 0x43, 0x00, 0x555, 0x2aa, 1);
+                          1, 2, 1, 0x01, 0x7e, 0x43, 0x00, 0x555, 0x2aa, 1);
 
     /* create irq lines */
     env->pic_state = lm32_pic_init(qemu_allocate_irq(cpu_irq_handler, env, 0));
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index e92db2c66a..04d318ca65 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -241,9 +241,8 @@ static void ref405ep_init(MachineState *machine)
 #endif
         pflash_cfi02_register((uint32_t)(-bios_size),
                               NULL, "ef405ep.bios", bios_size,
-                              blk, 65536, fl_sectors, 1,
-                              2, 0x0001, 0x22DA, 0x0000, 0x0000, 0x555, 0x2AA,
-                              1);
+                              blk, 65536, fl_sectors, 1, 2, 1,
+                              0x0001, 0x22DA, 0x0000, 0x0000, 0x555, 0x2AA, 1);
         fl_idx++;
     } else
 #endif
@@ -539,9 +538,8 @@ static void taihu_405ep_init(MachineState *machine)
 #endif
         pflash_cfi02_register((uint32_t)(-bios_size),
                               NULL, "taihu_405ep.bios", bios_size,
-                              blk, 65536, fl_sectors, 1,
-                              4, 0x0001, 0x22DA, 0x0000, 0x0000, 0x555, 0x2AA,
-                              1);
+                              blk, 65536, fl_sectors, 1, 4, 1,
+                              0x0001, 0x22DA, 0x0000, 0x0000, 0x555, 0x2AA, 1);
         fl_idx++;
     } else
 #endif
@@ -586,9 +584,8 @@ static void taihu_405ep_init(MachineState *machine)
                blk_name(blk));
 #endif
         pflash_cfi02_register(0xfc000000, NULL, "taihu_405ep.flash", bios_size,
-                              blk, 65536, fl_sectors, 1,
-                              4, 0x0001, 0x22DA, 0x0000, 0x0000, 0x555, 0x2AA,
-                              1);
+                              blk, 65536, fl_sectors, 1, 4, 1,
+                              0x0001, 0x22DA, 0x0000, 0x0000, 0x555, 0x2AA, 1);
         fl_idx++;
     }
     /* Register CLPD & LCD display */
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 458ed83297..696175dad6 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -293,7 +293,7 @@ static void r2d_init(MachineState *machine)
     pflash_cfi02_register(0x0, NULL, "r2d.flash", FLASH_SIZE,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                           (16 * 1024), FLASH_SIZE >> 16,
-                          1, 4, 0x0000, 0x0000, 0x0000, 0x0000,
+                          1, 4, 1, 0x0000, 0x0000, 0x0000, 0x0000,
                           0x555, 0x2aa, 0);
 
     /* NIC: rtl8139 on-board, and 2 slots. */
diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
index 67c3aa329e..b23e3e3030 100644
--- a/include/hw/block/flash.h
+++ b/include/hw/block/flash.h
@@ -25,6 +25,7 @@ pflash_t *pflash_cfi02_register(hwaddr base,
                                 hwaddr size,
                                 BlockBackend *blk, uint32_t sector_len,
                                 int nb_blocs, int nb_mappings, int width,
+                                int interleave_num,
                                 uint16_t id0, uint16_t id1,
                                 uint16_t id2, uint16_t id3,
                                 uint16_t unlock_addr0, uint16_t unlock_addr1,
-- 
2.14.2
