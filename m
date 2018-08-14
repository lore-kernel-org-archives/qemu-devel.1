Received: from eggs.gnu.org ([2001:4830:134:3::10]:52810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdvl-000587-Mp
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:22:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpduH-0006oz-7L
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:20:33 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fpduG-0006nb-Hc
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:19:00 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fpduE-0007Mv-BM
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:18:58 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 19:18:06 +0100
Message-Id: <20180814181815.23348-37-peter.maydell@linaro.org>
In-Reply-To: <20180814181815.23348-1-peter.maydell@linaro.org>
References: <20180814181815.23348-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 36/45] target/arm: Provide accessor functions
 for HCR_EL2.{IMO, FMO, AMO}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The IMO, FMO and AMO bits in HCR_EL2 are defined to "behave as
1 for all purposes other than direct reads" if HCR_EL2.TGE
is set and HCR_EL2.E2H is 0, and to "behave as 0 for all
purposes other than direct reads" if HCR_EL2.TGE is set
and HRC_EL2.E2H is 1.

To avoid having to check E2H and TGE everywhere where we test IMO and
FMO, provide accessors arm_hcr_el2_imo(), arm_hcr_el2_fmo()and
arm_hcr_el2_amo().  We don't implement ARMv8.1-VHE yet, so the E2H
case will never be true, but we include the logic to save effort when
we eventually do get to that.

