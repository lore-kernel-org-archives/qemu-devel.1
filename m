Received: from eggs.gnu.org ([2001:4830:134:3::10]:56711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dX18S-0005N3-1u
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:12:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dX18Q-0001Kr-C0
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:12:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dX18Q-0001Ka-2t
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:12:06 -0400
From: Ladi Prosek <lprosek@redhat.com>
Date: Mon, 17 Jul 2017 10:11:46 +0200
Message-Id: <20170717081152.17153-4-lprosek@redhat.com>
In-Reply-To: <20170717081152.17153-1-lprosek@redhat.com>
References: <20170717081152.17153-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/9] virtio: use virtqueue_error for errors
 with queue context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: casasfernando@hotmail.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, armbru@redhat.com, groug@kaod.org, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com

virtqueue_error includes the queue index in the error output and is preferred
for errors that pertain to a virtqueue rather than to the device as a whole.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/virtio/virtio.c | 57 +++++++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 935a5e3..de4dd32 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -148,7 +148,7 @@ static void virtio_init_region_cache(VirtIODevice *vdev, int n)
     len = address_space_cache_init(&new->desc, vdev->dma_as,
                                    addr, size, false);
     if (len < size) {
-        virtio_error(vdev, "Cannot map desc");
+        virtqueue_error(vq, "Cannot map desc");
         goto err_desc;
     }
 
@@ -156,7 +156,7 @@ static void virtio_init_region_cache(VirtIODevice *vdev, int n)
     len = address_space_cache_init(&new->used, vdev->dma_as,
                                    vq->vring.used, size, true);
     if (len < size) {
-        virtio_error(vdev, "Cannot map used");
+        virtqueue_error(vq, "Cannot map used");
         goto err_used;
     }
 
@@ -164,7 +164,7 @@ static void virtio_init_region_cache(VirtIODevice *vdev, int n)
     len = address_space_cache_init(&new->avail, vdev->dma_as,
                                    vq->vring.avail, size, false);
     if (len < size) {
-        virtio_error(vdev, "Cannot map avail");
+        virtqueue_error(vq, "Cannot map avail");
         goto err_avail;
     }
 
