Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F82CC47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:00:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DBA521848
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="iwLEGMbo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DBA521848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIFJb-00017B-E6
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 12:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60065)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iI59E-0001Xj-PG
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 02:08:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iI59D-0006XU-2R
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 02:08:32 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54929 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iI59C-0006Uf-Jn; Wed, 09 Oct 2019 02:08:30 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46p3gD67TJz9sQy; Wed,  9 Oct 2019 17:08:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570601304;
 bh=Ab9C6EnO+kA6bxgu5OZl2lcLxTVVDXXeqlil5mmBZOk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iwLEGMbo2DPukU9uycDbzp/AEj2P8NGqBUFraCVEdt2/jykTrzh7YR+vSJwkyHuMg
 m6iy/USZ3IycnNSZDWcbdgIp5ZYvo3lj74HGUYyf080U4zj0206iHDJmXTlfm8faUv
 CyhEPjinjEVFtyEx4KbSnZl8AQYjHjy8CYj67pjU=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org,
	clg@kaod.org,
	qemu-ppc@nongnu.org
Subject: [PATCH v4 08/19] spapr, xics,
 xive: Move set_irq from SpaprIrq to SpaprInterruptController
Date: Wed,  9 Oct 2019 17:08:07 +1100
Message-Id: <20191009060818.29719-9-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191009060818.29719-1-david@gibson.dropbear.id.au>
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
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

This method depends only on the active irq controller.  Now that we've
formalized the notion of active controller we can dispatch directly throu=
gh
that, rather than dispatching via SpaprIrq with the dual version having
to do a second conditional dispatch.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/spapr_xive.c       | 12 +++++++++++
 hw/intc/xics_spapr.c       |  9 +++++++++
 hw/ppc/spapr_irq.c         | 41 ++++++++++----------------------------
 include/hw/ppc/spapr_irq.h |  4 +++-
 4 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index ff1a175b44..52d5e71793 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -553,6 +553,17 @@ static int spapr_xive_cpu_intc_create(SpaprInterrupt=
Controller *intc,
     return 0;
 }
=20
+static void spapr_xive_set_irq(SpaprInterruptController *intc, int irq, =
int val)
+{
+    SpaprXive *xive =3D SPAPR_XIVE(intc);
+
+    if (kvm_irqchip_in_kernel()) {
+        kvmppc_xive_source_set_irq(&xive->source, irq, val);
+    } else {
+        xive_source_set_irq(&xive->source, irq, val);
+    }
+}
+
 static void spapr_xive_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -574,6 +585,7 @@ static void spapr_xive_class_init(ObjectClass *klass,=
 void *data)
     sicc->cpu_intc_create =3D spapr_xive_cpu_intc_create;
     sicc->claim_irq =3D spapr_xive_claim_irq;
     sicc->free_irq =3D spapr_xive_free_irq;
+    sicc->set_irq =3D spapr_xive_set_irq;
 }
=20
 static const TypeInfo spapr_xive_info =3D {
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 224fe1efcd..02372697f6 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -373,6 +373,14 @@ static void xics_spapr_free_irq(SpaprInterruptContro=
ller *intc, int irq)
     memset(&ics->irqs[srcno], 0, sizeof(ICSIRQState));
 }
=20
+static void xics_spapr_set_irq(SpaprInterruptController *intc, int irq, =
int val)
+{
+    ICSState *ics =3D ICS_SPAPR(intc);
+    uint32_t srcno =3D irq - ics->offset;
+
+    ics_set_irq(ics, srcno, val);
+}
+
 static void ics_spapr_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -384,6 +392,7 @@ static void ics_spapr_class_init(ObjectClass *klass, =
void *data)
     sicc->cpu_intc_create =3D xics_spapr_cpu_intc_create;
     sicc->claim_irq =3D xics_spapr_claim_irq;
     sicc->free_irq =3D xics_spapr_free_irq;
+    sicc->set_irq =3D xics_spapr_set_irq;
 }
=20
 static const TypeInfo ics_spapr_info =3D {
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 249a2688ac..bfccb815ed 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -123,14 +123,6 @@ static int spapr_irq_post_load_xics(SpaprMachineStat=
e *spapr, int version_id)
     return 0;
 }
=20
-static void spapr_irq_set_irq_xics(void *opaque, int irq, int val)
-{
-    SpaprMachineState *spapr =3D opaque;
-    uint32_t srcno =3D irq - spapr->ics->offset;
-
-    ics_set_irq(spapr->ics, srcno, val);
-}
-
 static void spapr_irq_reset_xics(SpaprMachineState *spapr, Error **errp)
 {
     Error *local_err =3D NULL;
@@ -159,7 +151,6 @@ SpaprIrq spapr_irq_xics =3D {
     .dt_populate =3D spapr_dt_xics,
     .post_load   =3D spapr_irq_post_load_xics,
     .reset       =3D spapr_irq_reset_xics,
-    .set_irq     =3D spapr_irq_set_irq_xics,
     .init_kvm    =3D spapr_irq_init_kvm_xics,
 };
=20
@@ -208,17 +199,6 @@ static void spapr_irq_reset_xive(SpaprMachineState *=
spapr, Error **errp)
     spapr_xive_mmio_set_enabled(spapr->xive, true);
 }
