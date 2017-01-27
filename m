Received: from eggs.gnu.org ([2001:4830:134:3::10]:33290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX8dg-0002X9-JV
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:40:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX8de-0007na-O4
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:40:36 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX8de-0007nP-EJ
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:40:34 -0500
Received: by mail-wm0-x244.google.com with SMTP id r126so59042729wmr.3
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 07:40:34 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 16:40:20 +0100
Message-Id: <1485531620-121182-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485531620-121182-1-git-send-email-pbonzini@redhat.com>
References: <1485531620-121182-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 9/9] virtio: use VRingMemoryRegionCaches for
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
Cc: mst@redhat.com

The virtio-net change is necessary because it uses virtqueue_fill
and virtqueue_flush instead of the more convenient virtqueue_push.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/net/virtio-net.c |  14 +++++-
 hw/virtio/virtio.c  | 132 ++++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 109 insertions(+), 37 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7b3ad4a..6f0e397 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1130,7 +1130,8 @@ static int receive_filter(VirtIONet *n, const uint8_t *buf, int size)
     return 0;
 }
 
-static ssize_t virtio_net_receive(NetClientState *nc, const uint8_t *buf, size_t size)
+static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
+                                      size_t size)
 {
     VirtIONet *n = qemu_get_nic_opaque(nc);
     VirtIONetQueue *q = virtio_net_get_subqueue(nc);
@@ -1233,6 +1234,17 @@ static ssize_t virtio_net_receive(NetClientState *nc, const uint8_t *buf, size_t
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
index 23fac1e..3668803 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -173,6 +173,7 @@ void virtio_queue_update_rings(VirtIODevice *vdev, int n)
     virtio_init_region_cache(vdev, n);
 }
 
+/* Called within rcu_read_lock().  */
 static void vring_desc_read(VirtIODevice *vdev, VRingDesc *desc,
                             MemoryRegionCache *cache, int i)
 {
@@ -184,88 +185,110 @@ static void vring_desc_read(VirtIODevice *vdev, VRingDesc *desc,
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
-    address_space_write(vq->vdev->dma_as, pa, MEMTXATTRS_UNSPECIFIED,
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
+    hwaddr pa = offsetof(VRingUsed, idx);
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
+
+    rcu_read_lock();
     if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
         vring_set_avail_event(vq, vring_avail_idx(vq));
     } else if (enable) {
@@ -277,6 +300,7 @@ void virtio_queue_set_notification(VirtQueue *vq, int enable)
         /* Expose avail event/used flags before caller checks the avail idx. */
         smp_mb();
     }
+    rcu_read_unlock();
 }
 
 int virtio_queue_ready(VirtQueue *vq)
@@ -285,8 +309,9 @@ int virtio_queue_ready(VirtQueue *vq)
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
@@ -295,6 +320,20 @@ int virtio_queue_empty(VirtQueue *vq)
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
@@ -373,6 +412,7 @@ bool virtqueue_rewind(VirtQueue *vq, unsigned int num)
     return true;
 }
 
+/* Called within rcu_read_lock().  */
 void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
                     unsigned int len, unsigned int idx)
 {
@@ -393,6 +433,7 @@ void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
     vring_used_write(vq, &uelem, idx);
 }
 
+/* Called within rcu_read_lock().  */
 void virtqueue_flush(VirtQueue *vq, unsigned int count)
 {
     uint16_t old, new;
@@ -416,10 +457,13 @@ void virtqueue_flush(VirtQueue *vq, unsigned int count)
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
@@ -439,6 +483,7 @@ static int virtqueue_num_heads(VirtQueue *vq, unsigned int idx)
     return num_heads;
 }
 
+/* Called within rcu_read_lock().  */
 static bool virtqueue_get_head(VirtQueue *vq, unsigned int idx,
                                unsigned int *head)
 {
@@ -740,8 +785,9 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     if (unlikely(vdev->broken)) {
         return NULL;
     }
-    if (virtio_queue_empty(vq)) {
-        return NULL;
+    rcu_read_lock();
+    if (virtio_queue_empty_rcu(vq)) {
+        goto done;
     }
     /* Needed after virtio_queue_empty(), see comment in
      * virtqueue_num_heads(). */
@@ -754,11 +800,11 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
 
     if (vq->inuse >= vq->vring.num) {
         virtio_error(vdev, "Virtqueue size exceeded");
-        return NULL;
+        goto done;
     }
 
     if (!virtqueue_get_head(vq, vq->last_avail_idx++, &head)) {
-        return NULL;
+        goto done;
     }
 
     if (virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
@@ -767,7 +813,6 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
 
     i = head;
 
-    rcu_read_lock();
     caches = atomic_rcu_read(&vq->vring.caches);
     if (caches->desc.len < max * sizeof(VRingDesc)) {
         virtio_error(vdev, "Cannot map descriptor ring");
@@ -1481,6 +1526,7 @@ static void virtio_set_isr(VirtIODevice *vdev, int value)
     }
 }
 
+/* Called within rcu_read_lock().  */
 static bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq)
 {
     uint16_t old, new;
@@ -1506,7 +1552,12 @@ static bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq)
 
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
 
@@ -1533,7 +1584,12 @@ void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq)
 
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
 
@@ -1994,6 +2050,7 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
         }
     }
 
+    rcu_read_lock();
     for (i = 0; i < num; i++) {
         if (vdev->vq[i].vring.desc) {
             uint16_t nheads;
@@ -2028,6 +2085,7 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
             }
         }
     }
+    rcu_read_unlock();
 
     return 0;
 }
@@ -2154,9 +2212,11 @@ void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n, uint16_t idx)
 
 void virtio_queue_update_used_idx(VirtIODevice *vdev, int n)
 {
+    rcu_read_lock();
     if (vdev->vq[n].vring.desc) {
         vdev->vq[n].used_idx = vring_used_idx(&vdev->vq[n]);
     }
+    rcu_read_unlock();
 }
 
 void virtio_queue_invalidate_signalled_used(VirtIODevice *vdev, int n)
-- 
1.8.3.1
