Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E66C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:19:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 122A6206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bVrzXOcv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 122A6206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDjbY-0001p3-AF
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 02:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iDj9t-0007VA-JT
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 01:51:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iDj9r-0005fu-BF
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 01:51:13 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:37703)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iDj9q-00054R-Lx; Fri, 27 Sep 2019 01:51:11 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46fgrG2NpPz9sRW; Fri, 27 Sep 2019 15:50:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569563438;
 bh=pROAw7u+GUIMJ+eNBr18ZrQZ/PUAs6NBHixdUtN2kdk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bVrzXOcvHRhwrnbbP6EQpGWZjFn41nGnohpw5PvXu4tmEXPoEA2LMCvnVUYd7LoJK
 Sd2YLqvWirQoniz7ft3/AAeWx2ekwx3j6yc7n6biTQM6yZOJZxZb3pKSoVS2UKgaqC
 gTYTPVr36ABe38xcTf0rSqgqGKmqb7mH/iOZ6HDQ=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org,
	clg@kaod.org,
	qemu-ppc@nongnu.org
Subject: [PATCH v2 22/33] spapr, xics,
 xive: Move irq claim and free from SpaprIrq to
 SpaprInterruptController
Date: Fri, 27 Sep 2019 15:50:17 +1000
Message-Id: <20190927055028.11493-23-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190927055028.11493-1-david@gibson.dropbear.id.au>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
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

These methods, like cpu_intc_create, really belong to the interrupt
controller, but need to be called on all possible intcs.

Like cpu_intc_create, therefore, make them methods on the intc and
always call it for all existing intcs.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive.c        |  71 +++++++++++-----------
 hw/intc/xics_spapr.c        |  29 +++++++++
 hw/ppc/spapr_irq.c          | 114 ++++++++++++------------------------
 include/hw/ppc/spapr_irq.h  |   5 +-
 include/hw/ppc/spapr_xive.h |   2 -
 5 files changed, 107 insertions(+), 114 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 9338daba3d..ff1a175b44 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -487,6 +487,42 @@ static const VMStateDescription vmstate_spapr_xive =3D=
 {
     },
 };
=20
+static int spapr_xive_claim_irq(SpaprInterruptController *intc, int lisn=
,
+                                bool lsi, Error **errp)
+{
+    SpaprXive *xive =3D SPAPR_XIVE(intc);
+    XiveSource *xsrc =3D &xive->source;
+
+    assert(lisn < xive->nr_irqs);
+
+    if (xive_eas_is_valid(&xive->eat[lisn])) {
+        error_setg(errp, "IRQ %d is not free", lisn);
+        return -EBUSY;
+    }
+
+    /*
+     * Set default values when allocating an IRQ number
+     */
+    xive->eat[lisn].w |=3D cpu_to_be64(EAS_VALID | EAS_MASKED);
+    if (lsi) {
+        xive_source_irq_set_lsi(xsrc, lisn);
+    }
+
+    if (kvm_irqchip_in_kernel()) {
+        return kvmppc_xive_source_reset_one(xsrc, lisn, errp);
+    }
+
+    return 0;
+}
+
+static void spapr_xive_free_irq(SpaprInterruptController *intc, int lisn=
)
+{
+    SpaprXive *xive =3D SPAPR_XIVE(intc);
+    assert(lisn < xive->nr_irqs);
+
+    xive->eat[lisn].w &=3D cpu_to_be64(~EAS_VALID);
+}
+
 static Property spapr_xive_properties[] =3D {
     DEFINE_PROP_UINT32("nr-irqs", SpaprXive, nr_irqs, 0),
     DEFINE_PROP_UINT32("nr-ends", SpaprXive, nr_ends, 0),
@@ -536,6 +572,8 @@ static void spapr_xive_class_init(ObjectClass *klass,=
 void *data)
     xrc->get_tctx =3D spapr_xive_get_tctx;
=20
     sicc->cpu_intc_create =3D spapr_xive_cpu_intc_create;
+    sicc->claim_irq =3D spapr_xive_claim_irq;
+    sicc->free_irq =3D spapr_xive_free_irq;
 }
