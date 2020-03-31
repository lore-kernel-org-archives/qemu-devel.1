Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7D0C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:02:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1850C20781
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I5WByNhb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1850C20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJIPa-00084e-7N
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 11:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jJIN5-0005FE-L7
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:00:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jJIN4-0007IO-JI
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:00:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40544
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jJIN4-0007I1-EH
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585666806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3OeRqcLUXp1PJx7mcVe0fqJObCbo/Ql8xyOG7ICszLk=;
 b=I5WByNhbMTOvDnIrB2YOyKAWEmUaUGW9LUQdCmUM0BiLuUfVYK4tbb1a4SktLHGqsRuk29
 MLzDWoLgH67fgyxZeO7H24f/hLMYJHkN9JSPTwDIoUCTdIKs9849xRhuhWjNca8P8+ETcL
 /dK117SBr3vIKDFeXGWj3265LibjPSQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-WgDs7YOEMfKYOPBgs17fnA-1; Tue, 31 Mar 2020 10:57:15 -0400
X-MC-Unique: WgDs7YOEMfKYOPBgs17fnA-1
Received: by mail-wr1-f71.google.com with SMTP id e10so13178209wrm.2
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 07:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Gu0oKcpP+vwX8QcmHaw4U7wfdMFOS+p6K77U2kBOCC0=;
 b=jEVNJpIlEOpy8rIkhGrN1anLAYrSIlgD79xIVCd1Tgq4Ngkhn0fQjDxPluy7mgA130
 F2WpisD3JXKfjuSyT3KnAxypJriX/ggdSfm35eA1QrzaDf/G3BfnFhb2n6K6OUqZnn1m
 Q4gLtIOWutqed6d1DaNAQTGVdCXUsUuU6nkaNPUhCR+9qtt4Qj4Onzqkd1D4ydPSS79p
 gueHRXGCwYde9KMXeaZC6r3cyMgX7lWXqiucLIImCXTwLKJzBrpt2MZpegNwIJuGp6im
 ypky4TEad8Sd1lANxVsP0bhTwM/gDyNb4pKLZAp6zu2+hXD1I19ZoV1w5LUpMBRipqku
 QZFw==
X-Gm-Message-State: ANhLgQ3TquyJo5d1+/BNV+LP0F8oHQAOn91JWRzaUH51DpMySBXps4YD
 YVrDxiiG5r7N/bfkdmxEx1o4j01IjqKWOGdIJZfywMl9ZDsCt7zOemZ71QWLnDkMTsXXDd0qZkk
 +V/y9gMqEkeBHaDg=
X-Received: by 2002:a1c:1904:: with SMTP id 4mr3820678wmz.21.1585666634407;
 Tue, 31 Mar 2020 07:57:14 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsEI1lr9oQXddAAT4w6D4ZQUD3u1Wo65vDG8K+QoEx4/euA4+apMmE4RDlFJzdf+BTMIBGz8Q==
X-Received: by 2002:a1c:1904:: with SMTP id 4mr3820660wmz.21.1585666634219;
 Tue, 31 Mar 2020 07:57:14 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
 by smtp.gmail.com with ESMTPSA id i1sm25889977wrq.89.2020.03.31.07.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 07:57:13 -0700 (PDT)
Date: Tue, 31 Mar 2020 10:57:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/10] virtio-blk: delete vqs on the error path in realize()
Message-ID: <20200331145631.135630-6-mst@redhat.com>
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
X-Received-From: 205.139.110.120
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
 Euler Robot <euler.robot@huawei.com>, Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

virtio_vqs forgot to free on the error path in realize(). Fix that.

The asan stack:
Direct leak of 14336 byte(s) in 1 object(s) allocated from:
    #0 0x7f58b93fd970 in __interceptor_calloc (/lib64/libasan.so.5+0xef970)
    #1 0x7f58b858249d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
    #2 0x5562cc627f49 in virtio_add_queue /mnt/sdb/qemu/hw/virtio/virtio.c:=
2413
    #3 0x5562cc4b524a in virtio_blk_device_realize /mnt/sdb/qemu/hw/block/v=
irtio-blk.c:1202
    #4 0x5562cc613050 in virtio_device_realize /mnt/sdb/qemu/hw/virtio/virt=
io.c:3615
    #5 0x5562ccb7a568 in device_set_realized /mnt/sdb/qemu/hw/core/qdev.c:8=
91
    #6 0x5562cd39cd45 in property_set_bool /mnt/sdb/qemu/qom/object.c:2238

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20200328005705.29898-2-pannengyuan@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/block/virtio-blk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 142863a3b2..97ba8a2187 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1204,6 +1204,9 @@ static void virtio_blk_device_realize(DeviceState *de=
v, Error **errp)
     virtio_blk_data_plane_create(vdev, conf, &s->dataplane, &err);
     if (err !=3D NULL) {
         error_propagate(errp, err);
+        for (i =3D 0; i < conf->num_queues; i++) {
+            virtio_del_queue(vdev, i);
+        }
         virtio_cleanup(vdev);
         return;
     }
--=20
MST


