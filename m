Received: from eggs.gnu.org ([2001:4830:134:3::10]:46507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk5-00032c-4A
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk2-0006bI-5w
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:53 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:02:55 +1100
Message-Id: <20170112020327.24882-36-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 35/67] ppc: Rewrite ppc_get_compat_smt_threads()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

To continue consolidation of compatibility mode information, this rewrites
the ppc_get_compat_smt_threads() function using the table of compatiblity
modes in target-ppc/compat.c.

It's not a direct replacement, the new ppc_compat_max_threads() function
has simpler semantics - it just returns the number of threads the cpu
model has, taking into account any compatiblity mode it is in.

This no longer takes into account kvmppc_smt_threads() as the previous
version did.  That check wasn't useful because we check in
ppc_cpu_realizefn() that CPUs aren't instantiated with more threads
than kvm allows (or if we didn't things will already be broken and
this won't make it any worse).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/ppc/spapr.c              |  8 ++++----
 target/ppc/compat.c         | 18 ++++++++++++++++++
 target/ppc/cpu.h            |  2 +-
 target/ppc/translate_init.c | 20 --------------------
 4 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index fcaa2a5..70dffcb 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -206,6 +206,7 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
         PowerPCCPU *cpu = POWERPC_CPU(cs);
         DeviceClass *dc = DEVICE_GET_CLASS(cs);
         int index = ppc_get_vcpu_dt_id(cpu);
+        int compat_smt = MIN(smp_threads, ppc_compat_max_threads(cpu));
 
         if ((index % smt) != 0) {
             continue;
@@ -240,8 +241,7 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
             return ret;
         }
 
-        ret = spapr_fixup_cpu_smt_dt(fdt, offset, cpu,
-                                     ppc_get_compat_smt_threads(cpu));
+        ret = spapr_fixup_cpu_smt_dt(fdt, offset, cpu, compat_smt);
         if (ret < 0) {
             return ret;
         }
@@ -407,6 +407,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
     size_t page_sizes_prop_size;
     uint32_t vcpus_per_socket = smp_threads * smp_cores;
     uint32_t pft_size_prop[] = {0, cpu_to_be32(spapr->htab_shift)};
+    int compat_smt = MIN(smp_threads, ppc_compat_max_threads(cpu));
     sPAPRDRConnector *drc;
     sPAPRDRConnectorClass *drck;
     int drc_index;
@@ -494,8 +495,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
 
     _FDT(spapr_fixup_cpu_numa_dt(fdt, offset, cs));
 
-    _FDT(spapr_fixup_cpu_smt_dt(fdt, offset, cpu,
-                                ppc_get_compat_smt_threads(cpu)));
+    _FDT(spapr_fixup_cpu_smt_dt(fdt, offset, cpu, compat_smt));
 }
 
 static void spapr_populate_cpus_dt_node(void *fdt, sPAPRMachineState *spapr)
diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index f3fd9c6..66529a6 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -28,6 +28,7 @@
 typedef struct {
     uint32_t pvr;
     uint64_t pcr;
+    int max_threads;
 } CompatInfo;
 
 static const CompatInfo compat_table[] = {
@@ -35,18 +36,22 @@ static const CompatInfo compat_table[] = {
         .pvr = CPU_POWERPC_LOGICAL_2_05,
         .pcr = PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_COMPAT_2_05
                | PCR_TM_DIS | PCR_VSX_DIS,
+        .max_threads = 2,
     },
     { /* POWER7, ISA2.06 */
         .pvr = CPU_POWERPC_LOGICAL_2_06,
         .pcr = PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_TM_DIS,
+        .max_threads = 4,
     },
     {
         .pvr = CPU_POWERPC_LOGICAL_2_06_PLUS,
         .pcr = PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_TM_DIS,
+        .max_threads = 4,
     },
     { /* POWER8, ISA2.07 */
         .pvr = CPU_POWERPC_LOGICAL_2_07,
         .pcr = PCR_COMPAT_2_07,
+        .max_threads = 8,
     },
 };
 
@@ -89,3 +94,16 @@ void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp)
         }
     }
 }
+
+int ppc_compat_max_threads(PowerPCCPU *cpu)
+{
+    const CompatInfo *compat = compat_by_pvr(cpu->compat_pvr);
+    int n_threads = CPU(cpu)->nr_threads;
+
+    if (cpu->compat_pvr) {
+        g_assert(compat);
+        n_threads = MIN(n_threads, compat->max_threads);
+    }
+
+    return n_threads;
+}
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index c859547..cd76053 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1250,7 +1250,6 @@ void ppc_store_sdr1 (CPUPPCState *env, target_ulong value);
 void ppc_store_msr (CPUPPCState *env, target_ulong value);
 
 void ppc_cpu_list (FILE *f, fprintf_function cpu_fprintf);
-int ppc_get_compat_smt_threads(PowerPCCPU *cpu);
 #if defined(TARGET_PPC64)
 #endif
 
@@ -1325,6 +1324,7 @@ static inline int cpu_mmu_index (CPUPPCState *env, bool ifetch)
 /* Compatibility modes */
 #if defined(TARGET_PPC64)
 void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp);
+int ppc_compat_max_threads(PowerPCCPU *cpu);
 #endif /* defined(TARGET_PPC64) */
 
 #include "exec/cpu-all.h"
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index abdb842..953d27d 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -9952,26 +9952,6 @@ static void ppc_cpu_unrealizefn(DeviceState *dev, Error **errp)
     }
 }
 
-int ppc_get_compat_smt_threads(PowerPCCPU *cpu)
-{
-    CPUState *cs = CPU(cpu);
-    int ret = MIN(cs->nr_threads, kvmppc_smt_threads());
-
-    switch (cpu->compat_pvr) {
-    case CPU_POWERPC_LOGICAL_2_05:
-        ret = MIN(ret, 2);
-        break;
-    case CPU_POWERPC_LOGICAL_2_06:
-        ret = MIN(ret, 4);
-        break;
-    case CPU_POWERPC_LOGICAL_2_07:
-        ret = MIN(ret, 8);
-        break;
-    }
-
-    return ret;
-}
-
 static gint ppc_cpu_compare_class_pvr(gconstpointer a, gconstpointer b)
 {
     ObjectClass *oc = (ObjectClass *)a;
-- 
2.9.3
