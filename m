Received: from eggs.gnu.org ([2001:4830:134:3::10]:48512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dVCek-0006Fs-M5
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dVCeh-0006We-Eg
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:05:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dVCeh-0006W7-4s
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:05:55 -0400
From: Ladi Prosek <lprosek@redhat.com>
Date: Wed, 12 Jul 2017 10:05:38 +0200
Message-Id: <20170712080538.28010-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH] virtio: enhance virtio_error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, stefanha@redhat.com, casasfernando@hotmail.com

Output like "Virtqueue size exceeded" is not much useful in identifying the
culprit. This commit adds virtio device name and queue index to all error
messages in virtio.c to improve debuggability.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
---
 hw/virtio/virtio.c | 74 +++++++++++++++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 28 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 464947f..5040f26 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -143,7 +143,7 @@ static void virtio_init_region_cache(VirtIODevice *vdev, int n)
     len = address_space_cache_init(&new->desc, vdev->dma_as,
                                    addr, size, false);
     if (len < size) {
-        virtio_error(vdev, "Cannot map desc");
+        virtio_error(vdev, "%s queue %u: Cannot map desc", vdev->name, n);
         goto err_desc;
     }
 
@@ -151,7 +151,7 @@ static void virtio_init_region_cache(VirtIODevice *vdev, int n)
     len = address_space_cache_init(&new->used, vdev->dma_as,
                                    vq->vring.used, size, true);
     if (len < size) {
-        virtio_error(vdev, "Cannot map used");
+        virtio_error(vdev, "%s queue %u: Cannot map used", vdev->name, n);
         goto err_used;
     }
 
@@ -159,7 +159,7 @@ static void virtio_init_region_cache(VirtIODevice *vdev, int n)
     len = address_space_cache_init(&new->avail, vdev->dma_as,
                                    vq->vring.avail, size, false);
     if (len < size) {
-        virtio_error(vdev, "Cannot map avail");
+        virtio_error(vdev, "%s queue %u: Cannot map avail", vdev->name, n);
         goto err_avail;
     }
 
@@ -517,8 +517,8 @@ static int virtqueue_num_heads(VirtQueue *vq, unsigned int idx)
 
     /* Check it isn't doing very strange things with descriptor numbers. */
     if (num_heads > vq->vring.num) {
-        virtio_error(vq->vdev, "Guest moved used index from %u to %u",
-                     idx, vq->shadow_avail_idx);
+        virtio_error(vq->vdev, "%s queue %u: Guest moved used index from %u to %u",
+                     vq->vdev->name, vq->queue_index, idx, vq->shadow_avail_idx);
         return -EINVAL;
     }
     /* On success, callers read a descriptor at vq->last_avail_idx.
@@ -540,7 +540,8 @@ static bool virtqueue_get_head(VirtQueue *vq, unsigned int idx,
 
     /* If their number is silly, that's a fatal mistake. */
     if (*head >= vq->vring.num) {
-        virtio_error(vq->vdev, "Guest says index %u is available", *head);
+        virtio_error(vq->vdev, "%s queue %u: Guest says index %u is available",
+                     vq->vdev->name, vq->queue_index, *head);
         return false;
     }
 
@@ -553,10 +554,12 @@ enum {
     VIRTQUEUE_READ_DESC_MORE = 1,   /* more buffers in chain */
 };
 
