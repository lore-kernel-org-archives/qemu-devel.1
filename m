Received: from eggs.gnu.org ([209.51.188.92]:42789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2to5-0000uM-WA
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2to4-0001Jp-Dp
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:41 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:28 +1100
Message-Id: <20190310082703.1245-26-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 25/60] ppc/pnv: change the CPU machine_data
 presenter type to Object *
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

The POWER9 PowerNV machine will use a XIVE interrupt presenter type.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190306085032.15744-6-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c              | 6 +++---
 hw/ppc/pnv_core.c         | 2 +-
 include/hw/ppc/pnv_core.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 9aa81c7f09..b90d03711a 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -684,7 +684,7 @@ static void pnv_chip_power8_intc_create(PnvChip *chip=
, PowerPCCPU *cpu,
         return;
     }
=20
-    pnv_cpu->icp =3D ICP(obj);
+    pnv_cpu->intc =3D obj;
 }
=20
 /*
@@ -1086,7 +1086,7 @@ static ICPState *pnv_icp_get(XICSFabric *xi, int pi=
r)
 {
     PowerPCCPU *cpu =3D ppc_get_vcpu_by_pir(pir);
=20
-    return cpu ? pnv_cpu_state(cpu)->icp : NULL;
+    return cpu ? ICP(pnv_cpu_state(cpu)->intc) : NULL;
 }
=20
 static void pnv_pic_print_info(InterruptStatsProvider *obj,
@@ -1099,7 +1099,7 @@ static void pnv_pic_print_info(InterruptStatsProvid=
er *obj,
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
=20
-        icp_pic_print_info(pnv_cpu_state(cpu)->icp, mon);
+        icp_pic_print_info(ICP(pnv_cpu_state(cpu)->intc), mon);
     }
=20
     for (i =3D 0; i < pnv->num_chips; i++) {
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 7c806da720..38179cdc53 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -198,7 +198,7 @@ static void pnv_unrealize_vcpu(PowerPCCPU *cpu)
     PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
=20
     qemu_unregister_reset(pnv_cpu_reset, cpu);
-    object_unparent(OBJECT(pnv_cpu_state(cpu)->icp));
+    object_unparent(OBJECT(pnv_cpu_state(cpu)->intc));
     cpu_remove_sync(CPU(cpu));
     cpu->machine_data =3D NULL;
     g_free(pnv_cpu);
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index 9961ea3a92..6874bb847a 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -48,7 +48,7 @@ typedef struct PnvCoreClass {
 #define PNV_CORE_TYPE_NAME(cpu_model) cpu_model PNV_CORE_TYPE_SUFFIX
=20
 typedef struct PnvCPUState {
-    struct ICPState *icp;
+    Object *intc;
 } PnvCPUState;
=20
 static inline PnvCPUState *pnv_cpu_state(PowerPCCPU *cpu)
--=20
2.20.1
