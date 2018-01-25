Received: from eggs.gnu.org ([2001:4830:134:3::10]:33622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eehod-0003CA-OQ
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eehoc-00035x-5g
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:43 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eehob-00035J-QS
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:42 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eehoa-0006tu-Iy
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 13:43:40 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2018 13:43:19 +0000
Message-Id: <1516887809-6265-12-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1516887809-6265-1-git-send-email-peter.maydell@linaro.org>
References: <1516887809-6265-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 11/21] target/arm: Move cpu_get_tb_cpu_state out
 of line
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180119045438.28582-14-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    | 127 +---------------------------------------------------
 target/arm/helper.c | 126 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+), 125 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 6f6e885..d2bb59e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2667,71 +2667,6 @@ static inline bool bswap_code(bool sctlr_b)
 #endif
 }
 
-/* Return the exception level to which FP-disabled exceptions should
- * be taken, or 0 if FP is enabled.
- */
-static inline int fp_exception_el(CPUARMState *env)
-{
-    int fpen;
-    int cur_el = arm_current_el(env);
-
-    /* CPACR and the CPTR registers don't exist before v6, so FP is
-     * always accessible
-     */
-    if (!arm_feature(env, ARM_FEATURE_V6)) {
-        return 0;
-    }
-
-    /* The CPACR controls traps to EL1, or PL1 if we're 32 bit:
-     * 0, 2 : trap EL0 and EL1/PL1 accesses
-     * 1    : trap only EL0 accesses
-     * 3    : trap no accesses
-     */
-    fpen = extract32(env->cp15.cpacr_el1, 20, 2);
-    switch (fpen) {
-    case 0:
-    case 2:
-        if (cur_el == 0 || cur_el == 1) {
-            /* Trap to PL1, which might be EL1 or EL3 */
-            if (arm_is_secure(env) && !arm_el_is_aa64(env, 3)) {
-                return 3;
-            }
-            return 1;
-        }
-        if (cur_el == 3 && !is_a64(env)) {
-            /* Secure PL1 running at EL3 */
-            return 3;
-        }
-        break;
-    case 1:
-        if (cur_el == 0) {
-            return 1;
-        }
-        break;
-    case 3:
-        break;
-    }
-
-    /* For the CPTR registers we don't need to guard with an ARM_FEATURE
-     * check because zero bits in the registers mean "don't trap".
-     */
-
-    /* CPTR_EL2 : present in v7VE or v8 */
-    if (cur_el <= 2 && extract32(env->cp15.cptr_el[2], 10, 1)
-        && !arm_is_secure_below_el3(env)) {
-        /* Trap FP ops at EL2, NS-EL1 or NS-EL0 to EL2 */
-        return 2;
-    }
-
-    /* CPTR_EL3 : present in v8 */
-    if (extract32(env->cp15.cptr_el[3], 10, 1)) {
-        /* Trap all FP ops to EL3 */
-        return 3;
-    }
-
-    return 0;
-}
-
 #ifdef CONFIG_USER_ONLY
 static inline bool arm_cpu_bswap_data(CPUARMState *env)
 {
@@ -2778,66 +2713,8 @@ static inline uint32_t arm_regime_tbi1(CPUARMState *env, ARMMMUIdx mmu_idx)
 }
 #endif
 
