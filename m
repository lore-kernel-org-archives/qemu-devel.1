Received: from eggs.gnu.org ([2001:4830:134:3::10]:36442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1clAmu-0006Z5-Tl
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 03:48:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1clAmr-0006Q0-Qr
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 03:48:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1clAmr-0006Pf-Hm
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 03:48:05 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 559D561B8C
	for <qemu-devel@nongnu.org>; Tue,  7 Mar 2017 08:48:05 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
Date: Tue,  7 Mar 2017 16:47:58 +0800
Message-Id: <1488876478-6889-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH] virtio: destroy region cache during reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

We don't destroy region cache during reset which can make the maps
of previous driver leaked to a buggy or malicious driver that don't
set vring address before starting to use the device. Fix this by
destroy the region cache during reset and validate it before trying to
use them. While at it, also validate address_space_cache_init() during
virtio_init_region_cache() to make sure we have a correct region
cache.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/virtio/virtio.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 76 insertions(+), 12 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 09f4cf4..90324f6 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -131,6 +131,7 @@ static void virtio_init_region_cache(VirtIODevice *vdev, int n)
     VRingMemoryRegionCaches *new;
     hwaddr addr, size;
     int event_size;
+    int64_t len;
 
     event_size = virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
 
@@ -140,21 +141,41 @@ static void virtio_init_region_cache(VirtIODevice *vdev, int n)
     }
     new = g_new0(VRingMemoryRegionCaches, 1);
     size = virtio_queue_get_desc_size(vdev, n);
-    address_space_cache_init(&new->desc, vdev->dma_as,
-                             addr, size, false);
+    len = address_space_cache_init(&new->desc, vdev->dma_as,
+                                   addr, size, false);
+    if (len < size) {
+        virtio_error(vdev, "Cannot map desc");
+        goto err_desc;
+    }
 
     size = virtio_queue_get_used_size(vdev, n) + event_size;
-    address_space_cache_init(&new->used, vdev->dma_as,
-                             vq->vring.used, size, true);
+    len = address_space_cache_init(&new->used, vdev->dma_as,
+                                   vq->vring.used, size, true);
+    if (len < size) {
+        virtio_error(vdev, "Cannot map used");
+        goto err_used;
+    }
 
     size = virtio_queue_get_avail_size(vdev, n) + event_size;
-    address_space_cache_init(&new->avail, vdev->dma_as,
-                             vq->vring.avail, size, false);
+    len = address_space_cache_init(&new->avail, vdev->dma_as,
+                                   vq->vring.avail, size, false);
+    if (len < size) {
+        virtio_error(vdev, "Cannot map avail");
+        goto err_avail;
+    }
 
     atomic_rcu_set(&vq->vring.caches, new);
     if (old) {
         call_rcu(old, virtio_free_region_cache, rcu);
     }
+    return;
+
+err_avail:
+    address_space_cache_destroy(&new->used);
+err_used:
+    address_space_cache_destroy(&new->desc);
+err_desc:
+    g_free(new);
 }
 
 /* virt queue functions */
@@ -190,6 +211,10 @@ static inline uint16_t vring_avail_flags(VirtQueue *vq)
 {
     VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
     hwaddr pa = offsetof(VRingAvail, flags);
+    if (!caches) {
+        virtio_error(vq->vdev, "Cannot map avail flags");
+        return 0;
+    }
     return virtio_lduw_phys_cached(vq->vdev, &caches->avail, pa);
 }
 
@@ -198,6 +223,10 @@ static inline uint16_t vring_avail_idx(VirtQueue *vq)
 {
     VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
     hwaddr pa = offsetof(VRingAvail, idx);
+    if (!caches) {
+        virtio_error(vq->vdev, "Cannot map avail idx");
+        return vq->shadow_avail_idx;
+    }
     vq->shadow_avail_idx = virtio_lduw_phys_cached(vq->vdev, &caches->avail, pa);
     return vq->shadow_avail_idx;
 }
@@ -207,6 +236,10 @@ static inline uint16_t vring_avail_ring(VirtQueue *vq, int i)
 {
     VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
     hwaddr pa = offsetof(VRingAvail, ring[i]);
+    if (!caches) {
+        virtio_error(vq->vdev, "Cannot map avail ring");
+        return 0;
+    }
     return virtio_lduw_phys_cached(vq->vdev, &caches->avail, pa);
 }
 
