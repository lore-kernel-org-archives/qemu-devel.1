Received: from eggs.gnu.org ([209.51.188.92]:46113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ghbsJ-000324-FJ
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 10:04:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ghbsG-0007O1-EW
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 10:04:03 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 10 Jan 2019 17:03:36 +0200
Message-Id: <42c8dab1efbcd608a09a1d84468fc498b612bfa1.1547132561.git.berto@igalia.com>
In-Reply-To: <cover.1547132561.git.berto@igalia.com>
References: <cover.1547132561.git.berto@igalia.com>
In-Reply-To: <cover.1547132561.git.berto@igalia.com>
References: <cover.1547132561.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 2/6] block: Acquire the AioContext in
 scsi_*_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This fixes the following crash:

{ "execute": "blockdev-add",
  "arguments": {"driver": "null-co", "node-name": "hd0"}}
{ "execute": "object-add",
  "arguments": {"qom-type": "iothread", "id": "iothread0"}}
{ "execute": "x-blockdev-set-iothread",
  "arguments": {"node-name": "hd0", "iothread": "iothread0"}}
{ "execute": "device_add",
   "arguments": {"id": "scsi-pci0", "driver": "virtio-scsi-pci"}}
{ "execute": "device_add",
  "arguments": {"id": "scsi-hd0", "driver": "scsi-hd", "drive": "hd0"}}
qemu: qemu_mutex_unlock_impl: Operation not permitted
Aborted

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 hw/scsi/scsi-disk.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 0e9027c8f3..8a22def7f3 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2318,16 +2318,20 @@ static void scsi_disk_unit_attention_reported(SCSIDevice *dev)
 static void scsi_realize(SCSIDevice *dev, Error **errp)
 {
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, dev);
+    AioContext *ctx;
 
     if (!s->qdev.conf.blk) {
         error_setg(errp, "drive property not set");
         return;
     }
 
+    ctx = blk_get_aio_context(s->qdev.conf.blk);
+    aio_context_acquire(ctx);
+
     if (!(s->features & (1 << SCSI_DISK_F_REMOVABLE)) &&
         !blk_is_inserted(s->qdev.conf.blk)) {
         error_setg(errp, "Device needs media, but drive is empty");
-        return;
+        goto out;
     }
 
     blkconf_blocksizes(&s->qdev.conf);
@@ -2336,18 +2340,18 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
         s->qdev.conf.physical_block_size) {
         error_setg(errp,
                    "logical_block_size > physical_block_size not supported");
-        return;
+        goto out;
     }
 
     if (dev->type == TYPE_DISK) {
         if (!blkconf_geometry(&dev->conf, NULL, 65535, 255, 255, errp)) {
-            return;
+            goto out;
         }
     }
     if (!blkconf_apply_backend_options(&dev->conf,
                                        blk_is_read_only(s->qdev.conf.blk),
                                        dev->type == TYPE_DISK, errp)) {
-        return;
+        goto out;
     }
 
     if (s->qdev.conf.discard_granularity == -1) {
@@ -2364,7 +2368,7 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
 
     if (blk_is_sg(s->qdev.conf.blk)) {
         error_setg(errp, "unwanted /dev/sg*");
-        return;
+        goto out;
     }
 
     if ((s->features & (1 << SCSI_DISK_F_REMOVABLE)) &&
@@ -2376,6 +2380,9 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
     blk_set_guest_block_size(s->qdev.conf.blk, s->qdev.blocksize);
 
     blk_iostatus_enable(s->qdev.conf.blk);
+
+out:
+    aio_context_release(ctx);
 }
 
 static void scsi_hd_realize(SCSIDevice *dev, Error **errp)
@@ -2385,7 +2392,10 @@ static void scsi_hd_realize(SCSIDevice *dev, Error **errp)
      * backend will be issued in scsi_realize
      */
     if (s->qdev.conf.blk) {
+        AioContext *ctx = blk_get_aio_context(s->qdev.conf.blk);
+        aio_context_acquire(ctx);
         blkconf_blocksizes(&s->qdev.conf);
+        aio_context_release(ctx);
     }
     s->qdev.blocksize = s->qdev.conf.logical_block_size;
     s->qdev.type = TYPE_DISK;
@@ -2553,6 +2563,7 @@ static int get_device_type(SCSIDiskState *s)
 static void scsi_block_realize(SCSIDevice *dev, Error **errp)
 {
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, dev);
+    AioContext *ctx;
     int sg_version;
     int rc;
 
@@ -2568,7 +2579,10 @@ static void scsi_block_realize(SCSIDevice *dev, Error **errp)
     }
 
     /* check we are using a driver managing SG_IO (version 3 and after) */
+    ctx = blk_get_aio_context(s->qdev.conf.blk);
+    aio_context_acquire(ctx);
     rc = blk_ioctl(s->qdev.conf.blk, SG_GET_VERSION_NUM, &sg_version);
+    aio_context_release(ctx);
     if (rc < 0) {
         error_setg_errno(errp, -rc, "cannot get SG_IO version number");
         if (rc != -EPERM) {
-- 
2.11.0
