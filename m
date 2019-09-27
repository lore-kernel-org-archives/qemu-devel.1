Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBE2C352AB
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:06:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 692432196E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ksgB+xnT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692432196E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDjOS-0005dj-EH
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 02:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iDj9R-0006lF-Sk
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 01:50:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iDj9P-0004zT-Lz
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 01:50:45 -0400
Received: from ozlabs.org ([203.11.71.1]:49347)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iDj9P-0004xK-8i; Fri, 27 Sep 2019 01:50:43 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46fgrD3NcCz9sQq; Fri, 27 Sep 2019 15:50:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569563436;
 bh=YXPNmOdI0D/MLLag6ggOeAtwNfrBISaLlPbOXWX/9Yo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ksgB+xnTD7Exk2HjzyUJr0mzc4FVy5F2e2a+ryFPZQx0Dgz3lQO8+gnTxUsnGC9AG
 6arAr47CiJ8bqAC2Z3p83ewPtd9WFfZrN3VLohmGf1Ae37XxvqaF1ku58vNY8Giz4q
 wPFzLiFqf0OROWA2SWdkhI6bleoIsG68xxXcghk8=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org,
	clg@kaod.org,
	qemu-ppc@nongnu.org
Subject: [PATCH v2 09/33] spapr: Clarify and fix handling of nr_irqs
Date: Fri, 27 Sep 2019 15:50:04 +1000
Message-Id: <20190927055028.11493-10-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190927055028.11493-1-david@gibson.dropbear.id.au>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
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
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Both the XICS and XIVE interrupt backends have a "nr-irqs" property, but
it means slightly different things.  For XICS (or, strictly, the ICS) it
indicates the number of "real" external IRQs.  Those start at XICS_IRQ_BA=
SE
(0x1000) and don't include the special IPI vector.  For XIVE, however, it
includes the whole IRQ space, including XIVE's many IPI vectors.

