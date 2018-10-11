Received: from eggs.gnu.org ([2001:4830:134:3::10]:39291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gAbeP-0004p6-IX
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:09:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gAbeL-0005zI-PH
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:09:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:65252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gAbeL-0005xl-Ep
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:09:13 -0400
From: wexu@redhat.com
Date: Thu, 11 Oct 2018 10:08:28 -0400
Message-Id: <1539266915-15216-6-git-send-email-wexu@redhat.com>
In-Reply-To: <1539266915-15216-1-git-send-email-wexu@redhat.com>
References: <1539266915-15216-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [[RFC v3 05/12] virtio: init and desc empty check for
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
Cc: jasowang@redhat.com, tiwei.bie@intel.com, wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com

From: Wei Xu <wexu@redhat.com>

Basic initialization and helpers for packed ring.

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/virtio/virtio.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 9185efb..86f88da 100644
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
@@ -372,6 +375,23 @@ int virtio_queue_ready(VirtQueue *vq)
     return vq->vring.avail != 0;
 }
 
+static void vring_packed_desc_read_flags(VirtIODevice *vdev,
+                    VRingPackedDesc *desc, MemoryRegionCache *cache, int i)
+{
+    address_space_read_cached(cache,
+              i * sizeof(VRingPackedDesc) + offsetof(VRingPackedDesc, flags),
+              &desc->flags, sizeof(desc->flags));
+}
+
+static inline bool is_desc_avail(struct VRingPackedDesc *desc, bool wc)
+{
+    bool avail, used;
+
+    avail = !!(desc->flags & AVAIL_DESC_PACKED(1));
+    used = !!(desc->flags & USED_DESC_PACKED(1));
+    return (avail != used) && (avail == wc);
+}
+
 /* Fetch avail_idx from VQ memory only when we really need to know if
  * guest has added some buffers.
  * Called within rcu_read_lock().  */
@@ -392,7 +412,7 @@ static int virtio_queue_empty_rcu(VirtQueue *vq)
     return vring_avail_idx(vq) == vq->last_avail_idx;
 }
 
-int virtio_queue_empty(VirtQueue *vq)
+static int virtio_queue_split_empty(VirtQueue *vq)
 {
     bool empty;
 
@@ -414,6 +434,41 @@ int virtio_queue_empty(VirtQueue *vq)
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
+    return !is_desc_avail(&desc, vq->avail_wrap_counter);
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