@@ -222,6 +255,10 @@ static inline void vring_used_write(VirtQueue *vq, VRingUsedElem *uelem,
 {
     VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
     hwaddr pa = offsetof(VRingUsed, ring[i]);
+    if (!caches) {
+        virtio_error(vq->vdev, "Cannot map used ring");
+        return;
+    }
     virtio_tswap32s(vq->vdev, &uelem->id);
     virtio_tswap32s(vq->vdev, &uelem->len);
     address_space_write_cached(&caches->used, pa, uelem, sizeof(VRingUsedElem));
@@ -233,6 +270,10 @@ static uint16_t vring_used_idx(VirtQueue *vq)
 {
     VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
     hwaddr pa = offsetof(VRingUsed, idx);
+    if (!caches) {
+        virtio_error(vq->vdev, "Cannot map used ring");
+        return 0;
+    }
     return virtio_lduw_phys_cached(vq->vdev, &caches->used, pa);
 }
 
@@ -241,6 +282,10 @@ static inline void vring_used_idx_set(VirtQueue *vq, uint16_t val)
 {
     VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
     hwaddr pa = offsetof(VRingUsed, idx);
+    if (!caches) {
+        virtio_error(vq->vdev, "Cannot map used idx");
+        return;
+    }
     virtio_stw_phys_cached(vq->vdev, &caches->used, pa, val);
     address_space_cache_invalidate(&caches->used, pa, sizeof(val));
     vq->used_idx = val;
@@ -254,6 +299,10 @@ static inline void vring_used_flags_set_bit(VirtQueue *vq, int mask)
     hwaddr pa = offsetof(VRingUsed, flags);
     uint16_t flags = virtio_lduw_phys_cached(vq->vdev, &caches->used, pa);
 
+    if (!caches) {
+        virtio_error(vq->vdev, "Cannot map used flags");
+        return;
+    }
     virtio_stw_phys_cached(vdev, &caches->used, pa, flags | mask);
     address_space_cache_invalidate(&caches->used, pa, sizeof(flags));
 }
@@ -266,6 +315,10 @@ static inline void vring_used_flags_unset_bit(VirtQueue *vq, int mask)
     hwaddr pa = offsetof(VRingUsed, flags);
     uint16_t flags = virtio_lduw_phys_cached(vq->vdev, &caches->used, pa);
 
+    if (!caches) {
+        virtio_error(vq->vdev, "Cannot map used flags");
+        return;
+    }
     virtio_stw_phys_cached(vdev, &caches->used, pa, flags & ~mask);
     address_space_cache_invalidate(&caches->used, pa, sizeof(flags));
 }
@@ -280,6 +333,10 @@ static inline void vring_set_avail_event(VirtQueue *vq, uint16_t val)
     }
 
     caches = atomic_rcu_read(&vq->vring.caches);
+    if (!caches) {
+        virtio_error(vq->vdev, "Cannot map avail event");
+        return;
+    }
     pa = offsetof(VRingUsed, ring[vq->vring.num]);
     virtio_stw_phys_cached(vq->vdev, &caches->used, pa, val);
     address_space_cache_invalidate(&caches->used, pa, sizeof(val));
@@ -552,7 +609,7 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
 
     max = vq->vring.num;
     caches = atomic_rcu_read(&vq->vring.caches);
-    if (caches->desc.len < max * sizeof(VRingDesc)) {
+    if (!caches || caches->desc.len < max * sizeof(VRingDesc)) {
         virtio_error(vdev, "Cannot map descriptor ring");
         goto err;
     }
@@ -819,7 +876,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     i = head;
 
     caches = atomic_rcu_read(&vq->vring.caches);
-    if (caches->desc.len < max * sizeof(VRingDesc)) {
+    if (!caches || caches->desc.len < max * sizeof(VRingDesc)) {
         virtio_error(vdev, "Cannot map descriptor ring");
         goto done;
     }
@@ -1117,6 +1174,15 @@ static enum virtio_device_endian virtio_current_cpu_endian(void)
     }
 }
 
+static void virtio_virtqueue_reset_region_cache(struct VirtQueue *vq)
+{
+    VRingMemoryRegionCaches *caches;
+
+    caches = atomic_read(&vq->vring.caches);
+    atomic_set(&vq->vring.caches, NULL);
+    virtio_free_region_cache(caches);
+}
+
 void virtio_reset(void *opaque)
 {
     VirtIODevice *vdev = opaque;
@@ -1157,6 +1223,7 @@ void virtio_reset(void *opaque)
         vdev->vq[i].notification = true;
         vdev->vq[i].vring.num = vdev->vq[i].vring.num_default;
         vdev->vq[i].inuse = 0;
+        virtio_virtqueue_reset_region_cache(&vdev->vq[i]);
     }
 }
 
@@ -2451,13 +2518,10 @@ static void virtio_device_free_virtqueues(VirtIODevice *vdev)
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
