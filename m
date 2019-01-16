Received: from eggs.gnu.org ([209.51.188.92]:47425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gjpzb-0003hJ-3J
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:32:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gjpzY-00080H-Ah
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:32:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gjpzX-0007gg-Vd
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:32:44 -0500
From: wexu@redhat.com
Date: Wed, 16 Jan 2019 13:31:12 -0500
Message-Id: <1547663480-547-8-git-send-email-wexu@redhat.com>
In-Reply-To: <1547663480-547-1-git-send-email-wexu@redhat.com>
References: <1547663480-547-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/15] virtio: get avail bytes check for
 packed ring
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
 hw/virtio/virtio.c | 180 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 167 insertions(+), 13 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index e728201..cb599e9 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -372,6 +372,17 @@ int virtio_queue_ready(VirtQueue *vq)
     return vq->vring.avail != 0;
 }
 
+static void vring_packed_desc_read(VirtIODevice *vdev, VRingPackedDesc *desc,
+                            MemoryRegionCache *cache, int i)
+{
+    address_space_read_cached(cache, i * sizeof(VRingPackedDesc),
+                              desc, sizeof(VRingPackedDesc));
+    virtio_tswap16s(vdev, &desc->flags);
+    virtio_tswap64s(vdev, &desc->addr);
+    virtio_tswap32s(vdev, &desc->len);
+    virtio_tswap16s(vdev, &desc->id);
+}
+
 static void vring_packed_desc_read_flags(VirtIODevice *vdev,
                     VRingPackedDesc *desc, MemoryRegionCache *cache, int i)
 {
@@ -671,9 +682,9 @@ static int virtqueue_read_next_desc(VirtIODevice *vdev, VRingDesc *desc,
     return VIRTQUEUE_READ_DESC_MORE;
 }
 
-void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
-                               unsigned int *out_bytes,
-                               unsigned max_in_bytes, unsigned max_out_bytes)
+static void virtqueue_split_get_avail_bytes(VirtQueue *vq,
+                            unsigned int *in_bytes, unsigned int *out_bytes,
+                            unsigned max_in_bytes, unsigned max_out_bytes)
 {
     VirtIODevice *vdev = vq->vdev;
     unsigned int max, idx;
@@ -683,16 +694,6 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
     int64_t len = 0;
     int rc;
 
-    if (unlikely(!vq->vring.desc)) {
-        if (in_bytes) {
-            *in_bytes = 0;
-        }
-        if (out_bytes) {
-            *out_bytes = 0;
-        }
-        return;
-    }
-
     rcu_read_lock();
     idx = vq->last_avail_idx;
     total_bufs = in_total = out_total = 0;
@@ -796,6 +797,159 @@ err:
     goto done;
 }
 
