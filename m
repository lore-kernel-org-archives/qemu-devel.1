Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E182BC35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:14:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA37B21744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XE6cTToW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA37B21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6buM-0000AQ-S7
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:14:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6btP-0006os-F8
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:13:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6btN-0000ym-Fz
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:13:03 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24519
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6btN-0000yY-BK
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:13:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582643580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/3tpoO/b13qxGCdroClG2tHi1hZJUztPTgTRGVuyGg8=;
 b=XE6cTToWJoVLaM3oodPc0FHJQ5Kmp+4h8fuzPm8/wtsws6AsBJM+wDw6SPxq5kHGaSTE2F
 WAsJQBb0li67RTRpYFtzvuFGkAWtZnrPPl60dbZvS9vwkS3HIUW/YApetdRWy3cdfMlANg
 6vWg2TjJ9aR0ab9rJIqtcJRmmLBPA1g=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-N6RZ8Zu0M86-2MnNT-2DUQ-1; Tue, 25 Feb 2020 10:12:54 -0500
X-MC-Unique: N6RZ8Zu0M86-2MnNT-2DUQ-1
Received: by mail-qk1-f200.google.com with SMTP id 200so4935476qkd.10
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 07:12:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PoUqLzU6INu2jZoEzWyNAufvBtw3qPKPkJ42k8ZdQek=;
 b=ANJ6sOTOrlRxoHE2ZCFdKxBtiIvwkCkCXcn81SJd6X3ynC0O5ns5Lw2nKHJAQVGFEp
 tAHkSBVaocPERZyquCQcT4PvdwNwuZB5bdnYg2pCQXvEvisWZY/DrnV7SrYKrzdVEmnm
 vZAKRrZH+TH+nHbA64AVjyVCKEtCHwWXfjWVe7vu/Ec/9yN27Or0IYWtNykJhP970xsl
 JxsUVEsXkPUP6w3u3m3EjIqjD3brUMFn3WKC8wGLWUYT8MTe9zGNT3pTcQUcxDBn11DZ
 WLAEGrhzpfWHh0KzfkwFYjL87nPtqcJ16bUJEg1V6EQSCscxjdQM0qVvMROQ8b6ckk+U
 lPsw==
X-Gm-Message-State: APjAAAXMwp2rXOIZV7PVRKEtCMN/Jkeng/4urc88IN7oBHC4yM2Xrl1g
 btFnKml+No4JsXdRadA3AUxo6A5DDcRFqG0PGwqem9PqC3VBr+zoIYCPj0aTPASIdzEtZPNnEsQ
 XOuU2kyLbIfMHqxo=
X-Received: by 2002:ad4:4d85:: with SMTP id cv5mr48754282qvb.171.1582643573751; 
 Tue, 25 Feb 2020 07:12:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqxxFCkYQdlA0Gwlr5wFpJb46HqO1ifLXXGsI1a80XgmhC9nTI8seSb2ggKG+Q6O9xd3obe/Mg==
X-Received: by 2002:ad4:4d85:: with SMTP id cv5mr48754269qvb.171.1582643573539; 
 Tue, 25 Feb 2020 07:12:53 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 b10sm1762359qtp.83.2020.02.25.07.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 07:12:52 -0800 (PST)
Date: Tue, 25 Feb 2020 10:12:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/32] vhost-user-fs: do delete virtio_queues in unrealize
Message-ID: <20200225151210.647797-6-mst@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pan Nengyuan <pannengyuan@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

Similar to other virtio device(https://patchwork.kernel.org/patch/11399237/=
), virtio queues forgot to delete in unrealize, and aslo error path in real=
ize, this patch fix these memleaks, the leak stack is as follow:
Direct leak of 57344 byte(s) in 1 object(s) allocated from:
    #0 0x7f15784fb970 in __interceptor_calloc (/lib64/libasan.so.5+0xef970)
    #1 0x7f157790849d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
    #2 0x55587a1bf859 in virtio_add_queue /mnt/sdb/qemu-new/qemu_test/qemu/=
hw/virtio/virtio.c:2333
    #3 0x55587a2071d5 in vuf_device_realize /mnt/sdb/qemu-new/qemu_test/qem=
u/hw/virtio/vhost-user-fs.c:212
    #4 0x55587a1ae360 in virtio_device_realize /mnt/sdb/qemu-new/qemu_test/=
qemu/hw/virtio/virtio.c:3531
    #5 0x55587a63fb7b in device_set_realized /mnt/sdb/qemu-new/qemu_test/qe=
mu/hw/core/qdev.c:891
    #6 0x55587acf03f5 in property_set_bool /mnt/sdb/qemu-new/qemu_test/qemu=
/qom/object.c:2238
    #7 0x55587acfce0d in object_property_set_qobject /mnt/sdb/qemu-new/qemu=
_test/qemu/qom/qom-qobject.c:26
    #8 0x55587acf5c8c in object_property_set_bool /mnt/sdb/qemu-new/qemu_te=
st/qemu/qom/object.c:1390
    #9 0x55587a8e22a2 in pci_qdev_realize /mnt/sdb/qemu-new/qemu_test/qemu/=
hw/pci/pci.c:2095
    #10 0x55587a63fb7b in device_set_realized /mnt/sdb/qemu-new/qemu_test/q=
emu/hw/core/qdev.c:891
    #11 0x55587acf03f5 in property_set_bool /mnt/sdb/qemu-new/qemu_test/qem=
u/qom/object.c:2238
    #12 0x55587acfce0d in object_property_set_qobject /mnt/sdb/qemu-new/qem=
u_test/qemu/qom/qom-qobject.c:26
    #13 0x55587acf5c8c in object_property_set_bool /mnt/sdb/qemu-new/qemu_t=
est/qemu/qom/object.c:1390
    #14 0x55587a496d65 in qdev_device_add /mnt/sdb/qemu-new/qemu_test/qemu/=
qdev-monitor.c:679

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200225075554.10835-2-pannengyuan@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user-fs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index 33b17848c2..4554d123b7 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -230,6 +230,10 @@ static void vuf_device_realize(DeviceState *dev, Error=
 **errp)
=20
 err_virtio:
     vhost_user_cleanup(&fs->vhost_user);
+    virtio_del_queue(vdev, 0);
+    for (i =3D 0; i < fs->conf.num_request_queues; i++) {
+        virtio_del_queue(vdev, i + 1);
+    }
     virtio_cleanup(vdev);
     g_free(fs->vhost_dev.vqs);
     return;
@@ -239,6 +243,7 @@ static void vuf_device_unrealize(DeviceState *dev, Erro=
r **errp)
 {
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
     VHostUserFS *fs =3D VHOST_USER_FS(dev);
+    int i;
=20
     /* This will stop vhost backend if appropriate. */
     vuf_set_status(vdev, 0);
@@ -247,6 +252,10 @@ static void vuf_device_unrealize(DeviceState *dev, Err=
or **errp)
=20
     vhost_user_cleanup(&fs->vhost_user);
=20
+    virtio_del_queue(vdev, 0);
+    for (i =3D 0; i < fs->conf.num_request_queues; i++) {
+        virtio_del_queue(vdev, i + 1);
+    }
     virtio_cleanup(vdev);
     g_free(fs->vhost_dev.vqs);
     fs->vhost_dev.vqs =3D NULL;
--=20
MST


