Received: from eggs.gnu.org ([2001:4830:134:3::10]:44329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cW5SF-0006D8-Or
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:04:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cW5SD-00009S-Rm
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:04:27 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cW5SD-00009G-JM
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:04:25 -0500
Received: by mail-wm0-x243.google.com with SMTP id r144so36413205wme.0
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 10:04:25 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 24 Jan 2017 19:04:15 +0100
Message-Id: <20170124180420.12430-4-pbonzini@redhat.com>
In-Reply-To: <20170124180420.12430-1-pbonzini@redhat.com>
References: <20170124180420.12430-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 3/8] virtio: use address_space_map/unmap to
 access descriptors
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

This makes little difference, but it makes the code change smaller
for the next patch that introduces MemoryRegionCache.  This is
because map/unmap are similar to MemoryRegionCache init/destroy.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/virtio/virtio.c | 103 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 75 insertions(+), 28 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index b1c5563..1b421cb 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -120,10 +120,9 @@ void virtio_queue_update_rings(VirtIODevice *vdev, int n)
 }
 
 static void vring_desc_read(VirtIODevice *vdev, VRingDesc *desc,
-                            hwaddr desc_pa, int i)
+                            uint8_t *desc_ptr, int i)
 {
-    address_space_read(vdev->dma_as, desc_pa + i * sizeof(VRingDesc),
-                       MEMTXATTRS_UNSPECIFIED, (void *)desc, sizeof(VRingDesc));
+    memcpy(desc, desc_ptr + i * sizeof(VRingDesc), sizeof(VRingDesc));
     virtio_tswap64s(vdev, &desc->addr);
     virtio_tswap32s(vdev, &desc->len);
     virtio_tswap16s(vdev, &desc->flags);
@@ -408,7 +407,7 @@ enum {
 };
 
 static int virtqueue_read_next_desc(VirtIODevice *vdev, VRingDesc *desc,
-                                    hwaddr desc_pa, unsigned int max,
+                                    void *desc_ptr, unsigned int max,
                                     unsigned int *next)
 {
     /* If this descriptor says it doesn't chain, we're done. */
@@ -426,7 +425,7 @@ static int virtqueue_read_next_desc(VirtIODevice *vdev, VRingDesc *desc,
         return VIRTQUEUE_READ_DESC_ERROR;
     }
 
-    vring_desc_read(vdev, desc, desc_pa, *next);
+    vring_desc_read(vdev, desc, desc_ptr, *next);
     return VIRTQUEUE_READ_DESC_MORE;
 }
 
@@ -434,31 +433,41 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
                                unsigned int *out_bytes,
                                unsigned max_in_bytes, unsigned max_out_bytes)
 {
-    unsigned int idx;
+    VirtIODevice *vdev = vq->vdev;
+    unsigned int max, idx;
     unsigned int total_bufs, in_total, out_total;
+    void *vring_desc_ptr;
+    void *indirect_desc_ptr = NULL;
+    hwaddr len = 0;
     int rc;
 
     idx = vq->last_avail_idx;
-
     total_bufs = in_total = out_total = 0;
+
+    max = vq->vring.num;
+    len = max * sizeof(VRingDesc);
+    vring_desc_ptr = address_space_map(vdev->dma_as, vq->vring.desc, &len, false);
+    if (len < max * sizeof(VRingDesc)) {
+        virtio_error(vdev, "Cannot map descriptor ring");
+        goto err;
+    }
+
     while ((rc = virtqueue_num_heads(vq, idx)) > 0) {
-        VirtIODevice *vdev = vq->vdev;
-        unsigned int max, num_bufs, indirect = 0;
+        void *desc_ptr = vring_desc_ptr;
+        unsigned int num_bufs;
         VRingDesc desc;
-        hwaddr desc_pa;
         unsigned int i;
 
-        max = vq->vring.num;
         num_bufs = total_bufs;
 
         if (!virtqueue_get_head(vq, idx++, &i)) {
             goto err;
         }
 
-        desc_pa = vq->vring.desc;
-        vring_desc_read(vdev, &desc, desc_pa, i);
+        vring_desc_read(vdev, &desc, desc_ptr, i);
 
         if (desc.flags & VRING_DESC_F_INDIRECT) {
+            len = desc.len;
             if (desc.len % sizeof(VRingDesc)) {
                 virtio_error(vdev, "Invalid size for indirect buffer table");
                 goto err;
@@ -471,11 +480,17 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
             }
 
             /* loop over the indirect descriptor table */
-            indirect = 1;
+            indirect_desc_ptr = address_space_map(vdev->dma_as, desc.addr,
+                                                  &len, false);
+            desc_ptr = indirect_desc_ptr;
+            if (len < desc.len) {
+                virtio_error(vdev, "Cannot map indirect buffer");
+                goto err;
+            }
+
             max = desc.len / sizeof(VRingDesc);
-            desc_pa = desc.addr;
             num_bufs = i = 0;
-            vring_desc_read(vdev, &desc, desc_pa, i);
+            vring_desc_read(vdev, &desc, desc_ptr, i);
         }
 
         do {
@@ -494,17 +509,20 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
                 goto done;
             }
 
-            rc = virtqueue_read_next_desc(vdev, &desc, desc_pa, max, &i);
+            rc = virtqueue_read_next_desc(vdev, &desc, desc_ptr, max, &i);
         } while (rc == VIRTQUEUE_READ_DESC_MORE);
 
         if (rc == VIRTQUEUE_READ_DESC_ERROR) {
             goto err;
         }
 
-        if (!indirect)
-            total_bufs = num_bufs;
-        else
+        if (desc_ptr == indirect_desc_ptr) {
+            address_space_unmap(vdev->dma_as, desc_ptr, len, false, 0);
+            indirect_desc_ptr = NULL;
             total_bufs++;
+        } else {
+            total_bufs = num_bufs;
+        }
     }
 
     if (rc < 0) {
@@ -512,6 +530,10 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
     }
 
 done:
