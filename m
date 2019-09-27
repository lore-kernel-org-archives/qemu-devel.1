Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C017CC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:30:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8455A207FF
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gvEhTwUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8455A207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDjlg-0004Bs-8o
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 02:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iDj9u-0007Vr-1F
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 01:51:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iDj9s-0005hK-CT
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 01:51:13 -0400
Received: from ozlabs.org ([203.11.71.1]:46825)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iDj9r-00058e-VI; Fri, 27 Sep 2019 01:51:12 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46fgrH2vqPz9sRk; Fri, 27 Sep 2019 15:50:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569563439;
 bh=RFj5CUYkakE4AUYr/nO1fu+1P4WRfY2FnQ66Dj8mQ8k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gvEhTwUWyWlidTB2LDRR7UsUgD3nzlzSmR3UWQR2uwktXSS6T6yLTMz1NqOPf00s7
 0t72W1bP+eVBrfWHQtI9wZzxyiEgOq6Tqr7Hgo4nZ7wDbdpqkuMCa+o6l4kAklmHJ8
 0g+siAHAK//HRHD7le8jvfPnLCNn9qUxOHrhnTEg=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org,
	clg@kaod.org,
	qemu-ppc@nongnu.org
Subject: [PATCH v2 28/33] spapr: Remove SpaprIrq::init_kvm hook
Date: Fri, 27 Sep 2019 15:50:23 +1000
Message-Id: <20190927055028.11493-29-david@gibson.dropbear.id.au>
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

This hook is a bit odd.  The only caller is spapr_irq_init_kvm(), but
it explicitly takes an SpaprIrq *, so it's never really called through th=
e
current SpaprIrq.  Essentially this is just a way of passing through a
function pointer so that spapr_irq_init_kvm() can handle some
configuration and error handling logic without duplicating it between the
xics and xive reset paths.

So, make it just take that function pointer.  Because of earlier reworks
to the KVM connect/disconnect code in the xics and xive backends we can
also eliminate some wrapper functions and streamline error handling a bit=
.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_irq.c         | 74 +++++++++++++-------------------------
 include/hw/ppc/spapr_irq.h |  1 -
 2 files changed, 25 insertions(+), 50 deletions(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 561bdbc4de..c6abebc4ef 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -65,33 +65,35 @@ void spapr_irq_msi_free(SpaprMachineState *spapr, int=
 irq, uint32_t num)
     bitmap_clear(spapr->irq_map, irq - SPAPR_IRQ_MSI, num);
 }
