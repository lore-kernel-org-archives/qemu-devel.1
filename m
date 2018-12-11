Received: from eggs.gnu.org ([2001:4830:134:3::10]:37363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWqhK-0007hA-Rx
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:40:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWqhH-0000Sm-HW
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:40:14 -0500
Received: from 3.mo5.mail-out.ovh.net ([46.105.40.108]:39113)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gWqhH-0000O0-3H
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:40:11 -0500
Received: from player688.ha.ovh.net (unknown [10.109.143.109])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 5493F209EB6
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 23:40:09 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 11 Dec 2018 23:38:19 +0100
Message-Id: <20181211223823.13770-9-clg@kaod.org>
In-Reply-To: <20181211223823.13770-1-clg@kaod.org>
References: <20181211223823.13770-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 08/12] spapr: introduce an 'ic-mode' machine
 option
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

This option is used to select the interrupt controller mode (XICS or
XIVE) with which the machine will operate. XICS being the default
mode for now.

When running a machine with the XIVE interrupt mode backend, the guest
OS is required to have support for the XIVE exploitation mode. In the
case of legacy OS, the mode selected by CAS should be XICS and the OS
should fail to boot. However, QEMU could possibly detect it, terminate
the boot process and reset to stop in the SLOF firmware. This is not
yet handled.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr.h  |  1 +
 hw/ppc/spapr.c          | 52 ++++++++++++++++++++++++++++++++++-------
 hw/ppc/spapr_cpu_core.c |  3 +--
 hw/ppc/spapr_irq.c      | 34 ++++++++-------------------
 4 files changed, 56 insertions(+), 34 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 06765b4e9d79..2c77a8ba8810 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -177,6 +177,7 @@ struct sPAPRMachineState {
     int32_t irq_map_nr;
     unsigned long *irq_map;
     sPAPRXive  *xive;
+    sPAPRIrq *irq;
=20
     bool cmd_line_caps[SPAPR_CAP_NUM];
     sPAPRCapabilities def, eff, mig;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ff138f224a87..5d985e38a598 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1102,7 +1102,6 @@ static void spapr_dt_ov5_platform_support(sPAPRMach=
ineState *spapr, void *fdt,
                                           int chosen)
 {
     PowerPCCPU *first_ppc_cpu =3D POWERPC_CPU(first_cpu);
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
=20
     char val[2 * 4] =3D {
         23, 0x00, /* Xive mode, filled in below. */
@@ -1122,7 +1121,7 @@ static void spapr_dt_ov5_platform_support(sPAPRMach=
ineState *spapr, void *fdt,
         /* If the KVM XIVE device is not available, the machine can
          * still operate with kernel_irqchip=3Doff
          */
-        val[1] =3D smc->irq->ov5;
+        val[1] =3D spapr->irq->ov5;
=20
         if (kvmppc_has_cap_mmu_radix() && kvmppc_has_cap_mmu_hash_v3()) =
{
             val[3] =3D 0x80; /* OV5_MMU_BOTH */
@@ -1133,7 +1132,7 @@ static void spapr_dt_ov5_platform_support(sPAPRMach=
ineState *spapr, void *fdt,
         }
     } else {
         /* In TCG, the interrupt mode is defined by the pseries machine =
*/
-        val[1] =3D smc->irq->ov5;
+        val[1] =3D spapr->irq->ov5;
=20
         /* V3 MMU supports both hash and radix in tcg (with dynamic swit=
ching) */
         val[3] =3D 0xC0;
@@ -1281,7 +1280,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spa=
pr,
     _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
=20
     /* /interrupt controller */
-    smc->irq->dt_populate(spapr, spapr_max_server_number(spapr), fdt,
+    spapr->irq->dt_populate(spapr, spapr_max_server_number(spapr), fdt,
                           PHANDLE_XICP);
=20
     ret =3D spapr_populate_memory(spapr, fdt);
@@ -1302,7 +1301,8 @@ static void *spapr_build_fdt(sPAPRMachineState *spa=
pr,
     }
=20
     QLIST_FOREACH(phb, &spapr->phbs, list) {
-        ret =3D spapr_populate_pci_dt(phb, PHANDLE_XICP, fdt, smc->irq->=
nr_msis);
+        ret =3D spapr_populate_pci_dt(phb, PHANDLE_XICP, fdt,
+                                    spapr->irq->nr_msis);
         if (ret < 0) {
             error_report("couldn't setup PCI devices in fdt");
             exit(1);
@@ -2636,7 +2636,7 @@ static void spapr_machine_init(MachineState *machin=
e)
     spapr_ovec_set(spapr->ov5, OV5_DRMEM_V2);
=20
     /* advertise XIVE on POWER9 machines */
-    if (smc->irq->ov5 & SPAPR_OV5_XIVE_EXPLOIT) {
+    if (spapr->irq->ov5 & SPAPR_OV5_XIVE_EXPLOIT) {
         if (ppc_type_check_compat(machine->cpu_type, CPU_POWERPC_LOGICAL=
_3_00,
                                   0, spapr->max_compat_pvr)) {
             spapr_ovec_set(spapr->ov5, OV5_XIVE_EXPLOIT);
@@ -3056,9 +3056,38 @@ static void spapr_set_vsmt(Object *obj, Visitor *v=
, const char *name,
     visit_type_uint32(v, name, (uint32_t *)opaque, errp);
 }
=20
+static char *spapr_get_ic_mode(Object *obj, Error **errp)
+{
+    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
+
+    if (spapr->irq =3D=3D &spapr_irq_xics_legacy) {
+        return g_strdup("legacy");
+    } else if (spapr->irq =3D=3D &spapr_irq_xics) {
+        return g_strdup("xics");
+    } else if (spapr->irq =3D=3D &spapr_irq_xive) {
+        return g_strdup("xive");
+    }
+    g_assert_not_reached();
+}
+
+static void spapr_set_ic_mode(Object *obj, const char *value, Error **er=
rp)
+{
+    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
+
+    /* The legacy IRQ backend can not be set */
+    if (strcmp(value, "xics") =3D=3D 0) {
+        spapr->irq =3D &spapr_irq_xics;
+    } else if (strcmp(value, "xive") =3D=3D 0) {
+        spapr->irq =3D &spapr_irq_xive;
+    } else {
+        error_setg(errp, "Bad value for \"ic-mode\" property");
+    }
+}
+
 static void spapr_instance_init(Object *obj)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
=20
     spapr->htab_fd =3D -1;
     spapr->use_hotplug_event_source =3D true;
@@ -3092,6 +3121,14 @@ static void spapr_instance_init(Object *obj)
                                     " the host's SMT mode", &error_abort=
);
     object_property_add_bool(obj, "vfio-no-msix-emulation",
                              spapr_get_msix_emulation, NULL, NULL);
+
+    /* The machine class defines the default interrupt controller mode *=
/
+    spapr->irq =3D smc->irq;
+    object_property_add_str(obj, "ic-mode", spapr_get_ic_mode,
+                            spapr_set_ic_mode, NULL);
+    object_property_set_description(obj, "ic-mode",
+                 "Specifies the interrupt controller mode (xics, xive)",
+                 NULL);
 }
=20
 static void spapr_machine_finalizefn(Object *obj)
@@ -3814,9 +3851,8 @@ static void spapr_pic_print_info(InterruptStatsProv=
ider *obj,
                                  Monitor *mon)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
=20
-    smc->irq->print_info(spapr, mon);
+    spapr->irq->print_info(spapr, mon);
 }
=20
 int spapr_get_vcpu_id(PowerPCCPU *cpu)
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 1811cd48db90..82666436e9b4 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -214,7 +214,6 @@ static void spapr_cpu_core_unrealize(DeviceState *dev=
, Error **errp)
 static void spapr_realize_vcpu(PowerPCCPU *cpu, sPAPRMachineState *spapr=
,
                                sPAPRCPUCore *sc, Error **errp)
 {
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
     CPUPPCState *env =3D &cpu->env;
     CPUState *cs =3D CPU(cpu);
     Error *local_err =3D NULL;
@@ -233,7 +232,7 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, sPAPR=
MachineState *spapr,
     qemu_register_reset(spapr_cpu_reset, cpu);
     spapr_cpu_reset(cpu);
=20
-    cpu->intc =3D smc->irq->cpu_intc_create(spapr, OBJECT(cpu), &local_e=
rr);
+    cpu->intc =3D spapr->irq->cpu_intc_create(spapr, OBJECT(cpu), &local=
_err);
     if (local_err) {
         goto error_unregister;
     }
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 79f06308995b..0999a2b2d69c 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -94,8 +94,7 @@ error:
 static void spapr_irq_init_xics(sPAPRMachineState *spapr, Error **errp)
 {
     MachineState *machine =3D MACHINE(spapr);
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
-    int nr_irqs =3D smc->irq->nr_irqs;
+    int nr_irqs =3D spapr->irq->nr_irqs;
     Error *local_err =3D NULL;
=20
     if (kvm_enabled()) {
@@ -234,7 +233,6 @@ sPAPRIrq spapr_irq_xics =3D {
 static void spapr_irq_init_xive(sPAPRMachineState *spapr, Error **errp)
 {
     MachineState *machine =3D MACHINE(spapr);
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
     uint32_t nr_servers =3D spapr_max_server_number(spapr);
     DeviceState *dev;
     int i;
@@ -248,7 +246,7 @@ static void spapr_irq_init_xive(sPAPRMachineState *sp=
apr, Error **errp)
     }
=20
     dev =3D qdev_create(NULL, TYPE_SPAPR_XIVE);
-    qdev_prop_set_uint32(dev, "nr-irqs", smc->irq->nr_irqs);
+    qdev_prop_set_uint32(dev, "nr-irqs", spapr->irq->nr_irqs);
     /*
      * 8 XIVE END structures per CPU. One for each available priority
      */
@@ -361,50 +359,38 @@ sPAPRIrq spapr_irq_xive =3D {
  */
 void spapr_irq_init(sPAPRMachineState *spapr, Error **errp)
 {
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
-
     /* Initialize the MSI IRQ allocator. */
     if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
-        spapr_irq_msi_init(spapr, smc->irq->nr_msis);
+        spapr_irq_msi_init(spapr, spapr->irq->nr_msis);
     }
=20
-    smc->irq->init(spapr, errp);
+    spapr->irq->init(spapr, errp);
 }
=20
 int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Error *=
*errp)
 {
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
-
-    return smc->irq->claim(spapr, irq, lsi, errp);
+    return spapr->irq->claim(spapr, irq, lsi, errp);
 }
=20
 void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num)
 {
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
-
-    smc->irq->free(spapr, irq, num);
+    spapr->irq->free(spapr, irq, num);
 }
=20
 qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq)
 {
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
-
-    return smc->irq->qirq(spapr, irq);
+    return spapr->irq->qirq(spapr, irq);
 }
=20
 int spapr_irq_post_load(sPAPRMachineState *spapr, int version_id)
 {
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
-
-    return smc->irq->post_load(spapr, version_id);
+    return spapr->irq->post_load(spapr, version_id);
 }
=20
 void spapr_irq_reset(sPAPRMachineState *spapr, Error **errp)
 {
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
-
-    if (smc->irq->reset) {
-        smc->irq->reset(spapr, errp);
+    if (spapr->irq->reset) {
+        spapr->irq->reset(spapr, errp);
     }
 }
=20
--=20
2.17.2
