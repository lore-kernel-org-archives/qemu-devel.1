Received: from eggs.gnu.org ([209.51.188.92]:47195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gjpzS-0003Yq-Gf
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:32:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gjpzN-0007p3-55
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:32:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gjpzH-0007hw-Ho
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:32:29 -0500
From: wexu@redhat.com
Date: Wed, 16 Jan 2019 13:31:13 -0500
Message-Id: <1547663480-547-9-git-send-email-wexu@redhat.com>
In-Reply-To: <1547663480-547-1-git-send-email-wexu@redhat.com>
References: <1547663480-547-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [PATCH v2 08/15] virtio: fill/flush/pop for packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wexu@redhat.com, tiwei.bie@intel.com, qemu-devel@nongnu.org
Cc: jasowang@redhat.com, mst@redhat.com, jfreiman@redhat.com, maxime.coquelin@redhat.com

From: Wei Xu <wexu@redhat.com>

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/virtio/virtio.c | 295 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 278 insertions(+), 17 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index cb599e9..5562ecd 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -383,6 +383,25 @@ static void vring_packed_desc_read(VirtIODevice *vdev, VRingPackedDesc *desc,
     virtio_tswap16s(vdev, &desc->id);
 }
 
+static void vring_packed_desc_write_data(VirtIODevice *vdev,
+                    VRingPackedDesc *desc, MemoryRegionCache *cache, int i)
+{
+    virtio_tswap32s(vdev, &desc->len);
+    virtio_tswap16s(vdev, &desc->id);
+    address_space_write_cached(cache,
+              i * sizeof(VRingPackedDesc) + offsetof(VRingPackedDesc, id),
+              &desc->id, sizeof(desc->id));
+    address_space_cache_invalidate(cache,
+              i * sizeof(VRingPackedDesc) + offsetof(VRingPackedDesc, id),
+              sizeof(desc->id));
+    address_space_write_cached(cache,
+              i * sizeof(VRingPackedDesc) + offsetof(VRingPackedDesc, len),
+              &desc->len, sizeof(desc->len));
+    address_space_cache_invalidate(cache,
+              i * sizeof(VRingPackedDesc) + offsetof(VRingPackedDesc, len),
+              sizeof(desc->len));
+}
+
 static void vring_packed_desc_read_flags(VirtIODevice *vdev,
                     VRingPackedDesc *desc, MemoryRegionCache *cache, int i)
 {
@@ -392,6 +411,18 @@ static void vring_packed_desc_read_flags(VirtIODevice *vdev,
     virtio_tswap16s(vdev, &desc->flags);
 }
 
+static void vring_packed_desc_write_flags(VirtIODevice *vdev,
+                    VRingPackedDesc *desc, MemoryRegionCache *cache, int i)
+{
+    virtio_tswap16s(vdev, &desc->flags);
+    address_space_write_cached(cache,
+              i * sizeof(VRingPackedDesc) + offsetof(VRingPackedDesc, flags),
+              &desc->flags, sizeof(desc->flags));
+    address_space_cache_invalidate(cache,
+              i * sizeof(VRingPackedDesc) + offsetof(VRingPackedDesc, flags),
+              sizeof(desc->flags));
+}
+
 static inline bool is_desc_avail(struct VRingPackedDesc *desc,
                                 bool wrap_counter)
 {
@@ -558,19 +589,11 @@ bool virtqueue_rewind(VirtQueue *vq, unsigned int num)
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
@@ -582,16 +605,72 @@ void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
     vring_used_write(vq, &uelem, idx);
 }
 
-/* Called within rcu_read_lock().  */
-void virtqueue_flush(VirtQueue *vq, unsigned int count)
+static void virtqueue_packed_fill(VirtQueue *vq, const VirtQueueElement *elem,
+                        unsigned int len, unsigned int idx)
 {
-    uint16_t old, new;
+    uint16_t head;
+    VRingMemoryRegionCaches *caches;
+    VRingPackedDesc desc = {
+        .flags = 0,
+    };
+    bool wrap_counter = vq->used_wrap_counter;
+
+    if (unlikely(!vq->vring.desc)) {
+        return;
+    }
+
+    caches = vring_get_region_caches(vq);
+    desc.id = elem->index;
+    desc.len = len;
+
+    head = vq->used_idx + idx;
+    if (head >= vq->vring.num) {
+        head -= vq->vring.num;
+        wrap_counter ^= 1;
+    }
+    if (wrap_counter) {
+        desc.flags |= VRING_DESC_F_AVAIL;
+        desc.flags |= VRING_DESC_F_USED;
+    } else {
+        desc.flags &= ~VRING_DESC_F_AVAIL;
+        desc.flags &= ~VRING_DESC_F_USED;
+    }
+
+    vring_packed_desc_write_data(vq->vdev, &desc, &caches->desc, head);
+    if (idx == 0) {
+        /*
+         * Make sure descriptor id and len is written before
+         * flags for the first used buffer.
+         */
+        smp_wmb();
+    }
+
+    vring_packed_desc_write_flags(vq->vdev, &desc, &caches->desc, head);
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
@@ -607,6 +686,31 @@ void virtqueue_flush(VirtQueue *vq, unsigned int count)
         vq->signalled_used_valid = false;
 }
 
+static void virtqueue_packed_flush(VirtQueue *vq, unsigned int count)
+{
+    if (unlikely(!vq->vring.desc)) {
+        return;
+    }
+
+    vq->inuse -= count;
+    vq->used_idx = vq->last_avail_idx;
+    vq->used_wrap_counter = vq->avail_wrap_counter;
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
@@ -1074,7 +1178,7 @@ static void *virtqueue_alloc_element(size_t sz, unsigned out_num, unsigned in_nu
     return elem;
 }
 
-void *virtqueue_pop(VirtQueue *vq, size_t sz)
+static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
 {
     unsigned int i, head, max;
     VRingMemoryRegionCaches *caches;
@@ -1089,9 +1193,6 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     VRingDesc desc;
     int rc;
 
-    if (unlikely(vdev->broken)) {
-        return NULL;
-    }
     rcu_read_lock();
     if (virtio_queue_empty_rcu(vq)) {
         goto done;
@@ -1209,6 +1310,166 @@ err_undo_map:
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
+    uint16_t id;
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
+
+    /*
+     * Empty check has been done at the beginning, so it is an available
+     * entry already, make sure all fields has been exposed by guest
+     */
+    smp_rmb();
+    vring_packed_desc_read(vdev, &desc, cache, i);
+
+    id = desc.id;
+    if (desc.flags & VRING_DESC_F_INDIRECT) {
+
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
+        if (cache == &indirect_desc_cache) {
+            if (i == max) {
+                break;
+            }
+            vring_packed_desc_read(vq->vdev, &desc, cache, i);
+        } else if (desc.flags & VRING_DESC_F_NEXT) {
+            vring_packed_desc_read(vq->vdev, &desc, cache, i);
+        } else {
+            break;
+        }
+    }
+
+    /* Now copy what we have collected and mapped */
+    elem = virtqueue_alloc_element(sz, out_num, in_num);
+    elem->index = id;
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
+                          1 : elem_entries;
+    if (vq->last_avail_idx >= vq->vring.num) {
+        vq->last_avail_idx -= vq->vring.num;
+        vq->avail_wrap_counter = !vq->avail_wrap_counter;
+    }
+    vq->inuse++;
+
+    vq->shadow_avail_idx = vq->last_avail_idx;
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
+    if (unlikely(vq->vdev->broken)) {
+        return NULL;
+    }
+
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
