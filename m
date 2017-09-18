Received: from eggs.gnu.org ([2001:4830:134:3::10]:42946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dtwiW-0000iE-BV
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:08:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dtwiP-0006PA-LO
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:08:08 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:20987
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dtwiP-0006Nj-0O
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:08:01 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Mon, 18 Sep 2017 22:05:13 +0800
Message-ID: <c4d27b4b5d9e37468e63e35214ce4833ca271542.1505737465.git.maozy.fnst@cn.fujitsu.com>
In-Reply-To: <cover.1505737465.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1505737465.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 1/6] hw/ide: Convert DeviceClass init to
 realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Replace init with realize in IDEDeviceClass, which has errp
as a parameter. So all the implementations now use error_setg
instead of error_report for reporting error.

Cc: John Snow <jsnow@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>

Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 hw/ide/core.c                 |  7 ++--
 hw/ide/qdev.c                 | 86 +++++++++++++++++++++----------------------
 include/hw/ide/internal.h     |  5 ++-
 tests/qemu-iotests/051.pc.out | 10 +----
 4 files changed, 51 insertions(+), 57 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index bea3953..dcf3dab 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -34,6 +34,7 @@
 #include "hw/block/block.h"
 #include "sysemu/block-backend.h"
 #include "qemu/cutils.h"
+#include "qemu/error-report.h"
 
 #include "hw/ide/internal.h"
 
@@ -2406,7 +2407,7 @@ int ide_init_drive(IDEState *s, BlockBackend *blk, IDEDriveKind kind,
                    const char *version, const char *serial, const char *model,
                    uint64_t wwn,
                    uint32_t cylinders, uint32_t heads, uint32_t secs,
-                   int chs_trans)
+                   int chs_trans, Error **errp)
 {
     uint64_t nb_sectors;
 
@@ -2431,11 +2432,11 @@ int ide_init_drive(IDEState *s, BlockBackend *blk, IDEDriveKind kind,
         blk_set_guest_block_size(blk, 2048);
     } else {
         if (!blk_is_inserted(s->blk)) {
-            error_report("Device needs media, but drive is empty");
+            error_setg(errp, "Device needs media, but drive is empty");
             return -1;
         }
         if (blk_is_read_only(blk)) {
-            error_report("Can't use a read-only drive");
+            error_setg(errp, "Can't use a read-only drive");
             return -1;
         }
         blk_set_dev_ops(blk, &ide_hd_block_ops, s);
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index cc2f5bd..d60ac25 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -80,7 +80,7 @@ static char *idebus_get_fw_dev_path(DeviceState *dev)
     return g_strdup(path);
 }
 
-static int ide_qdev_init(DeviceState *qdev)
+static void ide_qdev_realize(DeviceState *qdev, Error **errp)
 {
     IDEDevice *dev = IDE_DEVICE(qdev);
     IDEDeviceClass *dc = IDE_DEVICE_GET_CLASS(dev);
@@ -91,34 +91,31 @@ static int ide_qdev_init(DeviceState *qdev)
     }
 
     if (dev->unit >= bus->max_units) {
-        error_report("Can't create IDE unit %d, bus supports only %d units",
+        error_setg(errp, "Can't create IDE unit %d, bus supports only %d units",
                      dev->unit, bus->max_units);
-        goto err;
+        return;
     }
 
     switch (dev->unit) {
     case 0:
         if (bus->master) {
-            error_report("IDE unit %d is in use", dev->unit);
-            goto err;
+            error_setg(errp, "IDE unit %d is in use", dev->unit);
+            return;
         }
         bus->master = dev;
         break;
     case 1:
         if (bus->slave) {
-            error_report("IDE unit %d is in use", dev->unit);
-            goto err;
+            error_setg(errp, "IDE unit %d is in use", dev->unit);
+            return;
         }
         bus->slave = dev;
         break;
     default:
-        error_report("Invalid IDE unit %d", dev->unit);
-        goto err;
+        error_setg(errp, "Invalid IDE unit %d", dev->unit);
+        return;
     }
-    return dc->init(dev);
-
-err:
-    return -1;
+    dc->realize(dev, errp);
 }
 
 IDEDevice *ide_create_drive(IDEBus *bus, int unit, DriveInfo *drive)
@@ -159,7 +156,7 @@ typedef struct IDEDrive {
     IDEDevice dev;
 } IDEDrive;
 
-static int ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind)
+static void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
 {
     IDEBus *bus = DO_UPCAST(IDEBus, qbus, dev->qdev.parent_bus);
     IDEState *s = bus->ifs + dev->unit;
@@ -168,8 +165,8 @@ static int ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind)
 
     if (!dev->conf.blk) {
         if (kind != IDE_CD) {
-            error_report("No drive specified");
-            return -1;
+            error_setg(errp, "No drive specified");
+            return;
         } else {
             /* Anonymous BlockBackend for an empty drive */
             dev->conf.blk = blk_new(0, BLK_PERM_ALL);
@@ -182,36 +179,36 @@ static int ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind)
         dev->conf.discard_granularity = 512;
     } else if (dev->conf.discard_granularity &&
                dev->conf.discard_granularity != 512) {
-        error_report("discard_granularity must be 512 for ide");
-        return -1;
+        error_setg(errp, "discard_granularity must be 512 for ide");
+        return;
     }
 
     blkconf_blocksizes(&dev->conf);
     if (dev->conf.logical_block_size != 512) {
-        error_report("logical_block_size must be 512 for IDE");
-        return -1;
+        error_setg(errp, "logical_block_size must be 512 for IDE");
+        return;
     }
 
     blkconf_serial(&dev->conf, &dev->serial);
     if (kind != IDE_CD) {
         blkconf_geometry(&dev->conf, &dev->chs_trans, 65535, 16, 255, &err);
         if (err) {
-            error_report_err(err);
-            return -1;
+            error_propagate(errp, err);
+            return;
         }
     }
     blkconf_apply_backend_options(&dev->conf, kind == IDE_CD, kind != IDE_CD,
                                   &err);
     if (err) {
-        error_report_err(err);
-        return -1;
+        error_propagate(errp, err);
+        return;
     }
 
     if (ide_init_drive(s, dev->conf.blk, kind,
                        dev->version, dev->serial, dev->model, dev->wwn,
                        dev->conf.cyls, dev->conf.heads, dev->conf.secs,
-                       dev->chs_trans) < 0) {
-        return -1;
+                       dev->chs_trans, errp) < 0) {
+        return;
     }
 
     if (!dev->version) {
@@ -223,8 +220,6 @@ static int ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind)
 
     add_boot_device_path(dev->conf.bootindex, &dev->qdev,
                          dev->unit ? "/disk@1" : "/disk@0");
