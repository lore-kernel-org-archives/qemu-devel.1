Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235D8C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 04:08:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9B362073D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 04:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B362073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htOrt-0001rW-1b
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 00:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50499)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1htOq5-0006Ff-W2
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 00:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1htOq2-0001f5-2D
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 00:06:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43031)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1htOq1-0001er-NU
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 00:06:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 066AD85545;
 Fri,  2 Aug 2019 04:06:41 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com
 (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A9AB1001B02;
 Fri,  2 Aug 2019 04:06:34 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com
Date: Fri,  2 Aug 2019 00:06:03 -0400
Message-Id: <20190802040606.22573-4-jasowang@redhat.com>
In-Reply-To: <20190802040606.22573-1-jasowang@redhat.com>
References: <20190802040606.22573-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 02 Aug 2019 04:06:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH V5 3/6] virtio: basic packed virtqueue support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: yang.zhong@intel.com, tiwei.bie@intel.com, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, maxime.coquelin@redhat.com, Wei Xu <wexu@redhat.com>,
 jfreimann@redhat.com, weiyshay@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch implements basic support for the packed virtqueue. Compare
the split virtqueue which has three rings, packed virtqueue only have
one which is supposed to have better cache utilization and more
hardware friendly.

Please refer virtio specification for more information.

Signed-off-by: Wei Xu <wexu@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/block/virtio-blk.c       |   2 +-
 hw/char/virtio-serial-bus.c |   2 +-
 hw/scsi/virtio-scsi.c       |   3 +-
 hw/virtio/virtio.c          | 900 +++++++++++++++++++++++++++++++++---
 include/hw/virtio/virtio.h  |  10 +-
 5 files changed, 837 insertions(+), 80 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index cbb3729158..122d9fd6f1 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1047,7 +1047,7 @@ static void virtio_blk_save_device(VirtIODevice *vdev, QEMUFile *f)
             qemu_put_be32(f, virtio_get_queue_index(req->vq));
         }
 
-        qemu_put_virtqueue_element(f, &req->elem);
+        qemu_put_virtqueue_element(vdev, f, &req->elem);
         req = req->next;
     }
     qemu_put_sbyte(f, 0);
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index f7a54f261b..d0d861386c 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -705,7 +705,7 @@ static void virtio_serial_save_device(VirtIODevice *vdev, QEMUFile *f)
         if (elem_popped) {
             qemu_put_be32s(f, &port->iov_idx);
             qemu_put_be64s(f, &port->iov_offset);
-            qemu_put_virtqueue_element(f, port->elem);
+            qemu_put_virtqueue_element(vdev, f, port->elem);
         }
     }
 }
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 8b9e5e2b49..41ea855e0a 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -188,11 +188,12 @@ static void virtio_scsi_save_request(QEMUFile *f, SCSIRequest *sreq)
 {
     VirtIOSCSIReq *req = sreq->hba_private;
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(req->dev);
+    VirtIODevice *vdev = VIRTIO_DEVICE(req->dev);
     uint32_t n = virtio_get_queue_index(req->vq) - 2;
 
     assert(n < vs->conf.num_queues);
     qemu_put_be32s(f, &n);
-    qemu_put_virtqueue_element(f, &req->elem);
+    qemu_put_virtqueue_element(vdev, f, &req->elem);
 }
 
 static void *virtio_scsi_load_request(QEMUFile *f, SCSIRequest *sreq)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index ac21ab43e2..4105fe2448 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -92,6 +92,7 @@ typedef struct VRingPackedDescEvent {
 struct VirtQueue
 {
     VRing vring;
+    VirtQueueElement *used_elems;
 
     /* Next head to pop */
     uint16_t last_avail_idx;
@@ -156,6 +157,7 @@ static void virtio_init_region_cache(VirtIODevice *vdev, int n)
     VRingMemoryRegionCaches *new = NULL;
     hwaddr addr, size;
     int64_t len;
+    bool packed;
 
 
     addr = vq->vring.desc;
@@ -164,8 +166,10 @@ static void virtio_init_region_cache(VirtIODevice *vdev, int n)
     }
     new = g_new0(VRingMemoryRegionCaches, 1);
     size = virtio_queue_get_desc_size(vdev, n);
+    packed = virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED) ?
+                                   true : false;
     len = address_space_cache_init(&new->desc, vdev->dma_as,
-                                   addr, size, false);
+                                   addr, size, packed);
     if (len < size) {
         virtio_error(vdev, "Cannot map desc");
         goto err_desc;
@@ -221,8 +225,8 @@ void virtio_queue_update_rings(VirtIODevice *vdev, int n)
 }
 
 /* Called within rcu_read_lock().  */
-static void vring_desc_read(VirtIODevice *vdev, VRingDesc *desc,
-                            MemoryRegionCache *cache, int i)
+static void vring_split_desc_read(VirtIODevice *vdev, VRingDesc *desc,
+                                  MemoryRegionCache *cache, int i)
 {
     address_space_read_cached(cache, i * sizeof(VRingDesc),
                               desc, sizeof(VRingDesc));
@@ -366,6 +370,95 @@ int virtio_queue_ready(VirtQueue *vq)
     return vq->vring.avail != 0;
 }
 
