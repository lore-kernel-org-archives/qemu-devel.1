Received: from eggs.gnu.org ([2001:4830:134:3::10]:46184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTGh9-0002n6-3H
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:05:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTGh7-0001el-8f
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:04:59 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 14 Jun 2018 11:04:45 +1000
Message-Id: <20180614010446.30854-7-david@gibson.dropbear.id.au>
In-Reply-To: <20180614010446.30854-1-david@gibson.dropbear.id.au>
References: <20180614010446.30854-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv2 6/7] target/ppc: Replace intc pointer with a
 general machine_data pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org
Cc: clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

PowerPCCPU contains an (Object *)intc used to point to the cpu's interrupt
controller.  Or more precisely to the "presentation" component of the
interrupt controller relevant to this cpu.

Really, this field is machine specific.  The machines which use it can
point it to different types of object depending on their needs, and most
machines don't use it at all (since they have older style PICs which don't
have per-cpu presentation components).

There's also other information that's per-cpu, but platform/machine
specific.  So replace the intc pointer with a (void *)machine_data which
can be managed as the machine type likes to conveniently store per cpu
information.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics.c                  |  5 +++--
 hw/intc/xics_spapr.c            | 16 +++++++++++-----
 hw/ppc/pnv.c                    |  4 ++--
 hw/ppc/pnv_core.c               | 11 +++++++++--
 hw/ppc/spapr.c                  |  8 ++++----
 hw/ppc/spapr_cpu_core.c         | 13 ++++++++++---
 include/hw/ppc/pnv_core.h       |  9 +++++++++
 include/hw/ppc/spapr_cpu_core.h | 10 ++++++++++
 include/hw/ppc/xics.h           |  4 ++--
 target/ppc/cpu.h                |  2 +-
 10 files changed, 61 insertions(+), 21 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index e73e623e3b..689ad44e5f 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -383,7 +383,8 @@ static const TypeInfo icp_info = {
     .class_size = sizeof(ICPStateClass),
 };
 
-Object *icp_create(Object *cpu, const char *type, XICSFabric *xi, Error **errp)
+ICPState *icp_create(Object *cpu, const char *type, XICSFabric *xi,
+                     Error **errp)
 {
     Error *local_err = NULL;
     Object *obj;
@@ -401,7 +402,7 @@ Object *icp_create(Object *cpu, const char *type, XICSFabric *xi, Error **errp)
         obj = NULL;
     }
 
