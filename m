Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE816CA9EB7
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:42:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D95920B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9XkWcLM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D95920B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMW50-0000xc-K1
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iMW36-0007sN-OQ
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:40:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iMW34-0007l6-PU
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:40:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26684
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iMW34-0007kr-MF
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571658029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6f/tIKgyUMsti69c+t3UDCY+24vUC08ZRgUvxe0oXvw=;
 b=e9XkWcLMgAdUsL4Fqy2i0okbz5p0jXmYjG4aPzrOVxKO1vkx2ouMNkYd9JNj/qYEV8xSAb
 F8QOnjyyK/mZbOBAGP2kEc48Ov/m7yqd4wiuGJGlYGa4RePEp00avhU3kE9BKr2JoOvEol
 Ke3qWRyz2wVL9rdHYfCTGLHStcnTOiA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-MeysOhJuNyWE1F9v7j6KvA-1; Mon, 21 Oct 2019 07:40:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 391942B6;
 Mon, 21 Oct 2019 11:40:24 +0000 (UTC)
Received: from localhost (ovpn-116-128.ams2.redhat.com [10.36.116.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 794DE60127;
 Mon, 21 Oct 2019 11:40:18 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] virtio: notify virtqueue via host notifier when available
Date: Mon, 21 Oct 2019 12:40:17 +0100
Message-Id: <20191021114017.26011-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: MeysOhJuNyWE1F9v7j6KvA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
function directly.

This fixes the vhost case although it does add a trip through the
eventfd for the traditional ioeventfd case.  I don't think it's worth
adding a fast path for the traditional ioeventfd case because calling
virtio_queue_notify() is rare when ioeventfd is enabled.

Reported-by: Felipe Franciosi <felipe@nutanix.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
Felipe and Yongji: Only tested with "make check".  Please try
vhost-user-scsi/blk and let us know if it fixes the issue.

 include/hw/virtio/virtio-bus.h | 7 +++++++
 hw/virtio/virtio.c             | 4 +++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bus.=
h
index 38c9399cd4..28ca51cb4c 100644
--- a/include/hw/virtio/virtio-bus.h
+++ b/include/hw/virtio/virtio-bus.h
@@ -139,6 +139,13 @@ static inline VirtIODevice *virtio_bus_get_device(Virt=
ioBusState *bus)
=20
 /* Return whether the proxy allows ioeventfd.  */
 bool virtio_bus_ioeventfd_enabled(VirtioBusState *bus);
+
+/* Return whether ioeventfd has been started. */
+static inline bool virtio_bus_ioeventfd_started(VirtioBusState *bus)
+{
+    return bus->ioeventfd_started;
+}
+
 /* Start the ioeventfd. */
 int virtio_bus_start_ioeventfd(VirtioBusState *bus);
 /* Stop the ioeventfd. */
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 527df03bfd..abdcec00cd 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1567,6 +1567,8 @@ static void virtio_queue_notify_vq(VirtQueue *vq)
=20
 void virtio_queue_notify(VirtIODevice *vdev, int n)
 {
+    BusState *qbus =3D qdev_get_parent_bus(DEVICE(vdev));
+    VirtioBusState *vbus =3D VIRTIO_BUS(qbus);
     VirtQueue *vq =3D &vdev->vq[n];
=20
     if (unlikely(!vq->vring.desc || vdev->broken)) {
@@ -1574,7 +1576,7 @@ void virtio_queue_notify(VirtIODevice *vdev, int n)
     }
=20
     trace_virtio_queue_notify(vdev, vq - vdev->vq, vq);
-    if (vq->handle_aio_output) {
+    if (virtio_bus_ioeventfd_started(vbus)) {
         event_notifier_set(&vq->host_notifier);
     } else if (vq->handle_output) {
         vq->handle_output(vdev, vq);
--=20
2.21.0


