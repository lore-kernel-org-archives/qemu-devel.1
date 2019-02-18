Received: from eggs.gnu.org ([209.51.188.92]:44437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gviTO-00087R-Jp
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:56:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gviTM-0000n5-L9
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:56:38 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 18 Feb 2019 13:56:08 +0100
Message-Id: <20190218125615.18970-4-armbru@redhat.com>
In-Reply-To: <20190218125615.18970-1-armbru@redhat.com>
References: <20190218125615.18970-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 03/10] hw: Use CFI_PFLASH0{1,
 2} and TYPE_CFI_PFLASH0{1, 2}
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

We have two open-coded copies of macro CFI_PFLASH01().  Move the macro
to the header, so we can ditch the copies.  Move CFI_PFLASH02() to the
header for symmetry.

We define macros TYPE_CFI_PFLASH01 and TYPE_CFI_PFLASH02 for type name
strings, then mostly use the strings.  If the macros are worth
defining, they are worth using.  Replace the strings by the macros.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/arm/vexpress.c        | 4 ++--
 hw/arm/virt.c            | 3 ++-
 hw/block/pflash_cfi01.c  | 3 ---
 hw/block/pflash_cfi02.c  | 3 ---
 hw/xtensa/xtfpga.c       | 4 ++--
 include/hw/block/flash.h | 4 ++++
 6 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index ed46d2e730..00913f2655 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -515,7 +515,7 @@ static void vexpress_modify_dtb(const struct arm_boot_info *info, void *fdt)
 static PFlashCFI01 *ve_pflash_cfi01_register(hwaddr base, const char *name,
                                              DriveInfo *di)
 {
-    DeviceState *dev = qdev_create(NULL, "cfi.pflash01");
+    DeviceState *dev = qdev_create(NULL, TYPE_CFI_PFLASH01);
 
     if (di) {
         qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(di),
@@ -536,7 +536,7 @@ static PFlashCFI01 *ve_pflash_cfi01_register(hwaddr base, const char *name,
     qdev_init_nofail(dev);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
-    return OBJECT_CHECK(PFlashCFI01, (dev), "cfi.pflash01");
+    return CFI_PFLASH01(dev);
 }
 
 static void vexpress_common_init(MachineState *machine)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 99c2b6e60d..b7d53b2b87 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -34,6 +34,7 @@
 #include "hw/arm/arm.h"
 #include "hw/arm/primecell.h"
 #include "hw/arm/virt.h"
+#include "hw/block/flash.h"
 #include "hw/vfio/vfio-calxeda-xgmac.h"
 #include "hw/vfio/vfio-amd-xgbe.h"
 #include "hw/display/ramfb.h"
@@ -874,7 +875,7 @@ static void create_one_flash(const char *name, hwaddr flashbase,
      * parameters as the flash devices on the Versatile Express board.
      */
     DriveInfo *dinfo = drive_get_next(IF_PFLASH);
-    DeviceState *dev = qdev_create(NULL, "cfi.pflash01");
+    DeviceState *dev = qdev_create(NULL, TYPE_CFI_PFLASH01);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     const uint64_t sectorlength = 256 * 1024;
 
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index f73c30a3ee..43dbb7db26 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -59,9 +59,6 @@ do {                                                        \
 #define DPRINTF(fmt, ...) do { } while (0)
 #endif
 
-#define CFI_PFLASH01(obj) \
-    OBJECT_CHECK(PFlashCFI01, (obj), TYPE_CFI_PFLASH01)
-
 #define PFLASH_BE          0
 #define PFLASH_SECURE      1
 
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 424cc106d6..e9c76d6cfb 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -57,9 +57,6 @@ do {                                                       \
 
 #define PFLASH_LAZY_ROMD_THRESHOLD 42
 
-#define CFI_PFLASH02(obj) \
-    OBJECT_CHECK(PFlashCFI02, (obj), TYPE_CFI_PFLASH02)
-
 struct PFlashCFI02 {
     /*< private >*/
     SysBusDevice parent_obj;
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 3d59a7a356..a726d5632a 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -167,7 +167,7 @@ static PFlashCFI01 *xtfpga_flash_init(MemoryRegion *address_space,
                                       DriveInfo *dinfo, int be)
 {
     SysBusDevice *s;
-    DeviceState *dev = qdev_create(NULL, "cfi.pflash01");
+    DeviceState *dev = qdev_create(NULL, TYPE_CFI_PFLASH01);
 
     qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo),
                         &error_abort);
@@ -181,7 +181,7 @@ static PFlashCFI01 *xtfpga_flash_init(MemoryRegion *address_space,
     s = SYS_BUS_DEVICE(dev);
     memory_region_add_subregion(address_space, board->flash->base,
                                 sysbus_mmio_get_region(s, 0));
-    return OBJECT_CHECK(PFlashCFI01, (dev), "cfi.pflash01");
+    return CFI_PFLASH01(dev);
 }
 
 static uint64_t translate_phys_addr(void *opaque, uint64_t addr)
diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
index 51d8f60c65..1078dc7238 100644
--- a/include/hw/block/flash.h
+++ b/include/hw/block/flash.h
@@ -8,6 +8,8 @@
 /* pflash_cfi01.c */
 
 #define TYPE_CFI_PFLASH01 "cfi.pflash01"
+#define CFI_PFLASH01(obj) \
+    OBJECT_CHECK(PFlashCFI01, (obj), TYPE_CFI_PFLASH01)
 
 typedef struct PFlashCFI01 PFlashCFI01;
 
@@ -25,6 +27,8 @@ MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *fl);
 /* pflash_cfi02.c */
 
 #define TYPE_CFI_PFLASH02 "cfi.pflash02"
+#define CFI_PFLASH02(obj) \
+    OBJECT_CHECK(PFlashCFI02, (obj), TYPE_CFI_PFLASH02)
 
 typedef struct PFlashCFI02 PFlashCFI02;
 
-- 
2.17.2
