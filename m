Received: from eggs.gnu.org ([2001:4830:134:3::10]:54461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1f3hxJ-0001NK-Ln
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1f3hxH-0005oJ-9R
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:56:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41096 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1f3hxG-0005mt-PM
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:55:59 -0400
From: wexu@redhat.com
Date: Wed,  4 Apr 2018 20:54:04 +0800
Message-Id: <1522846444-31725-9-git-send-email-wexu@redhat.com>
In-Reply-To: <1522846444-31725-1-git-send-email-wexu@redhat.com>
References: <1522846444-31725-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [PATCH 8/8] virtio: queue pop support for packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wexu@redhat.com, jasowang@redhat.com, mst@redhat.com, tiwei.bie@intel.com, jfreimann@redhat.com, qemu-devel@nongnu.org

From: Wei Xu <wexu@redhat.com>

cloned from split ring pop, a global static length array
and the inside-element length array are introduced to
easy prototype, this consumes more memory and it is valuable
to move to dynamic allocation as the out/in sg does.

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/virtio/virtio.c | 154 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 153 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index cf726f3..0eafb38 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1221,7 +1221,7 @@ static void *virtqueue_alloc_element(size_t sz, unsigned out_num, unsigned in_nu
     return elem;
 }
 
-void *virtqueue_pop(VirtQueue *vq, size_t sz)
+static void *virtqueue_pop_split(VirtQueue *vq, size_t sz)
 {
     unsigned int i, head, max;
     VRingMemoryRegionCaches *caches;
@@ -1356,6 +1356,158 @@ err_undo_map:
     goto done;
 }
 
+static uint16_t dma_len[VIRTQUEUE_MAX_SIZE];
+static void *virtqueue_pop_packed(VirtQueue *vq, size_t sz)
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
+    VRingDescPacked desc;
+    uint8_t wrap_counter;
+
+    if (unlikely(vdev->broken)) {
+        return NULL;
+    }
+
+    vq->last_avail_idx %= vq->packed.num;
+
+    rcu_read_lock();
+    if (virtio_queue_empty_packed_rcu(vq)) {
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
+    if (virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
+        /* FIXME: TBD */
+    }
+
+    head = vq->last_avail_idx;
+    i = head;
+
+    caches = vring_get_region_caches(vq);
+    cache = &caches->desc_packed;
+    vring_desc_read_packed(vdev, &desc, cache, i);
+    if (desc.flags & VRING_DESC_F_INDIRECT) {
+        if (desc.len % sizeof(VRingDescPacked)) {
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
+        max = desc.len / sizeof(VRingDescPacked);
+        i = 0;
+        vring_desc_read_packed(vdev, &desc, cache, i);
+    }
+
+    wrap_counter = vq->wrap_counter;
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
+        dma_len[i++] = desc.len;
+        /* Toggle wrap_counter for non indirect desc */
+        if ((i == vq->packed.num) && (cache != &indirect_desc_cache)) {
+            vq->wrap_counter ^= 1;
+        }
+
+        if (desc.flags & VRING_DESC_F_NEXT) {
+            vring_desc_read_packed(vq->vdev, &desc, cache, i % vq->packed.num);
+        } else {
+            break;
+        }
+    }
+
+    /* Now copy what we have collected and mapped */
+    elem = virtqueue_alloc_element(sz, out_num, in_num);
+    elem->index = head;
+    elem->wrap_counter = wrap_counter;
+    elem->count = (cache == &indirect_desc_cache) ? 1 : out_num + in_num;
+    for (i = 0; i < out_num; i++) {
+        /* DMA Done by marking the length as 0 */
+        elem->len[i] = 0;
+        elem->out_addr[i] = addr[i];
+        elem->out_sg[i] = iov[i];
+    }
+    for (i = 0; i < in_num; i++) {
+        elem->len[out_num + i] = dma_len[head + out_num + i];
+        elem->in_addr[i] = addr[out_num + i];
+        elem->in_sg[i] = iov[out_num + i];
+    }
+
+    vq->last_avail_idx += elem->count;
+    vq->last_avail_idx %= vq->packed.num;
+    vq->inuse += elem->count;
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
+        return virtqueue_pop_packed(vq, sz);
+    } else {
+        return virtqueue_pop_split(vq, sz);
+    }
+}
+
 /* virtqueue_drop_all:
  * @vq: The #VirtQueue
  * Drops all queued buffers and indicates them to the guest
-- 
2.7.4
