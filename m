Received: from eggs.gnu.org ([209.51.188.92]:58540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh09K-0006Tn-DM
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:47:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh09I-00079B-TE
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:47:06 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  9 Jan 2019 09:45:59 +1100
Message-Id: <20190108224600.23125-29-david@gibson.dropbear.id.au>
In-Reply-To: <20190108224600.23125-1-david@gibson.dropbear.id.au>
References: <20190108224600.23125-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 28/29] spapr: introduce a new sPAPR IRQ backend
 supporting XIVE and XICS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

The 'dual' sPAPR IRQ backend supports both interrupt mode, XIVE
exploitation mode and the legacy compatibility mode (XICS). both modes
are not supported at the same time.

The machine starts with the legacy mode and a new interrupt mode can
then be negotiated by the CAS process. In this case, the new mode is
activated after a reset to take into account the required changes in
the machine. These impact the device tree layout, the interrupt
presenter object and the exposed MMIO regions in the case of XIVE.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c             |  10 ++-
 hw/ppc/spapr_hcall.c       |  11 +++
 hw/ppc/spapr_irq.c         | 179 +++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr_irq.h |   1 +
 4 files changed, 198 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 59faeccf4b..83081defde 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2686,11 +2686,11 @@ static void spapr_machine_init(MachineState *mach=
ine)
     spapr_ovec_set(spapr->ov5, OV5_DRMEM_V2);
=20
     /* advertise XIVE on POWER9 machines */
-    if (spapr->irq->ov5 & SPAPR_OV5_XIVE_EXPLOIT) {
+    if (spapr->irq->ov5 & (SPAPR_OV5_XIVE_EXPLOIT | SPAPR_OV5_XIVE_BOTH)=
) {
         if (ppc_type_check_compat(machine->cpu_type, CPU_POWERPC_LOGICAL=
_3_00,
                                   0, spapr->max_compat_pvr)) {
             spapr_ovec_set(spapr->ov5, OV5_XIVE_EXPLOIT);
-        } else {
+        } else if (spapr->irq->ov5 & SPAPR_OV5_XIVE_EXPLOIT) {
             error_report("XIVE-only machines require a POWER9 CPU");
             exit(1);
         }
@@ -3116,6 +3116,8 @@ static char *spapr_get_ic_mode(Object *obj, Error *=
*errp)
         return g_strdup("xics");
     } else if (spapr->irq =3D=3D &spapr_irq_xive) {
         return g_strdup("xive");
+    } else if (spapr->irq =3D=3D &spapr_irq_dual) {
+        return g_strdup("dual");
     }
     g_assert_not_reached();
 }
@@ -3129,6 +3131,8 @@ static void spapr_set_ic_mode(Object *obj, const ch=
ar *value, Error **errp)
         spapr->irq =3D &spapr_irq_xics;
     } else if (strcmp(value, "xive") =3D=3D 0) {
         spapr->irq =3D &spapr_irq_xive;
+    } else if (strcmp(value, "dual") =3D=3D 0) {
+        spapr->irq =3D &spapr_irq_dual;
     } else {
         error_setg(errp, "Bad value for \"ic-mode\" property");
     }
@@ -3177,7 +3181,7 @@ static void spapr_instance_init(Object *obj)
     object_property_add_str(obj, "ic-mode", spapr_get_ic_mode,
                             spapr_set_ic_mode, NULL);
     object_property_set_description(obj, "ic-mode",
-                 "Specifies the interrupt controller mode (xics, xive)",
+                 "Specifies the interrupt controller mode (xics, xive, d=
ual)",
                  NULL);
 }
=20
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 1ae3e6ff5e..17bcaa3822 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1654,6 +1654,17 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
             (spapr_h_cas_compose_response(spapr, args[1], args[2],
                                           ov5_updates) !=3D 0);
     }
+
+    /*
+     * Generate a machine reset when we have an update of the
+     * interrupt mode. Only required when the machine supports both
+     * modes.
+     */
+    if (!spapr->cas_reboot) {
+        spapr->cas_reboot =3D spapr_ovec_test(ov5_updates, OV5_XIVE_EXPL=
OIT)
+            && spapr->irq->ov5 & SPAPR_OV5_XIVE_BOTH;
+    }
+
     spapr_ovec_cleanup(ov5_updates);
=20
     if (spapr->cas_reboot) {
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index d23914887a..d110b8cdee 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -230,6 +230,11 @@ static void spapr_irq_set_irq_xics(void *opaque, int=
 srcno, int val)
     }
 }
