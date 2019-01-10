Received: from eggs.gnu.org ([209.51.188.92]:46203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ghbsN-00036w-Vx
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 10:04:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ghbsG-0007OR-Gm
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 10:04:06 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 10 Jan 2019 17:03:35 +0200
Message-Id: <4a595def20efc9d1d076850d79a2c7e6d0996ffd.1547132561.git.berto@igalia.com>
In-Reply-To: <cover.1547132561.git.berto@igalia.com>
References: <cover.1547132561.git.berto@igalia.com>
In-Reply-To: <cover.1547132561.git.berto@igalia.com>
References: <cover.1547132561.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 1/6] block: Acquire the AioContext in
 virtio_blk_device_realize()
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
  "arguments": {"id": "virtio0", "driver": "virtio-blk-pci",
                "drive": "hd0"}}
qemu: qemu_mutex_unlock_impl: Operation not permitted
Aborted

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 hw/block/virtio-blk.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index f208c6ddb9..5357da82af 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -912,6 +912,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOBlock *s = VIRTIO_BLK(dev);
     VirtIOBlkConf *conf = &s->conf;
+    AioContext *ctx;
     Error *err = NULL;
     unsigned i;
 
@@ -919,30 +920,34 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "drive property not set");
         return;
     }
+
+    ctx = blk_get_aio_context(conf->conf.blk);
+    aio_context_acquire(ctx);
+
     if (!blk_is_inserted(conf->conf.blk)) {
         error_setg(errp, "Device needs media, but drive is empty");
-        return;
+        goto out;
     }
     if (!conf->num_queues) {
         error_setg(errp, "num-queues property must be larger than 0");
-        return;
+        goto out;
     }
     if (!is_power_of_2(conf->queue_size) ||
         conf->queue_size > VIRTQUEUE_MAX_SIZE) {
         error_setg(errp, "invalid queue-size property (%" PRIu16 "), "
                    "must be a power of 2 (max %d)",
                    conf->queue_size, VIRTQUEUE_MAX_SIZE);
-        return;
+        goto out;
     }
 
     if (!blkconf_apply_backend_options(&conf->conf,
                                        blk_is_read_only(conf->conf.blk), true,
                                        errp)) {
-        return;
+        goto out;
     }
     s->original_wce = blk_enable_write_cache(conf->conf.blk);
     if (!blkconf_geometry(&conf->conf, NULL, 65535, 255, 255, errp)) {
-        return;
+        goto out;
     }
 
     blkconf_blocksizes(&conf->conf);
@@ -951,7 +956,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
         conf->conf.physical_block_size) {
         error_setg(errp,
                    "logical_block_size > physical_block_size not supported");
-        return;
+        goto out;
     }
 
     virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK,
@@ -968,7 +973,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
     if (err != NULL) {
         error_propagate(errp, err);
         virtio_cleanup(vdev);
-        return;
+        goto out;
     }
 
     s->change = qemu_add_vm_change_state_handler(virtio_blk_dma_restart_cb, s);
@@ -976,6 +981,9 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
     blk_set_guest_block_size(s->blk, s->conf.conf.logical_block_size);
 
     blk_iostatus_enable(s->blk);
+
+out:
+    aio_context_release(ctx);
 }
 
 static void virtio_blk_device_unrealize(DeviceState *dev, Error **errp)
-- 
2.11.0
