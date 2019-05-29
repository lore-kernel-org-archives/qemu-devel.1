Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07217C04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:15:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B99FD21019
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GbthugRt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B99FD21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48756 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVsoQ-0004HN-TE
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 03:15:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVsQr-0000r3-9X
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:51:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVsQp-00033j-Kh
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:51:29 -0400
Received: from ozlabs.org ([203.11.71.1]:33197)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hVsQp-0002uO-2X; Wed, 29 May 2019 02:51:27 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45DLv75bCYz9sPh; Wed, 29 May 2019 16:50:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559112627;
	bh=l7Xr6iubolyiB1w+vsLyJ/JH/2dDqIjebWMln6zucmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GbthugRtI82RSf+cMAgOiQeix7X1yr5/M4x/1K/4Q7rqRflHjfw49J+u5Mk6XVmKr
	ukRMXRf/1eItzofRB8cymm6mJ8ReabABG91S4bTiWxQthP+BDZL1te0f0x8aqH+4KL
	/J+34ttATSziMnfr4bbOjuUP3oNVPS7rdvJQfkY4=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 29 May 2019 16:50:08 +1000
Message-Id: <20190529065017.15149-36-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529065017.15149-1-david@gibson.dropbear.id.au>
References: <20190529065017.15149-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 35/44] spapr/irq: introduce a
 spapr_irq_init_device() helper
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
	qemu-ppc@nongnu.org, clg@kaod.org,
	David Gibson <david@gibson.dropbear.id.au>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

The way the XICS and the XIVE devices are initialized follows the same
pattern. First, try to connect to the KVM device and if not possible
fallback on the emulated device, unless a kernel_irqchip is required.
The spapr_irq_init_device() routine implements this sequence in
generic way using new sPAPR IRQ handlers ->init_emu() and ->init_kvm().

The XIVE init sequence is moved under the associated sPAPR IRQ
->init() handler. This will change again when KVM support is added for
the dual interrupt mode.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20190513084245.25755-12-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive.c        | 26 +++--------
 hw/ppc/spapr_irq.c          | 89 +++++++++++++++++++++++++++++--------
 include/hw/ppc/spapr_irq.h  |  2 +
 include/hw/ppc/spapr_xive.h |  1 +
 4 files changed, 78 insertions(+), 40 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 0aa5d8a55e..a79574b23c 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -281,7 +281,6 @@ static void spapr_xive_realize(DeviceState *dev, Erro=
r **errp)
     XiveSource *xsrc =3D &xive->source;
     XiveENDSource *end_xsrc =3D &xive->end_source;
     Error *local_err =3D NULL;
-    MachineState *machine =3D MACHINE(qdev_get_machine());
=20
     if (!xive->nr_irqs) {
         error_setg(errp, "Number of interrupt needs to be greater 0");
@@ -332,27 +331,12 @@ static void spapr_xive_realize(DeviceState *dev, Er=
ror **errp)
                            xive->tm_base + XIVE_TM_USER_PAGE * (1 << TM_=
SHIFT));
=20
     qemu_register_reset(spapr_xive_reset, dev);
+}
=20
-    if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
-        kvmppc_xive_connect(xive, &local_err);
-        if (local_err && machine_kernel_irqchip_required(machine)) {
-            error_prepend(&local_err,
-                          "kernel_irqchip requested but unavailable: ");
-            error_propagate(errp, local_err);
-            return;
-        }
-
-        if (!local_err) {
-            return;
-        }
-
-        /*
-         * We failed to initialize the XIVE KVM device, fallback to
-         * emulated mode
-         */
-        error_prepend(&local_err, "kernel_irqchip allowed but unavailabl=
e: ");
-        warn_report_err(local_err);
-    }
+void spapr_xive_init(SpaprXive *xive, Error **errp)
+{
+    XiveSource *xsrc =3D &xive->source;
+    XiveENDSource *end_xsrc =3D &xive->end_source;
=20
     /* TIMA initialization */
     memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &xive_tm_ops, xi=
ve,
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index e969683f5c..d1e87577fb 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -62,36 +62,50 @@ void spapr_irq_msi_reset(SpaprMachineState *spapr)
     bitmap_clear(spapr->irq_map, 0, spapr->irq_map_nr);
 }
