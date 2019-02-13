Received: from eggs.gnu.org ([209.51.188.92]:52797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gtuja-00045m-54
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:37:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gtujY-0006OL-2f
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:37:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gtujT-0006Gk-T1
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:37:48 -0500
From: wexu@redhat.com
Date: Wed, 13 Feb 2019 08:25:40 -0500
Message-Id: <1550064346-17012-6-git-send-email-wexu@redhat.com>
In-Reply-To: <1550064346-17012-1-git-send-email-wexu@redhat.com>
References: <1550064346-17012-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [PATCH 05/11] virtio: queue/descriptor check helpers
 for packed ring
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

These are descriptor available and queue empty check helpers.

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/virtio/virtio.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 54dc098..f2ff980 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -368,6 +368,25 @@ int virtio_queue_ready(VirtQueue *vq)
     return vq->vring.avail != 0;
 }
 
+static void vring_packed_desc_read_flags(VirtIODevice *vdev,
+                    VRingPackedDesc *desc, MemoryRegionCache *cache, int i)
+{
+    address_space_read_cached(cache,
+              i * sizeof(VRingPackedDesc) + offsetof(VRingPackedDesc, flags),
+              &desc->flags, sizeof(desc->flags));
+    virtio_tswap16s(vdev, &desc->flags);
+}
+
+static inline bool is_desc_avail(struct VRingPackedDesc *desc,
+                                bool wrap_counter)
+{
+    bool avail, used;
+
+    avail = !!(desc->flags & (1 << VRING_PACKED_DESC_F_AVAIL));
+    used = !!(desc->flags & (1 << VRING_PACKED_DESC_F_USED));
+    return (avail != used) && (avail == wrap_counter);
+}
+
 /* Fetch avail_idx from VQ memory only when we really need to know if
  * guest has added some buffers.
  * Called within rcu_read_lock().  */
@@ -388,7 +407,7 @@ static int virtio_queue_empty_rcu(VirtQueue *vq)
     return vring_avail_idx(vq) == vq->last_avail_idx;
 }
 
-int virtio_queue_empty(VirtQueue *vq)
+static int virtio_queue_split_empty(VirtQueue *vq)
 {
     bool empty;
 
@@ -410,6 +429,41 @@ int virtio_queue_empty(VirtQueue *vq)
     return empty;
 }
 
+static int virtio_queue_packed_empty_rcu(VirtQueue *vq)
+{
+    struct VRingPackedDesc desc;
+    VRingMemoryRegionCaches *cache;
+
+    if (unlikely(!vq->vring.desc)) {
+        return 1;
+    }
+
+    cache = vring_get_region_caches(vq);
+    vring_packed_desc_read_flags(vq->vdev, &desc, &cache->desc,
+                                vq->last_avail_idx);
+
+    return !is_desc_avail(&desc, vq->last_avail_wrap_counter);
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
-- 
1.8.3.1
