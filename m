Received: from eggs.gnu.org ([2001:4830:134:3::10]:54180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1f3hx5-0001AL-Bf
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:55:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1f3hx1-0005ZB-6y
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:55:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44930 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1f3hx0-0005Yk-O8
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:55:42 -0400
From: wexu@redhat.com
Date: Wed,  4 Apr 2018 20:53:58 +0800
Message-Id: <1522846444-31725-3-git-send-email-wexu@redhat.com>
In-Reply-To: <1522846444-31725-1-git-send-email-wexu@redhat.com>
References: <1522846444-31725-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [PATCH 2/8] virtio: memory cache for packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wexu@redhat.com, jasowang@redhat.com, mst@redhat.com, tiwei.bie@intel.com, jfreimann@redhat.com, qemu-devel@nongnu.org

From: Wei Xu <wexu@redhat.com>

A new memory cache is introduced to for packed ring,
the code looks pretty duplicated with split(1.0) ring,
any refactor idea?

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/virtio/virtio.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 76 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 9a6bfe7..73a35a4 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -155,13 +155,15 @@ static void virtio_free_region_cache(VRingMemoryRegionCaches *caches)
         return;
     }
 
+    /* FIX ME: pass in 1.1 device here, reuse 1.0 fields at current */
+
     address_space_cache_destroy(&caches->desc);
     address_space_cache_destroy(&caches->avail);
     address_space_cache_destroy(&caches->used);
     g_free(caches);
 }
 
-static void virtio_init_region_cache(VirtIODevice *vdev, int n)
+static void virtio_init_region_cache_split(VirtIODevice *vdev, int n)
 {
     VirtQueue *vq = &vdev->vq[n];
     VRingMemoryRegionCaches *old = vq->vring.caches;
@@ -215,6 +217,65 @@ err_desc:
     g_free(new);
 }
 
+static void virtio_init_region_cache_packed(VirtIODevice *vdev, int n)
+{
+    VirtQueue *vq = &vdev->vq[n];
+    VRingMemoryRegionCaches *old = vq->vring.caches;
+    VRingMemoryRegionCaches *new;
+    hwaddr addr, size;
+    int64_t len;
+
+    addr = vq->packed.desc;
+    if (!addr) {
+        return;
+    }
+    new = g_new0(VRingMemoryRegionCaches, 1);
+    size = virtio_queue_get_desc_size(vdev, n);
+    len = address_space_cache_init(&new->desc_packed, vdev->dma_as,
+                                   addr, size, false);
+    if (len < size) {
+        virtio_error(vdev, "Cannot map desc");
+        goto err_desc;
+    }
+
+    size = sizeof(struct VRingPackedDescEvent);
+    len = address_space_cache_init(&new->driver, vdev->dma_as,
+                                   vq->packed.driver, size, true);
+    if (len < size) {
+        virtio_error(vdev, "Cannot map driver area");
+        goto err_driver;
+    }
+
+    len = address_space_cache_init(&new->device, vdev->dma_as,
+                                   vq->packed.device, size, true);
+    if (len < size) {
+        virtio_error(vdev, "Cannot map device area");
+        goto err_device;
+    }
+
+    atomic_rcu_set(&vq->packed.caches, new);
+    if (old) {
+        call_rcu(old, virtio_free_region_cache, rcu);
+    }
+    return;
+
+err_device:
+    address_space_cache_destroy(&new->driver);
+err_driver:
+    address_space_cache_destroy(&new->desc);
+err_desc:
+    g_free(new);
+}
+
+static void virtio_init_region_cache(VirtIODevice *vdev, int n)
+{
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        virtio_init_region_cache_packed(vdev, n);
+    } else {
+        virtio_init_region_cache_split(vdev, n);
+    }
+}
+
 /* virt queue functions */
 void virtio_queue_update_rings(VirtIODevice *vdev, int n)
 {
@@ -245,10 +306,18 @@ static void vring_desc_read(VirtIODevice *vdev, VRingDesc *desc,
 
 static VRingMemoryRegionCaches *vring_get_region_caches(struct VirtQueue *vq)
 {
-    VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
+    VRingMemoryRegionCaches *caches;
+
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+        caches = atomic_rcu_read(&vq->packed.caches);
+    } else {
+        caches = atomic_rcu_read(&vq->vring.caches);
+    }
+
     assert(caches != NULL);
     return caches;
 }
+
 /* Called within rcu_read_lock().  */
 static inline uint16_t vring_avail_flags(VirtQueue *vq)
 {
@@ -2331,7 +2400,11 @@ hwaddr virtio_queue_get_used_addr(VirtIODevice *vdev, int n)
 
 hwaddr virtio_queue_get_desc_size(VirtIODevice *vdev, int n)
 {
-    return sizeof(VRingDesc) * vdev->vq[n].vring.num;
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        return sizeof(VRingDescPacked) * vdev->vq[n].packed.num;
+    } else {
+        return sizeof(VRingDesc) * vdev->vq[n].vring.num;
+    }
 }
 
 hwaddr virtio_queue_get_avail_size(VirtIODevice *vdev, int n)
-- 
2.7.4
