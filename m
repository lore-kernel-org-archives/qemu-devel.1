Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA771C35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:17:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B563B20658
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KoCLNAk2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B563B20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6bxt-0006dP-Tp
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:17:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6btm-0007d9-0o
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:13:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6btk-00016d-Qy
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:13:25 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39469
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6btk-00016K-Me
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582643604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GbXYhzT4HdCqyN2iskP5pyuuGP3IhftOdhWxCQdQeVU=;
 b=KoCLNAk21C1LLpIEYxyUpGeTOFLnXHVc8p38pIWh9LEp/3iQYx7B7buxqR+UNpPaO3PCBh
 gSUAthDQw5jvP6oHDK/bwFRVP8SEm459hJKS802o50cb716WBvYHbzc4sB46jlu0P34VFx
 M85QFDC+HKprgjAvIt76PvuXVqcpuxs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-1pr1NmO4O4yHJ42nByxWhw-1; Tue, 25 Feb 2020 10:13:20 -0500
X-MC-Unique: 1pr1NmO4O4yHJ42nByxWhw-1
Received: by mail-qk1-f198.google.com with SMTP id q123so15343304qkb.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 07:13:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XWpi8uIuYqDgAxSrNx/dNPfjKOUMUQTkfVlQ2qW7D7Y=;
 b=jTAEI3N322Z2O1oHsnrYi9vBQ07q9Eodyg0UekP0NOMlqgZ57tCzSU1fMJsQWJjar7
 mmn+cu+0mXrlBtLoGbexVr/Hxef+A9vABjt5954stoBnbC6kwTSRK42ISPDtEOjZ3V/8
 OIB2wSN/fNbYPsbKx2VGILvAKfoEIGMGIAXs9npQ3J52Ka1XRMO251WDzOMSo9LwAVDi
 wKV6s8RnS3sqjvwuRwRMWI1NA4h2BViBjfRPpA8VKYII6s3wV4xAMirZk4+Y6k5cHShg
 P0ZYF8z4pRpbGjJsiNRHLgdoMw7p3EUVnOR261DnOR7ztUwmqp4RP0lkH/ZAw4SinLUS
 x0aA==
X-Gm-Message-State: APjAAAXPREH2K23o2BZnpBYE1nUdt3r5f6smLNLzre7b5wxHMfV6FEGI
 GfxVjTB5u1f2P3/nhZJsNi3O/4dNdNSWKg29VxgQRpo0A4dMKdN1FpslTLMZOGAlSw3raVObzvi
 sV8o7XKLg50sBbmU=
X-Received: by 2002:a05:6214:1494:: with SMTP id
 bn20mr51323187qvb.43.1582643599414; 
 Tue, 25 Feb 2020 07:13:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqwYrjURwrUF8SqAALIsRsrcflyHpX1TwEyCa35tge0RQnzsgo/Eo2WYpuxXb352YKUszu3SaA==
X-Received: by 2002:a05:6214:1494:: with SMTP id
 bn20mr51323167qvb.43.1582643599203; 
 Tue, 25 Feb 2020 07:13:19 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 c45sm7795604qtd.43.2020.02.25.07.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 07:13:18 -0800 (PST)
Date: Tue, 25 Feb 2020 10:13:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/32] vhost-user-blk: convert to new virtio_delete_queue
Message-ID: <20200225151210.647797-11-mst@redhat.com>
References: <20200225151210.647797-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200225151210.647797-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 qemu-block@nongnu.org, Pan Nengyuan <pannengyuan@huawei.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

use the new virtio_delete_queue function to cleanup.

Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Message-Id: <20200224041336.30790-3-pannengyuan@huawei.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-user-blk.h |  3 ++-
 hw/block/vhost-user-blk.c          | 19 +++++++++++--------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-u=
ser-blk.h
index 108bfadeeb..05ea0ad183 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -36,7 +36,8 @@ typedef struct VHostUserBlk {
     struct vhost_dev dev;
     struct vhost_inflight *inflight;
     VhostUserState vhost_user;
-    struct vhost_virtqueue *vqs;
+    struct vhost_virtqueue *vhost_vqs;
+    VirtQueue **virtqs;
     guint watch;
     bool connected;
 } VHostUserBlk;
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 2eba8b9db0..12925a47ec 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -306,7 +306,7 @@ static int vhost_user_blk_connect(DeviceState *dev)
     s->connected =3D true;
=20
     s->dev.nvqs =3D s->num_queues;
-    s->dev.vqs =3D s->vqs;
+    s->dev.vqs =3D s->vhost_vqs;
     s->dev.vq_index =3D 0;
     s->dev.backend_features =3D 0;
=20
@@ -420,13 +420,14 @@ static void vhost_user_blk_device_realize(DeviceState=
 *dev, Error **errp)
     virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK,
                 sizeof(struct virtio_blk_config));
=20
+    s->virtqs =3D g_new(VirtQueue *, s->num_queues);
     for (i =3D 0; i < s->num_queues; i++) {
-        virtio_add_queue(vdev, s->queue_size,
-                         vhost_user_blk_handle_output);
+        s->virtqs[i] =3D virtio_add_queue(vdev, s->queue_size,
+                                        vhost_user_blk_handle_output);
     }
=20
     s->inflight =3D g_new0(struct vhost_inflight, 1);
-    s->vqs =3D g_new0(struct vhost_virtqueue, s->num_queues);
+    s->vhost_vqs =3D g_new0(struct vhost_virtqueue, s->num_queues);
     s->watch =3D 0;
     s->connected =3D false;
=20
@@ -458,11 +459,12 @@ reconnect:
     return;
=20
 virtio_err:
-    g_free(s->vqs);
+    g_free(s->vhost_vqs);
     g_free(s->inflight);
     for (i =3D 0; i < s->num_queues; i++) {
-        virtio_del_queue(vdev, i);
+        virtio_delete_queue(s->virtqs[i]);
     }
+    g_free(s->virtqs);
     virtio_cleanup(vdev);
     vhost_user_cleanup(&s->vhost_user);
 }
@@ -478,12 +480,13 @@ static void vhost_user_blk_device_unrealize(DeviceSta=
te *dev, Error **errp)
                              NULL, NULL, NULL, false);
     vhost_dev_cleanup(&s->dev);
     vhost_dev_free_inflight(s->inflight);
-    g_free(s->vqs);
+    g_free(s->vhost_vqs);
     g_free(s->inflight);
=20
     for (i =3D 0; i < s->num_queues; i++) {
-        virtio_del_queue(vdev, i);
+        virtio_delete_queue(s->virtqs[i]);
     }
+    g_free(s->virtqs);
     virtio_cleanup(vdev);
     vhost_user_cleanup(&s->vhost_user);
 }
--=20
MST


