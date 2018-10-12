Received: from eggs.gnu.org ([2001:4830:134:3::10]:55301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gAyeM-0007yg-Uk
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 10:42:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gAyeL-0002uf-LB
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 10:42:46 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Oct 2018 15:42:28 +0100
Message-Id: <20181012144235.19646-4-peter.maydell@linaro.org>
In-Reply-To: <20181012144235.19646-1-peter.maydell@linaro.org>
References: <20181012144235.19646-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 03/10] target/arm: Implement HCR.FB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

The HCR.FB virtualization configuration register bit requests that
TLB maintenance, branch predictor invalidate-all and icache
invalidate-all operations performed in NS EL1 should be upgraded
from "local CPU only to "broadcast within Inner Shareable domain".
For QEMU we NOP the branch predictor and icache operations, so
we only need to upgrade the TLB invalidates:
 AArch32 TLBIALL, TLBIMVA, TLBIASID, DTLBIALL, DTLBIMVA, DTLBIASID,
         ITLBIALL, ITLBIMVA, ITLBIASID, TLBIMVAA, TLBIMVAL, TLBIMVAAL
 AArch64 TLBI VMALLE1, TLBI VAE1, TLBI ASIDE1, TLBI VAAE1,
         TLBI VALE1, TLBI VAALE1

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 191 +++++++++++++++++++++++++++-----------------
 1 file changed, 116 insertions(+), 75 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0253a971099..cbec6844a44 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -554,42 +554,6 @@ static void contextidr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     raw_write(env, ri, value);
 }
 
-static void tlbiall_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                          uint64_t value)
-{
-    /* Invalidate all (TLBIALL) */
-    ARMCPU *cpu = arm_env_get_cpu(env);
-
-    tlb_flush(CPU(cpu));
-}
-
-static void tlbimva_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                          uint64_t value)
-{
-    /* Invalidate single TLB entry by MVA and ASID (TLBIMVA) */
-    ARMCPU *cpu = arm_env_get_cpu(env);
-
-    tlb_flush_page(CPU(cpu), value & TARGET_PAGE_MASK);
-}
-
-static void tlbiasid_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                           uint64_t value)
-{
-    /* Invalidate by ASID (TLBIASID) */
-    ARMCPU *cpu = arm_env_get_cpu(env);
-
-    tlb_flush(CPU(cpu));
-}
-
-static void tlbimvaa_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                           uint64_t value)
-{
-    /* Invalidate single entry by MVA, all ASIDs (TLBIMVAA) */
-    ARMCPU *cpu = arm_env_get_cpu(env);
-
-    tlb_flush_page(CPU(cpu), value & TARGET_PAGE_MASK);
-}
-
 /* IS variants of TLB operations must affect all cores */
 static void tlbiall_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t value)
@@ -623,6 +587,73 @@ static void tlbimvaa_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_page_all_cpus_synced(cs, value & TARGET_PAGE_MASK);
 }
 
+/*
+ * Non-IS variants of TLB operations are upgraded to
+ * IS versions if we are at NS EL1 and HCR_EL2.FB is set to
+ * force broadcast of these operations.
+ */
+static bool tlb_force_broadcast(CPUARMState *env)
+{
+    return (env->cp15.hcr_el2 & HCR_FB) &&
+        arm_current_el(env) == 1 && arm_is_secure_below_el3(env);
+}
+
+static void tlbiall_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                          uint64_t value)
+{
+    /* Invalidate all (TLBIALL) */
+    ARMCPU *cpu = arm_env_get_cpu(env);
+
+    if (tlb_force_broadcast(env)) {
+        tlbiall_is_write(env, NULL, value);
+        return;
+    }
+
+    tlb_flush(CPU(cpu));
+}
+
+static void tlbimva_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                          uint64_t value)
+{
+    /* Invalidate single TLB entry by MVA and ASID (TLBIMVA) */
+    ARMCPU *cpu = arm_env_get_cpu(env);
+
+    if (tlb_force_broadcast(env)) {
+        tlbimva_is_write(env, NULL, value);
+        return;
+    }
+
+    tlb_flush_page(CPU(cpu), value & TARGET_PAGE_MASK);
+}
+
+static void tlbiasid_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                           uint64_t value)
+{
+    /* Invalidate by ASID (TLBIASID) */
+    ARMCPU *cpu = arm_env_get_cpu(env);
+
+    if (tlb_force_broadcast(env)) {
+        tlbiasid_is_write(env, NULL, value);
+        return;
+    }
+
+    tlb_flush(CPU(cpu));
+}
+
+static void tlbimvaa_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                           uint64_t value)
+{
+    /* Invalidate single entry by MVA, all ASIDs (TLBIMVAA) */
+    ARMCPU *cpu = arm_env_get_cpu(env);
+
+    if (tlb_force_broadcast(env)) {
+        tlbimvaa_is_write(env, NULL, value);
+        return;
+    }
+
+    tlb_flush_page(CPU(cpu), value & TARGET_PAGE_MASK);
+}
+
 static void tlbiall_nsnh_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                uint64_t value)
 {
@@ -3082,22 +3113,6 @@ static CPAccessResult aa64_cacheop_access(CPUARMState *env,
  * Page D4-1736 (DDI0487A.b)
  */
 
-static void tlbi_aa64_vmalle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                    uint64_t value)
-{
-    CPUState *cs = ENV_GET_CPU(env);
-
-    if (arm_is_secure_below_el3(env)) {
-        tlb_flush_by_mmuidx(cs,
-                            ARMMMUIdxBit_S1SE1 |
-                            ARMMMUIdxBit_S1SE0);
-    } else {
-        tlb_flush_by_mmuidx(cs,
-                            ARMMMUIdxBit_S12NSE1 |
-                            ARMMMUIdxBit_S12NSE0);
-    }
-}
-
 static void tlbi_aa64_vmalle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                       uint64_t value)
 {
@@ -3115,6 +3130,27 @@ static void tlbi_aa64_vmalle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 }
 
