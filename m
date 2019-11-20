Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7A3C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:41:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E021520709
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WFJuotDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E021520709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXS6Q-0001dT-T5
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 10:41:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34679)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRvB-0004tb-Al
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:29:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRvA-0007wJ-5k
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:29:33 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49686
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iXRvA-0007wB-1y
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:29:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574263771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=97KwrfG1xjhus8tTA+sIOXcDgalWOjE4Jf8/DB10ML8=;
 b=WFJuotDzOvFZzz9iceTnXKrU39UkY9gREbdC5Fb34iFf8VwNqLKi1EzAX3z2ddqVxRzrFE
 fBl4paWlov0aExc9HfuuVR2Yv+rPFwA9mPFCC+FP4FtN47jc3h6wDm7SEXYwO3avw6e69E
 T8jyIM1ZhNOgMiqqMsjQcNlwXEHIlhU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-QKWIRl9FMwWtJ-da0PPoXw-1; Wed, 20 Nov 2019 10:29:28 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F04D18B5F69;
 Wed, 20 Nov 2019 15:29:27 +0000 (UTC)
Received: from localhost (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 351E367CFC;
 Wed, 20 Nov 2019 15:29:20 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 23/37] lance: replace PROP_PTR with PROP_LINK
Date: Wed, 20 Nov 2019 19:24:28 +0400
Message-Id: <20191120152442.26657-24-marcandre.lureau@redhat.com>
In-Reply-To: <20191120152442.26657-1-marcandre.lureau@redhat.com>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: QKWIRl9FMwWtJ-da0PPoXw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: peter.maydell@linaro.org, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The device remains non-user creatable since it is a sysbus device.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/dma/sparc32_dma.c | 2 +-
 hw/net/lance.c       | 5 ++---
 hw/net/pcnet-pci.c   | 2 +-
 hw/net/pcnet.h       | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index 0e5bbcdc7f..3e4da0c47f 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -346,7 +346,7 @@ static void sparc32_ledma_device_realize(DeviceState *d=
ev, Error **errp)
     d =3D qdev_create(NULL, TYPE_LANCE);
     object_property_add_child(OBJECT(dev), "lance", OBJECT(d), errp);
     qdev_set_nic_properties(d, nd);
-    qdev_prop_set_ptr(d, "dma", dev);
+    object_property_set_link(OBJECT(d), OBJECT(dev), "dma", errp);
     qdev_init_nofail(d);
 }
=20
diff --git a/hw/net/lance.c b/hw/net/lance.c
index 6631e2a4e0..4d96299041 100644
--- a/hw/net/lance.c
+++ b/hw/net/lance.c
@@ -138,7 +138,8 @@ static void lance_instance_init(Object *obj)
 }
=20
 static Property lance_properties[] =3D {
-    DEFINE_PROP_PTR("dma", SysBusPCNetState, state.dma_opaque),
+    DEFINE_PROP_LINK("dma", SysBusPCNetState, state.dma_opaque,
+                     TYPE_DEVICE, DeviceState *),
     DEFINE_NIC_PROPERTIES(SysBusPCNetState, state.conf),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -153,8 +154,6 @@ static void lance_class_init(ObjectClass *klass, void *=
data)
     dc->reset =3D lance_reset;
     dc->vmsd =3D &vmstate_lance;
     dc->props =3D lance_properties;
-    /* Reason: pointer property "dma" */
-    dc->user_creatable =3D false;
 }
=20
 static const TypeInfo lance_info =3D {
diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
index 4723c30c79..d067d21e2c 100644
--- a/hw/net/pcnet-pci.c
+++ b/hw/net/pcnet-pci.c
@@ -231,7 +231,7 @@ static void pci_pcnet_realize(PCIDevice *pci_dev, Error=
 **errp)
     s->irq =3D pci_allocate_irq(pci_dev);
     s->phys_mem_read =3D pci_physical_memory_read;
     s->phys_mem_write =3D pci_physical_memory_write;
-    s->dma_opaque =3D pci_dev;
+    s->dma_opaque =3D DEVICE(pci_dev);
=20
     pcnet_common_init(DEVICE(pci_dev), s, &net_pci_pcnet_info);
 }
diff --git a/hw/net/pcnet.h b/hw/net/pcnet.h
index 28d19a5c6f..f49b213c57 100644
--- a/hw/net/pcnet.h
+++ b/hw/net/pcnet.h
@@ -50,7 +50,7 @@ struct PCNetState_st {
                          uint8_t *buf, int len, int do_bswap);
     void (*phys_mem_write)(void *dma_opaque, hwaddr addr,
                           uint8_t *buf, int len, int do_bswap);
-    void *dma_opaque;
+    DeviceState *dma_opaque;
     int tx_busy;
     int looptest;
 };
--=20
2.24.0


