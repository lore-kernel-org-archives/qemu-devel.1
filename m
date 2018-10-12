Received: from eggs.gnu.org ([2001:4830:134:3::10]:35539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1gAtQw-00021v-SN
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:08:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1gAtQp-0007Yv-AN
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:08:32 -0400
Received: from synology.com ([59.124.61.242]:45417)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuchenlin@synology.com>)
	id 1gAtQc-0007NG-DY
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:08:19 -0400
From: yuchenlin@synology.com
Date: Fri, 12 Oct 2018 17:07:52 +0800
Message-Id: <20181012090752.31891-1-yuchenlin@synology.com>
Subject: [Qemu-devel] [PATCH] vhost-scsi: prevent using uninitialized vqs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, yuchenlin <yuchenlin@synology.com>, Forrest Liu <forrestl@synology.com>

From: yuchenlin <yuchenlin@synology.com>

There are 3 virtqueues (ctrl, event and cmd) for virtio scsi device,
but seabios will only set the physical address for the 3rd one (cmd).
Then in vhost_virtqueue_start(), virtio_queue_get_desc_addr()
will be 0 for ctrl and event vq.

In this case, ctrl and event vq are not initialized.
vhost_verify_ring_mappings may use uninitialized vhost_virtqueue
such that vhost_verify_ring_part_mapping returns ENOMEM.

When encountered this problem, we got the following logs:

    qemu-system-x86_64: Unable to map available ring for ring 0
    qemu-system-x86_64: Verify ring failure on region 0

Signed-off-by: Forrest Liu <forrestl@synology.com>
Signed-off-by: yuchenlin <yuchenlin@synology.com>
---
 hw/scsi/vhost-scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index becf550085..7f21b4f9d6 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -183,7 +183,7 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
     }
 
     vsc->dev.nvqs = VHOST_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
-    vsc->dev.vqs = g_new(struct vhost_virtqueue, vsc->dev.nvqs);
+    vsc->dev.vqs = g_new0(struct vhost_virtqueue, vsc->dev.nvqs);
     vsc->dev.vq_index = 0;
     vsc->dev.backend_features = 0;
 
-- 
2.18.0
