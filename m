Received: from eggs.gnu.org ([2001:4830:134:3::10]:42630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1fQHJq-0002FZ-7q
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 15:08:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1fQHJl-00038b-AD
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 15:08:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50274 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1fQHJl-00038A-3x
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 15:08:29 -0400
From: wexu@redhat.com
Date: Tue,  5 Jun 2018 15:08:01 -0400
Message-Id: <1528225683-11413-7-git-send-email-wexu@redhat.com>
In-Reply-To: <1528225683-11413-1-git-send-email-wexu@redhat.com>
References: <1528225683-11413-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [RFC v2 6/8] virtio: flush/push for packed ring
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
 hw/virtio/virtio.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 96 insertions(+), 13 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 0160d03..6f2da83 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -371,6 +371,21 @@ static void vring_packed_desc_read(VirtIODevice *vdev, VRingDescPacked *desc,
     virtio_tswap16s(vdev, &desc->flags);
 }
 
+static void vring_packed_desc_write(VirtIODevice *vdev, VRingDescPacked *desc,
+                            MemoryRegionCache *cache, int i)
+{
+    virtio_tswap64s(vdev, &desc->addr);
+    virtio_tswap32s(vdev, &desc->len);
+    virtio_tswap16s(vdev, &desc->id);
+    virtio_tswap16s(vdev, &desc->flags);
+    address_space_write_cached(cache,
+                               sizeof(VRingDescPacked) * i, desc,
+                               sizeof(VRingDescPacked));
+    address_space_cache_invalidate(cache,
+                                   sizeof(VRingDescPacked) * i,
+                                   sizeof(VRingDescPacked));
+}
+
 static inline bool is_desc_avail(struct VRingDescPacked *desc)
 {
     return !!(desc->flags & AVAIL_DESC_PACKED(1)) !=
@@ -526,19 +541,11 @@ bool virtqueue_rewind(VirtQueue *vq, unsigned int num)
 }
 
 /* Called within rcu_read_lock().  */
-void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
+static void virtqueue_split_fill(VirtQueue *vq, const VirtQueueElement *elem,
                     unsigned int len, unsigned int idx)
 {
     VRingUsedElem uelem;
 
-    trace_virtqueue_fill(vq, elem, len, idx);
-
-    virtqueue_unmap_sg(vq, elem, len);
-
-    if (unlikely(vq->vdev->broken)) {
-        return;
-    }
-
     if (unlikely(!vq->vring.used)) {
         return;
     }
@@ -550,16 +557,64 @@ void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
     vring_used_write(vq, &uelem, idx);
 }
 
-/* Called within rcu_read_lock().  */
-void virtqueue_flush(VirtQueue *vq, unsigned int count)
+static void virtqueue_packed_fill(VirtQueue *vq, const VirtQueueElement *elem,
+                        unsigned int len, unsigned int idx)
 {
-    uint16_t old, new;
+    uint16_t w, head;
+    VRingMemoryRegionCaches *caches;
+    VRingDescPacked desc = {
+        .addr = 0,
+        .flags = 0,
+    };
+
+    if (unlikely(!vq->vring.desc)) {
+        return;
+    }
+
+    caches = vring_get_region_caches(vq);
+    head = vq->used_idx + idx;
+    head = head >= vq->vring.num ? (head - vq->vring.num) : head;
+    vring_packed_desc_read(vq->vdev, &desc, &caches->desc, head);
+
+    w = (desc.flags & AVAIL_DESC_PACKED(1)) >> 7;
+    desc.flags &= ~(AVAIL_DESC_PACKED(1) | USED_DESC_PACKED(1));
+    desc.flags |= AVAIL_DESC_PACKED(w) | USED_DESC_PACKED(w);
+    if (!(desc.flags & VRING_DESC_F_INDIRECT)) {
+        if (!(desc.flags & VRING_DESC_F_WRITE)) {
+            desc.len = 0;
+        } else {
+            desc.len = len;
+        }
+    }
+    vring_packed_desc_write(vq->vdev, &desc, &caches->desc, head);
+
+    /* Make sure flags has been updated */
+    smp_mb();
+}
+
+void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
+                    unsigned int len, unsigned int idx)
+{
+    trace_virtqueue_fill(vq, elem, len, idx);
+
+    virtqueue_unmap_sg(vq, elem, len);
 
     if (unlikely(vq->vdev->broken)) {
-        vq->inuse -= count;
         return;
     }
 
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+        virtqueue_packed_fill(vq, elem, len, idx);
+    } else {
+        virtqueue_split_fill(vq, elem, len, idx);
+    }
+}
+
+/* Called within rcu_read_lock().  */
+static void virtqueue_split_flush(VirtQueue *vq, unsigned int count)
+{
+    uint16_t old, new;
+
     if (unlikely(!vq->vring.used)) {
         return;
     }
@@ -575,6 +630,34 @@ void virtqueue_flush(VirtQueue *vq, unsigned int count)
         vq->signalled_used_valid = false;
 }
 
+static void virtqueue_packed_flush(VirtQueue *vq, unsigned int count)
+{
+    if (unlikely(!vq->vring.desc)) {
+        return;
+    }
+
+    vq->inuse -= count;
+    vq->used_idx += count;
+    if (vq->used_idx >= vq->vring.num) {
+        vq->used_idx -= vq->vring.num;
+        vq->used_wrap_counter = !vq->used_wrap_counter;
+    }
+}
+
+void virtqueue_flush(VirtQueue *vq, unsigned int count)
+{
+    if (unlikely(vq->vdev->broken)) {
+        vq->inuse -= count;
+        return;
+    }
+
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+        virtqueue_packed_flush(vq, count);
+    } else {
+        virtqueue_split_flush(vq, count);
+    }
+}
+
 void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
                     unsigned int len)
 {
-- 
1.8.3.1
