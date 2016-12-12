Received: from eggs.gnu.org ([2001:4830:134:3::10]:39475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cGOdb-0004hl-RZ
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:19:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cGOdZ-0000Vo-PK
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:19:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cGOdZ-0000VS-Gl
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:19:17 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 Dec 2016 12:18:57 +0100
Message-Id: <20161212111857.23399-12-pbonzini@redhat.com>
In-Reply-To: <20161212111857.23399-1-pbonzini@redhat.com>
References: <20161212111857.23399-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 11/11] virtio: use VRingMemoryRegionCaches for
 avail and used rings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, famz@redhat.com, mst@redhat.com, borntraeger@de.ibm.com

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/net/virtio-net.c |  14 +++++-
 hw/virtio/virtio.c  | 137 +++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 111 insertions(+), 40 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 5009533..c9f8c1c 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1101,7 +1101,8 @@ static int receive_filter(VirtIONet *n, const uint8_t *buf, int size)
     return 0;
 }
 
-static ssize_t virtio_net_receive(NetClientState *nc, const uint8_t *buf, size_t size)
+static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
+                                      size_t size)
 {
     VirtIONet *n = qemu_get_nic_opaque(nc);
     VirtIONetQueue *q = virtio_net_get_subqueue(nc);
@@ -1204,6 +1205,17 @@ static ssize_t virtio_net_receive(NetClientState *nc, const uint8_t *buf, size_t
     return size;
 }
 
+static ssize_t virtio_net_receive(NetClientState *nc, const uint8_t *buf,
+                                  size_t size)
+{
+    ssize_t r;
+
+    rcu_read_lock();
+    r = virtio_net_receive_rcu(nc, buf, size);
+    rcu_read_unlock();
+    return r;
+}
+
 static int32_t virtio_net_flush_tx(VirtIONetQueue *q);
 
 static void virtio_net_tx_complete(NetClientState *nc, ssize_t len)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 702da0b..eb7ef83 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -167,6 +167,7 @@ void virtio_queue_update_rings(VirtIODevice *vdev, int n)
     virtio_init_region_cache(vdev, n);
 }
 
