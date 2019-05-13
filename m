Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F91DC04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:03:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E43942146F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43942146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53579 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ6sD-0001W9-5k
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 05:03:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hQ6o4-0006iZ-NO
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:59:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hQ6ZR-0004NA-8F
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:44:31 -0400
Received: from 10.mo3.mail-out.ovh.net ([87.98.165.232]:55237)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hQ6ZR-0004Mm-0s
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:44:29 -0400
Received: from player778.ha.ovh.net (unknown [10.109.146.20])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id A77012102FB
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 10:44:27 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player778.ha.ovh.net (Postfix) with ESMTPSA id 26AD959C4255;
	Mon, 13 May 2019 08:44:22 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 13 May 2019 10:42:45 +0200
Message-Id: <20190513084245.25755-15-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513084245.25755-1-clg@kaod.org>
References: <20190513084245.25755-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 3344767151384333286
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrleeggddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.165.232
Subject: [Qemu-devel] [PATCH v4 14/14] spapr/irq: add KVM support to the
 'dual' machine
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

The interrupt mode is chosen by the CAS negotiation process and
activated after a reset to take into account the required changes in
the machine. This brings new constraints on how the associated KVM IRQ
device is initialized.

Currently, each model takes care of the initialization of the KVM
device in their realize method but this is not possible anymore as the
initialization needs to be done globaly when the interrupt mode is
known, i.e. when machine is reseted. It also means that we need a way
to delete a KVM device when another mode is chosen.

Also, to support migration, the QEMU objects holding the state to
transfer should always be available but not necessarily activated.

The overall approach of this proposal is to initialize both interrupt
mode at the QEMU level to keep the IRQ number space in sync and to
allow switching from one mode to another. For the KVM side of things,
the whole initialization of the KVM device, sources and presenters, is
grouped in a single routine. The XICS and XIVE sPAPR IRQ reset
handlers are modified accordingly to handle the init and the delete
sequences of the KVM device.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---

 Changes since v3:

 - removed extra spapr_irq_init_device() in spapr_irq_init_xive()=20
 - reworked slightly the code sequence in xics_kvm_init() creating the
   presenters and connecting them to the KVM XICS device.
=20
 include/hw/ppc/xive.h    |  1 -
 hw/intc/spapr_xive_kvm.c | 29 +++++++++++++++++++-
 hw/intc/xics_kvm.c       | 31 +++++++++++++++++++++
 hw/intc/xive.c           |  4 ---
 hw/ppc/spapr_irq.c       | 58 ++++++++++++++++++++++++++--------------
 5 files changed, 97 insertions(+), 26 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index edb8937f17fb..d872f96d1a1b 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -432,7 +432,6 @@ static inline uint32_t xive_nvt_cam_line(uint8_t nvt_=
blk, uint32_t nvt_idx)
  */
=20
 void kvmppc_xive_source_reset_one(XiveSource *xsrc, int srcno, Error **e=
rrp);
-void kvmppc_xive_source_reset(XiveSource *xsrc, Error **errp);
 void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val);
 void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp);
 void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp);
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 078d18d7757f..ec170b304555 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -246,7 +246,7 @@ void kvmppc_xive_source_reset_one(XiveSource *xsrc, i=
nt srcno, Error **errp)
                       true, errp);
 }