=20
-static void spapr_irq_set_irq_xive(void *opaque, int irq, int val)
-{
-    SpaprMachineState *spapr =3D opaque;
-
-    if (kvm_irqchip_in_kernel()) {
-        kvmppc_xive_source_set_irq(&spapr->xive->source, irq, val);
-    } else {
-        xive_source_set_irq(&spapr->xive->source, irq, val);
-    }
-}
-
 static void spapr_irq_init_kvm_xive(SpaprMachineState *spapr, Error **er=
rp)
 {
     if (kvm_enabled()) {
@@ -236,7 +216,6 @@ SpaprIrq spapr_irq_xive =3D {
     .dt_populate =3D spapr_dt_xive,
     .post_load   =3D spapr_irq_post_load_xive,
     .reset       =3D spapr_irq_reset_xive,
-    .set_irq     =3D spapr_irq_set_irq_xive,
     .init_kvm    =3D spapr_irq_init_kvm_xive,
 };
=20
@@ -316,13 +295,6 @@ static void spapr_irq_reset_dual(SpaprMachineState *=
spapr, Error **errp)
     spapr_irq_current(spapr)->reset(spapr, errp);
 }
=20
-static void spapr_irq_set_irq_dual(void *opaque, int irq, int val)
-{
-    SpaprMachineState *spapr =3D opaque;
-
-    spapr_irq_current(spapr)->set_irq(spapr, irq, val);
-}
-
 /*
  * Define values in sync with the XIVE and XICS backend
  */
@@ -336,7 +308,6 @@ SpaprIrq spapr_irq_dual =3D {
     .dt_populate =3D spapr_irq_dt_populate_dual,
     .post_load   =3D spapr_irq_post_load_dual,
     .reset       =3D spapr_irq_reset_dual,
-    .set_irq     =3D spapr_irq_set_irq_dual,
     .init_kvm    =3D NULL, /* should not be used */
 };
=20
@@ -424,6 +395,15 @@ int spapr_irq_cpu_intc_create(SpaprMachineState *spa=
pr,
     return 0;
 }
=20
+static void spapr_set_irq(void *opaque, int irq, int level)
+{
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(opaque);
+    SpaprInterruptControllerClass *sicc
+        =3D SPAPR_INTC_GET_CLASS(spapr->active_intc);
+
+    sicc->set_irq(spapr->active_intc, irq, level);
+}
+
 void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
 {
     MachineState *machine =3D MACHINE(spapr);
@@ -513,7 +493,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error *=
*errp)
         spapr_xive_hcall_init(spapr);
     }
=20
-    spapr->qirqs =3D qemu_allocate_irqs(spapr->irq->set_irq, spapr,
+    spapr->qirqs =3D qemu_allocate_irqs(spapr_set_irq, spapr,
                                       spapr->irq->nr_xirqs + SPAPR_XIRQ_=
BASE);
 }
=20
@@ -737,7 +717,6 @@ SpaprIrq spapr_irq_xics_legacy =3D {
     .dt_populate =3D spapr_dt_xics,
     .post_load   =3D spapr_irq_post_load_xics,
     .reset       =3D spapr_irq_reset_xics,
-    .set_irq     =3D spapr_irq_set_irq_xics,
     .init_kvm    =3D spapr_irq_init_kvm_xics,
 };
=20
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 593059eff5..ece8d2ea48 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -56,6 +56,9 @@ typedef struct SpaprInterruptControllerClass {
     int (*claim_irq)(SpaprInterruptController *intc, int irq, bool lsi,
                      Error **errp);
     void (*free_irq)(SpaprInterruptController *intc, int irq);
+
+    /* These methods should only be called on the active intc */
+    void (*set_irq)(SpaprInterruptController *intc, int irq, int val);
 } SpaprInterruptControllerClass;
=20
 void spapr_irq_update_active_intc(SpaprMachineState *spapr);
@@ -80,7 +83,6 @@ typedef struct SpaprIrq {
                         void *fdt, uint32_t phandle);
     int (*post_load)(SpaprMachineState *spapr, int version_id);
     void (*reset)(SpaprMachineState *spapr, Error **errp);
-    void (*set_irq)(void *opaque, int srcno, int val);
     void (*init_kvm)(SpaprMachineState *spapr, Error **errp);
 } SpaprIrq;
=20
--=20
2.21.0


