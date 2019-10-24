Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D41CA9EBB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:23:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2F1220856
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DtLNTJv+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F1220856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNYPL-0006C4-F4
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 04:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iNYKT-0004kZ-Hz
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:18:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iNYKR-00056H-Uh
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:18:45 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:32983 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iNYKR-00050T-H5; Thu, 24 Oct 2019 04:18:43 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46zKrY6my7z9sRX; Thu, 24 Oct 2019 19:18:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571905117;
 bh=Y4tlqaw+1bOhPtsgVo+T80XZay4GmD5LhgnqMj46KQ8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DtLNTJv+21gKzUUYd7v+3nbr55tFKpbXJK/4VjYlU19tRhWYRIwDR98mm8E9tuuUT
 q4JvUI9tfBlgxKMlP1/lZCR8lrjTtT2CLpZZFhPyMtZo+S5X+TT7d5gf/sD92+kJVJ
 1LeOozWevsmgni0059K5y2CL/EJWn5NsS5LnTCg8=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 12/28] spapr, xics,
 xive: Move print_info from SpaprIrq to SpaprInterruptController
Date: Thu, 24 Oct 2019 19:17:57 +1100
Message-Id: <20191024081813.2115-13-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191024081813.2115-1-david@gibson.dropbear.id.au>
References: <20191024081813.2115-1-david@gibson.dropbear.id.au>
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

This method depends only on the active irq controller.  Now that we've
formalized the notion of active controller we can dispatch directly
through that, rather than dispatching via SpaprIrq with the dual
version having to do a second conditional dispatch.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive.c       | 15 +++++++++++++
 hw/intc/xics_spapr.c       | 15 +++++++++++++
 hw/ppc/spapr.c             |  2 +-
 hw/ppc/spapr_irq.c         | 44 +++++++-------------------------------
 include/hw/ppc/spapr_irq.h |  4 ++--
 5 files changed, 41 insertions(+), 39 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 52d5e71793..700ec5c9c1 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -564,6 +564,20 @@ static void spapr_xive_set_irq(SpaprInterruptControl=
ler *intc, int irq, int val)
     }
 }
=20
+static void spapr_xive_print_info(SpaprInterruptController *intc, Monito=
r *mon)
+{
+    SpaprXive *xive =3D SPAPR_XIVE(intc);
+    CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+
+        xive_tctx_pic_print_info(spapr_cpu_state(cpu)->tctx, mon);
+    }
+
+    spapr_xive_pic_print_info(xive, mon);
+}
+
 static void spapr_xive_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -586,6 +600,7 @@ static void spapr_xive_class_init(ObjectClass *klass,=
 void *data)
     sicc->claim_irq =3D spapr_xive_claim_irq;
     sicc->free_irq =3D spapr_xive_free_irq;
     sicc->set_irq =3D spapr_xive_set_irq;
+    sicc->print_info =3D spapr_xive_print_info;
 }
=20
 static const TypeInfo spapr_xive_info =3D {
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 02372697f6..415defe394 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -381,6 +381,20 @@ static void xics_spapr_set_irq(SpaprInterruptControl=
ler *intc, int irq, int val)
     ics_set_irq(ics, srcno, val);
 }
=20
+static void xics_spapr_print_info(SpaprInterruptController *intc, Monito=
r *mon)
+{
+    ICSState *ics =3D ICS_SPAPR(intc);
+    CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+
+        icp_pic_print_info(spapr_cpu_state(cpu)->icp, mon);
+    }
+
+    ics_pic_print_info(ics, mon);
+}
+
 static void ics_spapr_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -393,6 +407,7 @@ static void ics_spapr_class_init(ObjectClass *klass, =
void *data)
     sicc->claim_irq =3D xics_spapr_claim_irq;
     sicc->free_irq =3D xics_spapr_free_irq;
     sicc->set_irq =3D xics_spapr_set_irq;
+    sicc->print_info =3D xics_spapr_print_info;
 }