-    return obj;
+    return ICP(obj);
 }
 
 /*
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 2e27b92b87..01c76717cf 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -31,6 +31,7 @@
 #include "trace.h"
 #include "qemu/timer.h"
 #include "hw/ppc/spapr.h"
+#include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/xics.h"
 #include "hw/ppc/fdt.h"
 #include "qapi/visitor.h"
@@ -43,8 +44,9 @@ static target_ulong h_cppr(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
     target_ulong cppr = args[0];
+    sPAPRCPUState *spapr_cpu = spapr_cpu_state(cpu);
 
-    icp_set_cppr(ICP(cpu->intc), cppr);
+    icp_set_cppr(spapr_cpu->icp, cppr);
     return H_SUCCESS;
 }
 
@@ -65,7 +67,8 @@ static target_ulong h_ipi(PowerPCCPU *cpu, sPAPRMachineState *spapr,
 static target_ulong h_xirr(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
-    uint32_t xirr = icp_accept(ICP(cpu->intc));
+    sPAPRCPUState *spapr_cpu = spapr_cpu_state(cpu);
+    uint32_t xirr = icp_accept(spapr_cpu->icp);
 
     args[0] = xirr;
     return H_SUCCESS;
@@ -74,7 +77,8 @@ static target_ulong h_xirr(PowerPCCPU *cpu, sPAPRMachineState *spapr,
 static target_ulong h_xirr_x(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                              target_ulong opcode, target_ulong *args)
 {
-    uint32_t xirr = icp_accept(ICP(cpu->intc));
+    sPAPRCPUState *spapr_cpu = spapr_cpu_state(cpu);
+    uint32_t xirr = icp_accept(spapr_cpu->icp);
 
     args[0] = xirr;
     args[1] = cpu_get_host_ticks();
@@ -84,9 +88,10 @@ static target_ulong h_xirr_x(PowerPCCPU *cpu, sPAPRMachineState *spapr,
 static target_ulong h_eoi(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                           target_ulong opcode, target_ulong *args)
 {
+    sPAPRCPUState *spapr_cpu = spapr_cpu_state(cpu);
     target_ulong xirr = args[0];
 
-    icp_eoi(ICP(cpu->intc), xirr);
+    icp_eoi(spapr_cpu->icp, xirr);
     return H_SUCCESS;
 }
 
@@ -94,7 +99,8 @@ static target_ulong h_ipoll(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                             target_ulong opcode, target_ulong *args)
 {
     uint32_t mfrr;
-    uint32_t xirr = icp_ipoll(ICP(cpu->intc), &mfrr);
+    sPAPRCPUState *spapr_cpu = spapr_cpu_state(cpu);
+    uint32_t xirr = icp_ipoll(spapr_cpu->icp, &mfrr);
 
     args[0] = xirr;
     args[1] = mfrr;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 0b9508d94d..3a36c6ac6a 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1013,7 +1013,7 @@ static ICPState *pnv_icp_get(XICSFabric *xi, int pir)
 {
     PowerPCCPU *cpu = ppc_get_vcpu_by_pir(pir);
 
-    return cpu ? ICP(cpu->intc) : NULL;
+    return cpu ? pnv_cpu_state(cpu)->icp : NULL;
 }
 
 static void pnv_pic_print_info(InterruptStatsProvider *obj,
@@ -1026,7 +1026,7 @@ static void pnv_pic_print_info(InterruptStatsProvider *obj,
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu = POWERPC_CPU(cs);
 
-        icp_pic_print_info(ICP(cpu->intc), mon);
+        icp_pic_print_info(pnv_cpu_state(cpu)->icp, mon);
     }
 
     for (i = 0; i < pnv->num_chips; i++) {
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index f7cf33f547..746bc5c2c5 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -105,6 +105,7 @@ static void pnv_realize_vcpu(PowerPCCPU *cpu, XICSFabric *xi, Error **errp)
     int core_pir;
     int thread_index = 0; /* TODO: TCG supports only one thread */
     ppc_spr_t *pir = &env->spr_cb[SPR_PIR];
+    PnvCPUState *pnv_cpu;
     Error *local_err = NULL;
 
     object_property_set_bool(OBJECT(cpu), true, "realized", &local_err);
@@ -113,7 +114,9 @@ static void pnv_realize_vcpu(PowerPCCPU *cpu, XICSFabric *xi, Error **errp)
         return;
     }
 