+static void virtqueue_packed_get_avail_bytes(VirtQueue *vq,
+                            unsigned int *in_bytes, unsigned int *out_bytes,
+                            unsigned max_in_bytes, unsigned max_out_bytes)
+{
+    VirtIODevice *vdev = vq->vdev;
+    unsigned int max, idx;
+    unsigned int total_bufs, in_total, out_total;
+    MemoryRegionCache *desc_cache;
+    VRingMemoryRegionCaches *caches;
+    MemoryRegionCache indirect_desc_cache = MEMORY_REGION_CACHE_INVALID;
+    int64_t len = 0;
+    VRingPackedDesc desc;
+    bool wrap_counter;
+
+    rcu_read_lock();
+    idx = vq->last_avail_idx;
+    wrap_counter = vq->avail_wrap_counter;
+    total_bufs = in_total = out_total = 0;
+
+    max = vq->vring.num;
+    caches = vring_get_region_caches(vq);
+    if (caches->desc.len < max * sizeof(VRingPackedDesc)) {
+        virtio_error(vdev, "Cannot map descriptor ring");
+        goto err;
+    }
+
+    desc_cache = &caches->desc;
+    vring_packed_desc_read_flags(vdev, &desc, desc_cache, idx);
+    while (is_desc_avail(&desc, wrap_counter)) {
+        unsigned int num_bufs;
+        unsigned int i = 0;
+
+        num_bufs = total_bufs;
+
+        /* Make sure all the fields have been exposed. */
+        smp_rmb();
+        vring_packed_desc_read(vdev, &desc, desc_cache, idx);
+
+        if (desc.flags & VRING_DESC_F_INDIRECT) {
+            if (desc.len % sizeof(VRingPackedDesc)) {
+                virtio_error(vdev, "Invalid size for indirect buffer table");
+                goto err;
+            }
+
+            /* If we've got too many, that implies a descriptor loop. */
+            if (num_bufs >= max) {
+                virtio_error(vdev, "Looped descriptor");
+                goto err;
+            }
+
+            /* loop over the indirect descriptor table */
+            len = address_space_cache_init(&indirect_desc_cache,
+                                           vdev->dma_as,
+                                           desc.addr, desc.len, false);
+            desc_cache = &indirect_desc_cache;
+            if (len < desc.len) {
+                virtio_error(vdev, "Cannot map indirect buffer");
+                goto err;
+            }
+
+            max = desc.len / sizeof(VRingPackedDesc);
+            num_bufs = i = 0;
+            vring_packed_desc_read(vdev, &desc, desc_cache, i);
+        }
+
+        do {
+            /* If we've got too many, that implies a descriptor loop. */
+            if (++num_bufs > max) {
+                virtio_error(vdev, "Looped descriptor");
+                goto err;
+            }
+
+            if (desc.flags & VRING_DESC_F_WRITE) {
+                in_total += desc.len;
+            } else {
+                out_total += desc.len;
+            }
+            if (in_total >= max_in_bytes && out_total >= max_out_bytes) {
+                goto done;
+            }
+
+            if (desc_cache == &indirect_desc_cache) {
+                vring_packed_desc_read(vdev, &desc, desc_cache, i);
+            } else {
+                if (++idx >= vq->vring.num) {
+                    idx -= vq->vring.num;
+                    wrap_counter = !wrap_counter;
+                }
+                vring_packed_desc_read(vdev, &desc, desc_cache, idx);
+            }
+            /* Make sure we see the flags */
+            smp_rmb();
+        } while (desc.flags & VRING_DESC_F_NEXT);
+
+        if (desc_cache == &indirect_desc_cache) {
+            address_space_cache_destroy(&indirect_desc_cache);
+            total_bufs++;
+            /* We missed one step on for indirect desc */
+            idx++;
+            if (++idx >= vq->vring.num) {
+                idx -= vq->vring.num;
+                wrap_counter = !wrap_counter;
+            }
+        } else {
+            total_bufs = num_bufs;
+        }
+
+        desc_cache = &caches->desc;
+        vring_packed_desc_read_flags(vdev, &desc, desc_cache, idx);
+    }
+
+    /* Record the index and wrap counter for a kick we want */
+    vq->shadow_avail_idx = idx;
+    vq->event_wrap_counter = wrap_counter;
+done:
+    address_space_cache_destroy(&indirect_desc_cache);
+    if (in_bytes) {
+        *in_bytes = in_total;
+    }
+    if (out_bytes) {
+        *out_bytes = out_total;
+    }
+    rcu_read_unlock();
+    return;
+
+err:
+    in_total = out_total = 0;
+    goto done;
+}
+
+void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
+                               unsigned int *out_bytes,
+                               unsigned max_in_bytes, unsigned max_out_bytes)
+{
+    if (unlikely(!vq->vring.desc)) {
+        if (in_bytes) {
+            *in_bytes = 0;
+        }
+        if (out_bytes) {
+            *out_bytes = 0;
+        }
+        return;
+    }
+
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+        virtqueue_packed_get_avail_bytes(vq, in_bytes, out_bytes,
+                                         max_in_bytes, max_out_bytes);
+    } else {
+        virtqueue_split_get_avail_bytes(vq, in_bytes, out_bytes,
+                                        max_in_bytes, max_out_bytes);
+    }
+}
+
 int virtqueue_avail_bytes(VirtQueue *vq, unsigned int in_bytes,
                           unsigned int out_bytes)
 {
-- 
1.8.3.1