=20
 static const TypeInfo ics_spapr_info =3D {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 428b834f30..24fe12b244 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4266,7 +4266,7 @@ static void spapr_pic_print_info(InterruptStatsProv=
ider *obj,
 {
     SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
=20
-    spapr->irq->print_info(spapr, mon);
+    spapr_irq_print_info(spapr, mon);
     monitor_printf(mon, "irqchip: %s\n",
                    kvm_irqchip_in_kernel() ? "in-kernel" : "emulated");
 }
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index bfccb815ed..a29b527232 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -98,19 +98,6 @@ static void spapr_irq_init_kvm(SpaprMachineState *spap=
r,
  * XICS IRQ backend.
  */
=20
-static void spapr_irq_print_info_xics(SpaprMachineState *spapr, Monitor =
*mon)
-{
-    CPUState *cs;
-
-    CPU_FOREACH(cs) {
-        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-
-        icp_pic_print_info(spapr_cpu_state(cpu)->icp, mon);
-    }
-
-    ics_pic_print_info(spapr->ics, mon);
-}
-
 static int spapr_irq_post_load_xics(SpaprMachineState *spapr, int versio=
n_id)
 {
     if (!kvm_irqchip_in_kernel()) {
@@ -147,7 +134,6 @@ SpaprIrq spapr_irq_xics =3D {
     .xics        =3D true,
     .xive        =3D false,
=20
-    .print_info  =3D spapr_irq_print_info_xics,
     .dt_populate =3D spapr_dt_xics,
     .post_load   =3D spapr_irq_post_load_xics,
     .reset       =3D spapr_irq_reset_xics,
@@ -158,20 +144,6 @@ SpaprIrq spapr_irq_xics =3D {
  * XIVE IRQ backend.
  */
=20
-static void spapr_irq_print_info_xive(SpaprMachineState *spapr,
-                                      Monitor *mon)
-{
-    CPUState *cs;
-
-    CPU_FOREACH(cs) {
-        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-
-        xive_tctx_pic_print_info(spapr_cpu_state(cpu)->tctx, mon);
-    }
-
-    spapr_xive_pic_print_info(spapr->xive, mon);
-}
-
 static int spapr_irq_post_load_xive(SpaprMachineState *spapr, int versio=
n_id)
 {
     return spapr_xive_post_load(spapr->xive, version_id);
@@ -212,7 +184,6 @@ SpaprIrq spapr_irq_xive =3D {
     .xics        =3D false,
     .xive        =3D true,
=20
-    .print_info  =3D spapr_irq_print_info_xive,
     .dt_populate =3D spapr_dt_xive,
     .post_load   =3D spapr_irq_post_load_xive,
     .reset       =3D spapr_irq_reset_xive,
@@ -238,11 +209,6 @@ static SpaprIrq *spapr_irq_current(SpaprMachineState=
 *spapr)
         &spapr_irq_xive : &spapr_irq_xics;
 }
=20
-static void spapr_irq_print_info_dual(SpaprMachineState *spapr, Monitor =
*mon)
-{
-    spapr_irq_current(spapr)->print_info(spapr, mon);
-}
-
 static void spapr_irq_dt_populate_dual(SpaprMachineState *spapr,
                                        uint32_t nr_servers, void *fdt,
                                        uint32_t phandle)
@@ -304,7 +270,6 @@ SpaprIrq spapr_irq_dual =3D {
     .xics        =3D true,
     .xive        =3D true,
=20
-    .print_info  =3D spapr_irq_print_info_dual,
     .dt_populate =3D spapr_irq_dt_populate_dual,
     .post_load   =3D spapr_irq_post_load_dual,
     .reset       =3D spapr_irq_reset_dual,
@@ -404,6 +369,14 @@ static void spapr_set_irq(void *opaque, int irq, int=
 level)
     sicc->set_irq(spapr->active_intc, irq, level);
 }
=20
+void spapr_irq_print_info(SpaprMachineState *spapr, Monitor *mon)
+{
+    SpaprInterruptControllerClass *sicc
+        =3D SPAPR_INTC_GET_CLASS(spapr->active_intc);
+
+    sicc->print_info(spapr->active_intc, mon);
+}
+
 void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
 {
     MachineState *machine =3D MACHINE(spapr);
@@ -713,7 +686,6 @@ SpaprIrq spapr_irq_xics_legacy =3D {
     .xics        =3D true,
     .xive        =3D false,
=20
-    .print_info  =3D spapr_irq_print_info_xics,
     .dt_populate =3D spapr_dt_xics,
     .post_load   =3D spapr_irq_post_load_xics,
     .reset       =3D spapr_irq_reset_xics,
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index ece8d2ea48..bdfeb3b107 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -59,13 +59,14 @@ typedef struct SpaprInterruptControllerClass {
=20
     /* These methods should only be called on the active intc */
     void (*set_irq)(SpaprInterruptController *intc, int irq, int val);
+    void (*print_info)(SpaprInterruptController *intc, Monitor *mon);
 } SpaprInterruptControllerClass;
=20
 void spapr_irq_update_active_intc(SpaprMachineState *spapr);
=20
 int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
                               PowerPCCPU *cpu, Error **errp);
-
+void spapr_irq_print_info(SpaprMachineState *spapr, Monitor *mon);
=20
 void spapr_irq_msi_init(SpaprMachineState *spapr, uint32_t nr_msis);
 int spapr_irq_msi_alloc(SpaprMachineState *spapr, uint32_t num, bool ali=
gn,
@@ -78,7 +79,6 @@ typedef struct SpaprIrq {
     bool        xics;
     bool        xive;
=20
-    void (*print_info)(SpaprMachineState *spapr, Monitor *mon);
     void (*dt_populate)(SpaprMachineState *spapr, uint32_t nr_servers,
                         void *fdt, uint32_t phandle);
     int (*post_load)(SpaprMachineState *spapr, int version_id);
--=20
2.21.0