=20
-void kvmppc_xive_source_reset(XiveSource *xsrc, Error **errp)
+static void kvmppc_xive_source_reset(XiveSource *xsrc, Error **errp)
 {
     int i;
=20
@@ -697,6 +697,15 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **er=
rp)
     Error *local_err =3D NULL;
     size_t esb_len =3D (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
     size_t tima_len =3D 4ull << TM_SHIFT;
+    CPUState *cs;
+
+    /*
+     * The KVM XIVE device already in use. This is the case when
+     * rebooting under the XIVE-only interrupt mode.
+     */
+    if (xive->fd !=3D -1) {
+        return;
+    }
=20
     if (!kvmppc_has_cap_xive()) {
         error_setg(errp, "IRQ_XIVE capability must be present for KVM");
@@ -745,6 +754,24 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **er=
rp)
     xive->change =3D qemu_add_vm_change_state_handler(
         kvmppc_xive_change_state_handler, xive);
=20
+    /* Connect the presenters to the initial VCPUs of the machine */
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+
+        kvmppc_xive_cpu_connect(spapr_cpu_state(cpu)->tctx, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
+
+    /* Update the KVM sources */
+    kvmppc_xive_source_reset(xsrc, &local_err);
+    if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+    }
+
     kvm_kernel_irqchip =3D true;
     kvm_msi_via_irqfd_allowed =3D true;
     kvm_gsi_direct_mapping =3D true;
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 12bd5190cfad..5ba5b775615e 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -33,6 +33,7 @@
 #include "trace.h"
 #include "sysemu/kvm.h"
 #include "hw/ppc/spapr.h"
+#include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/xics.h"
 #include "hw/ppc/xics_spapr.h"
 #include "kvm_ppc.h"
@@ -342,6 +343,16 @@ static void rtas_dummy(PowerPCCPU *cpu, SpaprMachine=
State *spapr,
 int xics_kvm_init(SpaprMachineState *spapr, Error **errp)
 {
     int rc;
+    CPUState *cs;
+    Error *local_err =3D NULL;
+
+    /*
+     * The KVM XICS device already in use. This is the case when
+     * rebooting under the XICS-only interrupt mode.
+     */
+    if (kernel_xics_fd !=3D -1) {
+        return 0;
+    }
=20
     if (!kvm_enabled() || !kvm_check_extension(kvm_state, KVM_CAP_IRQ_XI=
CS)) {
         error_setg(errp,
@@ -390,6 +401,26 @@ int xics_kvm_init(SpaprMachineState *spapr, Error **=
errp)
     kvm_msi_via_irqfd_allowed =3D true;
     kvm_gsi_direct_mapping =3D true;
=20
+    /* Create the presenters */
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+
+        icp_kvm_realize(DEVICE(spapr_cpu_state(cpu)->icp), &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            goto fail;
+        }
+    }
+
+    /* Update the KVM sources */
+    ics_set_kvm_state(spapr->ics);
+
+    /* Connect the presenters to the initial VCPUs of the machine */
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+        icp_set_kvm_state(spapr_cpu_state(cpu)->icp);
+    }
+
     return 0;
=20
 fail:
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index b5ebb33527e7..0c74e47aa49c 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -993,10 +993,6 @@ static void xive_source_reset(void *dev)
=20
     /* PQs are initialized to 0b01 (Q=3D1) which corresponds to "ints of=
f" */
     memset(xsrc->status, XIVE_ESB_OFF, xsrc->nr_irqs);
-
-    if (kvm_irqchip_in_kernel()) {
-        kvmppc_xive_source_reset(xsrc, &error_fatal);
-    }
 }
=20
 static void xive_source_realize(DeviceState *dev, Error **errp)
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index d1e87577fb0e..3156daf09381 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -102,12 +102,6 @@ static void spapr_irq_init_xics(SpaprMachineState *s=
papr, int nr_irqs,
     Object *obj;
     Error *local_err =3D NULL;
=20
-    spapr_irq_init_device(spapr, &spapr_irq_xics, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
     obj =3D object_new(TYPE_ICS_SIMPLE);
     object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
     object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
@@ -226,7 +220,13 @@ static void spapr_irq_set_irq_xics(void *opaque, int=
 srcno, int val)
=20
 static void spapr_irq_reset_xics(SpaprMachineState *spapr, Error **errp)
 {
-    /* TODO: create the KVM XICS device */
+    Error *local_err =3D NULL;
+
+    spapr_irq_init_device(spapr, &spapr_irq_xics, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 }
=20
 static const char *spapr_irq_get_nodename_xics(SpaprMachineState *spapr)
@@ -279,7 +279,6 @@ static void spapr_irq_init_xive(SpaprMachineState *sp=
apr, int nr_irqs,
     uint32_t nr_servers =3D spapr_max_server_number(spapr);
     DeviceState *dev;
     int i;
-    Error *local_err =3D NULL;
=20
     dev =3D qdev_create(NULL, TYPE_SPAPR_XIVE);
     qdev_prop_set_uint32(dev, "nr-irqs", nr_irqs);
@@ -297,12 +296,6 @@ static void spapr_irq_init_xive(SpaprMachineState *s=
papr, int nr_irqs,
     }
=20
     spapr_xive_hcall_init(spapr);
-
-    spapr_irq_init_device(spapr, &spapr_irq_xive, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
 }
=20
 static int spapr_irq_claim_xive(SpaprMachineState *spapr, int irq, bool =
lsi,
@@ -382,6 +375,7 @@ static int spapr_irq_post_load_xive(SpaprMachineState=
 *spapr, int version_id)
 static void spapr_irq_reset_xive(SpaprMachineState *spapr, Error **errp)
 {
     CPUState *cs;
+    Error *local_err =3D NULL;
=20
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
@@ -390,6 +384,12 @@ static void spapr_irq_reset_xive(SpaprMachineState *=
spapr, Error **errp)
         spapr_xive_set_tctx_os_cam(spapr_cpu_state(cpu)->tctx);
     }
=20
+    spapr_irq_init_device(spapr, &spapr_irq_xive, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     /* Activate the XIVE MMIOs */
     spapr_xive_mmio_set_enabled(spapr->xive, true);
 }
@@ -472,14 +472,8 @@ static SpaprIrq *spapr_irq_current(SpaprMachineState=
 *spapr)
 static void spapr_irq_init_dual(SpaprMachineState *spapr, int nr_irqs,
                                 Error **errp)
 {
-    MachineState *machine =3D MACHINE(spapr);
     Error *local_err =3D NULL;
=20
-    if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
-        error_setg(errp, "No KVM support for the 'dual' machine");
-        return;
-    }
-
     spapr_irq_xics.init(spapr, spapr_irq_xics.nr_irqs, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -558,6 +552,9 @@ static int spapr_irq_post_load_dual(SpaprMachineState=
 *spapr, int version_id)
      * defaults to XICS at startup.
      */
     if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        if (kvm_irqchip_in_kernel()) {
+            xics_kvm_disconnect(spapr, &error_fatal);
+        }
         spapr_irq_xive.reset(spapr, &error_fatal);
     }
=20
@@ -566,12 +563,30 @@ static int spapr_irq_post_load_dual(SpaprMachineSta=
te *spapr, int version_id)
=20
 static void spapr_irq_reset_dual(SpaprMachineState *spapr, Error **errp)
 {
+    Error *local_err =3D NULL;
+
     /*
      * Deactivate the XIVE MMIOs. The XIVE backend will reenable them
      * if selected.
      */
     spapr_xive_mmio_set_enabled(spapr->xive, false);
=20
+    /* Destroy all KVM devices */
+    if (kvm_irqchip_in_kernel()) {
+        xics_kvm_disconnect(spapr, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            error_prepend(errp, "KVM XICS disconnect failed: ");
+            return;
+        }
+        kvmppc_xive_disconnect(spapr->xive, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            error_prepend(errp, "KVM XIVE disconnect failed: ");
+            return;
+        }
+    }
+
     spapr_irq_current(spapr)->reset(spapr, errp);
 }
=20
@@ -809,6 +824,9 @@ SpaprIrq spapr_irq_xics_legacy =3D {
     .dt_populate =3D spapr_dt_xics,
     .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
     .post_load   =3D spapr_irq_post_load_xics,
+    .reset       =3D spapr_irq_reset_xics,
     .set_irq     =3D spapr_irq_set_irq_xics,
     .get_nodename =3D spapr_irq_get_nodename_xics,
+    .init_emu    =3D spapr_irq_init_emu_xics,
+    .init_kvm    =3D spapr_irq_init_kvm_xics,
 };
--=20
2.20.1


