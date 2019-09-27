Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C703EC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:25:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E045206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="S8bNAbgf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E045206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDjgl-00007m-Ms
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 02:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iDj9p-0007Nd-9W
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 01:51:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iDj9n-0005Zo-LW
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 01:51:09 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:50933)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iDj9n-00051M-9k; Fri, 27 Sep 2019 01:51:07 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46fgrF6qTMz9sRQ; Fri, 27 Sep 2019 15:50:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569563437;
 bh=SS5P3zUReRVT/NHEaoA2OCkQxMX6u0pPpRV6wdvsVM4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=S8bNAbgf4ppPRyeI2Brl01CZDuLB6CLUOAnlTwSGlYr4iMuL6desVuJoRWu/wjHTk
 0GSrHOZehJBz+WC+BVCHmxXbyEuaM9fxu0BJH8KSIro5tQ5WaCBgm3Szi3culYKf07
 7LWszcKEETZp1+cPWoWElsOt25CzU4lI0nMgBrwU=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org,
	clg@kaod.org,
	qemu-ppc@nongnu.org
Subject: [PATCH v2 19/33] spapr: Eliminate SpaprIrq::init hook
Date: Fri, 27 Sep 2019 15:50:14 +1000
Message-Id: <20190927055028.11493-20-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190927055028.11493-1-david@gibson.dropbear.id.au>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 groug@kaod.org, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This method is used to set up the interrupt backends for the current
configuration.  However, this means some confusing redirection between
the "dual" mode init and the init hooks for xics only and xive only modes=
.

