Received: from eggs.gnu.org ([2001:4830:134:3::10]:39277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gAbeL-0004no-FR
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:09:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gAbeG-0005uc-60
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:09:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gAbeF-0005u3-TA
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:09:08 -0400
From: wexu@redhat.com
Date: Thu, 11 Oct 2018 10:08:26 -0400
Message-Id: <1539266915-15216-4-git-send-email-wexu@redhat.com>
In-Reply-To: <1539266915-15216-1-git-send-email-wexu@redhat.com>
References: <1539266915-15216-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [[RFC v3 03/12] virtio: init memory cache for packed
 ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, tiwei.bie@intel.com, wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com

From: Wei Xu <wexu@redhat.com>

Expand 1.0 by adding offset calculation accordingly.

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/virtio/vhost.c          | 16 ++++++++--------
 hw/virtio/virtio.c         | 35 +++++++++++++++++++++++------------
 include/hw/virtio/virtio.h |  4 ++--
 3 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 569c405..9df2da3 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -996,14 +996,14 @@ static int vhost_virtqueue_start(struct vhost_dev *dev,
         r = -ENOMEM;
         goto fail_alloc_desc;
     }
-    vq->avail_size = s = l = virtio_queue_get_avail_size(vdev, idx);
+    vq->avail_size = s = l = virtio_queue_get_driver_size(vdev, idx);
     vq->avail_phys = a = virtio_queue_get_avail_addr(vdev, idx);
     vq->avail = vhost_memory_map(dev, a, &l, 0);
     if (!vq->avail || l != s) {
         r = -ENOMEM;
         goto fail_alloc_avail;
     }
-    vq->used_size = s = l = virtio_queue_get_used_size(vdev, idx);
+    vq->used_size = s = l = virtio_queue_get_device_size(vdev, idx);
     vq->used_phys = a = virtio_queue_get_used_addr(vdev, idx);
     vq->used = vhost_memory_map(dev, a, &l, 1);
     if (!vq->used || l != s) {
@@ -1051,10 +1051,10 @@ static int vhost_virtqueue_start(struct vhost_dev *dev,
 fail_vector:
 fail_kick:
 fail_alloc:
-    vhost_memory_unmap(dev, vq->used, virtio_queue_get_used_size(vdev, idx),
+    vhost_memory_unmap(dev, vq->used, virtio_queue_get_device_size(vdev, idx),
                        0, 0);
 fail_alloc_used:
-    vhost_memory_unmap(dev, vq->avail, virtio_queue_get_avail_size(vdev, idx),
+    vhost_memory_unmap(dev, vq->avail, virtio_queue_get_driver_size(vdev, idx),
                        0, 0);
 fail_alloc_avail:
     vhost_memory_unmap(dev, vq->desc, virtio_queue_get_desc_size(vdev, idx),
@@ -1101,10 +1101,10 @@ static void vhost_virtqueue_stop(struct vhost_dev *dev,
                                                 vhost_vq_index);
     }
 
-    vhost_memory_unmap(dev, vq->used, virtio_queue_get_used_size(vdev, idx),
-                       1, virtio_queue_get_used_size(vdev, idx));
-    vhost_memory_unmap(dev, vq->avail, virtio_queue_get_avail_size(vdev, idx),
-                       0, virtio_queue_get_avail_size(vdev, idx));
+    vhost_memory_unmap(dev, vq->used, virtio_queue_get_device_size(vdev, idx),
+                       1, virtio_queue_get_device_size(vdev, idx));
+    vhost_memory_unmap(dev, vq->avail, virtio_queue_get_driver_size(vdev, idx),
+                       0, virtio_queue_get_driver_size(vdev, idx));
     vhost_memory_unmap(dev, vq->desc, virtio_queue_get_desc_size(vdev, idx),
                        0, virtio_queue_get_desc_size(vdev, idx));
 }
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 500eecf..bfb3364 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -162,11 +162,8 @@ static void virtio_init_region_cache(VirtIODevice *vdev, int n)
     VRingMemoryRegionCaches *old = vq->vring.caches;
     VRingMemoryRegionCaches *new = NULL;
     hwaddr addr, size;
-    int event_size;
     int64_t len;
 
-    event_size = virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
-
     addr = vq->vring.desc;
     if (!addr) {
         goto out_no_cache;
@@ -174,13 +171,13 @@ static void virtio_init_region_cache(VirtIODevice *vdev, int n)
     new = g_new0(VRingMemoryRegionCaches, 1);
     size = virtio_queue_get_desc_size(vdev, n);
     len = address_space_cache_init(&new->desc, vdev->dma_as,
-                                   addr, size, false);
+                                   addr, size, true);
     if (len < size) {
         virtio_error(vdev, "Cannot map desc");
         goto err_desc;
     }
 
-    size = virtio_queue_get_used_size(vdev, n) + event_size;
+    size = virtio_queue_get_device_size(vdev, n);
     len = address_space_cache_init(&new->used, vdev->dma_as,
                                    vq->vring.used, size, true);
     if (len < size) {
@@ -188,7 +185,7 @@ static void virtio_init_region_cache(VirtIODevice *vdev, int n)
         goto err_used;
     }
 
-    size = virtio_queue_get_avail_size(vdev, n) + event_size;
+    size = virtio_queue_get_driver_size(vdev, n);
     len = address_space_cache_init(&new->avail, vdev->dma_as,
                                    vq->vring.avail, size, false);
     if (len < size) {
@@ -2339,16 +2336,30 @@ hwaddr virtio_queue_get_desc_size(VirtIODevice *vdev, int n)
     return sizeof(VRingDesc) * vdev->vq[n].vring.num;
 }
 
-hwaddr virtio_queue_get_avail_size(VirtIODevice *vdev, int n)
+hwaddr virtio_queue_get_driver_size(VirtIODevice *vdev, int n)
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
 
-hwaddr virtio_queue_get_used_size(VirtIODevice *vdev, int n)
+hwaddr virtio_queue_get_device_size(VirtIODevice *vdev, int n)
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
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 9c1fa07..e323e76 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -270,8 +270,8 @@ hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
 hwaddr virtio_queue_get_avail_addr(VirtIODevice *vdev, int n);
 hwaddr virtio_queue_get_used_addr(VirtIODevice *vdev, int n);
 hwaddr virtio_queue_get_desc_size(VirtIODevice *vdev, int n);
-hwaddr virtio_queue_get_avail_size(VirtIODevice *vdev, int n);
-hwaddr virtio_queue_get_used_size(VirtIODevice *vdev, int n);
+hwaddr virtio_queue_get_driver_size(VirtIODevice *vdev, int n);
+hwaddr virtio_queue_get_device_size(VirtIODevice *vdev, int n);
 uint16_t virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n);
 void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n, uint16_t idx);
 void virtio_queue_restore_last_avail_idx(VirtIODevice *vdev, int n);
-- 
1.8.3.1
