Received: from eggs.gnu.org ([2001:4830:134:3::10]:42950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dtwiW-0000iH-IN
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:08:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dtwiO-0006OU-C6
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:08:08 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:20987
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dtwiN-0006Nj-OF
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:08:00 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Mon, 18 Sep 2017 22:05:14 +0800
Message-ID: <87119b34f32e2acf7166165fb5d8e6fca787b3bc.1505737465.git.maozy.fnst@cn.fujitsu.com>
In-Reply-To: <cover.1505737465.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1505737465.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 2/6] hw/block/fdc: Convert to realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>

Convert floppy_drive_init() to realize and rename it to
floppy_drive_realize().

Cc: John Snow <jsnow@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>

Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
---
 hw/block/fdc.c             | 33 ++++++++++++++++-----------------
 tests/qemu-iotests/172.out |  8 --------
 2 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index db40e17..2853cdc 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -517,7 +517,7 @@ static Property floppy_drive_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static int floppy_drive_init(DeviceState *qdev)
+static void floppy_drive_realize(DeviceState *qdev, Error **errp)
 {
     FloppyDrive *dev = FLOPPY_DRIVE(qdev);
     FloppyBus *bus = FLOPPY_BUS(qdev->parent_bus);
@@ -535,15 +535,15 @@ static int floppy_drive_init(DeviceState *qdev)
     }
 
     if (dev->unit >= MAX_FD) {
-        error_report("Can't create floppy unit %d, bus supports only %d units",
-                     dev->unit, MAX_FD);
-        return -1;
+        error_setg(errp, "Can't create floppy unit %d, bus supports "
+                   "only %d units", dev->unit, MAX_FD);
+        return;
     }
 
     drive = get_drv(bus->fdc, dev->unit);
     if (drive->blk) {
-        error_report("Floppy unit %d is in use", dev->unit);
-        return -1;
+        error_setg(errp, "Floppy unit %d is in use", dev->unit);
+        return;
     }
 
     if (!dev->conf.blk) {
@@ -557,8 +557,9 @@ static int floppy_drive_init(DeviceState *qdev)
     if (dev->conf.logical_block_size != 512 ||
         dev->conf.physical_block_size != 512)
     {
-        error_report("Physical and logical block size must be 512 for floppy");
-        return -1;
+        error_setg(errp, "Physical and logical block size must "
+                   "be 512 for floppy");
+        return;
     }
 
     /* rerror/werror aren't supported by fdc and therefore not even registered
@@ -570,20 +571,20 @@ static int floppy_drive_init(DeviceState *qdev)
     blkconf_apply_backend_options(&dev->conf, blk_is_read_only(dev->conf.blk),
                                   false, &local_err);
     if (local_err) {
-        error_report_err(local_err);
-        return -1;
+        error_propagate(errp, local_err);
+        return;
     }
 
     /* 'enospc' is the default for -drive, 'report' is what blk_new() gives us
      * for empty drives. */
     if (blk_get_on_error(dev->conf.blk, 0) != BLOCKDEV_ON_ERROR_ENOSPC &&
         blk_get_on_error(dev->conf.blk, 0) != BLOCKDEV_ON_ERROR_REPORT) {
-        error_report("fdc doesn't support drive option werror");
-        return -1;
+        error_setg(errp, "fdc doesn't support drive option werror");
+        return;
     }
     if (blk_get_on_error(dev->conf.blk, 1) != BLOCKDEV_ON_ERROR_REPORT) {
-        error_report("fdc doesn't support drive option rerror");
-        return -1;
+        error_setg(errp, "fdc doesn't support drive option rerror");
+        return;
     }
 
     drive->conf = &dev->conf;
@@ -599,14 +600,12 @@ static int floppy_drive_init(DeviceState *qdev)
     dev->type = drive->drive;
 
     fd_revalidate(drive);
-
-    return 0;
 }
 
 static void floppy_drive_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
-    k->init = floppy_drive_init;
+    k->realize = floppy_drive_realize;
     set_bit(DEVICE_CATEGORY_STORAGE, k->categories);
     k->bus_type = TYPE_FLOPPY_BUS;
     k->props = floppy_drive_properties;
diff --git a/tests/qemu-iotests/172.out b/tests/qemu-iotests/172.out
index 2732966..7abbe82 100644
--- a/tests/qemu-iotests/172.out
+++ b/tests/qemu-iotests/172.out
@@ -725,11 +725,9 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
 
 Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device floppy,drive=none0,unit=0
 QEMU_PROG: -device floppy,drive=none0,unit=0: Floppy unit 0 is in use
-QEMU_PROG: -device floppy,drive=none0,unit=0: Device initialization failed.
 
 Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device floppy,drive=none0,unit=1
 QEMU_PROG: -device floppy,drive=none0,unit=1: Floppy unit 1 is in use
-QEMU_PROG: -device floppy,drive=none0,unit=1: Device initialization failed.
 
 
 === Mixing -drive and -device ===
@@ -812,7 +810,6 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
 
 Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device floppy,drive=none0,unit=0
 QEMU_PROG: -device floppy,drive=none0,unit=0: Floppy unit 0 is in use
-QEMU_PROG: -device floppy,drive=none0,unit=0: Device initialization failed.
 
 
 === Mixing -global and -device ===
@@ -971,18 +968,15 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveA=none0 -device floppy,drive=none1,unit=0
 QEMU_PROG: -device floppy,drive=none1,unit=0: Floppy unit 0 is in use
-QEMU_PROG: -device floppy,drive=none1,unit=0: Device initialization failed.
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveB=none0 -device floppy,drive=none1,unit=1
 QEMU_PROG: -device floppy,drive=none1,unit=1: Floppy unit 1 is in use
-QEMU_PROG: -device floppy,drive=none1,unit=1: Device initialization failed.
 
 
 === Too many floppy drives ===
 
 Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -drive if=none,file=TEST_DIR/t.qcow2.3 -global isa-fdc.driveB=none0 -device floppy,drive=none1
 QEMU_PROG: -device floppy,drive=none1: Can't create floppy unit 2, bus supports only 2 units
-QEMU_PROG: -device floppy,drive=none1: Device initialization failed.
 
 
 === Creating an empty drive with anonymous BB ===
@@ -1211,11 +1205,9 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,physica
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,logical_block_size=4096
 QEMU_PROG: -device floppy,drive=none0,logical_block_size=4096: Physical and logical block size must be 512 for floppy
-QEMU_PROG: -device floppy,drive=none0,logical_block_size=4096: Device initialization failed.
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,physical_block_size=1024
 QEMU_PROG: -device floppy,drive=none0,physical_block_size=1024: Physical and logical block size must be 512 for floppy
-QEMU_PROG: -device floppy,drive=none0,physical_block_size=1024: Device initialization failed.
 
 
 === Writethrough caching ===
-- 
2.9.4
