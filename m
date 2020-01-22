Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37493C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 06:02:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F145624656
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 06:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jh9wcscv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F145624656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37147 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu95b-0002Et-K1
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 01:02:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iu8wF-0007vX-Im
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:52:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iu8wE-0004ix-Gd
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:52:27 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46348
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iu8wE-0004in-Cl
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:52:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579672346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EE2u/AAZTtiTF3BR1usKNAN0L1IlKKsiavRWKotl39g=;
 b=Jh9wcscvMOCco77tVRRwaqf+CAJtZNunEF/EJ18M0+c7J5bn1iUE2Lhnlg9h2hEzaUj6Ty
 ZOyDWtx85cYW/LCeBCK/a4apjDY50IHpbVPSL+IBwDWn2bZ4Ezg4dtY0c/Njfmhv5SBUcq
 3+N3MzGGcm4ep8lFODarVj4tYCdgX1M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-FvcvQntGOniG-HOaSYDZjQ-1; Wed, 22 Jan 2020 00:52:24 -0500
Received: by mail-wr1-f70.google.com with SMTP id u12so2541929wrt.15
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 21:52:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uL+2BTDQ25Kv4JEooHriCyXb60bUBMFr6mqaTgyAVpc=;
 b=J60fBRIajnhHqyNv1nx2Ju6ZAN1q+4hQTFSk/nqE7+ozBSXjIIIlye5Ds8D/hM/L16
 vhEl95FJXYOU8W3AIsH5KjiZ3tdQKc6a9V9QSoZLvPGyZHJmWFwzXA4NRG1xIaqDey82
 TlleIXhrryJ0B3otTOB4IsovdVw+uGevKCK3ZMT4GP4+UkcDmZRy9aHjlW3IqlpuWgXC
 AMeF4ZBKXOzRb8tOzMn5FjPtOm9RcsrBT9Yg2QXeURmGRkFWi9Abx8KkqRzlKIueLSzk
 I04thzUj2N97YfwAkQdujyUxKTzv8uS28MpDZ2QqxRmaRb4srkYJfy216VFnjYMKbiAq
 ADpQ==
X-Gm-Message-State: APjAAAX7ZTAJ22AAhomHXniQyFVbzOwkDd9HbNZXneColSF2+4sA1WWF
 Dkdwx6D6S/AsD8FoxgwhPa+9of162ZTOvC9m7pUa8khrAKsOYHIjElhpEAZvPa/QtraSyEZ5SDO
 t/z9BcrK94IZQLoQ=
X-Received: by 2002:a7b:c74c:: with SMTP id w12mr905089wmk.1.1579672342726;
 Tue, 21 Jan 2020 21:52:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqxXd8z0wSVBm185mKPiPe+D2urgW8/geaBtaVp6C9432XWeIibNjidZNCEZTgNHcLiNPKz4Xg==
X-Received: by 2002:a7b:c74c:: with SMTP id w12mr905071wmk.1.1579672342588;
 Tue, 21 Jan 2020 21:52:22 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 f1sm2282591wmc.45.2020.01.21.21.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 21:52:22 -0800 (PST)
Date: Wed, 22 Jan 2020 00:52:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/17] virtio-scsi: delete vqs in unrealize to avoid memleaks
Message-ID: <20200122055115.429945-13-mst@redhat.com>
References: <20200122055115.429945-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200122055115.429945-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: FvcvQntGOniG-HOaSYDZjQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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


