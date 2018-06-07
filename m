Received: from eggs.gnu.org ([2001:4830:134:3::10]:39257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxCt-0002uQ-V5
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:52:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxCp-0004H8-3l
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:52:12 -0400
Received: from 10.mo177.mail-out.ovh.net ([46.105.73.133]:47712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fQxCo-0004GK-Q7
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:52:07 -0400
Received: from player169.ha.ovh.net (unknown [10.109.122.74])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 80269B49CA
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 17:52:05 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Jun 2018 17:49:55 +0200
Message-Id: <20180607155003.1580-21-clg@kaod.org>
In-Reply-To: <20180607155003.1580-1-clg@kaod.org>
References: <20180607155003.1580-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 20/28] spapr: introduce a 'pseries-3.0-xive'
 QEMU machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The interrupt mode is statically defined to XIVE only for this machine.
The guest OS is required to have support for the XIVE exploitation
mode of the POWER9 interrupt controller.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr_irq.h |  1 +
 hw/ppc/spapr.c             | 35 ++++++++++++++++++++++++++++++-----
 hw/ppc/spapr_irq.c         |  3 +++
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 8046cbd83d61..85829928a9c4 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -31,6 +31,7 @@ typedef struct sPAPRPIrqRange {
 typedef struct sPAPRIrq {
     uint32_t    nr_irqs;
     const sPAPRPIrqRange *ranges;
+    uint8_t     ov5;
=20
     void (*init)(sPAPRMachineState *spapr, uint32_t nr_servers, Error **=
errp);
     int (*assign)(sPAPRMachineState *spapr, uint32_t range, uint32_t irq=
,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3340264e4cfb..2774b53f169e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1060,12 +1060,14 @@ static void spapr_dt_rtas(sPAPRMachineState *spap=
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
@@ -1086,7 +1088,10 @@ static void spapr_dt_ov5_platform_support(void *fd=
t, int chosen)
         } else {
             val[3] =3D 0x00; /* Hash */
         }
+        val[1] =3D smc->irq->ov5;
     } else {
+        val[1] =3D smc->irq->ov5;
+
         /* V3 MMU supports both hash and radix in tcg (with dynamic swit=
ching) */
         val[3] =3D 0xC0;
     }
@@ -1154,7 +1159,7 @@ static void spapr_dt_chosen(sPAPRMachineState *spap=
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
@@ -2577,6 +2582,11 @@ static void spapr_machine_init(MachineState *machi=
ne)
     /* advertise support for ibm,dyamic-memory-v2 */
     spapr_ovec_set(spapr->ov5, OV5_DRMEM_V2);
=20
+    /* advertise XIVE */
+    if (smc->irq->ov5) {
+        spapr_ovec_set(spapr->ov5, OV5_XIVE_EXPLOIT);
+    }
+
     /* init CPUs */
     spapr_init_cpus(spapr);
=20
@@ -3916,6 +3926,21 @@ static void spapr_machine_3_0_class_options(Machin=
eClass *mc)
=20
 DEFINE_SPAPR_MACHINE(3_0, "3.0", true);
=20
+static void spapr_machine_3_0_xive_instance_options(MachineState *machin=
e)
+{
+    spapr_machine_3_0_instance_options(machine);
+}
+
+static void spapr_machine_3_0_xive_class_options(MachineClass *mc)
+{
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
+
+    spapr_machine_3_0_class_options(mc);
+    smc->irq =3D &spapr_irq_xive;
+}
+
+DEFINE_SPAPR_MACHINE(3_0_xive, "3.0-xive", false);
+
 /*
  * pseries-2.12
  */
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 266f7db3be7b..745c78024d6f 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -256,6 +256,7 @@ static Object *spapr_irq_cpu_intc_create_legacy(sPAPR=
MachineState *spapr,
=20
 sPAPRIrq spapr_irq_legacy =3D {
     .nr_irqs     =3D XICS_IRQS_SPAPR,
+    .ov5         =3D 0x0, /* XICS only */
     .init        =3D spapr_irq_init_legacy,
     .assign      =3D spapr_irq_assign_legacy,
     .alloc       =3D spapr_irq_alloc_legacy,
@@ -522,6 +523,7 @@ static const sPAPRPIrqRange spapr_irq_ranges_xics[] =3D=
 {
=20
 sPAPRIrq spapr_irq_xics =3D {
     .nr_irqs     =3D 0x1000,
+    .ov5         =3D 0x0, /* XICS only */
     .init        =3D spapr_irq_init_xics,
     .ranges      =3D spapr_irq_ranges_xics,
     .assign      =3D spapr_irq_assign_xics,
@@ -743,6 +745,7 @@ static const sPAPRPIrqRange spapr_irq_ranges_xive[] =3D=
 {
=20
 sPAPRIrq spapr_irq_xive =3D {
     .nr_irqs     =3D 0x2000,
+    .ov5         =3D 0x40, /* XIVE exploitation mode only */
     .init        =3D spapr_irq_init_xive,
     .ranges      =3D spapr_irq_ranges_xive,
     .assign      =3D spapr_irq_assign_xive,
--=20
2.13.6
