Received: from eggs.gnu.org ([209.51.188.92]:47428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gjpza-0003h6-6U
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:32:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gjpzX-0007zS-QV
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:32:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gjpzV-0007jW-Nc
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:32:43 -0500
From: wexu@redhat.com
Date: Wed, 16 Jan 2019 13:31:14 -0500
Message-Id: <1547663480-547-10-git-send-email-wexu@redhat.com>
In-Reply-To: <1547663480-547-1-git-send-email-wexu@redhat.com>
References: <1547663480-547-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [PATCH v2 09/15] virtio: event suppression support for
 packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wexu@redhat.com, tiwei.bie@intel.com, qemu-devel@nongnu.org
Cc: jasowang@redhat.com, mst@redhat.com, jfreiman@redhat.com, maxime.coquelin@redhat.com

From: Wei Xu <wexu@redhat.com>

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/virtio/virtio.c | 121 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 118 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 5562ecd..0bcf8a5 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -238,6 +238,30 @@ static void vring_desc_read(VirtIODevice *vdev, VRingDesc *desc,
     virtio_tswap16s(vdev, &desc->next);
 }
 
+static void vring_packed_event_read(VirtIODevice *vdev,
+                            MemoryRegionCache *cache, VRingPackedDescEvent *e)
+{
+    address_space_read_cached(cache, 0, e, sizeof(*e));
+    virtio_tswap16s(vdev, &e->off_wrap);
+    virtio_tswap16s(vdev, &e->flags);
+}
+
+static void vring_packed_off_wrap_write(VirtIODevice *vdev,
+                            MemoryRegionCache *cache, uint16_t off_wrap)
+{
+    virtio_tswap16s(vdev, &off_wrap);
+    address_space_write_cached(cache, 0, &off_wrap, sizeof(off_wrap));
+    address_space_cache_invalidate(cache, 0, sizeof(off_wrap));
+}
+
+static void vring_packed_flags_write(VirtIODevice *vdev,
+                            MemoryRegionCache *cache, uint16_t flags)
+{
+    virtio_tswap16s(vdev, &flags);
+    address_space_write_cached(cache, sizeof(uint16_t), &flags, sizeof(flags));
+    address_space_cache_invalidate(cache, sizeof(uint16_t), sizeof(flags));
+}
+
 static VRingMemoryRegionCaches *vring_get_region_caches(struct VirtQueue *vq)
 {
     VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
@@ -344,7 +368,7 @@ static inline void vring_set_avail_event(VirtQueue *vq, uint16_t val)
     address_space_cache_invalidate(&caches->used, pa, sizeof(val));
 }
 
-void virtio_queue_set_notification(VirtQueue *vq, int enable)
+static void virtio_queue_set_notification_split(VirtQueue *vq, int enable)
 {
     vq->notification = enable;
 
@@ -367,6 +391,51 @@ void virtio_queue_set_notification(VirtQueue *vq, int enable)
     rcu_read_unlock();
 }
 
+static void virtio_queue_set_notification_packed(VirtQueue *vq, int enable)
+{
+    VRingPackedDescEvent e;
+    VRingMemoryRegionCaches *caches;
+
+    rcu_read_lock();
+    caches  = vring_get_region_caches(vq);
+    vring_packed_event_read(vq->vdev, &caches->used, &e);
+
+    if (!enable) {
+        e.flags = RING_EVENT_FLAGS_DISABLE;
+        goto out;
+    }
+
+    e.flags = RING_EVENT_FLAGS_ENABLE;
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
+        uint16_t off_wrap = vq->shadow_avail_idx | vq->event_wrap_counter << 15;
+
+        vring_packed_off_wrap_write(vq->vdev, &caches->used, off_wrap);
+        /* Make sure off_wrap is wrote before flags */
+        smp_wmb();
+
+        e.flags = RING_EVENT_FLAGS_DESC;
+    }
+
+out:
+    vring_packed_flags_write(vq->vdev, &caches->used, e.flags);
+    rcu_read_unlock();
+}
+
+void virtio_queue_set_notification(VirtQueue *vq, int enable)
+{
+    vq->notification = enable;
+
+    if (!vq->vring.desc) {
+        return;
+    }
+
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+        virtio_queue_set_notification_packed(vq, enable);
+    } else {
+        virtio_queue_set_notification_split(vq, enable);
+    }
+}
+
 int virtio_queue_ready(VirtQueue *vq)
 {
     return vq->vring.avail != 0;
@@ -2118,8 +2187,7 @@ static void virtio_set_isr(VirtIODevice *vdev, int value)
     }
 }
 
-/* Called within rcu_read_lock().  */
-static bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq)
+static bool virtio_split_should_notify(VirtIODevice *vdev, VirtQueue *vq)
 {
     uint16_t old, new;
     bool v;
@@ -2142,6 +2210,53 @@ static bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq)
     return !v || vring_need_event(vring_get_used_event(vq), new, old);
 }
 
+static bool vring_packed_need_event(VirtQueue *vq, bool wrap,
+                            uint16_t off_wrap, uint16_t new, uint16_t old)
+{
+    int off = off_wrap & ~(1 << 15);
+
+    if (wrap != off_wrap >> 15) {
+        off -= vq->vring.num;
+    }
+
+    return vring_need_event(off, new, old);
+}
+
+static bool virtio_packed_should_notify(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VRingPackedDescEvent e;
+    uint16_t old, new;
+    bool v;
+    VRingMemoryRegionCaches *caches;
+
+    caches  = vring_get_region_caches(vq);
+    vring_packed_event_read(vdev, &caches->avail, &e);
+
+    old = vq->signalled_used;
+    new = vq->signalled_used = vq->used_idx;
+    v = vq->signalled_used_valid;
+    vq->signalled_used_valid = true;
+
+    if (e.flags == RING_EVENT_FLAGS_DISABLE) {
+        return false;
+    } else if (e.flags == RING_EVENT_FLAGS_ENABLE) {
+        return true;
+    }
+
+    return !v || vring_packed_need_event(vq,
+        vq->used_wrap_counter, e.off_wrap, new, old);
+}
+
+/* Called within rcu_read_lock().  */
+static bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq)
+{
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        return virtio_packed_should_notify(vdev, vq);
+    } else {
+        return virtio_split_should_notify(vdev, vq);
+    }
+}
+
 void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq)
 {
     bool should_notify;
-- 
1.8.3.1