-static inline void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
-                                        target_ulong *cs_base, uint32_t *flags)
-{
-    ARMMMUIdx mmu_idx = core_to_arm_mmu_idx(env, cpu_mmu_index(env, false));
-    if (is_a64(env)) {
-        *pc = env->pc;
-        *flags = ARM_TBFLAG_AARCH64_STATE_MASK;
-        /* Get control bits for tagged addresses */
-        *flags |= (arm_regime_tbi0(env, mmu_idx) << ARM_TBFLAG_TBI0_SHIFT);
-        *flags |= (arm_regime_tbi1(env, mmu_idx) << ARM_TBFLAG_TBI1_SHIFT);
-    } else {
-        *pc = env->regs[15];
-        *flags = (env->thumb << ARM_TBFLAG_THUMB_SHIFT)
-            | (env->vfp.vec_len << ARM_TBFLAG_VECLEN_SHIFT)
-            | (env->vfp.vec_stride << ARM_TBFLAG_VECSTRIDE_SHIFT)
-            | (env->condexec_bits << ARM_TBFLAG_CONDEXEC_SHIFT)
-            | (arm_sctlr_b(env) << ARM_TBFLAG_SCTLR_B_SHIFT);
-        if (!(access_secure_reg(env))) {
-            *flags |= ARM_TBFLAG_NS_MASK;
-        }
-        if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)
-            || arm_el_is_aa64(env, 1)) {
-            *flags |= ARM_TBFLAG_VFPEN_MASK;
-        }
-        *flags |= (extract32(env->cp15.c15_cpar, 0, 2)
-                   << ARM_TBFLAG_XSCALE_CPAR_SHIFT);
-    }
-
-    *flags |= (arm_to_core_mmu_idx(mmu_idx) << ARM_TBFLAG_MMUIDX_SHIFT);
-
-    /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
-     * states defined in the ARM ARM for software singlestep:
-     *  SS_ACTIVE   PSTATE.SS   State
-     *     0            x       Inactive (the TB flag for SS is always 0)
-     *     1            0       Active-pending
-     *     1            1       Active-not-pending
-     */
-    if (arm_singlestep_active(env)) {
-        *flags |= ARM_TBFLAG_SS_ACTIVE_MASK;
-        if (is_a64(env)) {
-            if (env->pstate & PSTATE_SS) {
-                *flags |= ARM_TBFLAG_PSTATE_SS_MASK;
-            }
-        } else {
-            if (env->uncached_cpsr & PSTATE_SS) {
-                *flags |= ARM_TBFLAG_PSTATE_SS_MASK;
-            }
-        }
-    }
-    if (arm_cpu_data_is_big_endian(env)) {
-        *flags |= ARM_TBFLAG_BE_DATA_MASK;
-    }
-    *flags |= fp_exception_el(env) << ARM_TBFLAG_FPEXC_EL_SHIFT;
-
-    if (arm_v7m_is_handler_mode(env)) {
-        *flags |= ARM_TBFLAG_HANDLER_MASK;
-    }
-
-    *cs_base = 0;
-}
+void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
+                          target_ulong *cs_base, uint32_t *flags);
 
 enum {
     QEMU_PSCI_CONDUIT_DISABLED = 0,
diff --git a/target/arm/helper.c b/target/arm/helper.c
index a41b6c3..1e64bb9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11621,3 +11621,129 @@ uint32_t HELPER(crc32c)(uint32_t acc, uint32_t val, uint32_t bytes)
     /* Linux crc32c converts the output to one's complement.  */
     return crc32c(acc, buf, bytes) ^ 0xffffffff;
 }