-    cpu->intc = icp_create(OBJECT(cpu), TYPE_PNV_ICP, xi, &local_err);
+    cpu->machine_data = pnv_cpu = g_new0(PnvCPUState, 1);
+
+    pnv_cpu->icp = icp_create(OBJECT(cpu), TYPE_PNV_ICP, xi, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -188,8 +191,12 @@ err:
 
 static void pnv_unrealize_vcpu(PowerPCCPU *cpu)
 {
+    PnvCPUState *pnv_cpu = pnv_cpu_state(cpu);
+
     qemu_unregister_reset(pnv_cpu_reset, cpu);
-    object_unparent(cpu->intc);
+    object_unparent(OBJECT(pnv_cpu->icp));
+    cpu->machine_data = NULL;
+    g_free(pnv_cpu);
     cpu_remove_sync(CPU(cpu));
     object_unparent(OBJECT(cpu));
 }
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f59999daac..cbab6b6b7e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1745,8 +1745,8 @@ static int spapr_post_load(void *opaque, int version_id)
     if (!object_dynamic_cast(OBJECT(spapr->ics), TYPE_ICS_KVM)) {
         CPUState *cs;
         CPU_FOREACH(cs) {
-            PowerPCCPU *cpu = POWERPC_CPU(cs);
-            icp_resend(ICP(cpu->intc));
+            sPAPRCPUState *spapr_cpu = spapr_cpu_state(POWERPC_CPU(cs));
+            icp_resend(spapr_cpu->icp);
         }
     }
 
@@ -3783,7 +3783,7 @@ static ICPState *spapr_icp_get(XICSFabric *xi, int vcpu_id)
 {
     PowerPCCPU *cpu = spapr_find_cpu(vcpu_id);
 
-    return cpu ? ICP(cpu->intc) : NULL;
+    return cpu ? spapr_cpu_state(cpu)->icp : NULL;
 }
 
 #define ICS_IRQ_FREE(ics, srcno)   \
@@ -3925,7 +3925,7 @@ static void spapr_pic_print_info(InterruptStatsProvider *obj,
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu = POWERPC_CPU(cs);
 
-        icp_pic_print_info(ICP(cpu->intc), mon);
+        icp_pic_print_info(spapr_cpu_state(cpu)->icp, mon);
     }
 
     ics_pic_print_info(spapr->ics, mon);
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 7fdb3b6667..544bda93e2 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -104,8 +104,12 @@ const char *spapr_get_cpu_core_type(const char *cpu_type)
 
 static void spapr_unrealize_vcpu(PowerPCCPU *cpu)
 {
+    sPAPRCPUState *spapr_cpu = spapr_cpu_state(cpu);
+
     qemu_unregister_reset(spapr_cpu_reset, cpu);
-    object_unparent(cpu->intc);
+    object_unparent(OBJECT(spapr_cpu->icp));
+    cpu->machine_data = NULL;
+    g_free(spapr_cpu);
     cpu_remove_sync(CPU(cpu));
     object_unparent(OBJECT(cpu));
 }
@@ -127,12 +131,15 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, sPAPRMachineState *spapr,
 {
     CPUPPCState *env = &cpu->env;
     Error *local_err = NULL;
+    sPAPRCPUState *spapr_cpu;
 
     object_property_set_bool(OBJECT(cpu), true, "realized", &local_err);
     if (local_err) {
         goto error;
     }
 
+    spapr_cpu = cpu->machine_data = g_new0(sPAPRCPUState, 1);
+
     /* Set time-base frequency to 512 MHz */
     cpu_ppc_tb_init(env, SPAPR_TIMEBASE_FREQ);
 
@@ -142,8 +149,8 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, sPAPRMachineState *spapr,
     qemu_register_reset(spapr_cpu_reset, cpu);
     spapr_cpu_reset(cpu);
 
-    cpu->intc = icp_create(OBJECT(cpu), spapr->icp_type, XICS_FABRIC(spapr),
-                           &local_err);
+    spapr_cpu->icp = icp_create(OBJECT(cpu), spapr->icp_type,
+                                XICS_FABRIC(spapr), &local_err);
     if (local_err) {
         goto error;
     }
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index 447ae761f7..f81dff28aa 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -47,4 +47,13 @@ typedef struct PnvCoreClass {
 #define PNV_CORE_TYPE_SUFFIX "-" TYPE_PNV_CORE
 #define PNV_CORE_TYPE_NAME(cpu_model) cpu_model PNV_CORE_TYPE_SUFFIX
 
+typedef struct PnvCPUState {
+    ICPState *icp;
+} PnvCPUState;
+
+static inline PnvCPUState *pnv_cpu_state(PowerPCCPU *cpu)
+{
+    return cpu->machine_data;
+}
+
 #endif /* _PPC_PNV_CORE_H */
diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
index 47dcfda12b..e3d2aa45a4 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -41,4 +41,14 @@ typedef struct sPAPRCPUCoreClass {
 const char *spapr_get_cpu_core_type(const char *cpu_type);
 void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target_ulong r3);
 
+typedef struct ICPState ICPState;
+typedef struct sPAPRCPUState {
+    ICPState *icp;
+} sPAPRCPUState;
+
+static inline sPAPRCPUState *spapr_cpu_state(PowerPCCPU *cpu)
+{
+    return (sPAPRCPUState *)cpu->machine_data;
+}
+
 #endif
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 6cebff47a7..48930d91e5 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -207,7 +207,7 @@ typedef struct sPAPRMachineState sPAPRMachineState;
 int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
 void xics_spapr_init(sPAPRMachineState *spapr);
 
-Object *icp_create(Object *cpu, const char *type, XICSFabric *xi,
-                   Error **errp);
+ICPState *icp_create(Object *cpu, const char *type, XICSFabric *xi,
+                     Error **errp);
 
 #endif /* XICS_H */
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index a91f1a8777..abf0bf0224 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1204,7 +1204,7 @@ struct PowerPCCPU {
     int vcpu_id;
     uint32_t compat_pvr;
     PPCVirtualHypervisor *vhyp;
-    Object *intc;
+    void *machine_data;
     int32_t node_id; /* NUMA node this CPU belongs to */
     PPCHash64Options *hash64_opts;
 
-- 
2.17.1
