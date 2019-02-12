Received: from eggs.gnu.org ([209.51.188.92]:56234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1gtR29-0002ow-4l
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 00:55:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1gtQrT-0003Us-1I
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 00:44:05 -0500
Received: from mga14.intel.com ([192.55.52.115]:53245)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1gtQrM-0002vl-Mr
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 00:43:57 -0500
From: Changpeng Liu <changpeng.liu@intel.com>
Date: Tue, 12 Feb 2019 14:01:44 +0800
Message-Id: <1549951304-26100-1-git-send-email-changpeng.liu@intel.com>
Subject: [Qemu-devel] [PATCH v2] virtio-blk: set correct config size for the
 host driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, stefanha@redhat.com, sgarzare@redhat.com, dgilbert@redhat.com, ldoktor@redhat.com, changpeng.liu@intel.com

Commit caa1ee43 "vhost-user-blk: add discard/write zeroes features support"
introduced extra fields to existing struct virtio_blk_config, when
migration was executed from older QEMU version to current head, it
will break the migration.  While here, set the correct config size
when initializing the host driver, for now, discard/write zeroes
are not supported by virtio-blk host driver, so set the config
size as before, users can change config size when adding the new
feature bits support.

Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
---
 hw/block/virtio-blk.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 9a87b3b..846b7b9 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -28,6 +28,9 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
 
+#define VIRTIO_BLK_CFG_SIZE (offsetof(struct virtio_blk_config, num_queues) + \
+                             sizeof_field(struct virtio_blk_config, num_queues))
+
 static void virtio_blk_init_request(VirtIOBlock *s, VirtQueue *vq,
                                     VirtIOBlockReq *req)
 {
@@ -761,7 +764,7 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
     blkcfg.alignment_offset = 0;
     blkcfg.wce = blk_enable_write_cache(s->blk);
     virtio_stw_p(vdev, &blkcfg.num_queues, s->conf.num_queues);
-    memcpy(config, &blkcfg, sizeof(struct virtio_blk_config));
+    memcpy(config, &blkcfg, VIRTIO_BLK_CFG_SIZE);
 }
 
 static void virtio_blk_set_config(VirtIODevice *vdev, const uint8_t *config)
@@ -769,7 +772,7 @@ static void virtio_blk_set_config(VirtIODevice *vdev, const uint8_t *config)
     VirtIOBlock *s = VIRTIO_BLK(vdev);
     struct virtio_blk_config blkcfg;
 
-    memcpy(&blkcfg, config, sizeof(blkcfg));
+    memcpy(&blkcfg, config, VIRTIO_BLK_CFG_SIZE);
 
     aio_context_acquire(blk_get_aio_context(s->blk));
     blk_set_enable_write_cache(s->blk, blkcfg.wce != 0);
@@ -952,8 +955,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK,
-                sizeof(struct virtio_blk_config));
+    virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK, VIRTIO_BLK_CFG_SIZE);
 
     s->blk = conf->conf.blk;
     s->rq = NULL;
-- 
1.9.3
