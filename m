Received: from eggs.gnu.org ([2001:4830:134:3::10]:39446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cGOdZ-0004hG-5O
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:19:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cGOdU-0000Sn-3y
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:19:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cGOdT-0000SX-R0
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:19:12 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 Dec 2016 12:18:53 +0100
Message-Id: <20161212111857.23399-8-pbonzini@redhat.com>
In-Reply-To: <20161212111857.23399-1-pbonzini@redhat.com>
References: <20161212111857.23399-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 07/11] virtio: use address_space_map/unmap to
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
Cc: stefanha@redhat.com, famz@redhat.com, mst@redhat.com, borntraeger@de.ibm.com

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/virtio/virtio.c | 78 +++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 60 insertions(+), 18 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 568f4be..459f9dd 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -119,10 +119,9 @@ void virtio_queue_update_rings(VirtIODevice *vdev, int n)
 }
 
 static void vring_desc_read(VirtIODevice *vdev, VRingDesc *desc,
-                            hwaddr desc_pa, int i)
+                            uint8_t *desc_ptr, int i)
 {
-    address_space_read(&address_space_memory, desc_pa + i * sizeof(VRingDesc),
-                       MEMTXATTRS_UNSPECIFIED, (void *)desc, sizeof(VRingDesc));
+    memcpy(desc, desc_ptr + i * sizeof(VRingDesc), sizeof(VRingDesc));
     virtio_tswap64s(vdev, &desc->addr);
     virtio_tswap32s(vdev, &desc->len);
     virtio_tswap16s(vdev, &desc->flags);
@@ -405,7 +404,7 @@ enum {
 };
 
 static int virtqueue_read_next_desc(VirtIODevice *vdev, VRingDesc *desc,
-                                    hwaddr desc_pa, unsigned int max,
+                                    void *desc_ptr, unsigned int max,
                                     unsigned int *next)
 {
     /* If this descriptor says it doesn't chain, we're done. */
@@ -423,7 +422,7 @@ static int virtqueue_read_next_desc(VirtIODevice *vdev, VRingDesc *desc,
         return VIRTQUEUE_READ_DESC_ERROR;
     }
 
-    vring_desc_read(vdev, desc, desc_pa, *next);
+    vring_desc_read(vdev, desc, desc_ptr, *next);
     return VIRTQUEUE_READ_DESC_MORE;
 }
 
@@ -433,6 +432,8 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
 {
     unsigned int idx;
     unsigned int total_bufs, in_total, out_total;
+    void *desc_ptr = NULL;
+    hwaddr len = 0;
     int rc;
 
     idx = vq->last_avail_idx;
@@ -442,7 +443,6 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
         VirtIODevice *vdev = vq->vdev;
         unsigned int max, num_bufs, indirect = 0;
         VRingDesc desc;
-        hwaddr desc_pa;
         unsigned int i;
 
         max = vq->vring.num;
@@ -452,10 +452,19 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
             goto err;
         }
 
-        desc_pa = vq->vring.desc;
-        vring_desc_read(vdev, &desc, desc_pa, i);
+        len = max * sizeof(VRingDesc);
+        desc_ptr = address_space_map(&address_space_memory, vq->vring.desc,
+                                     &len, false);
+        if (len < max * sizeof(VRingDesc)) {
+            virtio_error(vdev, "Cannot map descriptor ring");
+            goto err;
+        }
+
+        vring_desc_read(vdev, &desc, desc_ptr, i);
 
         if (desc.flags & VRING_DESC_F_INDIRECT) {
+            address_space_unmap(&address_space_memory, desc_ptr, len, false, 0);
+            len = desc.len;
             if (desc.len % sizeof(VRingDesc)) {
                 virtio_error(vdev, "Invalid size for indirect buffer table");
                 goto err;
@@ -468,11 +477,17 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
             }
 
             /* loop over the indirect descriptor table */
+            desc_ptr = address_space_map(&address_space_memory, desc.addr,
+                                         &len, false);
+            if (len < desc.len) {
+                virtio_error(vdev, "Cannot map indirect buffer");
+                goto err;
+            }
+
             indirect = 1;
             max = desc.len / sizeof(VRingDesc);
-            desc_pa = desc.addr;
             num_bufs = i = 0;
-            vring_desc_read(vdev, &desc, desc_pa, i);
+            vring_desc_read(vdev, &desc, desc_ptr, i);
         }
 
         do {
@@ -491,7 +506,7 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
                 goto done;
             }
 
-            rc = virtqueue_read_next_desc(vdev, &desc, desc_pa, max, &i);
+            rc = virtqueue_read_next_desc(vdev, &desc, desc_ptr, max, &i);
         } while (rc == VIRTQUEUE_READ_DESC_MORE);
 
         if (rc == VIRTQUEUE_READ_DESC_ERROR) {
@@ -509,6 +524,9 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
     }
 
 done:
