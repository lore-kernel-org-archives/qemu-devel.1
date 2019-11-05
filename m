Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D844C17460
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 14:10:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 392F721882
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 14:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ATfHv0ZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 392F721882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRzXe-0000fr-FI
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 09:10:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iRzWz-00008a-Re
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 09:10:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iRzWx-0008Mg-AQ
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 09:10:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39677
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iRzWx-0008MO-6f
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 09:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572962998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PPk5PU/MXJtWhLIacHYViiR+P8CJ0g8IEgAqzENJaGc=;
 b=ATfHv0ZN1XTK14vT+MlwRriOrjeNpy3HaGXCttjtTcrbvGUY6HJbLdTrIQ9IHdn853rmOU
 xUj4edKO/SiHnaCO4JHZ3b6HEG6SyCZnA3rlljE8GiO1dgG42Frj81lJrORRPD92ApwdRk
 jIT8sWwjc+XSWS2PKAMB6NjEenlM5BM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-RCbRuumqPwuyiM-Sn37ZhA-1; Tue, 05 Nov 2019 09:09:55 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20AE98017DE;
 Tue,  5 Nov 2019 14:09:54 +0000 (UTC)
Received: from localhost (ovpn-116-232.ams2.redhat.com [10.36.116.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B60AC5D70D;
 Tue,  5 Nov 2019 14:09:47 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] virtio: notify virtqueue via host notifier when available
Date: Tue,  5 Nov 2019 15:09:46 +0100
Message-Id: <20191105140946.165584-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: RCbRuumqPwuyiM-Sn37ZhA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Yongji Xie <elohimes@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, felipe@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Host notifiers are used in several cases:
1. Traditional ioeventfd where virtqueue notifications are handled in
   the main loop thread.
2. IOThreads (aio_handle_output) where virtqueue notifications are
   handled in an IOThread AioContext.
3. vhost where virtqueue notifications are handled by kernel vhost or
   a vhost-user device backend.

Most virtqueue notifications from the guest use the ioeventfd mechanism,
but there are corner cases where QEMU code calls virtio_queue_notify().
This currently honors the host notifier for the IOThreads
aio_handle_output case, but not for the vhost case.  The result is that
vhost does not receive virtqueue notifications from QEMU when
virtio_queue_notify() is called.

This patch extends virtio_queue_notify() to set the host notifier
whenever it is enabled instead of calling the vq->(aio_)handle_output()
function directly.  We track the host notifier state for each virtqueue
separately since some devices may use it only for certain virtqueues.

This fixes the vhost case although it does add a trip through the
eventfd for the traditional ioeventfd case.  I don't think it's worth
adding a fast path for the traditional ioeventfd case because calling
virtio_queue_notify() is rare when ioeventfd is enabled.

Reported-by: Felipe Franciosi <felipe@nutanix.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v2:
 * Track host notifier enabled/disabled state per virtqueue [Yongji Xie]
 * Tested with contrib/vhost-user-blk and contrib/vhost-user-scsi

 hw/virtio/virtio-bus.c     | 4 ++++
 hw/virtio/virtio.c         | 9 ++++++++-
 include/hw/virtio/virtio.h | 1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index b2c804292e..d6332d45c3 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -288,6 +288,10 @@ int virtio_bus_set_host_notifier(VirtioBusState *bus, =
int n, bool assign)
         k->ioeventfd_assign(proxy, notifier, n, false);
     }
=20
+    if (r =3D=3D 0) {
+        virtio_queue_set_host_notifier_enabled(vq, assign);
+    }
+
     return r;
 }
=20
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 762df12f4c..04716b5f6c 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -128,6 +128,7 @@ struct VirtQueue
     VirtIODevice *vdev;
     EventNotifier guest_notifier;
     EventNotifier host_notifier;
+    bool host_notifier_enabled;
     QLIST_ENTRY(VirtQueue) node;
 };
=20
@@ -2271,7 +2272,7 @@ void virtio_queue_notify(VirtIODevice *vdev, int n)
     }
=20
     trace_virtio_queue_notify(vdev, vq - vdev->vq, vq);
-    if (vq->handle_aio_output) {
+    if (vq->host_notifier_enabled) {
         event_notifier_set(&vq->host_notifier);
     } else if (vq->handle_output) {
         vq->handle_output(vdev, vq);
@@ -3145,6 +3146,7 @@ void virtio_init(VirtIODevice *vdev, const char *name=
,
         vdev->vq[i].vector =3D VIRTIO_NO_VECTOR;
         vdev->vq[i].vdev =3D vdev;
         vdev->vq[i].queue_index =3D i;
+        vdev->vq[i].host_notifier_enabled =3D false;
     }
=20
     vdev->name =3D name;
@@ -3436,6 +3438,11 @@ EventNotifier *virtio_queue_get_host_notifier(VirtQu=
eue *vq)
     return &vq->host_notifier;
 }
=20
+void virtio_queue_set_host_notifier_enabled(VirtQueue *vq, bool enabled)
+{
+    vq->host_notifier_enabled =3D enabled;
+}
+
 int virtio_queue_set_host_notifier_mr(VirtIODevice *vdev, int n,
                                       MemoryRegion *mr, bool assign)
 {
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 3448d67d2a..c32a815303 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -312,6 +312,7 @@ int virtio_device_grab_ioeventfd(VirtIODevice *vdev);
 void virtio_device_release_ioeventfd(VirtIODevice *vdev);
 bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev);
 EventNotifier *virtio_queue_get_host_notifier(VirtQueue *vq);
+void virtio_queue_set_host_notifier_enabled(VirtQueue *vq, bool enabled);
 void virtio_queue_host_notifier_read(EventNotifier *n);
 void virtio_queue_aio_set_host_notifier_handler(VirtQueue *vq, AioContext =
*ctx,
                                                 VirtIOHandleAIOOutput hand=
le_output);
--=20
2.23.0


