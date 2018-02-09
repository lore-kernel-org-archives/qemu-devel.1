Received: from eggs.gnu.org ([2001:4830:134:3::10]:39922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6Sv-00016A-IQ
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6Su-000258-DE
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:37 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46266)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ek6Su-000219-5d
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:36 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6Ss-0002eP-VE
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:03:34 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Feb 2018 11:03:11 +0000
Message-Id: <20180209110314.11766-28-peter.maydell@linaro.org>
In-Reply-To: <20180209110314.11766-1-peter.maydell@linaro.org>
References: <20180209110314.11766-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 27/30] target/arm: Add SVE state to TB->FLAGS
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

Add both SVE exception state and vector length.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180123035349.24538-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h           |  8 ++++++++
 target/arm/translate.h     |  2 ++
 target/arm/helper.c        | 25 ++++++++++++++++++++++++-
 target/arm/translate-a64.c |  2 ++
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1b2ff0f3ce..521444a5a1 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2678,6 +2678,10 @@ static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
 #define ARM_TBFLAG_TBI0_MASK (0x1ull << ARM_TBFLAG_TBI0_SHIFT)
 #define ARM_TBFLAG_TBI1_SHIFT 1        /* TBI1 for EL0/1  */
 #define ARM_TBFLAG_TBI1_MASK (0x1ull << ARM_TBFLAG_TBI1_SHIFT)
+#define ARM_TBFLAG_SVEEXC_EL_SHIFT  2
+#define ARM_TBFLAG_SVEEXC_EL_MASK   (0x3 << ARM_TBFLAG_SVEEXC_EL_SHIFT)
+#define ARM_TBFLAG_ZCR_LEN_SHIFT    4
+#define ARM_TBFLAG_ZCR_LEN_MASK     (0xf << ARM_TBFLAG_ZCR_LEN_SHIFT)
 
 /* some convenience accessor macros */
 #define ARM_TBFLAG_AARCH64_STATE(F) \
@@ -2714,6 +2718,10 @@ static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
     (((F) & ARM_TBFLAG_TBI0_MASK) >> ARM_TBFLAG_TBI0_SHIFT)
 #define ARM_TBFLAG_TBI1(F) \
     (((F) & ARM_TBFLAG_TBI1_MASK) >> ARM_TBFLAG_TBI1_SHIFT)
+#define ARM_TBFLAG_SVEEXC_EL(F) \
+    (((F) & ARM_TBFLAG_SVEEXC_EL_MASK) >> ARM_TBFLAG_SVEEXC_EL_SHIFT)
+#define ARM_TBFLAG_ZCR_LEN(F) \
+    (((F) & ARM_TBFLAG_ZCR_LEN_MASK) >> ARM_TBFLAG_ZCR_LEN_SHIFT)
 
 static inline bool bswap_code(bool sctlr_b)
 {
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 3f4df91e5e..c47febf99d 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -29,6 +29,8 @@ typedef struct DisasContext {
     bool tbi1;         /* TBI1 for EL0/1, not used for EL2/3 */
     bool ns;        /* Use non-secure CPREG bank on access */
     int fp_excp_el; /* FP exception EL or 0 if enabled */
+    int sve_excp_el; /* SVE exception EL or 0 if enabled */
+    int sve_len;     /* SVE vector length in bytes */
     /* Flag indicating that exceptions from secure mode are routed to EL3. */
     bool secure_routed_to_el3;
     bool vfp_enabled; /* FP enabled via FPSCR.EN */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 673c476455..180ab75458 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12059,14 +12059,37 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                           target_ulong *cs_base, uint32_t *pflags)
 {
     ARMMMUIdx mmu_idx = core_to_arm_mmu_idx(env, cpu_mmu_index(env, false));
+    int fp_el = fp_exception_el(env);
     uint32_t flags;
 
     if (is_a64(env)) {
+        int sve_el = sve_exception_el(env);
+        uint32_t zcr_len;
+
         *pc = env->pc;
         flags = ARM_TBFLAG_AARCH64_STATE_MASK;
         /* Get control bits for tagged addresses */
         flags |= (arm_regime_tbi0(env, mmu_idx) << ARM_TBFLAG_TBI0_SHIFT);
         flags |= (arm_regime_tbi1(env, mmu_idx) << ARM_TBFLAG_TBI1_SHIFT);
+        flags |= sve_el << ARM_TBFLAG_SVEEXC_EL_SHIFT;
+
+        /* If SVE is disabled, but FP is enabled,
+           then the effective len is 0.  */
+        if (sve_el != 0 && fp_el == 0) {
+            zcr_len = 0;
+        } else {
+            int current_el = arm_current_el(env);
+
+            zcr_len = env->vfp.zcr_el[current_el <= 1 ? 1 : current_el];
+            zcr_len &= 0xf;
+            if (current_el < 2 && arm_feature(env, ARM_FEATURE_EL2)) {
+                zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[2]);
+            }
+            if (current_el < 3 && arm_feature(env, ARM_FEATURE_EL3)) {
+                zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[3]);
+            }
+        }
+        flags |= zcr_len << ARM_TBFLAG_ZCR_LEN_SHIFT;
     } else {
         *pc = env->regs[15];
         flags = (env->thumb << ARM_TBFLAG_THUMB_SHIFT)
@@ -12109,7 +12132,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
     if (arm_cpu_data_is_big_endian(env)) {
         flags |= ARM_TBFLAG_BE_DATA_MASK;
     }
-    flags |= fp_exception_el(env) << ARM_TBFLAG_FPEXC_EL_SHIFT;
+    flags |= fp_el << ARM_TBFLAG_FPEXC_EL_SHIFT;
 
     if (arm_v7m_is_handler_mode(env)) {
         flags |= ARM_TBFLAG_HANDLER_MASK;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 352a79bad1..fb1a4cb532 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -12058,6 +12058,8 @@ static int aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->user = (dc->current_el == 0);
 #endif
     dc->fp_excp_el = ARM_TBFLAG_FPEXC_EL(dc->base.tb->flags);
+    dc->sve_excp_el = ARM_TBFLAG_SVEEXC_EL(dc->base.tb->flags);
+    dc->sve_len = (ARM_TBFLAG_ZCR_LEN(dc->base.tb->flags) + 1) * 16;
     dc->vec_len = 0;
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
-- 
2.16.1
