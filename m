Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94365C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 06:57:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62A892465B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 06:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a00YQy0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A892465B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu9wm-0004md-1a
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 01:57:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36169)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iu9qQ-0004ho-8y
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:50:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iu9qP-00085N-1Y
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:50:30 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46800
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iu9qO-00084w-UX
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:50:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579675828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EE2u/AAZTtiTF3BR1usKNAN0L1IlKKsiavRWKotl39g=;
 b=a00YQy0sPe87tPByKxbWg6Qz4zUZ3ER7XitwaHt2nkfV9S9oQdBaaTCQD6q7XxMOXC7Rgg
 7G69n91wCvcX1PJer7auGcaQlMKsFmEyNfQeOrfGfRUeCYOaipCveevPRpgQPeHydvsao5
 OwuSb8MvX5CgeAHi3Eq6sBxtJyzI96k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-fDr0b_LXPkyTUz9KSph5xQ-1; Wed, 22 Jan 2020 01:50:26 -0500
Received: by mail-wm1-f71.google.com with SMTP id c4so1662786wmb.8
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 22:50:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uL+2BTDQ25Kv4JEooHriCyXb60bUBMFr6mqaTgyAVpc=;
 b=IoeN2pShs3Xc12Kg/zuousVSOdth7javHS1aqxXorslh+SidnJpW2MpUzpTUXJOBQn
 EqLF7oirCvPl7+R0EVpJZNnx6iCggF+IL3yLZ3V6YzNm/v+wzfDkG9nw/qMZUspA+gKf
 IfX9hCzjvsXhftp8YIz+MpLYBq1RY1tzr0OVexEAyKs998uRjAGMzB9djzOUgAH9Oo+C
 rBd7DSoYJmc6Q4plMKFduAxly8WkXZOlHAaPJ0lcAfV7F1sJJKqsbDEBKNxTmgZ9OSdk
 qO67GL3EnqT0aImiyZcNGjppUuF/mSGxZAn9p8NrCw6gzR0JegE/fuj5jAjmFuvTIj0Z
 JNfw==
X-Gm-Message-State: APjAAAUq48b8Qks9WvU5wPb3tebHTGr66ITkIcb9hSapbzzwiODcd40y
 xI4uPcqm1ISP7Vnj0hp1wgKgphUOsj72fP+LMgKyn4FnunJ3VwuzUE3pCrgHgwxSfp0XqWzZAjo
 df5j1KxCHKeQbnEM=
X-Received: by 2002:a1c:4907:: with SMTP id w7mr1224388wma.106.1579675825464; 
 Tue, 21 Jan 2020 22:50:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqyAaP1PBbLOAwi5mhrMlI7pqx1xUI6cGdHIaBq8j8mNMomrMYaxBKMs4qu8Dd+HEOWOwU7raw==
X-Received: by 2002:a1c:4907:: with SMTP id w7mr1224369wma.106.1579675825298; 
 Tue, 21 Jan 2020 22:50:25 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 s65sm2664747wmf.48.2020.01.21.22.50.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 22:50:24 -0800 (PST)
Date: Wed, 22 Jan 2020 01:50:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 12/17] virtio-scsi: delete vqs in unrealize to avoid memleaks
Message-ID: <20200122064907.512501-13-mst@redhat.com>
References: <20200122064907.512501-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200122064907.512501-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: fDr0b_LXPkyTUz9KSph5xQ-1
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Pan Nengyuan <pannengyuan@huawei.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Euler Robot <euler.robot@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

This patch fix memleaks when attaching/detaching virtio-scsi device, the
memory leak stack is as follow:

Direct leak of 21504 byte(s) in 3 object(s) allocated from:
  #0 0x7f491f2f2970 (/lib64/libasan.so.5+0xef970)  ??:?
  #1 0x7f491e94649d (/lib64/libglib-2.0.so.0+0x5249d)  ??:?
  #2 0x564d0f3919fa (./x86_64-softmmu/qemu-system-x86_64+0x2c3e9fa)  /mnt/s=
db/qemu/hw/virtio/virtio.c:2333
  #3 0x564d0f2eca55 (./x86_64-softmmu/qemu-system-x86_64+0x2b99a55)  /mnt/s=
db/qemu/hw/scsi/virtio-scsi.c:912
  #4 0x564d0f2ece7b (./x86_64-softmmu/qemu-system-x86_64+0x2b99e7b)  /mnt/s=
db/qemu/hw/scsi/virtio-scsi.c:924
  #5 0x564d0f39ee47 (./x86_64-softmmu/qemu-system-x86_64+0x2c4be47)  /mnt/s=
db/qemu/hw/virtio/virtio.c:3531
  #6 0x564d0f980224 (./x86_64-softmmu/qemu-system-x86_64+0x322d224)  /mnt/s=
db/qemu/hw/core/qdev.c:865

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Message-Id: <20200117075547.60864-2-pannengyuan@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/scsi/virtio-scsi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 4bc73a370e..858b3aaccb 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -943,7 +943,13 @@ void virtio_scsi_common_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
     VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
+    int i;
=20
+    virtio_del_queue(vdev, 0);
+    virtio_del_queue(vdev, 1);
+    for (i =3D 0; i < vs->conf.num_queues; i++) {
+        virtio_del_queue(vdev, i + 2);
+    }
     g_free(vs->cmd_vqs);
     virtio_cleanup(vdev);
 }
--=20
MST


