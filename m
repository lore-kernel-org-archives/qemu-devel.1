Received: from eggs.gnu.org ([2001:4830:134:3::10]:45767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgZ0-0000DS-IR
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:26:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgYw-00052O-4h
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:26:42 -0500
Received: from 19.mo3.mail-out.ovh.net ([178.32.98.231]:58971)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gUgYv-0004pY-IP
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:26:37 -0500
Received: from player714.ha.ovh.net (unknown [10.109.160.12])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 2D9401EBCF0
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 00:26:22 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  6 Dec 2018 00:22:51 +0100
Message-Id: <20181205232251.10446-38-clg@kaod.org>
In-Reply-To: <20181205232251.10446-1-clg@kaod.org>
References: <20181205232251.10446-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 37/37] spapr: add KVM support to the 'dual'
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

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
sequences of the KVM device. The post_load handlers also are, to take
into account a possible change of interrupt mode after transfer.

As KVM is now initialized at reset, we loose the possiblity to
fallback to the QEMU emulated mode in case of failure and failures
become fatal to the machine.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive.c     |  8 +----
 hw/intc/spapr_xive_kvm.c | 26 +++++++++++++++
 hw/intc/xics_kvm.c       | 25 +++++++++++++++
 hw/intc/xive.c           |  4 ---
 hw/ppc/spapr_irq.c       | 68 +++++++++++++++++++++++++++-------------
 5 files changed, 98 insertions(+), 33 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 68d2a6fd8177..cdbcf27f9544 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -331,13 +331,7 @@ static void spapr_xive_realize(DeviceState *dev, Err=
or **errp)
     xive->eat =3D g_new0(XiveEAS, xive->nr_irqs);
     xive->endt =3D g_new0(XiveEND, xive->nr_ends);
