Received: from eggs.gnu.org ([2001:4830:134:3::10]:42522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1fQHJa-0001zh-FZ
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 15:08:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1fQHJZ-00030c-Fd
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 15:08:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46852 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1fQHJZ-00030B-A5
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 15:08:17 -0400
From: wexu@redhat.com
Date: Tue,  5 Jun 2018 15:07:57 -0400
Message-Id: <1528225683-11413-3-git-send-email-wexu@redhat.com>
In-Reply-To: <1528225683-11413-1-git-send-email-wexu@redhat.com>
References: <1528225683-11413-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [RFC v2 2/8] virtio: memory cache for packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, tiwei.bie@intel.com, mst@redhat.com, wexu@redhat.com, jfreimann@redhat.com

From: Wei Xu <wexu@redhat.com>

Mostly reuse memory cache with 1.0 except for the offset calculation.

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/virtio/virtio.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index e192a9a..f6c0689 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -150,11 +150,8 @@ static void virtio_init_region_cache(VirtIODevice *vdev, int n)
     VRingMemoryRegionCaches *old = vq->vring.caches;
     VRingMemoryRegionCaches *new;
     hwaddr addr, size;
-    int event_size;
     int64_t len;
 
-    event_size = virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
-
     addr = vq->vring.desc;
     if (!addr) {
         return;
@@ -168,7 +165,7 @@ static void virtio_init_region_cache(VirtIODevice *vdev, int n)
         goto err_desc;
     }
 
-    size = virtio_queue_get_used_size(vdev, n) + event_size;
+    size = virtio_queue_get_used_size(vdev, n);
     len = address_space_cache_init(&new->used, vdev->dma_as,
                                    vq->vring.used, size, true);
     if (len < size) {
@@ -176,7 +173,7 @@ static void virtio_init_region_cache(VirtIODevice *vdev, int n)
         goto err_used;
     }
 
-    size = virtio_queue_get_avail_size(vdev, n) + event_size;
+    size = virtio_queue_get_avail_size(vdev, n);
     len = address_space_cache_init(&new->avail, vdev->dma_as,
                                    vq->vring.avail, size, false);
     if (len < size) {
@@ -2320,14 +2317,28 @@ hwaddr virtio_queue_get_desc_size(VirtIODevice *vdev, int n)
 
 hwaddr virtio_queue_get_avail_size(VirtIODevice *vdev, int n)
 {
-    return offsetof(VRingAvail, ring) +
-        sizeof(uint16_t) * vdev->vq[n].vring.num;
+    int s;
+
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        return sizeof(struct VRingPackedDescEvent);
+    } else {
+        s = virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
+        return offsetof(VRingAvail, ring) +
+            sizeof(uint16_t) * vdev->vq[n].vring.num + s;
+    }
 }
 
 hwaddr virtio_queue_get_used_size(VirtIODevice *vdev, int n)
 {
-    return offsetof(VRingUsed, ring) +
-        sizeof(VRingUsedElem) * vdev->vq[n].vring.num;
+    int s;
+
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        return sizeof(struct VRingPackedDescEvent);
+    } else {
+        s = virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
+        return offsetof(VRingUsed, ring) +
+            sizeof(VRingUsedElem) * vdev->vq[n].vring.num + s;
+    }
 }
 
 uint16_t virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n)
-- 
1.8.3.1
