Received: from eggs.gnu.org ([2001:4830:134:3::10]:58259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98xA-0001Lh-SV
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:46:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98x6-00011i-Vt
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:46:20 -0400
Received: from 20.mo5.mail-out.ovh.net ([91.121.55.239]:39103)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f98x6-00010Q-NR
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:46:16 -0400
Received: from player792.ha.ovh.net (unknown [10.109.105.64])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 319181A2DB5
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:46:15 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Apr 2018 14:43:22 +0200
Message-Id: <20180419124331.3915-27-clg@kaod.org>
In-Reply-To: <20180419124331.3915-1-clg@kaod.org>
References: <20180419124331.3915-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 26/35] spapr/xive: add a XIVE KVM device to
 the machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

As the VM is connected to the KVM interrupt device at the init of the
machine, KVM support is added for XICS or for XIVE but not both at the
same time. This should change later on when KVM resets are supported.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics_kvm.c | 22 +++++++++++++++++++++-
 hw/ppc/spapr.c     | 34 +++++++++++++++++++++++-----------
 2 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 89fb20e2c55c..e727397c4a4d 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -62,6 +62,11 @@ static void icp_get_kvm_state(ICPState *icp)
     };
     int ret;
=20
+    /* A change of the interrupt mode can disable XICS */
+    if (kernel_xics_fd =3D=3D -1) {
+        return;
+    }
+
     /* ICP for this CPU thread is not in use, exiting */
     if (!icp->cs) {
         return;
@@ -102,6 +107,11 @@ static int icp_set_kvm_state(ICPState *icp, int vers=
ion_id)
     };
     int ret;
=20
+    /* Protect resets. A change of the interrupt mode can disable XICS *=
/
+    if (kernel_xics_fd =3D=3D -1) {
+        return 0;
+    }
+
     /* ICP for this CPU thread is not in use, exiting */
     if (!icp->cs) {
         return 0;
@@ -135,7 +145,7 @@ static void icp_kvm_realize(ICPState *icp, Error **er=
rp)
     int ret;
=20
     if (kernel_xics_fd =3D=3D -1) {
-        abort();
+        return;
     }
=20
     /*
@@ -192,6 +202,11 @@ static void ics_get_kvm_state(ICSState *ics)
     };
     int i;
=20
+    /* A change of the interrupt mode can disable XICS */
+    if (kernel_xics_fd =3D=3D -1) {
+        return;
+    }
+
     for (i =3D 0; i < ics->nr_irqs; i++) {
         ICSIRQState *irq =3D &ics->irqs[i];
         int ret;
@@ -262,6 +277,11 @@ static int ics_set_kvm_state(ICSState *ics, int vers=
ion_id)
     };
     int i;
=20
+    /* Protect resets. A change of the interrupt mode can disable XICS *=
/
+    if (kernel_xics_fd =3D=3D -1) {
+        return 0;
+    }
+
     for (i =3D 0; i < ics->nr_irqs; i++) {
         ICSIRQState *irq =3D &ics->irqs[i];
         int ret;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d05c83cdb322..c98ceeed9d6f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -189,8 +189,7 @@ static void xics_system_init(MachineState *machine, i=
nt nr_irqs, Error **errp)
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
=20
     if (kvm_enabled()) {
-        if (machine_kernel_irqchip_allowed(machine) &&
-            !xics_kvm_init(spapr, errp)) {
+        if (machine_kernel_irqchip_allowed(machine)) {
             spapr->icp_type =3D TYPE_KVM_ICP;
             spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs=
, errp);
         }
@@ -239,10 +238,16 @@ static void xive_system_init(MachineState *machine,=
 int nr_irqs, Error **errp)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
=20
-    /* We don't have KVM support yet, so check for irqchip=3Don */
-    if (kvm_enabled() && machine_kernel_irqchip_required(machine)) {
-        error_report("kernel_irqchip requested. no XIVE support");
-        exit(1);
+    if (kvm_enabled()) {
+        if (machine_kernel_irqchip_allowed(machine)) {
+            spapr->nvt_type =3D TYPE_XIVE_NVT_KVM;
+            spapr->xive =3D spapr_xive_create(spapr, TYPE_SPAPR_XIVE_KVM=
,
+                                            nr_irqs, errp);
+        }
+        if (machine_kernel_irqchip_required(machine) && !spapr->xive) {
+            error_prepend(errp, "kernel_irqchip requested but unavailabl=
e: ");
+            return;
+        }
     }
=20
     if (spapr->xive) {
@@ -1043,11 +1048,9 @@ static void spapr_dt_ov5_platform_support(sPAPRMac=
hineState *spapr, void *fdt,
         } else {
             val[3] =3D 0x00; /* Hash */
         }
-        /* TODO: introduce a kvmppc_has_cap_xive() ? Works with
-         * irqchip=3Doff for now
-         */
-        if (spapr->xive_exploitation) {
-            val[1] =3D 0x80; /* OV5_XIVE_BOTH */
+        /* TODO: when under KVM, only advertise XIVE but not both mode *=
/
+        if (spapr->xive_exploitation && kvmppc_has_cap_xive()) {
+            val[1] =3D 0x40; /* OV5_XIVE_EXPLOIT */
         }
     } else {
         if (spapr->xive_exploitation) {
@@ -2580,6 +2583,15 @@ static void spapr_machine_init(MachineState *machi=
ne)
         /* XIVE uses the full range of IRQ numbers. */
         xive_system_init(machine, XICS_IRQ_BASE + XICS_IRQS_SPAPR,
                          &error_fatal);
+
+        /* TODO: initialize KVM for XIVE or for XICS but not for both */
+        if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
+            xive_kvm_init(spapr->xive, &error_fatal);
+        }
+    } else {
+        if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
+            xics_kvm_init(spapr, &error_fatal);
+        }
     }
=20
     /* Set up containers for ibm,client-architecture-support negotiated =
options
--=20
2.13.6
