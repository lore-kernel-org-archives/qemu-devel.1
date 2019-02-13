Received: from eggs.gnu.org ([209.51.188.92]:52347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gtuhj-0002hq-J9
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:36:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gtuhi-00041m-3O
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:35:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gtuhh-0003sZ-Og
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:35:57 -0500
From: wexu@redhat.com
Date: Wed, 13 Feb 2019 08:25:37 -0500
Message-Id: <1550064346-17012-3-git-send-email-wexu@redhat.com>
In-Reply-To: <1550064346-17012-1-git-send-email-wexu@redhat.com>
References: <1550064346-17012-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [PATCH 02/11] virtio: device/driver area size
 calculation helper for split ring
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

There is slight size difference between split/packed rings.

This is a refactor of split ring as well as a helper to expand
device and driver area size calculation for packed ring.

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/virtio/virtio.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index eafb4cc..6769e54 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -155,10 +155,8 @@ static void virtio_init_region_cache(VirtIODevice *vdev, int n)
     VRingMemoryRegionCaches *old = vq->vring.caches;
     VRingMemoryRegionCaches *new = NULL;
     hwaddr addr, size;
-    int event_size;
     int64_t len;
 
-    event_size = virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
 
     addr = vq->vring.desc;
     if (!addr) {
@@ -173,7 +171,7 @@ static void virtio_init_region_cache(VirtIODevice *vdev, int n)
         goto err_desc;
     }
 
-    size = virtio_queue_get_used_size(vdev, n) + event_size;
+    size = virtio_queue_get_used_size(vdev, n);
     len = address_space_cache_init(&new->used, vdev->dma_as,
                                    vq->vring.used, size, true);
     if (len < size) {
@@ -181,7 +179,7 @@ static void virtio_init_region_cache(VirtIODevice *vdev, int n)
         goto err_used;
     }
 
-    size = virtio_queue_get_avail_size(vdev, n) + event_size;
+    size = virtio_queue_get_avail_size(vdev, n);
     len = address_space_cache_init(&new->avail, vdev->dma_as,
                                    vq->vring.avail, size, false);
     if (len < size) {
@@ -2335,14 +2333,20 @@ hwaddr virtio_queue_get_desc_size(VirtIODevice *vdev, int n)
 
 hwaddr virtio_queue_get_avail_size(VirtIODevice *vdev, int n)
 {
+    int s;
+
+    s = virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
     return offsetof(VRingAvail, ring) +
-        sizeof(uint16_t) * vdev->vq[n].vring.num;
+        sizeof(uint16_t) * vdev->vq[n].vring.num + s;
 }
 
 hwaddr virtio_queue_get_used_size(VirtIODevice *vdev, int n)
 {
+    int s;
+
+    s = virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
     return offsetof(VRingUsed, ring) +
-        sizeof(VRingUsedElem) * vdev->vq[n].vring.num;
+        sizeof(VRingUsedElem) * vdev->vq[n].vring.num + s;
 }
 
 uint16_t virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n)
-- 
1.8.3.1
