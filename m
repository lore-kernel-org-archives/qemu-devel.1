Received: from eggs.gnu.org ([2001:4830:134:3::10]:37073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1co7QD-0006ho-Fr
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:48:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1co7Q9-0003sc-Fj
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:48:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1co7Q9-0003s8-6t
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:48:49 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 15 Mar 2017 19:48:31 +0800
Message-Id: <1489578512-14031-3-git-send-email-jasowang@redhat.com>
In-Reply-To: <1489578512-14031-1-git-send-email-jasowang@redhat.com>
References: <1489578512-14031-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH V4 2/3] virtio: destroy region cache during
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
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Changes from V3:
- remove unrelated whitespace change
Changes from V2:
- introduce a helper and assert caches != NULL
Changes from v1:
- switch to use rcu in virtio_virtqueue_region_cache()
- use unlikely() when needed
---
 hw/virtio/virtio.c | 45 ++++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 9164579..a00380f 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -185,10 +185,16 @@ static void vring_desc_read(VirtIODevice *vdev, VRingDesc *desc,
     virtio_tswap16s(vdev, &desc->next);
 }
 
+static VRingMemoryRegionCaches *vring_get_region_caches(struct VirtQueue *vq)
+{
+    VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
+    assert(caches != NULL);
+    return caches;
+}
 /* Called within rcu_read_lock().  */
 static inline uint16_t vring_avail_flags(VirtQueue *vq)
 {
-    VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
+    VRingMemoryRegionCaches *caches = vring_get_region_caches(vq);
     hwaddr pa = offsetof(VRingAvail, flags);
     return virtio_lduw_phys_cached(vq->vdev, &caches->avail, pa);
 }
@@ -196,7 +202,7 @@ static inline uint16_t vring_avail_flags(VirtQueue *vq)
 /* Called within rcu_read_lock().  */
 static inline uint16_t vring_avail_idx(VirtQueue *vq)
 {
-    VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
+    VRingMemoryRegionCaches *caches = vring_get_region_caches(vq);
     hwaddr pa = offsetof(VRingAvail, idx);
     vq->shadow_avail_idx = virtio_lduw_phys_cached(vq->vdev, &caches->avail, pa);
     return vq->shadow_avail_idx;
@@ -205,7 +211,7 @@ static inline uint16_t vring_avail_idx(VirtQueue *vq)
 /* Called within rcu_read_lock().  */
 static inline uint16_t vring_avail_ring(VirtQueue *vq, int i)
 {
-    VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
+    VRingMemoryRegionCaches *caches = vring_get_region_caches(vq);
     hwaddr pa = offsetof(VRingAvail, ring[i]);
     return virtio_lduw_phys_cached(vq->vdev, &caches->avail, pa);
 }
@@ -220,7 +226,7 @@ static inline uint16_t vring_get_used_event(VirtQueue *vq)
 static inline void vring_used_write(VirtQueue *vq, VRingUsedElem *uelem,
                                     int i)
 {
-    VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
+    VRingMemoryRegionCaches *caches = vring_get_region_caches(vq);
     hwaddr pa = offsetof(VRingUsed, ring[i]);
     virtio_tswap32s(vq->vdev, &uelem->id);
     virtio_tswap32s(vq->vdev, &uelem->len);
@@ -231,7 +237,7 @@ static inline void vring_used_write(VirtQueue *vq, VRingUsedElem *uelem,
 /* Called within rcu_read_lock().  */
 static uint16_t vring_used_idx(VirtQueue *vq)
 {
-    VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
+    VRingMemoryRegionCaches *caches = vring_get_region_caches(vq);
     hwaddr pa = offsetof(VRingUsed, idx);
     return virtio_lduw_phys_cached(vq->vdev, &caches->used, pa);
 }
@@ -239,7 +245,7 @@ static uint16_t vring_used_idx(VirtQueue *vq)
 /* Called within rcu_read_lock().  */
 static inline void vring_used_idx_set(VirtQueue *vq, uint16_t val)
 {
-    VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
+    VRingMemoryRegionCaches *caches = vring_get_region_caches(vq);
     hwaddr pa = offsetof(VRingUsed, idx);
     virtio_stw_phys_cached(vq->vdev, &caches->used, pa, val);
     address_space_cache_invalidate(&caches->used, pa, sizeof(val));
@@ -249,7 +255,7 @@ static inline void vring_used_idx_set(VirtQueue *vq, uint16_t val)
 /* Called within rcu_read_lock().  */
 static inline void vring_used_flags_set_bit(VirtQueue *vq, int mask)
 {
-    VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
+    VRingMemoryRegionCaches *caches = vring_get_region_caches(vq);
     VirtIODevice *vdev = vq->vdev;
     hwaddr pa = offsetof(VRingUsed, flags);
     uint16_t flags = virtio_lduw_phys_cached(vq->vdev, &caches->used, pa);
@@ -261,7 +267,7 @@ static inline void vring_used_flags_set_bit(VirtQueue *vq, int mask)
 /* Called within rcu_read_lock().  */
 static inline void vring_used_flags_unset_bit(VirtQueue *vq, int mask)
 {
-    VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
+    VRingMemoryRegionCaches *caches = vring_get_region_caches(vq);
     VirtIODevice *vdev = vq->vdev;
     hwaddr pa = offsetof(VRingUsed, flags);
     uint16_t flags = virtio_lduw_phys_cached(vq->vdev, &caches->used, pa);
@@ -279,7 +285,7 @@ static inline void vring_set_avail_event(VirtQueue *vq, uint16_t val)
         return;
     }
 
-    caches = atomic_rcu_read(&vq->vring.caches);
+    caches = vring_get_region_caches(vq);
     pa = offsetof(VRingUsed, ring[vq->vring.num]);
     virtio_stw_phys_cached(vq->vdev, &caches->used, pa, val);
     address_space_cache_invalidate(&caches->used, pa, sizeof(val));
@@ -577,7 +583,7 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
     total_bufs = in_total = out_total = 0;
 
     max = vq->vring.num;
-    caches = atomic_rcu_read(&vq->vring.caches);
+    caches = vring_get_region_caches(vq);
     if (caches->desc.len < max * sizeof(VRingDesc)) {
         virtio_error(vdev, "Cannot map descriptor ring");
         goto err;
@@ -844,7 +850,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
 
     i = head;
 
-    caches = atomic_rcu_read(&vq->vring.caches);
+    caches = vring_get_region_caches(vq);
     if (caches->desc.len < max * sizeof(VRingDesc)) {
         virtio_error(vdev, "Cannot map descriptor ring");
         goto done;
@@ -1143,6 +1149,17 @@ static enum virtio_device_endian virtio_current_cpu_endian(void)
     }
 }
 
+static void virtio_virtqueue_reset_region_cache(struct VirtQueue *vq)
+{
+    VRingMemoryRegionCaches *caches;
+
+    caches = atomic_read(&vq->vring.caches);
+    atomic_rcu_set(&vq->vring.caches, NULL);
+    if (caches) {
+        call_rcu(caches, virtio_free_region_cache, rcu);
+    }
+}
+
 void virtio_reset(void *opaque)
 {
     VirtIODevice *vdev = opaque;
@@ -1183,6 +1200,7 @@ void virtio_reset(void *opaque)
         vdev->vq[i].notification = true;
         vdev->vq[i].vring.num = vdev->vq[i].vring.num_default;
         vdev->vq[i].inuse = 0;
+        virtio_virtqueue_reset_region_cache(&vdev->vq[i]);
     }
 }
 
@@ -2477,13 +2495,10 @@ static void virtio_device_free_virtqueues(VirtIODevice *vdev)
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
