Received: from eggs.gnu.org ([2001:4830:134:3::10]:42561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1fQHJf-00023h-Fk
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 15:08:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1fQHJc-00032g-Hw
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 15:08:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46868 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1fQHJc-00032C-BM
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 15:08:20 -0400
From: wexu@redhat.com
Date: Tue,  5 Jun 2018 15:07:58 -0400
Message-Id: <1528225683-11413-4-git-send-email-wexu@redhat.com>
In-Reply-To: <1528225683-11413-1-git-send-email-wexu@redhat.com>
References: <1528225683-11413-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [RFC v2 3/8] virtio: empty check and desc read for
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
Cc: jasowang@redhat.com, tiwei.bie@intel.com, mst@redhat.com, wexu@redhat.com, jfreimann@redhat.com

From: Wei Xu <wexu@redhat.com>

helper for ring empty check and descriptor read.

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/virtio/virtio.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 59 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index f6c0689..bd669a2 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -24,6 +24,9 @@
 #include "hw/virtio/virtio-access.h"
 #include "sysemu/dma.h"
 
+#define AVAIL_DESC_PACKED(b) ((b) << 7)
+#define USED_DESC_PACKED(b)  ((b) << 15)
+
 /*
  * The alignment to use between consumer and producer parts of vring.
  * x86 pagesize again. This is the default, used by transports like PCI
@@ -357,10 +360,27 @@ int virtio_queue_ready(VirtQueue *vq)
     return vq->vring.avail != 0;
 }
 
+static void vring_packed_desc_read(VirtIODevice *vdev, VRingDescPacked *desc,
+                            MemoryRegionCache *cache, int i)
+{
+    address_space_read_cached(cache, i * sizeof(VRingDescPacked),
+                              desc, sizeof(VRingDescPacked));
+    virtio_tswap64s(vdev, &desc->addr);
+    virtio_tswap32s(vdev, &desc->len);
+    virtio_tswap16s(vdev, &desc->id);
+    virtio_tswap16s(vdev, &desc->flags);
+}
+
+static inline bool is_desc_avail(struct VRingDescPacked *desc)
+{
+    return !!(desc->flags & AVAIL_DESC_PACKED(1)) !=
+            !!(desc->flags & USED_DESC_PACKED(1));
+}
+
 /* Fetch avail_idx from VQ memory only when we really need to know if
  * guest has added some buffers.
  * Called within rcu_read_lock().  */
-static int virtio_queue_empty_rcu(VirtQueue *vq)
+static int virtio_queue_split_empty_rcu(VirtQueue *vq)
 {
     if (unlikely(!vq->vring.avail)) {
         return 1;
@@ -373,7 +393,7 @@ static int virtio_queue_empty_rcu(VirtQueue *vq)
     return vring_avail_idx(vq) == vq->last_avail_idx;
 }
 
-int virtio_queue_empty(VirtQueue *vq)
+static int virtio_queue_split_empty(VirtQueue *vq)
 {
     bool empty;
 
@@ -391,6 +411,42 @@ int virtio_queue_empty(VirtQueue *vq)
     return empty;
 }
 
+static int virtio_queue_packed_empty_rcu(VirtQueue *vq)
+{
+    struct VRingDescPacked desc;
+    VRingMemoryRegionCaches *cache;
+
+    if (unlikely(!vq->vring.desc)) {
+        return 1;
+    }
+
+    cache = vring_get_region_caches(vq);
+    vring_packed_desc_read(vq->vdev, &desc, &cache->desc, vq->last_avail_idx);
+
+    /* Make sure we see the updated flag */
+    smp_mb();
+    return !is_desc_avail(&desc);
+}
+
+static int virtio_queue_packed_empty(VirtQueue *vq)
+{
+    bool empty;
+
+    rcu_read_lock();
+    empty = virtio_queue_packed_empty_rcu(vq);
+    rcu_read_unlock();
+    return empty;
+}
+
+int virtio_queue_empty(VirtQueue *vq)
+{
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+        return virtio_queue_packed_empty(vq);
+    } else {
+        return virtio_queue_split_empty(vq);
+    }
+}
+
 static void virtqueue_unmap_sg(VirtQueue *vq, const VirtQueueElement *elem,
                                unsigned int len)
 {
@@ -862,7 +918,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
         return NULL;
     }
     rcu_read_lock();
-    if (virtio_queue_empty_rcu(vq)) {
+    if (virtio_queue_split_empty_rcu(vq)) {
         goto done;
     }
     /* Needed after virtio_queue_empty(), see comment in
-- 
1.8.3.1