The spapr code currently doesn't handle this sensibly, with the
nr_irqs value in SpaprIrq having different meanings depending on the
backend.  We fix this by renaming nr_irqs to nr_xirqs and making it
always indicate just the number of external irqs, adjusting the value
we pass to XIVE accordingly.  We also move to using common constants
in most of the irq configurations, to make it clearer that the IRQ
space looks the same to the guest (and emulated devices), even if the
backend is different.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_irq.c         | 53 ++++++++++++++------------------------
 include/hw/ppc/spapr_irq.h | 19 +++++++++-----
 2 files changed, 31 insertions(+), 41 deletions(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 8c26fa2d1e..3207b6bd01 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -92,7 +92,7 @@ static void spapr_irq_init_kvm(SpaprMachineState *spapr=
,
  * XICS IRQ backend.
  */
=20
-static void spapr_irq_init_xics(SpaprMachineState *spapr, int nr_irqs,
+static void spapr_irq_init_xics(SpaprMachineState *spapr, int nr_xirqs,
                                 Error **errp)
 {
     Object *obj;
@@ -102,7 +102,7 @@ static void spapr_irq_init_xics(SpaprMachineState *sp=
apr, int nr_irqs,
     object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
     object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
                                    &error_fatal);
-    object_property_set_int(obj, nr_irqs, "nr-irqs",  &error_fatal);
+    object_property_set_int(obj, nr_xirqs, "nr-irqs",  &error_fatal);
     object_property_set_bool(obj, true, "realized", &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -234,13 +234,9 @@ static void spapr_irq_init_kvm_xics(SpaprMachineStat=
e *spapr, Error **errp)
     }
 }
=20
-#define SPAPR_IRQ_XICS_NR_IRQS     0x1000
-#define SPAPR_IRQ_XICS_NR_MSIS     \
-    (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
-
 SpaprIrq spapr_irq_xics =3D {
-    .nr_irqs     =3D SPAPR_IRQ_XICS_NR_IRQS,
-    .nr_msis     =3D SPAPR_IRQ_XICS_NR_MSIS,
+    .nr_xirqs    =3D SPAPR_NR_XIRQS,
+    .nr_msis     =3D SPAPR_NR_MSIS,
     .ov5         =3D SPAPR_OV5_XIVE_LEGACY,
=20
     .init        =3D spapr_irq_init_xics,
@@ -260,7 +256,7 @@ SpaprIrq spapr_irq_xics =3D {
 /*
  * XIVE IRQ backend.
  */
-static void spapr_irq_init_xive(SpaprMachineState *spapr, int nr_irqs,
+static void spapr_irq_init_xive(SpaprMachineState *spapr, int nr_xirqs,
                                 Error **errp)
 {
     uint32_t nr_servers =3D spapr_max_server_number(spapr);
@@ -268,7 +264,7 @@ static void spapr_irq_init_xive(SpaprMachineState *sp=
apr, int nr_irqs,
     int i;
=20
     dev =3D qdev_create(NULL, TYPE_SPAPR_XIVE);
-    qdev_prop_set_uint32(dev, "nr-irqs", nr_irqs);
+    qdev_prop_set_uint32(dev, "nr-irqs", nr_xirqs + SPAPR_XIRQ_BASE);
     /*
      * 8 XIVE END structures per CPU. One for each available priority
      */
@@ -308,7 +304,7 @@ static qemu_irq spapr_qirq_xive(SpaprMachineState *sp=
apr, int irq)
 {
     SpaprXive *xive =3D spapr->xive;
=20
-    if (irq >=3D xive->nr_irqs) {
+    if ((irq < SPAPR_XIRQ_BASE) || (irq >=3D xive->nr_irqs)) {
         return NULL;
     }
=20
@@ -404,17 +400,9 @@ static void spapr_irq_init_kvm_xive(SpaprMachineStat=
e *spapr, Error **errp)
     }
 }
=20
-/*
- * XIVE uses the full IRQ number space. Set it to 8K to be compatible
- * with XICS.
- */
-
-#define SPAPR_IRQ_XIVE_NR_IRQS     0x2000
-#define SPAPR_IRQ_XIVE_NR_MSIS     (SPAPR_IRQ_XIVE_NR_IRQS - SPAPR_IRQ_M=
SI)
-
 SpaprIrq spapr_irq_xive =3D {
-    .nr_irqs     =3D SPAPR_IRQ_XIVE_NR_IRQS,
-    .nr_msis     =3D SPAPR_IRQ_XIVE_NR_MSIS,
+    .nr_xirqs    =3D SPAPR_NR_XIRQS,
+    .nr_msis     =3D SPAPR_NR_MSIS,
     .ov5         =3D SPAPR_OV5_XIVE_EXPLOIT,
=20
     .init        =3D spapr_irq_init_xive,
@@ -450,18 +438,18 @@ static SpaprIrq *spapr_irq_current(SpaprMachineStat=
e *spapr)
         &spapr_irq_xive : &spapr_irq_xics;
 }
=20
-static void spapr_irq_init_dual(SpaprMachineState *spapr, int nr_irqs,
+static void spapr_irq_init_dual(SpaprMachineState *spapr, int nr_xirqs,
                                 Error **errp)
 {
     Error *local_err =3D NULL;
=20
-    spapr_irq_xics.init(spapr, spapr_irq_xics.nr_irqs, &local_err);
+    spapr_irq_xics.init(spapr, spapr_irq_xics.nr_xirqs, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
=20
-    spapr_irq_xive.init(spapr, spapr_irq_xive.nr_irqs, &local_err);
+    spapr_irq_xive.init(spapr, spapr_irq_xive.nr_xirqs, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -586,12 +574,9 @@ static const char *spapr_irq_get_nodename_dual(Spapr=
MachineState *spapr)
 /*
  * Define values in sync with the XIVE and XICS backend
  */
-#define SPAPR_IRQ_DUAL_NR_IRQS     0x2000
-#define SPAPR_IRQ_DUAL_NR_MSIS     (SPAPR_IRQ_DUAL_NR_IRQS - SPAPR_IRQ_M=
SI)
-
 SpaprIrq spapr_irq_dual =3D {
-    .nr_irqs     =3D SPAPR_IRQ_DUAL_NR_IRQS,
-    .nr_msis     =3D SPAPR_IRQ_DUAL_NR_MSIS,
+    .nr_xirqs    =3D SPAPR_NR_XIRQS,
+    .nr_msis     =3D SPAPR_NR_MSIS,
     .ov5         =3D SPAPR_OV5_XIVE_BOTH,
=20
     .init        =3D spapr_irq_init_dual,
@@ -693,10 +678,10 @@ void spapr_irq_init(SpaprMachineState *spapr, Error=
 **errp)
         spapr_irq_msi_init(spapr, spapr->irq->nr_msis);
     }
=20
-    spapr->irq->init(spapr, spapr->irq->nr_irqs, errp);
+    spapr->irq->init(spapr, spapr->irq->nr_xirqs, errp);
=20
     spapr->qirqs =3D qemu_allocate_irqs(spapr->irq->set_irq, spapr,
-                                      spapr->irq->nr_irqs);
+                                      spapr->irq->nr_xirqs + SPAPR_XIRQ_=
BASE);
 }
=20
 int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error *=
*errp)
@@ -804,11 +789,11 @@ int spapr_irq_find(SpaprMachineState *spapr, int nu=
m, bool align, Error **errp)
     return first + ics->offset;
 }
=20
-#define SPAPR_IRQ_XICS_LEGACY_NR_IRQS     0x400
+#define SPAPR_IRQ_XICS_LEGACY_NR_XIRQS     0x400
=20
 SpaprIrq spapr_irq_xics_legacy =3D {
-    .nr_irqs     =3D SPAPR_IRQ_XICS_LEGACY_NR_IRQS,
-    .nr_msis     =3D SPAPR_IRQ_XICS_LEGACY_NR_IRQS,
+    .nr_xirqs    =3D SPAPR_IRQ_XICS_LEGACY_NR_XIRQS,
+    .nr_msis     =3D SPAPR_IRQ_XICS_LEGACY_NR_XIRQS,
     .ov5         =3D SPAPR_OV5_XIVE_LEGACY,
=20
     .init        =3D spapr_irq_init_xics,
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 5db305165c..a8f9a2ab11 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -16,13 +16,18 @@
  * IRQ range offsets per device type
  */
 #define SPAPR_IRQ_IPI        0x0
-#define SPAPR_IRQ_EPOW       0x1000  /* XICS_IRQ_BASE offset */
-#define SPAPR_IRQ_HOTPLUG    0x1001
-#define SPAPR_IRQ_VIO        0x1100  /* 256 VIO devices */
-#define SPAPR_IRQ_PCI_LSI    0x1200  /* 32+ PHBs devices */
=20
-#define SPAPR_IRQ_MSI        0x1300  /* Offset of the dynamic range cove=
red
-                                      * by the bitmap allocator */
+#define SPAPR_XIRQ_BASE      XICS_IRQ_BASE /* 0x1000 */
+#define SPAPR_IRQ_EPOW       (SPAPR_XIRQ_BASE + 0x0000)
+#define SPAPR_IRQ_HOTPLUG    (SPAPR_XIRQ_BASE + 0x0001)
+#define SPAPR_IRQ_VIO        (SPAPR_XIRQ_BASE + 0x0100)  /* 256 VIO devi=
ces */
+#define SPAPR_IRQ_PCI_LSI    (SPAPR_XIRQ_BASE + 0x0200)  /* 32+ PHBs dev=
ices */
+
+/* Offset of the dynamic range covered by the bitmap allocator */
+#define SPAPR_IRQ_MSI        (SPAPR_XIRQ_BASE + 0x0300)
+
+#define SPAPR_NR_XIRQS       0x1000
+#define SPAPR_NR_MSIS        (SPAPR_XIRQ_BASE + SPAPR_NR_XIRQS - SPAPR_I=
RQ_MSI)
=20
 typedef struct SpaprMachineState SpaprMachineState;
=20
@@ -32,7 +37,7 @@ int spapr_irq_msi_alloc(SpaprMachineState *spapr, uint3=
2_t num, bool align,
 void spapr_irq_msi_free(SpaprMachineState *spapr, int irq, uint32_t num)=
;
=20
 typedef struct SpaprIrq {
-    uint32_t    nr_irqs;
+    uint32_t    nr_xirqs;
     uint32_t    nr_msis;
     uint8_t     ov5;
=20
--=20
2.21.0


