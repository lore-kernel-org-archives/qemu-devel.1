Received: from eggs.gnu.org ([209.51.188.92]:50857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gm1wL-0008Pi-Vg
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:42:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gm1wK-0001Ph-16
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:42:29 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Tue, 22 Jan 2019 17:53:22 +0200
Message-Id: <fd8204fddd979714d15b993d38c893d201d3cb7b.1548171741.git.berto@igalia.com>
In-Reply-To: <cover.1548171741.git.berto@igalia.com>
References: <cover.1548171741.git.berto@igalia.com>
In-Reply-To: <cover.1548171741.git.berto@igalia.com>
References: <cover.1548171741.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 2/3] scsi-disk: Acquire the AioContext in
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
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This fixes a crash when attaching two disks with the same blockdev to
a SCSI device that is using iothreads. Test case included.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 hw/scsi/scsi-disk.c        | 23 ++++++++++++++++++++---
 tests/qemu-iotests/240     | 18 ++++++++++++++++++
 tests/qemu-iotests/240.out | 16 ++++++++++++++++
 3 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 0e9027c8f3..b049026219 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2381,10 +2381,13 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
 static void scsi_hd_realize(SCSIDevice *dev, Error **errp)
 {
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, dev);
+    AioContext *ctx = NULL;
     /* can happen for devices without drive. The error message for missing
      * backend will be issued in scsi_realize
      */
     if (s->qdev.conf.blk) {
+        ctx = blk_get_aio_context(s->qdev.conf.blk);
+        aio_context_acquire(ctx);
         blkconf_blocksizes(&s->qdev.conf);
     }
     s->qdev.blocksize = s->qdev.conf.logical_block_size;
@@ -2393,11 +2396,15 @@ static void scsi_hd_realize(SCSIDevice *dev, Error **errp)
         s->product = g_strdup("QEMU HARDDISK");
     }
     scsi_realize(&s->qdev, errp);
+    if (ctx) {
+        aio_context_release(ctx);
+    }
 }
 
 static void scsi_cd_realize(SCSIDevice *dev, Error **errp)
 {
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, dev);
+    AioContext *ctx;
     int ret;
 
     if (!dev->conf.blk) {
@@ -2408,6 +2415,8 @@ static void scsi_cd_realize(SCSIDevice *dev, Error **errp)
         assert(ret == 0);
     }
 
+    ctx = blk_get_aio_context(dev->conf.blk);
+    aio_context_acquire(ctx);
     s->qdev.blocksize = 2048;
     s->qdev.type = TYPE_ROM;
     s->features |= 1 << SCSI_DISK_F_REMOVABLE;
@@ -2415,6 +2424,7 @@ static void scsi_cd_realize(SCSIDevice *dev, Error **errp)
         s->product = g_strdup("QEMU CD-ROM");
     }
     scsi_realize(&s->qdev, errp);
+    aio_context_release(ctx);
 }
 
 static void scsi_disk_realize(SCSIDevice *dev, Error **errp)
@@ -2553,6 +2563,7 @@ static int get_device_type(SCSIDiskState *s)
 static void scsi_block_realize(SCSIDevice *dev, Error **errp)
 {
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, dev);
+    AioContext *ctx;
     int sg_version;
     int rc;
 
@@ -2567,6 +2578,9 @@ static void scsi_block_realize(SCSIDevice *dev, Error **errp)
                           "be removed in a future version");
     }
 
+    ctx = blk_get_aio_context(s->qdev.conf.blk);
+    aio_context_acquire(ctx);
+
     /* check we are using a driver managing SG_IO (version 3 and after) */
     rc = blk_ioctl(s->qdev.conf.blk, SG_GET_VERSION_NUM, &sg_version);
     if (rc < 0) {
@@ -2574,18 +2588,18 @@ static void scsi_block_realize(SCSIDevice *dev, Error **errp)
         if (rc != -EPERM) {
             error_append_hint(errp, "Is this a SCSI device?\n");
         }
-        return;
+        goto out;
     }
     if (sg_version < 30000) {
         error_setg(errp, "scsi generic interface too old");
-        return;
+        goto out;
     }
 
     /* get device type from INQUIRY data */
     rc = get_device_type(s);
     if (rc < 0) {
         error_setg(errp, "INQUIRY failed");
-        return;
+        goto out;
     }
 
     /* Make a guess for the block size, we'll fix it when the guest sends.
@@ -2605,6 +2619,9 @@ static void scsi_block_realize(SCSIDevice *dev, Error **errp)
 
     scsi_realize(&s->qdev, errp);
     scsi_generic_read_device_inquiry(&s->qdev);
+
+out:
+    aio_context_release(ctx);
 }
 
 typedef struct SCSIBlockReq {
diff --git a/tests/qemu-iotests/240 b/tests/qemu-iotests/240
index ead7ee08eb..5d499c9a00 100755
--- a/tests/qemu-iotests/240
+++ b/tests/qemu-iotests/240
@@ -83,6 +83,24 @@ run_qemu <<EOF
 { "execute": "quit"}
 EOF
 
+echo
+echo === Attach two SCSI disks using the same block device and the same iothread ===
+echo
+
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name": "hd0", "read-only": true}}
+{ "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread0"}}
+{ "execute": "device_add", "arguments": {"id": "scsi0", "driver": "${virtio_scsi}", "iothread": "iothread0"}}
+{ "execute": "device_add", "arguments": {"id": "scsi-hd0", "driver": "scsi-hd", "drive": "hd0"}}
+{ "execute": "device_add", "arguments": {"id": "scsi-hd1", "driver": "scsi-hd", "drive": "hd0"}}
+{ "execute": "device_del", "arguments": {"id": "scsi-hd0"}}
+{ "execute": "device_del", "arguments": {"id": "scsi-hd1"}}
+{ "execute": "device_del", "arguments": {"id": "scsi0"}}
+{ "execute": "blockdev-del", "arguments": {"node-name": "hd0"}}
+{ "execute": "quit"}
+EOF
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/240.out b/tests/qemu-iotests/240.out
index 432d98111c..701cb5c7d2 100644
--- a/tests/qemu-iotests/240.out
+++ b/tests/qemu-iotests/240.out
@@ -15,4 +15,20 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
+
+=== Attach two SCSI disks using the same block device and the same iothread ===
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
 *** done
-- 
2.11.0
