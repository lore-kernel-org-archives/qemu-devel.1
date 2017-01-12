Received: from eggs.gnu.org ([2001:4830:134:3::10]:47219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUkJ-0003Ji-C1
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:04:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUkF-0006r0-TW
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:04:07 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:03:21 +1100
Message-Id: <20170112020327.24882-62-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 61/67] pseries: Rewrite CAS PVR compatibility
 logic
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

During boot, PAPR guests negotiate CPU model support with the
ibm,client-architecture-support mechanism.  The logic to implement this in
qemu is very convoluted.  This cleans it up to be cleaner, using the new
ppc_check_compat() call.

The new logic for choosing a compatibility mode is:
    1. Usually, use the most recent compatibility mode that is
            a) supported by the guest
            b) supported by the CPU
        and c) no later than the maximum allowed (if specified)
    2. If no suitable compatibility mode was found, the guest *does*
       support this CPU explicitly, and no maximum compatibility mode is
       specified, then use "raw" mode for the current CPU
    3. Otherwise, fail the boot.

This differs from the results of the old code: the old code preferred using
"raw" mode to a compatibility mode, whereas the new code prefers a
compatibility mode if available.  Using compatibility mode preferentially
means that we're more likely to be able to migrate the guest to a similar
but not identical host.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_hcall.c | 104 ++++++++++++++++-----------------------------------
 hw/ppc/trace-events  |   2 +-
 2 files changed, 34 insertions(+), 72 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index fd9f1d4..43a1fef 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -935,98 +935,60 @@ static void do_set_compat(CPUState *cs, run_on_cpu_data arg)
     ppc_set_compat(cpu, s->compat_pvr, &s->err);
 }
 
-#define get_compat_level(cpuver) ( \
-    ((cpuver) == CPU_POWERPC_LOGICAL_2_05) ? 2050 : \
-    ((cpuver) == CPU_POWERPC_LOGICAL_2_06) ? 2060 : \
-    ((cpuver) == CPU_POWERPC_LOGICAL_2_06_PLUS) ? 2061 : \
-    ((cpuver) == CPU_POWERPC_LOGICAL_2_07) ? 2070 : 0)
-
-static void cas_handle_compat_cpu(PowerPCCPUClass *pcc, uint32_t pvr,
-                                  unsigned max_lvl, unsigned *compat_lvl,
-                                  unsigned *compat_pvr)
-{
-    unsigned lvl = get_compat_level(pvr);
-    bool is205, is206, is207;
-
-    if (!lvl) {
-        return;
-    }
-
-    /* If it is a logical PVR, try to determine the highest level */
-    is205 = (pcc->pcr_supported & PCR_COMPAT_2_05) &&
-            (lvl == get_compat_level(CPU_POWERPC_LOGICAL_2_05));
-    is206 = (pcc->pcr_supported & PCR_COMPAT_2_06) &&
-            ((lvl == get_compat_level(CPU_POWERPC_LOGICAL_2_06)) ||
-             (lvl == get_compat_level(CPU_POWERPC_LOGICAL_2_06_PLUS)));
-    is207 = (pcc->pcr_supported & PCR_COMPAT_2_07) &&
-            (lvl == get_compat_level(CPU_POWERPC_LOGICAL_2_07));
-
-    if (is205 || is206 || is207) {
-        if (!max_lvl) {
-            /* User did not set the level, choose the highest */
-            if (*compat_lvl <= lvl) {
-                *compat_lvl = lvl;
-                *compat_pvr = pvr;
-            }
-        } else if (max_lvl >= lvl) {
-            /* User chose the level, don't set higher than this */
-            *compat_lvl = lvl;
-            *compat_pvr = pvr;
-        }
-    }
-}
-
-static target_ulong h_client_architecture_support(PowerPCCPU *cpu_,
+static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
                                                   sPAPRMachineState *spapr,
                                                   target_ulong opcode,
                                                   target_ulong *args)
 {
     target_ulong list = ppc64_phys_to_real(args[0]);
     target_ulong ov_table;
-    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu_);
     CPUState *cs;
