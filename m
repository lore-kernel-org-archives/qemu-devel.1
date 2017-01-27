Received: from eggs.gnu.org ([2001:4830:134:3::10]:33224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX8db-0002S7-IL
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:40:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX8da-0007m4-4b
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:40:31 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX8dZ-0007lq-R8
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:40:30 -0500
Received: by mail-wm0-x242.google.com with SMTP id r144so59112146wme.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 07:40:29 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 16:40:16 +0100
Message-Id: <1485531620-121182-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485531620-121182-1-git-send-email-pbonzini@redhat.com>
References: <1485531620-121182-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 5/9] virtio: use MemoryRegionCache to access
 descriptors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com

For now, the cache is created on every virtqueue_pop.  Later on,
direct descriptors will be able to reuse it.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/virtio/virtio.c    | 80 +++++++++++++++++++++++++--------------------------
 include/exec/memory.h |  2 ++
 2 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index f44e072..8e9667b 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -120,9 +120,10 @@ void virtio_queue_update_rings(VirtIODevice *vdev, int n)
 }
 
 static void vring_desc_read(VirtIODevice *vdev, VRingDesc *desc,
-                            uint8_t *desc_ptr, int i)
+                            MemoryRegionCache *cache, int i)
 {
-    memcpy(desc, desc_ptr + i * sizeof(VRingDesc), sizeof(VRingDesc));
+    address_space_read_cached(cache, i * sizeof(VRingDesc),
+                              desc, sizeof(VRingDesc));
     virtio_tswap64s(vdev, &desc->addr);
     virtio_tswap32s(vdev, &desc->len);
     virtio_tswap16s(vdev, &desc->flags);
@@ -407,7 +408,7 @@ enum {
 };
 
 static int virtqueue_read_next_desc(VirtIODevice *vdev, VRingDesc *desc,
-                                    void *desc_ptr, unsigned int max,
+                                    MemoryRegionCache *desc_cache, unsigned int max,
                                     unsigned int *next)
 {
     /* If this descriptor says it doesn't chain, we're done. */
@@ -425,7 +426,7 @@ static int virtqueue_read_next_desc(VirtIODevice *vdev, VRingDesc *desc,
         return VIRTQUEUE_READ_DESC_ERROR;
     }
 
-    vring_desc_read(vdev, desc, desc_ptr, *next);
+    vring_desc_read(vdev, desc, desc_cache, *next);
     return VIRTQUEUE_READ_DESC_MORE;
 }
 
@@ -436,24 +437,25 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
     VirtIODevice *vdev = vq->vdev;
     unsigned int max, idx;
     unsigned int total_bufs, in_total, out_total;
-    void *vring_desc_ptr;
-    void *indirect_desc_ptr = NULL;
-    hwaddr len = 0;
+    MemoryRegionCache vring_desc_cache;
+    MemoryRegionCache indirect_desc_cache = MEMORY_REGION_CACHE_INVALID;
+    int64_t len = 0;
     int rc;
 
     idx = vq->last_avail_idx;
     total_bufs = in_total = out_total = 0;
 
     max = vq->vring.num;
-    len = max * sizeof(VRingDesc);
-    vring_desc_ptr = address_space_map(vdev->dma_as, vq->vring.desc, &len, false);
+    len = address_space_cache_init(&vring_desc_cache, vdev->dma_as,
+                                   vq->vring.desc, max * sizeof(VRingDesc),
+                                   false);
     if (len < max * sizeof(VRingDesc)) {
         virtio_error(vdev, "Cannot map descriptor ring");
         goto err;
     }
 
     while ((rc = virtqueue_num_heads(vq, idx)) > 0) {
-        void *desc_ptr = vring_desc_ptr;
+        MemoryRegionCache *desc_cache = &vring_desc_cache;
         unsigned int num_bufs;
         VRingDesc desc;
         unsigned int i;
@@ -464,10 +466,9 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
             goto err;
         }
 
-        vring_desc_read(vdev, &desc, desc_ptr, i);
+        vring_desc_read(vdev, &desc, desc_cache, i);
 
         if (desc.flags & VRING_DESC_F_INDIRECT) {
-            len = desc.len;
             if (desc.len % sizeof(VRingDesc)) {
                 virtio_error(vdev, "Invalid size for indirect buffer table");
                 goto err;
@@ -480,9 +481,10 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
             }
 
             /* loop over the indirect descriptor table */
-            indirect_desc_ptr = address_space_map(vdev->dma_as, desc.addr,
-                                                  &len, false);
-            desc_ptr = indirect_desc_ptr;
+            len = address_space_cache_init(&indirect_desc_cache,
+                                           vdev->dma_as,
+                                           desc.addr, desc.len, false);
+            desc_cache = &indirect_desc_cache;
             if (len < desc.len) {
                 virtio_error(vdev, "Cannot map indirect buffer");
                 goto err;
@@ -490,7 +492,7 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
 
             max = desc.len / sizeof(VRingDesc);
             num_bufs = i = 0;
-            vring_desc_read(vdev, &desc, desc_ptr, i);
+            vring_desc_read(vdev, &desc, desc_cache, i);
         }
 
         do {
@@ -509,16 +511,15 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
                 goto done;
             }
 
-            rc = virtqueue_read_next_desc(vdev, &desc, desc_ptr, max, &i);
+            rc = virtqueue_read_next_desc(vdev, &desc, desc_cache, max, &i);
         } while (rc == VIRTQUEUE_READ_DESC_MORE);
 
         if (rc == VIRTQUEUE_READ_DESC_ERROR) {
             goto err;
         }
 
-        if (desc_ptr == indirect_desc_ptr) {
-            address_space_unmap(vdev->dma_as, desc_ptr, len, false, 0);
-            indirect_desc_ptr = NULL;
+        if (desc_cache == &indirect_desc_cache) {
+            address_space_cache_destroy(&indirect_desc_cache);
             total_bufs++;
         } else {
             total_bufs = num_bufs;
@@ -530,10 +531,8 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
     }
 
 done:
-    if (indirect_desc_ptr) {
-        address_space_unmap(vdev->dma_as, indirect_desc_ptr, len, false, 0);
-    }
-    address_space_unmap(vdev->dma_as, vring_desc_ptr, len, false, 0);
+    address_space_cache_destroy(&indirect_desc_cache);
+    address_space_cache_destroy(&vring_desc_cache);
     if (in_bytes) {
         *in_bytes = in_total;
     }
@@ -673,10 +672,10 @@ static void *virtqueue_alloc_element(size_t sz, unsigned out_num, unsigned in_nu
 void *virtqueue_pop(VirtQueue *vq, size_t sz)
 {
     unsigned int i, head, max;
-    void *vring_desc_ptr;
-    void *indirect_desc_ptr = NULL;
-    void *desc_ptr;
-    hwaddr len;
+    MemoryRegionCache vring_desc_cache;
+    MemoryRegionCache indirect_desc_cache = MEMORY_REGION_CACHE_INVALID;
+    MemoryRegionCache *desc_cache;
+    int64_t len;
     VirtIODevice *vdev = vq->vdev;
     VirtQueueElement *elem = NULL;
     unsigned out_num, in_num;
@@ -715,15 +714,16 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
 
     i = head;
 
-    len = max * sizeof(VRingDesc);
-    vring_desc_ptr = address_space_map(vdev->dma_as, vq->vring.desc, &len, false);
+    len = address_space_cache_init(&vring_desc_cache, vdev->dma_as,
+                                   vq->vring.desc, max * sizeof(VRingDesc),
+                                   false);
     if (len < max * sizeof(VRingDesc)) {
         virtio_error(vdev, "Cannot map descriptor ring");
         goto done;
     }
 
-    desc_ptr = vring_desc_ptr;
-    vring_desc_read(vdev, &desc, desc_ptr, i);
+    desc_cache = &vring_desc_cache;
+    vring_desc_read(vdev, &desc, desc_cache, i);
     if (desc.flags & VRING_DESC_F_INDIRECT) {
         if (desc.len % sizeof(VRingDesc)) {
             virtio_error(vdev, "Invalid size for indirect buffer table");
@@ -731,9 +731,9 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
         }
 
         /* loop over the indirect descriptor table */
-        len = desc.len;
-        indirect_desc_ptr = address_space_map(vdev->dma_as, desc.addr, &len, false);
-        desc_ptr = indirect_desc_ptr;
+        len = address_space_cache_init(&indirect_desc_cache, vdev->dma_as,
+                                       desc.addr, desc.len, false);
+        desc_cache = &indirect_desc_cache;
         if (len < desc.len) {
             virtio_error(vdev, "Cannot map indirect buffer");
             goto done;
@@ -741,7 +741,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
 
         max = desc.len / sizeof(VRingDesc);
         i = 0;
-        vring_desc_read(vdev, &desc, desc_ptr, i);
+        vring_desc_read(vdev, &desc, desc_cache, i);
     }
 
     /* Collect all the descriptors */
@@ -772,7 +772,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
             goto err_undo_map;
         }
 
-        rc = virtqueue_read_next_desc(vdev, &desc, desc_ptr, max, &i);
+        rc = virtqueue_read_next_desc(vdev, &desc, desc_cache, max, &i);
     } while (rc == VIRTQUEUE_READ_DESC_MORE);
 
     if (rc == VIRTQUEUE_READ_DESC_ERROR) {
@@ -795,10 +795,8 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
 
     trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
 done:
-    if (indirect_desc_ptr) {
-        address_space_unmap(vdev->dma_as, indirect_desc_ptr, len, false, 0);
-    }
-    address_space_unmap(vdev->dma_as, vring_desc_ptr, len, false, 0);
+    address_space_cache_destroy(&indirect_desc_cache);
+    address_space_cache_destroy(&vring_desc_cache);
 
     return elem;
 
diff --git a/include/exec/memory.h b/include/exec/memory.h
index a10044f..cb40723 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1426,6 +1426,8 @@ struct MemoryRegionCache {
     bool is_write;
 };
 
+#define MEMORY_REGION_CACHE_INVALID ((MemoryRegionCache) { .mr = NULL })
+
 /* address_space_cache_init: prepare for repeated access to a physical
  * memory region
  *
-- 
1.8.3.1
