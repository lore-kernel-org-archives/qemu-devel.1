Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16AFC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:39:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C0FE2067D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="IOZu6E4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C0FE2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip43s-0000q6-Vk
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 00:39:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47580)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3oc-0003tE-Dr
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3oa-0002l9-R1
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:34 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:43941 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ip3oa-0002hR-GX; Wed, 08 Jan 2020 00:23:32 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47syMC4X3Yz9sSX; Wed,  8 Jan 2020 16:23:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578460999;
 bh=+Kba0GZL/Hqaic272S3HeDf3a0FZWcgeDtS8j3jcQaY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IOZu6E4qPk0t2ndr7prPeqY27RWBGWXozGXMMsS/ZeAFbkarkG1PjYCiNnwKpL7Gw
 F5mOTox0AD3a6wjq7U43OvcQQUZw+GbJS5eOqdMFqSr2xpyhRU/8pcxwltRu9Kl+uM
 eLJo6KMV1yvicggMmY0lmEGYmAcNgwOdR1WFcgEQ=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 15/26] pnv/xive: Use device_class_set_parent_realize()
Date: Wed,  8 Jan 2020 16:23:01 +1100
Message-Id: <20200108052312.238710-16-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108052312.238710-1-david@gibson.dropbear.id.au>
References: <20200108052312.238710-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

The XIVE router base class currently inherits an empty realize hook
from the sysbus device base class, but it will soon implement one
of its own to perform some sanity checks. Do the preliminary plumbing
to have it called.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20200106145645.4539-4-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/pnv_xive.c        | 10 ++++++++++
 include/hw/ppc/pnv_xive.h | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index a0a69b98a7..6412cf222e 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -1816,10 +1816,17 @@ static void pnv_xive_init(Object *obj)
 static void pnv_xive_realize(DeviceState *dev, Error **errp)
 {
     PnvXive *xive =3D PNV_XIVE(dev);
+    PnvXiveClass *pxc =3D PNV_XIVE_GET_CLASS(dev);
     XiveSource *xsrc =3D &xive->ipi_source;
     XiveENDSource *end_xsrc =3D &xive->end_source;
     Error *local_err =3D NULL;
=20
+    pxc->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     assert(xive->chip);
=20
     /*
@@ -1947,10 +1954,12 @@ static void pnv_xive_class_init(ObjectClass *klas=
s, void *data)
     XiveRouterClass *xrc =3D XIVE_ROUTER_CLASS(klass);
     XiveNotifierClass *xnc =3D XIVE_NOTIFIER_CLASS(klass);
     XivePresenterClass *xpc =3D XIVE_PRESENTER_CLASS(klass);
+    PnvXiveClass *pxc =3D PNV_XIVE_CLASS(klass);
=20
     xdc->dt_xscom =3D pnv_xive_dt_xscom;
=20
     dc->desc =3D "PowerNV XIVE Interrupt Controller";
+    device_class_set_parent_realize(dc, pnv_xive_realize, &pxc->parent_r=
ealize);
     dc->realize =3D pnv_xive_realize;
     dc->props =3D pnv_xive_properties;
=20
@@ -1971,6 +1980,7 @@ static const TypeInfo pnv_xive_info =3D {
     .instance_init =3D pnv_xive_init,
     .instance_size =3D sizeof(PnvXive),
     .class_init    =3D pnv_xive_class_init,
+    .class_size    =3D sizeof(PnvXiveClass),
     .interfaces    =3D (InterfaceInfo[]) {
         { TYPE_PNV_XSCOM_INTERFACE },
         { }
diff --git a/include/hw/ppc/pnv_xive.h b/include/hw/ppc/pnv_xive.h
index f4c7caad40..76cf16f644 100644
--- a/include/hw/ppc/pnv_xive.h
+++ b/include/hw/ppc/pnv_xive.h
@@ -16,6 +16,10 @@ struct PnvChip;
=20
 #define TYPE_PNV_XIVE "pnv-xive"
 #define PNV_XIVE(obj) OBJECT_CHECK(PnvXive, (obj), TYPE_PNV_XIVE)
+#define PNV_XIVE_CLASS(klass)                                   \
+    OBJECT_CLASS_CHECK(PnvXiveClass, (klass), TYPE_PNV_XIVE)
+#define PNV_XIVE_GET_CLASS(obj)                                 \
+    OBJECT_GET_CLASS(PnvXiveClass, (obj), TYPE_PNV_XIVE)
=20
 #define XIVE_BLOCK_MAX      16
=20
@@ -85,6 +89,12 @@ typedef struct PnvXive {
     uint64_t      edt[XIVE_TABLE_EDT_MAX];
 } PnvXive;
=20
+typedef struct PnvXiveClass {
+    XiveRouterClass parent_class;
+
+    DeviceRealize parent_realize;
+} PnvXiveClass;
+
 void pnv_xive_pic_print_info(PnvXive *xive, Monitor *mon);
=20
 #endif /* PPC_PNV_XIVE_H */
--=20
2.24.1