-    bool cpu_match = false;
-    unsigned old_compat_pvr = cpu_->compat_pvr;
-    unsigned compat_lvl = 0, compat_pvr = 0;
-    unsigned max_lvl = get_compat_level(cpu_->max_compat);
-    int counter;
+    bool explicit_match = false; /* Matched the CPU's real PVR */
+    uint32_t max_compat = cpu->max_compat;
+    uint32_t best_compat = 0;
+    int i;
     sPAPROptionVector *ov5_guest, *ov5_cas_old, *ov5_updates;
 
-    /* Parse PVR list */
-    for (counter = 0; counter < 512; ++counter) {
+    /*
+     * We scan the supplied table of PVRs looking for two things
+     *   1. Is our real CPU PVR in the list?
+     *   2. What's the "best" listed logical PVR
+     */
+    for (i = 0; i < 512; ++i) {
         uint32_t pvr, pvr_mask;
 
         pvr_mask = ldl_be_phys(&address_space_memory, list);
-        list += 4;
-        pvr = ldl_be_phys(&address_space_memory, list);
-        list += 4;
-
-        trace_spapr_cas_pvr_try(pvr);
-        if (!max_lvl &&
-            ((cpu_->env.spr[SPR_PVR] & pvr_mask) == (pvr & pvr_mask))) {
-            cpu_match = true;
-            compat_pvr = 0;
-        } else if (pvr == cpu_->compat_pvr) {
-            cpu_match = true;
-            compat_pvr = cpu_->compat_pvr;
-        } else if (!cpu_match) {
-            cas_handle_compat_cpu(pcc, pvr, max_lvl, &compat_lvl, &compat_pvr);
-        }
-        /* Terminator record */
+        pvr = ldl_be_phys(&address_space_memory, list + 4);
+        list += 8;
+
         if (~pvr_mask & pvr) {
-            break;
+            break; /* Terminator record */
         }
+
+        if ((cpu->env.spr[SPR_PVR] & pvr_mask) == (pvr & pvr_mask)) {
+            explicit_match = true;
+        } else {
+            if (ppc_check_compat(cpu, pvr, best_compat, max_compat)) {
+                best_compat = pvr;
+            }
+        }
+    }
+
+    if ((best_compat == 0) && (!explicit_match || max_compat)) {
+        /* We couldn't find a suitable compatibility mode, and either
+         * the guest doesn't support "raw" mode for this CPU, or raw
+         * mode is disabled because a maximum compat mode is set */
+        return H_HARDWARE;
     }
 
     /* Parsing finished */
-    trace_spapr_cas_pvr(cpu_->compat_pvr, cpu_match,
-                        compat_pvr, pcc->pcr_mask);
+    trace_spapr_cas_pvr(cpu->compat_pvr, explicit_match, best_compat);
 
     /* Update CPUs */
-    if (old_compat_pvr != compat_pvr) {
+    if (cpu->compat_pvr != best_compat) {
         CPU_FOREACH(cs) {
             SetCompatState s = {
-                .compat_pvr = compat_pvr,
+                .compat_pvr = best_compat,
                 .err = NULL,
             };
 
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index 42b8ec0..f46995c 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -15,7 +15,7 @@ spapr_cas_continue(unsigned long n) "Copy changes to the guest: %ld bytes"
 
 # hw/ppc/spapr_hcall.c
 spapr_cas_pvr_try(uint32_t pvr) "%x"
-spapr_cas_pvr(uint32_t cur_pvr, bool cpu_match, uint32_t new_pvr, uint64_t pcr) "current=%x, cpu_match=%u, new=%x, compat flags=%"PRIx64
+spapr_cas_pvr(uint32_t cur_pvr, bool explicit_match, uint32_t new_pvr) "current=%x, explicit_match=%u, new=%x"
 
 # hw/ppc/spapr_iommu.c
 spapr_iommu_put(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t ret) "liobn=%"PRIx64" ioba=0x%"PRIx64" tce=0x%"PRIx64" ret=%"PRId64
-- 
2.9.3
