Received: from eggs.gnu.org ([2001:4830:134:3::10]:37295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWqhG-0007fN-Ea
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:40:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWqhD-0000Hj-09
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:40:10 -0500
Received: from 20.mo1.mail-out.ovh.net ([188.165.45.168]:43389)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gWqhB-0000EQ-Lt
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:40:06 -0500
Received: from player688.ha.ovh.net (unknown [10.109.143.24])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 0FA92149AEF
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 23:40:04 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 11 Dec 2018 23:38:18 +0100
Message-Id: <20181211223823.13770-8-clg@kaod.org>
In-Reply-To: <20181211223823.13770-1-clg@kaod.org>
References: <20181211223823.13770-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 07/12] spapr: add an extra OV5 field to the
 sPAPR IRQ backend
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
---

 Changes since v7:

 - improved commit log
 - introduced a check on CPU type.

 include/hw/ppc/spapr.h     |  6 ++++++
 include/hw/ppc/spapr_irq.h |  1 +
 hw/ppc/spapr.c             | 36 ++++++++++++++++++++++++++++++------
 hw/ppc/spapr_irq.c         |  3 +++
 4 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 6bf028a02fe2..06765b4e9d79 100644
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
index 63061a009b4c..b34d5a00381b 100644
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
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 57c0066edd56..ff138f224a87 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1095,12 +1095,14 @@ static void spapr_dt_rtas(sPAPRMachineState *spap=
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
+/* Prepare ibm,arch-vec-5-platform-support, which indicates the MMU
+ * and the XIVE features that the guest may request and thus the valid
+ * values for bytes 23..26 of option vector 5: */
+static void spapr_dt_ov5_platform_support(sPAPRMachineState *spapr, void=
 *fdt,
+                                          int chosen)
 {
     PowerPCCPU *first_ppc_cpu =3D POWERPC_CPU(first_cpu);
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
=20
     char val[2 * 4] =3D {
         23, 0x00, /* Xive mode, filled in below. */
@@ -1111,9 +1113,17 @@ static void spapr_dt_ov5_platform_support(void *fd=
t, int chosen)
=20
     if (!ppc_check_compat(first_ppc_cpu, CPU_POWERPC_LOGICAL_3_00, 0,
                           first_ppc_cpu->compat_pvr)) {
-        /* If we're in a pre POWER9 compat mode then the guest should do=
 hash */
+        /* If we're in a pre POWER9 compat mode then the guest should do=
 hash
+         * and use the legacy interrupt mode
+         */
+        val[1] =3D 0x00; /* XICS */
         val[3] =3D 0x00; /* Hash */
     } else if (kvm_enabled()) {
+        /* If the KVM XIVE device is not available, the machine can
+         * still operate with kernel_irqchip=3Doff
+         */
+        val[1] =3D smc->irq->ov5;
+
         if (kvmppc_has_cap_mmu_radix() && kvmppc_has_cap_mmu_hash_v3()) =
{
             val[3] =3D 0x80; /* OV5_MMU_BOTH */
         } else if (kvmppc_has_cap_mmu_radix()) {
@@ -1122,6 +1132,9 @@ static void spapr_dt_ov5_platform_support(void *fdt=
, int chosen)
             val[3] =3D 0x00; /* Hash */
         }
     } else {
+        /* In TCG, the interrupt mode is defined by the pseries machine =
*/
+        val[1] =3D smc->irq->ov5;
+
         /* V3 MMU supports both hash and radix in tcg (with dynamic swit=
ching) */
         val[3] =3D 0xC0;
     }
@@ -1189,7 +1202,7 @@ static void spapr_dt_chosen(sPAPRMachineState *spap=
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
@@ -2622,6 +2635,17 @@ static void spapr_machine_init(MachineState *machi=
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
index f835ea939cbf..79f06308995b 100644
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
@@ -342,6 +343,7 @@ static void spapr_irq_reset_xive(sPAPRMachineState *s=
papr, Error **errp)
 sPAPRIrq spapr_irq_xive =3D {
     .nr_irqs     =3D SPAPR_IRQ_XIVE_NR_IRQS,
     .nr_msis     =3D SPAPR_IRQ_XIVE_NR_MSIS,
+    .ov5         =3D SPAPR_OV5_XIVE_EXPLOIT,
=20
     .init        =3D spapr_irq_init_xive,
     .claim       =3D spapr_irq_claim_xive,
@@ -466,6 +468,7 @@ int spapr_irq_find(sPAPRMachineState *spapr, int num,=
 bool align, Error **errp)
 sPAPRIrq spapr_irq_xics_legacy =3D {
     .nr_irqs     =3D SPAPR_IRQ_XICS_LEGACY_NR_IRQS,
     .nr_msis     =3D SPAPR_IRQ_XICS_LEGACY_NR_IRQS,
+    .ov5         =3D SPAPR_OV5_XIVE_LEGACY,
=20
     .init        =3D spapr_irq_init_xics,
     .claim       =3D spapr_irq_claim_xics,
--=20
2.17.2
