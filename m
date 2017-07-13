Received: from eggs.gnu.org ([2001:4830:134:3::10]:40249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dVbtV-0005jQ-OJ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:02:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dVbtU-0001LM-4k
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:02:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dVbtT-0001KZ-S6
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:02:52 -0400
From: Ladi Prosek <lprosek@redhat.com>
Date: Thu, 13 Jul 2017 13:02:32 +0200
Message-Id: <20170713110237.6712-4-lprosek@redhat.com>
In-Reply-To: <20170713110237.6712-1-lprosek@redhat.com>
References: <20170713110237.6712-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/8] virtio: introduce virtqueue_error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: casasfernando@hotmail.com, mst@redhat.com, jasowang@redhat.com, armbru@redhat.com, groug@kaod.org, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com, stefanha@redhat.com

Most virtio error output pertains to a specific virtqueue so it makes
sense to include the queue index in error messages. This commit makes
all error output in virtio.c use the newly introduced virtqueue_error.

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Ladi Prosek <lprosek@redhat.com>
---
 hw/virtio/virtio.c         | 98 ++++++++++++++++++++++++++++------------------
 include/hw/virtio/virtio.h |  1 +
 2 files changed, 60 insertions(+), 39 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index a98f681..4a4e977 100644
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
@@ -2464,17 +2463,8 @@ static const char *virtio_get_device_id(VirtIODevice *vdev)
     return NULL;
 }
 
-void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
+static void virtio_device_set_broken(VirtIODevice *vdev)
 {
-    va_list ap;
-
-    error_report_nolf("%s (id=%s): ", vdev->name, virtio_get_device_id(vdev));
-
-    va_start(ap, fmt);
-    error_vprintf(fmt, ap);
-    va_end(ap);
-    error_printf("\n");
-
     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
         virtio_set_status(vdev, vdev->status | VIRTIO_CONFIG_S_NEEDS_RESET);
         virtio_notify_config(vdev);
@@ -2483,6 +2473,36 @@ void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
     vdev->broken = true;
 }
 
+void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
+{
+    va_list ap;
+
+    error_report_nolf("%s (id=%s): ", vdev->name, virtio_get_device_id(vdev));
+
+    va_start(ap, fmt);
+    error_vprintf(fmt, ap);
+    va_end(ap);
+    error_printf("\n");
+
+    virtio_device_set_broken(vdev);
+}
+
+void GCC_FMT_ATTR(2, 3) virtqueue_error(VirtQueue *vq, const char *fmt, ...)
+{
+    VirtIODevice *vdev = vq->vdev;
+    va_list ap;
+
+    error_report_nolf("%s (id=%s) queue %d: ", vdev->name,
+                      virtio_get_device_id(vdev), vq->queue_index);
+
+    va_start(ap, fmt);
+    error_vprintf(fmt, ap);
+    va_end(ap);
+    error_printf("\n");
+
+    virtio_device_set_broken(vdev);
+}
+
 static void virtio_memory_listener_commit(MemoryListener *listener)
 {
     VirtIODevice *vdev = container_of(listener, VirtIODevice, listener);
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 80c45c3..c6c56a0 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -151,6 +151,7 @@ void virtio_init(VirtIODevice *vdev, const char *name,
 void virtio_cleanup(VirtIODevice *vdev);
 
 void virtio_error(VirtIODevice *vdev, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
+void virtqueue_error(VirtQueue *vq, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
 
 /* Set the child bus name. */
 void virtio_device_set_child_bus_name(VirtIODevice *vdev, char *bus_name);
-- 
2.9.3
