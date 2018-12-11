Received: from eggs.gnu.org ([2001:4830:134:3::10]:37427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWqhQ-0007mm-38
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:40:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWqhM-0000bf-Tt
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:40:20 -0500
Received: from 7.mo177.mail-out.ovh.net ([46.105.61.149]:54539)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gWqhM-0000a1-IH
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:40:16 -0500
Received: from player688.ha.ovh.net (unknown [10.109.160.40])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id A1DF8D7210
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 23:40:14 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 11 Dec 2018 23:38:20 +0100
Message-Id: <20181211223823.13770-10-clg@kaod.org>
In-Reply-To: <20181211223823.13770-1-clg@kaod.org>
References: <20181211223823.13770-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 09/12] spapr: set the interrupt presenter at
 reset
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

Currently, the interrupt presenter of the vCPU is set at realize
time. Setting it at reset will become necessary when the new machine
supporting both interrupt modes is introduced. In this machine, the
interrupt mode is chosen at CAS time and activated after a reset.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Changes since v7:

 - introduced spapr_irq_reset_xics().=20

 include/hw/ppc/spapr_cpu_core.h |  2 ++
 hw/ppc/spapr_cpu_core.c         | 26 ++++++++++++++++++++++++++
 hw/ppc/spapr_irq.c              | 13 +++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_c=
ore.h
index 9e2821e4b31f..fc8ea9021656 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -53,4 +53,6 @@ static inline sPAPRCPUState *spapr_cpu_state(PowerPCCPU=
 *cpu)
     return (sPAPRCPUState *)cpu->machine_data;
 }
=20
+void spapr_cpu_core_set_intc(PowerPCCPU *cpu, const char *intc_type);
+
 #endif
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 82666436e9b4..afc5d4f4e739 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -397,3 +397,29 @@ static const TypeInfo spapr_cpu_core_type_infos[] =3D=
 {
 };
=20
 DEFINE_TYPES(spapr_cpu_core_type_infos)
+
+typedef struct ForeachFindIntCArgs {
+    const char *intc_type;
+    Object *intc;
+} ForeachFindIntCArgs;
+
+static int spapr_cpu_core_find_intc(Object *child, void *opaque)
+{
+    ForeachFindIntCArgs *args =3D opaque;
+
+    if (object_dynamic_cast(child, args->intc_type)) {
+        args->intc =3D child;
+    }
+
+    return args->intc !=3D NULL;
+}
+
+void spapr_cpu_core_set_intc(PowerPCCPU *cpu, const char *intc_type)
+{
+    ForeachFindIntCArgs args =3D { intc_type, NULL };
+
+    object_child_foreach(OBJECT(cpu), spapr_cpu_core_find_intc, &args);
+    g_assert(args.intc);
+
+    cpu->intc =3D args.intc;
+}
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 0999a2b2d69c..814500f22d34 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -12,6 +12,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "hw/ppc/spapr.h"
+#include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/spapr_xive.h"
 #include "hw/ppc/xics.h"
 #include "sysemu/kvm.h"
@@ -208,6 +209,15 @@ static int spapr_irq_post_load_xics(sPAPRMachineStat=
e *spapr, int version_id)
     return 0;
 }
=20
+static void spapr_irq_reset_xics(sPAPRMachineState *spapr, Error **errp)
+{
+   CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        spapr_cpu_core_set_intc(POWERPC_CPU(cs), spapr->icp_type);
+    }
+}
+
 #define SPAPR_IRQ_XICS_NR_IRQS     0x1000
 #define SPAPR_IRQ_XICS_NR_MSIS     \
     (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
@@ -225,6 +235,7 @@ sPAPRIrq spapr_irq_xics =3D {
     .dt_populate =3D spapr_dt_xics,
     .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
     .post_load   =3D spapr_irq_post_load_xics,
+    .reset       =3D spapr_irq_reset_xics,
 };
=20
 /*
@@ -325,6 +336,8 @@ static void spapr_irq_reset_xive(sPAPRMachineState *s=
papr, Error **errp)
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
=20
+        spapr_cpu_core_set_intc(cpu, TYPE_XIVE_TCTX);
+
         /* (TCG) Set the OS CAM line of the thread interrupt context. */
         spapr_xive_set_tctx_os_cam(XIVE_TCTX(cpu->intc));
     }
--=20
2.17.2