+static void vring_packed_desc_read_flags(VirtIODevice *vdev,
+                                         uint16_t *flags,
+                                         MemoryRegionCache *cache,
+                                         int i)
+{
+    address_space_read_cached(cache,
+                              i * sizeof(VRingPackedDesc) +
+                              offsetof(VRingPackedDesc, flags),
+                              flags, sizeof(*flags));
+    virtio_tswap16s(vdev, flags);
+}
+
+static void vring_packed_desc_read(VirtIODevice *vdev,
+                                   VRingPackedDesc *desc,
+                                   MemoryRegionCache *cache,
+                                   int i, bool strict_order)
+{
+    hwaddr off = i * sizeof(VRingPackedDesc);
+
+    vring_packed_desc_read_flags(vdev, &desc->flags, cache, i);
+
+    if (strict_order) {
+        /* Make sure flags is read before the rest fields. */
+        smp_rmb();
+    }
+
+    address_space_read_cached(cache, off + offsetof(VRingPackedDesc, addr),
+                              &desc->addr, sizeof(desc->addr));
+    address_space_read_cached(cache, off + offsetof(VRingPackedDesc, id),
+                              &desc->id, sizeof(desc->id));
+    address_space_read_cached(cache, off + offsetof(VRingPackedDesc, len),
+                              &desc->len, sizeof(desc->len));
+    virtio_tswap64s(vdev, &desc->addr);
+    virtio_tswap16s(vdev, &desc->id);
+    virtio_tswap32s(vdev, &desc->len);
+}
+
+static void vring_packed_desc_write_data(VirtIODevice *vdev,
+                                         VRingPackedDesc *desc,
+                                         MemoryRegionCache *cache,
+                                         int i)
+{
+    hwaddr off_id = i * sizeof(VRingPackedDesc) +
+                    offsetof(VRingPackedDesc, id);
+    hwaddr off_len = i * sizeof(VRingPackedDesc) +
+                    offsetof(VRingPackedDesc, len);
+
+    virtio_tswap32s(vdev, &desc->len);
+    virtio_tswap16s(vdev, &desc->id);
+    address_space_write_cached(cache, off_id, &desc->id, sizeof(desc->id));
+    address_space_cache_invalidate(cache, off_id, sizeof(desc->id));
+    address_space_write_cached(cache, off_len, &desc->len, sizeof(desc->len));
+    address_space_cache_invalidate(cache, off_len, sizeof(desc->len));
+}
+
+static void vring_packed_desc_write_flags(VirtIODevice *vdev,
+                                          VRingPackedDesc *desc,
+                                          MemoryRegionCache *cache,
+                                          int i)
+{
+    hwaddr off = i * sizeof(VRingPackedDesc) + offsetof(VRingPackedDesc, flags);
+
+    virtio_tswap16s(vdev, &desc->flags);
+    address_space_write_cached(cache, off, &desc->flags, sizeof(desc->flags));
+    address_space_cache_invalidate(cache, off, sizeof(desc->flags));
+}
+
+static void vring_packed_desc_write(VirtIODevice *vdev,
+                                    VRingPackedDesc *desc,
+                                    MemoryRegionCache *cache,
+                                    int i, bool strict_order)
+{
+    vring_packed_desc_write_data(vdev, desc, cache, i);
+    if (strict_order) {
+        /* Make sure data is wrote before flags. */
+        smp_wmb();
+    }
+    vring_packed_desc_write_flags(vdev, desc, cache, i);
+}
+
+static inline bool is_desc_avail(uint16_t flags, bool wrap_counter)
+{
+    bool avail, used;
+
+    avail = !!(flags & (1 << VRING_PACKED_DESC_F_AVAIL));
+    used = !!(flags & (1 << VRING_PACKED_DESC_F_USED));
+    return (avail != used) && (avail == wrap_counter);
+}
+
 /* Fetch avail_idx from VQ memory only when we really need to know if
  * guest has added some buffers.
  * Called within rcu_read_lock().  */
@@ -386,7 +479,7 @@ static int virtio_queue_empty_rcu(VirtQueue *vq)
     return vring_avail_idx(vq) == vq->last_avail_idx;
 }
 
-int virtio_queue_empty(VirtQueue *vq)
+static int virtio_queue_split_empty(VirtQueue *vq)
 {
     bool empty;
 
@@ -408,6 +501,41 @@ int virtio_queue_empty(VirtQueue *vq)
     return empty;
 }
 