+/* Called within rcu_read_lock().  */
 static void vring_desc_read(VirtIODevice *vdev, VRingDesc *desc,
                             MemoryRegionCache *cache, int i)
 {
@@ -178,88 +179,109 @@ static void vring_desc_read(VirtIODevice *vdev, VRingDesc *desc,
     virtio_tswap16s(vdev, &desc->next);
 }
 
+/* Called within rcu_read_lock().  */
 static inline uint16_t vring_avail_flags(VirtQueue *vq)
 {
-    hwaddr pa;
-    pa = vq->vring.avail + offsetof(VRingAvail, flags);
-    return virtio_lduw_phys(vq->vdev, pa);
+    VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
+    hwaddr pa = offsetof(VRingAvail, flags);
+    return virtio_lduw_phys_cached(vq->vdev, &caches->avail, pa);
 }
 
+/* Called within rcu_read_lock().  */
 static inline uint16_t vring_avail_idx(VirtQueue *vq)
 {
-    hwaddr pa;
-    pa = vq->vring.avail + offsetof(VRingAvail, idx);
-    vq->shadow_avail_idx = virtio_lduw_phys(vq->vdev, pa);
+    VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
+    hwaddr pa = offsetof(VRingAvail, idx);
+    vq->shadow_avail_idx = virtio_lduw_phys_cached(vq->vdev, &caches->avail, pa);
     return vq->shadow_avail_idx;
 }
 
+/* Called within rcu_read_lock().  */
 static inline uint16_t vring_avail_ring(VirtQueue *vq, int i)
 {
-    hwaddr pa;
-    pa = vq->vring.avail + offsetof(VRingAvail, ring[i]);
-    return virtio_lduw_phys(vq->vdev, pa);
+    VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
+    hwaddr pa = offsetof(VRingAvail, ring[i]);
+    return virtio_lduw_phys_cached(vq->vdev, &caches->avail, pa);
 }
 
+/* Called within rcu_read_lock().  */
 static inline uint16_t vring_get_used_event(VirtQueue *vq)
 {
     return vring_avail_ring(vq, vq->vring.num);
 }
 
+/* Called within rcu_read_lock().  */
 static inline void vring_used_write(VirtQueue *vq, VRingUsedElem *uelem,
                                     int i)
 {
-    hwaddr pa;
+    VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
+    hwaddr pa = offsetof(VRingUsed, ring[i]);
     virtio_tswap32s(vq->vdev, &uelem->id);
     virtio_tswap32s(vq->vdev, &uelem->len);
-    pa = vq->vring.used + offsetof(VRingUsed, ring[i]);
-    address_space_write(&address_space_memory, pa, MEMTXATTRS_UNSPECIFIED,
-                       (void *)uelem, sizeof(VRingUsedElem));
+    address_space_write_cached(&caches->used, pa, uelem, sizeof(VRingUsedElem));
+    address_space_cache_invalidate(&caches->used, pa, sizeof(VRingUsedElem));
 }
 
+/* Called within rcu_read_lock().  */
 static uint16_t vring_used_idx(VirtQueue *vq)
 {
-    hwaddr pa;
-    pa = vq->vring.used + offsetof(VRingUsed, idx);
-    return virtio_lduw_phys(vq->vdev, pa);
+    VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
+    hwaddr pa = vq->vring.used + offsetof(VRingUsed, idx);
+    return virtio_lduw_phys_cached(vq->vdev, &caches->used, pa);
 }
 
+/* Called within rcu_read_lock().  */
 static inline void vring_used_idx_set(VirtQueue *vq, uint16_t val)
 {
-    hwaddr pa;
-    pa = vq->vring.used + offsetof(VRingUsed, idx);
-    virtio_stw_phys(vq->vdev, pa, val);
+    VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
+    hwaddr pa = offsetof(VRingUsed, idx);
+    virtio_stw_phys_cached(vq->vdev, &caches->used, pa, val);
+    address_space_cache_invalidate(&caches->used, pa, sizeof(val));
     vq->used_idx = val;
 }
 
+/* Called within rcu_read_lock().  */
 static inline void vring_used_flags_set_bit(VirtQueue *vq, int mask)
 {
+    VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
     VirtIODevice *vdev = vq->vdev;
-    hwaddr pa;
-    pa = vq->vring.used + offsetof(VRingUsed, flags);
-    virtio_stw_phys(vdev, pa, virtio_lduw_phys(vdev, pa) | mask);
+    hwaddr pa = offsetof(VRingUsed, flags);
+    uint16_t flags = virtio_lduw_phys_cached(vq->vdev, &caches->used, pa);
+
+    virtio_stw_phys_cached(vdev, &caches->used, pa, flags | mask);
+    address_space_cache_invalidate(&caches->used, pa, sizeof(flags));
 }
 
+/* Called within rcu_read_lock().  */
 static inline void vring_used_flags_unset_bit(VirtQueue *vq, int mask)
 {
+    VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
     VirtIODevice *vdev = vq->vdev;
-    hwaddr pa;
-    pa = vq->vring.used + offsetof(VRingUsed, flags);
-    virtio_stw_phys(vdev, pa, virtio_lduw_phys(vdev, pa) & ~mask);
+    hwaddr pa = offsetof(VRingUsed, flags);
+    uint16_t flags = virtio_lduw_phys_cached(vq->vdev, &caches->used, pa);
+
+    virtio_stw_phys_cached(vdev, &caches->used, pa, flags & ~mask);
+    address_space_cache_invalidate(&caches->used, pa, sizeof(flags));
 }
 
+/* Called within rcu_read_lock().  */
 static inline void vring_set_avail_event(VirtQueue *vq, uint16_t val)
 {
+    VRingMemoryRegionCaches *caches;
     hwaddr pa;
     if (!vq->notification) {
         return;
     }
-    pa = vq->vring.used + offsetof(VRingUsed, ring[vq->vring.num]);
-    virtio_stw_phys(vq->vdev, pa, val);
+
+    caches = atomic_rcu_read(&vq->vring.caches);
+    pa = offsetof(VRingUsed, ring[vq->vring.num]);
+    virtio_stw_phys_cached(vq->vdev, &caches->used, pa, val);
 }
 
 void virtio_queue_set_notification(VirtQueue *vq, int enable)
 {
     vq->notification = enable;
+    rcu_read_lock();
     if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
         vring_set_avail_event(vq, vring_avail_idx(vq));
     } else if (enable) {
@@ -271,6 +293,7 @@ void virtio_queue_set_notification(VirtQueue *vq, int enable)
         /* Expose avail event/used flags before caller checks the avail idx. */
         smp_mb();
     }
+    rcu_read_unlock();
 }
 
 int virtio_queue_ready(VirtQueue *vq)
@@ -279,8 +302,9 @@ int virtio_queue_ready(VirtQueue *vq)
 }
 
 /* Fetch avail_idx from VQ memory only when we really need to know if
- * guest has added some buffers. */
-int virtio_queue_empty(VirtQueue *vq)
+ * guest has added some buffers.
+ * Called within rcu_read_lock().  */
+static int virtio_queue_empty_rcu(VirtQueue *vq)
 {
     if (vq->shadow_avail_idx != vq->last_avail_idx) {
         return 0;
@@ -289,6 +313,20 @@ int virtio_queue_empty(VirtQueue *vq)
     return vring_avail_idx(vq) == vq->last_avail_idx;
 }
 
+int virtio_queue_empty(VirtQueue *vq)
+{
+    bool empty;
+
+    if (vq->shadow_avail_idx != vq->last_avail_idx) {
+        return 0;
+    }
+
+    rcu_read_lock();
+    empty = vring_avail_idx(vq) == vq->last_avail_idx;
+    rcu_read_unlock();
+    return empty;
+}
+
 static void virtqueue_unmap_sg(VirtQueue *vq, const VirtQueueElement *elem,
                                unsigned int len)
 {
@@ -365,6 +403,7 @@ bool virtqueue_rewind(VirtQueue *vq, unsigned int num)
     return true;
 }
 
+/* Called within rcu_read_lock().  */
 void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
                     unsigned int len, unsigned int idx)
 {
@@ -385,6 +424,7 @@ void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
     vring_used_write(vq, &uelem, idx);
 }
 