=20
-
-/*
- * XICS IRQ backend.
- */
-
-static void spapr_irq_init_xics(SpaprMachineState *spapr, int nr_irqs,
-                                Error **errp)
+static void spapr_irq_init_device(SpaprMachineState *spapr,
+                                  SpaprIrq *irq, Error **errp)
 {
     MachineState *machine =3D MACHINE(spapr);
-    Object *obj;
     Error *local_err =3D NULL;
-    bool xics_kvm =3D false;
=20
-    if (kvm_enabled()) {
-        if (machine_kernel_irqchip_allowed(machine) &&
-            !xics_kvm_init(spapr, &local_err)) {
-            xics_kvm =3D true;
-        }
-        if (machine_kernel_irqchip_required(machine) && !xics_kvm) {
+    if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
+        irq->init_kvm(spapr, &local_err);
+        if (local_err && machine_kernel_irqchip_required(machine)) {
             error_prepend(&local_err,
                           "kernel_irqchip requested but unavailable: ");
             error_propagate(errp, local_err);
             return;
         }
-        error_free(local_err);
-        local_err =3D NULL;
+
+        if (!local_err) {
+            return;
+        }
+
+        /*
+         * We failed to initialize the KVM device, fallback to
+         * emulated mode
+         */
+        error_prepend(&local_err, "kernel_irqchip allowed but unavailabl=
e: ");
+        warn_report_err(local_err);
     }
=20
-    if (!xics_kvm) {
-        xics_spapr_init(spapr);
+    irq->init_emu(spapr, errp);
+}
+
+/*
+ * XICS IRQ backend.
+ */
+
+static void spapr_irq_init_xics(SpaprMachineState *spapr, int nr_irqs,
+                                Error **errp)
+{
+    Object *obj;
+    Error *local_err =3D NULL;
+
+    spapr_irq_init_device(spapr, &spapr_irq_xics, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
     }
=20
     obj =3D object_new(TYPE_ICS_SIMPLE);
@@ -220,6 +234,18 @@ static const char *spapr_irq_get_nodename_xics(Spapr=
MachineState *spapr)
     return XICS_NODENAME;
 }
=20
+static void spapr_irq_init_emu_xics(SpaprMachineState *spapr, Error **er=
rp)
+{
+    xics_spapr_init(spapr);
+}
+
+static void spapr_irq_init_kvm_xics(SpaprMachineState *spapr, Error **er=
rp)
+{
+    if (kvm_enabled()) {
+        xics_kvm_init(spapr, errp);
+    }
+}
+
 #define SPAPR_IRQ_XICS_NR_IRQS     0x1000
 #define SPAPR_IRQ_XICS_NR_MSIS     \
     (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
@@ -240,6 +266,8 @@ SpaprIrq spapr_irq_xics =3D {
     .reset       =3D spapr_irq_reset_xics,
     .set_irq     =3D spapr_irq_set_irq_xics,
     .get_nodename =3D spapr_irq_get_nodename_xics,
+    .init_emu    =3D spapr_irq_init_emu_xics,
+    .init_kvm    =3D spapr_irq_init_kvm_xics,
 };
=20
 /*
@@ -251,6 +279,7 @@ static void spapr_irq_init_xive(SpaprMachineState *sp=
apr, int nr_irqs,
     uint32_t nr_servers =3D spapr_max_server_number(spapr);
     DeviceState *dev;
     int i;
+    Error *local_err =3D NULL;
=20
     dev =3D qdev_create(NULL, TYPE_SPAPR_XIVE);
     qdev_prop_set_uint32(dev, "nr-irqs", nr_irqs);
@@ -268,6 +297,12 @@ static void spapr_irq_init_xive(SpaprMachineState *s=
papr, int nr_irqs,
     }
=20
     spapr_xive_hcall_init(spapr);
+
+    spapr_irq_init_device(spapr, &spapr_irq_xive, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 }
=20
 static int spapr_irq_claim_xive(SpaprMachineState *spapr, int irq, bool =
lsi,
@@ -375,6 +410,18 @@ static const char *spapr_irq_get_nodename_xive(Spapr=
MachineState *spapr)
     return spapr->xive->nodename;
 }
=20
+static void spapr_irq_init_emu_xive(SpaprMachineState *spapr, Error **er=
rp)
+{
+    spapr_xive_init(spapr->xive, errp);
+}
+
+static void spapr_irq_init_kvm_xive(SpaprMachineState *spapr, Error **er=
rp)
+{
+    if (kvm_enabled()) {
+        kvmppc_xive_connect(spapr->xive, errp);
+    }
+}
+
 /*
  * XIVE uses the full IRQ number space. Set it to 8K to be compatible
  * with XICS.
@@ -399,6 +446,8 @@ SpaprIrq spapr_irq_xive =3D {
     .reset       =3D spapr_irq_reset_xive,
     .set_irq     =3D spapr_irq_set_irq_xive,
     .get_nodename =3D spapr_irq_get_nodename_xive,
+    .init_emu    =3D spapr_irq_init_emu_xive,
+    .init_kvm    =3D spapr_irq_init_kvm_xive,
 };
=20
 /*
@@ -560,6 +609,8 @@ SpaprIrq spapr_irq_dual =3D {
     .reset       =3D spapr_irq_reset_dual,
     .set_irq     =3D spapr_irq_set_irq_dual,
     .get_nodename =3D spapr_irq_get_nodename_dual,
+    .init_emu    =3D NULL, /* should not be used */
+    .init_kvm    =3D NULL, /* should not be used */
 };
=20
=20
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index b855f74e44..14cab73c9c 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -48,6 +48,8 @@ typedef struct SpaprIrq {
     void (*reset)(SpaprMachineState *spapr, Error **errp);
     void (*set_irq)(void *opaque, int srcno, int val);
     const char *(*get_nodename)(SpaprMachineState *spapr);
+    void (*init_emu)(SpaprMachineState *spapr, Error **errp);
+    void (*init_kvm)(SpaprMachineState *spapr, Error **errp);
 } SpaprIrq;
=20
 extern SpaprIrq spapr_irq_xics;
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 0b5e972d52..b26befcf6b 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -66,6 +66,7 @@ void spapr_xive_map_mmio(SpaprXive *xive);
=20
 int spapr_xive_end_to_target(uint8_t end_blk, uint32_t end_idx,
                              uint32_t *out_server, uint8_t *out_prio);
+void spapr_xive_init(SpaprXive *xive, Error **errp);
=20
 /*
  * KVM XIVE device helpers
--=20
2.21.0