+static int virtio_queue_packed_empty_rcu(VirtQueue *vq)
+{
+    struct VRingPackedDesc desc;
+    VRingMemoryRegionCaches *cache;
+
+    if (unlikely(!vq->vring.desc)) {
+        return 1;
+    }
+
+    cache = vring_get_region_caches(vq);
+    vring_packed_desc_read_flags(vq->vdev, &desc.flags, &cache->desc,
+                                 vq->last_avail_idx);
+
+    return !is_desc_avail(desc.flags, vq->last_avail_wrap_counter);
+}
+
+static int virtio_queue_packed_empty(VirtQueue *vq)
+{
+    bool empty;
+
+    rcu_read_lock();
+    empty = virtio_queue_packed_empty_rcu(vq);
+    rcu_read_unlock();
+    return empty;
+}
+
+int virtio_queue_empty(VirtQueue *vq)
+{
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+        return virtio_queue_packed_empty(vq);
+    } else {
+        return virtio_queue_split_empty(vq);
+    }
+}
+
 static void virtqueue_unmap_sg(VirtQueue *vq, const VirtQueueElement *elem,
                                unsigned int len)
 {
@@ -445,10 +573,25 @@ static void virtqueue_unmap_sg(VirtQueue *vq, const VirtQueueElement *elem,
 void virtqueue_detach_element(VirtQueue *vq, const VirtQueueElement *elem,
                               unsigned int len)
 {
-    vq->inuse--;
+    vq->inuse -= elem->ndescs;
     virtqueue_unmap_sg(vq, elem, len);
 }
 
+static void virtqueue_split_rewind(VirtQueue *vq, unsigned int num)
+{
+    vq->last_avail_idx -= num;
+}
+
+static void virtqueue_packed_rewind(VirtQueue *vq, unsigned int num)
+{
+    if (vq->last_avail_idx < num) {
+        vq->last_avail_idx = vq->vring.num + vq->last_avail_idx - num;
+        vq->last_avail_wrap_counter ^= 1;
+    } else {
+        vq->last_avail_idx -= num;
+    }
+}
+
 /* virtqueue_unpop:
  * @vq: The #VirtQueue
  * @elem: The #VirtQueueElement
@@ -460,7 +603,13 @@ void virtqueue_detach_element(VirtQueue *vq, const VirtQueueElement *elem,
 void virtqueue_unpop(VirtQueue *vq, const VirtQueueElement *elem,
                      unsigned int len)
 {
-    vq->last_avail_idx--;
+
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+        virtqueue_packed_rewind(vq, 1);
+    } else {
+        virtqueue_split_rewind(vq, 1);
+    }
+
     virtqueue_detach_element(vq, elem, len);
 }
 
@@ -481,25 +630,22 @@ bool virtqueue_rewind(VirtQueue *vq, unsigned int num)
     if (num > vq->inuse) {
         return false;
     }
-    vq->last_avail_idx -= num;
+
     vq->inuse -= num;
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+        virtqueue_packed_rewind(vq, num);
+    } else {
+        virtqueue_split_rewind(vq, num);
+    }
     return true;
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
@@ -511,16 +657,71 @@ void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
     vring_used_write(vq, &uelem, idx);
 }
 
-/* Called within rcu_read_lock().  */
-void virtqueue_flush(VirtQueue *vq, unsigned int count)
+static void virtqueue_packed_fill(VirtQueue *vq, const VirtQueueElement *elem,
+                                  unsigned int len, unsigned int idx)
 {
-    uint16_t old, new;
+    vq->used_elems[idx].index = elem->index;
+    vq->used_elems[idx].len = len;
+    vq->used_elems[idx].ndescs = elem->ndescs;
+}
+
+static void virtqueue_packed_fill_desc(VirtQueue *vq,
+                                       const VirtQueueElement *elem,
+                                       unsigned int idx,
+                                       bool strict_order)
+{
+    uint16_t head;
+    VRingMemoryRegionCaches *caches;
+    VRingPackedDesc desc = {
+        .id = elem->index,
+        .len = elem->len,
+    };
+    bool wrap_counter = vq->used_wrap_counter;
+
+    if (unlikely(!vq->vring.desc)) {
+        return;
+    }
+
+    head = vq->used_idx + idx;
+    if (head >= vq->vring.num) {
+        head -= vq->vring.num;
+        wrap_counter ^= 1;
+    }
+    if (wrap_counter) {
+        desc.flags |= (1 << VRING_PACKED_DESC_F_AVAIL);
+        desc.flags |= (1 << VRING_PACKED_DESC_F_USED);
+    } else {
+        desc.flags &= ~(1 << VRING_PACKED_DESC_F_AVAIL);
+        desc.flags &= ~(1 << VRING_PACKED_DESC_F_USED);
+    }
+
+    caches = vring_get_region_caches(vq);
+    vring_packed_desc_write(vq->vdev, &desc, &caches->desc, head, strict_order);
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
@@ -536,6 +737,43 @@ void virtqueue_flush(VirtQueue *vq, unsigned int count)
         vq->signalled_used_valid = false;
 }
 
+static void virtqueue_packed_flush(VirtQueue *vq, unsigned int count)
+{
+    unsigned int i, ndescs = 0;
+
+    if (unlikely(!vq->vring.desc)) {
+        return;
+    }
+
+    for (i = 1; i < count; i++) {
+        virtqueue_packed_fill_desc(vq, &vq->used_elems[i], i, false);
+        ndescs += vq->used_elems[i].ndescs;
+    }
+    virtqueue_packed_fill_desc(vq, &vq->used_elems[0], 0, true);
+    ndescs += vq->used_elems[0].ndescs;
+
+    vq->inuse -= ndescs;
+    vq->used_idx += ndescs;
+    if (vq->used_idx >= vq->vring.num) {
+        vq->used_idx -= vq->vring.num;
+        vq->used_wrap_counter ^= 1;
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
@@ -588,9 +826,9 @@ enum {
     VIRTQUEUE_READ_DESC_MORE = 1,   /* more buffers in chain */
 };
 
-static int virtqueue_read_next_desc(VirtIODevice *vdev, VRingDesc *desc,
-                                    MemoryRegionCache *desc_cache, unsigned int max,
-                                    unsigned int *next)
+static int virtqueue_split_read_next_desc(VirtIODevice *vdev, VRingDesc *desc,
+                                          MemoryRegionCache *desc_cache,
+                                          unsigned int max, unsigned int *next)
 {
     /* If this descriptor says it doesn't chain, we're done. */
     if (!(desc->flags & VRING_DESC_F_NEXT)) {
@@ -607,13 +845,13 @@ static int virtqueue_read_next_desc(VirtIODevice *vdev, VRingDesc *desc,
         return VIRTQUEUE_READ_DESC_ERROR;
     }
 
-    vring_desc_read(vdev, desc, desc_cache, *next);
+    vring_split_desc_read(vdev, desc, desc_cache, *next);
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
@@ -623,27 +861,12 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
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
 
     max = vq->vring.num;
     caches = vring_get_region_caches(vq);
-    if (caches->desc.len < max * sizeof(VRingDesc)) {
-        virtio_error(vdev, "Cannot map descriptor ring");
-        goto err;
-    }
-
     while ((rc = virtqueue_num_heads(vq, idx)) > 0) {
         MemoryRegionCache *desc_cache = &caches->desc;
         unsigned int num_bufs;
@@ -656,7 +879,7 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
             goto err;
         }
 
-        vring_desc_read(vdev, &desc, desc_cache, i);
+        vring_split_desc_read(vdev, &desc, desc_cache, i);
 
         if (desc.flags & VRING_DESC_F_INDIRECT) {
             if (!desc.len || (desc.len % sizeof(VRingDesc))) {
@@ -682,7 +905,7 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
 
             max = desc.len / sizeof(VRingDesc);
             num_bufs = i = 0;
-            vring_desc_read(vdev, &desc, desc_cache, i);
+            vring_split_desc_read(vdev, &desc, desc_cache, i);
         }
 
         do {
@@ -701,7 +924,7 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
                 goto done;
             }
 
-            rc = virtqueue_read_next_desc(vdev, &desc, desc_cache, max, &i);
+            rc = virtqueue_split_read_next_desc(vdev, &desc, desc_cache, max, &i);
         } while (rc == VIRTQUEUE_READ_DESC_MORE);
 
         if (rc == VIRTQUEUE_READ_DESC_ERROR) {
@@ -723,17 +946,197 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
 done:
     address_space_cache_destroy(&indirect_desc_cache);
     if (in_bytes) {
-        *in_bytes = in_total;
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
+static int virtqueue_packed_read_next_desc(VirtQueue *vq,
+                                           VRingPackedDesc *desc,
+                                           MemoryRegionCache
+                                           *desc_cache,
+                                           unsigned int max,
+                                           unsigned int *next,
+                                           bool indirect)
+{
+    /* If this descriptor says it doesn't chain, we're done. */
+    if (!indirect && !(desc->flags & VRING_DESC_F_NEXT)) {
+        return VIRTQUEUE_READ_DESC_DONE;
+    }
+
+    ++*next;
+    if (*next == max) {
+        if (indirect) {
+            return VIRTQUEUE_READ_DESC_DONE;
+        } else {
+            (*next) -= vq->vring.num;
+        }
+    }
+
+    vring_packed_desc_read(vq->vdev, desc, desc_cache, *next, false);
+    return VIRTQUEUE_READ_DESC_MORE;
+}
+
+static void virtqueue_packed_get_avail_bytes(VirtQueue *vq,
+                                             unsigned int *in_bytes,
+                                             unsigned int *out_bytes,
+                                             unsigned max_in_bytes,
+                                             unsigned max_out_bytes)
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
+    wrap_counter = vq->last_avail_wrap_counter;
+    total_bufs = in_total = out_total = 0;
+
+    max = vq->vring.num;
+    caches = vring_get_region_caches(vq);
+
+    for (;;) {
+        unsigned int num_bufs = total_bufs;
+        unsigned int i = idx;
+        int rc;
+
+        desc_cache = &caches->desc;
+        vring_packed_desc_read(vdev, &desc, desc_cache, idx, true);
+        if (!is_desc_avail(desc.flags, wrap_counter)) {
+            break;
+        }
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
+            vring_packed_desc_read(vdev, &desc, desc_cache, i, false);
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
+            rc = virtqueue_packed_read_next_desc(vq, &desc, desc_cache, max,
+                                                 &i, desc_cache ==
+                                                 &indirect_desc_cache);
+        } while (rc == VIRTQUEUE_READ_DESC_MORE);
+
+        if (desc_cache == &indirect_desc_cache) {
+            address_space_cache_destroy(&indirect_desc_cache);
+            total_bufs++;
+            idx++;
+        } else {
+            idx += num_bufs - total_bufs;
+            total_bufs = num_bufs;
+        }
+
+        if (idx >= vq->vring.num) {
+            idx -= vq->vring.num;
+            wrap_counter ^= 1;
+        }
+    }
+
+    /* Record the index and wrap counter for a kick we want */
+    vq->shadow_avail_idx = idx;
+    vq->shadow_avail_wrap_counter = wrap_counter;
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
+    uint16_t desc_size;
+    VRingMemoryRegionCaches *caches;
+
+    if (unlikely(!vq->vring.desc)) {
+        goto err;
+    }
+
+    caches = vring_get_region_caches(vq);
+    desc_size = virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED) ?
+                                sizeof(VRingPackedDesc) : sizeof(VRingDesc);
+    if (caches->desc.len < vq->vring.num * desc_size) {
+        virtio_error(vq->vdev, "Cannot map descriptor ring");
+        goto err;
+    }
+
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+        virtqueue_packed_get_avail_bytes(vq, in_bytes, out_bytes,
+                                         max_in_bytes, max_out_bytes);
+    } else {
+        virtqueue_split_get_avail_bytes(vq, in_bytes, out_bytes,
+                                        max_in_bytes, max_out_bytes);
+    }
+
+    return;
+err:
+    if (in_bytes) {
+        *in_bytes = 0;
     }
     if (out_bytes) {
-        *out_bytes = out_total;
+        *out_bytes = 0;
     }
-    rcu_read_unlock();
-    return;
-
-err:
-    in_total = out_total = 0;
-    goto done;
 }
 
 int virtqueue_avail_bytes(VirtQueue *vq, unsigned int in_bytes,
@@ -860,7 +1263,7 @@ static void *virtqueue_alloc_element(size_t sz, unsigned out_num, unsigned in_nu
     return elem;
 }
 
-void *virtqueue_pop(VirtQueue *vq, size_t sz)
+static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
 {
     unsigned int i, head, max;
     VRingMemoryRegionCaches *caches;
@@ -875,9 +1278,6 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     VRingDesc desc;
     int rc;
 
-    if (unlikely(vdev->broken)) {
-        return NULL;
-    }
     rcu_read_lock();
     if (virtio_queue_empty_rcu(vq)) {
         goto done;
@@ -913,7 +1313,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     }
 
     desc_cache = &caches->desc;
-    vring_desc_read(vdev, &desc, desc_cache, i);
+    vring_split_desc_read(vdev, &desc, desc_cache, i);
     if (desc.flags & VRING_DESC_F_INDIRECT) {
         if (!desc.len || (desc.len % sizeof(VRingDesc))) {
             virtio_error(vdev, "Invalid size for indirect buffer table");
@@ -931,7 +1331,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
 
         max = desc.len / sizeof(VRingDesc);
         i = 0;
-        vring_desc_read(vdev, &desc, desc_cache, i);
+        vring_split_desc_read(vdev, &desc, desc_cache, i);
     }
 
     /* Collect all the descriptors */
@@ -962,7 +1362,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
             goto err_undo_map;
         }
 
-        rc = virtqueue_read_next_desc(vdev, &desc, desc_cache, max, &i);
+        rc = virtqueue_split_read_next_desc(vdev, &desc, desc_cache, max, &i);
     } while (rc == VIRTQUEUE_READ_DESC_MORE);
 
     if (rc == VIRTQUEUE_READ_DESC_ERROR) {
@@ -972,6 +1372,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     /* Now copy what we have collected and mapped */
     elem = virtqueue_alloc_element(sz, out_num, in_num);
     elem->index = head;
+    elem->ndescs = 1;
     for (i = 0; i < out_num; i++) {
         elem->out_addr[i] = addr[i];
         elem->out_sg[i] = iov[i];
@@ -995,13 +1396,202 @@ err_undo_map:
     goto done;
 }
 
-/* virtqueue_drop_all:
- * @vq: The #VirtQueue
- * Drops all queued buffers and indicates them to the guest
- * as if they are done. Useful when buffers can not be
- * processed but must be returned to the guest.
- */
-unsigned int virtqueue_drop_all(VirtQueue *vq)
+static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
+{
+    unsigned int i, max;
+    VRingMemoryRegionCaches *caches;
+    MemoryRegionCache indirect_desc_cache = MEMORY_REGION_CACHE_INVALID;
+    MemoryRegionCache *desc_cache;
+    int64_t len;
+    VirtIODevice *vdev = vq->vdev;
+    VirtQueueElement *elem = NULL;
+    unsigned out_num, in_num, elem_entries;
+    hwaddr addr[VIRTQUEUE_MAX_SIZE];
+    struct iovec iov[VIRTQUEUE_MAX_SIZE];
+    VRingPackedDesc desc;
+    uint16_t id;
+    int rc;
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
+    i = vq->last_avail_idx;
+
+    caches = vring_get_region_caches(vq);
+    if (caches->desc.len < max * sizeof(VRingDesc)) {
+        virtio_error(vdev, "Cannot map descriptor ring");
+        goto done;
+    }
+
+    desc_cache = &caches->desc;
+    vring_packed_desc_read(vdev, &desc, desc_cache, i, true);
+    id = desc.id;
+    if (desc.flags & VRING_DESC_F_INDIRECT) {
+        if (desc.len % sizeof(VRingPackedDesc)) {
+            virtio_error(vdev, "Invalid size for indirect buffer table");
+            goto done;
+        }
+
+        /* loop over the indirect descriptor table */
+        len = address_space_cache_init(&indirect_desc_cache, vdev->dma_as,
+                                       desc.addr, desc.len, false);
+        desc_cache = &indirect_desc_cache;
+        if (len < desc.len) {
+            virtio_error(vdev, "Cannot map indirect buffer");
+            goto done;
+        }
+
+        max = desc.len / sizeof(VRingPackedDesc);
+        i = 0;
+        vring_packed_desc_read(vdev, &desc, desc_cache, i, false);
+    }
+
+    /* Collect all the descriptors */
+    do {
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
+        rc = virtqueue_packed_read_next_desc(vq, &desc, desc_cache, max, &i,
+                                             desc_cache ==
+                                             &indirect_desc_cache);
+    } while (rc == VIRTQUEUE_READ_DESC_MORE);
+
+    /* Now copy what we have collected and mapped */
+    elem = virtqueue_alloc_element(sz, out_num, in_num);
+    for (i = 0; i < out_num; i++) {
+        elem->out_addr[i] = addr[i];
+        elem->out_sg[i] = iov[i];
+    }
+    for (i = 0; i < in_num; i++) {
+        elem->in_addr[i] = addr[out_num + i];
+        elem->in_sg[i] = iov[out_num + i];
+    }
+
+    elem->index = id;
+    elem->ndescs = (desc_cache == &indirect_desc_cache) ? 1 : elem_entries;
+    vq->last_avail_idx += elem->ndescs;
+    vq->inuse += elem->ndescs;
+
+    if (vq->last_avail_idx >= vq->vring.num) {
+        vq->last_avail_idx -= vq->vring.num;
+        vq->last_avail_wrap_counter ^= 1;
+    }
+
+    vq->shadow_avail_idx = vq->last_avail_idx;
+    vq->shadow_avail_wrap_counter = vq->last_avail_wrap_counter;
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
+static unsigned int virtqueue_packed_drop_all(VirtQueue *vq)
+{
+    VRingMemoryRegionCaches *caches;
+    MemoryRegionCache *desc_cache;
+    unsigned int dropped = 0;
+    VirtQueueElement elem = {};
+    VirtIODevice *vdev = vq->vdev;
+    VRingPackedDesc desc;
+
+    if (unlikely(vdev->broken)) {
+        return 0;
+    }
+
+    caches = vring_get_region_caches(vq);
+    desc_cache = &caches->desc;
+
+    virtio_queue_set_notification(vq, 0);
+
+    while (vq->inuse < vq->vring.num) {
+        unsigned int idx = vq->last_avail_idx;
+        /*
+         * works similar to virtqueue_pop but does not map buffers
+         * and does not allocate any memory.
+         */
+        vring_packed_desc_read(vdev, &desc, desc_cache,
+                               vq->last_avail_idx , true);
+        if (!is_desc_avail(desc.flags, vq->last_avail_wrap_counter)) {
+            break;
+        }
+        elem.index = desc.id;
+        elem.ndescs = 1;
+        while (virtqueue_packed_read_next_desc(vq, &desc, desc_cache,
+                                               vq->vring.num, &idx, false)) {
+            ++elem.ndescs;
+        }
+        /*
+         * immediately push the element, nothing to unmap
+         * as both in_num and out_num are set to 0.
+         */
+        virtqueue_push(vq, &elem, 0);
+        dropped++;
+        vq->last_avail_idx += elem.ndescs;
+        if (vq->last_avail_idx >= vq->vring.num) {
+            vq->last_avail_idx -= vq->vring.num;
+            vq->last_avail_wrap_counter ^= 1;
+        }
+    }
+
+    return dropped;
+}
+
+static unsigned int virtqueue_split_drop_all(VirtQueue *vq)
 {
     unsigned int dropped = 0;
     VirtQueueElement elem = {};
@@ -1033,6 +1623,23 @@ unsigned int virtqueue_drop_all(VirtQueue *vq)
     return dropped;
 }
 
+/* virtqueue_drop_all:
+ * @vq: The #VirtQueue
+ * Drops all queued buffers and indicates them to the guest
+ * as if they are done. Useful when buffers can not be
+ * processed but must be returned to the guest.
+ */
+unsigned int virtqueue_drop_all(VirtQueue *vq)
+{
+    struct VirtIODevice *vdev = vq->vdev;
+
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        return virtqueue_packed_drop_all(vq);
+    } else {
+        return virtqueue_split_drop_all(vq);
+    }
+}
+
 /* Reading and writing a structure directly to QEMUFile is *awful*, but
  * it is what QEMU has always done by mistake.  We can change it sooner
  * or later by bumping the version number of the affected vm states.
@@ -1089,11 +1696,16 @@ void *qemu_get_virtqueue_element(VirtIODevice *vdev, QEMUFile *f, size_t sz)
         elem->out_sg[i].iov_len = data.out_sg[i].iov_len;
     }
 
+    if (virtio_host_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        qemu_get_be32s(f, &elem->ndescs);
+    }
+
     virtqueue_map(vdev, elem);
     return elem;
 }
 
-void qemu_put_virtqueue_element(QEMUFile *f, VirtQueueElement *elem)
+void qemu_put_virtqueue_element(VirtIODevice *vdev, QEMUFile *f,
+                                VirtQueueElement *elem)
 {
     VirtQueueElementOld data;
     int i;
@@ -1121,6 +1733,11 @@ void qemu_put_virtqueue_element(QEMUFile *f, VirtQueueElement *elem)
         /* Do not save iov_base as above.  */
         data.out_sg[i].iov_len = elem->out_sg[i].iov_len;
     }
+
+    if (virtio_host_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        qemu_put_be32s(f, &elem->ndescs);
+    }
+
     qemu_put_buffer(f, (uint8_t *)&data, sizeof(VirtQueueElementOld));
 }
 
@@ -1245,6 +1862,9 @@ void virtio_reset(void *opaque)
         vdev->vq[i].last_avail_idx = 0;
         vdev->vq[i].shadow_avail_idx = 0;
         vdev->vq[i].used_idx = 0;
+        vdev->vq[i].last_avail_wrap_counter = true;
+        vdev->vq[i].shadow_avail_wrap_counter = true;
+        vdev->vq[i].used_wrap_counter = true;
         virtio_queue_set_vector(vdev, i, VIRTIO_NO_VECTOR);
         vdev->vq[i].signalled_used = 0;
         vdev->vq[i].signalled_used_valid = false;
@@ -1635,6 +2255,8 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
     vdev->vq[i].vring.align = VIRTIO_PCI_VRING_ALIGN;
     vdev->vq[i].handle_output = handle_output;
     vdev->vq[i].handle_aio_output = NULL;
+    vdev->vq[i].used_elems = g_malloc0(sizeof(VirtQueueElement) *
+                                       queue_size);
 
     return &vdev->vq[i];
 }
@@ -1649,6 +2271,7 @@ void virtio_del_queue(VirtIODevice *vdev, int n)
     vdev->vq[n].vring.num_default = 0;
     vdev->vq[n].handle_output = NULL;
     vdev->vq[n].handle_aio_output = NULL;
+    g_free(vdev->vq[n].used_elems);
 }
 
 static void virtio_set_isr(VirtIODevice *vdev, int value)
@@ -1776,6 +2399,13 @@ static bool virtio_virtqueue_needed(void *opaque)
     return virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1);
 }
 