+    if (desc_ptr) {
+        address_space_unmap(&address_space_memory, desc_ptr, len, false, 0);
+    }
     if (in_bytes) {
         *in_bytes = in_total;
     }
@@ -656,9 +674,10 @@ static void *virtqueue_alloc_element(size_t sz, unsigned out_num, unsigned in_nu
 void *virtqueue_pop(VirtQueue *vq, size_t sz)
 {
     unsigned int i, head, max;
-    hwaddr desc_pa = vq->vring.desc;
+    void *desc_ptr = NULL;
+    hwaddr len;
     VirtIODevice *vdev = vq->vdev;
-    VirtQueueElement *elem;
+    VirtQueueElement *elem = NULL;
     unsigned out_num, in_num;
     hwaddr addr[VIRTQUEUE_MAX_SIZE];
     struct iovec iov[VIRTQUEUE_MAX_SIZE];
@@ -694,18 +713,35 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     }
 
     i = head;
-    vring_desc_read(vdev, &desc, desc_pa, i);
+
+    len = max * sizeof(VRingDesc);
+    desc_ptr = address_space_map(&address_space_memory, vq->vring.desc, &len,
+                                 false);
+    if (len < max * sizeof(VRingDesc)) {
+        virtio_error(vdev, "Cannot map descriptor ring");
+        return NULL;
+    }
+
+    vring_desc_read(vdev, &desc, desc_ptr, i);
     if (desc.flags & VRING_DESC_F_INDIRECT) {
+        address_space_unmap(&address_space_memory, desc_ptr, len, false, 0);
         if (desc.len % sizeof(VRingDesc)) {
             virtio_error(vdev, "Invalid size for indirect buffer table");
             return NULL;
         }
 
         /* loop over the indirect descriptor table */
+        len = desc.len;
+        desc_ptr = address_space_map(&address_space_memory, desc.addr,
+                                     &len, false);
+        if (len < desc.len) {
+            virtio_error(vdev, "Cannot map indirect buffer");
+            return NULL;
+        }
+
         max = desc.len / sizeof(VRingDesc);
-        desc_pa = desc.addr;
         i = 0;
-        vring_desc_read(vdev, &desc, desc_pa, i);
+        vring_desc_read(vdev, &desc, desc_ptr, i);
     }
 
     /* Collect all the descriptors */
@@ -736,7 +772,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
             goto err_undo_map;
         }
 
-        rc = virtqueue_read_next_desc(vdev, &desc, desc_pa, max, &i);
+        rc = virtqueue_read_next_desc(vdev, &desc, desc_ptr, max, &i);
     } while (rc == VIRTQUEUE_READ_DESC_MORE);
 
     if (rc == VIRTQUEUE_READ_DESC_ERROR) {
@@ -758,11 +794,17 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     vq->inuse++;
 
     trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
+done:
+    if (desc_ptr) {
+        address_space_unmap(&address_space_memory, desc_ptr, len, false, 0);
+    }
+
     return elem;
 
 err_undo_map:
     virtqueue_undo_map_desc(out_num, in_num, iov);
-    return NULL;
+    elem = NULL;
+    goto done;
 }
 
 /* Reading and writing a structure directly to QEMUFile is *awful*, but
-- 
1.8.3.1
