Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581C6C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:05:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21EED20781
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2k66394"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21EED20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJISC-0004TB-Uf
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 11:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jJIKU-0000AY-5y
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jJIKT-0005FW-2P
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:57:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29493
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jJIKS-0005FE-Tp
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585666644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NtNJ5H8JIBmysvGE2yyA792DHd77xM9UtTPllB8vSog=;
 b=h2k66394gcwz3yMQbM+Gn5iP8LqCYuO7cpvcCjGjFuAbKavGt9KiZcRE3dc06luaYKv9/3
 5JKj+SWAOxcat+9CSdDAhHbakK6gGg34iMvMxUNpdLNNp3cCita7cISnYLHpAYexeJe9Xf
 0QZr+lNOoB0c1E4HaV5B3iKXsZrgMEk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-CsxtWD41MvesUr3Rao5l6w-1; Tue, 31 Mar 2020 10:57:22 -0400
X-MC-Unique: CsxtWD41MvesUr3Rao5l6w-1
Received: by mail-wm1-f72.google.com with SMTP id w9so801922wmi.2
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 07:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5kY1maDIkBgF7StU6AeIayvxOoSaIDJsW8zxlcAXMcY=;
 b=DT6OUKC7ck/lMBAxoJatAYcdfU6wNaatfejisNGG6JeOAXcZ0vBMjXjvbICPJvZiaC
 0qkZb9TClpPtF8/h5JHNeVTBH7mxA9mDDTGWUC7/vHXdEvPqtAbW5sXRQ9VQ6tMFxsZi
 N8emNPIDeA+SaIZZHvXI9Jcw2ERzU2F/58d9DX67PAduPete62AXwa78euu0STejbgCm
 l7i8xunzyBwqycCSZp5KSyoHcDcyWzUOPCNwClJiCnL+gQgjhZ2ZqosOeHpoqbNCgYtR
 jUiic0ejOy3wLWzVTqDc29dWaVmNHit+lXca/tJsU7VkYZxwBKBlqdfVbUgGKBOv5kV5
 z0aA==
X-Gm-Message-State: ANhLgQ07I12jW5zMqLToI74bV6CxQvoVQSEKlhmB2RYbVn+M7PArKrMa
 qrtOi1g4Kn07I/P+a8sgfPfUZ2uWvc/aUtFTao444jV6auhOXrFSZ6M0ayLqNrMc4DEdxTvtFhR
 mhBgGnCvUgHnrpVo=
X-Received: by 2002:a1c:6a14:: with SMTP id f20mr4003865wmc.53.1585666641234; 
 Tue, 31 Mar 2020 07:57:21 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvXYs3jOXyoal1+/84Xncq4ecxi43FIB2U3eYPognXbh6eI7KCa0oH5TugXgZfC1Qlkw0PmYg==
X-Received: by 2002:a1c:6a14:: with SMTP id f20mr4003850wmc.53.1585666641071; 
 Tue, 31 Mar 2020 07:57:21 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
 by smtp.gmail.com with ESMTPSA id 61sm28951824wrn.82.2020.03.31.07.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 07:57:20 -0700 (PDT)
Date: Tue, 31 Mar 2020 10:57:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/10] fix vhost_user_blk_watch crash
Message-ID: <20200331145631.135630-9-mst@redhat.com>
References: <20200331145631.135630-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200331145631.135630-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Li Feng <fengli@smartx.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Feng <fengli@smartx.com>

the G_IO_HUP is watched in tcp_chr_connect, and the callback
vhost_user_blk_watch is not needed, because tcp_chr_hup is registered as
callback. And it will close the tcp link.

Signed-off-by: Li Feng <fengli@smartx.com>
Message-Id: <20200323052924.29286-1-fengli@smartx.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-user-blk.h |  1 -
 hw/block/vhost-user-blk.c          | 19 -------------------
 2 files changed, 20 deletions(-)

diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-u=
ser-blk.h
index 05ea0ad183..34ad6f0c0e 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -38,7 +38,6 @@ typedef struct VHostUserBlk {
     VhostUserState vhost_user;
     struct vhost_virtqueue *vhost_vqs;
     VirtQueue **virtqs;
-    guint watch;
     bool connected;
 } VHostUserBlk;
=20
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 12925a47ec..17df5338e7 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -349,18 +349,6 @@ static void vhost_user_blk_disconnect(DeviceState *dev=
)
     vhost_dev_cleanup(&s->dev);
 }
=20
-static gboolean vhost_user_blk_watch(GIOChannel *chan, GIOCondition cond,
-                                     void *opaque)
-{
-    DeviceState *dev =3D opaque;
-    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
-    VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
-
-    qemu_chr_fe_disconnect(&s->chardev);
-
-    return true;
-}
-
 static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
 {
     DeviceState *dev =3D opaque;
@@ -373,15 +361,9 @@ static void vhost_user_blk_event(void *opaque, QEMUChr=
Event event)
             qemu_chr_fe_disconnect(&s->chardev);
             return;
         }
-        s->watch =3D qemu_chr_fe_add_watch(&s->chardev, G_IO_HUP,
-                                         vhost_user_blk_watch, dev);
         break;
     case CHR_EVENT_CLOSED:
         vhost_user_blk_disconnect(dev);
-        if (s->watch) {
-            g_source_remove(s->watch);
-            s->watch =3D 0;
-        }
         break;
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
@@ -428,7 +410,6 @@ static void vhost_user_blk_device_realize(DeviceState *=
dev, Error **errp)
=20
     s->inflight =3D g_new0(struct vhost_inflight, 1);
     s->vhost_vqs =3D g_new0(struct vhost_virtqueue, s->num_queues);
-    s->watch =3D 0;
     s->connected =3D false;
=20
     qemu_chr_fe_set_handlers(&s->chardev,  NULL, NULL, vhost_user_blk_even=
t,
--=20
MST


