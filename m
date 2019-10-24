Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B212CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:36:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 845ED205ED
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nAhoyMbd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845ED205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNYbe-0005rx-Ei
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 04:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iNYKX-0004sA-0j
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iNYKU-0005EZ-Jv
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:18:48 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60747 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iNYKU-00057d-6X; Thu, 24 Oct 2019 04:18:46 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46zKrZ6x1sz9sS9; Thu, 24 Oct 2019 19:18:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571905118;
 bh=EnkOd+cFS560IbTJUs1/5e/f7lteTIS2I3MFC/TeA6g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nAhoyMbdzu2GTDVXh6Ec6fJ7uenYfeKkEiAhB9IZZi8tqtBgRl5xyXBGU1GIoy/3f
 OgGJuSeW2O3yhha49KTIKpJR4EcX4cVfLg0TqocN0O1tuwOWr1MoMINMDLkjJjIh4R
 R8jzQfN6jSxEtbv+VanRn54wlDs8+IMVoLw2UT8I=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 17/28] spapr, xics,
 xive: Move SpaprIrq::post_load hook to backends
Date: Thu, 24 Oct 2019 19:18:02 +1100
Message-Id: <20191024081813.2115-18-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191024081813.2115-1-david@gibson.dropbear.id.au>
References: <20191024081813.2115-1-david@gibson.dropbear.id.au>
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

The remaining logic in the post_load hook really belongs to the interrupt
controller backends, and just needs to be called on the active controller
(after the active controller is set to the right thing based on the
incoming migration in the generic spapr_irq_post_load() logic).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive.c        |  5 +++--
 hw/intc/xics_spapr.c        | 13 +++++++++++
 hw/ppc/spapr_irq.c          | 45 ++++---------------------------------
 include/hw/ppc/spapr_irq.h  |  3 +--
 include/hw/ppc/spapr_xive.h |  1 -
 5 files changed, 21 insertions(+), 46 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 1811653aac..ba32d2cc5b 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -462,10 +462,10 @@ static int vmstate_spapr_xive_pre_save(void *opaque=
)
  * Called by the sPAPR IRQ backend 'post_load' method at the machine
  * level.
  */
-int spapr_xive_post_load(SpaprXive *xive, int version_id)
+static int spapr_xive_post_load(SpaprInterruptController *intc, int vers=
ion_id)
 {
     if (kvm_irqchip_in_kernel()) {
-        return kvmppc_xive_post_load(xive, version_id);
+        return kvmppc_xive_post_load(SPAPR_XIVE(intc), version_id);
     }
=20
     return 0;
@@ -702,6 +702,7 @@ static void spapr_xive_class_init(ObjectClass *klass,=
 void *data)
     sicc->set_irq =3D spapr_xive_set_irq;
     sicc->print_info =3D spapr_xive_print_info;
     sicc->dt =3D spapr_xive_dt;
+    sicc->post_load =3D spapr_xive_post_load;
 }
=20
 static const TypeInfo spapr_xive_info =3D {
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 90b4d48877..4f64b9a9fc 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -395,6 +395,18 @@ static void xics_spapr_print_info(SpaprInterruptCont=
roller *intc, Monitor *mon)
     ics_pic_print_info(ics, mon);
 }
