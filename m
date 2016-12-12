Received: from eggs.gnu.org ([2001:4830:134:3::10]:39411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cGOdX-0004gk-TX
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:19:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cGOdV-0000Th-GO
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:19:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cGOdV-0000T8-5u
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:19:13 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 Dec 2016 12:18:54 +0100
Message-Id: <20161212111857.23399-9-pbonzini@redhat.com>
In-Reply-To: <20161212111857.23399-1-pbonzini@redhat.com>
References: <20161212111857.23399-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 08/11] virtio: use MemoryRegionCache to access
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
Cc: stefanha@redhat.com, famz@redhat.com, mst@redhat.com, borntraeger@de.ibm.com

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/virtio/virtio.c | 102 +++++++++++++++++++++++++++++------------------------
 1 file changed, 56 insertions(+), 46 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 459f9dd..562e2b7 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -119,9 +119,10 @@ void virtio_queue_update_rings(VirtIODevice *vdev, int n)
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
@@ -404,7 +405,7 @@ enum {
 };
 
 static int virtqueue_read_next_desc(VirtIODevice *vdev, VRingDesc *desc,
-                                    void *desc_ptr, unsigned int max,
+                                    MemoryRegionCache *desc_cache, unsigned int max,
                                     unsigned int *next)
 {
     /* If this descriptor says it doesn't chain, we're done. */
@@ -422,7 +423,7 @@ static int virtqueue_read_next_desc(VirtIODevice *vdev, VRingDesc *desc,
         return VIRTQUEUE_READ_DESC_ERROR;
     }
 
-    vring_desc_read(vdev, desc, desc_ptr, *next);
+    vring_desc_read(vdev, desc, desc_cache, *next);
     return VIRTQUEUE_READ_DESC_MORE;
 }
 
@@ -430,41 +431,42 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
                                unsigned int *out_bytes,
                                unsigned max_in_bytes, unsigned max_out_bytes)
 {
-    unsigned int idx;
+    VirtIODevice *vdev = vq->vdev;
+    unsigned int max, idx;
     unsigned int total_bufs, in_total, out_total;
-    void *desc_ptr = NULL;
-    hwaddr len = 0;
+    MemoryRegionCache *desc_cache = NULL;
+    MemoryRegionCache vring_desc_cache;
+    MemoryRegionCache indirect_desc_cache;
+    int64_t len = 0;
     int rc;
 
+    rcu_read_lock();
     idx = vq->last_avail_idx;
+    max = vq->vring.num;
+    len = address_space_cache_init(&vring_desc_cache, &address_space_memory,
+                                   vq->vring.desc, max * sizeof(VRingDesc),
+                                   false);
+    if (len < max * sizeof(VRingDesc)) {
+        virtio_error(vdev, "Cannot map descriptor ring");
+        goto err;
+    }
 
     total_bufs = in_total = out_total = 0;
     while ((rc = virtqueue_num_heads(vq, idx)) > 0) {
-        VirtIODevice *vdev = vq->vdev;
-        unsigned int max, num_bufs, indirect = 0;
+        unsigned int num_bufs;
         VRingDesc desc;
         unsigned int i;
 
-        max = vq->vring.num;
         num_bufs = total_bufs;
 
         if (!virtqueue_get_head(vq, idx++, &i)) {
             goto err;
         }
 
-        len = max * sizeof(VRingDesc);
-        desc_ptr = address_space_map(&address_space_memory, vq->vring.desc,
-                                     &len, false);
-        if (len < max * sizeof(VRingDesc)) {
-            virtio_error(vdev, "Cannot map descriptor ring");
-            goto err;
-        }
-
-        vring_desc_read(vdev, &desc, desc_ptr, i);
+        desc_cache = &vring_desc_cache;
+        vring_desc_read(vdev, &desc, desc_cache, i);
 
         if (desc.flags & VRING_DESC_F_INDIRECT) {
-            address_space_unmap(&address_space_memory, desc_ptr, len, false, 0);
-            len = desc.len;
             if (desc.len % sizeof(VRingDesc)) {
                 virtio_error(vdev, "Invalid size for indirect buffer table");
                 goto err;
@@ -477,17 +479,18 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
             }
 
             /* loop over the indirect descriptor table */
-            desc_ptr = address_space_map(&address_space_memory, desc.addr,
-                                         &len, false);
+            len = address_space_cache_init(&indirect_desc_cache,
+                                           &address_space_memory,
+                                           desc.addr, desc.len, false);
+            desc_cache = &indirect_desc_cache;
             if (len < desc.len) {
                 virtio_error(vdev, "Cannot map indirect buffer");
                 goto err;
             }
 
-            indirect = 1;
             max = desc.len / sizeof(VRingDesc);
             num_bufs = i = 0;
-            vring_desc_read(vdev, &desc, desc_ptr, i);
+            vring_desc_read(vdev, &desc, desc_cache, i);
         }
 
         do {
@@ -506,17 +509,19 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
                 goto done;
             }
 
-            rc = virtqueue_read_next_desc(vdev, &desc, desc_ptr, max, &i);
+            rc = virtqueue_read_next_desc(vdev, &desc, desc_cache, max, &i);
         } while (rc == VIRTQUEUE_READ_DESC_MORE);
 
         if (rc == VIRTQUEUE_READ_DESC_ERROR) {
             goto err;
         }
 
-        if (!indirect)
-            total_bufs = num_bufs;
-        else
+        if (desc_cache == &indirect_desc_cache) {
+            address_space_cache_destroy(&indirect_desc_cache);
             total_bufs++;
+        } else {
+            total_bufs = num_bufs;
+        }
     }
 
     if (rc < 0) {
@@ -524,15 +529,14 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
     }
 
 done:
