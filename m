Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40560C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:46:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D44E20709
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/zGKHhT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D44E20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXSBs-0007uf-2Q
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 10:46:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRvO-0005KF-7S
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:29:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRvM-0007y6-SP
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:29:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41549
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iXRvM-0007xs-OR
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574263784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AuDHnPEDsT4yM/z28g70dodjWPrA3ViUrrmBJyeV5yw=;
 b=Y/zGKHhTWe3sqUhHxaYxVrpWEHnf9W+WoN01ltY1AtNtpvWu439Y4g4Y257kQ+SkmmzIRs
 AAC2FcDk9NLB7pAC+ShzG4ybhMQf8VDKQ+SK88oTUZkEhiXhZsTJy7IAdWY+jzfZExwbt3
 DWdP+Le32Pgovcaox/RFkkO//iczdgg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-Wtdhblh7Pv-UhED-oqIlMw-1; Wed, 20 Nov 2019 10:29:42 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AD7F801FA1;
 Wed, 20 Nov 2019 15:29:41 +0000 (UTC)
Received: from localhost (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5227D6715F;
 Wed, 20 Nov 2019 15:29:33 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 24/37] etraxfs: remove PROP_PTR usage
Date: Wed, 20 Nov 2019 19:24:29 +0400
Message-Id: <20191120152442.26657-25-marcandre.lureau@redhat.com>
In-Reply-To: <20191120152442.26657-1-marcandre.lureau@redhat.com>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Wtdhblh7Pv-UhED-oqIlMw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: peter.maydell@linaro.org, Jason Wang <jasowang@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

etraxfs_dma_client are not Object, so can't be exposed to user with
QOM path. Let's remove property usage and move the constructor to the
.c unit, simplifying some code on the way.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/etraxfs_eth.c      | 44 +++++++++++++++++++++++++++++----------
 include/hw/cris/etraxfs.h | 20 +++---------------
 2 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/hw/net/etraxfs_eth.c b/hw/net/etraxfs_eth.c
index 4cfbf1135a..f30d963487 100644
--- a/hw/net/etraxfs_eth.c
+++ b/hw/net/etraxfs_eth.c
@@ -338,14 +338,8 @@ typedef struct ETRAXFSEthState
     uint8_t macaddr[2][6];
     uint32_t regs[FS_ETH_MAX_REGS];
=20
-    union {
-        void *vdma_out;
-        struct etraxfs_dma_client *dma_out;
-    };
-    union {
-        void *vdma_in;
-        struct etraxfs_dma_client *dma_in;
-    };
+    struct etraxfs_dma_client *dma_out;
+    struct etraxfs_dma_client *dma_in;
=20
     /* MDIO bus.  */
     struct qemu_mdio mdio_bus;
@@ -635,8 +629,6 @@ static void etraxfs_eth_realize(DeviceState *dev, Error=
 **errp)
=20
 static Property etraxfs_eth_properties[] =3D {
     DEFINE_PROP_UINT32("phyaddr", ETRAXFSEthState, phyaddr, 1),
-    DEFINE_PROP_PTR("dma_out", ETRAXFSEthState, vdma_out),
-    DEFINE_PROP_PTR("dma_in", ETRAXFSEthState, vdma_in),
     DEFINE_NIC_PROPERTIES(ETRAXFSEthState, conf),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -648,10 +640,40 @@ static void etraxfs_eth_class_init(ObjectClass *klass=
, void *data)
     dc->realize =3D etraxfs_eth_realize;
     dc->reset =3D etraxfs_eth_reset;
     dc->props =3D etraxfs_eth_properties;
-    /* Reason: pointer properties "dma_out", "dma_in" */
+    /* Reason: dma_out, dma_in are not user settable */
     dc->user_creatable =3D false;
 }
=20
+
+/* Instantiate an ETRAXFS Ethernet MAC.  */
+DeviceState *
+etraxfs_eth_init(NICInfo *nd, hwaddr base, int phyaddr,
+                 struct etraxfs_dma_client *dma_out,
+                 struct etraxfs_dma_client *dma_in)
+{
+    DeviceState *dev;
+    qemu_check_nic_model(nd, "fseth");
+
+    dev =3D qdev_create(NULL, "etraxfs-eth");
+    qdev_set_nic_properties(dev, nd);
+    qdev_prop_set_uint32(dev, "phyaddr", phyaddr);
+
+    /*
+     * TODO: QOM design, define a QOM interface for "I am an etraxfs
+     * DMA client" (which replaces the current 'struct
+     * etraxfs_dma_client' ad-hoc interface), implement it on the
+     * ethernet device, and then have QOM link properties on the DMA
+     * controller device so that you can pass the interface
+     * implementations to it.
+     */
+    ETRAX_FS_ETH(dev)->dma_out =3D dma_out;
+    ETRAX_FS_ETH(dev)->dma_in =3D dma_in;
+    qdev_init_nofail(dev);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
+
+    return dev;
+}
+
 static const TypeInfo etraxfs_eth_info =3D {
     .name          =3D TYPE_ETRAX_FS_ETH,
     .parent        =3D TYPE_SYS_BUS_DEVICE,
diff --git a/include/hw/cris/etraxfs.h b/include/hw/cris/etraxfs.h
index aa146a2cd8..403e7f95e6 100644
--- a/include/hw/cris/etraxfs.h
+++ b/include/hw/cris/etraxfs.h
@@ -30,23 +30,9 @@
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
=20
-/* Instantiate an ETRAXFS Ethernet MAC.  */
-static inline DeviceState *
-etraxfs_eth_init(NICInfo *nd, hwaddr base, int phyaddr,
-                 void *dma_out, void *dma_in)
-{
-    DeviceState *dev;
-    qemu_check_nic_model(nd, "fseth");
-
-    dev =3D qdev_create(NULL, "etraxfs-eth");
-    qdev_set_nic_properties(dev, nd);
-    qdev_prop_set_uint32(dev, "phyaddr", phyaddr);
-    qdev_prop_set_ptr(dev, "dma_out", dma_out);
-    qdev_prop_set_ptr(dev, "dma_in", dma_in);
-    qdev_init_nofail(dev);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
-    return dev;
-}
+DeviceState *etraxfs_eth_init(NICInfo *nd, hwaddr base, int phyaddr,
+                              struct etraxfs_dma_client *dma_out,
+                              struct etraxfs_dma_client *dma_in);
=20
 static inline DeviceState *etraxfs_ser_create(hwaddr addr,
                                               qemu_irq irq,
--=20
2.24.0


