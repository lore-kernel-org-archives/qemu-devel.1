Received: from eggs.gnu.org ([2001:4830:134:3::10]:54745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cnJUU-0008P3-3W
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:29:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cnJUS-00025C-FS
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:29:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cnJUS-00024o-63
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:29:56 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 13 Mar 2017 14:29:42 +0800
Message-Id: <1489386583-11564-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1489386583-11564-1-git-send-email-jasowang@redhat.com>
References: <1489386583-11564-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH V2 2/3] virtio: destroy region cache during
 reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

We don't destroy region cache during reset which can make the maps
of previous driver leaked to a buggy or malicious driver that don't
set vring address before starting to use the device. Fix this by
destroy the region cache during reset and validate it before trying to
see them.

Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Changes from v1:
- switch to use rcu in virtio_virtqueue_region_cache()
- use unlikely() when needed
---
 hw/virtio/virtio.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 76cc81b..f086452 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -190,6 +190,10 @@ static inline uint16_t vring_avail_flags(VirtQueue *vq)
 {
     VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
     hwaddr pa = offsetof(VRingAvail, flags);
+    if (unlikely(!caches)) {
+        virtio_error(vq->vdev, "Cannot map avail flags");
+        return 0;
+    }
     return virtio_lduw_phys_cached(vq->vdev, &caches->avail, pa);
 }
 
@@ -198,6 +202,10 @@ static inline uint16_t vring_avail_idx(VirtQueue *vq)
 {
     VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
     hwaddr pa = offsetof(VRingAvail, idx);
+    if (unlikely(!caches)) {
+        virtio_error(vq->vdev, "Cannot map avail idx");
+        return vq->shadow_avail_idx;
+    }
     vq->shadow_avail_idx = virtio_lduw_phys_cached(vq->vdev, &caches->avail, pa);
     return vq->shadow_avail_idx;
 }
@@ -207,6 +215,10 @@ static inline uint16_t vring_avail_ring(VirtQueue *vq, int i)
 {
     VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
     hwaddr pa = offsetof(VRingAvail, ring[i]);
+    if (unlikely(!caches)) {
+        virtio_error(vq->vdev, "Cannot map avail ring");
+        return 0;
+    }
     return virtio_lduw_phys_cached(vq->vdev, &caches->avail, pa);
 }
 
@@ -222,6 +234,10 @@ static inline void vring_used_write(VirtQueue *vq, VRingUsedElem *uelem,
 {
     VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
     hwaddr pa = offsetof(VRingUsed, ring[i]);
+    if (unlikely(!caches)) {
+        virtio_error(vq->vdev, "Cannot map used ring");
+        return;
+    }
     virtio_tswap32s(vq->vdev, &uelem->id);
     virtio_tswap32s(vq->vdev, &uelem->len);
     address_space_write_cached(&caches->used, pa, uelem, sizeof(VRingUsedElem));
@@ -233,6 +249,10 @@ static uint16_t vring_used_idx(VirtQueue *vq)
 {
     VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
     hwaddr pa = offsetof(VRingUsed, idx);
+    if (unlikely(!caches)) {
+        virtio_error(vq->vdev, "Cannot map used ring");
+        return 0;
+    }
     return virtio_lduw_phys_cached(vq->vdev, &caches->used, pa);
 }
 
@@ -241,6 +261,10 @@ static inline void vring_used_idx_set(VirtQueue *vq, uint16_t val)
 {
     VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
     hwaddr pa = offsetof(VRingUsed, idx);
+    if (unlikely(!caches)) {
+        virtio_error(vq->vdev, "Cannot map used idx");
+        return;
+    }
     virtio_stw_phys_cached(vq->vdev, &caches->used, pa, val);
     address_space_cache_invalidate(&caches->used, pa, sizeof(val));
     vq->used_idx = val;
@@ -252,8 +276,13 @@ static inline void vring_used_flags_set_bit(VirtQueue *vq, int mask)
     VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
     VirtIODevice *vdev = vq->vdev;
     hwaddr pa = offsetof(VRingUsed, flags);
-    uint16_t flags = virtio_lduw_phys_cached(vq->vdev, &caches->used, pa);
+    uint16_t flags;
 
+    if (unlikely(!caches)) {
+        virtio_error(vq->vdev, "Cannot map used flags");
+        return;
+    }
+    flags = virtio_lduw_phys_cached(vq->vdev, &caches->used, pa);
     virtio_stw_phys_cached(vdev, &caches->used, pa, flags | mask);
     address_space_cache_invalidate(&caches->used, pa, sizeof(flags));
 }
@@ -266,6 +295,10 @@ static inline void vring_used_flags_unset_bit(VirtQueue *vq, int mask)
     hwaddr pa = offsetof(VRingUsed, flags);
     uint16_t flags = virtio_lduw_phys_cached(vq->vdev, &caches->used, pa);
 
+    if (unlikely(!caches)) {
+        virtio_error(vq->vdev, "Cannot map used flags");
+        return;
+    }
     virtio_stw_phys_cached(vdev, &caches->used, pa, flags & ~mask);
     address_space_cache_invalidate(&caches->used, pa, sizeof(flags));
 }
@@ -280,6 +313,10 @@ static inline void vring_set_avail_event(VirtQueue *vq, uint16_t val)
     }
 
     caches = atomic_rcu_read(&vq->vring.caches);