+/* Called within rcu_read_lock().  */
 void virtqueue_flush(VirtQueue *vq, unsigned int count)
 {
     uint16_t old, new;
@@ -408,10 +448,13 @@ void virtqueue_flush(VirtQueue *vq, unsigned int count)
 void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
                     unsigned int len)
 {
+    rcu_read_lock();
     virtqueue_fill(vq, elem, len, 0);
     virtqueue_flush(vq, 1);
+    rcu_read_unlock();
 }
 
+/* Called within rcu_read_lock().  */
 static int virtqueue_num_heads(VirtQueue *vq, unsigned int idx)
 {
     uint16_t num_heads = vring_avail_idx(vq) - idx;
@@ -431,6 +474,7 @@ static int virtqueue_num_heads(VirtQueue *vq, unsigned int idx)
     return num_heads;
 }
 
+/* Called within rcu_read_lock().  */
 static bool virtqueue_get_head(VirtQueue *vq, unsigned int idx,
                                unsigned int *head)
 {
@@ -739,8 +783,9 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     if (unlikely(vdev->broken)) {
         return NULL;
     }
-    if (virtio_queue_empty(vq)) {
-        return NULL;
+    rcu_read_lock();
+    if (virtio_queue_empty_rcu(vq)) {
+        goto out_rcu;
     }
     /* Needed after virtio_queue_empty(), see comment in
      * virtqueue_num_heads(). */
@@ -753,11 +798,11 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
 
     if (vq->inuse >= vq->vring.num) {
         virtio_error(vdev, "Virtqueue size exceeded");
-        return NULL;
+        goto out_rcu;
     }
 
     if (!virtqueue_get_head(vq, vq->last_avail_idx++, &head)) {
-        return NULL;
+        goto out_rcu;
     }
 
     if (virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
@@ -770,7 +815,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     caches = atomic_rcu_read(&vq->vring.caches);
     if (caches->desc.len < max * sizeof(VRingDesc)) {
         virtio_error(vdev, "Cannot map descriptor ring");
-        return NULL;
+        goto out_rcu;
     }
 
     desc_cache = &caches->desc;
@@ -778,7 +823,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     if (desc.flags & VRING_DESC_F_INDIRECT) {
         if (desc.len % sizeof(VRingDesc)) {
             virtio_error(vdev, "Invalid size for indirect buffer table");
-            return NULL;
+            goto out_rcu;
         }
 
         /* loop over the indirect descriptor table */
@@ -788,7 +833,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
         desc_cache = &indirect_desc_cache;
         if (len < desc.len) {
             virtio_error(vdev, "Cannot map indirect buffer");
-            return NULL;
+            goto out_rcu;
         }
 
         max = desc.len / sizeof(VRingDesc);
@@ -850,12 +895,13 @@ done:
     if (desc_cache == &indirect_desc_cache) {
         address_space_cache_destroy(&indirect_desc_cache);
     }
-    rcu_read_unlock();
 
+    rcu_read_unlock();
     return elem;
 
 err_undo_map:
     virtqueue_undo_map_desc(out_num, in_num, iov);
+out_rcu:
     elem = NULL;
     goto done;
 }
@@ -1426,6 +1472,7 @@ static void virtio_set_isr(VirtIODevice *vdev, int value)
     }
 }
 
+/* Called within rcu_read_lock().  */
 static bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq)
 {
     uint16_t old, new;
@@ -1451,7 +1498,12 @@ static bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq)
 
 void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq)
 {
-    if (!virtio_should_notify(vdev, vq)) {
+    bool should_notify;
+    rcu_read_lock();
+    should_notify = virtio_should_notify(vdev, vq);
+    rcu_read_unlock();
+
+    if (!should_notify) {
         return;
     }
 
@@ -1478,7 +1530,12 @@ void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq)
 
 void virtio_notify(VirtIODevice *vdev, VirtQueue *vq)
 {
-    if (!virtio_should_notify(vdev, vq)) {
+    bool should_notify;
+    rcu_read_lock();
+    should_notify = virtio_should_notify(vdev, vq);
+    rcu_read_unlock();
+
+    if (!should_notify) {
         return;
     }
 
@@ -1932,6 +1989,7 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
         }
     }
 
+    rcu_read_lock();
     for (i = 0; i < num; i++) {
         if (vdev->vq[i].vring.desc) {
             uint16_t nheads;
@@ -1964,6 +2022,7 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
             }
         }
     }
+    rcu_read_unlock();
 
     return 0;
 }
-- 
1.8.3.1
