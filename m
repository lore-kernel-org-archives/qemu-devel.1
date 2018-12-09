Received: from eggs.gnu.org ([2001:4830:134:3::10]:36667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gW53G-00028D-Aa
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:47:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gW53C-0006iu-5b
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:47:42 -0500
Received: from 16.mo6.mail-out.ovh.net ([87.98.139.208]:50957)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gW539-0006UY-UQ
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:47:37 -0500
Received: from player695.ha.ovh.net (unknown [10.109.159.139])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 4052919D3BD
	for <qemu-devel@nongnu.org>; Sun,  9 Dec 2018 20:47:32 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Sun,  9 Dec 2018 20:46:04 +0100
Message-Id: <20181209194610.29727-14-clg@kaod.org>
In-Reply-To: <20181209194610.29727-1-clg@kaod.org>
References: <20181209194610.29727-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 13/19] spapr: add an extra OV5 field to the
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

This field defines the interrupt modes supported by the hypervisor in
the "ibm,arch-vec-5-platform-support" property. The CAS negotiation
process will select which mode to use.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr.h     |  6 ++++++
 include/hw/ppc/spapr_irq.h |  1 +
 hw/ppc/spapr.c             | 23 ++++++++++++++++++-----
 hw/ppc/spapr_irq.c         |  3 +++
 4 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 6bf028a02fe2..daced428a42c 100644
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
+#define SPAPR_OV5_XIVE_BOTH     0x80
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
index 98d69f09e080..5ef87a00f68b 100644
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
@@ -1121,7 +1123,13 @@ static void spapr_dt_ov5_platform_support(void *fd=
t, int chosen)
         } else {
             val[3] =3D 0x00; /* Hash */
         }
+        /* If the KVM XIVE device is not available, the machine can
+         * still operate with kernel_irqchip=3Doff
+         */
+        val[1] =3D smc->irq->ov5;
     } else {
+        val[1] =3D smc->irq->ov5;
+
         /* V3 MMU supports both hash and radix in tcg (with dynamic swit=
ching) */
         val[3] =3D 0xC0;
     }
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
@@ -2622,6 +2630,11 @@ static void spapr_machine_init(MachineState *machi=
ne)
     /* advertise support for ibm,dyamic-memory-v2 */
     spapr_ovec_set(spapr->ov5, OV5_DRMEM_V2);
=20
+    /* advertise XIVE */
+    if (smc->irq->ov5 =3D=3D SPAPR_OV5_XIVE_EXPLOIT) {
+        spapr_ovec_set(spapr->ov5, OV5_XIVE_EXPLOIT);
+    }
+
     /* init CPUs */
     spapr_init_cpus(spapr);
=20
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 04f5c9665550..7a0d4f529763 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -220,6 +220,7 @@ static void spapr_irq_reset_xics(sPAPRMachineState *s=
papr, Error **errp)
 sPAPRIrq spapr_irq_xics =3D {
     .nr_irqs     =3D SPAPR_IRQ_XICS_NR_IRQS,
     .nr_msis     =3D SPAPR_IRQ_XICS_NR_MSIS,
+    .ov5         =3D SPAPR_OV5_XIVE_LEGACY,
=20
     .init        =3D spapr_irq_init_xics,
     .claim       =3D spapr_irq_claim_xics,
@@ -358,6 +359,7 @@ static void spapr_irq_reset_xive(sPAPRMachineState *s=
papr, Error **errp)
 sPAPRIrq spapr_irq_xive =3D {
     .nr_irqs     =3D SPAPR_IRQ_XIVE_NR_IRQS,
     .nr_msis     =3D SPAPR_IRQ_XIVE_NR_MSIS,
+    .ov5         =3D SPAPR_OV5_XIVE_EXPLOIT,
=20
     .init        =3D spapr_irq_init_xive,
     .claim       =3D spapr_irq_claim_xive,
@@ -482,6 +484,7 @@ int spapr_irq_find(sPAPRMachineState *spapr, int num,=
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