+
+/* Return the exception level to which FP-disabled exceptions should
+ * be taken, or 0 if FP is enabled.
+ */
+static inline int fp_exception_el(CPUARMState *env)
+{
+    int fpen;
+    int cur_el = arm_current_el(env);
+
+    /* CPACR and the CPTR registers don't exist before v6, so FP is
+     * always accessible
+     */
+    if (!arm_feature(env, ARM_FEATURE_V6)) {
+        return 0;
+    }
+
+    /* The CPACR controls traps to EL1, or PL1 if we're 32 bit:
+     * 0, 2 : trap EL0 and EL1/PL1 accesses
+     * 1    : trap only EL0 accesses
+     * 3    : trap no accesses
+     */
+    fpen = extract32(env->cp15.cpacr_el1, 20, 2);
+    switch (fpen) {
+    case 0:
+    case 2:
+        if (cur_el == 0 || cur_el == 1) {
+            /* Trap to PL1, which might be EL1 or EL3 */
+            if (arm_is_secure(env) && !arm_el_is_aa64(env, 3)) {
+                return 3;
+            }
+            return 1;
+        }
+        if (cur_el == 3 && !is_a64(env)) {
+            /* Secure PL1 running at EL3 */
+            return 3;
+        }
+        break;
+    case 1:
+        if (cur_el == 0) {
+            return 1;
+        }
+        break;
+    case 3:
+        break;
+    }
+
+    /* For the CPTR registers we don't need to guard with an ARM_FEATURE
+     * check because zero bits in the registers mean "don't trap".
+     */
+
+    /* CPTR_EL2 : present in v7VE or v8 */
+    if (cur_el <= 2 && extract32(env->cp15.cptr_el[2], 10, 1)
+        && !arm_is_secure_below_el3(env)) {
+        /* Trap FP ops at EL2, NS-EL1 or NS-EL0 to EL2 */
+        return 2;
+    }
+
+    /* CPTR_EL3 : present in v8 */
+    if (extract32(env->cp15.cptr_el[3], 10, 1)) {
+        /* Trap all FP ops to EL3 */
+        return 3;
+    }
+
+    return 0;
+}
+
+void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
+                          target_ulong *cs_base, uint32_t *flags)
+{
+    ARMMMUIdx mmu_idx = core_to_arm_mmu_idx(env, cpu_mmu_index(env, false));
+    if (is_a64(env)) {
+        *pc = env->pc;
+        *flags = ARM_TBFLAG_AARCH64_STATE_MASK;
+        /* Get control bits for tagged addresses */
+        *flags |= (arm_regime_tbi0(env, mmu_idx) << ARM_TBFLAG_TBI0_SHIFT);
+        *flags |= (arm_regime_tbi1(env, mmu_idx) << ARM_TBFLAG_TBI1_SHIFT);
+    } else {
+        *pc = env->regs[15];
+        *flags = (env->thumb << ARM_TBFLAG_THUMB_SHIFT)
+            | (env->vfp.vec_len << ARM_TBFLAG_VECLEN_SHIFT)
+            | (env->vfp.vec_stride << ARM_TBFLAG_VECSTRIDE_SHIFT)
+            | (env->condexec_bits << ARM_TBFLAG_CONDEXEC_SHIFT)
+            | (arm_sctlr_b(env) << ARM_TBFLAG_SCTLR_B_SHIFT);
+        if (!(access_secure_reg(env))) {
+            *flags |= ARM_TBFLAG_NS_MASK;
+        }
+        if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)
+            || arm_el_is_aa64(env, 1)) {
+            *flags |= ARM_TBFLAG_VFPEN_MASK;
+        }
+        *flags |= (extract32(env->cp15.c15_cpar, 0, 2)
+                   << ARM_TBFLAG_XSCALE_CPAR_SHIFT);
+    }
+
+    *flags |= (arm_to_core_mmu_idx(mmu_idx) << ARM_TBFLAG_MMUIDX_SHIFT);
+
+    /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
+     * states defined in the ARM ARM for software singlestep:
+     *  SS_ACTIVE   PSTATE.SS   State
+     *     0            x       Inactive (the TB flag for SS is always 0)
+     *     1            0       Active-pending
+     *     1            1       Active-not-pending
+     */
+    if (arm_singlestep_active(env)) {
+        *flags |= ARM_TBFLAG_SS_ACTIVE_MASK;
+        if (is_a64(env)) {
+            if (env->pstate & PSTATE_SS) {
+                *flags |= ARM_TBFLAG_PSTATE_SS_MASK;
+            }
+        } else {
+            if (env->uncached_cpsr & PSTATE_SS) {
+                *flags |= ARM_TBFLAG_PSTATE_SS_MASK;
+            }
+        }
+    }
+    if (arm_cpu_data_is_big_endian(env)) {
+        *flags |= ARM_TBFLAG_BE_DATA_MASK;
+    }
+    *flags |= fp_exception_el(env) << ARM_TBFLAG_FPEXC_EL_SHIFT;
+
+    if (arm_v7m_is_handler_mode(env)) {
+        *flags |= ARM_TBFLAG_HANDLER_MASK;
+    }
+
+    *cs_base = 0;
+}
-- 
2.7.4