=20
+static void spapr_irq_reset_xics(sPAPRMachineState *spapr, Error **errp)
+{
+    /* TODO: create the KVM XICS device */
+}
+
 #define SPAPR_IRQ_XICS_NR_IRQS     0x1000
 #define SPAPR_IRQ_XICS_NR_MSIS     \
     (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
@@ -247,6 +252,7 @@ sPAPRIrq spapr_irq_xics =3D {
     .dt_populate =3D spapr_dt_xics,
     .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
     .post_load   =3D spapr_irq_post_load_xics,
+    .reset       =3D spapr_irq_reset_xics,
     .set_irq     =3D spapr_irq_set_irq_xics,
 };
=20
@@ -403,6 +409,179 @@ sPAPRIrq spapr_irq_xive =3D {
     .set_irq     =3D spapr_irq_set_irq_xive,
 };
=20
+/*
+ * Dual XIVE and XICS IRQ backend.
+ *
+ * Both interrupt mode, XIVE and XICS, objects are created but the
+ * machine starts in legacy interrupt mode (XICS). It can be changed
+ * by the CAS negotiation process and, in that case, the new mode is
+ * activated after an extra machine reset.
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
+static void spapr_irq_init_dual(sPAPRMachineState *spapr, Error **errp)
+{
+    MachineState *machine =3D MACHINE(spapr);
+    Error *local_err =3D NULL;
+
+    if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
+        error_setg(errp, "No KVM support for the 'dual' machine");
+        return;
+    }
+
+    spapr_irq_xics.init(spapr, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    /*
+     * Align the XICS and the XIVE IRQ number space under QEMU.
+     *
+     * However, the XICS KVM device still considers that the IRQ
+     * numbers should start at XICS_IRQ_BASE (0x1000). Either we
+     * should introduce a KVM device ioctl to set the offset or ignore
+     * the lower 4K numbers when using the get/set ioctl of the XICS
+     * KVM device. The second option seems the least intrusive.
+     */
+    spapr->ics->offset =3D 0;
+
+    spapr_irq_xive.init(spapr, &local_err);
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
+    Error *local_err =3D NULL;
+    int ret;
+
+    ret =3D spapr_irq_xics.claim(spapr, irq, lsi, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return ret;
+    }
+
+    ret =3D spapr_irq_xive.claim(spapr, irq, lsi, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return ret;
+    }
+
+    return ret;
+}
+
+static void spapr_irq_free_dual(sPAPRMachineState *spapr, int irq, int n=
um)
+{
+    spapr_irq_xics.free(spapr, irq, num);
+    spapr_irq_xive.free(spapr, irq, num);
+}
+
+static qemu_irq spapr_qirq_dual(sPAPRMachineState *spapr, int irq)
+{
+    sPAPRXive *xive =3D spapr->xive;
+    ICSState *ics =3D spapr->ics;
+
+    if (irq >=3D spapr->irq->nr_irqs) {
+        return NULL;
+    }
+
+    /*
+     * The IRQ number should have been claimed under both interrupt
+     * controllers.
+     */
+    assert(!ICS_IRQ_FREE(ics, irq - ics->offset));
+    assert(xive_eas_is_valid(&xive->eat[irq]));
+
+    return spapr->qirqs[irq];
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
+static void spapr_irq_cpu_intc_create_dual(sPAPRMachineState *spapr,
+                                           PowerPCCPU *cpu, Error **errp=
)
+{
+    Error *local_err =3D NULL;
+
+    spapr_irq_xive.cpu_intc_create(spapr, cpu, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    spapr_irq_xics.cpu_intc_create(spapr, cpu, errp);
+}
+
+static int spapr_irq_post_load_dual(sPAPRMachineState *spapr, int versio=
n_id)
+{
+    /*
+     * Force a reset of the XIVE backend after migration. The machine
+     * defaults to XICS at startup.
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
+    spapr_irq_current(spapr)->reset(spapr, errp);
+}
+
+static void spapr_irq_set_irq_dual(void *opaque, int srcno, int val)
+{
+    sPAPRMachineState *spapr =3D opaque;
+
+    spapr_irq_current(spapr)->set_irq(spapr, srcno, val);
+}
+
+/*
+ * Define values in sync with the XIVE and XICS backend
+ */
+#define SPAPR_IRQ_DUAL_NR_IRQS     0x2000
+#define SPAPR_IRQ_DUAL_NR_MSIS     (SPAPR_IRQ_DUAL_NR_IRQS - SPAPR_IRQ_M=
SI)
+
+sPAPRIrq spapr_irq_dual =3D {
+    .nr_irqs     =3D SPAPR_IRQ_DUAL_NR_IRQS,
+    .nr_msis     =3D SPAPR_IRQ_DUAL_NR_MSIS,
+    .ov5         =3D SPAPR_OV5_XIVE_BOTH,
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
+    .set_irq     =3D spapr_irq_set_irq_dual
+};
+
 /*
  * sPAPR IRQ frontend routines for devices
  */
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 283bb5002c..14b02c3aca 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -52,6 +52,7 @@ typedef struct sPAPRIrq {
 extern sPAPRIrq spapr_irq_xics;
 extern sPAPRIrq spapr_irq_xics_legacy;
 extern sPAPRIrq spapr_irq_xive;
+extern sPAPRIrq spapr_irq_dual;
=20
 void spapr_irq_init(sPAPRMachineState *spapr, Error **errp);
 int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Error *=
*errp);
--=20
2.20.1