-    if (desc_ptr) {
-        address_space_unmap(&address_space_memory, desc_ptr, len, false, 0);
-    }
+    address_space_cache_destroy(&vring_desc_cache);
     if (in_bytes) {
         *in_bytes = in_total;
     }
     if (out_bytes) {
         *out_bytes = out_total;
     }
+    rcu_read_unlock();
     return;
 
 err:
@@ -674,8 +678,10 @@ static void *virtqueue_alloc_element(size_t sz, unsigned out_num, unsigned in_nu
 void *virtqueue_pop(VirtQueue *vq, size_t sz)
 {
     unsigned int i, head, max;
-    void *desc_ptr = NULL;
-    hwaddr len;
+    MemoryRegionCache *desc_cache = NULL;
+    MemoryRegionCache indirect_desc_cache;
+    MemoryRegionCache vring_desc_cache;
+    int64_t len;
     VirtIODevice *vdev = vq->vdev;
     VirtQueueElement *elem = NULL;
     unsigned out_num, in_num;
@@ -714,26 +720,28 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
 
     i = head;
 
-    len = max * sizeof(VRingDesc);
-    desc_ptr = address_space_map(&address_space_memory, vq->vring.desc, &len,
-                                 false);
+    rcu_read_lock();
+    len = address_space_cache_init(&vring_desc_cache, &address_space_memory,
+                                   vq->vring.desc, max * sizeof(VRingDesc),
+                                   false);
+    desc_cache = &vring_desc_cache;
     if (len < max * sizeof(VRingDesc)) {
         virtio_error(vdev, "Cannot map descriptor ring");
         return NULL;
     }
 
-    vring_desc_read(vdev, &desc, desc_ptr, i);
+    vring_desc_read(vdev, &desc, desc_cache, i);
     if (desc.flags & VRING_DESC_F_INDIRECT) {
-        address_space_unmap(&address_space_memory, desc_ptr, len, false, 0);
         if (desc.len % sizeof(VRingDesc)) {
             virtio_error(vdev, "Invalid size for indirect buffer table");
             return NULL;
         }
 
         /* loop over the indirect descriptor table */
-        len = desc.len;
-        desc_ptr = address_space_map(&address_space_memory, desc.addr,
-                                     &len, false);
+        len = address_space_cache_init(&indirect_desc_cache,
+                                       &address_space_memory,
+                                       desc.addr, desc.len, false);
+        desc_cache = &indirect_desc_cache;
         if (len < desc.len) {
             virtio_error(vdev, "Cannot map indirect buffer");
             return NULL;
@@ -741,7 +749,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
 
         max = desc.len / sizeof(VRingDesc);
         i = 0;
-        vring_desc_read(vdev, &desc, desc_ptr, i);
+        vring_desc_read(vdev, &desc, desc_cache, i);
     }
 
     /* Collect all the descriptors */
@@ -772,7 +780,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
             goto err_undo_map;
         }
 
-        rc = virtqueue_read_next_desc(vdev, &desc, desc_ptr, max, &i);
+        rc = virtqueue_read_next_desc(vdev, &desc, desc_cache, max, &i);
     } while (rc == VIRTQUEUE_READ_DESC_MORE);
 
     if (rc == VIRTQUEUE_READ_DESC_ERROR) {
@@ -795,9 +803,11 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
 
     trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
 done:
-    if (desc_ptr) {
-        address_space_unmap(&address_space_memory, desc_ptr, len, false, 0);
+    if (desc_cache == &indirect_desc_cache) {
+        address_space_cache_destroy(&indirect_desc_cache);
     }
+    address_space_cache_destroy(&vring_desc_cache);
+    rcu_read_unlock();
 
     return elem;
 
-- 
1.8.3.1
