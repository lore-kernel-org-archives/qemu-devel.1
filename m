Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60554C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:56:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C70220873
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C70220873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK4Zh-00014b-DB
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iK4YW-0008R8-Sq
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 13:54:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iK4YU-0006ct-B7
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 13:54:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51074)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iK4YU-0006cW-3D
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 13:54:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BC8D610CC203
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 17:54:48 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1FF72608C2;
 Mon, 14 Oct 2019 17:54:42 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com
Subject: [PATCH] virito: Use auto rcu_read macros
Date: Mon, 14 Oct 2019 18:54:40 +0100
Message-Id: <20191014175440.152609-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Mon, 14 Oct 2019 17:54:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: stefanha@redhat.com
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
 hw/virtio/virtio.c | 46 ++++++++++++++++------------------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 527df03bfd..15ae9da60b 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -337,7 +337,7 @@ void virtio_queue_set_notification(VirtQueue *vq, int=
 enable)
         return;
     }
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
         vring_set_avail_event(vq, vring_avail_idx(vq));
     } else if (enable) {
@@ -349,7 +349,6 @@ void virtio_queue_set_notification(VirtQueue *vq, int=
 enable)
         /* Expose avail event/used flags before caller checks the avail =
idx. */
         smp_mb();
     }
-    rcu_read_unlock();
 }
=20
 int virtio_queue_ready(VirtQueue *vq)
@@ -393,9 +392,8 @@ int virtio_queue_empty(VirtQueue *vq)
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
@@ -530,10 +528,9 @@ void virtqueue_flush(VirtQueue *vq, unsigned int cou=
nt)
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
@@ -624,7 +621,7 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigne=
d int *in_bytes,
         return;
     }
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     idx =3D vq->last_avail_idx;
     total_bufs =3D in_total =3D out_total =3D 0;
=20
@@ -719,7 +716,6 @@ done:
     if (out_bytes) {
         *out_bytes =3D out_total;
     }
-    rcu_read_unlock();
     return;
=20
 err:
@@ -869,7 +865,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     if (unlikely(vdev->broken)) {
         return NULL;
     }
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     if (virtio_queue_empty_rcu(vq)) {
         goto done;
     }
@@ -977,7 +973,6 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
 done:
     address_space_cache_destroy(&indirect_desc_cache);
-    rcu_read_unlock();
=20
     return elem;
=20
@@ -1680,13 +1675,10 @@ static bool virtio_should_notify(VirtIODevice *vd=
ev, VirtQueue *vq)
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
@@ -1718,13 +1710,10 @@ static void virtio_irq(VirtQueue *vq)
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
@@ -2241,7 +2230,7 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, in=
t version_id)
         vdev->start_on_kick =3D true;
     }
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     for (i =3D 0; i < num; i++) {
         if (vdev->vq[i].vring.desc) {
             uint16_t nheads;
@@ -2289,7 +2278,6 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, in=
t version_id)
             }
         }
     }
-    rcu_read_unlock();
=20
     return 0;
 }
@@ -2422,21 +2410,19 @@ void virtio_queue_set_last_avail_idx(VirtIODevice=
 *vdev, int n, uint16_t idx)
=20
 void virtio_queue_restore_last_avail_idx(VirtIODevice *vdev, int n)
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
 void virtio_queue_update_used_idx(VirtIODevice *vdev, int n)
 {
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     if (vdev->vq[n].vring.desc) {
         vdev->vq[n].used_idx =3D vring_used_idx(&vdev->vq[n]);
     }
-    rcu_read_unlock();
 }
=20
 void virtio_queue_invalidate_signalled_used(VirtIODevice *vdev, int n)
--=20
2.23.0


