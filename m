Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB69CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 17:29:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4D8620862
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 17:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EaUtPq/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D8620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP8pB-0003yn-KO
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 13:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iP7c4-0002eE-JS
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:11:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iP7c2-00006r-1C
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:11:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25593
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iP7c1-00006g-Na
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572279081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Hnj0hIqd9X1h5X9SAoMPg6K5+65BLNbNQsJXZQt1qNU=;
 b=EaUtPq/gAxldzqdP/KzvwFb2nMfqkvSh9W3a0A01zu+GdtulbWIqMjJ+9QQYGPykDx+6pn
 BLAeuTlSrALvAhT6qq0wjNixIx6M8iYanRGAElAqbAcFFsFK8pi9DMdzBzWzKVB/3Xs5ve
 OEicpDNzpghmGE0oy5WxF5IP9kBQMGk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-iZfK7TG9M4uO7pOAvCApZw-1; Mon, 28 Oct 2019 12:11:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11E7A180496F
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 16:11:19 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-216.ams2.redhat.com
 [10.36.116.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD66A600C9;
 Mon, 28 Oct 2019 16:11:12 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com
Subject: [PATCH v2] virtio: Use auto rcu_read macros
Date: Mon, 28 Oct 2019 16:11:09 +0000
Message-Id: <20191028161109.60205-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: iZfK7TG9M4uO7pOAvCApZw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Use RCU_READ_LOCK_GUARD and WITH_RCU_READ_LOCK_GUARD
to replace the manual rcu_read_(un)lock calls.

I think the only change is virtio_load which was missing unlocks
in error paths; those end up being fatal errors so it's not
that important anyway.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/virtio.c | 65 ++++++++++++++++------------------------------
 1 file changed, 23 insertions(+), 42 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 2e91dec567..7cb67702d0 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -387,7 +387,8 @@ static inline void vring_set_avail_event(VirtQueue *vq,=
 uint16_t val)
=20
 static void virtio_queue_split_set_notification(VirtQueue *vq, int enable)
 {
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
+
     if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
         vring_set_avail_event(vq, vring_avail_idx(vq));
     } else if (enable) {
@@ -399,7 +400,6 @@ static void virtio_queue_split_set_notification(VirtQue=
ue *vq, int enable)
         /* Expose avail event/used flags before caller checks the avail id=
x. */
         smp_mb();
     }
-    rcu_read_unlock();
 }
=20
 static void virtio_queue_packed_set_notification(VirtQueue *vq, int enable=
)
@@ -408,7 +408,7 @@ static void virtio_queue_packed_set_notification(VirtQu=
eue *vq, int enable)
     VRingPackedDescEvent e;
     VRingMemoryRegionCaches *caches;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     caches  =3D vring_get_region_caches(vq);
     vring_packed_event_read(vq->vdev, &caches->used, &e);
=20
@@ -429,7 +429,6 @@ static void virtio_queue_packed_set_notification(VirtQu=
eue *vq, int enable)
         /* Expose avail event/used flags before caller checks the avail id=
x. */
         smp_mb();
     }
-    rcu_read_unlock();
 }
=20
 void virtio_queue_set_notification(VirtQueue *vq, int enable)
@@ -577,9 +576,8 @@ static int virtio_queue_split_empty(VirtQueue *vq)
         return 0;
     }
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     empty =3D vring_avail_idx(vq) =3D=3D vq->last_avail_idx;
-    rcu_read_unlock();
     return empty;
 }
=20
@@ -601,12 +599,8 @@ static int virtio_queue_packed_empty_rcu(VirtQueue *vq=
)
=20
 static int virtio_queue_packed_empty(VirtQueue *vq)
 {
-    bool empty;
-
-    rcu_read_lock();
-    empty =3D virtio_queue_packed_empty_rcu(vq);
-    rcu_read_unlock();
-    return empty;
+    RCU_READ_LOCK_GUARD();
+    return virtio_queue_packed_empty_rcu(vq);
 }
=20
 int virtio_queue_empty(VirtQueue *vq)
@@ -859,10 +853,9 @@ void virtqueue_flush(VirtQueue *vq, unsigned int count=
)
 void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
                     unsigned int len)
 {
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     virtqueue_fill(vq, elem, len, 0);
     virtqueue_flush(vq, 1);
-    rcu_read_unlock();
 }
=20
 /* Called within rcu_read_lock().  */
