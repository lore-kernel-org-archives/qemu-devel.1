Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDEECA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:49:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEFC920659
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0hLkSlX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEFC920659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNhFE-0001QB-8d
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eperezma@redhat.com>) id 1iNghJ-0002Ru-Dm
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eperezma@redhat.com>) id 1iNghH-0001y3-Cl
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:14:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38462
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eperezma@redhat.com>) id 1iNghF-0001wZ-5H
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571937286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nww/FniJPLNWx+uRR3X6O4qY1LasX67m0rwmDB7G99Q=;
 b=U0hLkSlXF0OzsWigRF6kHa/fseRik1N/ohCXC4D7yvS0PKPs2eYYpgU2vVBDvOSgSXNbnX
 qhV0Y71sylKLwdr1GNonozetyM8hgh/yQ0ev71PVFCVUfyXwQcJ68E0jehlnH/2CpnlkFr
 L83nxW2fijWRAsA6HXapRgpKlmNYS0A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-P6BRINxfNwmqHusiVcDBjQ-1; Thu, 24 Oct 2019 13:14:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1DB7100550E;
 Thu, 24 Oct 2019 17:14:43 +0000 (UTC)
Received: from eperezma.remote.csb (ovpn-116-206.ams2.redhat.com
 [10.36.116.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0BC545D70E;
 Thu, 24 Oct 2019 17:14:40 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 5/9] virtio: event suppression support for packed ring
Date: Thu, 24 Oct 2019 19:14:02 +0200
Message-Id: <20191024171406.12504-6-eperezma@redhat.com>
In-Reply-To: <20191024171406.12504-1-eperezma@redhat.com>
References: <20191024171406.12504-1-eperezma@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: P6BRINxfNwmqHusiVcDBjQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
 Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jason Wang <jasowang@redhat.com>

This patch implements event suppression through device/driver
area. Please refer virtio specification for more information.

Signed-off-by: Wei Xu <wexu@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/virtio/virtio.c | 142 +++++++++++++++++++++++++++++++++++++++++++++++++=
----
 1 file changed, 133 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 6e7a034d2a..3cf12a62c0 100644
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
 static VRingMemoryRegionCaches *vring_get_region_caches(struct VirtQueue *=
vq)
 {
     VRingMemoryRegionCaches *caches =3D atomic_rcu_read(&vq->vring.caches)=
;
@@ -346,14 +384,8 @@ static inline void vring_set_avail_event(VirtQueue *vq=
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
@@ -369,6 +401,51 @@ void virtio_queue_set_notification(VirtQueue *vq, int =
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
@@ -2290,8 +2367,7 @@ static void virtio_set_isr(VirtIODevice *vdev, int va=
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
@@ -2314,6 +2390,54 @@ static bool virtio_should_notify(VirtIODevice *vdev,=
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