=20
-static void spapr_irq_init_kvm(SpaprMachineState *spapr,
-                                  SpaprIrq *irq, Error **errp)
+static int spapr_irq_init_kvm(int (*fn)(SpaprInterruptController *, Erro=
r **),
+                              SpaprInterruptController *intc,
+                              Error **errp)
 {
-    MachineState *machine =3D MACHINE(spapr);
+    MachineState *machine =3D MACHINE(qdev_get_machine());
     Error *local_err =3D NULL;
=20
     if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
-        irq->init_kvm(spapr, &local_err);
-        if (local_err && machine_kernel_irqchip_required(machine)) {
-            error_prepend(&local_err,
-                          "kernel_irqchip requested but unavailable: ");
-            error_propagate(errp, local_err);
-            return;
-        }
+        if (fn(intc, &local_err) < 0) {
+            if (machine_kernel_irqchip_required(machine)) {
+                error_prepend(&local_err,
+                              "kernel_irqchip requested but unavailable:=
 ");
+                error_propagate(errp, local_err);
+                return -1;
+            }
=20
-        if (!local_err) {
-            return;
+            /*
+             * We failed to initialize the KVM device, fallback to
+             * emulated mode
+             */
+            error_prepend(&local_err,
+                          "kernel_irqchip allowed but unavailable: ");
+            error_append_hint(&local_err,
+                              "Falling back to kernel-irqchip=3Doff\n");
+            warn_report_err(local_err);
         }
-
-        /*
-         * We failed to initialize the KVM device, fallback to
-         * emulated mode
-         */
-        error_prepend(&local_err, "kernel_irqchip allowed but unavailabl=
e: ");
-        error_append_hint(&local_err, "Falling back to kernel-irqchip=3D=
off\n");
-        warn_report_err(local_err);
     }
+
+    return 0;
 }
=20
 /*
@@ -112,20 +114,7 @@ static int spapr_irq_post_load_xics(SpaprMachineStat=
e *spapr, int version_id)
=20
 static void spapr_irq_reset_xics(SpaprMachineState *spapr, Error **errp)
 {
-    Error *local_err =3D NULL;
-
-    spapr_irq_init_kvm(spapr, &spapr_irq_xics, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-}
-
-static void spapr_irq_init_kvm_xics(SpaprMachineState *spapr, Error **er=
rp)
-{
-    if (kvm_enabled()) {
-        xics_kvm_connect(SPAPR_INTC(spapr->ics), errp);
-    }
+    spapr_irq_init_kvm(xics_kvm_connect, SPAPR_INTC(spapr->ics), errp);
 }
=20
 SpaprIrq spapr_irq_xics =3D {
@@ -136,7 +125,6 @@ SpaprIrq spapr_irq_xics =3D {
=20
     .post_load   =3D spapr_irq_post_load_xics,
     .reset       =3D spapr_irq_reset_xics,
-    .init_kvm    =3D spapr_irq_init_kvm_xics,
 };
=20
 /*
@@ -151,7 +139,6 @@ static int spapr_irq_post_load_xive(SpaprMachineState=
 *spapr, int version_id)
 static void spapr_irq_reset_xive(SpaprMachineState *spapr, Error **errp)
 {
     CPUState *cs;
-    Error *local_err =3D NULL;
=20
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
@@ -160,9 +147,8 @@ static void spapr_irq_reset_xive(SpaprMachineState *s=
papr, Error **errp)
         spapr_xive_set_tctx_os_cam(spapr_cpu_state(cpu)->tctx);
     }
=20
-    spapr_irq_init_kvm(spapr, &spapr_irq_xive, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (spapr_irq_init_kvm(kvmppc_xive_connect,
+                           SPAPR_INTC(spapr->xive), errp) < 0) {
         return;
     }
=20
@@ -170,13 +156,6 @@ static void spapr_irq_reset_xive(SpaprMachineState *=
spapr, Error **errp)
     spapr_xive_mmio_set_enabled(spapr->xive, true);
 }
=20
-static void spapr_irq_init_kvm_xive(SpaprMachineState *spapr, Error **er=
rp)
-{
-    if (kvm_enabled()) {
-        kvmppc_xive_connect(SPAPR_INTC(spapr->xive), errp);
-    }
-}
-
 SpaprIrq spapr_irq_xive =3D {
     .nr_xirqs    =3D SPAPR_NR_XIRQS,
     .nr_msis     =3D SPAPR_NR_MSIS,
@@ -185,7 +164,6 @@ SpaprIrq spapr_irq_xive =3D {
=20
     .post_load   =3D spapr_irq_post_load_xive,
     .reset       =3D spapr_irq_reset_xive,
-    .init_kvm    =3D spapr_irq_init_kvm_xive,
 };
=20
 /*
@@ -251,7 +229,6 @@ SpaprIrq spapr_irq_dual =3D {
=20
     .post_load   =3D spapr_irq_post_load_dual,
     .reset       =3D spapr_irq_reset_dual,
-    .init_kvm    =3D NULL, /* should not be used */
 };
=20
=20
@@ -682,7 +659,6 @@ SpaprIrq spapr_irq_xics_legacy =3D {
=20
     .post_load   =3D spapr_irq_post_load_xics,
     .reset       =3D spapr_irq_reset_xics,
-    .init_kvm    =3D spapr_irq_init_kvm_xics,
 };
=20
 static void spapr_irq_register_types(void)
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index c82724fc2b..c947f40571 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -85,7 +85,6 @@ typedef struct SpaprIrq {
=20
     int (*post_load)(SpaprMachineState *spapr, int version_id);
     void (*reset)(SpaprMachineState *spapr, Error **errp);
-    void (*init_kvm)(SpaprMachineState *spapr, Error **errp);
 } SpaprIrq;
=20
 extern SpaprIrq spapr_irq_xics;
--=20
2.21.0


