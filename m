Received: from eggs.gnu.org ([2001:4830:134:3::10]:44215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=y3pv=Z6=redhat.com=mst@kernel.org>)
	id 1ceoc4-0004H0-CK
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:54:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=y3pv=Z6=redhat.com=mst@kernel.org>)
	id 1ceobz-0005fU-DV
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:54:40 -0500
Received: from mail.kernel.org ([198.145.29.136]:34414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=y3pv=Z6=redhat.com=mst@kernel.org>)
	id 1ceobz-0005es-3B
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:54:35 -0500
Date: Fri, 17 Feb 2017 21:54:30 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1487361200-29966-11-git-send-email-mst@redhat.com>
References: <1487361200-29966-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487361200-29966-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 10/23] virtio: use VRingMemoryRegionCaches for
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index b75cb52..d62509d 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -491,25 +491,24 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
     VirtIODevice *vdev = vq->vdev;
     unsigned int max, idx;
     unsigned int total_bufs, in_total, out_total;
-    MemoryRegionCache vring_desc_cache;
+    VRingMemoryRegionCaches *caches;
     MemoryRegionCache indirect_desc_cache = MEMORY_REGION_CACHE_INVALID;
     int64_t len = 0;
     int rc;
 
+    rcu_read_lock();
     idx = vq->last_avail_idx;
     total_bufs = in_total = out_total = 0;
 
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
 
     while ((rc = virtqueue_num_heads(vq, idx)) > 0) {
-        MemoryRegionCache *desc_cache = &vring_desc_cache;
+        MemoryRegionCache *desc_cache = &caches->desc;
         unsigned int num_bufs;
         VRingDesc desc;
         unsigned int i;
@@ -586,13 +585,13 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
 
 done:
     address_space_cache_destroy(&indirect_desc_cache);
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
@@ -726,7 +725,7 @@ static void *virtqueue_alloc_element(size_t sz, unsigned out_num, unsigned in_nu
 void *virtqueue_pop(VirtQueue *vq, size_t sz)
 {
     unsigned int i, head, max;
-    MemoryRegionCache vring_desc_cache;
+    VRingMemoryRegionCaches *caches;
     MemoryRegionCache indirect_desc_cache = MEMORY_REGION_CACHE_INVALID;
     MemoryRegionCache *desc_cache;
     int64_t len;
@@ -768,15 +767,14 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
 
     i = head;
 
-    len = address_space_cache_init(&vring_desc_cache, vdev->dma_as,
-                                   vq->vring.desc, max * sizeof(VRingDesc),
-                                   false);
-    if (len < max * sizeof(VRingDesc)) {
+    rcu_read_lock();
+    caches = atomic_rcu_read(&vq->vring.caches);
+    if (caches->desc.len < max * sizeof(VRingDesc)) {
         virtio_error(vdev, "Cannot map descriptor ring");
         goto done;
     }
 
-    desc_cache = &vring_desc_cache;
+    desc_cache = &caches->desc;
     vring_desc_read(vdev, &desc, desc_cache, i);
     if (desc.flags & VRING_DESC_F_INDIRECT) {
         if (desc.len % sizeof(VRingDesc)) {
@@ -850,7 +848,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
 done:
     address_space_cache_destroy(&indirect_desc_cache);
-    address_space_cache_destroy(&vring_desc_cache);
+    rcu_read_unlock();
 
     return elem;
 
-- 
MST