+static void tlbi_aa64_vmalle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                    uint64_t value)
+{
+    CPUState *cs = ENV_GET_CPU(env);
+
+    if (tlb_force_broadcast(env)) {
+        tlbi_aa64_vmalle1_write(env, NULL, value);
+        return;
+    }
+
+    if (arm_is_secure_below_el3(env)) {
+        tlb_flush_by_mmuidx(cs,
+                            ARMMMUIdxBit_S1SE1 |
+                            ARMMMUIdxBit_S1SE0);
+    } else {
+        tlb_flush_by_mmuidx(cs,
+                            ARMMMUIdxBit_S12NSE1 |
+                            ARMMMUIdxBit_S12NSE0);
+    }
+}
+
 static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                   uint64_t value)
 {
@@ -3204,29 +3240,6 @@ static void tlbi_aa64_alle3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_S1E3);
 }
 
-static void tlbi_aa64_vae1_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                 uint64_t value)
-{
-    /* Invalidate by VA, EL1&0 (AArch64 version).
-     * Currently handles all of VAE1, VAAE1, VAALE1 and VALE1,
-     * since we don't support flush-for-specific-ASID-only or
-     * flush-last-level-only.
-     */
-    ARMCPU *cpu = arm_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
-    uint64_t pageaddr = sextract64(value << 12, 0, 56);
-
-    if (arm_is_secure_below_el3(env)) {
-        tlb_flush_page_by_mmuidx(cs, pageaddr,
-                                 ARMMMUIdxBit_S1SE1 |
-                                 ARMMMUIdxBit_S1SE0);
-    } else {
-        tlb_flush_page_by_mmuidx(cs, pageaddr,
-                                 ARMMMUIdxBit_S12NSE1 |
-                                 ARMMMUIdxBit_S12NSE0);
-    }
-}
-
 static void tlbi_aa64_vae2_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                  uint64_t value)
 {
@@ -3274,6 +3287,34 @@ static void tlbi_aa64_vae1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 }
 
+static void tlbi_aa64_vae1_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                 uint64_t value)
+{
+    /* Invalidate by VA, EL1&0 (AArch64 version).
+     * Currently handles all of VAE1, VAAE1, VAALE1 and VALE1,
+     * since we don't support flush-for-specific-ASID-only or
+     * flush-last-level-only.
+     */
+    ARMCPU *cpu = arm_env_get_cpu(env);
+    CPUState *cs = CPU(cpu);
+    uint64_t pageaddr = sextract64(value << 12, 0, 56);
+
+    if (tlb_force_broadcast(env)) {
+        tlbi_aa64_vae1is_write(env, NULL, value);
+        return;
+    }
+
+    if (arm_is_secure_below_el3(env)) {
+        tlb_flush_page_by_mmuidx(cs, pageaddr,
+                                 ARMMMUIdxBit_S1SE1 |
+                                 ARMMMUIdxBit_S1SE0);
+    } else {
+        tlb_flush_page_by_mmuidx(cs, pageaddr,
+                                 ARMMMUIdxBit_S12NSE1 |
+                                 ARMMMUIdxBit_S12NSE0);
+    }
+}
+
 static void tlbi_aa64_vae2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                    uint64_t value)
 {
-- 
2.19.0
