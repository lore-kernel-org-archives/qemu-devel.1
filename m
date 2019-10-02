Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69ACC352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 03:35:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 711BB2086A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 03:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="pFptSH8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711BB2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFVPp-00034U-KS
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 23:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iFUlF-00028V-FF
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 22:53:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iFUlD-0003Zg-6w
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 22:53:05 -0400
Received: from ozlabs.org ([203.11.71.1]:60201)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iFUlC-00030I-QH; Tue, 01 Oct 2019 22:53:03 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46jgfB3XWYz9sS8; Wed,  2 Oct 2019 12:52:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569984738;
 bh=E6qkxJWansAqQI+vsJg0EQSMxfj2M7lcVKCtmPfEoj8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pFptSH8RBdmELcMa12tjUK9wZ+0EESam7dAeLvVQH5cbq19/4HBFsuao8u9299q/C
 iDKKiFOUR8CriIMmbB/vCdg0+nyI+6YkyWXAhY3U/VTC8SUmiinffqV5hfANI5GFs+
 O9iGR4QvnedOVO1bmACfTXbu+dfHzVFaHfhXBHBQ=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-ppc@nongnu.org,
	clg@kaod.org,
	qemu-devel@nongnu.org
Subject: [PATCH v3 29/34] spapr: Remove SpaprIrq::init_kvm hook
Date: Wed,  2 Oct 2019 12:52:03 +1000
Message-Id: <20191002025208.3487-30-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191002025208.3487-1-david@gibson.dropbear.id.au>
References: <20191002025208.3487-1-david@gibson.dropbear.id.au>
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, groug@kaod.org,
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
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr_irq.c         | 74 +++++++++++++-------------------------
 include/hw/ppc/spapr_irq.h |  1 -
 2 files changed, 25 insertions(+), 50 deletions(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 5c8ffb27da..7cd18e5b15 100644
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
@@ -675,7 +652,6 @@ SpaprIrq spapr_irq_xics_legacy =3D {
=20
     .post_load   =3D spapr_irq_post_load_xics,
     .reset       =3D spapr_irq_reset_xics,
-    .init_kvm    =3D spapr_irq_init_kvm_xics,
 };
=20
 static void spapr_irq_register_types(void)
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 1be53a01bb..a5fdb963a8 100644
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


