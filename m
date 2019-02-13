Received: from eggs.gnu.org ([209.51.188.92]:52310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gtuhi-0002h0-Os
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:36:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gtuhh-00040p-MC
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:35:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:26187)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gtuhh-0003sW-0F
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:35:57 -0500
From: wexu@redhat.com
Date: Wed, 13 Feb 2019 08:25:38 -0500
Message-Id: <1550064346-17012-4-git-send-email-wexu@redhat.com>
In-Reply-To: <1550064346-17012-1-git-send-email-wexu@redhat.com>
References: <1550064346-17012-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [PATCH 03/11] virtio: initialize packed ring region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: wexu@redhat.com, jasowang@redhat.com, mst@redhat.com, jfreiman@redhat.com, maxime.coquelin@redhat.com, tiwei.bie@intel.com

From: Wei Xu <wexu@redhat.com>

Initialize packed ring memory region with correct size and attribute.

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/virtio/virtio.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 6769e54..1a98e61 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -156,7 +156,7 @@ static void virtio_init_region_cache(VirtIODevice *vdev, int n)
     VRingMemoryRegionCaches *new = NULL;
     hwaddr addr, size;
     int64_t len;
-
+    bool attr;
 
     addr = vq->vring.desc;
     if (!addr) {
@@ -164,8 +164,10 @@ static void virtio_init_region_cache(VirtIODevice *vdev, int n)
     }
     new = g_new0(VRingMemoryRegionCaches, 1);
     size = virtio_queue_get_desc_size(vdev, n);
+    attr = virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED) ?
+                                   true : false;
     len = address_space_cache_init(&new->desc, vdev->dma_as,
-                                   addr, size, false);
+                                   addr, size, attr);
     if (len < size) {
         virtio_error(vdev, "Cannot map desc");
         goto err_desc;
@@ -2335,6 +2337,10 @@ hwaddr virtio_queue_get_avail_size(VirtIODevice *vdev, int n)
 {
     int s;
 
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        return sizeof(struct VRingPackedDescEvent);
+    }
+
     s = virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
     return offsetof(VRingAvail, ring) +
         sizeof(uint16_t) * vdev->vq[n].vring.num + s;
@@ -2344,6 +2350,10 @@ hwaddr virtio_queue_get_used_size(VirtIODevice *vdev, int n)
 {
     int s;
 
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        return sizeof(struct VRingPackedDescEvent);
+    }
+
     s = virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
     return offsetof(VRingUsed, ring) +
         sizeof(VRingUsedElem) * vdev->vq[n].vring.num + s;
-- 
1.8.3.1
