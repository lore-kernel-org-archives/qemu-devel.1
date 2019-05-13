Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11879C04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:09:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB6D820989
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6D820989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53675 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ6xr-0005Ow-3g
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 05:09:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hQ6o8-0006kQ-IT
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hQ6Z8-0004Gj-Q2
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:44:12 -0400
Received: from 5.mo179.mail-out.ovh.net ([46.105.43.140]:50851)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hQ6Z8-0004G6-KG
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:44:10 -0400
Received: from player778.ha.ovh.net (unknown [10.108.42.170])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 2080012D0A0
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 10:44:09 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player778.ha.ovh.net (Postfix) with ESMTPSA id 0DEAA59C4118;
	Mon, 13 May 2019 08:44:02 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 13 May 2019 10:42:42 +0200
Message-Id: <20190513084245.25755-12-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513084245.25755-1-clg@kaod.org>
References: <20190513084245.25755-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 3339419126787247078
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrleeggddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.43.140
Subject: [Qemu-devel] [PATCH v4 11/14] spapr/irq: introduce a
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
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 include/hw/ppc/spapr_irq.h  |  2 +
 include/hw/ppc/spapr_xive.h |  1 +
 hw/intc/spapr_xive.c        | 26 +++--------
 hw/ppc/spapr_irq.c          | 89 +++++++++++++++++++++++++++++--------
 4 files changed, 78 insertions(+), 40 deletions(-)

diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index b855f74e4428..14cab73c9c07 100644
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
index 0b5e972d52c8..b26befcf6b56 100644
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
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index d02993f489df..246b21ae7f31 100644
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
index e969683f5c49..d1e87577fb0e 100644
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
--=20
2.20.1