-static int virtqueue_read_next_desc(VirtIODevice *vdev, VRingDesc *desc,
+static int virtqueue_read_next_desc(VirtQueue *vq, VRingDesc *desc,
                                     MemoryRegionCache *desc_cache, unsigned int max,
                                     unsigned int *next)
 {
+    VirtIODevice *vdev = vq->vdev;
+
     /* If this descriptor says it doesn't chain, we're done. */
     if (!(desc->flags & VRING_DESC_F_NEXT)) {
         return VIRTQUEUE_READ_DESC_DONE;
@@ -568,7 +571,8 @@ static int virtqueue_read_next_desc(VirtIODevice *vdev, VRingDesc *desc,
     smp_wmb();
 
     if (*next >= max) {
-        virtio_error(vdev, "Desc next is %u", *next);
+        virtio_error(vdev, "%s queue %u: Desc next is %u",
+                     vdev->name, vq->queue_index, *next);
         return VIRTQUEUE_READ_DESC_ERROR;
     }
 
@@ -605,7 +609,8 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
     max = vq->vring.num;
     caches = vring_get_region_caches(vq);
     if (caches->desc.len < max * sizeof(VRingDesc)) {
-        virtio_error(vdev, "Cannot map descriptor ring");
+        virtio_error(vdev, "%s queue %u: Cannot map descriptor ring",
+                     vdev->name, vq->queue_index);
         goto err;
     }
 
@@ -625,13 +630,15 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
 
         if (desc.flags & VRING_DESC_F_INDIRECT) {
             if (desc.len % sizeof(VRingDesc)) {
-                virtio_error(vdev, "Invalid size for indirect buffer table");
+                virtio_error(vdev, "%s queue %u: Invalid size for indirect "
+                             "buffer table", vdev->name, vq->queue_index);
                 goto err;
             }
 
             /* If we've got too many, that implies a descriptor loop. */
             if (num_bufs >= max) {
-                virtio_error(vdev, "Looped descriptor");
+                virtio_error(vdev, "%s queue %u: Looped descriptor",
+                             vdev->name, vq->queue_index);
                 goto err;
             }
 
@@ -641,7 +648,8 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
                                            desc.addr, desc.len, false);
             desc_cache = &indirect_desc_cache;
             if (len < desc.len) {
-                virtio_error(vdev, "Cannot map indirect buffer");
+                virtio_error(vdev, "%s queue %u: Cannot map indirect buffer",
+                             vdev->name, vq->queue_index);
                 goto err;
             }
 
@@ -653,7 +661,8 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
         do {
             /* If we've got too many, that implies a descriptor loop. */
             if (++num_bufs > max) {
-                virtio_error(vdev, "Looped descriptor");
+                virtio_error(vdev, "%s queue %u: Looped descriptor",
+                             vdev->name, vq->queue_index);
                 goto err;
             }
 
@@ -666,7 +675,7 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
                 goto done;
             }
 
-            rc = virtqueue_read_next_desc(vdev, &desc, desc_cache, max, &i);
+            rc = virtqueue_read_next_desc(vq, &desc, desc_cache, max, &i);
         } while (rc == VIRTQUEUE_READ_DESC_MORE);
 
         if (rc == VIRTQUEUE_READ_DESC_ERROR) {
@@ -710,17 +719,19 @@ int virtqueue_avail_bytes(VirtQueue *vq, unsigned int in_bytes,
     return in_bytes <= in_total && out_bytes <= out_total;
 }
 
-static bool virtqueue_map_desc(VirtIODevice *vdev, unsigned int *p_num_sg,
+static bool virtqueue_map_desc(VirtQueue *vq, unsigned int *p_num_sg,
                                hwaddr *addr, struct iovec *iov,
                                unsigned int max_num_sg, bool is_write,
                                hwaddr pa, size_t sz)
 {
+    VirtIODevice *vdev = vq->vdev;
     bool ok = false;
     unsigned num_sg = *p_num_sg;
     assert(num_sg <= max_num_sg);
 
     if (!sz) {
-        virtio_error(vdev, "virtio: zero sized buffers are not allowed");
+        virtio_error(vdev, "%s queue %u: Zero sized buffers are not allowed",
+                     vdev->name, vq->queue_index);
         goto out;
     }
 
@@ -728,8 +739,8 @@ static bool virtqueue_map_desc(VirtIODevice *vdev, unsigned int *p_num_sg,
         hwaddr len = sz;
 
         if (num_sg == max_num_sg) {
-            virtio_error(vdev, "virtio: too many write descriptors in "
-                               "indirect table");
+            virtio_error(vdev, "%s queue %u: Too many write descriptors in "
+                               "indirect table", vdev->name, vq->queue_index);
             goto out;
         }
 
@@ -738,7 +749,8 @@ static bool virtqueue_map_desc(VirtIODevice *vdev, unsigned int *p_num_sg,
                                               DMA_DIRECTION_FROM_DEVICE :
                                               DMA_DIRECTION_TO_DEVICE);
         if (!iov[num_sg].iov_base) {
-            virtio_error(vdev, "virtio: bogus descriptor or out of resources");
+            virtio_error(vdev, "%s queue %u: Bogus descriptor or out of resources",
+                         vdev->name, vq->queue_index);
             goto out;
         }
 
@@ -857,7 +869,8 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     max = vq->vring.num;
 
     if (vq->inuse >= vq->vring.num) {
-        virtio_error(vdev, "Virtqueue size exceeded");
+        virtio_error(vdev, "%s queue %u: Virtqueue size exceeded",
+                     vdev->name, vq->queue_index);
         goto done;
     }
 
@@ -873,7 +886,8 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
 
     caches = vring_get_region_caches(vq);
     if (caches->desc.len < max * sizeof(VRingDesc)) {
-        virtio_error(vdev, "Cannot map descriptor ring");
+        virtio_error(vdev, "%s queue %u: Cannot map descriptor ring",
+                     vdev->name, vq->queue_index);
         goto done;
     }
 
@@ -881,7 +895,8 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     vring_desc_read(vdev, &desc, desc_cache, i);
     if (desc.flags & VRING_DESC_F_INDIRECT) {
         if (desc.len % sizeof(VRingDesc)) {
-            virtio_error(vdev, "Invalid size for indirect buffer table");
+            virtio_error(vdev, "%s queue %u: Invalid size for indirect "
+                         "buffer table", vdev->name, vq->queue_index);
             goto done;
         }
 
@@ -890,7 +905,8 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
                                        desc.addr, desc.len, false);
         desc_cache = &indirect_desc_cache;
         if (len < desc.len) {
-            virtio_error(vdev, "Cannot map indirect buffer");
+            virtio_error(vdev, "%s queue %u: Cannot map indirect buffer",
+                         vdev->name, vq->queue_index);
             goto done;
         }
 
@@ -904,16 +920,17 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
         bool map_ok;
 
         if (desc.flags & VRING_DESC_F_WRITE) {
-            map_ok = virtqueue_map_desc(vdev, &in_num, addr + out_num,
+            map_ok = virtqueue_map_desc(vq, &in_num, addr + out_num,
                                         iov + out_num,
                                         VIRTQUEUE_MAX_SIZE - out_num, true,
                                         desc.addr, desc.len);
         } else {
             if (in_num) {
-                virtio_error(vdev, "Incorrect order for descriptors");
+                virtio_error(vdev, "%s queue %u: Incorrect order for descriptors",
+                             vdev->name, vq->queue_index);
                 goto err_undo_map;
             }
-            map_ok = virtqueue_map_desc(vdev, &out_num, addr, iov,
+            map_ok = virtqueue_map_desc(vq, &out_num, addr, iov,
                                         VIRTQUEUE_MAX_SIZE, false,
                                         desc.addr, desc.len);
         }
@@ -923,11 +940,12 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
 
         /* If we've got too many, that implies a descriptor loop. */
         if ((in_num + out_num) > max) {
-            virtio_error(vdev, "Looped descriptor");
+            virtio_error(vdev, "%s queue %u: Looped descriptor",
+                         vdev->name, vq->queue_index);
             goto err_undo_map;
         }
 
-        rc = virtqueue_read_next_desc(vdev, &desc, desc_cache, max, &i);
+        rc = virtqueue_read_next_desc(vq, &desc, desc_cache, max, &i);
     } while (rc == VIRTQUEUE_READ_DESC_MORE);
 
     if (rc == VIRTQUEUE_READ_DESC_ERROR) {
-- 
2.9.3