=20
+static int xics_spapr_post_load(SpaprInterruptController *intc, int vers=
ion_id)
+{
+    if (!kvm_irqchip_in_kernel()) {
+        CPUState *cs;
+        CPU_FOREACH(cs) {
+            PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+            icp_resend(spapr_cpu_state(cpu)->icp);
+        }
+    }
+    return 0;
+}
+
 static int xics_spapr_activate(SpaprInterruptController *intc, Error **e=
rrp)
 {
     if (kvm_enabled()) {
@@ -426,6 +438,7 @@ static void ics_spapr_class_init(ObjectClass *klass, =
void *data)
     sicc->set_irq =3D xics_spapr_set_irq;
     sicc->print_info =3D xics_spapr_print_info;
     sicc->dt =3D xics_spapr_dt;
+    sicc->post_load =3D xics_spapr_post_load;
 }
=20
 static const TypeInfo ics_spapr_info =3D {
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index f70b331f44..f3d18b1dad 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -100,43 +100,22 @@ int spapr_irq_init_kvm(int (*fn)(SpaprInterruptCont=
roller *, Error **),
  * XICS IRQ backend.
  */
=20
-static int spapr_irq_post_load_xics(SpaprMachineState *spapr, int versio=
n_id)
-{
-    if (!kvm_irqchip_in_kernel()) {
-        CPUState *cs;
-        CPU_FOREACH(cs) {
-            PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-            icp_resend(spapr_cpu_state(cpu)->icp);
-        }
-    }
-    return 0;
-}
-
 SpaprIrq spapr_irq_xics =3D {
     .nr_xirqs    =3D SPAPR_NR_XIRQS,
     .nr_msis     =3D SPAPR_NR_MSIS,
     .xics        =3D true,
     .xive        =3D false,
-
-    .post_load   =3D spapr_irq_post_load_xics,
 };
=20
 /*
  * XIVE IRQ backend.
  */
=20
-static int spapr_irq_post_load_xive(SpaprMachineState *spapr, int versio=
n_id)
-{
-    return spapr_xive_post_load(spapr->xive, version_id);
-}
-
 SpaprIrq spapr_irq_xive =3D {
     .nr_xirqs    =3D SPAPR_NR_XIRQS,
     .nr_msis     =3D SPAPR_NR_MSIS,
     .xics        =3D false,
     .xive        =3D true,
-
-    .post_load   =3D spapr_irq_post_load_xive,
 };
=20
 /*
@@ -148,21 +127,6 @@ SpaprIrq spapr_irq_xive =3D {
  * activated after an extra machine reset.
  */
=20
-/*
- * Returns the sPAPR IRQ backend negotiated by CAS. XICS is the
- * default.
- */
-static SpaprIrq *spapr_irq_current(SpaprMachineState *spapr)
-{
-    return spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT) ?
-        &spapr_irq_xive : &spapr_irq_xics;
-}
-
-static int spapr_irq_post_load_dual(SpaprMachineState *spapr, int versio=
n_id)
-{
-    return spapr_irq_current(spapr)->post_load(spapr, version_id);
-}
-
 /*
  * Define values in sync with the XIVE and XICS backend
  */
@@ -171,8 +135,6 @@ SpaprIrq spapr_irq_dual =3D {
     .nr_msis     =3D SPAPR_NR_MSIS,
     .xics        =3D true,
     .xive        =3D true,
-
-    .post_load   =3D spapr_irq_post_load_dual,
 };
=20
=20
@@ -447,8 +409,11 @@ qemu_irq spapr_qirq(SpaprMachineState *spapr, int ir=
q)
=20
 int spapr_irq_post_load(SpaprMachineState *spapr, int version_id)
 {
+    SpaprInterruptControllerClass *sicc;
+
     spapr_irq_update_active_intc(spapr);
-    return spapr->irq->post_load(spapr, version_id);
+    sicc =3D SPAPR_INTC_GET_CLASS(spapr->active_intc);
+    return sicc->post_load(spapr->active_intc, version_id);
 }
=20
 void spapr_irq_reset(SpaprMachineState *spapr, Error **errp)
@@ -589,8 +554,6 @@ SpaprIrq spapr_irq_xics_legacy =3D {
     .nr_msis     =3D SPAPR_IRQ_XICS_LEGACY_NR_XIRQS,
     .xics        =3D true,
     .xive        =3D false,
-
-    .post_load   =3D spapr_irq_post_load_xics,
 };
=20
 static void spapr_irq_register_types(void)
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index e02e44624b..08173e714c 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -62,6 +62,7 @@ typedef struct SpaprInterruptControllerClass {
     void (*print_info)(SpaprInterruptController *intc, Monitor *mon);
     void (*dt)(SpaprInterruptController *intc, uint32_t nr_servers,
                void *fdt, uint32_t phandle);
+    int (*post_load)(SpaprInterruptController *intc, int version_id);
 } SpaprInterruptControllerClass;
=20
 void spapr_irq_update_active_intc(SpaprMachineState *spapr);
@@ -82,8 +83,6 @@ typedef struct SpaprIrq {
     uint32_t    nr_msis;
     bool        xics;
     bool        xive;
-
-    int (*post_load)(SpaprMachineState *spapr, int version_id);
 } SpaprIrq;
=20
 extern SpaprIrq spapr_irq_xics;
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 64972754f9..d84bd5c229 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -55,7 +55,6 @@ typedef struct SpaprXive {
 #define SPAPR_XIVE_BLOCK_ID 0x0
=20
 void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon);
-int spapr_xive_post_load(SpaprXive *xive, int version_id);
=20
 void spapr_xive_hcall_init(SpaprMachineState *spapr);
 void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx);
--=20
2.21.0


