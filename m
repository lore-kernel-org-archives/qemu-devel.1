Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF0CC432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 06:54:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 266A2217F4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 06:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GXqyej7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 266A2217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD1Bp-0005rx-Hd
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 02:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iD13g-0008H5-SO
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 02:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iD13f-0003S4-HI
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 02:45:52 -0400
Received: from ozlabs.org ([203.11.71.1]:60485)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iD13e-0003P4-Ee; Wed, 25 Sep 2019 02:45:51 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46dT8m6LLsz9sPS; Wed, 25 Sep 2019 16:45:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569393944;
 bh=P0np1w4XgBOhb+kntSg8w2qO0Xl6W7irJK27KvLJAYc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GXqyej7sJklRlHi8hNOmCLmWw87EJc+xoKdwb0bZrr3Mg+BUk2dCItwJqVyDkmNd3
 BKCWNvnoEmmi5/fiYHkZtaMBkeXEuVyYL4kZbAwkiTlayoAsF9hHuroUedr72+SNiH
 YROzdVZqZhYQ5gLTVFGwWanqwuTD05/2/07sAmEE=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-ppc@nongnu.org,
	clg@kaod.org,
	qemu-devel@nongnu.org
Subject: [PATCH 04/20] xics: Eliminate reset hook
Date: Wed, 25 Sep 2019 16:45:18 +1000
Message-Id: <20190925064534.19155-5-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190925064534.19155-1-david@gibson.dropbear.id.au>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 groug@kaod.org, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently TYPE_XICS_BASE and TYPE_XICS_SIMPLE have their own reset method=
s,
using the standard technique for having the subtype call the supertype's
methods before doing its own thing.

But TYPE_XICS_SIMPLE is the only subtype of TYPE_XICS_BASE ever
instantiated, so there's no point having the split here.  Merge them
together into just an ics_reset() function.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c        | 57 ++++++++++++++++++-------------------------
 include/hw/ppc/xics.h |  1 -
 2 files changed, 24 insertions(+), 34 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 310dc72b46..82e6f09259 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -547,11 +547,28 @@ static void ics_eoi(ICSState *ics, uint32_t nr)
     }
 }
=20
-static void ics_simple_reset(DeviceState *dev)
+static void ics_reset_irq(ICSIRQState *irq)
 {
-    ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(dev);
+    irq->priority =3D 0xff;
+    irq->saved_priority =3D 0xff;
+}
=20
-    icsc->parent_reset(dev);
+static void ics_reset(DeviceState *dev)
+{
+    ICSState *ics =3D ICS_BASE(dev);
+    int i;
+    uint8_t flags[ics->nr_irqs];
+
+    for (i =3D 0; i < ics->nr_irqs; i++) {
+        flags[i] =3D ics->irqs[i].flags;
+    }
+
+    memset(ics->irqs, 0, sizeof(ICSIRQState) * ics->nr_irqs);
+
+    for (i =3D 0; i < ics->nr_irqs; i++) {
+        ics_reset_irq(ics->irqs + i);
+        ics->irqs[i].flags =3D flags[i];
+    }
=20
     if (kvm_irqchip_in_kernel()) {
         Error *local_err =3D NULL;
@@ -563,9 +580,9 @@ static void ics_simple_reset(DeviceState *dev)
     }
 }
=20
-static void ics_simple_reset_handler(void *dev)
+static void ics_reset_handler(void *dev)
 {
-    ics_simple_reset(dev);
+    ics_reset(dev);
 }
=20
 static void ics_simple_realize(DeviceState *dev, Error **errp)
@@ -580,7 +597,7 @@ static void ics_simple_realize(DeviceState *dev, Erro=
r **errp)
         return;
     }
=20
-    qemu_register_reset(ics_simple_reset_handler, ics);
+    qemu_register_reset(ics_reset_handler, ics);
 }
=20
 static void ics_simple_class_init(ObjectClass *klass, void *data)
@@ -590,8 +607,6 @@ static void ics_simple_class_init(ObjectClass *klass,=
 void *data)
=20
     device_class_set_parent_realize(dc, ics_simple_realize,
                                     &isc->parent_realize);
-    device_class_set_parent_reset(dc, ics_simple_reset,
-                                  &isc->parent_reset);
 }
=20
 static const TypeInfo ics_simple_info =3D {
@@ -602,30 +617,6 @@ static const TypeInfo ics_simple_info =3D {
     .class_size =3D sizeof(ICSStateClass),
 };
=20
-static void ics_reset_irq(ICSIRQState *irq)
-{
-    irq->priority =3D 0xff;
-    irq->saved_priority =3D 0xff;
-}
-
-static void ics_base_reset(DeviceState *dev)
-{
-    ICSState *ics =3D ICS_BASE(dev);
-    int i;
-    uint8_t flags[ics->nr_irqs];
-
-    for (i =3D 0; i < ics->nr_irqs; i++) {
-        flags[i] =3D ics->irqs[i].flags;
-    }
-
-    memset(ics->irqs, 0, sizeof(ICSIRQState) * ics->nr_irqs);
-
-    for (i =3D 0; i < ics->nr_irqs; i++) {
-        ics_reset_irq(ics->irqs + i);
-        ics->irqs[i].flags =3D flags[i];
-    }
-}
-
 static void ics_base_realize(DeviceState *dev, Error **errp)
 {
     ICSState *ics =3D ICS_BASE(dev);
@@ -726,7 +717,7 @@ static void ics_base_class_init(ObjectClass *klass, v=
oid *data)
=20
     dc->realize =3D ics_base_realize;
     dc->props =3D ics_base_properties;
-    dc->reset =3D ics_base_reset;
+    dc->reset =3D ics_reset;
     dc->vmsd =3D &vmstate_ics_base;
 }
=20
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index e72fb67968..18fcd2b11c 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -105,7 +105,6 @@ struct ICSStateClass {
     DeviceClass parent_class;
=20
     DeviceRealize parent_realize;
-    DeviceReset parent_reset;
 };
=20
 struct ICSState {
--=20
2.21.0