+    if (unlikely(!caches)) {
+        virtio_error(vq->vdev, "Cannot map avail event");
+        return;
+    }
     pa = offsetof(VRingUsed, ring[vq->vring.num]);
     virtio_stw_phys_cached(vq->vdev, &caches->used, pa, val);
     address_space_cache_invalidate(&caches->used, pa, sizeof(val));
@@ -573,7 +610,7 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
 
     max = vq->vring.num;
     caches = atomic_rcu_read(&vq->vring.caches);
-    if (caches->desc.len < max * sizeof(VRingDesc)) {
+    if (unlikely(!caches) || caches->desc.len < max * sizeof(VRingDesc)) {
         virtio_error(vdev, "Cannot map descriptor ring");
         goto err;
     }
@@ -840,7 +877,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     i = head;
 
     caches = atomic_rcu_read(&vq->vring.caches);
-    if (caches->desc.len < max * sizeof(VRingDesc)) {
+    if (unlikely(!caches) || caches->desc.len < max * sizeof(VRingDesc)) {
         virtio_error(vdev, "Cannot map descriptor ring");
         goto done;
     }
@@ -1138,6 +1175,17 @@ static enum virtio_device_endian virtio_current_cpu_endian(void)
     }
 }
 
+static void virtio_virtqueue_reset_region_cache(struct VirtQueue *vq)
+{
+    VRingMemoryRegionCaches *caches;
+
+    caches = atomic_read(&vq->vring.caches);
+    atomic_set(&vq->vring.caches, NULL);
+    if (caches) {
+        call_rcu(caches, virtio_free_region_cache, rcu);
+    }
+}
+
 void virtio_reset(void *opaque)
 {
     VirtIODevice *vdev = opaque;
@@ -1178,6 +1226,7 @@ void virtio_reset(void *opaque)
         vdev->vq[i].notification = true;
         vdev->vq[i].vring.num = vdev->vq[i].vring.num_default;
         vdev->vq[i].inuse = 0;
+        virtio_virtqueue_reset_region_cache(&vdev->vq[i]);
     }
 }
 
@@ -2472,13 +2521,10 @@ static void virtio_device_free_virtqueues(VirtIODevice *vdev)
     }
 
     for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
-        VRingMemoryRegionCaches *caches;
         if (vdev->vq[i].vring.num == 0) {
             break;
         }
-        caches = atomic_read(&vdev->vq[i].vring.caches);
-        atomic_set(&vdev->vq[i].vring.caches, NULL);
-        virtio_free_region_cache(caches);
+        virtio_virtqueue_reset_region_cache(&vdev->vq[i]);
     }
     g_free(vdev->vq);
 }
-- 
2.7.4
