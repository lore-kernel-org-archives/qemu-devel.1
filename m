Received: from eggs.gnu.org ([2001:4830:134:3::10]:39334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gAbeZ-0004wX-Am
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gAbeV-00064i-Be
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:09:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47181)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gAbeS-00061o-0l
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:09:21 -0400
From: wexu@redhat.com
Date: Thu, 11 Oct 2018 10:08:30 -0400
Message-Id: <1539266915-15216-8-git-send-email-wexu@redhat.com>
In-Reply-To: <1539266915-15216-1-git-send-email-wexu@redhat.com>
References: <1539266915-15216-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [[RFC v3 07/12] virtio: fill/flush/pop for packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, tiwei.bie@intel.com, wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com

From: Wei Xu <wexu@redhat.com>

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/virtio/virtio.c | 258 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 244 insertions(+), 14 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 13c6c98..d12a7e3 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -386,6 +386,21 @@ static void vring_packed_desc_read(VirtIODevice *vdev, VRingPackedDesc *desc,
     virtio_tswap16s(vdev, &desc->id);
 }
 
+static void vring_packed_desc_write(VirtIODevice *vdev, VRingPackedDesc *desc,
+                            MemoryRegionCache *cache, int i)
+{
+    virtio_tswap64s(vdev, &desc->addr);
+    virtio_tswap32s(vdev, &desc->len);
+    virtio_tswap16s(vdev, &desc->id);
+    virtio_tswap16s(vdev, &desc->flags);
+    address_space_write_cached(cache,
+                               sizeof(VRingPackedDesc) * i, desc,
+                               sizeof(VRingPackedDesc));
+    address_space_cache_invalidate(cache,
+                                   sizeof(VRingPackedDesc) * i,
+                                   sizeof(VRingPackedDesc));
+}
+
 static void vring_packed_desc_read_flags(VirtIODevice *vdev,
                     VRingPackedDesc *desc, MemoryRegionCache *cache, int i)
 {
@@ -559,19 +574,11 @@ bool virtqueue_rewind(VirtQueue *vq, unsigned int num)
 }
 
 /* Called within rcu_read_lock().  */
-void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
+static void virtqueue_split_fill(VirtQueue *vq, const VirtQueueElement *elem,
                     unsigned int len, unsigned int idx)
 {
     VRingUsedElem uelem;
 
-    trace_virtqueue_fill(vq, elem, len, idx);
-
-    virtqueue_unmap_sg(vq, elem, len);
-
-    if (unlikely(vq->vdev->broken)) {
-        return;
-    }
-
     if (unlikely(!vq->vring.used)) {
         return;
     }
@@ -583,16 +590,64 @@ void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
     vring_used_write(vq, &uelem, idx);
 }
 
-/* Called within rcu_read_lock().  */
-void virtqueue_flush(VirtQueue *vq, unsigned int count)
+static void virtqueue_packed_fill(VirtQueue *vq, const VirtQueueElement *elem,
+                        unsigned int len, unsigned int idx)
 {
-    uint16_t old, new;
+    uint16_t w, head;
+    VRingMemoryRegionCaches *caches;
+    VRingPackedDesc desc = {
+        .addr = 0,
+        .flags = 0,
+    };
+
+    if (unlikely(!vq->vring.desc)) {
+        return;
+    }
+
+    caches = vring_get_region_caches(vq);
+    head = vq->used_idx + idx;
+    head = head >= vq->vring.num ? (head - vq->vring.num) : head;
+    vring_packed_desc_read(vq->vdev, &desc, &caches->desc, head);
+
+    w = (desc.flags & AVAIL_DESC_PACKED(1)) >> 7;
+    desc.flags &= ~(AVAIL_DESC_PACKED(1) | USED_DESC_PACKED(1));
+    desc.flags |= AVAIL_DESC_PACKED(w) | USED_DESC_PACKED(w);
+    if (!(desc.flags & VRING_DESC_F_INDIRECT)) {
+        if (!(desc.flags & VRING_DESC_F_WRITE)) {
+            desc.len = 0;
+        } else {
+            desc.len = len;
+        }
+    }
+    vring_packed_desc_write(vq->vdev, &desc, &caches->desc, head);
+
+    /* Make sure flags has been updated */
+    smp_mb();
+}
+
+void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
+                    unsigned int len, unsigned int idx)
+{
+    trace_virtqueue_fill(vq, elem, len, idx);
+
+    virtqueue_unmap_sg(vq, elem, len);
 
     if (unlikely(vq->vdev->broken)) {
-        vq->inuse -= count;
         return;
     }
 
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+        virtqueue_packed_fill(vq, elem, len, idx);
+    } else {
+        virtqueue_split_fill(vq, elem, len, idx);
+    }
+}
+
+/* Called within rcu_read_lock().  */
+static void virtqueue_split_flush(VirtQueue *vq, unsigned int count)
+{
+    uint16_t old, new;
+
     if (unlikely(!vq->vring.used)) {
         return;
     }
@@ -608,6 +663,33 @@ void virtqueue_flush(VirtQueue *vq, unsigned int count)
         vq->signalled_used_valid = false;
 }
 
