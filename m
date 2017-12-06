Received: from eggs.gnu.org ([2001:4830:134:3::10]:42874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.kanda@oracle.com>) id 1eMfjv-0002zA-F6
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:52:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.kanda@oracle.com>) id 1eMfju-0001CC-MS
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:52:19 -0500
From: Mark Kanda <mark.kanda@oracle.com>
Date: Wed,  6 Dec 2017 13:54:00 -0600
Message-Id: <e7b259772e3e075ae4b08778a27139b9db8d3bf9.1512589016.git.mark.kanda@oracle.com>
In-Reply-To: <cover.1512589016.git.mark.kanda@oracle.com>
References: <cover.1512589016.git.mark.kanda@oracle.com>
In-Reply-To: <cover.1512589016.git.mark.kanda@oracle.com>
References: <cover.1512589016.git.mark.kanda@oracle.com>
Subject: [Qemu-devel] [PATCH 1/2] virtio-blk: make queue size configurable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, konrad.wilk@oracle.com, martin.petersen@oracle.com, ameya.more@oracle.com, karl.heubaum@oracle.com, Mark Kanda <mark.kanda@oracle.com>

Depending on the configuration, it can be beneficial to adjust the virtio-blk
queue size to something other than the current default of 128. Add a new
property to make the queue size configurable.

Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Ameya More <ameya.more@oracle.com>
---
 hw/block/virtio-blk.c          | 7 ++++++-
 include/hw/virtio/virtio-blk.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 05d1440..002c56f 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -928,6 +928,10 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "num-queues property must be larger than 0");
         return;
     }
+    if (!is_power_of_2(conf->queue_size)) {
+        error_setg(errp, "queue-size property must be a power of 2");
+        return;
+    }
 
     blkconf_serial(&conf->conf, &conf->serial);
     blkconf_apply_backend_options(&conf->conf,
@@ -953,7 +957,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
     s->sector_mask = (s->conf.conf.logical_block_size / BDRV_SECTOR_SIZE) - 1;
 
     for (i = 0; i < conf->num_queues; i++) {
-        virtio_add_queue(vdev, 128, virtio_blk_handle_output);
+        virtio_add_queue(vdev, conf->queue_size, virtio_blk_handle_output);
     }
     virtio_blk_data_plane_create(vdev, conf, &s->dataplane, &err);
     if (err != NULL) {
@@ -1012,6 +1016,7 @@ static Property virtio_blk_properties[] = {
     DEFINE_PROP_BIT("request-merging", VirtIOBlock, conf.request_merging, 0,
                     true),
     DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues, 1),
+    DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size, 128),
     DEFINE_PROP_LINK("iothread", VirtIOBlock, conf.iothread, TYPE_IOTHREAD,
                      IOThread *),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
index d3c8a6f..5117431 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -39,6 +39,7 @@ struct VirtIOBlkConf
     uint32_t config_wce;
     uint32_t request_merging;
     uint16_t num_queues;
+    uint16_t queue_size;
 };
 
 struct VirtIOBlockDataPlane;
-- 
1.8.3.1