Since we now have simple flags indicating whether XICS and/or XIVE are
supported, it's easier to just open code each initialization directly in
spapr_irq_init().  This will also make some future cleanups simpler.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_irq.c          | 137 +++++++++++++++++-------------------
 include/hw/ppc/spapr_irq.h  |   1 -
 include/hw/ppc/xics_spapr.h |   1 +
 3 files changed, 64 insertions(+), 75 deletions(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 0aec5b0f0e..5e448b1fd4 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -92,26 +92,6 @@ static void spapr_irq_init_kvm(SpaprMachineState *spap=
r,
  * XICS IRQ backend.
  */
=20
-static void spapr_irq_init_xics(SpaprMachineState *spapr, Error **errp)
-{
-    Object *obj;
-    Error *local_err =3D NULL;
-
-    obj =3D object_new(TYPE_ICS_SPAPR);
-    object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
-    object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
-                                   &error_fatal);
-    object_property_set_int(obj, spapr->irq->nr_xirqs,
-                            "nr-irqs",  &error_fatal);
-    object_property_set_bool(obj, true, "realized", &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
-    spapr->ics =3D ICS_SPAPR(obj);
-}
-
 static int spapr_irq_claim_xics(SpaprMachineState *spapr, int irq, bool =
lsi,
                                 Error **errp)
 {
@@ -213,7 +193,6 @@ SpaprIrq spapr_irq_xics =3D {
     .xics        =3D true,
     .xive        =3D false,
=20
-    .init        =3D spapr_irq_init_xics,
     .claim       =3D spapr_irq_claim_xics,
     .free        =3D spapr_irq_free_xics,
     .print_info  =3D spapr_irq_print_info_xics,
@@ -228,36 +207,6 @@ SpaprIrq spapr_irq_xics =3D {
 /*
  * XIVE IRQ backend.
  */
-static void spapr_irq_init_xive(SpaprMachineState *spapr, Error **errp)
-{
-    uint32_t nr_servers =3D spapr_max_server_number(spapr);
-    DeviceState *dev;
-    int i;
-
-    dev =3D qdev_create(NULL, TYPE_SPAPR_XIVE);
-    qdev_prop_set_uint32(dev, "nr-irqs",
-                         spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE);
-    /*
-     * 8 XIVE END structures per CPU. One for each available priority
-     */
-    qdev_prop_set_uint32(dev, "nr-ends", nr_servers << 3);
-    qdev_init_nofail(dev);
-
-    spapr->xive =3D SPAPR_XIVE(dev);
-
-    /* Enable the CPU IPIs */
-    for (i =3D 0; i < nr_servers; ++i) {
-        Error *local_err =3D NULL;
-
-        spapr_xive_irq_claim(spapr->xive, SPAPR_IRQ_IPI + i, false, &loc=
al_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
-        }
-    }
-
-    spapr_xive_hcall_init(spapr);
-}
=20
 static int spapr_irq_claim_xive(SpaprMachineState *spapr, int irq, bool =
lsi,
                                 Error **errp)
@@ -357,7 +306,6 @@ SpaprIrq spapr_irq_xive =3D {
     .xics        =3D false,
     .xive        =3D true,
=20
-    .init        =3D spapr_irq_init_xive,
     .claim       =3D spapr_irq_claim_xive,
     .free        =3D spapr_irq_free_xive,
     .print_info  =3D spapr_irq_print_info_xive,
@@ -388,23 +336,6 @@ static SpaprIrq *spapr_irq_current(SpaprMachineState=
 *spapr)
         &spapr_irq_xive : &spapr_irq_xics;
 }
=20
-static void spapr_irq_init_dual(SpaprMachineState *spapr, Error **errp)
-{
-    Error *local_err =3D NULL;
-
-    spapr_irq_xics.init(spapr, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
-    spapr_irq_xive.init(spapr, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-}
-
 static int spapr_irq_claim_dual(SpaprMachineState *spapr, int irq, bool =
lsi,
                                 Error **errp)
 {
@@ -519,7 +450,6 @@ SpaprIrq spapr_irq_dual =3D {
     .xics        =3D true,
     .xive        =3D true,
=20
-    .init        =3D spapr_irq_init_dual,
     .claim       =3D spapr_irq_claim_dual,
     .free        =3D spapr_irq_free_dual,
     .print_info  =3D spapr_irq_print_info_dual,
@@ -607,8 +537,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error *=
*errp)
=20
     spapr_irq_check(spapr, &local_err);
     if (local_err) {
-        error_propagate(errp, local_err);
-        return;
+        goto out;
     }
=20
     /* Initialize the MSI IRQ allocator. */
@@ -616,10 +545,71 @@ void spapr_irq_init(SpaprMachineState *spapr, Error=
 **errp)
         spapr_irq_msi_init(spapr, spapr->irq->nr_msis);
     }
=20
-    spapr->irq->init(spapr, errp);
+    if (spapr->irq->xics) {
+        Object *obj;
+
+        obj =3D object_new(TYPE_ICS_SPAPR);
+        object_property_add_child(OBJECT(spapr), "ics", obj, &local_err)=
;
+        if (local_err) {
+            goto out;
+        }
+
+        object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr)=
,
+                                       &local_err);
+        if (local_err) {
+            goto out;
+        }
+
+        object_property_set_int(obj, spapr->irq->nr_xirqs, "nr-irqs",
+                                &local_err);
+        if (local_err) {
+            goto out;
+        }
+
+        object_property_set_bool(obj, true, "realized", &local_err);
+        if (local_err) {
+            goto out;
+        }
+
+        spapr->ics =3D ICS_SPAPR(obj);
+    }
+
+    if (spapr->irq->xive) {
+        uint32_t nr_servers =3D spapr_max_server_number(spapr);
+        DeviceState *dev;
+        int i;
+
+        dev =3D qdev_create(NULL, TYPE_SPAPR_XIVE);
+        qdev_prop_set_uint32(dev, "nr-irqs",
+                             spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE);
+        /*
+         * 8 XIVE END structures per CPU. One for each available
+         * priority
+         */
+        qdev_prop_set_uint32(dev, "nr-ends", nr_servers << 3);
+        qdev_init_nofail(dev);
+
+        spapr->xive =3D SPAPR_XIVE(dev);
+
+        /* Enable the CPU IPIs */
+        for (i =3D 0; i < nr_servers; ++i) {
+            Error *local_err =3D NULL;
+
+            spapr_xive_irq_claim(spapr->xive, SPAPR_IRQ_IPI + i,
+                                 false, &local_err);
+            if (local_err) {
+                goto out;
+            }
+        }
+
+        spapr_xive_hcall_init(spapr);
+    }
=20
     spapr->qirqs =3D qemu_allocate_irqs(spapr->irq->set_irq, spapr,
                                       spapr->irq->nr_xirqs + SPAPR_XIRQ_=
BASE);
+
+out:
+    error_propagate(errp, local_err);
 }
=20
 int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error *=
*errp)
@@ -763,7 +753,6 @@ SpaprIrq spapr_irq_xics_legacy =3D {
     .xics        =3D true,
     .xive        =3D false,
=20
-    .init        =3D spapr_irq_init_xics,
     .claim       =3D spapr_irq_claim_xics,
     .free        =3D spapr_irq_free_xics,
     .print_info  =3D spapr_irq_print_info_xics,
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index d3f3b85eb9..69a37f608e 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -42,7 +42,6 @@ typedef struct SpaprIrq {
     bool        xics;
     bool        xive;
=20
-    void (*init)(SpaprMachineState *spapr, Error **errp);
     int (*claim)(SpaprMachineState *spapr, int irq, bool lsi, Error **er=
rp);
     void (*free)(SpaprMachineState *spapr, int irq);
     void (*print_info)(SpaprMachineState *spapr, Monitor *mon);
diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
index 0b35e85c26..0a32a86e3e 100644
--- a/include/hw/ppc/xics_spapr.h
+++ b/include/hw/ppc/xics_spapr.h
@@ -32,6 +32,7 @@
 #define TYPE_ICS_SPAPR "ics-spapr"
 #define ICS_SPAPR(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_SPAPR)
=20
+void ics_spapr_create(SpaprMachineState *spapr, int nr_xirqs, Error **er=
rp);
 void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers, void *=
fdt,
                    uint32_t phandle);
 int xics_kvm_connect(SpaprMachineState *spapr, Error **errp);
--=20
2.21.0


