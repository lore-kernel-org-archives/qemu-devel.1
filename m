Received: from eggs.gnu.org ([2001:4830:134:3::10]:34130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSziY-0002vM-Be
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 02:57:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSziX-0006Ws-BW
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 02:57:18 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 13 Jun 2018 16:57:04 +1000
Message-Id: <20180613065707.30766-5-david@gibson.dropbear.id.au>
In-Reply-To: <20180613065707.30766-1-david@gibson.dropbear.id.au>
References: <20180613065707.30766-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 4/7] pnv: Clean up cpu realize path
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

pnv_cpu_init() is only called from the the pnv cpu core realize path, and
really only can be called from there.  So fold it into its caller, which
we also rename for brevity.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_core.c | 56 ++++++++++++++++++-----------------------------
 1 file changed, 21 insertions(+), 35 deletions(-)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 59309e149c..c9648fd1ad 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -54,28 +54,6 @@ static void pnv_cpu_reset(void *opaque)
     env->msr |= MSR_HVB; /* Hypervisor mode */
 }
 
-static void pnv_cpu_init(PowerPCCPU *cpu, Error **errp)
-{
-    CPUPPCState *env = &cpu->env;
-    int core_pir;
-    int thread_index = 0; /* TODO: TCG supports only one thread */
-    ppc_spr_t *pir = &env->spr_cb[SPR_PIR];
-
-    core_pir = object_property_get_uint(OBJECT(cpu), "core-pir", &error_abort);
-
-    /*
-     * The PIR of a thread is the core PIR + the thread index. We will
-     * need to find a way to get the thread index when TCG supports
-     * more than 1. We could use the object name ?
-     */
-    pir->default_value = core_pir + thread_index;
-
-    /* Set time-base frequency to 512 MHz */
-    cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
-
-    qemu_register_reset(pnv_cpu_reset, cpu);
-}
-
 /*
  * These values are read by the PowerNV HW monitors under Linux
  */
@@ -121,29 +99,39 @@ static const MemoryRegionOps pnv_core_xscom_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-static void pnv_core_realize_child(Object *child, XICSFabric *xi, Error **errp)
+static void pnv_realize_vcpu(PowerPCCPU *cpu, XICSFabric *xi, Error **errp)
 {
+    CPUPPCState *env = &cpu->env;
+    int core_pir;
+    int thread_index = 0; /* TODO: TCG supports only one thread */
+    ppc_spr_t *pir = &env->spr_cb[SPR_PIR];
     Error *local_err = NULL;
-    CPUState *cs = CPU(child);
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
 
-    object_property_set_bool(child, true, "realized", &local_err);
+    object_property_set_bool(OBJECT(cpu), true, "realized", &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
 
-    cpu->intc = icp_create(child, TYPE_PNV_ICP, xi, &local_err);
+    cpu->intc = icp_create(OBJECT(cpu), TYPE_PNV_ICP, xi, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
 
-    pnv_cpu_init(cpu, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
+    core_pir = object_property_get_uint(OBJECT(cpu), "core-pir", &error_abort);
+
+    /*
+     * The PIR of a thread is the core PIR + the thread index. We will
+     * need to find a way to get the thread index when TCG supports
+     * more than 1. We could use the object name ?
+     */
+    pir->default_value = core_pir + thread_index;
+
+    /* Set time-base frequency to 512 MHz */
+    cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
+
+    qemu_register_reset(pnv_cpu_reset, cpu);
 }
 
 static void pnv_core_realize(DeviceState *dev, Error **errp)
@@ -184,9 +172,7 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
     }
 
     for (j = 0; j < cc->nr_threads; j++) {
-        obj = OBJECT(pc->threads[j]);
-
-        pnv_core_realize_child(obj, XICS_FABRIC(xi), &local_err);
+        pnv_realize_vcpu(pc->threads[j], XICS_FABRIC(xi), &local_err);
         if (local_err) {
             goto err;
         }
-- 
2.17.1