-
-    return 0;
 }
 
 static void ide_dev_get_bootindex(Object *obj, Visitor *v, const char *name,
@@ -270,17 +265,17 @@ static void ide_dev_instance_init(Object *obj)
     object_property_set_int(obj, -1, "bootindex", NULL);
 }
 
-static int ide_hd_initfn(IDEDevice *dev)
+static void ide_hd_realize(IDEDevice *dev, Error **errp)
 {
-    return ide_dev_initfn(dev, IDE_HD);
+    ide_dev_initfn(dev, IDE_HD, errp);
 }
 
-static int ide_cd_initfn(IDEDevice *dev)
+static void ide_cd_realize(IDEDevice *dev, Error **errp)
 {
-    return ide_dev_initfn(dev, IDE_CD);
+    ide_dev_initfn(dev, IDE_CD, errp);
 }
 
-static int ide_drive_initfn(IDEDevice *dev)
+static void ide_drive_realize(IDEDevice *dev, Error **errp)
 {
     DriveInfo *dinfo = NULL;
 
@@ -288,7 +283,7 @@ static int ide_drive_initfn(IDEDevice *dev)
         dinfo = blk_legacy_dinfo(dev->conf.blk);
     }
 
-    return ide_dev_initfn(dev, dinfo && dinfo->media_cd ? IDE_CD : IDE_HD);
+    ide_dev_initfn(dev, dinfo && dinfo->media_cd ? IDE_CD : IDE_HD, errp);
 }
 
 #define DEFINE_IDE_DEV_PROPERTIES()                     \
@@ -311,10 +306,11 @@ static void ide_hd_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     IDEDeviceClass *k = IDE_DEVICE_CLASS(klass);
-    k->init = ide_hd_initfn;
+
+    k->realize  = ide_hd_realize;
     dc->fw_name = "drive";
