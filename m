Received: from eggs.gnu.org ([2001:4830:134:3::10]:50563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUcfY-0006qj-Fd
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 12:08:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUcfX-0001Lr-CK
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 12:08:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cUcfX-0001LK-3a
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 12:08:07 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 55E727FE91
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 17:08:07 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Jan 2017 18:07:56 +0100
Message-Id: <20170120170757.30308-7-pbonzini@redhat.com>
In-Reply-To: <20170120170757.30308-1-pbonzini@redhat.com>
References: <20170120170757.30308-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 6/7] virtio: use VRingMemoryRegionCaches for
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
Cc: mst@redhat.com, stefanha@redhat.com

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/virtio/virtio.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 848c30f..668a97f 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -487,17 +487,16 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
     unsigned int max, idx;
     unsigned int total_bufs, in_total, out_total;
     MemoryRegionCache *desc_cache = NULL;
-    MemoryRegionCache vring_desc_cache;
     MemoryRegionCache indirect_desc_cache;
+    VRingMemoryRegionCaches *caches;
     int64_t len = 0;
     int rc;
 
+    rcu_read_lock();
     idx = vq->last_avail_idx;
     max = vq->vring.num;
-    len = address_space_cache_init(&vring_desc_cache, vdev->dma_as,
-                                   vq->vring.desc, max * sizeof(VRingDesc),
-                                   false);
-    if (len < max * sizeof(VRingDesc)) {
+    caches = atomic_rcu_read(&vq->vring.caches);
+    if (caches->desc.len < max * sizeof(VRingDesc)) {
         virtio_error(vdev, "Cannot map descriptor ring");
         goto err;
     }
@@ -514,7 +513,7 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
             goto err;
         }
 
-        desc_cache = &vring_desc_cache;
+        desc_cache = &caches->desc;
         vring_desc_read(vdev, &desc, desc_cache, i);
 
         if (desc.flags & VRING_DESC_F_INDIRECT) {
@@ -580,13 +579,13 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
     }
 
 done:
-    address_space_cache_destroy(&vring_desc_cache);
     if (in_bytes) {
         *in_bytes = in_total;
     }
     if (out_bytes) {
         *out_bytes = out_total;
     }
+    rcu_read_unlock();
     return;
 
 err:
@@ -722,7 +721,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     unsigned int i, head, max;
     MemoryRegionCache *desc_cache = NULL;
     MemoryRegionCache indirect_desc_cache;
-    MemoryRegionCache vring_desc_cache;
+    VRingMemoryRegionCaches *caches;
     int64_t len;
     VirtIODevice *vdev = vq->vdev;
     VirtQueueElement *elem = NULL;
@@ -762,15 +761,14 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
 
     i = head;
 
-    len = address_space_cache_init(&vring_desc_cache, vdev->dma_as,
-                                   vq->vring.desc, max * sizeof(VRingDesc),
-                                   false);
-    desc_cache = &vring_desc_cache;
-    if (len < max * sizeof(VRingDesc)) {
+    rcu_read_lock();
+    caches = atomic_rcu_read(&vq->vring.caches);
+    if (caches->desc.len < max * sizeof(VRingDesc)) {
         virtio_error(vdev, "Cannot map descriptor ring");
         return NULL;
     }
 
+    desc_cache = &caches->desc;
     vring_desc_read(vdev, &desc, desc_cache, i);
     if (desc.flags & VRING_DESC_F_INDIRECT) {
         if (desc.len % sizeof(VRingDesc)) {
@@ -846,7 +844,7 @@ done:
     if (desc_cache == &indirect_desc_cache) {
         address_space_cache_destroy(&indirect_desc_cache);
     }
-    address_space_cache_destroy(&vring_desc_cache);
+    rcu_read_unlock();
 
     return elem;
 
-- 
2.9.3
