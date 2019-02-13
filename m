Received: from eggs.gnu.org ([209.51.188.92]:52823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gtujd-00048J-2u
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:37:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gtuja-0006TI-61
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:37:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gtujY-0006Gh-4S
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:37:53 -0500
From: wexu@redhat.com
Date: Wed, 13 Feb 2019 08:25:43 -0500
Message-Id: <1550064346-17012-9-git-send-email-wexu@redhat.com>
In-Reply-To: <1550064346-17012-1-git-send-email-wexu@redhat.com>
References: <1550064346-17012-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [PATCH 08/11] virtio: event suppression support for
 packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: wexu@redhat.com, jasowang@redhat.com, mst@redhat.com, jfreiman@redhat.com, maxime.coquelin@redhat.com, tiwei.bie@intel.com

From: Wei Xu <wexu@redhat.com>

Difference between 'avail_wrap_counter' and 'last_avail_wrap_counter':
For Tx(guest transmitting), they are the same after each pop of a desc.

For Rx(guest receiving), they are also the same when there are enough
descriptors to carry the payload for a packet(e.g. usually 16 descs are
needed for a 64k packet in typical iperf tcp connection with tso enabled),
however, when the ring is running out of descriptors while there are
still a few free ones, e.g. 6 descriptors are available which is not
enough to carry an entire packet which needs 16 descriptors, in this
case the 'avail_wrap_counter' should be set as the first one pending
being handled by guest driver in order to get a notification, and the
'last_avail_wrap_counter' should stay unchanged to the head of available
descriptors, like below:

Mark meaning:
    | | -- available
    |*| -- used

A Snapshot of the queue:
                                      last_avail_idx = 253
                                      last_avail_wrap_counter = 1
                                             |
    +---------------------------------------------+
 0  | | | |*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*| | | | 255
    +---------------------------------------------+
           |
  shadow_avail_idx = 3
  avail_wrap_counter = 0

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/virtio/virtio.c | 137 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 128 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 7e276b4..8cfc7b6 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -234,6 +234,34 @@ static void vring_desc_read(VirtIODevice *vdev, VRingDesc *desc,
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
+    address_space_write_cached(cache, offsetof(VRingPackedDescEvent, off_wrap),
+                            &off_wrap, sizeof(off_wrap));
+    address_space_cache_invalidate(cache,
+                offsetof(VRingPackedDescEvent, off_wrap), sizeof(off_wrap));
+}
+
+static void vring_packed_flags_write(VirtIODevice *vdev,
+                            MemoryRegionCache *cache, uint16_t flags)
+{
+    virtio_tswap16s(vdev, &flags);
+    address_space_write_cached(cache, offsetof(VRingPackedDescEvent, flags),
+                            &flags, sizeof(flags));
+    address_space_cache_invalidate(cache,
+                        offsetof(VRingPackedDescEvent, flags), sizeof(flags));
+}
+
 static VRingMemoryRegionCaches *vring_get_region_caches(struct VirtQueue *vq)
 {
     VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
@@ -340,14 +368,8 @@ static inline void vring_set_avail_event(VirtQueue *vq, uint16_t val)
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
@@ -363,6 +385,57 @@ void virtio_queue_set_notification(VirtQueue *vq, int enable)
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
+        if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
+            /* no need to write device area since this is outdated. */
+            goto out;
+        }
+
+        e.flags = VRING_PACKED_EVENT_FLAG_DISABLE;
+        goto update;
+    }
+
+    e.flags = VRING_PACKED_EVENT_FLAG_ENABLE;
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
+        uint16_t off_wrap = vq->shadow_avail_idx | vq->avail_wrap_counter << 15;
+
+        vring_packed_off_wrap_write(vq->vdev, &caches->used, off_wrap);
+        /* Make sure off_wrap is wrote before flags */
+        smp_wmb();
+
+        e.flags = VRING_PACKED_EVENT_FLAG_DESC;
+    }
+
+update:
+    vring_packed_flags_write(vq->vdev, &caches->used, e.flags);
+out:
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
@@ -2117,8 +2190,7 @@ static void virtio_set_isr(VirtIODevice *vdev, int value)
     }
 }
 
-/* Called within rcu_read_lock().  */
-static bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq)
+static bool virtio_split_should_notify(VirtIODevice *vdev, VirtQueue *vq)
 {
     uint16_t old, new;
     bool v;
@@ -2141,6 +2213,53 @@ static bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq)
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
+    if (e.flags == VRING_PACKED_EVENT_FLAG_DISABLE) {
+        return false;
+    } else if (e.flags == VRING_PACKED_EVENT_FLAG_ENABLE) {
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
