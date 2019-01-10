Received: from eggs.gnu.org ([209.51.188.92]:46108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ghbsJ-00031u-A2
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 10:04:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ghbsG-0007OD-Ff
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 10:04:01 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 10 Jan 2019 17:03:39 +0200
Message-Id: <dfb5eaaf8a0e102ed662c8bfdf82f13787d2382e.1547132561.git.berto@igalia.com>
In-Reply-To: <cover.1547132561.git.berto@igalia.com>
References: <cover.1547132561.git.berto@igalia.com>
In-Reply-To: <cover.1547132561.git.berto@igalia.com>
References: <cover.1547132561.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 5/6] block: Acquire the AioContext in
 ide_dev_initfn()
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

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 hw/ide/qdev.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 573b022e1e..f355f2a352 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -160,6 +160,7 @@ static void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
 {
     IDEBus *bus = DO_UPCAST(IDEBus, qbus, dev->qdev.parent_bus);
     IDEState *s = bus->ifs + dev->unit;
+    AioContext *ctx;
     int ret;
 
     if (!dev->conf.blk) {
@@ -174,36 +175,39 @@ static void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
         }
     }
 
+    ctx = blk_get_aio_context(dev->conf.blk);
+    aio_context_acquire(ctx);
+
     if (dev->conf.discard_granularity == -1) {
         dev->conf.discard_granularity = 512;
     } else if (dev->conf.discard_granularity &&
                dev->conf.discard_granularity != 512) {
         error_setg(errp, "discard_granularity must be 512 for ide");
-        return;
+        goto out;
     }
 
     blkconf_blocksizes(&dev->conf);
     if (dev->conf.logical_block_size != 512) {
         error_setg(errp, "logical_block_size must be 512 for IDE");
-        return;
+        goto out;
     }
 
     if (kind != IDE_CD) {
         if (!blkconf_geometry(&dev->conf, &dev->chs_trans, 65535, 16, 255,
                               errp)) {
-            return;
+            goto out;
         }
     }
     if (!blkconf_apply_backend_options(&dev->conf, kind == IDE_CD,
                                        kind != IDE_CD, errp)) {
-        return;
+        goto out;
     }
 
     if (ide_init_drive(s, dev->conf.blk, kind,
                        dev->version, dev->serial, dev->model, dev->wwn,
                        dev->conf.cyls, dev->conf.heads, dev->conf.secs,
                        dev->chs_trans, errp) < 0) {
-        return;
+        goto out;
     }
 
     if (!dev->version) {
@@ -215,6 +219,9 @@ static void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
 
     add_boot_device_path(dev->conf.bootindex, &dev->qdev,
                          dev->unit ? "/disk@1" : "/disk@0");
+
+out:
+    aio_context_release(ctx);
 }
 
 static void ide_dev_get_bootindex(Object *obj, Visitor *v, const char *name,
-- 
2.11.0