@@ -522,7 +522,7 @@ static int virtqueue_num_heads(VirtQueue *vq, unsigned int idx)
 
     /* Check it isn't doing very strange things with descriptor numbers. */
     if (num_heads > vq->vring.num) {
-        virtio_error(vq->vdev, "Guest moved used index from %u to %u",
+        virtqueue_error(vq, "Guest moved used index from %u to %u",
                      idx, vq->shadow_avail_idx);
         return -EINVAL;
     }
@@ -545,7 +545,7 @@ static bool virtqueue_get_head(VirtQueue *vq, unsigned int idx,
 
     /* If their number is silly, that's a fatal mistake. */
     if (*head >= vq->vring.num) {
-        virtio_error(vq->vdev, "Guest says index %u is available", *head);
+        virtqueue_error(vq, "Guest says index %u is available", *head);
         return false;
     }
 
@@ -558,7 +558,7 @@ enum {
     VIRTQUEUE_READ_DESC_MORE = 1,   /* more buffers in chain */
 };
 
-static int virtqueue_read_next_desc(VirtIODevice *vdev, VRingDesc *desc,
+static int virtqueue_read_next_desc(VirtQueue *vq, VRingDesc *desc,
                                     MemoryRegionCache *desc_cache, unsigned int max,
                                     unsigned int *next)
 {
@@ -573,11 +573,11 @@ static int virtqueue_read_next_desc(VirtIODevice *vdev, VRingDesc *desc,
     smp_wmb();
 
     if (*next >= max) {
-        virtio_error(vdev, "Desc next is %u", *next);
+        virtqueue_error(vq, "Desc next is %u", *next);
         return VIRTQUEUE_READ_DESC_ERROR;
     }
 
-    vring_desc_read(vdev, desc, desc_cache, *next);
+    vring_desc_read(vq->vdev, desc, desc_cache, *next);
     return VIRTQUEUE_READ_DESC_MORE;
 }
 
@@ -610,7 +610,7 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
     max = vq->vring.num;
     caches = vring_get_region_caches(vq);
     if (caches->desc.len < max * sizeof(VRingDesc)) {
-        virtio_error(vdev, "Cannot map descriptor ring");
+        virtqueue_error(vq, "Cannot map descriptor ring");
         goto err;
     }
 
@@ -630,13 +630,13 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
 
         if (desc.flags & VRING_DESC_F_INDIRECT) {
             if (desc.len % sizeof(VRingDesc)) {
-                virtio_error(vdev, "Invalid size for indirect buffer table");
+                virtqueue_error(vq, "Invalid size for indirect buffer table");
                 goto err;
             }
 
             /* If we've got too many, that implies a descriptor loop. */
             if (num_bufs >= max) {
-                virtio_error(vdev, "Looped descriptor");
+                virtqueue_error(vq, "Looped descriptor");
                 goto err;
             }
 
@@ -646,7 +646,7 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
                                            desc.addr, desc.len, false);
             desc_cache = &indirect_desc_cache;
             if (len < desc.len) {
-                virtio_error(vdev, "Cannot map indirect buffer");
+                virtqueue_error(vq, "Cannot map indirect buffer");
                 goto err;
             }
 
@@ -658,7 +658,7 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
         do {
             /* If we've got too many, that implies a descriptor loop. */
             if (++num_bufs > max) {
-                virtio_error(vdev, "Looped descriptor");
+                virtqueue_error(vq, "Looped descriptor");
                 goto err;
             }
 
@@ -671,7 +671,7 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
                 goto done;
             }
 
-            rc = virtqueue_read_next_desc(vdev, &desc, desc_cache, max, &i);
+            rc = virtqueue_read_next_desc(vq, &desc, desc_cache, max, &i);
         } while (rc == VIRTQUEUE_READ_DESC_MORE);
 
         if (rc == VIRTQUEUE_READ_DESC_ERROR) {
@@ -715,7 +715,7 @@ int virtqueue_avail_bytes(VirtQueue *vq, unsigned int in_bytes,
     return in_bytes <= in_total && out_bytes <= out_total;
 }
 
-static bool virtqueue_map_desc(VirtIODevice *vdev, unsigned int *p_num_sg,
+static bool virtqueue_map_desc(VirtQueue *vq, unsigned int *p_num_sg,
                                hwaddr *addr, struct iovec *iov,
                                unsigned int max_num_sg, bool is_write,
                                hwaddr pa, size_t sz)
@@ -725,7 +725,7 @@ static bool virtqueue_map_desc(VirtIODevice *vdev, unsigned int *p_num_sg,
     assert(num_sg <= max_num_sg);
 
     if (!sz) {
-        virtio_error(vdev, "virtio: zero sized buffers are not allowed");
+        virtqueue_error(vq, "Zero sized buffers are not allowed");
         goto out;
     }
 
@@ -733,17 +733,16 @@ static bool virtqueue_map_desc(VirtIODevice *vdev, unsigned int *p_num_sg,
         hwaddr len = sz;
 
         if (num_sg == max_num_sg) {
-            virtio_error(vdev, "virtio: too many write descriptors in "
-                               "indirect table");
+            virtqueue_error(vq, "Too many write descriptors in indirect table");
             goto out;
         }
 
-        iov[num_sg].iov_base = dma_memory_map(vdev->dma_as, pa, &len,
+        iov[num_sg].iov_base = dma_memory_map(vq->vdev->dma_as, pa, &len,
                                               is_write ?
                                               DMA_DIRECTION_FROM_DEVICE :
                                               DMA_DIRECTION_TO_DEVICE);
         if (!iov[num_sg].iov_base) {
-            virtio_error(vdev, "virtio: bogus descriptor or out of resources");
+            virtqueue_error(vq, "Bogus descriptor or out of resources");
             goto out;
         }
 
@@ -862,7 +861,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     max = vq->vring.num;
 
     if (vq->inuse >= vq->vring.num) {
-        virtio_error(vdev, "Virtqueue size exceeded");
+        virtqueue_error(vq, "Virtqueue size exceeded");
         goto done;
     }
 
@@ -878,7 +877,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
 
     caches = vring_get_region_caches(vq);
     if (caches->desc.len < max * sizeof(VRingDesc)) {
-        virtio_error(vdev, "Cannot map descriptor ring");
+        virtqueue_error(vq, "Cannot map descriptor ring");
         goto done;
     }
 
@@ -886,7 +885,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     vring_desc_read(vdev, &desc, desc_cache, i);
     if (desc.flags & VRING_DESC_F_INDIRECT) {
         if (desc.len % sizeof(VRingDesc)) {
-            virtio_error(vdev, "Invalid size for indirect buffer table");
+            virtqueue_error(vq, "Invalid size for indirect buffer table");
             goto done;
         }
 
@@ -895,7 +894,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
                                        desc.addr, desc.len, false);
         desc_cache = &indirect_desc_cache;
         if (len < desc.len) {
-            virtio_error(vdev, "Cannot map indirect buffer");
+            virtqueue_error(vq, "Cannot map indirect buffer");
             goto done;
         }
 
@@ -909,16 +908,16 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
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
+                virtqueue_error(vq, "Incorrect order for descriptors");
                 goto err_undo_map;
             }
-            map_ok = virtqueue_map_desc(vdev, &out_num, addr, iov,
+            map_ok = virtqueue_map_desc(vq, &out_num, addr, iov,
                                         VIRTQUEUE_MAX_SIZE, false,
                                         desc.addr, desc.len);
         }
@@ -928,11 +927,11 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
 
         /* If we've got too many, that implies a descriptor loop. */
         if ((in_num + out_num) > max) {
-            virtio_error(vdev, "Looped descriptor");
+            virtqueue_error(vq, "Looped descriptor");
             goto err_undo_map;
         }
 
-        rc = virtqueue_read_next_desc(vdev, &desc, desc_cache, max, &i);
+        rc = virtqueue_read_next_desc(vq, &desc, desc_cache, max, &i);
     } while (rc == VIRTQUEUE_READ_DESC_MORE);
 
     if (rc == VIRTQUEUE_READ_DESC_ERROR) {
-- 
2.9.3
