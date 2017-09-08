Received: from eggs.gnu.org ([2001:4830:134:3::10]:58905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGeF-0002HG-5R
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe6-0003Mn-K8
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:31 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  8 Sep 2017 20:35:58 +1000
Message-Id: <20170908103558.31632-41-david@gibson.dropbear.id.au>
In-Reply-To: <20170908103558.31632-1-david@gibson.dropbear.id.au>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 40/40] ppc: spapr: Move VCPU ID calculation into
 sPAPR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, sam.bobroff@au1.ibm.com, imammedo@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Sam Bobroff <sam.bobroff@au1.ibm.com>

Move the calculation of a CPU's VCPU ID out of the generic PPC code
(ppc_cpu_realizefn()) and into sPAPR specific code
(spapr_cpu_core_realize()) where it belongs.

Unfortunately, due to the way things are ordered, we still need to
default the VCPU ID in ppc_cpu_realizfn() but at least doing that
doesn't require any interaction with sPAPR.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c     | 11 +++++++++++
 target/ppc/translate_init.c | 18 +++---------------
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 92bec033b3..85037ef71e 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -213,6 +213,7 @@ error:
 
 static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
 {
+    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
     sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
     sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
     CPUCore *cc = CPU_CORE(OBJECT(dev));
@@ -239,6 +240,16 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
         cs = CPU(obj);
         cpu = POWERPC_CPU(cs);
         cs->cpu_index = cc->core_id + i;
+        cpu->vcpu_id = (cc->core_id * spapr->vsmt / smp_threads) + i;
+        if (kvm_enabled() && !kvm_vcpu_id_is_valid(cpu->vcpu_id)) {
+            error_setg(&local_err, "Can't create CPU with id %d in KVM",
+                       cpu->vcpu_id);
+            error_append_hint(&local_err, "Adjust the number of cpus to %d "
+                              "or try to raise the number of threads per core\n",
+                              cpu->vcpu_id * smp_threads / spapr->vsmt);
+            goto err;
+        }
+
 
         /* Set NUMA node for the threads belonged to core  */
         cpu->node_id = sc->node_id;
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 3e24cddb86..c827d1e388 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -9904,28 +9904,15 @@ static void ppc_cpu_realizefn(DeviceState *dev, Error **errp)
     PowerPCCPU *cpu = POWERPC_CPU(dev);
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     Error *local_err = NULL;
-#if !defined(CONFIG_USER_ONLY)
-    int max_smt = kvmppc_smt_threads();
-#endif
 
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
     }
-
-#if !defined(CONFIG_USER_ONLY)
-    cpu->vcpu_id = (cs->cpu_index / smp_threads) * max_smt
-        + (cs->cpu_index % smp_threads);
-
-    if (kvm_enabled() && !kvm_vcpu_id_is_valid(cpu->vcpu_id)) {
-        error_setg(errp, "Can't create CPU with id %d in KVM", cpu->vcpu_id);
-        error_append_hint(errp, "Adjust the number of cpus to %d "
-                          "or try to raise the number of threads per core\n",
-                          cpu->vcpu_id * smp_threads / max_smt);
-        goto unrealize;
+    if (cpu->vcpu_id == UNASSIGNED_CPU_INDEX) {
+        cpu->vcpu_id = cs->cpu_index;
     }
-#endif
 
     if (tcg_enabled()) {
         if (ppc_fixup_cpu(cpu) != 0) {
@@ -10576,6 +10563,7 @@ static void ppc_cpu_initfn(Object *obj)
     CPUPPCState *env = &cpu->env;
 
     cs->env_ptr = env;
+    cpu->vcpu_id = UNASSIGNED_CPU_INDEX;
 
     env->msr_mask = pcc->msr_mask;
     env->mmu_model = pcc->mmu_model;
-- 
2.13.5
