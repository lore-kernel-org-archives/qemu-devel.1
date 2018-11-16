Received: from eggs.gnu.org ([2001:4830:134:3::10]:34670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gNbrv-0000dv-51
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 06:01:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gNbrp-0001Cj-Mv
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 06:00:59 -0500
Received: from 6.mo4.mail-out.ovh.net ([188.165.36.253]:35196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gNbrp-0000Xa-BV
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 06:00:53 -0500
Received: from player734.ha.ovh.net (unknown [10.109.160.12])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id F0D0A1C14AE
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 12:00:06 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 16 Nov 2018 11:57:19 +0100
Message-Id: <20181116105729.23240-27-clg@kaod.org>
In-Reply-To: <20181116105729.23240-1-clg@kaod.org>
References: <20181116105729.23240-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 26/36] spapr: add a 'pseries-3.1-dual'
 machine type
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

This pseries machine makes use of a new sPAPR IRQ backend supporting
both interrupt modes : XIVE and XICS, the default being XICS.

The interrupt mode is chosen by the CAS negotiation process and
activated after a reset to take into account the required changes in
the machine. These impact the device tree layout, the interrupt
presenter object and the exposed MMIO regions in the case of XIVE.

KVM is not yet supported.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr_irq.h |   1 +
 hw/ppc/spapr.c             |  15 ++++
 hw/ppc/spapr_hcall.c       |  16 +++++
 hw/ppc/spapr_irq.c         | 140 +++++++++++++++++++++++++++++++++++++
 4 files changed, 172 insertions(+)

diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 34128976e21c..08f12ee3177b 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -52,6 +52,7 @@ typedef struct sPAPRIrq {
 extern sPAPRIrq spapr_irq_xics;
 extern sPAPRIrq spapr_irq_xics_legacy;
 extern sPAPRIrq spapr_irq_xive;
+extern sPAPRIrq spapr_irq_dual;
=20
 void spapr_irq_init(sPAPRMachineState *spapr, int nr_servers, Error **er=
rp);
 int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Error *=
*errp);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 013e6ea8aa64..03f6fb93ed47 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3999,6 +3999,21 @@ static void spapr_machine_3_1_xive_class_options(M=
achineClass *mc)
=20
 DEFINE_SPAPR_MACHINE(3_1_xive, "3.1-xive", false);
=20
+static void spapr_machine_3_1_dual_instance_options(MachineState *machin=
e)
+{
+    spapr_machine_3_1_instance_options(machine);
+}
+
+static void spapr_machine_3_1_dual_class_options(MachineClass *mc)
+{
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
+
+    spapr_machine_3_1_class_options(mc);
+    smc->irq =3D &spapr_irq_dual;
+}
+
+DEFINE_SPAPR_MACHINE(3_1_dual, "3.1-dual", false);
+
 /*
  * pseries-3.0
  */
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index ae913d070f50..e9cc3697c02f 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1654,6 +1654,22 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
             (spapr_h_cas_compose_response(spapr, args[1], args[2],
                                           ov5_updates) !=3D 0);
     }
+
+    /*
+     * Generate a machine reset when we have an update of the
+     * interrupt mode.
+     */
+    if (!spapr->cas_reboot) {
+        sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
+
+        /*
+         * The reset is not required when running under the XIVE-only
+         * machine. This test can be certainly improved.
+         */
+        spapr->cas_reboot =3D spapr_ovec_test(ov5_updates, OV5_XIVE_EXPL=
OIT)
+            && smc->irq !=3D &spapr_irq_xive;
+    }
+
     spapr_ovec_cleanup(ov5_updates);
