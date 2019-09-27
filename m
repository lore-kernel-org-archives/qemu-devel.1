Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2EEC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:17:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83DCE206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="XG3q1zao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DCE206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDjZP-00007H-Tb
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 02:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iDj9r-0007Ri-GT
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 01:51:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iDj9p-0005cw-VT
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 01:51:11 -0400
Received: from ozlabs.org ([203.11.71.1]:32993)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iDj9p-00054k-Ip; Fri, 27 Sep 2019 01:51:09 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46fgrG4f7qz9sRV; Fri, 27 Sep 2019 15:50:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569563438;
 bh=DH9d448OE2kHDHXoVlCBVZWLBPcI0v9MdoT1GgXMWIk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XG3q1zaoU8bbp1D33kUlS4JMlNhFdcxaU1a8qUvGTYoA067KUHBPdLhXo8uDnkVeK
 nZ9CMtGUJgv+IeNZb+62yW8SLj0w+qjv2pq1oS7ft0MsFFVia6oFUM1O+29oQwAZvb
 KqwxhCphgHRs7EfME8CgLqwBqC3cXxak6/p+zizs=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org,
	clg@kaod.org,
	qemu-ppc@nongnu.org
Subject: [PATCH v2 25/33] spapr, xics,
 xive: Move print_info from SpaprIrq to SpaprInterruptController
Date: Fri, 27 Sep 2019 15:50:20 +1000
Message-Id: <20190927055028.11493-26-david@gibson.dropbear.id.au>
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

This method depends only on the active irq controller.  Now that we've
formalized the notion of active controller we can dispatch directly
through that, rather than dispatching via SpaprIrq with the dual
version having to do a second conditional dispatch.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive.c       | 15 +++++++++++++
 hw/intc/xics_spapr.c       | 15 +++++++++++++
 hw/ppc/spapr.c             |  2 +-
 hw/ppc/spapr_irq.c         | 44 +++++++-------------------------------
 include/hw/ppc/spapr_irq.h |  2 +-
 5 files changed, 40 insertions(+), 38 deletions(-)

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
index 795f6ab505..7e04746db1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4341,7 +4341,7 @@ static void spapr_pic_print_info(InterruptStatsProv=
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
index 4922062908..be20bbf3cf 100644
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
@@ -402,6 +367,14 @@ static void spapr_set_irq(void *opaque, int irq, int=
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
@@ -720,7 +693,6 @@ SpaprIrq spapr_irq_xics_legacy =3D {
     .xics        =3D true,
     .xive        =3D false,
=20
-    .print_info  =3D spapr_irq_print_info_xics,
     .dt_populate =3D spapr_dt_xics,
     .post_load   =3D spapr_irq_post_load_xics,
     .reset       =3D spapr_irq_reset_xics,
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 8286a9aa63..2ade580992 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -59,6 +59,7 @@ typedef struct SpaprInterruptControllerClass {
=20
     /* These methods should only be called on the active intc */
     void (*set_irq)(SpaprInterruptController *intc, int irq, int val);
+    void (*print_info)(SpaprInterruptController *intc, Monitor *mon);
 } SpaprInterruptControllerClass;
=20
 void spapr_irq_update_active_intc(SpaprMachineState *spapr);
@@ -81,7 +82,6 @@ typedef struct SpaprIrq {
     bool        xics;
     bool        xive;
=20
-    void (*print_info)(SpaprMachineState *spapr, Monitor *mon);
     void (*dt_populate)(SpaprMachineState *spapr, uint32_t nr_servers,
                         void *fdt, uint32_t phandle);
     int (*post_load)(SpaprMachineState *spapr, int version_id);
--=20
2.21.0