+static bool virtio_packed_virtqueue_needed(void *opaque)
+{
+    VirtIODevice *vdev = opaque;
+
+    return virtio_host_has_feature(vdev, VIRTIO_F_RING_PACKED);
+}
+
 static bool virtio_ringsize_needed(void *opaque)
 {
     VirtIODevice *vdev = opaque;
@@ -1824,6 +2454,20 @@ static const VMStateDescription vmstate_virtqueue = {
     }
 };
 
+static const VMStateDescription vmstate_packed_virtqueue = {
+    .name = "packed_virtqueue_state",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT16(last_avail_idx, struct VirtQueue),
+        VMSTATE_BOOL(last_avail_wrap_counter, struct VirtQueue),
+        VMSTATE_UINT16(used_idx, struct VirtQueue),
+        VMSTATE_BOOL(used_wrap_counter, struct VirtQueue),
+        VMSTATE_UINT32(inuse, struct VirtQueue),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_virtio_virtqueues = {
     .name = "virtio/virtqueues",
     .version_id = 1,
@@ -1836,6 +2480,18 @@ static const VMStateDescription vmstate_virtio_virtqueues = {
     }
 };
 
+static const VMStateDescription vmstate_virtio_packed_virtqueues = {
+    .name = "virtio/packed_virtqueues",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = &virtio_packed_virtqueue_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT_VARRAY_POINTER_KNOWN(vq, struct VirtIODevice,
+                      VIRTIO_QUEUE_MAX, 0, vmstate_packed_virtqueue, VirtQueue),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_ringsize = {
     .name = "ringsize_state",
     .version_id = 1,
@@ -1968,6 +2624,7 @@ static const VMStateDescription vmstate_virtio = {
         &vmstate_virtio_broken,
         &vmstate_virtio_extra_state,
         &vmstate_virtio_started,
+        &vmstate_virtio_packed_virtqueues,
         NULL
     }
 };
@@ -2267,6 +2924,13 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
                 virtio_queue_update_rings(vdev, i);
             }
 
+            if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+                vdev->vq[i].shadow_avail_idx = vdev->vq[i].last_avail_idx;
+                vdev->vq[i].shadow_avail_wrap_counter =
+                                        vdev->vq[i].last_avail_wrap_counter;
+                continue;
+            }
+
             nheads = vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_avail_idx;
             /* Check it isn't doing strange things with descriptor numbers. */
             if (nheads > vdev->vq[i].vring.num) {
@@ -2410,6 +3074,10 @@ hwaddr virtio_queue_get_avail_size(VirtIODevice *vdev, int n)
 {
     int s;
 
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        return sizeof(struct VRingPackedDescEvent);
+    }
+
     s = virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
     return offsetof(VRingAvail, ring) +
         sizeof(uint16_t) * vdev->vq[n].vring.num + s;
@@ -2419,23 +3087,83 @@ hwaddr virtio_queue_get_used_size(VirtIODevice *vdev, int n)
 {
     int s;
 
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        return sizeof(struct VRingPackedDescEvent);
+    }
+
     s = virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
     return offsetof(VRingUsed, ring) +
         sizeof(VRingUsedElem) * vdev->vq[n].vring.num + s;
 }
 