+    if (indirect_desc_ptr) {
+        address_space_unmap(vdev->dma_as, indirect_desc_ptr, len, false, 0);
+    }
+    address_space_unmap(vdev->dma_as, vring_desc_ptr, len, false, 0);
     if (in_bytes) {
         *in_bytes = in_total;
     }
@@ -651,9 +673,12 @@ static void *virtqueue_alloc_element(size_t sz, unsigned out_num, unsigned in_nu
 void *virtqueue_pop(VirtQueue *vq, size_t sz)
 {
     unsigned int i, head, max;
-    hwaddr desc_pa = vq->vring.desc;
+    void *vring_desc_ptr;
+    void *indirect_desc_ptr = NULL;
+    void *desc_ptr;
+    hwaddr len;
     VirtIODevice *vdev = vq->vdev;
-    VirtQueueElement *elem;
+    VirtQueueElement *elem = NULL;
     unsigned out_num, in_num;
     hwaddr addr[VIRTQUEUE_MAX_SIZE];
     struct iovec iov[VIRTQUEUE_MAX_SIZE];
@@ -689,18 +714,34 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     }
 
     i = head;
-    vring_desc_read(vdev, &desc, desc_pa, i);
+
+    len = max * sizeof(VRingDesc);
+    vring_desc_ptr = address_space_map(vdev->dma_as, vq->vring.desc, &len, false);
+    if (len < max * sizeof(VRingDesc)) {
+        virtio_error(vdev, "Cannot map descriptor ring");
+        return NULL;
+    }
+
+    desc_ptr = vring_desc_ptr;
+    vring_desc_read(vdev, &desc, desc_ptr, i);
     if (desc.flags & VRING_DESC_F_INDIRECT) {
         if (desc.len % sizeof(VRingDesc)) {
             virtio_error(vdev, "Invalid size for indirect buffer table");
-            return NULL;
+            goto done;
         }
 
         /* loop over the indirect descriptor table */
+        len = desc.len;
+        indirect_desc_ptr = address_space_map(vdev->dma_as, desc.addr, &len, false);
+        desc_ptr = indirect_desc_ptr;
+        if (len < desc.len) {
+            virtio_error(vdev, "Cannot map indirect buffer");
+            goto done;
+        }
+
         max = desc.len / sizeof(VRingDesc);
-        desc_pa = desc.addr;
         i = 0;
-        vring_desc_read(vdev, &desc, desc_pa, i);
+        vring_desc_read(vdev, &desc, desc_ptr, i);
     }
 
     /* Collect all the descriptors */
@@ -731,7 +772,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
             goto err_undo_map;
         }
 
-        rc = virtqueue_read_next_desc(vdev, &desc, desc_pa, max, &i);
+        rc = virtqueue_read_next_desc(vdev, &desc, desc_ptr, max, &i);
     } while (rc == VIRTQUEUE_READ_DESC_MORE);
 
     if (rc == VIRTQUEUE_READ_DESC_ERROR) {
@@ -753,11 +794,17 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     vq->inuse++;
 
     trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
+done:
+    if (indirect_desc_ptr) {
+        address_space_unmap(vdev->dma_as, indirect_desc_ptr, len, false, 0);
+    }
+    address_space_unmap(vdev->dma_as, vring_desc_ptr, len, false, 0);
+
     return elem;
 
 err_undo_map:
     virtqueue_undo_map_desc(out_num, in_num, iov);
-    return NULL;
+    goto done;
 }
 
 /* virtqueue_drop_all:
-- 
2.9.3
