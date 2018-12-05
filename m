Received: from eggs.gnu.org ([2001:4830:134:3::10]:44885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgYC-0007xM-9F
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:25:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgY7-0004GZ-9z
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:25:52 -0500
Received: from 2.mo177.mail-out.ovh.net ([178.33.109.80]:55326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gUgY6-0004CV-OS
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:25:46 -0500
Received: from player714.ha.ovh.net (unknown [10.109.159.248])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 52F2DD5D62
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 00:25:40 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  6 Dec 2018 00:22:43 +0100
Message-Id: <20181205232251.10446-30-clg@kaod.org>
In-Reply-To: <20181205232251.10446-1-clg@kaod.org>
References: <20181205232251.10446-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 29/37] spapr: set the interrupt presenter at
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
time. Setting it at reset will become useful when the new machine
supporting both interrupt modes is introduced. In this machine, the
interrupt mode is chosen at CAS time and activated after a reset.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr_cpu_core.h |  2 ++
 hw/ppc/spapr_cpu_core.c         | 26 ++++++++++++++++++++++++++
 hw/ppc/spapr_irq.c              | 11 +++++++++++
 3 files changed, 39 insertions(+)

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
index 1811cd48db90..529de0b6b9c8 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -398,3 +398,29 @@ static const TypeInfo spapr_cpu_core_type_infos[] =3D=
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
index 951d4ff1350a..f9b5564b271c 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -211,6 +211,11 @@ static int spapr_irq_post_load_xics(sPAPRMachineStat=
e *spapr, int version_id)
=20
 static void spapr_irq_reset_xics(sPAPRMachineState *spapr, Error **errp)
 {
+    CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        spapr_cpu_core_set_intc(POWERPC_CPU(cs), spapr->icp_type);
+    }
 }
=20
 #define SPAPR_IRQ_XICS_NR_IRQS     0x1000
@@ -349,6 +354,12 @@ static int spapr_irq_post_load_xive(sPAPRMachineStat=
e *spapr, int version_id)
=20
 static void spapr_irq_reset_xive(sPAPRMachineState *spapr, Error **errp)
 {
+    CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        spapr_cpu_core_set_intc(POWERPC_CPU(cs), TYPE_XIVE_TCTX);
+    }
+
     /*
      * Set the OS CAM line of the cpu interrupt thread context. Needs
      * to come after the XiveTCTX reset handlers.
--=20
2.17.2
