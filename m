Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F28C33C9E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:27:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 002D920705
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="k/OrmbWb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002D920705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip3sd-0001Wv-NY
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 00:27:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3oa-0003rD-Ei
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3oY-0002ha-Uq
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:32 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:58843 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ip3oY-0002da-Ir; Wed, 08 Jan 2020 00:23:30 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47syMB5t59z9sSG; Wed,  8 Jan 2020 16:23:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578460998;
 bh=mBUMRDLOn4RhQLMiLfYdwaUWkSfy6s7D/PbVF3ODnjw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=k/OrmbWbBLZfcr4wJrVvzaAtVHfv53WELUCgaltDaMzx2gqn45IAk/T5qKzB8Aef1
 xXdPp/6bKA2Qn3jVqTJr8iD4OLgS4JX/ucIVEgwOXPubkva7jdAH7NWq3eadgbfm9u
 h9H0N0YX7u3LI9Z2AQ9EZtUKtHuoVxiPk8nQE7rM=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 07/26] spapr/xive: Use device_class_set_parent_realize()
Date: Wed,  8 Jan 2020 16:22:53 +1100
Message-Id: <20200108052312.238710-8-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108052312.238710-1-david@gibson.dropbear.id.au>
References: <20200108052312.238710-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Message-Id: <20191219181155.32530-6-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive.c        | 12 +++++++++++-
 include/hw/ppc/spapr_xive.h | 10 ++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 57305c56d7..32322470a8 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -286,10 +286,17 @@ static void spapr_xive_instance_init(Object *obj)
 static void spapr_xive_realize(DeviceState *dev, Error **errp)
 {
     SpaprXive *xive =3D SPAPR_XIVE(dev);
+    SpaprXiveClass *sxc =3D SPAPR_XIVE_GET_CLASS(xive);
     XiveSource *xsrc =3D &xive->source;
     XiveENDSource *end_xsrc =3D &xive->end_source;
     Error *local_err =3D NULL;
=20
+    sxc->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     if (!xive->nr_irqs) {
         error_setg(errp, "Number of interrupt needs to be greater 0");
         return;
@@ -760,10 +767,12 @@ static void spapr_xive_class_init(ObjectClass *klas=
s, void *data)
     XiveRouterClass *xrc =3D XIVE_ROUTER_CLASS(klass);
     SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_CLASS(klass);
     XivePresenterClass *xpc =3D XIVE_PRESENTER_CLASS(klass);
+    SpaprXiveClass *sxc =3D SPAPR_XIVE_CLASS(klass);
=20
     dc->desc    =3D "sPAPR XIVE Interrupt Controller";
     dc->props   =3D spapr_xive_properties;
-    dc->realize =3D spapr_xive_realize;
+    device_class_set_parent_realize(dc, spapr_xive_realize,
+                                    &sxc->parent_realize);
     dc->vmsd    =3D &vmstate_spapr_xive;
=20
     xrc->get_eas =3D spapr_xive_get_eas;
@@ -794,6 +803,7 @@ static const TypeInfo spapr_xive_info =3D {
     .instance_init =3D spapr_xive_instance_init,
     .instance_size =3D sizeof(SpaprXive),
     .class_init =3D spapr_xive_class_init,
+    .class_size =3D sizeof(SpaprXiveClass),
     .interfaces =3D (InterfaceInfo[]) {
         { TYPE_SPAPR_INTC },
         { }
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 3a103c224d..93d09d68de 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -15,6 +15,10 @@
=20
 #define TYPE_SPAPR_XIVE "spapr-xive"
 #define SPAPR_XIVE(obj) OBJECT_CHECK(SpaprXive, (obj), TYPE_SPAPR_XIVE)
+#define SPAPR_XIVE_CLASS(klass)                                         =
\
+    OBJECT_CLASS_CHECK(SpaprXiveClass, (klass), TYPE_SPAPR_XIVE)
+#define SPAPR_XIVE_GET_CLASS(obj)                               \
+    OBJECT_GET_CLASS(SpaprXiveClass, (obj), TYPE_SPAPR_XIVE)
=20
 typedef struct SpaprXive {
     XiveRouter    parent;
@@ -47,6 +51,12 @@ typedef struct SpaprXive {
     VMChangeStateEntry *change;
 } SpaprXive;
=20
+typedef struct SpaprXiveClass {
+    XiveRouterClass parent;
+
+    DeviceRealize parent_realize;
+} SpaprXiveClass;
+
 /*
  * The sPAPR machine has a unique XIVE IC device. Assign a fixed value
  * to the controller block id value. It can nevertheless be changed
--=20
2.24.1