+static void virtqueue_packed_flush(VirtQueue *vq, unsigned int count)
+{
+    if (unlikely(!vq->vring.desc)) {
+        return;
+    }
+
+    vq->inuse -= count;
+    vq->used_idx += count;
+    if (vq->used_idx >= vq->vring.num) {
+        vq->used_idx -= vq->vring.num;
+    }
+}
+
+void virtqueue_flush(VirtQueue *vq, unsigned int count)
+{
+    if (unlikely(vq->vdev->broken)) {
+        vq->inuse -= count;
+        return;
+    }
+
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+        virtqueue_packed_flush(vq, count);
+    } else {
+        virtqueue_split_flush(vq, count);
+    }
+}
+
 void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
                     unsigned int len)
 {
@@ -1091,7 +1173,7 @@ static void *virtqueue_alloc_element(size_t sz, unsigned out_num, unsigned in_nu
     return elem;
 }
 
-void *virtqueue_pop(VirtQueue *vq, size_t sz)
+static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
 {
     unsigned int i, head, max;
     VRingMemoryRegionCaches *caches;
@@ -1226,6 +1308,154 @@ err_undo_map:
     goto done;
 }
 
+static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
+{
+    unsigned int i, head, max;
+    VRingMemoryRegionCaches *caches;
+    MemoryRegionCache indirect_desc_cache = MEMORY_REGION_CACHE_INVALID;
+    MemoryRegionCache *cache;
+    int64_t len;
+    VirtIODevice *vdev = vq->vdev;
+    VirtQueueElement *elem = NULL;
+    unsigned out_num, in_num, elem_entries;
+    hwaddr addr[VIRTQUEUE_MAX_SIZE];
+    struct iovec iov[VIRTQUEUE_MAX_SIZE];
+    VRingPackedDesc desc;
+
+    if (unlikely(vdev->broken)) {
+        return NULL;
+    }
+
+    rcu_read_lock();
+    if (virtio_queue_packed_empty_rcu(vq)) {
+        goto done;
+    }
+
+    /* When we start there are none of either input nor output. */
+    out_num = in_num = elem_entries = 0;
+
+    max = vq->vring.num;
+
+    if (vq->inuse >= vq->vring.num) {
+        virtio_error(vdev, "Virtqueue size exceeded");
+        goto done;
+    }
+
+    head = vq->last_avail_idx;
+    i = head;
+
+    caches = vring_get_region_caches(vq);
+    cache = &caches->desc;
+    vring_packed_desc_read(vdev, &desc, cache, i);
+    /* Make sure we see all the fields*/
+    smp_rmb();
+    if (desc.flags & VRING_DESC_F_INDIRECT) {
+        if (desc.len % sizeof(VRingPackedDesc)) {
+            virtio_error(vdev, "Invalid size for indirect buffer table");
+            goto done;
+        }
+
+        /* loop over the indirect descriptor table */
+        len = address_space_cache_init(&indirect_desc_cache, vdev->dma_as,
+                                       desc.addr, desc.len, false);
+        cache = &indirect_desc_cache;
+        if (len < desc.len) {
+            virtio_error(vdev, "Cannot map indirect buffer");
+            goto done;
+        }
+
+        max = desc.len / sizeof(VRingPackedDesc);
+        i = 0;
+        vring_packed_desc_read(vdev, &desc, cache, i);
+        /* Make sure we see all the fields*/
+        smp_rmb();
+    }
+
+    /* Collect all the descriptors */
+    while (1) {
+        bool map_ok;
+
+        if (desc.flags & VRING_DESC_F_WRITE) {
+            map_ok = virtqueue_map_desc(vdev, &in_num, addr + out_num,
+                                        iov + out_num,
+                                        VIRTQUEUE_MAX_SIZE - out_num, true,
+                                        desc.addr, desc.len);
+        } else {
+            if (in_num) {
+                virtio_error(vdev, "Incorrect order for descriptors");
+                goto err_undo_map;
+            }
+            map_ok = virtqueue_map_desc(vdev, &out_num, addr, iov,
+                                        VIRTQUEUE_MAX_SIZE, false,
+                                        desc.addr, desc.len);
+        }
+        if (!map_ok) {
+            goto err_undo_map;
+        }
+
+        /* If we've got too many, that implies a descriptor loop. */
+        if (++elem_entries > max) {
+            virtio_error(vdev, "Looped descriptor");
+            goto err_undo_map;
+        }
+
+        if (++i >= vq->vring.num) {
+            i -= vq->vring.num;
+        }
+
+        if (desc.flags & VRING_DESC_F_NEXT) {
+            vring_packed_desc_read(vq->vdev, &desc, cache, i);
+            /* Make sure we see all the fields*/
+            smp_rmb();
+        } else {
+            break;
+        }
+    }
+
+    /* Now copy what we have collected and mapped */
+    elem = virtqueue_alloc_element(sz, out_num, in_num);
+    for (i = 0; i < out_num; i++) {
+        elem->out_addr[i] = addr[i];
+        elem->out_sg[i] = iov[i];
+    }
+    for (i = 0; i < in_num; i++) {
+        elem->in_addr[i] = addr[head + out_num + i];
+        elem->in_sg[i] = iov[out_num + i];
+    }
+
+    vq->last_avail_idx += (cache == &indirect_desc_cache) ?
+                          1 : out_num + in_num;
+    if (vq->last_avail_idx >= vq->vring.num) {
+        vq->last_avail_idx -= vq->vring.num;
+        vq->avail_wrap_counter = !vq->avail_wrap_counter;
+    }
+    vq->inuse++;
+
+    vq->event_idx = vq->last_avail_idx;
+    vq->event_wrap_counter = vq->avail_wrap_counter;
+
+    trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
+done:
+    address_space_cache_destroy(&indirect_desc_cache);
+    rcu_read_unlock();
+
+    return elem;
+
+err_undo_map:
+    virtqueue_undo_map_desc(out_num, in_num, iov);
+    g_free(elem);
+    goto done;
+}
+
+void *virtqueue_pop(VirtQueue *vq, size_t sz)
+{
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+        return virtqueue_packed_pop(vq, sz);
+    } else {
+        return virtqueue_split_pop(vq, sz);
+    }
+}
+
 /* virtqueue_drop_all:
  * @vq: The #VirtQueue
  * Drops all queued buffers and indicates them to the guest
-- 
1.8.3.1
