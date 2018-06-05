Received: from eggs.gnu.org ([2001:4830:134:3::10]:42577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1fQHJg-00024g-Kk
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 15:08:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1fQHJf-00034a-ER
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 15:08:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46872 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1fQHJf-00034D-7B
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 15:08:23 -0400
From: wexu@redhat.com
Date: Tue,  5 Jun 2018 15:07:59 -0400
Message-Id: <1528225683-11413-5-git-send-email-wexu@redhat.com>
In-Reply-To: <1528225683-11413-1-git-send-email-wexu@redhat.com>
References: <1528225683-11413-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [RFC v2 4/8] virtio: get avail bytes check for packed
 ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, tiwei.bie@intel.com, mst@redhat.com, wexu@redhat.com, jfreimann@redhat.com

From: Wei Xu <wexu@redhat.com>

mostly as same as 1.0 except traversing all desc to feed
headcount, need a refactor.

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/virtio/virtio.c | 148 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 145 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index bd669a2..cdbb5af 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -650,9 +650,9 @@ static int virtqueue_read_next_desc(VirtIODevice *vdev, VRingDesc *desc,
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
@@ -775,6 +775,148 @@ err:
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
+    VRingDescPacked desc;
+
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
+    rcu_read_lock();
+    idx = vq->last_avail_idx;
+    total_bufs = in_total = out_total = 0;
+
+    max = vq->vring.num;
+    caches = vring_get_region_caches(vq);
+    if (caches->desc.len < max * sizeof(VRingDescPacked)) {
+        virtio_error(vdev, "Cannot map descriptor ring");
+        goto err;
+    }
+
+    desc_cache = &caches->desc;
+    vring_packed_desc_read(vdev, &desc, desc_cache, idx);
+    while (is_desc_avail(&desc)) {
+        unsigned int num_bufs;
+        unsigned int i;
+
+        num_bufs = total_bufs;
+
+        if (desc.flags & VRING_DESC_F_INDIRECT) {
+            if (desc.len % sizeof(VRingDescPacked)) {
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
+            max = desc.len / sizeof(VRingDescPacked);
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
+                if (++i >= vq->vring.num) {
+                    i -= vq->vring.num;
+                }
+                vring_packed_desc_read(vdev, &desc, desc_cache, i);
+            } else {
+                if (++idx >= vq->vring.num) {
+                    idx -= vq->vring.num;
+                }
+                vring_packed_desc_read(vdev, &desc, desc_cache, idx);
+            }
+            /* Make sure we see the flags */
+            smp_mb();
+        } while (desc.flags & VRING_DESC_F_NEXT);
+
+        if (desc_cache == &indirect_desc_cache) {
+            address_space_cache_destroy(&indirect_desc_cache);
+            total_bufs++;
+            /* We missed one step on for indirect desc */
+            idx++;
+        } else {
+            total_bufs = num_bufs;
+        }
+
+        desc_cache = &caches->desc;
+        vring_packed_desc_read(vdev, &desc, desc_cache, idx % vq->vring.num);
+    }
+
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
