Received: from eggs.gnu.org ([2001:4830:134:3::10]:60928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gaDee-0001N2-V5
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 00:47:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gaDed-0000cE-Ht
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 00:47:24 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 21 Dec 2018 16:46:03 +1100
Message-Id: <20181221054606.22007-38-david@gibson.dropbear.id.au>
In-Reply-To: <20181221054606.22007-1-david@gibson.dropbear.id.au>
References: <20181221054606.22007-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 37/40] spapr: add an extra OV5 field to the
 sPAPR IRQ backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, gkurz@redhat.com, lvivier@redhat.com, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

The interrupt modes supported by the hypervisor are advertised to the
guest with new bits definitions of the option vector 5 of property
"ibm,arch-vec-5-platform-support. The byte 23 bits 0-1 of the OV5 are
defined as follow :

  0b00   PAPR 2.7 and earlier (Legacy systems)
  0b01   XIVE Exploitation mode only
  0b10   Either available

If the client/guest selects the XIVE interrupt mode, it informs the
hypervisor by returning the value 0b01 in byte 23 bits 0-1. A 0b00
value indicates the use of the XICS interrupt mode (Legacy systems).

The sPAPR IRQ backend is extended with these definitions and the
values are directly used to populate the "ibm,arch-vec-5-platform-support=
"
property. The interrupt mode is advertised under TCG and under KVM.
Although a KVM XIVE device is not yet available, the machine can still
operate with kernel_irqchip=3Doff. However, we apply a restriction on
the CPU which is required to be a POWER9 when a XIVE interrupt
controller is in use.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c             | 33 ++++++++++++++++++++++++++-------
 hw/ppc/spapr_irq.c         |  3 +++
 include/hw/ppc/spapr.h     |  6 ++++++
 include/hw/ppc/spapr_irq.h |  1 +
 4 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 487f80e940..2f87c8ba19 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1095,15 +1095,19 @@ static void spapr_dt_rtas(sPAPRMachineState *spap=
r, void *fdt)
     spapr_dt_rtas_tokens(fdt, rtas);
 }
