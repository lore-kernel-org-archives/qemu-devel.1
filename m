Received: from eggs.gnu.org ([2001:4830:134:3::10]:36216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSOj-0004fc-Et
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSOg-0007u2-3P
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:33 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gXSOf-0007J5-Lb
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:29 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSOH-0007NV-2N
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 14:55:05 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 14:54:43 +0000
Message-Id: <20181213145445.17935-36-peter.maydell@linaro.org>
In-Reply-To: <20181213145445.17935-1-peter.maydell@linaro.org>
References: <20181213145445.17935-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 35/37] target/arm: Introduce arm_hcr_el2_eff
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Replace arm_hcr_el2_{fmo,imo,amo} with a more general routine
that also takes SCR_EL3.NS (aka arm_is_secure_below_el3) into
account, as documented for the plethora of bits in HCR_EL2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181210150501.7990-2-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h          | 67 +++++++++------------------------------
 hw/intc/arm_gicv3_cpuif.c | 21 ++++++------
 target/arm/helper.c       | 66 ++++++++++++++++++++++++++++++++------
 3 files changed, 83 insertions(+), 71 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 11ec2cce767..05ac883b6be 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1729,6 +1729,14 @@ static inline bool arm_is_secure(CPUARMState *env)
 }
 #endif
 
+/**
+ * arm_hcr_el2_eff(): Return the effective value of HCR_EL2.
+ * E.g. when in secure state, fields in HCR_EL2 are suppressed,
+ * "for all purposes other than a direct read or write access of HCR_EL2."
+ * Not included here is HCR_RW.
+ */
+uint64_t arm_hcr_el2_eff(CPUARMState *env);
+
 /* Return true if the specified exception level is running in AArch64 state. */
 static inline bool arm_el_is_aa64(CPUARMState *env, int el)
 {
@@ -2414,54 +2422,6 @@ bool write_cpustate_to_list(ARMCPU *cpu);
 #  define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 
-/**
- * arm_hcr_el2_imo(): Return the effective value of HCR_EL2.IMO.
- * Depending on the values of HCR_EL2.E2H and TGE, this may be
- * "behaves as 1 for all purposes other than direct read/write" or
- * "behaves as 0 for all purposes other than direct read/write"
- */
-static inline bool arm_hcr_el2_imo(CPUARMState *env)
-{
-    switch (env->cp15.hcr_el2 & (HCR_TGE | HCR_E2H)) {
-    case HCR_TGE:
-        return true;
-    case HCR_TGE | HCR_E2H:
-        return false;
-    default:
-        return env->cp15.hcr_el2 & HCR_IMO;
-    }
-}
-
-/**
- * arm_hcr_el2_fmo(): Return the effective value of HCR_EL2.FMO.
- */
-static inline bool arm_hcr_el2_fmo(CPUARMState *env)
-{
-    switch (env->cp15.hcr_el2 & (HCR_TGE | HCR_E2H)) {
-    case HCR_TGE:
-        return true;
-    case HCR_TGE | HCR_E2H:
-        return false;
-    default:
-        return env->cp15.hcr_el2 & HCR_FMO;
-    }
-}
-
-/**
- * arm_hcr_el2_amo(): Return the effective value of HCR_EL2.AMO.
- */
-static inline bool arm_hcr_el2_amo(CPUARMState *env)
-{
-    switch (env->cp15.hcr_el2 & (HCR_TGE | HCR_E2H)) {
-    case HCR_TGE:
-        return true;
-    case HCR_TGE | HCR_E2H:
-        return false;
-    default:
-        return env->cp15.hcr_el2 & HCR_AMO;
-    }
-}
-
 static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
                                      unsigned int target_el)
 {
@@ -2470,6 +2430,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
     bool secure = arm_is_secure(env);
     bool pstate_unmasked;
     int8_t unmasked = 0;
+    uint64_t hcr_el2;
 
     /* Don't take exceptions if they target a lower EL.
      * This check should catch any exceptions that would not be taken but left
@@ -2479,6 +2440,8 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
         return false;
     }
 
+    hcr_el2 = arm_hcr_el2_eff(env);
+
     switch (excp_idx) {
     case EXCP_FIQ:
         pstate_unmasked = !(env->daif & PSTATE_F);
@@ -2489,13 +2452,13 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
         break;
 
     case EXCP_VFIQ:
-        if (secure || !arm_hcr_el2_fmo(env) || (env->cp15.hcr_el2 & HCR_TGE)) {
+        if (secure || !(hcr_el2 & HCR_FMO) || (hcr_el2 & HCR_TGE)) {
             /* VFIQs are only taken when hypervized and non-secure.  */
             return false;
         }
         return !(env->daif & PSTATE_F);
     case EXCP_VIRQ:
-        if (secure || !arm_hcr_el2_imo(env) || (env->cp15.hcr_el2 & HCR_TGE)) {
+        if (secure || !(hcr_el2 & HCR_IMO) || (hcr_el2 & HCR_TGE)) {
             /* VIRQs are only taken when hypervized and non-secure.  */
             return false;
         }
@@ -2534,7 +2497,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
                  * to the CPSR.F setting otherwise we further assess the state
                  * below.
                  */
-                hcr = arm_hcr_el2_fmo(env);
+                hcr = hcr_el2 & HCR_FMO;
                 scr = (env->cp15.scr_el3 & SCR_FIQ);
 
                 /* When EL3 is 32-bit, the SCR.FW bit controls whether the
@@ -2551,7 +2514,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
                  * when setting the target EL, so it does not have a further
                  * affect here.
                  */
-                hcr = arm_hcr_el2_imo(env);
+                hcr = hcr_el2 & HCR_IMO;
                 scr = false;
                 break;
             default:
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 068a8e8e9b9..cbad6037f19 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -85,8 +85,8 @@ static bool icv_access(CPUARMState *env, int hcr_flags)
      *  * access if NS EL1 and either IMO or FMO == 1:
      *    CTLR, DIR, PMR, RPR
      */
-    bool flagmatch = ((hcr_flags & HCR_IMO) && arm_hcr_el2_imo(env)) ||
-        ((hcr_flags & HCR_FMO) && arm_hcr_el2_fmo(env));
+    uint64_t hcr_el2 = arm_hcr_el2_eff(env);
+    bool flagmatch = hcr_el2 & hcr_flags & (HCR_IMO | HCR_FMO);
 
     return flagmatch && arm_current_el(env) == 1
         && !arm_is_secure_below_el3(env);
@@ -1552,8 +1552,9 @@ static void icc_dir_write(CPUARMState *env, const ARMCPRegInfo *ri,
     /* No need to include !IsSecure in route_*_to_el2 as it's only
      * tested in cases where we know !IsSecure is true.
      */
-    route_fiq_to_el2 = arm_hcr_el2_fmo(env);
-    route_irq_to_el2 = arm_hcr_el2_imo(env);
+    uint64_t hcr_el2 = arm_hcr_el2_eff(env);
+    route_fiq_to_el2 = hcr_el2 & HCR_FMO;
+    route_irq_to_el2 = hcr_el2 & HCR_IMO;
 
     switch (arm_current_el(env)) {
     case 3:
@@ -1895,8 +1896,8 @@ static CPAccessResult gicv3_irqfiq_access(CPUARMState *env,
     if ((env->cp15.scr_el3 & (SCR_FIQ | SCR_IRQ)) == (SCR_FIQ | SCR_IRQ)) {
         switch (el) {
         case 1:
-            if (arm_is_secure_below_el3(env) ||
-                (arm_hcr_el2_imo(env) == 0 && arm_hcr_el2_fmo(env) == 0)) {
+            /* Note that arm_hcr_el2_eff takes secure state into account.  */
+            if ((arm_hcr_el2_eff(env) & (HCR_IMO | HCR_FMO)) == 0) {
                 r = CP_ACCESS_TRAP_EL3;
             }
             break;
@@ -1936,8 +1937,8 @@ static CPAccessResult gicv3_dir_access(CPUARMState *env,
 static CPAccessResult gicv3_sgi_access(CPUARMState *env,
                                        const ARMCPRegInfo *ri, bool isread)
 {
-    if ((arm_hcr_el2_imo(env) || arm_hcr_el2_fmo(env)) &&
-        arm_current_el(env) == 1 && !arm_is_secure_below_el3(env)) {
+    if (arm_current_el(env) == 1 &&
+        (arm_hcr_el2_eff(env) & (HCR_IMO | HCR_FMO)) != 0) {
         /* Takes priority over a possible EL3 trap */
         return CP_ACCESS_TRAP_EL2;
     }
@@ -1961,7 +1962,7 @@ static CPAccessResult gicv3_fiq_access(CPUARMState *env,
     if (env->cp15.scr_el3 & SCR_FIQ) {
         switch (el) {
         case 1:
-            if (arm_is_secure_below_el3(env) || !arm_hcr_el2_fmo(env)) {
+            if ((arm_hcr_el2_eff(env) & HCR_FMO) == 0) {
                 r = CP_ACCESS_TRAP_EL3;
             }
             break;
@@ -2000,7 +2001,7 @@ static CPAccessResult gicv3_irq_access(CPUARMState *env,
     if (env->cp15.scr_el3 & SCR_IRQ) {
         switch (el) {
         case 1:
-            if (arm_is_secure_below_el3(env) || !arm_hcr_el2_imo(env)) {
+            if ((arm_hcr_el2_eff(env) & HCR_IMO) == 0) {
                 r = CP_ACCESS_TRAP_EL3;
             }
             break;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 037cece1334..95d59e07fb9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1331,9 +1331,10 @@ static void csselr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static uint64_t isr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     CPUState *cs = ENV_GET_CPU(env);
+    uint64_t hcr_el2 = arm_hcr_el2_eff(env);
     uint64_t ret = 0;
 
-    if (arm_hcr_el2_imo(env)) {
+    if (hcr_el2 & HCR_IMO) {
         if (cs->interrupt_request & CPU_INTERRUPT_VIRQ) {
             ret |= CPSR_I;
         }
@@ -1343,7 +1344,7 @@ static uint64_t isr_read(CPUARMState *env, const ARMCPRegInfo *ri)
         }
     }
 
-    if (arm_hcr_el2_fmo(env)) {
+    if (hcr_el2 & HCR_FMO) {
         if (cs->interrupt_request & CPU_INTERRUPT_VFIQ) {
             ret |= CPSR_F;
         }
@@ -4008,6 +4009,51 @@ static void hcr_writelow(CPUARMState *env, const ARMCPRegInfo *ri,
     hcr_write(env, NULL, value);
 }
 
+/*
+ * Return the effective value of HCR_EL2.
+ * Bits that are not included here:
+ * RW       (read from SCR_EL3.RW as needed)
+ */
+uint64_t arm_hcr_el2_eff(CPUARMState *env)
+{
+    uint64_t ret = env->cp15.hcr_el2;
+
+    if (arm_is_secure_below_el3(env)) {
+        /*
+         * "This register has no effect if EL2 is not enabled in the
+         * current Security state".  This is ARMv8.4-SecEL2 speak for
+         * !(SCR_EL3.NS==1 || SCR_EL3.EEL2==1).
+         *
+         * Prior to that, the language was "In an implementation that
+         * includes EL3, when the value of SCR_EL3.NS is 0 the PE behaves
+         * as if this field is 0 for all purposes other than a direct
+         * read or write access of HCR_EL2".  With lots of enumeration
+         * on a per-field basis.  In current QEMU, this is condition
+         * is arm_is_secure_below_el3.
+         *
+         * Since the v8.4 language applies to the entire register, and
+         * appears to be backward compatible, use that.
+         */
+        ret = 0;
+    } else if (ret & HCR_TGE) {
+        /* These bits are up-to-date as of ARMv8.4.  */
+        if (ret & HCR_E2H) {
+            ret &= ~(HCR_VM | HCR_FMO | HCR_IMO | HCR_AMO |
+                     HCR_BSU_MASK | HCR_DC | HCR_TWI | HCR_TWE |
+                     HCR_TID0 | HCR_TID2 | HCR_TPCP | HCR_TPU |
+                     HCR_TDZ | HCR_CD | HCR_ID | HCR_MIOCNCE);
+        } else {
+            ret |= HCR_FMO | HCR_IMO | HCR_AMO;
+        }
+        ret &= ~(HCR_SWIO | HCR_PTW | HCR_VF | HCR_VI | HCR_VSE |
+                 HCR_FB | HCR_TID1 | HCR_TID3 | HCR_TSC | HCR_TACR |
+                 HCR_TSW | HCR_TTLB | HCR_TVM | HCR_HCD | HCR_TRVM |
+                 HCR_TLOR);
+    }
+
+    return ret;
+}
+
 static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "HCR_EL2", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_IO,
@@ -6526,12 +6572,13 @@ uint32_t arm_phys_excp_target_el(CPUState *cs, uint32_t excp_idx,
                                  uint32_t cur_el, bool secure)
 {
     CPUARMState *env = cs->env_ptr;
-    int rw;
-    int scr;
-    int hcr;
+    bool rw;
+    bool scr;
+    bool hcr;
     int target_el;
     /* Is the highest EL AArch64? */
-    int is64 = arm_feature(env, ARM_FEATURE_AARCH64);
+    bool is64 = arm_feature(env, ARM_FEATURE_AARCH64);
+    uint64_t hcr_el2;
 
     if (arm_feature(env, ARM_FEATURE_EL3)) {
         rw = ((env->cp15.scr_el3 & SCR_RW) == SCR_RW);
@@ -6543,18 +6590,19 @@ uint32_t arm_phys_excp_target_el(CPUState *cs, uint32_t excp_idx,
         rw = is64;
     }
 
+    hcr_el2 = arm_hcr_el2_eff(env);
     switch (excp_idx) {
     case EXCP_IRQ:
         scr = ((env->cp15.scr_el3 & SCR_IRQ) == SCR_IRQ);
-        hcr = arm_hcr_el2_imo(env);
+        hcr = hcr_el2 & HCR_IMO;
         break;
     case EXCP_FIQ:
         scr = ((env->cp15.scr_el3 & SCR_FIQ) == SCR_FIQ);
-        hcr = arm_hcr_el2_fmo(env);
+        hcr = hcr_el2 & HCR_FMO;
         break;
     default:
         scr = ((env->cp15.scr_el3 & SCR_EA) == SCR_EA);
-        hcr = arm_hcr_el2_amo(env);
+        hcr = hcr_el2 & HCR_AMO;
         break;
     };
 
-- 
2.19.2