=20
 static const TypeInfo spapr_xive_info =3D {
@@ -557,39 +595,6 @@ static void spapr_xive_register_types(void)
=20
 type_init(spapr_xive_register_types)
=20
-int spapr_xive_irq_claim(SpaprXive *xive, int lisn, bool lsi, Error **er=
rp)
-{
-    XiveSource *xsrc =3D &xive->source;
-
-    assert(lisn < xive->nr_irqs);
-
-    if (xive_eas_is_valid(&xive->eat[lisn])) {
-        error_setg(errp, "IRQ %d is not free", lisn);
-        return -EBUSY;
-    }
-
-    /*
-     * Set default values when allocating an IRQ number
-     */
-    xive->eat[lisn].w |=3D cpu_to_be64(EAS_VALID | EAS_MASKED);
-    if (lsi) {
-        xive_source_irq_set_lsi(xsrc, lisn);
-    }
-
-    if (kvm_irqchip_in_kernel()) {
-        return kvmppc_xive_source_reset_one(xsrc, lisn, errp);
-    }
-
-    return 0;
-}
-
-void spapr_xive_irq_free(SpaprXive *xive, int lisn)
-{
-    assert(lisn < xive->nr_irqs);
-
-    xive->eat[lisn].w &=3D cpu_to_be64(~EAS_VALID);
-}
-
 /*
  * XIVE hcalls
  *
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 946311b858..224fe1efcd 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -346,6 +346,33 @@ static int xics_spapr_cpu_intc_create(SpaprInterrupt=
Controller *intc,
     return 0;
 }
=20
+static int xics_spapr_claim_irq(SpaprInterruptController *intc, int irq,
+                                bool lsi, Error **errp)
+{
+    ICSState *ics =3D ICS_SPAPR(intc);
+
+    assert(ics);
+    assert(ics_valid_irq(ics, irq));
+
+    if (!ics_irq_free(ics, irq - ics->offset)) {
+        error_setg(errp, "IRQ %d is not free", irq);
+        return -EBUSY;
+    }
+
+    ics_set_irq_type(ics, irq - ics->offset, lsi);
+    return 0;
+}
+
+static void xics_spapr_free_irq(SpaprInterruptController *intc, int irq)
+{
+    ICSState *ics =3D ICS_SPAPR(intc);
+    uint32_t srcno =3D irq - ics->offset;
+
+    assert(ics_valid_irq(ics, irq));
+
+    memset(&ics->irqs[srcno], 0, sizeof(ICSIRQState));
+}
+
 static void ics_spapr_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -355,6 +382,8 @@ static void ics_spapr_class_init(ObjectClass *klass, =
void *data)
     device_class_set_parent_realize(dc, ics_spapr_realize,
                                     &isc->parent_realize);
     sicc->cpu_intc_create =3D xics_spapr_cpu_intc_create;
+    sicc->claim_irq =3D xics_spapr_claim_irq;
+    sicc->free_irq =3D xics_spapr_free_irq;
 }
=20
 static const TypeInfo ics_spapr_info =3D {
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index a855dfe4e9..ea44378d8c 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -98,33 +98,6 @@ static void spapr_irq_init_kvm(SpaprMachineState *spap=
r,
  * XICS IRQ backend.
  */
=20
-static int spapr_irq_claim_xics(SpaprMachineState *spapr, int irq, bool =
lsi,
-                                Error **errp)
-{
-    ICSState *ics =3D spapr->ics;
-
-    assert(ics);
-    assert(ics_valid_irq(ics, irq));
-
-    if (!ics_irq_free(ics, irq - ics->offset)) {
-        error_setg(errp, "IRQ %d is not free", irq);
-        return -1;
-    }
-
-    ics_set_irq_type(ics, irq - ics->offset, lsi);
-    return 0;
-}
-
-static void spapr_irq_free_xics(SpaprMachineState *spapr, int irq)
-{
-    ICSState *ics =3D spapr->ics;
-    uint32_t srcno =3D irq - ics->offset;
-
-    assert(ics_valid_irq(ics, irq));
-
-    memset(&ics->irqs[srcno], 0, sizeof(ICSIRQState));
-}
-
 static void spapr_irq_print_info_xics(SpaprMachineState *spapr, Monitor =
*mon)
 {
     CPUState *cs;
@@ -182,8 +155,6 @@ SpaprIrq spapr_irq_xics =3D {
     .xics        =3D true,
     .xive        =3D false,
=20
-    .claim       =3D spapr_irq_claim_xics,
-    .free        =3D spapr_irq_free_xics,
     .print_info  =3D spapr_irq_print_info_xics,
     .dt_populate =3D spapr_dt_xics,
     .post_load   =3D spapr_irq_post_load_xics,
@@ -196,17 +167,6 @@ SpaprIrq spapr_irq_xics =3D {
  * XIVE IRQ backend.
  */
=20
-static int spapr_irq_claim_xive(SpaprMachineState *spapr, int irq, bool =
lsi,
-                                Error **errp)
-{
-    return spapr_xive_irq_claim(spapr->xive, irq, lsi, errp);
-}
-
-static void spapr_irq_free_xive(SpaprMachineState *spapr, int irq)
-{
-    spapr_xive_irq_free(spapr->xive, irq);
-}
-
 static void spapr_irq_print_info_xive(SpaprMachineState *spapr,
                                       Monitor *mon)
 {
@@ -272,8 +232,6 @@ SpaprIrq spapr_irq_xive =3D {
     .xics        =3D false,
     .xive        =3D true,
=20
-    .claim       =3D spapr_irq_claim_xive,
-    .free        =3D spapr_irq_free_xive,
     .print_info  =3D spapr_irq_print_info_xive,
     .dt_populate =3D spapr_dt_xive,
     .post_load   =3D spapr_irq_post_load_xive,
@@ -301,33 +259,6 @@ static SpaprIrq *spapr_irq_current(SpaprMachineState=
 *spapr)
         &spapr_irq_xive : &spapr_irq_xics;
 }
=20
-static int spapr_irq_claim_dual(SpaprMachineState *spapr, int irq, bool =
lsi,
-                                Error **errp)
-{
-    Error *local_err =3D NULL;
-    int ret;
-
-    ret =3D spapr_irq_xics.claim(spapr, irq, lsi, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return ret;
-    }
-
-    ret =3D spapr_irq_xive.claim(spapr, irq, lsi, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return ret;
-    }
-
-    return ret;
-}
-
-static void spapr_irq_free_dual(SpaprMachineState *spapr, int irq)
-{
-    spapr_irq_xics.free(spapr, irq);
-    spapr_irq_xive.free(spapr, irq);
-}
-
 static void spapr_irq_print_info_dual(SpaprMachineState *spapr, Monitor =
*mon)
 {
     spapr_irq_current(spapr)->print_info(spapr, mon);
@@ -401,8 +332,6 @@ SpaprIrq spapr_irq_dual =3D {
     .xics        =3D true,
     .xive        =3D true,
=20
-    .claim       =3D spapr_irq_claim_dual,
-    .free        =3D spapr_irq_free_dual,
     .print_info  =3D spapr_irq_print_info_dual,
     .dt_populate =3D spapr_irq_dt_populate_dual,
     .post_load   =3D spapr_irq_post_load_dual,
@@ -567,10 +496,12 @@ void spapr_irq_init(SpaprMachineState *spapr, Error=
 **errp)
=20
         /* Enable the CPU IPIs */
         for (i =3D 0; i < nr_servers; ++i) {
+            SpaprInterruptControllerClass *sicc
+                =3D SPAPR_INTC_GET_CLASS(spapr->xive);
             Error *local_err =3D NULL;
=20
-            spapr_xive_irq_claim(spapr->xive, SPAPR_IRQ_IPI + i,
-                                 false, &local_err);
+            sicc->claim_irq(SPAPR_INTC(spapr->xive), SPAPR_IRQ_IPI + i,
+                            false, &local_err);
             if (local_err) {
                 goto out;
             }
@@ -588,10 +519,30 @@ out:
=20
 int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error *=
*errp)
 {
+    int rc;
+
     assert(irq >=3D SPAPR_XIRQ_BASE);
     assert(irq < (spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE));
=20
-    return spapr->irq->claim(spapr, irq, lsi, errp);
+    if (spapr->xive) {
+        SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_GET_CLASS(spa=
pr->xive);
+
+        rc =3D sicc->claim_irq(SPAPR_INTC(spapr->xive), irq, lsi, errp);
+        if (rc < 0) {
+            return rc;
+        }
+    }
+
+    if (spapr->ics) {
+        SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_GET_CLASS(spa=
pr->ics);
+
+        rc =3D sicc->claim_irq(SPAPR_INTC(spapr->ics), irq, lsi, errp);
+        if (rc < 0) {
+            return rc;
+        }
+    }
+
+    return 0;
 }
=20
 void spapr_irq_free(SpaprMachineState *spapr, int irq, int num)
@@ -602,7 +553,18 @@ void spapr_irq_free(SpaprMachineState *spapr, int ir=
q, int num)
     assert((irq + num) <=3D (spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE));
=20
     for (i =3D irq; i < (irq + num); i++) {
-        spapr->irq->free(spapr, irq);
+        if (spapr->xive) {
+            SpaprInterruptController *intc =3D SPAPR_INTC(spapr->xive);
+            SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_GET_CLASS=
(intc);
+
+            sicc->free_irq(intc, irq);
+        }
+        if (spapr->ics) {
+            SpaprInterruptController *intc =3D SPAPR_INTC(spapr->ics);
+            SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_GET_CLASS=
(intc);
+
+            sicc->free_irq(intc, irq);
+        }
     }
 }
=20
@@ -727,8 +689,6 @@ SpaprIrq spapr_irq_xics_legacy =3D {
     .xics        =3D true,
     .xive        =3D false,
=20
-    .claim       =3D spapr_irq_claim_xics,
-    .free        =3D spapr_irq_free_xics,
     .print_info  =3D spapr_irq_print_info_xics,
     .dt_populate =3D spapr_dt_xics,
     .post_load   =3D spapr_irq_post_load_xics,
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 30d660ff1e..616086f9bb 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -50,6 +50,9 @@ typedef struct SpaprInterruptControllerClass {
      */
     int (*cpu_intc_create)(SpaprInterruptController *intc,
                             PowerPCCPU *cpu, Error **errp);
+    int (*claim_irq)(SpaprInterruptController *intc, int irq, bool lsi,
+                     Error **errp);
+    void (*free_irq)(SpaprInterruptController *intc, int irq);
 } SpaprInterruptControllerClass;
=20
 void spapr_irq_print_info(SpaprMachineState *spapr, Monitor *mon);
@@ -70,8 +73,6 @@ typedef struct SpaprIrq {
     bool        xics;
     bool        xive;
=20
-    int (*claim)(SpaprMachineState *spapr, int irq, bool lsi, Error **er=
rp);
-    void (*free)(SpaprMachineState *spapr, int irq);
     void (*print_info)(SpaprMachineState *spapr, Monitor *mon);
     void (*dt_populate)(SpaprMachineState *spapr, uint32_t nr_servers,
                         void *fdt, uint32_t phandle);
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 0df20a6590..8f875673f5 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -54,8 +54,6 @@ typedef struct SpaprXive {
  */
 #define SPAPR_XIVE_BLOCK_ID 0x0
=20
-int spapr_xive_irq_claim(SpaprXive *xive, int lisn, bool lsi, Error **er=
rp);
-void spapr_xive_irq_free(SpaprXive *xive, int lisn);
 void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon);
 int spapr_xive_post_load(SpaprXive *xive, int version_id);
=20
--=20
2.21.0