=20
-    if (kvmppc_xive_enabled()) {
-        kvmppc_xive_connect(xive, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
-        }
-    } else {
+    if (!kvmppc_xive_enabled()) {
         /* TIMA initialization */
         memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &xive_tm_ops=
, xive,
                               "xive.tima", 4ull << TM_SHIFT);
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 6135b8c11e63..d7d499db1b5d 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -712,6 +712,14 @@ void kvmppc_xive_connect(sPAPRXive *xive, Error **er=
rp)
     Error *local_err =3D NULL;
     size_t esb_len;
     size_t tima_len;
+    CPUState *cs;
+
+    /* The KVM XIVE device already in use. This is the case when
+     * rebooting XIVE -> XIVE
+     */
+    if (xive->fd !=3D -1) {
+        return;
+    }
=20
     if (!kvm_enabled() || !kvmppc_has_cap_xive()) {
         error_setg(errp,
@@ -774,6 +782,24 @@ void kvmppc_xive_connect(sPAPRXive *xive, Error **er=
rp)
     xive->change =3D qemu_add_vm_change_state_handler(
         kvmppc_xive_change_state_handler, xive);
=20
+    /* Connect the presenters to the initial VCPUs of the machine */
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+
+        kvmppc_xive_cpu_connect(XIVE_TCTX(cpu->intc), &local_err);
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
index 4355c9d12160..393e4e0bd79c 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -431,6 +431,15 @@ static void rtas_dummy(PowerPCCPU *cpu, sPAPRMachine=
State *spapr,
 int xics_kvm_init(sPAPRMachineState *spapr, Error **errp)
 {
     int rc;
+    CPUState *cs;
+    Error *local_err =3D NULL;
+
+    /* The KVM XICS device already in use. This is the case when
+     * rebooting XICS -> XICS
+     */
+    if (kernel_xics_fd !=3D -1) {
+        return 0;
+    }
=20
     if (!kvm_enabled() || !kvm_check_extension(kvm_state, KVM_CAP_IRQ_XI=
CS)) {
         error_setg(errp,
@@ -479,6 +488,22 @@ int xics_kvm_init(sPAPRMachineState *spapr, Error **=
errp)
     kvm_msi_via_irqfd_allowed =3D true;
     kvm_gsi_direct_mapping =3D true;
=20
+    /* Connect the presenters to the initial VCPUs of the machine */
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+        ICPState *icp =3D ICP(cpu->intc);
+
+        icp_kvm_connect(icp, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            goto fail;
+        }
+        icp_set_kvm_state(icp, 1);
+    }
+
+    /* Update the KVM sources */
+    ics_set_kvm_state(ICS_KVM(spapr->ics), 1);
+
     return 0;
=20
 fail:
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index cde46b5ca161..cb07a7f36f8c 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -958,10 +958,6 @@ static void xive_source_reset(void *dev)
=20
     /* PQs are initialized to 0b01 (Q=3D1) which corresponds to "ints of=
f" */
     memset(xsrc->status, XIVE_ESB_OFF, xsrc->nr_irqs);
-
-    if (kvmppc_xive_enabled()) {
-        kvmppc_xive_source_reset(xsrc, &error_fatal);
-    }
 }
=20
 static void xive_source_realize(DeviceState *dev, Error **errp)
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 157c335f6f8d..0b5b3469b899 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -98,20 +98,14 @@ static void spapr_irq_init_xics(sPAPRMachineState *sp=
apr, int nr_irqs,
     MachineState *machine =3D MACHINE(spapr);
     Error *local_err =3D NULL;
=20
-    if (kvm_enabled()) {
-        if (machine_kernel_irqchip_allowed(machine) &&
-            !xics_kvm_init(spapr, &local_err)) {
-            spapr->icp_type =3D TYPE_KVM_ICP;
-            spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs=
,
-                                          &local_err);
-        }
-        if (machine_kernel_irqchip_required(machine) && !spapr->ics) {
-            error_prepend(&local_err,
-                          "kernel_irqchip requested but unavailable: ");
-            goto error;
+    if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
+        spapr->icp_type =3D TYPE_KVM_ICP;
+        spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs,
+                                      &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
         }
-        error_free(local_err);
-        local_err =3D NULL;
     }
=20
     if (!spapr->ics) {
@@ -119,10 +113,11 @@ static void spapr_irq_init_xics(sPAPRMachineState *=
spapr, int nr_irqs,
         spapr->icp_type =3D TYPE_ICP;
         spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irqs,
                                       &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
     }
-
-error:
-    error_propagate(errp, local_err);
 }
=20
 #define ICS_IRQ_FREE(ics, srcno)   \
@@ -211,7 +206,9 @@ static int spapr_irq_post_load_xics(sPAPRMachineState=
 *spapr, int version_id)
=20
 static void spapr_irq_reset_xics(sPAPRMachineState *spapr, Error **errp)
 {
+    MachineState *machine =3D MACHINE(spapr);
     CPUState *cs;
+    Error *local_err =3D NULL;
=20
     CPU_FOREACH(cs) {
         spapr_cpu_core_set_intc(POWERPC_CPU(cs), spapr->icp_type);
@@ -221,6 +218,22 @@ static void spapr_irq_reset_xics(sPAPRMachineState *=
spapr, Error **errp)
     if (spapr->xive) {
         spapr_xive_enable_mmio(spapr->xive, false);
     }
+
+    /* Get rid of the KVM XIVE device and activate XICS */
+    if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
+        kvmppc_xive_disconnect(spapr->xive, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            error_prepend(errp, "KVM XIVE disconnect failed: ");
+            return;
+        }
+        xics_kvm_init(spapr, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            error_prepend(errp, "KVM XICS connect failed: ");
+            return;
+        }
+    }
 }
=20
 #define SPAPR_IRQ_XICS_NR_IRQS     0x1000
@@ -360,6 +373,7 @@ static int spapr_irq_post_load_xive(sPAPRMachineState=
 *spapr, int version_id)
 static void spapr_irq_reset_xive(sPAPRMachineState *spapr, Error **errp)
 {
     CPUState *cs;
+    Error *local_err =3D NULL;
=20
     CPU_FOREACH(cs) {
         spapr_cpu_core_set_intc(POWERPC_CPU(cs), TYPE_XIVE_TCTX);
@@ -371,6 +385,22 @@ static void spapr_irq_reset_xive(sPAPRMachineState *=
spapr, Error **errp)
      */
     spapr_xive_reset_tctx(spapr->xive);
=20
+    /* Get rid of the KVM XICS device and activate XIVE */
+    if (kvmppc_xive_enabled()) {
+        xics_kvm_disconnect(spapr, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            error_prepend(errp, "KVM XICS disconnect failed: ");
+            return;
+        }
+        kvmppc_xive_connect(spapr->xive, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            error_prepend(errp, "KVM XIVE connect failed: ");
+            return;
+        }
+    }
+
     /* Activate the XIVE MMIOs */
     spapr_xive_enable_mmio(spapr->xive, true);
 }
@@ -421,14 +451,8 @@ static sPAPRIrq *spapr_irq_current(sPAPRMachineState=
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
--=20
2.17.2
