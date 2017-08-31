Received: from eggs.gnu.org ([2001:4830:134:3::10]:51132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1dnJ8z-00051d-6X
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 02:40:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1dnJ8s-0004UX-Rn
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 02:40:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1dnJ8s-0004Tw-IK
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 02:39:54 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7V6doxD106582
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 02:39:52 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cpc4g5bs3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 02:39:50 -0400
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Thu, 31 Aug 2017 16:38:51 +1000
Date: Thu, 31 Aug 2017 16:38:46 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-Id: <747daf1a700a5340eeeedd9d98188bf89f75bb85.1504161284.git.sam.bobroff@au1.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] ppc: spapr: Move VCPU ID calculation into
 sPAPR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au

Move the calculation of a CPU's VCPU ID out of the generic PPC code
(ppc_cpu_realizefn()) and into sPAPR specific code
(spapr_cpu_core_realize()) where it belongs.

Unfortunately, due to the way things are ordered, we still need to
default the VCPU ID in ppc_cpu_realizfn() but at least doing that
doesn't require any interaction with sPAPR.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
This is follow up work arising from my work to clean up the way CPU VCPU IDs are
handled on PowerPC. It had looked like it would be difficult to move the actual
VCPU ID calculation out of generic code but it turned out to be OK.

It's based on dgibson/ppc-for-2.11.

Cheers,
Sam.

 hw/ppc/spapr_cpu_core.c     | 11 +++++++++++
 target/ppc/translate_init.c | 18 +++---------------
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 5e319d9bbb..84dcc6e264 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -211,6 +211,7 @@ error:
 
 static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
 {
+    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
     sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
     sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
     CPUCore *cc = CPU_CORE(OBJECT(dev));
@@ -237,6 +238,16 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
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
index 7f6a349e43..1f7286c893 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -9903,28 +9903,15 @@ static void ppc_cpu_realizefn(DeviceState *dev, Error **errp)
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
@@ -10625,6 +10612,7 @@ static void ppc_cpu_initfn(Object *obj)
     CPUPPCState *env = &cpu->env;
 
     cs->env_ptr = env;
+    cpu->vcpu_id = UNASSIGNED_CPU_INDEX;
 
     env->msr_mask = pcc->msr_mask;
     env->mmu_model = pcc->mmu_model;
-- 
2.14.1.4.g334a7be4f
