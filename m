Received: from eggs.gnu.org ([209.51.188.92]:35719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6P-000064-6e
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:08:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6M-0004bJ-Oh
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:08:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h3T6M-0004aG-Cx
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:08:54 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4D30B37E60
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 22:08:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-92.ams2.redhat.com
	[10.36.116.92])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E69FD19724
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 22:08:49 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 11 Mar 2019 23:08:21 +0100
Message-Id: <20190311220843.4026-6-armbru@redhat.com>
In-Reply-To: <20190311220843.4026-1-armbru@redhat.com>
References: <20190311220843.4026-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/27] hw: Use PFLASH_CFI0{1,
 2} and TYPE_PFLASH_CFI0{1, 2}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We have two open-coded copies of macro PFLASH_CFI01().  Move the macro
to the header, so we can ditch the copies.  Move PFLASH_CFI02() to the
header for symmetry.

We define macros TYPE_PFLASH_CFI01 and TYPE_PFLASH_CFI02 for type name
strings, then mostly use the strings.  If the macros are worth
defining, they are worth using.  Replace the strings by the macros.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Message-Id: <20190308094610.21210-6-armbru@redhat.com>
---
 hw/arm/vexpress.c        | 4 ++--
 hw/arm/virt.c            | 3 ++-
 hw/block/pflash_cfi01.c  | 3 ---
 hw/block/pflash_cfi02.c  | 3 ---
 hw/xtensa/xtfpga.c       | 4 ++--
 include/hw/block/flash.h | 4 ++++
 6 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index ed46d2e730..f07134c424 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -515,7 +515,7 @@ static void vexpress_modify_dtb(const struct arm_boot=
_info *info, void *fdt)
 static PFlashCFI01 *ve_pflash_cfi01_register(hwaddr base, const char *na=
me,
                                              DriveInfo *di)
 {
-    DeviceState *dev =3D qdev_create(NULL, "cfi.pflash01");
+    DeviceState *dev =3D qdev_create(NULL, TYPE_PFLASH_CFI01);
=20
     if (di) {
         qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(di),
@@ -536,7 +536,7 @@ static PFlashCFI01 *ve_pflash_cfi01_register(hwaddr b=
ase, const char *name,
     qdev_init_nofail(dev);
=20
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
-    return OBJECT_CHECK(PFlashCFI01, (dev), "cfi.pflash01");
+    return PFLASH_CFI01(dev);
 }
=20
 static void vexpress_common_init(MachineState *machine)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7f66ddad89..1e8485ff7c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -35,6 +35,7 @@
 #include "hw/arm/arm.h"
 #include "hw/arm/primecell.h"
 #include "hw/arm/virt.h"
+#include "hw/block/flash.h"
 #include "hw/vfio/vfio-calxeda-xgmac.h"
 #include "hw/vfio/vfio-amd-xgbe.h"
 #include "hw/display/ramfb.h"
@@ -878,7 +879,7 @@ static void create_one_flash(const char *name, hwaddr=
 flashbase,
      * parameters as the flash devices on the Versatile Express board.
      */
     DriveInfo *dinfo =3D drive_get_next(IF_PFLASH);
-    DeviceState *dev =3D qdev_create(NULL, "cfi.pflash01");
+    DeviceState *dev =3D qdev_create(NULL, TYPE_PFLASH_CFI01);
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
     const uint64_t sectorlength =3D 256 * 1024;
=20
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index f75f0a6998..1c99aa6e4a 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -59,9 +59,6 @@ do {                                                   =
     \
 #define DPRINTF(fmt, ...) do { } while (0)
 #endif
=20
-#define PFLASH_CFI01(obj) \
-    OBJECT_CHECK(PFlashCFI01, (obj), TYPE_PFLASH_CFI01)
-
 #define PFLASH_BE          0
 #define PFLASH_SECURE      1
=20
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 933de99d6a..915c6171a0 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -57,9 +57,6 @@ do {                                                   =
    \
=20
 #define PFLASH_LAZY_ROMD_THRESHOLD 42
=20
-#define PFLASH_CFI02(obj) \
-    OBJECT_CHECK(PFlashCFI02, (obj), TYPE_PFLASH_CFI02)
-
 struct PFlashCFI02 {
     /*< private >*/
     SysBusDevice parent_obj;
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 3d59a7a356..e05ef75a75 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -167,7 +167,7 @@ static PFlashCFI01 *xtfpga_flash_init(MemoryRegion *a=
ddress_space,
                                       DriveInfo *dinfo, int be)
 {
     SysBusDevice *s;
-    DeviceState *dev =3D qdev_create(NULL, "cfi.pflash01");
+    DeviceState *dev =3D qdev_create(NULL, TYPE_PFLASH_CFI01);
=20
     qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo),
                         &error_abort);
@@ -181,7 +181,7 @@ static PFlashCFI01 *xtfpga_flash_init(MemoryRegion *a=
ddress_space,
     s =3D SYS_BUS_DEVICE(dev);
     memory_region_add_subregion(address_space, board->flash->base,
                                 sysbus_mmio_get_region(s, 0));
-    return OBJECT_CHECK(PFlashCFI01, (dev), "cfi.pflash01");
+    return PFLASH_CFI01(dev);
 }
=20
 static uint64_t translate_phys_addr(void *opaque, uint64_t addr)
diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
index 333005d9ff..aeea3ca99d 100644
--- a/include/hw/block/flash.h
+++ b/include/hw/block/flash.h
@@ -8,6 +8,8 @@
 /* pflash_cfi01.c */
=20
 #define TYPE_PFLASH_CFI01 "cfi.pflash01"
+#define PFLASH_CFI01(obj) \
+    OBJECT_CHECK(PFlashCFI01, (obj), TYPE_PFLASH_CFI01)
=20
 typedef struct PFlashCFI01 PFlashCFI01;
=20
@@ -25,6 +27,8 @@ MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *fl);
 /* pflash_cfi02.c */
=20
 #define TYPE_PFLASH_CFI02 "cfi.pflash02"
+#define PFLASH_CFI02(obj) \
+    OBJECT_CHECK(PFlashCFI02, (obj), TYPE_PFLASH_CFI02)
=20
 typedef struct PFlashCFI02 PFlashCFI02;
=20
--=20
2.17.2
