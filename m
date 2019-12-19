Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CBBC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B7712082E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eFW9v1VN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7712082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvrD-0002Lw-2J
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:28:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ihvpp-0000mO-Kl
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:27:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ihvpo-0002LJ-EZ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:27:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31362
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ihvpo-0002Iy-59
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:27:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576762039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nm5rBDcoCplmlWRAfpJUTX03Lt2BWA14BTGdBKMUPBs=;
 b=eFW9v1VNs6/sRMytbtkj+9mUNVMnc2X0Ofn3ZM074HhEvO1aolv8TVdQC17OmnjPvBaLgO
 dX7JcnGi6tsobHVfMimF/UEWlnQLGyIsa+okYMPZRYkjsa32z7aFABop70kvP2oCRzxa1H
 gK0OQNivMHTc2RtsKXD/gr5uG34hc7E=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-s-q-aSmsPi2TXiA8F8touQ-1; Thu, 19 Dec 2019 08:27:18 -0500
Received: by mail-qv1-f72.google.com with SMTP id n11so3605223qvp.15
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 05:27:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=SV/3gkt55AkXiObd4ttRVZfM0Ouiap0tkA8DR2mthfg=;
 b=cidFTFL8lSNGKNEL2rgq3mQi2v8bQTwrLYb9a8cMw0EHGTP0Jwlui3dFektVE2j4DT
 F3kMW4zpaBgfc+HFmvMOaRPHjs1IM4Dhel1aiquUW787JH0tLefqYWGXLHnS9vLPTq5U
 0adRGAKaGhfUG5ZZbLeS/3mb2MW/K8PK0MnOorZWY7rGdRCEkQhSPdLFoSATr7i42jje
 vMF76qEvaV6RN8pTLcGOwHHTFYDThxjN77Y5Ki9JaPgbg6hEyhCp/9mRMj8u8zUaGBlj
 VRUnSCXu42HZZkrAXFJPxV5v9VBAp6ugFHfjgi7TDbCMgC6YwWwVZFmuVw4qh5i+V3vL
 DiGg==
X-Gm-Message-State: APjAAAUyjLRUFyZw/0y113daO9TcVIFEbeD0M8tZgVbacPdiumfYCrZm
 O0uS39BUnY/WkSnI9xL/eJQCZQUw/fqSbJZp3B2gxEvIqzX0Mwj64GJD7jzOXrBe448i1/7PHD7
 J6DnT5YS+Z+BXxLE=
X-Received: by 2002:aed:2b04:: with SMTP id p4mr6747250qtd.270.1576762037869; 
 Thu, 19 Dec 2019 05:27:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqzxJSPYH0s/GOrWKXPHoKaapoOlZ68ZAq0Wt+zq6meHdeQTCK3Hqf5x6HDhG78xE123I89yUg==
X-Received: by 2002:aed:2b04:: with SMTP id p4mr6747232qtd.270.1576762037692; 
 Thu, 19 Dec 2019 05:27:17 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id b7sm1861870qtj.15.2019.12.19.05.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 05:27:16 -0800 (PST)
Date: Thu, 19 Dec 2019 08:27:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/24] virtio-serial-bus: fix memory leak while attach
 virtio-serial-bus
Message-ID: <20191219132621.16595-5-mst@redhat.com>
References: <20191219132621.16595-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191219132621.16595-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: s-q-aSmsPi2TXiA8F8touQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Amit Shah <amit@kernel.org>,
 Pan Nengyuan <pannengyuan@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Euler Robot <euler.robot@huawei.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

ivqs/ovqs/c_ivq/c_ovq is forgot to cleanup in
virtio_serial_device_unrealize, the memory leak stack is as bellow:

Direct leak of 1290240 byte(s) in 180 object(s) allocated from:
    #0 0x7fc9bfc27560 in calloc (/usr/lib64/libasan.so.3+0xc7560)
    #1 0x7fc9bed6f015 in g_malloc0 (/usr/lib64/libglib-2.0.so.0+0x50015)
    #2 0x5650e02b83e7 in virtio_add_queue hw/virtio/virtio.c:2327
    #3 0x5650e02847b5 in virtio_serial_device_realize hw/char/virtio-serial=
-bus.c:1089
    #4 0x5650e02b56a7 in virtio_device_realize hw/virtio/virtio.c:3504
    #5 0x5650e03bf031 in device_set_realized hw/core/qdev.c:876
    #6 0x5650e0531efd in property_set_bool qom/object.c:2080
    #7 0x5650e053650e in object_property_set_qobject qom/qom-qobject.c:26
    #8 0x5650e0533e14 in object_property_set_bool qom/object.c:1338
    #9 0x5650e04c0e37 in virtio_pci_realize hw/virtio/virtio-pci.c:1801

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Amit Shah <amit@kernel.org>
Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1575444716-17632-3-git-send-email-pannengyuan@huawei.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/char/virtio-serial-bus.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 33259042a9..e1cbce3ba3 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -1126,9 +1126,17 @@ static void virtio_serial_device_unrealize(DeviceSta=
te *dev, Error **errp)
 {
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
     VirtIOSerial *vser =3D VIRTIO_SERIAL(dev);
+    int i;
=20
     QLIST_REMOVE(vser, next);
=20
+    virtio_delete_queue(vser->c_ivq);
+    virtio_delete_queue(vser->c_ovq);
+    for (i =3D 0; i < vser->bus.max_nr_ports; i++) {
+        virtio_delete_queue(vser->ivqs[i]);
+        virtio_delete_queue(vser->ovqs[i]);
+    }
+
     g_free(vser->ivqs);
     g_free(vser->ovqs);
     g_free(vser->ports_map);
--=20
MST


