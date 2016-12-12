Received: from eggs.gnu.org ([2001:4830:134:3::10]:39443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cGOdZ-0004hF-3n
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:19:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cGOdY-0000V5-87
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:19:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cGOdY-0000Ue-0t
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:19:16 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 Dec 2016 12:18:56 +0100
Message-Id: <20161212111857.23399-11-pbonzini@redhat.com>
In-Reply-To: <20161212111857.23399-1-pbonzini@redhat.com>
References: <20161212111857.23399-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 10/11] virtio: use VRingMemoryRegionCaches for
 descriptor ring
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
 hw/virtio/virtio.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 4f355b4..702da0b 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -484,18 +484,16 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
     unsigned int max, idx;
     unsigned int total_bufs, in_total, out_total;
     MemoryRegionCache *desc_cache = NULL;
-    MemoryRegionCache vring_desc_cache;
     MemoryRegionCache indirect_desc_cache;
+    VRingMemoryRegionCaches *caches;
     int64_t len = 0;
     int rc;
 
     rcu_read_lock();
     idx = vq->last_avail_idx;
     max = vq->vring.num;
-    len = address_space_cache_init(&vring_desc_cache, &address_space_memory,
-                                   vq->vring.desc, max * sizeof(VRingDesc),
-                                   false);
-    if (len < max * sizeof(VRingDesc)) {
+    caches = atomic_rcu_read(&vq->vring.caches);
+    if (caches->desc.len < max * sizeof(VRingDesc)) {
         virtio_error(vdev, "Cannot map descriptor ring");
         goto err;
     }
@@ -512,7 +510,7 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
             goto err;
         }
 
-        desc_cache = &vring_desc_cache;
+        desc_cache = &caches->desc;
         vring_desc_read(vdev, &desc, desc_cache, i);
 
         if (desc.flags & VRING_DESC_F_INDIRECT) {
@@ -578,7 +576,6 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
     }
 
 done:
-    address_space_cache_destroy(&vring_desc_cache);
     if (in_bytes) {
         *in_bytes = in_total;
     }
@@ -729,7 +726,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     unsigned int i, head, max;
     MemoryRegionCache *desc_cache = NULL;
     MemoryRegionCache indirect_desc_cache;
-    MemoryRegionCache vring_desc_cache;
+    VRingMemoryRegionCaches *caches;
     int64_t len;
     VirtIODevice *vdev = vq->vdev;
     VirtQueueElement *elem = NULL;
@@ -770,15 +767,13 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     i = head;
 
     rcu_read_lock();
-    len = address_space_cache_init(&vring_desc_cache, &address_space_memory,
-                                   vq->vring.desc, max * sizeof(VRingDesc),
-                                   false);
-    desc_cache = &vring_desc_cache;
-    if (len < max * sizeof(VRingDesc)) {
+    caches = atomic_rcu_read(&vq->vring.caches);
+    if (caches->desc.len < max * sizeof(VRingDesc)) {
         virtio_error(vdev, "Cannot map descriptor ring");
         return NULL;
     }
 
+    desc_cache = &caches->desc;
     vring_desc_read(vdev, &desc, desc_cache, i);
     if (desc.flags & VRING_DESC_F_INDIRECT) {
         if (desc.len % sizeof(VRingDesc)) {
@@ -855,7 +850,6 @@ done:
     if (desc_cache == &indirect_desc_cache) {
         address_space_cache_destroy(&indirect_desc_cache);
     }
-    address_space_cache_destroy(&vring_desc_cache);
     rcu_read_unlock();
 
     return elem;
-- 
1.8.3.1
