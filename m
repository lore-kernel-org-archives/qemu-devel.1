Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293C7C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:42:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC186206DA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Q9vHQx7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC186206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip47I-0005Mu-1c
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 00:42:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47734)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3of-0003ye-5C
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3od-0002pW-76
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:36 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:38725 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ip3oc-0002mB-Se; Wed, 08 Jan 2020 00:23:35 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47syMF1Qh3z9sSd; Wed,  8 Jan 2020 16:23:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578461001;
 bh=FrX/6SyVjPjJTIn/b/hGmvNuofHIxtxtXwHx5jlXHBI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Q9vHQx7e21sz1qxE9XUEZ1cbI9o80guAd+SuT1UIyrS3xBvy4IS/hcEvup2t1XZzR
 EY7cJwuKyfCxEeuHUE8Vcv1PUnnQndBuXPcTmd3BlGRMK4zlJ8/oLWshxlEP2J6+Cm
 njSxQDLs3zl6kAC0RwLohIHr4gN/zijgD0IhkFT0=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 16/26] spapr, pnv,
 xive: Add a "xive-fabric" link to the XIVE router
Date: Wed,  8 Jan 2020 16:23:02 +1100
Message-Id: <20200108052312.238710-17-david@gibson.dropbear.id.au>
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

In order to get rid of qdev_get_machine(), first add a pointer to the
XIVE fabric under the XIVE router and make it configurable through a
QOM link property.

Configure it in the spapr and pnv machine. In the case of pnv, the XIVE
routers are under the chip, so this is done with a QOM alias property of
the POWER9 pnv chip.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20200106145645.4539-5-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xive.c        | 8 ++++++++
 hw/ppc/pnv.c          | 6 ++++++
 hw/ppc/spapr_irq.c    | 2 ++
 include/hw/ppc/xive.h | 5 +++--
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index d4c6e21703..6df89b06da 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1714,12 +1714,19 @@ void xive_router_notify(XiveNotifier *xn, uint32_=
t lisn)
                            xive_get_field64(EAS_END_DATA,  eas.w));
 }
=20
+static Property xive_router_properties[] =3D {
+    DEFINE_PROP_LINK("xive-fabric", XiveRouter, xfb,
+                     TYPE_XIVE_FABRIC, XiveFabric *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void xive_router_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     XiveNotifierClass *xnc =3D XIVE_NOTIFIER_CLASS(klass);
=20
     dc->desc    =3D "XIVE Router Engine";
+    dc->props   =3D xive_router_properties;
     xnc->notify =3D xive_router_notify;
 }
=20
@@ -1727,6 +1734,7 @@ static const TypeInfo xive_router_info =3D {
     .name          =3D TYPE_XIVE_ROUTER,
     .parent        =3D TYPE_SYS_BUS_DEVICE,
     .abstract      =3D true,
+    .instance_size =3D sizeof(XiveRouter),
     .class_size    =3D sizeof(XiveRouterClass),
     .class_init    =3D xive_router_class_init,
     .interfaces    =3D (InterfaceInfo[]) {
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 65cba84335..ead92d52b2 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -809,6 +809,10 @@ static void pnv_init(MachineState *machine)
         if (object_dynamic_cast(OBJECT(pnv), TYPE_XICS_FABRIC)) {
             object_property_set_link(chip, OBJECT(pnv), "xics", &error_a=
bort);
         }
+        if (object_dynamic_cast(OBJECT(pnv), TYPE_XIVE_FABRIC)) {
+            object_property_set_link(chip, OBJECT(pnv), "xive-fabric",
+                                     &error_abort);
+        }
         object_property_set_bool(chip, true, "realized", &error_fatal);
     }
     g_free(chip_typename);
@@ -1227,6 +1231,8 @@ static void pnv_chip_power9_instance_init(Object *o=
bj)
=20
     object_initialize_child(obj, "xive", &chip9->xive, sizeof(chip9->xiv=
e),
                             TYPE_PNV_XIVE, &error_abort, NULL);
+    object_property_add_alias(obj, "xive-fabric", OBJECT(&chip9->xive),
+                              "xive-fabric", &error_abort);
=20
     object_initialize_child(obj, "psi",  &chip9->psi, sizeof(chip9->psi)=
,
                             TYPE_PNV9_PSI, &error_abort, NULL);
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 373505d28b..1f630f296b 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -332,6 +332,8 @@ void spapr_irq_init(SpaprMachineState *spapr, Error *=
*errp)
          * priority
          */
         qdev_prop_set_uint32(dev, "nr-ends", nr_servers << 3);
+        object_property_set_link(OBJECT(dev), OBJECT(spapr), "xive-fabri=
c",
+                                 &error_abort);
         qdev_init_nofail(dev);
=20
         spapr->xive =3D SPAPR_XIVE(dev);
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 1b7b89098f..1ded82b1cd 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -324,9 +324,12 @@ typedef struct XiveTCTX {
 /*
  * XIVE Router
  */
+typedef struct XiveFabric XiveFabric;
=20
 typedef struct XiveRouter {
     SysBusDevice    parent;
+
+    XiveFabric *xfb;
 } XiveRouter;
=20
 #define TYPE_XIVE_ROUTER "xive-router"
@@ -402,8 +405,6 @@ int xive_presenter_tctx_match(XivePresenter *xptr, Xi=
veTCTX *tctx,
  * XIVE Fabric (Interface between Interrupt Controller and Machine)
  */
=20
-typedef struct XiveFabric XiveFabric;
-
 #define TYPE_XIVE_FABRIC "xive-fabric"
 #define XIVE_FABRIC(obj)                                     \
     INTERFACE_CHECK(XiveFabric, (obj), TYPE_XIVE_FABRIC)
--=20
2.24.1


