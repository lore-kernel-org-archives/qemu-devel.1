Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E5CC35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:17:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9419F20658
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9op1Aje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9419F20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6bxM-0005v8-Jl
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:17:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6btf-0007Ju-Px
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:13:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6bte-00014e-Jw
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:13:19 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56520
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6bte-00013k-GV
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:13:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582643596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NjdfC5cPcTj7xCSppU7CRy3um06hUEk/RHvT4NHcJJM=;
 b=G9op1Aje6UXyaoN8TH1YIyF8zv9av2w6BgwTCgfCJdmXTFbD1GgrCpLjnJmM3EKLGbaG7c
 4/ZV6+GtIhvV7W1ZSH7LghlzDmfnxkSxAmWW65yLOLD/8FQ+NtYyEosxH2o9K2WbgLJ21l
 V4oTogM05ReIXqU/P275fBgY75ENaeA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-6CU8SYAbNgWIuR3Tsn17MA-1; Tue, 25 Feb 2020 10:13:14 -0500
X-MC-Unique: 6CU8SYAbNgWIuR3Tsn17MA-1
Received: by mail-qt1-f199.google.com with SMTP id u40so15236483qtk.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 07:13:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yx/d9Pi1yF7zdpvYgnvi6Hx1i6BxcPVN8IeOoA2COOE=;
 b=IojKLbM5i+GgyVNkxsD9LN41p2D8TkXfHSoBnmXaPIey1B60BDOvtCyRNpVwjy0Jgb
 8QNP98AoG+bmeQqM7j0rb1V/NgWCCj7jHYN3IRpuW+UXJKRV4Mno9YGxWML6jYgmKCsL
 vTYOx5kKd8zzF+dIrFpLiT4dbL99vkt/0p4d6DuWNPGP4NjdhT+Cq3PPehgBpPtSq6ax
 dkB5ZcPGZaGS5VWwL63lO0fNuxhiZRBUMgf+SguJ+0PG31FXicx8eCPClnS6v+nA0Ung
 RmXMhFu/Xz4t8cDDNfk+8ZzTdR1Rjs5dBq5u9R+kWoFgGjZEzvDZNaNPeHSSgV3qmDPx
 h3qw==
X-Gm-Message-State: APjAAAWc+lwshZUSXnoKyDt/G5tlXlQNbnK2UnhqMBeE8ITh2InOh5mu
 PnSw+F8eBJpc0KqYRh+IgCWjLKVIlRmfPPdNt8GLkd8+omXXgx8NW+vb07YIEt9u1E8Nlve3x1G
 BwAY2LML8AFI/X+s=
X-Received: by 2002:a37:b11:: with SMTP id 17mr2709182qkl.384.1582643594116;
 Tue, 25 Feb 2020 07:13:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqx1Bx8sj51cx6qcGziyMuYuhqzSh00LZNm7YilIUiwjZ2W4paq0tvafub4o2LqgXwOGyPYuTg==
X-Received: by 2002:a37:b11:: with SMTP id 17mr2709161qkl.384.1582643593881;
 Tue, 25 Feb 2020 07:13:13 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 l8sm7499378qtr.36.2020.02.25.07.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 07:13:12 -0800 (PST)
Date: Tue, 25 Feb 2020 10:13:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/32] vhost-user-blk: delete virtioqueues in unrealize to fix
 memleaks
Message-ID: <20200225151210.647797-10-mst@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Pan Nengyuan <pannengyuan@huawei.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

virtio queues forgot to delete in unrealize, and aslo error path in
realize, this patch fix these memleaks, the leak stack is as follow:

Direct leak of 114688 byte(s) in 16 object(s) allocated from:
    #0 0x7f24024fdbf0 in calloc (/lib64/libasan.so.3+0xcabf0)
    #1 0x7f2401642015 in g_malloc0 (/lib64/libglib-2.0.so.0+0x50015)
    #2 0x55ad175a6447 in virtio_add_queue /mnt/sdb/qemu/hw/virtio/virtio.c:=
2327
    #3 0x55ad17570cf9 in vhost_user_blk_device_realize /mnt/sdb/qemu/hw/blo=
ck/vhost-user-blk.c:419
    #4 0x55ad175a3707 in virtio_device_realize /mnt/sdb/qemu/hw/virtio/virt=
io.c:3509
    #5 0x55ad176ad0d1 in device_set_realized /mnt/sdb/qemu/hw/core/qdev.c:8=
76
    #6 0x55ad1781ff9d in property_set_bool /mnt/sdb/qemu/qom/object.c:2080
    #7 0x55ad178245ae in object_property_set_qobject /mnt/sdb/qemu/qom/qom-=
qobject.c:26
    #8 0x55ad17821eb4 in object_property_set_bool /mnt/sdb/qemu/qom/object.=
c:1338
    #9 0x55ad177aeed7 in virtio_pci_realize /mnt/sdb/qemu/hw/virtio/virtio-=
pci.c:1801

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200224041336.30790-2-pannengyuan@huawei.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/block/vhost-user-blk.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index d8c459c575..2eba8b9db0 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -460,6 +460,9 @@ reconnect:
 virtio_err:
     g_free(s->vqs);
     g_free(s->inflight);
+    for (i =3D 0; i < s->num_queues; i++) {
+        virtio_del_queue(vdev, i);
+    }
     virtio_cleanup(vdev);
     vhost_user_cleanup(&s->vhost_user);
 }
@@ -468,6 +471,7 @@ static void vhost_user_blk_device_unrealize(DeviceState=
 *dev, Error **errp)
 {
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
     VHostUserBlk *s =3D VHOST_USER_BLK(dev);
+    int i;
=20
     virtio_set_status(vdev, 0);
     qemu_chr_fe_set_handlers(&s->chardev,  NULL, NULL, NULL,
@@ -476,6 +480,10 @@ static void vhost_user_blk_device_unrealize(DeviceStat=
e *dev, Error **errp)
     vhost_dev_free_inflight(s->inflight);
     g_free(s->vqs);
     g_free(s->inflight);
+
+    for (i =3D 0; i < s->num_queues; i++) {
+        virtio_del_queue(vdev, i);
+    }
     virtio_cleanup(vdev);
     vhost_user_cleanup(&s->vhost_user);
 }
--=20
MST


