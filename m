Received: from eggs.gnu.org ([2001:4830:134:3::10]:46083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwXO-00079l-Eu
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:37:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwXJ-0007TF-Qu
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:37:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eQwXJ-0007SM-Km
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:36:57 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 18 Dec 2017 14:35:23 +0000
Message-Id: <20171218143530.12082-17-stefanha@redhat.com>
In-Reply-To: <20171218143530.12082-1-stefanha@redhat.com>
References: <20171218143530.12082-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 16/23] virtio-blk: make queue size configurable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Mark Kanda <mark.kanda@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Mark Kanda <mark.kanda@oracle.com>

Depending on the configuration, it can be beneficial to adjust the virtio-blk
queue size to something other than the current default of 128. Add a new
property to make the queue size configurable.

Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Ameya More <ameya.more@oracle.com>
Message-id: 52e6d742811f10dbd16e996e86cf375b9577c187.1513005190.git.mark.kanda@oracle.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/virtio/virtio-blk.h |  1 +
 hw/block/virtio-blk.c          | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
index d3c8a6fa8c..5117431d96 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -39,6 +39,7 @@ struct VirtIOBlkConf
     uint32_t config_wce;
     uint32_t request_merging;
     uint16_t num_queues;
+    uint16_t queue_size;
 };
 
 struct VirtIOBlockDataPlane;
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index ae3356f6a8..d8cfdc81f6 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -927,6 +927,13 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "num-queues property must be larger than 0");
         return;
     }
+    if (!is_power_of_2(conf->queue_size) ||
+        conf->queue_size > VIRTQUEUE_MAX_SIZE) {
+        error_setg(errp, "invalid queue-size property (%" PRIu16 "), "
+                   "must be a power of 2 (max %d)",
+                   conf->queue_size, VIRTQUEUE_MAX_SIZE);
+        return;
+    }
 
     blkconf_serial(&conf->conf, &conf->serial);
     if (!blkconf_apply_backend_options(&conf->conf,
@@ -949,7 +956,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
     s->sector_mask = (s->conf.conf.logical_block_size / BDRV_SECTOR_SIZE) - 1;
 
     for (i = 0; i < conf->num_queues; i++) {
-        virtio_add_queue(vdev, 128, virtio_blk_handle_output);
+        virtio_add_queue(vdev, conf->queue_size, virtio_blk_handle_output);
     }
     if (!virtio_blk_data_plane_create(vdev, conf, &s->dataplane, errp)) {
         virtio_cleanup(vdev);
@@ -1006,6 +1013,7 @@ static Property virtio_blk_properties[] = {
     DEFINE_PROP_BIT("request-merging", VirtIOBlock, conf.request_merging, 0,
                     true),
     DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues, 1),
+    DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size, 128),
     DEFINE_PROP_LINK("iothread", VirtIOBlock, conf.iothread, TYPE_IOTHREAD,
                      IOThread *),
     DEFINE_PROP_END_OF_LIST(),
-- 
2.14.3