@@ -943,7 +936,8 @@ static void virtqueue_split_get_avail_bytes(VirtQueue *=
vq,
     int64_t len =3D 0;
     int rc;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
+
     idx =3D vq->last_avail_idx;
     total_bufs =3D in_total =3D out_total =3D 0;
=20
@@ -1033,7 +1027,6 @@ done:
     if (out_bytes) {
         *out_bytes =3D out_total;
     }
-    rcu_read_unlock();
     return;
=20
 err:
@@ -1083,7 +1076,7 @@ static void virtqueue_packed_get_avail_bytes(VirtQueu=
e *vq,
     VRingPackedDesc desc;
     bool wrap_counter;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     idx =3D vq->last_avail_idx;
     wrap_counter =3D vq->last_avail_wrap_counter;
     total_bufs =3D in_total =3D out_total =3D 0;
@@ -1176,7 +1169,6 @@ done:
     if (out_bytes) {
         *out_bytes =3D out_total;
     }
-    rcu_read_unlock();
     return;
=20
 err:
@@ -1360,7 +1352,7 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_=
t sz)
     VRingDesc desc;
     int rc;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     if (virtio_queue_empty_rcu(vq)) {
         goto done;
     }
@@ -1469,7 +1461,6 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_=
t sz)
     trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
 done:
     address_space_cache_destroy(&indirect_desc_cache);
-    rcu_read_unlock();
=20
     return elem;
=20
@@ -1494,7 +1485,7 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size=
_t sz)
     uint16_t id;
     int rc;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     if (virtio_queue_packed_empty_rcu(vq)) {
         goto done;
     }
@@ -1600,7 +1591,6 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size=
_t sz)
     trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
 done:
     address_space_cache_destroy(&indirect_desc_cache);
-    rcu_read_unlock();
=20
     return elem;
=20
@@ -2437,13 +2427,10 @@ static bool virtio_should_notify(VirtIODevice *vdev=
, VirtQueue *vq)
=20
 void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq)
 {
-    bool should_notify;
-    rcu_read_lock();
-    should_notify =3D virtio_should_notify(vdev, vq);
-    rcu_read_unlock();
-
-    if (!should_notify) {
-        return;
+    WITH_RCU_READ_LOCK_GUARD() {
+        if (!virtio_should_notify(vdev, vq)) {
+            return;
+        }
     }
=20
     trace_virtio_notify_irqfd(vdev, vq);
@@ -2475,13 +2462,10 @@ static void virtio_irq(VirtQueue *vq)
=20
 void virtio_notify(VirtIODevice *vdev, VirtQueue *vq)
 {
-    bool should_notify;
-    rcu_read_lock();
-    should_notify =3D virtio_should_notify(vdev, vq);
-    rcu_read_unlock();
-
-    if (!should_notify) {
-        return;
+    WITH_RCU_READ_LOCK_GUARD() {
+        if (!virtio_should_notify(vdev, vq)) {
+            return;
+        }
     }
=20
     trace_virtio_notify(vdev, vq);
@@ -3032,7 +3016,7 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int =
version_id)
         vdev->start_on_kick =3D true;
     }
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     for (i =3D 0; i < num; i++) {
         if (vdev->vq[i].vring.desc) {
             uint16_t nheads;
@@ -3087,7 +3071,6 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int =
version_id)
             }
         }
     }
-    rcu_read_unlock();
=20
     return 0;
 }
@@ -3290,12 +3273,11 @@ static void virtio_queue_packed_restore_last_avail_=
idx(VirtIODevice *vdev,
 static void virtio_queue_split_restore_last_avail_idx(VirtIODevice *vdev,
                                                       int n)
 {
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     if (vdev->vq[n].vring.desc) {
         vdev->vq[n].last_avail_idx =3D vring_used_idx(&vdev->vq[n]);
         vdev->vq[n].shadow_avail_idx =3D vdev->vq[n].last_avail_idx;
     }
-    rcu_read_unlock();
 }
=20
 void virtio_queue_restore_last_avail_idx(VirtIODevice *vdev, int n)
@@ -3315,11 +3297,10 @@ static void virtio_queue_packed_update_used_idx(Vir=
tIODevice *vdev, int n)
=20
 static void virtio_split_packed_update_used_idx(VirtIODevice *vdev, int n)
 {
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     if (vdev->vq[n].vring.desc) {
         vdev->vq[n].used_idx =3D vring_used_idx(&vdev->vq[n]);
     }
-    rcu_read_unlock();
 }
=20
 void virtio_queue_update_used_idx(VirtIODevice *vdev, int n)
--=20
2.23.0


