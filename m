Received: from eggs.gnu.org ([2001:4830:134:3::10]:54348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1f3hxG-0001KR-B2
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:56:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1f3hxC-0005hQ-3c
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:55:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33820 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1f3hxB-0005gD-J0
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:55:53 -0400
From: wexu@redhat.com
Date: Wed,  4 Apr 2018 20:54:02 +0800
Message-Id: <1522846444-31725-7-git-send-email-wexu@redhat.com>
In-Reply-To: <1522846444-31725-1-git-send-email-wexu@redhat.com>
References: <1522846444-31725-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [PATCH 6/8] virtio: flush/push support for packed ring
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

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/virtio/virtio.c | 104 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 90 insertions(+), 14 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 95a4681..def07c6 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -26,6 +26,7 @@
 
 #define AVAIL_DESC_PACKED(b) ((b) << 7)
 #define USED_DESC_PACKED(b)  ((b) << 15)
+#define VIRTQ_F_DESC_USED(w)  (AVAIL_DESC_PACKED(w) | USED_DESC_PACKED(w))
 
 /*
  * The alignment to use between consumer and producer parts of vring.
@@ -636,19 +637,11 @@ bool virtqueue_rewind(VirtQueue *vq, unsigned int num)
 }
 
 /* Called within rcu_read_lock().  */
-void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
+static void virtqueue_fill_split(VirtQueue *vq, const VirtQueueElement *elem,
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
@@ -660,16 +653,66 @@ void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
     vring_used_write(vq, &uelem, idx);
 }
 
-/* Called within rcu_read_lock().  */
-void virtqueue_flush(VirtQueue *vq, unsigned int count)
+static void virtqueue_fill_packed(VirtQueue *vq, const VirtQueueElement *elem)
 {
-    uint16_t old, new;
+    uint16_t i, w, head;
+    VRingMemoryRegionCaches *caches;
+    VRingDescPacked desc = {
+        .addr = 0,
+        .flags = 0,
+    };
+
+    if (unlikely(!vq->packed.desc)) {
+        return;
+    }
+
+    w = elem->wrap_counter;
+    caches = vring_get_region_caches(vq);
+    for (i = 0; i < elem->count; i++) {
+        head = (elem->index + i) % vq->packed.num;
+        /* Don't toggle the first one since it is the originally one */
+        if ((i > 0) && (!head)) {
+            w ^= 1;
+        }
+
+        desc.id = elem->index;
+        desc.flags = VIRTQ_F_DESC_USED(w);
+        desc.len = elem->len[i];
+        virtio_tswap16s(vq->vdev, &desc.id);
+        virtio_tswap32s(vq->vdev, &desc.len);
+        virtio_tswap16s(vq->vdev, &desc.flags);
+        address_space_write_cached(&caches->desc,
+                                   sizeof(VRingDescPacked) * head, &desc,
+                                   sizeof(VRingDescPacked));
+        address_space_cache_invalidate(&caches->desc,
+                                       sizeof(VRingDescPacked) * head,
+                                       sizeof(VRingDescPacked));
+    }
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
+        virtqueue_fill_packed(vq, elem);
+    } else {
+        virtqueue_fill_split(vq, elem, len, idx);
+    }
+}
+
+/* Called within rcu_read_lock().  */
+static void virtqueue_flush_split(VirtQueue *vq, unsigned int count)
+{
+    uint16_t old, new;
+
     if (unlikely(!vq->vring.used)) {
         return;
     }
@@ -685,12 +728,45 @@ void virtqueue_flush(VirtQueue *vq, unsigned int count)
         vq->signalled_used_valid = false;
 }
 
+static void virtqueue_flush_packed(VirtQueue *vq, unsigned int count)
+{
+    if (unlikely(!vq->packed.desc)) {
+        return;
+    }
+
+    vq->inuse -= count;
+
+    /* FIXME: is this correct? */
+    if (vq->inuse) {
+        return;
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
+        virtqueue_flush_packed(vq, count);
+    } else {
+        virtqueue_flush_split(vq, count);
+    }
+}
+
 void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
                     unsigned int len)
 {
     rcu_read_lock();
     virtqueue_fill(vq, elem, len, 0);
-    virtqueue_flush(vq, 1);
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+        /* FIXME: How to deal with the length field for chained desc */
+        virtqueue_flush(vq, elem->count);
+    } else {
+        virtqueue_flush(vq, 1);
+    }
     rcu_read_unlock();
 }
 
-- 
2.7.4
