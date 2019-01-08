Received: from eggs.gnu.org ([209.51.188.92]:58914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh09u-00077a-9m
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:47:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh09t-0007px-5f
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:47:42 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  9 Jan 2019 09:45:53 +1100
Message-Id: <20190108224600.23125-23-david@gibson.dropbear.id.au>
In-Reply-To: <20190108224600.23125-1-david@gibson.dropbear.id.au>
References: <20190108224600.23125-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 22/29] ppc: replace the 'Object *intc' by a
 'ICPState *icp' pointer under the CPU
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

Now that the 'intc' pointer is only used by the XICS interrupt mode,
let's make things clear and use a XICS type and name.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics_spapr.c    | 10 +++++-----
 hw/ppc/pnv.c            |  6 +++---
 hw/ppc/pnv_core.c       |  2 +-
 hw/ppc/spapr.c          |  2 +-
 hw/ppc/spapr_cpu_core.c |  4 ++--
 hw/ppc/spapr_irq.c      |  6 +++---
 target/ppc/cpu.h        |  3 ++-
 7 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index f67d3c80bf..9c1a90d709 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -44,7 +44,7 @@ static target_ulong h_cppr(PowerPCCPU *cpu, sPAPRMachin=
eState *spapr,
 {
     target_ulong cppr =3D args[0];
=20
-    icp_set_cppr(ICP(cpu->intc), cppr);
+    icp_set_cppr(cpu->icp, cppr);
     return H_SUCCESS;
 }
=20
@@ -65,7 +65,7 @@ static target_ulong h_ipi(PowerPCCPU *cpu, sPAPRMachine=
State *spapr,
 static target_ulong h_xirr(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
-    uint32_t xirr =3D icp_accept(ICP(cpu->intc));
+    uint32_t xirr =3D icp_accept(cpu->icp);
=20
     args[0] =3D xirr;
     return H_SUCCESS;
@@ -74,7 +74,7 @@ static target_ulong h_xirr(PowerPCCPU *cpu, sPAPRMachin=
eState *spapr,
 static target_ulong h_xirr_x(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                              target_ulong opcode, target_ulong *args)
 {
-    uint32_t xirr =3D icp_accept(ICP(cpu->intc));
+    uint32_t xirr =3D icp_accept(cpu->icp);
=20
     args[0] =3D xirr;
     args[1] =3D cpu_get_host_ticks();
@@ -86,7 +86,7 @@ static target_ulong h_eoi(PowerPCCPU *cpu, sPAPRMachine=
State *spapr,
 {
     target_ulong xirr =3D args[0];
=20
-    icp_eoi(ICP(cpu->intc), xirr);
+    icp_eoi(cpu->icp, xirr);
     return H_SUCCESS;
 }
=20
@@ -94,7 +94,7 @@ static target_ulong h_ipoll(PowerPCCPU *cpu, sPAPRMachi=
neState *spapr,
                             target_ulong opcode, target_ulong *args)
 {
     uint32_t mfrr;
-    uint32_t xirr =3D icp_ipoll(ICP(cpu->intc), &mfrr);
+    uint32_t xirr =3D icp_ipoll(cpu->icp, &mfrr);
=20
     args[0] =3D xirr;
     args[1] =3D mfrr;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 8e83be54fc..d84acef55b 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -681,7 +681,7 @@ static void pnv_chip_power8_intc_create(PnvChip *chip=
, PowerPCCPU *cpu,
         return;
     }
=20
-    cpu->intc =3D obj;
+    cpu->icp =3D ICP(obj);
 }
=20
 /*
@@ -1099,7 +1099,7 @@ static ICPState *pnv_icp_get(XICSFabric *xi, int pi=
r)
 {
     PowerPCCPU *cpu =3D ppc_get_vcpu_by_pir(pir);
=20
-    return cpu ? ICP(cpu->intc) : NULL;
+    return cpu ? cpu->icp : NULL;
 }
=20
 static void pnv_pic_print_info(InterruptStatsProvider *obj,
@@ -1112,7 +1112,7 @@ static void pnv_pic_print_info(InterruptStatsProvid=
er *obj,
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
=20
-        icp_pic_print_info(ICP(cpu->intc), mon);
+        icp_pic_print_info(cpu->icp, mon);
     }
=20
     for (i =3D 0; i < pnv->num_chips; i++) {
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 1202737748..b98f277f1e 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -190,7 +190,7 @@ err:
 static void pnv_unrealize_vcpu(PowerPCCPU *cpu)
 {
     qemu_unregister_reset(pnv_cpu_reset, cpu);
-    object_unparent(cpu->intc);
+    object_unparent(OBJECT(cpu->icp));
     cpu_remove_sync(CPU(cpu));
     object_unparent(OBJECT(cpu));
 }
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 75164ba4fc..8576c1c6f7 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3887,7 +3887,7 @@ static ICPState *spapr_icp_get(XICSFabric *xi, int =
vcpu_id)
 {
     PowerPCCPU *cpu =3D spapr_find_cpu(vcpu_id);
=20
-    return cpu ? ICP(cpu->intc) : NULL;
+    return cpu ? cpu->icp : NULL;
 }
=20
 static void spapr_pic_print_info(InterruptStatsProvider *obj,
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 1473ef8533..0405306d1e 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -194,8 +194,8 @@ static void spapr_unrealize_vcpu(PowerPCCPU *cpu, sPA=
PRCPUCore *sc)
         vmstate_unregister(NULL, &vmstate_spapr_cpu_state, cpu->machine_=
data);
     }
     qemu_unregister_reset(spapr_cpu_reset, cpu);
-    if (cpu->intc) {
-        object_unparent(cpu->intc);
+    if (cpu->icp) {
+        object_unparent(OBJECT(cpu->icp));
     }
     if (cpu->tctx) {
         object_unparent(OBJECT(cpu->tctx));
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 598b91a808..b875065ef8 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -184,7 +184,7 @@ static void spapr_irq_print_info_xics(sPAPRMachineSta=
te *spapr, Monitor *mon)
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
=20
-        icp_pic_print_info(ICP(cpu->intc), mon);
+        icp_pic_print_info(cpu->icp, mon);
     }
=20
     ics_pic_print_info(spapr->ics, mon);
@@ -203,7 +203,7 @@ static void spapr_irq_cpu_intc_create_xics(sPAPRMachi=
neState *spapr,
         return;
     }
=20
-    cpu->intc =3D obj;
+    cpu->icp =3D ICP(obj);
 }
=20
 static int spapr_irq_post_load_xics(sPAPRMachineState *spapr, int versio=
n_id)
@@ -212,7 +212,7 @@ static int spapr_irq_post_load_xics(sPAPRMachineState=
 *spapr, int version_id)
         CPUState *cs;
         CPU_FOREACH(cs) {
             PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-            icp_resend(ICP(cpu->intc));
+            icp_resend(cpu->icp);
         }
     }
     return 0;
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 64e94fd83c..486abaf99b 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1178,6 +1178,7 @@ do {                                            \
 typedef struct PPCVirtualHypervisor PPCVirtualHypervisor;
 typedef struct PPCVirtualHypervisorClass PPCVirtualHypervisorClass;
 typedef struct XiveTCTX XiveTCTX;
+typedef struct ICPState ICPState;
=20
 /**
  * PowerPCCPU:
@@ -1196,7 +1197,7 @@ struct PowerPCCPU {
     int vcpu_id;
     uint32_t compat_pvr;
     PPCVirtualHypervisor *vhyp;
-    Object *intc;
+    ICPState *icp;
     XiveTCTX *tctx;
     void *machine_data;
     int32_t node_id; /* NUMA node this CPU belongs to */
--=20
2.20.1