(Note that in several of these callsites the change doesn't
actually make a difference as either the callsite is handling
TGE specially anyway, or the CPU can't get into that situation
with TGE set; we change everywhere for consistency.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180724115950.17316-5-peter.maydell@linaro.org
---
 target/arm/cpu.h          | 64 +++++++++++++++++++++++++++++++++++----
 hw/intc/arm_gicv3_cpuif.c | 19 ++++++------
 target/arm/helper.c       |  6 ++--
 3 files changed, 71 insertions(+), 18 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index efb2a8d3f3d..4289c33ef4c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1229,6 +1229,12 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define HCR_RW        (1ULL << 31)
 #define HCR_CD        (1ULL << 32)
 #define HCR_ID        (1ULL << 33)
+#define HCR_E2H       (1ULL << 34)
+/*
+ * When we actually implement ARMv8.1-VHE we should add HCR_E2H to
+ * HCR_MASK and then clear it again if the feature bit is not set in
+ * hcr_write().
+ */
 #define HCR_MASK      ((1ULL << 34) - 1)
 
 #define SCR_NS                (1U << 0)
@@ -2234,6 +2240,54 @@ bool write_cpustate_to_list(ARMCPU *cpu);
 #  define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 
+/**
+ * arm_hcr_el2_imo(): Return the effective value of HCR_EL2.IMO.
+ * Depending on the values of HCR_EL2.E2H and TGE, this may be
+ * "behaves as 1 for all purposes other than direct read/write" or
+ * "behaves as 0 for all purposes other than direct read/write"
+ */
+static inline bool arm_hcr_el2_imo(CPUARMState *env)
+{
+    switch (env->cp15.hcr_el2 & (HCR_TGE | HCR_E2H)) {
+    case HCR_TGE:
+        return true;
+    case HCR_TGE | HCR_E2H:
+        return false;
+    default:
+        return env->cp15.hcr_el2 & HCR_IMO;
+    }
+}
+
+/**
+ * arm_hcr_el2_fmo(): Return the effective value of HCR_EL2.FMO.
+ */
+static inline bool arm_hcr_el2_fmo(CPUARMState *env)
+{
+    switch (env->cp15.hcr_el2 & (HCR_TGE | HCR_E2H)) {
+    case HCR_TGE:
+        return true;
+    case HCR_TGE | HCR_E2H:
+        return false;
+    default:
+        return env->cp15.hcr_el2 & HCR_FMO;
+    }
+}
+
+/**
+ * arm_hcr_el2_amo(): Return the effective value of HCR_EL2.AMO.
+ */
+static inline bool arm_hcr_el2_amo(CPUARMState *env)
+{
+    switch (env->cp15.hcr_el2 & (HCR_TGE | HCR_E2H)) {
+    case HCR_TGE:
+        return true;
+    case HCR_TGE | HCR_E2H:
+        return false;
+    default:
+        return env->cp15.hcr_el2 & HCR_AMO;
+    }
+}
+
 static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
                                      unsigned int target_el)
 {
@@ -2261,15 +2315,13 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
         break;
 
     case EXCP_VFIQ:
-        if (secure || !(env->cp15.hcr_el2 & HCR_FMO)
-            || (env->cp15.hcr_el2 & HCR_TGE)) {
+        if (secure || !arm_hcr_el2_fmo(env) || (env->cp15.hcr_el2 & HCR_TGE)) {
             /* VFIQs are only taken when hypervized and non-secure.  */
             return false;
         }
         return !(env->daif & PSTATE_F);
     case EXCP_VIRQ:
-        if (secure || !(env->cp15.hcr_el2 & HCR_IMO)
-            || (env->cp15.hcr_el2 & HCR_TGE)) {
+        if (secure || !arm_hcr_el2_imo(env) || (env->cp15.hcr_el2 & HCR_TGE)) {
             /* VIRQs are only taken when hypervized and non-secure.  */
             return false;
         }
@@ -2308,7 +2360,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
                  * to the CPSR.F setting otherwise we further assess the state
                  * below.
                  */
-                hcr = (env->cp15.hcr_el2 & HCR_FMO);
+                hcr = arm_hcr_el2_fmo(env);
                 scr = (env->cp15.scr_el3 & SCR_FIQ);
 
                 /* When EL3 is 32-bit, the SCR.FW bit controls whether the
@@ -2325,7 +2377,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
                  * when setting the target EL, so it does not have a further
                  * affect here.
                  */
-                hcr = (env->cp15.hcr_el2 & HCR_IMO);
+                hcr = arm_hcr_el2_imo(env);
                 scr = false;
                 break;
             default:
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 2a60568d82c..068a8e8e9b9 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -85,7 +85,10 @@ static bool icv_access(CPUARMState *env, int hcr_flags)
      *  * access if NS EL1 and either IMO or FMO == 1:
      *    CTLR, DIR, PMR, RPR
      */
-    return (env->cp15.hcr_el2 & hcr_flags) && arm_current_el(env) == 1
+    bool flagmatch = ((hcr_flags & HCR_IMO) && arm_hcr_el2_imo(env)) ||
+        ((hcr_flags & HCR_FMO) && arm_hcr_el2_fmo(env));
+
+    return flagmatch && arm_current_el(env) == 1
         && !arm_is_secure_below_el3(env);
 }
 
@@ -1549,8 +1552,8 @@ static void icc_dir_write(CPUARMState *env, const ARMCPRegInfo *ri,
     /* No need to include !IsSecure in route_*_to_el2 as it's only
      * tested in cases where we know !IsSecure is true.
      */
-    route_fiq_to_el2 = env->cp15.hcr_el2 & HCR_FMO;
-    route_irq_to_el2 = env->cp15.hcr_el2 & HCR_IMO;
+    route_fiq_to_el2 = arm_hcr_el2_fmo(env);
+    route_irq_to_el2 = arm_hcr_el2_imo(env);
 
     switch (arm_current_el(env)) {
     case 3:
@@ -1893,7 +1896,7 @@ static CPAccessResult gicv3_irqfiq_access(CPUARMState *env,
         switch (el) {
         case 1:
             if (arm_is_secure_below_el3(env) ||
-                ((env->cp15.hcr_el2 & (HCR_IMO | HCR_FMO)) == 0)) {
+                (arm_hcr_el2_imo(env) == 0 && arm_hcr_el2_fmo(env) == 0)) {
                 r = CP_ACCESS_TRAP_EL3;
             }
             break;
@@ -1933,7 +1936,7 @@ static CPAccessResult gicv3_dir_access(CPUARMState *env,
 static CPAccessResult gicv3_sgi_access(CPUARMState *env,
                                        const ARMCPRegInfo *ri, bool isread)
 {
-    if ((env->cp15.hcr_el2 & (HCR_IMO | HCR_FMO)) &&
+    if ((arm_hcr_el2_imo(env) || arm_hcr_el2_fmo(env)) &&
         arm_current_el(env) == 1 && !arm_is_secure_below_el3(env)) {
         /* Takes priority over a possible EL3 trap */
         return CP_ACCESS_TRAP_EL2;
@@ -1958,8 +1961,7 @@ static CPAccessResult gicv3_fiq_access(CPUARMState *env,
     if (env->cp15.scr_el3 & SCR_FIQ) {
         switch (el) {
         case 1:
-            if (arm_is_secure_below_el3(env) ||
-                ((env->cp15.hcr_el2 & HCR_FMO) == 0)) {
+            if (arm_is_secure_below_el3(env) || !arm_hcr_el2_fmo(env)) {
                 r = CP_ACCESS_TRAP_EL3;
             }
             break;
@@ -1998,8 +2000,7 @@ static CPAccessResult gicv3_irq_access(CPUARMState *env,
     if (env->cp15.scr_el3 & SCR_IRQ) {
         switch (el) {
         case 1:
-            if (arm_is_secure_below_el3(env) ||
-                ((env->cp15.hcr_el2 & HCR_IMO) == 0)) {
+            if (arm_is_secure_below_el3(env) || !arm_hcr_el2_imo(env)) {
                 r = CP_ACCESS_TRAP_EL3;
             }
             break;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3cd43cf7018..7b438e43a90 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6336,15 +6336,15 @@ uint32_t arm_phys_excp_target_el(CPUState *cs, uint32_t excp_idx,
     switch (excp_idx) {
     case EXCP_IRQ:
         scr = ((env->cp15.scr_el3 & SCR_IRQ) == SCR_IRQ);
-        hcr = ((env->cp15.hcr_el2 & HCR_IMO) == HCR_IMO);
+        hcr = arm_hcr_el2_imo(env);
         break;
     case EXCP_FIQ:
         scr = ((env->cp15.scr_el3 & SCR_FIQ) == SCR_FIQ);
-        hcr = ((env->cp15.hcr_el2 & HCR_FMO) == HCR_FMO);
+        hcr = arm_hcr_el2_fmo(env);
         break;
     default:
         scr = ((env->cp15.scr_el3 & SCR_EA) == SCR_EA);
-        hcr = ((env->cp15.hcr_el2 & HCR_AMO) == HCR_AMO);
+        hcr = arm_hcr_el2_amo(env);
         break;
     };
 
-- 
2.18.0