-    dc->desc = "virtual IDE disk";
-    dc->props = ide_hd_properties;
+    dc->desc    = "virtual IDE disk";
+    dc->props   = ide_hd_properties;
 }
 
 static const TypeInfo ide_hd_info = {
@@ -333,10 +329,11 @@ static void ide_cd_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     IDEDeviceClass *k = IDE_DEVICE_CLASS(klass);
-    k->init = ide_cd_initfn;
+
+    k->realize  = ide_cd_realize;
     dc->fw_name = "drive";
-    dc->desc = "virtual IDE CD-ROM";
-    dc->props = ide_cd_properties;
+    dc->desc    = "virtual IDE CD-ROM";
+    dc->props   = ide_cd_properties;
 }
 
 static const TypeInfo ide_cd_info = {
@@ -355,10 +352,11 @@ static void ide_drive_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     IDEDeviceClass *k = IDE_DEVICE_CLASS(klass);
-    k->init = ide_drive_initfn;
+
+    k->realize  = ide_drive_realize;
     dc->fw_name = "drive";
-    dc->desc = "virtual IDE disk or CD-ROM (legacy)";
-    dc->props = ide_drive_properties;
+    dc->desc    = "virtual IDE disk or CD-ROM (legacy)";
+    dc->props   = ide_drive_properties;
 }
 
 static const TypeInfo ide_drive_info = {
@@ -371,7 +369,7 @@ static const TypeInfo ide_drive_info = {
 static void ide_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
-    k->init = ide_qdev_init;
+    k->realize = ide_qdev_realize;
     set_bit(DEVICE_CATEGORY_STORAGE, k->categories);
     k->bus_type = TYPE_IDE_BUS;
     k->props = ide_props;
diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 482a951..5ebb4c9 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -12,6 +12,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/block/block.h"
 #include "block/scsi.h"
+#include "qapi/error.h"
 
 /* debug IDE devices */
 //#define DEBUG_IDE
@@ -495,7 +496,7 @@ struct IDEBus {
 
 typedef struct IDEDeviceClass {
     DeviceClass parent_class;
-    int (*init)(IDEDevice *dev);
+    void (*realize)(IDEDevice *dev, Error **errp);
 } IDEDeviceClass;
 
 struct IDEDevice {
@@ -605,7 +606,7 @@ int ide_init_drive(IDEState *s, BlockBackend *blk, IDEDriveKind kind,
                    const char *version, const char *serial, const char *model,
                    uint64_t wwn,
                    uint32_t cylinders, uint32_t heads, uint32_t secs,
-                   int chs_trans);
+                   int chs_trans, Error **errp);
 void ide_init2(IDEBus *bus, qemu_irq irq);
 void ide_exit(IDEState *s);
 void ide_init_ioport(IDEBus *bus, ISADevice *isa, int iobase, int iobase2);
diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
index 76d7205..762fb9f 100644
--- a/tests/qemu-iotests/051.pc.out
+++ b/tests/qemu-iotests/051.pc.out
@@ -123,8 +123,7 @@ quit
 
 Testing: -drive if=ide
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: Device needs media, but drive is empty
-QEMU_PROG: Initialization of device ide-hd failed: Device initialization failed.
+(qemu) QEMU_PROG: Initialization of device ide-hd failed: Device needs media, but drive is empty
 
 Testing: -drive if=scsi
 QEMU X.Y.Z monitor - type 'help' for more information
@@ -146,12 +145,10 @@ QEMU X.Y.Z monitor - type 'help' for more information
 Testing: -drive if=none,id=disk -device ide-drive,drive=disk
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) QEMU_PROG: -device ide-drive,drive=disk: Device needs media, but drive is empty
-QEMU_PROG: -device ide-drive,drive=disk: Device initialization failed.
 
 Testing: -drive if=none,id=disk -device ide-hd,drive=disk
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) QEMU_PROG: -device ide-hd,drive=disk: Device needs media, but drive is empty
-QEMU_PROG: -device ide-hd,drive=disk: Device initialization failed.
 
 Testing: -drive if=none,id=disk -device lsi53c895a -device scsi-disk,drive=disk
 QEMU X.Y.Z monitor - type 'help' for more information
@@ -179,8 +176,7 @@ quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=ide,readonly=on
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: Block node is read-only
-QEMU_PROG: Initialization of device ide-hd failed: Device initialization failed.
+(qemu) QEMU_PROG: Initialization of device ide-hd failed: Block node is read-only
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=scsi,readonly=on
 QEMU X.Y.Z monitor - type 'help' for more information
@@ -202,12 +198,10 @@ QEMU X.Y.Z monitor - type 'help' for more information
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,id=disk,readonly=on -device ide-drive,drive=disk
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) QEMU_PROG: -device ide-drive,drive=disk: Block node is read-only
-QEMU_PROG: -device ide-drive,drive=disk: Device initialization failed.
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,id=disk,readonly=on -device ide-hd,drive=disk
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) QEMU_PROG: -device ide-hd,drive=disk: Block node is read-only
-QEMU_PROG: -device ide-hd,drive=disk: Device initialization failed.
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,id=disk,readonly=on -device lsi53c895a -device scsi-disk,drive=disk
 QEMU X.Y.Z monitor - type 'help' for more information
-- 
2.9.4
