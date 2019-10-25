Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34084CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 08:55:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F25A221D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 08:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/Km9adN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25A221D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNvNR-0002Fz-CU
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 04:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eperezma@redhat.com>) id 1iNv5I-0001JD-PG
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eperezma@redhat.com>) id 1iNv5H-000882-7y
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49971
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eperezma@redhat.com>) id 1iNv5H-00087d-46
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571992594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=62aNHpT8/o+LHRU6l0eEE98VmdRPzP2CfebWQtkrLiU=;
 b=Z/Km9adNrAymQMiN7Gbt4U0NyYnj0FMe60ZYxo+QT4ED43R+3XlifvbYT8EhGdIKEgVmE2
 FfKJDL7l8EsRlqU1iQDj85mVC+l/Ka23JxuhiZkBr40mBwr+H20tABp0YG/j+hg8TE2E9/
 5a+2OHqY8a/o18mB8j6nU8tjjOUaGwo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-NicC1khnNy-lpZTZ5MfPHw-1; Fri, 25 Oct 2019 04:36:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C7A4800D49;
 Fri, 25 Oct 2019 08:36:30 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.36.118.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1273760BE0;
 Fri, 25 Oct 2019 08:36:26 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 6/8] virtio: event suppression support for packed ring
Date: Fri, 25 Oct 2019 10:35:25 +0200
Message-Id: <20191025083527.30803-7-eperezma@redhat.com>
In-Reply-To: <20191025083527.30803-1-eperezma@redhat.com>
References: <20191025083527.30803-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: NicC1khnNy-lpZTZ5MfPHw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-block@nongnu.org, Amit Shah <amit@kernel.org>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Jens Freimann <jfreimann@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jason Wang <jasowang@redhat.com>

This patch implements event suppression through device/driver
area. Please refer virtio specification for more information.

Signed-off-by: Wei Xu <wexu@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
---
 hw/virtio/virtio.c | 142 +++++++++++++++++++++++++++++++++++++++++++++++++=
----
 1 file changed, 133 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index a694b4ab50..828c27de1f 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -240,6 +240,44 @@ static void vring_split_desc_read(VirtIODevice *vdev, =
VRingDesc *desc,
     virtio_tswap16s(vdev, &desc->next);
 }
=20
+static void vring_packed_event_read(VirtIODevice *vdev,
+                                    MemoryRegionCache *cache,
+                                    VRingPackedDescEvent *e)
+{
+    hwaddr off_off =3D offsetof(VRingPackedDescEvent, off_wrap);
+    hwaddr off_flags =3D offsetof(VRingPackedDescEvent, flags);
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
+    hwaddr off =3D offsetof(VRingPackedDescEvent, off_wrap);
+
+    virtio_tswap16s(vdev, &off_wrap);
+    address_space_write_cached(cache, off, &off_wrap, sizeof(off_wrap));
+    address_space_cache_invalidate(cache, off, sizeof(off_wrap));
+}
+
+static void vring_packed_flags_write(VirtIODevice *vdev,
+                                     MemoryRegionCache *cache, uint16_t fl=
ags)
+{
+    hwaddr off =3D offsetof(VRingPackedDescEvent, flags);
+
+    virtio_tswap16s(vdev, &flags);
+    address_space_write_cached(cache, off, &flags, sizeof(flags));
+    address_space_cache_invalidate(cache, off, sizeof(flags));
+}
+
 /* Called within rcu_read_lock().  */
 static VRingMemoryRegionCaches *vring_get_region_caches(struct VirtQueue *=
vq)
 {
@@ -347,14 +385,8 @@ static inline void vring_set_avail_event(VirtQueue *vq=
, uint16_t val)
     address_space_cache_invalidate(&caches->used, pa, sizeof(val));
 }
=20
-void virtio_queue_set_notification(VirtQueue *vq, int enable)
+static void virtio_queue_split_set_notification(VirtQueue *vq, int enable)
 {
-    vq->notification =3D enable;
-
-    if (!vq->vring.desc) {
-        return;
-    }
-
     rcu_read_lock();
     if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
         vring_set_avail_event(vq, vring_avail_idx(vq));
@@ -370,6 +402,51 @@ void virtio_queue_set_notification(VirtQueue *vq, int =
enable)
     rcu_read_unlock();
 }
=20
+static void virtio_queue_packed_set_notification(VirtQueue *vq, int enable=
)
+{
+    uint16_t off_wrap;
+    VRingPackedDescEvent e;
+    VRingMemoryRegionCaches *caches;
+
+    rcu_read_lock();
+    caches  =3D vring_get_region_caches(vq);
+    vring_packed_event_read(vq->vdev, &caches->used, &e);
+
+    if (!enable) {
+        e.flags =3D VRING_PACKED_EVENT_FLAG_DISABLE;
+    } else if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX))=
 {
+        off_wrap =3D vq->shadow_avail_idx | vq->shadow_avail_wrap_counter =
<< 15;
+        vring_packed_off_wrap_write(vq->vdev, &caches->used, off_wrap);
+        /* Make sure off_wrap is wrote before flags */
+        smp_wmb();
+        e.flags =3D VRING_PACKED_EVENT_FLAG_DESC;
+    } else {
+        e.flags =3D VRING_PACKED_EVENT_FLAG_ENABLE;
+    }
+
+    vring_packed_flags_write(vq->vdev, &caches->used, e.flags);
+    if (enable) {
+        /* Expose avail event/used flags before caller checks the avail id=
x. */
+        smp_mb();
+    }
+    rcu_read_unlock();
+}
+
+void virtio_queue_set_notification(VirtQueue *vq, int enable)
+{
+    vq->notification =3D enable;
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
     return vq->vring.avail !=3D 0;
@@ -2287,8 +2364,7 @@ static void virtio_set_isr(VirtIODevice *vdev, int va=
lue)
     }
 }
=20
-/* Called within rcu_read_lock().  */
-static bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq)
+static bool virtio_split_should_notify(VirtIODevice *vdev, VirtQueue *vq)
 {
     uint16_t old, new;
     bool v;
@@ -2311,6 +2387,54 @@ static bool virtio_should_notify(VirtIODevice *vdev,=
 VirtQueue *vq)
     return !v || vring_need_event(vring_get_used_event(vq), new, old);
 }
=20
+static bool vring_packed_need_event(VirtQueue *vq, bool wrap,
+                                    uint16_t off_wrap, uint16_t new,
+                                    uint16_t old)
+{
+    int off =3D off_wrap & ~(1 << 15);
+
+    if (wrap !=3D off_wrap >> 15) {
+        off -=3D vq->vring.num;
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
+    caches =3D vring_get_region_caches(vq);
+    vring_packed_event_read(vdev, &caches->avail, &e);
+
+    old =3D vq->signalled_used;
+    new =3D vq->signalled_used =3D vq->used_idx;
+    v =3D vq->signalled_used_valid;
+    vq->signalled_used_valid =3D true;
+
+    if (e.flags =3D=3D VRING_PACKED_EVENT_FLAG_DISABLE) {
+        return false;
+    } else if (e.flags =3D=3D VRING_PACKED_EVENT_FLAG_ENABLE) {
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
--=20
2.16.5


