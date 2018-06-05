Received: from eggs.gnu.org ([2001:4830:134:3::10]:42632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1fQHJq-0002Fb-8q
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 15:08:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1fQHJo-0003C8-5a
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 15:08:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47186 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1fQHJn-0003Be-Vq
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 15:08:32 -0400
From: wexu@redhat.com
Date: Tue,  5 Jun 2018 15:08:02 -0400
Message-Id: <1528225683-11413-8-git-send-email-wexu@redhat.com>
In-Reply-To: <1528225683-11413-1-git-send-email-wexu@redhat.com>
References: <1528225683-11413-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [RFC v2 7/8] virtio: event suppression for packed ring
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

Signed-off-by: Wei Xu <wexu@redhat.com>
Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/virtio/virtio.c                             | 115 +++++++++++++++++++++++--
 include/standard-headers/linux/virtio_config.h |  13 +++
 2 files changed, 119 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 6f2da83..4543974 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -226,6 +226,24 @@ static void vring_desc_read(VirtIODevice *vdev, VRingDesc *desc,
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
+static void vring_packed_event_write(VirtIODevice *vdev,
+                            MemoryRegionCache *cache, VRingPackedDescEvent *e)
+{
+    virtio_tswap16s(vdev, &e->off_wrap);
+    virtio_tswap16s(vdev, &e->flags);
+    address_space_write_cached(cache, 0, e, sizeof(*e));
+    address_space_cache_invalidate(cache, 0, sizeof(VRingUsedElem));
+}
+
+
 static VRingMemoryRegionCaches *vring_get_region_caches(struct VirtQueue *vq)
 {
     VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
@@ -332,14 +350,8 @@ static inline void vring_set_avail_event(VirtQueue *vq, uint16_t val)
     address_space_cache_invalidate(&caches->used, pa, sizeof(val));
 }
 
-void virtio_queue_set_notification(VirtQueue *vq, int enable)
+static void virtio_queue_set_notification_split(VirtQueue *vq, int enable)
 {
-    vq->notification = enable;
-
-    if (!vq->vring.desc) {
-        return;
-    }
-
     rcu_read_lock();
     if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
         vring_set_avail_event(vq, vring_avail_idx(vq));
@@ -355,6 +367,38 @@ void virtio_queue_set_notification(VirtQueue *vq, int enable)
     rcu_read_unlock();
 }
 
+static void virtio_queue_set_notification_packed(VirtQueue *vq, int enable)
+{
+    VRingPackedDescEvent e;
+    VRingMemoryRegionCaches *caches;
+
+    rcu_read_lock();
+    caches  = vring_get_region_caches(vq);
+    vring_packed_event_read(vq->vdev, &caches->device, &e);
+    if (enable) {
+        e.flags = RING_EVENT_FLAGS_ENABLE;
+    } else {
+        e.flags = RING_EVENT_FLAGS_DISABLE;
+    }
+    vring_packed_event_write(vq->vdev, &caches->device, &e);
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
@@ -2059,8 +2103,7 @@ static void virtio_set_isr(VirtIODevice *vdev, int value)
     }
 }
 
-/* Called within rcu_read_lock().  */
-static bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq)
+static bool virtio_split_should_notify(VirtIODevice *vdev, VirtQueue *vq)
 {
     uint16_t old, new;
     bool v;
@@ -2083,6 +2126,60 @@ static bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq)
     return !v || vring_need_event(vring_get_used_event(vq), new, old);
 }
 
+static bool vring_packed_need_event(VirtQueue *vq, uint16_t off_wrap,
+                                    uint16_t new, uint16_t old)
+{
+    bool wrap = vq->used_wrap_counter;
+    int off = off_wrap & ~(1 << 15);
+
+    if (new < old) {
+        new += vq->vring.num;
+        wrap ^= 1;
+    }
+
+    if (wrap != off_wrap >> 15) {
+        off += vq->vring.num;
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
+    vring_packed_event_read(vdev, &caches->driver, &e);
+
+    /* Make sure we see the updated flags */
+    smp_mb();
+    if (e.flags == RING_EVENT_FLAGS_DISABLE) {
+        return false;
+    } else if (e.flags == RING_EVENT_FLAGS_ENABLE) {
+        return true;
+    }
+
+    v = vq->signalled_used_valid;
+    vq->signalled_used_valid = true;
+    old = vq->signalled_used;
+    new = vq->signalled_used = vq->used_idx;
+
+    return !v || vring_packed_need_event(vq, e.off_wrap, new, old);
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
diff --git a/include/standard-headers/linux/virtio_config.h b/include/standard-headers/linux/virtio_config.h
index 6ee5529..53e5c83 100644
--- a/include/standard-headers/linux/virtio_config.h
+++ b/include/standard-headers/linux/virtio_config.h
@@ -73,4 +73,17 @@
 #define VIRTIO_F_IOMMU_PLATFORM		33
 
 #define VIRTIO_F_RING_PACKED		34
+
+/* Enable events */
+#define RING_EVENT_FLAGS_ENABLE 0x0
+/* Disable events */
+#define RING_EVENT_FLAGS_DISABLE 0x1
+/*
+ *  * Enable events for a specific descriptor
+ *   * (as specified by Descriptor Ring Change Event Offset/Wrap Counter).
+ *    * Only valid if VIRTIO_F_RING_EVENT_IDX has been negotiated.
+ *     */
+#define RING_EVENT_FLAGS_DESC 0x2
+/* The value 0x3 is reserved */
+
 #endif /* _LINUX_VIRTIO_CONFIG_H */
-- 
1.8.3.1
