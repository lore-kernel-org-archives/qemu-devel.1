Received: from eggs.gnu.org ([209.51.188.92]:40514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gxApN-0000qA-4F
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:25:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gxAeU-0004NH-6u
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:14:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51666)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gxAeT-0003zO-O6
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:14:06 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1MDCdxc131113
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 08:13:43 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qthrs8235-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 08:13:43 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Fri, 22 Feb 2019 13:13:40 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 22 Feb 2019 14:13:21 +0100
In-Reply-To: <20190222131322.26079-1-clg@kaod.org>
References: <20190222131322.26079-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190222131322.26079-13-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 12/13] spapr: add KVM support to the 'dual'
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

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
mode at the QEMU level and keep the IRQ number space in sync to allow
switching from one mode to another. For the KVM side of things, the
whole initialization of the KVM device, sources and presenters, is
grouped in a single routine. The XICS and XIVE sPAPR IRQ reset
handlers are modified accordingly to handle the init and the delete
sequences of the KVM device.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr_xive.h |  1 +
 hw/intc/spapr_xive.c        | 19 +++++++-
 hw/intc/spapr_xive_kvm.c    | 27 +++++++++++
 hw/intc/xics_kvm.c          | 26 ++++++++++
 hw/intc/xive.c              |  4 --
 hw/ppc/spapr_irq.c          | 97 ++++++++++++++++++++++++++++---------
 6 files changed, 145 insertions(+), 29 deletions(-)

diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index a7c4c275a747..a1593ac2fcf0 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -66,6 +66,7 @@ void spapr_xive_map_mmio(sPAPRXive *xive);
=20
 int spapr_xive_end_to_target(uint8_t end_blk, uint32_t end_idx,
                              uint32_t *out_server, uint8_t *out_prio);
+void spapr_xive_late_realize(sPAPRXive *xive, Error **errp);
=20
 /*
  * KVM XIVE device helpers
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 21fe5e1aa39f..b0cbc2fe21ee 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -278,7 +278,6 @@ static void spapr_xive_realize(DeviceState *dev, Erro=
r **errp)
     XiveSource *xsrc =3D &xive->source;
     XiveENDSource *end_xsrc =3D &xive->end_source;
     Error *local_err =3D NULL;
-    MachineState *machine =3D MACHINE(qdev_get_machine());
=20
     if (!xive->nr_irqs) {
         error_setg(errp, "Number of interrupt needs to be greater 0");
@@ -329,6 +328,15 @@ static void spapr_xive_realize(DeviceState *dev, Err=
or **errp)
                            xive->tm_base + XIVE_TM_USER_PAGE * (1 << TM_=
SHIFT));
=20
     qemu_register_reset(spapr_xive_reset, dev);
+}
+
+void spapr_xive_late_realize(sPAPRXive *xive, Error **errp)
+{
+    Error *local_err =3D NULL;
+    MachineState *machine =3D MACHINE(qdev_get_machine());
+    XiveSource *xsrc =3D &xive->source;
+    XiveENDSource *end_xsrc =3D &xive->end_source;
+    static bool once;
=20
     if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
         kvmppc_xive_connect(xive, &local_err);
@@ -351,6 +359,15 @@ static void spapr_xive_realize(DeviceState *dev, Err=
or **errp)
         error_report_err(local_err);
     }
=20
+    /*
+     * TODO: Emulated mode can only be initialized once. Should we
+     * store the information under the device model for later usage ?
+     */
+    if (once) {
+        return;
+    }
+    once =3D true;
+
     /* TIMA initialization */
     memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &xive_tm_ops, xi=