-uint16_t virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n)
+static unsigned int virtio_queue_packed_get_last_avail_idx(VirtIODevice *vdev,
+                                                           int n)
+{
+    unsigned int avail, used;
+
+    avail = vdev->vq[n].last_avail_idx;
+    avail |= ((uint16_t)vdev->vq[n].last_avail_wrap_counter) << 15;
+
+    used = vdev->vq[n].used_idx;
+    used |= ((uint16_t)vdev->vq[n].used_wrap_counter) << 15;
+
+    return avail | used << 16;
+}
+
+static uint16_t virtio_queue_split_get_last_avail_idx(VirtIODevice *vdev,
+                                                      int n)
 {
     return vdev->vq[n].last_avail_idx;
 }
 
-void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n, uint16_t idx)
+unsigned int virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n)
 {
-    vdev->vq[n].last_avail_idx = idx;
-    vdev->vq[n].shadow_avail_idx = idx;
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        return virtio_queue_packed_get_last_avail_idx(vdev, n);
+    } else {
+        return virtio_queue_split_get_last_avail_idx(vdev, n);
+    }
 }
 
-void virtio_queue_restore_last_avail_idx(VirtIODevice *vdev, int n)
+static void virtio_queue_packed_set_last_avail_idx(VirtIODevice *vdev,
+                                                   int n, unsigned int idx)
+{
+    struct VirtQueue *vq = &vdev->vq[n];
+
+    vq->last_avail_idx = vq->shadow_avail_idx = idx & 0x7fff;
+    vq->last_avail_wrap_counter =
+        vq->shadow_avail_wrap_counter = !!(idx & 0x8000);
+    idx >>= 16;
+    vq->used_idx = idx & 0x7ffff;
+    vq->used_wrap_counter = !!(idx & 0x8000);
+}
+
+static void virtio_queue_split_set_last_avail_idx(VirtIODevice *vdev,
+                                                  int n, unsigned int idx)
+{
+        vdev->vq[n].last_avail_idx = idx;
+        vdev->vq[n].shadow_avail_idx = idx;
+}
+
+void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n,
+                                     unsigned int idx)
+{
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        virtio_queue_packed_set_last_avail_idx(vdev, n, idx);
+    } else {
+        virtio_queue_split_set_last_avail_idx(vdev, n, idx);
+    }
+}
+
+static void virtio_queue_packed_restore_last_avail_idx(VirtIODevice *vdev,
+                                                       int n)
+{
+    /* We don't have a reference like avail idx in shared memory */
+    return;
+}
+
+static void virtio_queue_split_restore_last_avail_idx(VirtIODevice *vdev,
+                                                      int n)
 {
     rcu_read_lock();
     if (vdev->vq[n].vring.desc) {
@@ -2445,7 +3173,22 @@ void virtio_queue_restore_last_avail_idx(VirtIODevice *vdev, int n)
     rcu_read_unlock();
 }
 
-void virtio_queue_update_used_idx(VirtIODevice *vdev, int n)
+void virtio_queue_restore_last_avail_idx(VirtIODevice *vdev, int n)
+{
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        virtio_queue_packed_restore_last_avail_idx(vdev, n);
+    } else {
+        virtio_queue_split_restore_last_avail_idx(vdev, n);
+    }
+}
+
+static void virtio_queue_packed_update_used_idx(VirtIODevice *vdev, int n)
+{
+    /* used idx was updated through set_last_avail_idx() */
+    return;
+}
+
+static void virtio_split_packed_update_used_idx(VirtIODevice *vdev, int n)
 {
     rcu_read_lock();
     if (vdev->vq[n].vring.desc) {
@@ -2454,6 +3197,15 @@ void virtio_queue_update_used_idx(VirtIODevice *vdev, int n)
     rcu_read_unlock();
 }
 
+void virtio_queue_update_used_idx(VirtIODevice *vdev, int n)
+{
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        return virtio_queue_packed_update_used_idx(vdev, n);
+    } else {
+        return virtio_split_packed_update_used_idx(vdev, n);
+    }
+}
+
 void virtio_queue_invalidate_signalled_used(VirtIODevice *vdev, int n)
 {
     vdev->vq[n].signalled_used_valid = false;
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index b189788cb2..226c94078f 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -59,6 +59,8 @@ typedef struct VirtQueue VirtQueue;
 typedef struct VirtQueueElement
 {
     unsigned int index;
+    unsigned int len;
+    unsigned int ndescs;
     unsigned int out_num;
     unsigned int in_num;
     hwaddr *in_addr;
@@ -196,7 +198,8 @@ void virtqueue_map(VirtIODevice *vdev, VirtQueueElement *elem);
 void *virtqueue_pop(VirtQueue *vq, size_t sz);
 unsigned int virtqueue_drop_all(VirtQueue *vq);
 void *qemu_get_virtqueue_element(VirtIODevice *vdev, QEMUFile *f, size_t sz);
-void qemu_put_virtqueue_element(QEMUFile *f, VirtQueueElement *elem);
+void qemu_put_virtqueue_element(VirtIODevice *vdev, QEMUFile *f,
+                                VirtQueueElement *elem);
 int virtqueue_avail_bytes(VirtQueue *vq, unsigned int in_bytes,
                           unsigned int out_bytes);
 void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
@@ -291,8 +294,9 @@ hwaddr virtio_queue_get_used_addr(VirtIODevice *vdev, int n);
 hwaddr virtio_queue_get_desc_size(VirtIODevice *vdev, int n);
 hwaddr virtio_queue_get_avail_size(VirtIODevice *vdev, int n);
 hwaddr virtio_queue_get_used_size(VirtIODevice *vdev, int n);
-uint16_t virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n);
-void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n, uint16_t idx);
+unsigned int virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n);
+void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n,
+                                     unsigned int idx);
 void virtio_queue_restore_last_avail_idx(VirtIODevice *vdev, int n);
 void virtio_queue_invalidate_signalled_used(VirtIODevice *vdev, int n);
 void virtio_queue_update_used_idx(VirtIODevice *vdev, int n);
-- 
2.18.1


