Return-Path: <SRS0=Lm/k=22=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBAEC33C8C
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 12:59:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA8D32085B
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 12:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YNEuj8zR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8D32085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1io5VQ-0002k2-Md
	for qemu-devel@archiver.kernel.org; Sun, 05 Jan 2020 07:59:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58102)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1io5TY-0000k1-TP
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:57:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1io5TX-0003jq-Nd
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:57:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56870
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1io5TX-0003iq-Jm
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:57:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578229063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nm5rBDcoCplmlWRAfpJUTX03Lt2BWA14BTGdBKMUPBs=;
 b=YNEuj8zRVrHi5NdDRArqV9Y2xTxtws2Youp94E9VWOoFBOMqT09DE/stYoyC3ZQ77AyKjM
 xAmoAI6RZMr4iXquwDyVDKnangw9G2U2JWHXYH1Brsz7hCx0MbOu6j63SMNQj6ZQaLKjJn
 mGgAVeqFK6rZrifSs6KyQ/zKifkH4TE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-_6WUKmuqMIS0LXNnp6OeOg-1; Sun, 05 Jan 2020 07:57:41 -0500
Received: by mail-qt1-f199.google.com with SMTP id k27so9559116qtu.12
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2020 04:57:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=SV/3gkt55AkXiObd4ttRVZfM0Ouiap0tkA8DR2mthfg=;
 b=X/LCDTBKPBQereGcSHG5eEDOusQ/93rAuzu8nFxDlyljtNaO+U9hMbCPDcicpKCrcR
 6D8ndi0vnB4zJGSxD3KfvIOh5cxF3IS/WPIMxmR6y4G5vhda2maOOZi5tUQJbcYdQtUf
 yaDA6RK63EnxEvZ3E3/A4vmZ+kfNKSrOTFLHxo80E7WxX8epttYa1PTcLQp1Fk+sfUnk
 ns+WriHbalth0RYVmOxreUxxOfDFs5XYe8uODFXMW5cxn3JR/wsTlEnVA+ZtPuNxKYXb
 sEWJcHYKLqYtS6k9qdYDITfW8wemFwSf+j6itzDNgiqfqc13/8mUU0BFcSs1m/zG379Z
 aaVg==
X-Gm-Message-State: APjAAAUh4IpnGg83VGA4A9PREBnVsLT4bGKTuLZQq97HxbLiE5PjE6tq
 gDCl1RSQE/rSa4NVrxHPzrE2r68+1yqgn3k/BrKFGqJWyKGSjYapNm8DRtbj+FE64tWq0dUiUm5
 2keTwf+X4TaZMQIo=
X-Received: by 2002:a05:6214:1149:: with SMTP id
 b9mr73798127qvt.227.1578229060512; 
 Sun, 05 Jan 2020 04:57:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqzya5OPB3zk+w7cR+JmWpck3qkY5h5Xhn4etT6tQvVBuFe68IP0YNFelcXEC9SpJQmk6+DfTg==
X-Received: by 2002:a05:6214:1149:: with SMTP id
 b9mr73798114qvt.227.1578229060297; 
 Sun, 05 Jan 2020 04:57:40 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id c13sm19270948qko.87.2020.01.05.04.57.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jan 2020 04:57:39 -0800 (PST)
Date: Sun, 5 Jan 2020 07:57:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 04/32] virtio-serial-bus: fix memory leak while attach
 virtio-serial-bus
Message-ID: <20200105125622.27231-5-mst@redhat.com>
References: <20200105125622.27231-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200105125622.27231-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: _6WUKmuqMIS0LXNnp6OeOg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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


