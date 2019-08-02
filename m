Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8959CC32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 04:07:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E21F2073D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 04:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E21F2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htOrE-0000V2-Lw
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 00:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50510)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1htOq9-0006N5-9T
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 00:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1htOq7-0001gb-VK
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 00:06:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52882)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1htOq7-0001gH-Nf
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 00:06:47 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 14F8615EF48;
 Fri,  2 Aug 2019 04:06:47 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com
 (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F0501001959;
 Fri,  2 Aug 2019 04:06:41 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com
Date: Fri,  2 Aug 2019 00:06:04 -0400
Message-Id: <20190802040606.22573-5-jasowang@redhat.com>
In-Reply-To: <20190802040606.22573-1-jasowang@redhat.com>
References: <20190802040606.22573-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 02 Aug 2019 04:06:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH V5 4/6] virtio: event suppression support for
 packed ring
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

This patch implements event suppression through device/driver
area. Please refer virtio specification for more information.

Signed-off-by: Wei Xu <wexu@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/virtio/virtio.c | 142 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 133 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 4105fe2448..a70551d26d 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -236,6 +236,44 @@ static void vring_split_desc_read(VirtIODevice *vdev, VRingDesc *desc,
     virtio_tswap16s(vdev, &desc->next);
 }
 
+static void vring_packed_event_read(VirtIODevice *vdev,
+                                    MemoryRegionCache *cache,
+                                    VRingPackedDescEvent *e)
+{
+    hwaddr off_off = offsetof(VRingPackedDescEvent, off_wrap);
+    hwaddr off_flags = offsetof(VRingPackedDescEvent, flags);
+
+    address_space_read_cached(cache, off_flags, &e->flags,
+                              sizeof(e->flags));
+    /* Make sure flags is seen before off_wrap */
+    smp_rmb();
+    address_space_read_cached(cache, off_off, &e->off_wrap,
+                              sizeof(e->off_wrap));
+    virtio_tswap16s(vdev, &e->off_wrap);
+    virtio_tswap16s(vdev, &e->flags);
+}
+
+static void vring_packed_off_wrap_write(VirtIODevice *vdev,
+                                        MemoryRegionCache *cache,
+                                        uint16_t off_wrap)
+{
+    hwaddr off = offsetof(VRingPackedDescEvent, off_wrap);
+
+    virtio_tswap16s(vdev, &off_wrap);
+    address_space_write_cached(cache, off, &off_wrap, sizeof(off_wrap));
+    address_space_cache_invalidate(cache, off, sizeof(off_wrap));
+}
+
+static void vring_packed_flags_write(VirtIODevice *vdev,
+                                     MemoryRegionCache *cache, uint16_t flags)
+{
+    hwaddr off = offsetof(VRingPackedDescEvent, flags);
+
+    virtio_tswap16s(vdev, &flags);
+    address_space_write_cached(cache, off, &flags, sizeof(flags));
+    address_space_cache_invalidate(cache, off, sizeof(flags));
+}
+
 static VRingMemoryRegionCaches *vring_get_region_caches(struct VirtQueue *vq)
 {
     VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
@@ -342,14 +380,8 @@ static inline void vring_set_avail_event(VirtQueue *vq, uint16_t val)
     address_space_cache_invalidate(&caches->used, pa, sizeof(val));
 }
 
-void virtio_queue_set_notification(VirtQueue *vq, int enable)
+static void virtio_queue_split_set_notification(VirtQueue *vq, int enable)
 {
-    vq->notification = enable;
-
-    if (!vq->vring.desc) {
-        return;
-    }
-
     rcu_read_lock();
     if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
         vring_set_avail_event(vq, vring_avail_idx(vq));
@@ -365,6 +397,51 @@ void virtio_queue_set_notification(VirtQueue *vq, int enable)
     rcu_read_unlock();
 }
 
+static void virtio_queue_packed_set_notification(VirtQueue *vq, int enable)
+{
+    uint16_t off_wrap;
+    VRingPackedDescEvent e;
+    VRingMemoryRegionCaches *caches;
+
+    rcu_read_lock();
+    caches  = vring_get_region_caches(vq);
+    vring_packed_event_read(vq->vdev, &caches->used, &e);
+
+    if (!enable) {
+        e.flags = VRING_PACKED_EVENT_FLAG_DISABLE;
+    } else if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
+        off_wrap = vq->shadow_avail_idx | vq->shadow_avail_wrap_counter << 15;
+        vring_packed_off_wrap_write(vq->vdev, &caches->used, off_wrap);
+        /* Make sure off_wrap is wrote before flags */
+        smp_wmb();
+        e.flags = VRING_PACKED_EVENT_FLAG_DESC;
+    } else {
+        e.flags = VRING_PACKED_EVENT_FLAG_ENABLE;
+    }
+
+    vring_packed_flags_write(vq->vdev, &caches->used, e.flags);
+    if (enable) {
+        /* Expose avail event/used flags before caller checks the avail idx. */
+        smp_mb();
+    }
+    rcu_read_unlock();
+}
+
+void virtio_queue_set_notification(VirtQueue *vq, int enable)
+{
+    vq->notification = enable;
+
+    if (!vq->vring.desc) {
+        return;
+    }
+
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+        virtio_queue_packed_set_notification(vq, enable);
+    } else {
+        virtio_queue_split_set_notification(vq, enable);
+    }
+}
+
 int virtio_queue_ready(VirtQueue *vq)
 {
     return vq->vring.avail != 0;
@@ -2286,8 +2363,7 @@ static void virtio_set_isr(VirtIODevice *vdev, int value)
     }
 }
 
-/* Called within rcu_read_lock().  */
-static bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq)
+static bool virtio_split_should_notify(VirtIODevice *vdev, VirtQueue *vq)
 {
     uint16_t old, new;
     bool v;
@@ -2310,6 +2386,54 @@ static bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq)
     return !v || vring_need_event(vring_get_used_event(vq), new, old);
 }
 
+static bool vring_packed_need_event(VirtQueue *vq, bool wrap,
+                                    uint16_t off_wrap, uint16_t new,
+                                    uint16_t old)
+{
+    int off = off_wrap & ~(1 << 15);
+
+    if (wrap != off_wrap >> 15) {
+        off -= vq->vring.num;
+    }
+
+    return vring_need_event(off, new, old);
+}
+
+static bool virtio_packed_should_notify(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VRingPackedDescEvent e;
+    uint16_t old, new;
+    bool v;
+    VRingMemoryRegionCaches *caches;
+
+    caches = vring_get_region_caches(vq);
+    vring_packed_event_read(vdev, &caches->avail, &e);
+
+    old = vq->signalled_used;
+    new = vq->signalled_used = vq->used_idx;
+    v = vq->signalled_used_valid;
+    vq->signalled_used_valid = true;
+
+    if (e.flags == VRING_PACKED_EVENT_FLAG_DISABLE) {
+        return false;
+    } else if (e.flags == VRING_PACKED_EVENT_FLAG_ENABLE) {
+        return true;
+    }
+
+    return !v || vring_packed_need_event(vq, vq->used_wrap_counter,
+                                         e.off_wrap, new, old);
+}
+
+/* Called within rcu_read_lock().  */
+static bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq)
+{
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        return virtio_packed_should_notify(vdev, vq);
+    } else {
+        return virtio_split_should_notify(vdev, vq);
+    }
+}
+
 void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq)
 {
     bool should_notify;
-- 
2.18.1


