Received: from eggs.gnu.org ([209.51.188.92]:54178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gj3Ar-0001f8-7A
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:25:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gj3Ao-0008Vq-EB
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:25:09 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Mon, 14 Jan 2019 16:24:01 +0200
Message-Id: <af08f836feae53a54ec2abed93161fdfa381ad2c.1547475602.git.berto@igalia.com>
In-Reply-To: <cover.1547475602.git.berto@igalia.com>
References: <cover.1547475602.git.berto@igalia.com>
In-Reply-To: <cover.1547475602.git.berto@igalia.com>
References: <cover.1547475602.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 3/6] block: Acquire the AioContext in
 floppy_drive_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alberto Garcia <berto@igalia.com>

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 hw/block/fdc.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 6f19f127a5..d9bc80de83 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -512,6 +512,7 @@ static void floppy_drive_realize(DeviceState *qdev, Error **errp)
 {
     FloppyDrive *dev = FLOPPY_DRIVE(qdev);
     FloppyBus *bus = FLOPPY_BUS(qdev->parent_bus);
+    AioContext *ctx;
     FDrive *drive;
     int ret;
 
@@ -543,13 +544,16 @@ static void floppy_drive_realize(DeviceState *qdev, Error **errp)
         assert(ret == 0);
     }
 
+    ctx = blk_get_aio_context(dev->conf.blk);
+    aio_context_acquire(ctx);
+
     blkconf_blocksizes(&dev->conf);
     if (dev->conf.logical_block_size != 512 ||
         dev->conf.physical_block_size != 512)
     {
         error_setg(errp, "Physical and logical block size must "
                    "be 512 for floppy");
-        return;
+        goto out;
     }
 
     /* rerror/werror aren't supported by fdc and therefore not even registered
@@ -561,7 +565,7 @@ static void floppy_drive_realize(DeviceState *qdev, Error **errp)
     if (!blkconf_apply_backend_options(&dev->conf,
                                        blk_is_read_only(dev->conf.blk),
                                        false, errp)) {
-        return;
+        goto out;
     }
 
     /* 'enospc' is the default for -drive, 'report' is what blk_new() gives us
@@ -569,11 +573,11 @@ static void floppy_drive_realize(DeviceState *qdev, Error **errp)
     if (blk_get_on_error(dev->conf.blk, 0) != BLOCKDEV_ON_ERROR_ENOSPC &&
         blk_get_on_error(dev->conf.blk, 0) != BLOCKDEV_ON_ERROR_REPORT) {
         error_setg(errp, "fdc doesn't support drive option werror");
-        return;
+        goto out;
     }
     if (blk_get_on_error(dev->conf.blk, 1) != BLOCKDEV_ON_ERROR_REPORT) {
         error_setg(errp, "fdc doesn't support drive option rerror");
-        return;
+        goto out;
     }
 
     drive->conf = &dev->conf;
@@ -589,6 +593,9 @@ static void floppy_drive_realize(DeviceState *qdev, Error **errp)
     dev->type = drive->drive;
 
     fd_revalidate(drive);
+
+out:
+    aio_context_release(ctx);
 }
 
 static void floppy_drive_class_init(ObjectClass *klass, void *data)
-- 
2.11.0