=20
-/* Prepare ibm,arch-vec-5-platform-support, which indicates the MMU feat=
ures
- * that the guest may request and thus the valid values for bytes 24..26=
 of
- * option vector 5: */
-static void spapr_dt_ov5_platform_support(void *fdt, int chosen)
+/*
+ * Prepare ibm,arch-vec-5-platform-support, which indicates the MMU
+ * and the XIVE features that the guest may request and thus the valid
+ * values for bytes 23..26 of option vector 5:
+ */
+static void spapr_dt_ov5_platform_support(sPAPRMachineState *spapr, void=
 *fdt,
+                                          int chosen)
 {
     PowerPCCPU *first_ppc_cpu =3D POWERPC_CPU(first_cpu);
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
=20
     char val[2 * 4] =3D {
-        23, 0x00, /* Xive mode, filled in below. */
+        23, smc->irq->ov5, /* Xive mode. */
         24, 0x00, /* Hash/Radix, filled in below. */
         25, 0x00, /* Hash options: Segment Tables =3D=3D no, GTSE =3D=3D=
 no. */
         26, 0x40, /* Radix options: GTSE =3D=3D yes. */
@@ -1111,7 +1115,11 @@ static void spapr_dt_ov5_platform_support(void *fd=
t, int chosen)
=20
     if (!ppc_check_compat(first_ppc_cpu, CPU_POWERPC_LOGICAL_3_00, 0,
                           first_ppc_cpu->compat_pvr)) {
-        /* If we're in a pre POWER9 compat mode then the guest should do=
 hash */
+        /*
+         * If we're in a pre POWER9 compat mode then the guest should
+         * do hash and use the legacy interrupt mode
+         */
+        val[1] =3D 0x00; /* XICS */
         val[3] =3D 0x00; /* Hash */
     } else if (kvm_enabled()) {
         if (kvmppc_has_cap_mmu_radix() && kvmppc_has_cap_mmu_hash_v3()) =
{
@@ -1189,7 +1197,7 @@ static void spapr_dt_chosen(sPAPRMachineState *spap=
r, void *fdt)
         _FDT(fdt_setprop_string(fdt, chosen, "stdout-path", stdout_path)=
);
     }
=20
-    spapr_dt_ov5_platform_support(fdt, chosen);
+    spapr_dt_ov5_platform_support(spapr, fdt, chosen);
=20
     g_free(stdout_path);
     g_free(bootlist);
@@ -2624,6 +2632,17 @@ static void spapr_machine_init(MachineState *machi=
ne)
     /* advertise support for ibm,dyamic-memory-v2 */
     spapr_ovec_set(spapr->ov5, OV5_DRMEM_V2);
=20
+    /* advertise XIVE on POWER9 machines */
+    if (smc->irq->ov5 & SPAPR_OV5_XIVE_EXPLOIT) {
+        if (ppc_type_check_compat(machine->cpu_type, CPU_POWERPC_LOGICAL=
_3_00,
+                                  0, spapr->max_compat_pvr)) {
+            spapr_ovec_set(spapr->ov5, OV5_XIVE_EXPLOIT);
+        } else {
+            error_report("XIVE-only machines require a POWER9 CPU");
+            exit(1);
+        }
+    }
+
     /* init CPUs */
     spapr_init_cpus(spapr);
=20
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 9ecbf47329..9e3aa85b6d 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -216,6 +216,7 @@ static int spapr_irq_post_load_xics(sPAPRMachineState=
 *spapr, int version_id)
 sPAPRIrq spapr_irq_xics =3D {
     .nr_irqs     =3D SPAPR_IRQ_XICS_NR_IRQS,
     .nr_msis     =3D SPAPR_IRQ_XICS_NR_MSIS,
+    .ov5         =3D SPAPR_OV5_XIVE_LEGACY,
=20
     .init        =3D spapr_irq_init_xics,
     .claim       =3D spapr_irq_claim_xics,
@@ -343,6 +344,7 @@ static void spapr_irq_reset_xive(sPAPRMachineState *s=
papr, Error **errp)
 sPAPRIrq spapr_irq_xive =3D {
     .nr_irqs     =3D SPAPR_IRQ_XIVE_NR_IRQS,
     .nr_msis     =3D SPAPR_IRQ_XIVE_NR_MSIS,
+    .ov5         =3D SPAPR_OV5_XIVE_EXPLOIT,
=20
     .init        =3D spapr_irq_init_xive,
     .claim       =3D spapr_irq_claim_xive,
@@ -467,6 +469,7 @@ int spapr_irq_find(sPAPRMachineState *spapr, int num,=
 bool align, Error **errp)
 sPAPRIrq spapr_irq_xics_legacy =3D {
     .nr_irqs     =3D SPAPR_IRQ_XICS_LEGACY_NR_IRQS,
     .nr_msis     =3D SPAPR_IRQ_XICS_LEGACY_NR_IRQS,
+    .ov5         =3D SPAPR_OV5_XIVE_LEGACY,
=20
     .init        =3D spapr_irq_init_xics,
     .claim       =3D spapr_irq_claim_xics,
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 6bf028a02f..06765b4e9d 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -824,5 +824,11 @@ int spapr_caps_post_migration(sPAPRMachineState *spa=
pr);
=20
 void spapr_check_pagesize(sPAPRMachineState *spapr, hwaddr pagesize,
                           Error **errp);
+/*
+ * XIVE definitions
+ */
+#define SPAPR_OV5_XIVE_LEGACY   0x0
+#define SPAPR_OV5_XIVE_EXPLOIT  0x40
+#define SPAPR_OV5_XIVE_BOTH     0x80 /* Only to advertise on the platfor=
m */
=20
 #endif /* HW_SPAPR_H */
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 63061a009b..b34d5a0038 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -33,6 +33,7 @@ void spapr_irq_msi_reset(sPAPRMachineState *spapr);
 typedef struct sPAPRIrq {
     uint32_t    nr_irqs;
     uint32_t    nr_msis;
+    uint8_t     ov5;
=20
     void (*init)(sPAPRMachineState *spapr, Error **errp);
     int (*claim)(sPAPRMachineState *spapr, int irq, bool lsi, Error **er=
rp);
--=20
2.19.2