ve,
                           "xive.tima", 4ull << TM_SHIFT);
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index cd81cdb23a5e..99a829fb3f60 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -657,6 +657,15 @@ void kvmppc_xive_connect(sPAPRXive *xive, Error **er=
rp)
     Error *local_err =3D NULL;
     size_t esb_len =3D (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
     size_t tima_len =3D 4ull << TM_SHIFT;
+    CPUState *cs;
+
+    /*
+     * The KVM XIVE device already in use. This is the case when
+     * rebooting XIVE -> XIVE
+     */
+    if (xive->fd !=3D -1) {
+        return;
+    }
=20
     if (!kvmppc_has_cap_xive()) {
         error_setg(errp, "IRQ_XIVE capability must be present for KVM");
@@ -705,6 +714,24 @@ void kvmppc_xive_connect(sPAPRXive *xive, Error **er=
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
index 9855316e4831..8ffd4c7a36f8 100644
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
@@ -337,6 +338,16 @@ static void rtas_dummy(PowerPCCPU *cpu, sPAPRMachine=
State *spapr,
 int xics_kvm_init(sPAPRMachineState *spapr, Error **errp)
 {
     int rc;
+    CPUState *cs;
+    Error *local_err =3D NULL;
+
+    /*
+     * The KVM XICS device already in use. This is the case when
+     * rebooting XICS -> XICS
+     */
+    if (kernel_xics_fd !=3D -1) {
+        return 0;
+    }
=20
     if (!kvm_enabled() || !kvm_check_extension(kvm_state, KVM_CAP_IRQ_XI=
CS)) {
         error_setg(errp,
@@ -385,6 +396,21 @@ int xics_kvm_init(sPAPRMachineState *spapr, Error **=
errp)
     kvm_msi_via_irqfd_allowed =3D true;
     kvm_gsi_direct_mapping =3D true;
=20
+    /* Connect the presenters to the initial VCPUs of the machine */
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+
+        icp_kvm_realize(DEVICE(spapr_cpu_state(cpu)->icp), &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            goto fail;
+        }
+        icp_set_kvm_state(spapr_cpu_state(cpu)->icp);
+    }
+
+    /* Update the KVM sources */
+    ics_set_kvm_state(spapr->ics);
+
     return 0;
=20
 fail:
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 1f8e923ca654..715d5a7e65ed 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -929,10 +929,6 @@ static void xive_source_reset(void *dev)
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
index 3176098b9f7c..f8260c14aecd 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -92,35 +92,55 @@ error:
     return NULL;
 }
=20
-static void spapr_irq_init_xics(sPAPRMachineState *spapr, int nr_irqs,
-                                Error **errp)
+static void spapr_ics_late_realize(sPAPRMachineState *spapr, Error **err=
p)
 {
     MachineState *machine =3D MACHINE(spapr);
     Error *local_err =3D NULL;
-    bool xics_kvm =3D false;
+    static bool once;
=20
-    if (kvm_enabled()) {
-        if (machine_kernel_irqchip_allowed(machine) &&
-            !xics_kvm_init(spapr, &local_err)) {
-            xics_kvm =3D true;
-        }
-        if (machine_kernel_irqchip_required(machine) && !xics_kvm) {
+    if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
+        xics_kvm_init(spapr, &local_err);
+        if (local_err && machine_kernel_irqchip_required(machine)) {
             error_prepend(&local_err,
                           "kernel_irqchip requested but unavailable: ");
-            goto error;
+            error_propagate(errp, local_err);
+            return;
         }
-        error_free(local_err);
-        local_err =3D NULL;
+
+        if (!local_err) {
+            return;
+        }
+
+        /*
+         * We failed to initialize the XIVE KVM device, fallback to
+         * emulated mode
+         */
+        error_prepend(&local_err, "kernel_irqchip allowed but unavailabl=
e: ");
+        error_report_err(local_err);
     }
=20
-    if (!xics_kvm) {
-        xics_spapr_init(spapr);
+    /*
+     * TODO: Emulated mode can only be initialized once. Should we
+     * store the information under the device model for later usage ?
+     */
+    if (once) {
+        return;
     }
+    once =3D true;
=20
-    spapr->ics =3D spapr_ics_create(spapr, nr_irqs, &local_err);
+    xics_spapr_init(spapr);
+}
=20
-error:
-    error_propagate(errp, local_err);
+static void spapr_irq_init_xics(sPAPRMachineState *spapr, int nr_irqs,
+                                Error **errp)
+{
+    Error *local_err =3D NULL;
+
+    spapr->ics =3D spapr_ics_create(spapr, nr_irqs, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 }
=20
 #define ICS_IRQ_FREE(ics, srcno)   \
@@ -227,7 +247,13 @@ static void spapr_irq_set_irq_xics(void *opaque, int=
 srcno, int val)
=20
 static void spapr_irq_reset_xics(sPAPRMachineState *spapr, Error **errp)
 {
-    /* TODO: create the KVM XICS device */
+    Error *local_err =3D NULL;
+
+    spapr_ics_late_realize(spapr, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 }
=20
 static const char *spapr_irq_get_nodename_xics(sPAPRMachineState *spapr)
@@ -386,6 +412,7 @@ static int spapr_irq_post_load_xive(sPAPRMachineState=
 *spapr, int version_id)
 static void spapr_irq_reset_xive(sPAPRMachineState *spapr, Error **errp)
 {
     CPUState *cs;
+    Error *local_err =3D NULL;
=20
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
@@ -394,6 +421,12 @@ static void spapr_irq_reset_xive(sPAPRMachineState *=
spapr, Error **errp)
         spapr_xive_set_tctx_os_cam(spapr_cpu_state(cpu)->tctx);
     }
=20
+    spapr_xive_late_realize(spapr->xive, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     /* Activate the XIVE MMIOs */
     spapr_xive_mmio_set_enabled(spapr->xive, true);
 }
@@ -462,14 +495,8 @@ static sPAPRIrq *spapr_irq_current(sPAPRMachineState=
 *spapr)
 static void spapr_irq_init_dual(sPAPRMachineState *spapr, int nr_irqs,
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
@@ -548,6 +575,9 @@ static int spapr_irq_post_load_dual(sPAPRMachineState=
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
@@ -556,12 +586,30 @@ static int spapr_irq_post_load_dual(sPAPRMachineSta=
te *spapr, int version_id)
=20
 static void spapr_irq_reset_dual(sPAPRMachineState *spapr, Error **errp)
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
@@ -748,6 +796,7 @@ sPAPRIrq spapr_irq_xics_legacy =3D {
     .dt_populate =3D spapr_dt_xics,
     .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
     .post_load   =3D spapr_irq_post_load_xics,
+    .reset       =3D spapr_irq_reset_xics,
     .set_irq     =3D spapr_irq_set_irq_xics,
     .get_nodename =3D spapr_irq_get_nodename_xics,
 };
--=20
2.20.1
