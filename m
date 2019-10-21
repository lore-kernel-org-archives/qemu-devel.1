Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B202CA9EB0
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:05:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 579AD20679
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/KdxSDl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 579AD20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMZFa-0005hX-EW
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 11:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iMZE1-00040S-32
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:04:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iMZDz-0007aA-1a
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:04:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60725
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iMZDy-0007Zh-IR
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:03:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571670237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=p/FkbIruihCuB2dCbzP3Kozlt1WA3tFVLFKrWZ6zeT0=;
 b=C/KdxSDlApViV8w4f9+DHP5QrQ0LQoObNjn+JP77pxyZd9XpHoSzDOc5tdpu+S+od/ODn9
 woiLakyzx9+iLaePpTLH93yrnWZkno3GGo1QXtvc0NZ8u3EvclZMESAy+EnJO4Wp9Hk+1w
 DLq9A81NMJXSo3f/KBC24J+pX321QFo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-TebYvb7gPN2qwE8zIdADWg-1; Mon, 21 Oct 2019 11:03:56 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1F31800D41
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 15:03:55 +0000 (UTC)
Received: from localhost (ovpn-116-128.ams2.redhat.com [10.36.116.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD3971001DC2;
 Mon, 21 Oct 2019 15:03:44 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] virtio: drop unused virtio_device_stop_ioeventfd() function
Date: Mon, 21 Oct 2019 16:03:43 +0100
Message-Id: <20191021150343.30742-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: TebYvb7gPN2qwE8zIdADWg-1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

virtio_device_stop_ioeventfd() has not been used since commit
310837de6c1e0badfd736b1b316b1698c53120a7 ("virtio: introduce
grab/release_ioeventfd to fix vhost") in 2016.

Nowadays ioeventfd is stopped implicitly by the virtio transport when
lifecycle events such as the VM pausing or device unplug occur.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/virtio/virtio.h | 1 -
 hw/virtio/virtio.c         | 8 --------
 2 files changed, 9 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 48e8d04ff6..14660ea30a 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -302,7 +302,6 @@ EventNotifier *virtio_queue_get_guest_notifier(VirtQueu=
e *vq);
 void virtio_queue_set_guest_notifier_fd_handler(VirtQueue *vq, bool assign=
,
                                                 bool with_irqfd);
 int virtio_device_start_ioeventfd(VirtIODevice *vdev);
-void virtio_device_stop_ioeventfd(VirtIODevice *vdev);
 int virtio_device_grab_ioeventfd(VirtIODevice *vdev);
 void virtio_device_release_ioeventfd(VirtIODevice *vdev);
 bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev);
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 527df03bfd..05186a531c 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2773,14 +2773,6 @@ static void virtio_device_stop_ioeventfd_impl(VirtIO=
Device *vdev)
     }
 }
=20
-void virtio_device_stop_ioeventfd(VirtIODevice *vdev)
-{
-    BusState *qbus =3D qdev_get_parent_bus(DEVICE(vdev));
-    VirtioBusState *vbus =3D VIRTIO_BUS(qbus);
-
-    virtio_bus_stop_ioeventfd(vbus);
-}
-
 int virtio_device_grab_ioeventfd(VirtIODevice *vdev)
 {
     BusState *qbus =3D qdev_get_parent_bus(DEVICE(vdev));
--=20
2.21.0


