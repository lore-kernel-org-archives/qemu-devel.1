Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37513C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:22:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 050AD217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ax+AZiBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050AD217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuWpI-0002la-TV
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 02:22:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37514)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iuWdm-0006Yl-8O
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:10:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iuWdk-0008RW-TX
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:10:58 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38662
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iuWdk-0008QD-Pa
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:10:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579763456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fvu/JejnrpbIYjtd6kH0elorwKES/+22eaULELxAawU=;
 b=ax+AZiBEuc/q8eoWYzgzo15hNIKz9eT41IaQkjz6Nac8wFu3TRNuspyiJvb9OinqTJCOeW
 LJl7fG+WAGGe1hlre9e2nT6bXY6Dw855w/55F0Gsjlxn3kCw6/Yxpqy8NViiMiBh3LIvOo
 i3iikr/xT23FReWa5/hBRR1ecXykHH4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-0SNh41DJNQG5gpU81litbA-1; Thu, 23 Jan 2020 02:10:54 -0500
Received: by mail-wr1-f69.google.com with SMTP id h30so1312318wrh.5
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 23:10:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Pvkfe/62fecBB0WaC+0Ls5admcVzWgltEZR0OGv8pe0=;
 b=RVgaQDKMePtVfljcS8gfLhpIGMothCPQ7PK0ud2FjN0oBCCLBZTr3JcOCA9B4c1NuI
 c7ttWW541nWN6jJ2cdBPnxkRlIS6/P99SBlzz/kBUY6wSoWRFbDAtS40R5QhimlvQpl8
 4Tb3eKHCVhXZUClYCO/gswVcnsonv4H06LtOxkhZaZigkAwtAl/vAptuHIALoOyIE/1v
 CD8qmtztjs7RbGSlSysAOb1YkRSOLvf8BGgcrpMoMKlsjn+NWvj9MOmHD4WvH8HU54Ku
 839XbV7POTPHdrMepUvMuUBG52Y9AprcbhzOukzeXXn5nEDnAKD1hTYrE4fB5xdThxab
 BSyA==
X-Gm-Message-State: APjAAAVdr8TILxSxgW7u09misa3hxLJJH7+/5uhfxC+6a4rtcnAvwyF2
 cY0vDoFbZbLBOxS6aowtIHBMPYR7+wcNBgRZ7Wa4rRf4eijPbwpkN2pua3+WfSt3SroGvcPbU0B
 prD50kjBWwLf7Pnw=
X-Received: by 2002:a5d:46d0:: with SMTP id g16mr15314162wrs.287.1579763453071; 
 Wed, 22 Jan 2020 23:10:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqx57RUb/rDO/ecikoUtDTGTPZJuyiwsSSVYDlvVLrtIIEzXlGrJNHc5a9wgCCLQlsAyy4yjow==
X-Received: by 2002:a5d:46d0:: with SMTP id g16mr15314145wrs.287.1579763452828; 
 Wed, 22 Jan 2020 23:10:52 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 a1sm1481349wmj.40.2020.01.22.23.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 23:10:52 -0800 (PST)
Date: Thu, 23 Jan 2020 02:10:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 14/18] vhost-vsock: delete vqs in vhost_vsock_unrealize to
 avoid memleaks
Message-ID: <20200123070913.626488-15-mst@redhat.com>
References: <20200123070913.626488-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200123070913.626488-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: 0SNh41DJNQG5gpU81litbA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Pan Nengyuan <pannengyuan@huawei.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

Receive/transmit/event vqs forgot to cleanup in vhost_vsock_unrealize. This
patch save receive/transmit vq pointer in realize() and cleanup vqs
through those vq pointers in unrealize(). The leak stack is as follow:

Direct leak of 21504 byte(s) in 3 object(s) allocated from:
  #0 0x7f86a1356970 (/lib64/libasan.so.5+0xef970)  ??:?
  #1 0x7f86a09aa49d (/lib64/libglib-2.0.so.0+0x5249d)  ??:?
  #2 0x5604852f85ca (./x86_64-softmmu/qemu-system-x86_64+0x2c3e5ca)  /mnt/s=
db/qemu/hw/virtio/virtio.c:2333
  #3 0x560485356208 (./x86_64-softmmu/qemu-system-x86_64+0x2c9c208)  /mnt/s=
db/qemu/hw/virtio/vhost-vsock.c:339
  #4 0x560485305a17 (./x86_64-softmmu/qemu-system-x86_64+0x2c4ba17)  /mnt/s=
db/qemu/hw/virtio/virtio.c:3531
  #5 0x5604858e6b65 (./x86_64-softmmu/qemu-system-x86_64+0x322cb65)  /mnt/s=
db/qemu/hw/core/qdev.c:865
  #6 0x5604861e6c41 (./x86_64-softmmu/qemu-system-x86_64+0x3b2cc41)  /mnt/s=
db/qemu/qom/object.c:2102

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Message-Id: <20200115062535.50644-1-pannengyuan@huawei.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-vsock.h |  2 ++
 hw/virtio/vhost-vsock.c         | 12 ++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsoc=
k.h
index d509d67c4a..bc5a988ee5 100644
--- a/include/hw/virtio/vhost-vsock.h
+++ b/include/hw/virtio/vhost-vsock.h
@@ -33,6 +33,8 @@ typedef struct {
     struct vhost_virtqueue vhost_vqs[2];
     struct vhost_dev vhost_dev;
     VirtQueue *event_vq;
+    VirtQueue *recv_vq;
+    VirtQueue *trans_vq;
     QEMUTimer *post_load_timer;
=20
     /*< public >*/
diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index f5744363a8..b6cee479bb 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -335,8 +335,10 @@ static void vhost_vsock_device_realize(DeviceState *de=
v, Error **errp)
                 sizeof(struct virtio_vsock_config));
=20
     /* Receive and transmit queues belong to vhost */
-    virtio_add_queue(vdev, VHOST_VSOCK_QUEUE_SIZE, vhost_vsock_handle_outp=
ut);
-    virtio_add_queue(vdev, VHOST_VSOCK_QUEUE_SIZE, vhost_vsock_handle_outp=
ut);
+    vsock->recv_vq =3D virtio_add_queue(vdev, VHOST_VSOCK_QUEUE_SIZE,
+                                      vhost_vsock_handle_output);
+    vsock->trans_vq =3D virtio_add_queue(vdev, VHOST_VSOCK_QUEUE_SIZE,
+                                       vhost_vsock_handle_output);
=20
     /* The event queue belongs to QEMU */
     vsock->event_vq =3D virtio_add_queue(vdev, VHOST_VSOCK_QUEUE_SIZE,
@@ -363,6 +365,9 @@ static void vhost_vsock_device_realize(DeviceState *dev=
, Error **errp)
 err_vhost_dev:
     vhost_dev_cleanup(&vsock->vhost_dev);
 err_virtio:
+    virtio_delete_queue(vsock->recv_vq);
+    virtio_delete_queue(vsock->trans_vq);
+    virtio_delete_queue(vsock->event_vq);
     virtio_cleanup(vdev);
     close(vhostfd);
     return;
@@ -379,6 +384,9 @@ static void vhost_vsock_device_unrealize(DeviceState *d=
ev, Error **errp)
     vhost_vsock_set_status(vdev, 0);
=20
     vhost_dev_cleanup(&vsock->vhost_dev);
+    virtio_delete_queue(vsock->recv_vq);
+    virtio_delete_queue(vsock->trans_vq);
+    virtio_delete_queue(vsock->event_vq);
     virtio_cleanup(vdev);
 }
=20
--=20
MST