=20
     if (spapr->cas_reboot) {
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 969efad7e6e9..79ead51c630d 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -408,6 +408,146 @@ sPAPRIrq spapr_irq_xive =3D {
     .reset       =3D spapr_irq_reset_xive,
 };
=20
+/*
+ * Dual XIVE and XICS IRQ backend.
+ *
+ * Both interrupt mode, XIVE and XICS, objects are created but the
+ * machine starts in legacy interrupt mode (XICS). It can be changed
+ * by the CAS negotiation process and, in that case, the new mode is
+ * activated after extra machine reset.
+ */
+
+/*
+ * Returns the sPAPR IRQ backend negotiated by CAS. XICS is the
+ * default.
+ */
+static sPAPRIrq *spapr_irq_current(sPAPRMachineState *spapr)
+{
+    return spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT) ?
+        &spapr_irq_xive : &spapr_irq_xics;
+}
+
+static void spapr_irq_init_dual(sPAPRMachineState *spapr, int nr_irqs,
+                                int nr_servers, Error **errp)
+{
+    Error *local_err =3D NULL;
+
+    if (kvm_enabled()) {
+        error_setg(errp, "No KVM support for the 'dual' machine");
+        return;
+    }
+
+    spapr_irq_xics.init(spapr, spapr_irq_xics.nr_irqs, nr_servers, &loca=
l_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    spapr_irq_xive.init(spapr, spapr_irq_xive.nr_irqs, nr_servers, &loca=
l_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+}
+
+static int spapr_irq_claim_dual(sPAPRMachineState *spapr, int irq, bool =
lsi,
+                                Error **errp)
+{
+    int ret;
+    Error *local_err =3D NULL;
+
+    ret =3D spapr_irq_xive.claim(spapr, irq, lsi, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return ret;
+    }
+
+    ret =3D spapr_irq_xics.claim(spapr, irq, lsi, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+    }
+
+    return ret;
+}
+
+static void spapr_irq_free_dual(sPAPRMachineState *spapr, int irq, int n=
um)
+{
+    spapr_irq_xive.free(spapr, irq, num);
+    spapr_irq_xics.free(spapr, irq, num);
+}
+
+static qemu_irq spapr_qirq_dual(sPAPRMachineState *spapr, int irq)
+{
+    return spapr_irq_current(spapr)->qirq(spapr, irq);
+}
+
+static void spapr_irq_print_info_dual(sPAPRMachineState *spapr, Monitor =
*mon)
+{
+    spapr_irq_current(spapr)->print_info(spapr, mon);
+}
+
+static void spapr_irq_dt_populate_dual(sPAPRMachineState *spapr,
+                                       uint32_t nr_servers, void *fdt,
+                                       uint32_t phandle)
+{
+    spapr_irq_current(spapr)->dt_populate(spapr, nr_servers, fdt, phandl=
e);
+}
+
+static Object *spapr_irq_cpu_intc_create_dual(sPAPRMachineState *spapr,
+                                              Object *cpu, Error **errp)
+{
+    Error *local_err =3D NULL;
+
+    spapr_irq_xive.cpu_intc_create(spapr, cpu, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return NULL;
+    }
+
+    /* Default to XICS interrupt mode */
+    return spapr_irq_xics.cpu_intc_create(spapr, cpu, errp);
+}
+
+static int spapr_irq_post_load_dual(sPAPRMachineState *spapr, int versio=
n_id)
+{
+    /*
+     * Force a reset of the XIVE backend after migration.
+     */
+    if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        spapr_irq_xive.reset(spapr, &error_fatal);
+    }
+
+    return spapr_irq_current(spapr)->post_load(spapr, version_id);
+}
+
+static void spapr_irq_reset_dual(sPAPRMachineState *spapr, Error **errp)
+{
+    /*
+     * Only XICS is reseted at startup as it is the default interrupt
+     * mode.
+     */
+    spapr_irq_current(spapr)->reset(spapr, errp);
+}
+
+#define SPAPR_IRQ_DUAL_NR_IRQS     0x2000
+#define SPAPR_IRQ_DUAL_NR_MSIS     (SPAPR_IRQ_DUAL_NR_IRQS - SPAPR_IRQ_M=
SI)
+
+sPAPRIrq spapr_irq_dual =3D {
+    .nr_irqs     =3D SPAPR_IRQ_DUAL_NR_IRQS,
+    .nr_msis     =3D SPAPR_IRQ_DUAL_NR_MSIS,
+    .ov5         =3D 0x80, /* both mode */
+
+    .init        =3D spapr_irq_init_dual,
+    .claim       =3D spapr_irq_claim_dual,
+    .free        =3D spapr_irq_free_dual,
+    .qirq        =3D spapr_qirq_dual,
+    .print_info  =3D spapr_irq_print_info_dual,
+    .dt_populate =3D spapr_irq_dt_populate_dual,
+    .cpu_intc_create =3D spapr_irq_cpu_intc_create_dual,
+    .post_load   =3D spapr_irq_post_load_dual,
+    .reset       =3D spapr_irq_reset_dual,
+};
+
 /*
  * sPAPR IRQ frontend routines for devices
  */
--=20
2.17.2
