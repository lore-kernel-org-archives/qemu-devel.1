Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A30C4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:08:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F04322084E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AwN7xygv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04322084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6sfu-0006fc-2I
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 04:08:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6se4-0003Zr-H1
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:06:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6se3-00077I-AW
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:06:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37610
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6se3-00076t-6L
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582707978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NjdfC5cPcTj7xCSppU7CRy3um06hUEk/RHvT4NHcJJM=;
 b=AwN7xygvDpzNWObnYOvVFDtcqvtCJYk4HeDwV3VRzzQRDX+39QFa/QRtslmTVRi1Wni0D+
 mOnOJGuclL3yHsUiFD6j53Y8r9Ja9PCP8ZMVbBxBYwZG2KBlb2GJy7poIL2YCm8zcOpZMp
 0gX/w0O8YE1ZqaFZWp8F1PbAP47k710=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-0cMcsbPeMF2BfRRCLZ6jWg-1; Wed, 26 Feb 2020 04:06:16 -0500
X-MC-Unique: 0cMcsbPeMF2BfRRCLZ6jWg-1
Received: by mail-wm1-f72.google.com with SMTP id f9so381566wmb.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 01:06:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yx/d9Pi1yF7zdpvYgnvi6Hx1i6BxcPVN8IeOoA2COOE=;
 b=jrXMsYDR5u/Fj3REWc7WsNVI5v5ngfV24rroE0bhTthKYv3Q6UmVbzGmLfoovc9x7Y
 KnTAdgImQx/LDvgGNkuIvLswUextUhFgD+R+UdXfgsJHmr7CWWcAT1nEg9JWSvPHIm9Y
 1J7ucRsPKcEzE/6keVczqmn09xLwuc4o8tHGnD56nDvuqEkq6xbHPw3Bct9nzHsgZwzf
 AU8KDNIAlZCiWdaflau3L/ci83CwG6mXXF13PLvCiQ7NWHXLs9IH8idpDgvhk0hXuICI
 ZfDPf6sptzCzh4fVJvN15PQ51k0mM2iuh93ZAkyz1FLIDkuyhIjdg4KcyCToLoEtLNgc
 LKfQ==
X-Gm-Message-State: APjAAAXjQgTMn+9qlbNq72PzHV5fezy6QD1RAIA+3Jdu7CSi+5H3romP
 qE4HHNLquINiYjl1p/yjM2QCuOoYFS2LmwOLdXQghpVRtqbDS9qdcrQi2FSUa008TbEZ6ihgGXj
 8+aXHR5laZ/Th9xA=
X-Received: by 2002:a05:6000:1046:: with SMTP id
 c6mr472005wrx.411.1582707975395; 
 Wed, 26 Feb 2020 01:06:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqwcBOPUZwYDu5Z1jlTNJE8V2+fh2gTwcPKC0Dvp/M77eGbLOJnS+la66Co8BhtdPey+grHRPQ==
X-Received: by 2002:a05:6000:1046:: with SMTP id
 c6mr471972wrx.411.1582707975165; 
 Wed, 26 Feb 2020 01:06:15 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 n3sm720576wmc.42.2020.02.26.01.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 01:06:14 -0800 (PST)
Date: Wed, 26 Feb 2020 04:06:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 09/30] vhost-user-blk: delete virtioqueues in unrealize to
 fix memleaks
Message-ID: <20200226090010.708934-10-mst@redhat.com>
References: <20200226090010.708934-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200226090010.708934-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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


