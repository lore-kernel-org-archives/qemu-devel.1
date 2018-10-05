Received: from eggs.gnu.org ([2001:4830:134:3::10]:35434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8UIf-00012n-1B
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 13:54:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8UId-0003Ei-Ne
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 13:54:04 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:43534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g8UId-0003EK-H9
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 13:54:03 -0400
Received: by mail-ot1-x32d.google.com with SMTP id e21-v6so13516481otk.10
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 10:54:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  5 Oct 2018 12:53:39 -0500
Message-Id: <20181005175350.30752-5-richard.henderson@linaro.org>
In-Reply-To: <20181005175350.30752-1-richard.henderson@linaro.org>
References: <20181005175350.30752-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 04/15] target/arm: Handle SVE vector length
 changes in system mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

SVE vector length can change when changing EL, or when writing
to one of the ZCR_ELn registers.

For correctness, our implementation requires that predicate bits
that are inaccessible are never set.  Which means noticing length
changes and zeroing the appropriate register bits.

Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h       |   4 ++
 target/arm/cpu64.c     |  42 -------------
 target/arm/helper.c    | 133 +++++++++++++++++++++++++++++++++++++----
 target/arm/op_helper.c |   1 +
 4 files changed, 125 insertions(+), 55 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 65c0fa0a65..a4ee83dc77 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -910,6 +910,10 @@ int arm_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
 int aarch64_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int aarch64_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
+void aarch64_sve_change_el(CPUARMState *env, int old_el, int new_el);
+#else
+static inline void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq) { }
+static inline void aarch64_sve_change_el(CPUARMState *env, int o, int n) { }
 #endif
 
 target_ulong do_arm_semihosting(CPUARMState *env);
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 800bff780e..db71504cb5 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -410,45 +410,3 @@ static void aarch64_cpu_register_types(void)
 }
 
 type_init(aarch64_cpu_register_types)
-
-/* The manual says that when SVE is enabled and VQ is widened the
- * implementation is allowed to zero the previously inaccessible
- * portion of the registers.  The corollary to that is that when
- * SVE is enabled and VQ is narrowed we are also allowed to zero
- * the now inaccessible portion of the registers.
- *
- * The intent of this is that no predicate bit beyond VQ is ever set.
- * Which means that some operations on predicate registers themselves
- * may operate on full uint64_t or even unrolled across the maximum
- * uint64_t[4].  Performing 4 bits of host arithmetic unconditionally
- * may well be cheaper than conditionals to restrict the operation
- * to the relevant portion of a uint16_t[16].
- *
- * TODO: Need to call this for changes to the real system registers
- * and EL state changes.
- */
-void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq)
-{
-    int i, j;
-    uint64_t pmask;
-
-    assert(vq >= 1 && vq <= ARM_MAX_VQ);
-    assert(vq <= arm_env_get_cpu(env)->sve_max_vq);
-
-    /* Zap the high bits of the zregs.  */
-    for (i = 0; i < 32; i++) {
-        memset(&env->vfp.zregs[i].d[2 * vq], 0, 16 * (ARM_MAX_VQ - vq));
-    }
-
-    /* Zap the high bits of the pregs and ffr.  */
-    pmask = 0;
-    if (vq & 3) {
-        pmask = ~(-1ULL << (16 * (vq & 3)));
-    }
-    for (j = vq / 4; j < ARM_MAX_VQ / 4; j++) {
-        for (i = 0; i < 17; ++i) {
-            env->vfp.pregs[i].p[j] &= pmask;
-        }
-        pmask = 0;
-    }
-}
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 52fc9d1d4c..3b8d838dbc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4461,11 +4461,44 @@ static int sve_exception_el(CPUARMState *env, int el)
     return 0;
 }
 
+/*
+ * Given that SVE is enabled, return the vector length for EL.
+ */
+static uint32_t sve_zcr_len_for_el(CPUARMState *env, int el)
+{
+    ARMCPU *cpu = arm_env_get_cpu(env);
+    uint32_t zcr_len = cpu->sve_max_vq - 1;
+
+    if (el <= 1) {
+        zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[1]);
+    }
+    if (el < 2 && arm_feature(env, ARM_FEATURE_EL2)) {
+        zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[2]);
+    }
+    if (el < 3 && arm_feature(env, ARM_FEATURE_EL3)) {
+        zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[3]);
+    }
+    return zcr_len;
+}
+
 static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                       uint64_t value)
 {
+    int cur_el = arm_current_el(env);
+    int old_len = sve_zcr_len_for_el(env, cur_el);
+    int new_len;
+
     /* Bits other than [3:0] are RAZ/WI.  */
     raw_write(env, ri, value & 0xf);
+
+    /*
+     * Because we arrived here, we know both FP and SVE are enabled;
+     * otherwise we would have trapped access to the ZCR_ELn register.
+     */
+    new_len = sve_zcr_len_for_el(env, cur_el);
+    if (new_len < old_len) {
+        aarch64_sve_narrow_vq(env, new_len + 1);
+    }
 }
 
 static const ARMCPRegInfo zcr_el1_reginfo = {
@@ -8305,8 +8338,11 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     unsigned int new_el = env->exception.target_el;
     target_ulong addr = env->cp15.vbar_el[new_el];
     unsigned int new_mode = aarch64_pstate_mode(new_el, true);
+    unsigned int cur_el = arm_current_el(env);
 
-    if (arm_current_el(env) < new_el) {
+    aarch64_sve_change_el(env, cur_el, new_el);
+
+    if (cur_el < new_el) {
         /* Entry vector offset depends on whether the implemented EL
          * immediately lower than the target level is using AArch32 or AArch64
          */
@@ -12598,18 +12634,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             if (sve_el != 0 && fp_el == 0) {
                 zcr_len = 0;
             } else {
-                ARMCPU *cpu = arm_env_get_cpu(env);
-
-                zcr_len = cpu->sve_max_vq - 1;
-                if (current_el <= 1) {
-                    zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[1]);
-                }
-                if (current_el < 2 && arm_feature(env, ARM_FEATURE_EL2)) {
-                    zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[2]);
-                }
-                if (current_el < 3 && arm_feature(env, ARM_FEATURE_EL3)) {
-                    zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[3]);
-                }
+                zcr_len = sve_zcr_len_for_el(env, current_el);
             }
             flags |= sve_el << ARM_TBFLAG_SVEEXC_EL_SHIFT;
             flags |= zcr_len << ARM_TBFLAG_ZCR_LEN_SHIFT;
@@ -12665,3 +12690,85 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
     *pflags = flags;
     *cs_base = 0;
 }
+
+#ifdef TARGET_AARCH64
+/*
+ * The manual says that when SVE is enabled and VQ is widened the
+ * implementation is allowed to zero the previously inaccessible
+ * portion of the registers.  The corollary to that is that when
+ * SVE is enabled and VQ is narrowed we are also allowed to zero
+ * the now inaccessible portion of the registers.
+ *
+ * The intent of this is that no predicate bit beyond VQ is ever set.
+ * Which means that some operations on predicate registers themselves
+ * may operate on full uint64_t or even unrolled across the maximum
+ * uint64_t[4].  Performing 4 bits of host arithmetic unconditionally
+ * may well be cheaper than conditionals to restrict the operation
+ * to the relevant portion of a uint16_t[16].
+ */
+void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq)
+{
+    int i, j;
+    uint64_t pmask;
+
+    assert(vq >= 1 && vq <= ARM_MAX_VQ);
+    assert(vq <= arm_env_get_cpu(env)->sve_max_vq);
+
+    /* Zap the high bits of the zregs.  */
+    for (i = 0; i < 32; i++) {
+        memset(&env->vfp.zregs[i].d[2 * vq], 0, 16 * (ARM_MAX_VQ - vq));
+    }
+
+    /* Zap the high bits of the pregs and ffr.  */
+    pmask = 0;
+    if (vq & 3) {
+        pmask = ~(-1ULL << (16 * (vq & 3)));
+    }
+    for (j = vq / 4; j < ARM_MAX_VQ / 4; j++) {
+        for (i = 0; i < 17; ++i) {
+            env->vfp.pregs[i].p[j] &= pmask;
+        }
+        pmask = 0;
+    }
+}
+
+/*
+ * Notice a change in SVE vector size when changing EL.
+ */
+void aarch64_sve_change_el(CPUARMState *env, int old_el, int new_el)
+{
+    int old_len, new_len;
+
+    /* Nothing to do if no SVE.  */
+    if (!arm_feature(env, ARM_FEATURE_SVE)) {
+        return;
+    }
+
+    /* Nothing to do if FP is disabled in either EL.  */
+    if (fp_exception_el(env, old_el) || fp_exception_el(env, new_el)) {
+        return;
+    }
+
+    /*
+     * DDI0584A.d sec 3.2: "If SVE instructions are disabled or trapped
+     * at ELx, or not available because the EL is in AArch32 state, then
+     * for all purposes other than a direct read, the ZCR_ELx.LEN field
+     * has an effective value of 0".
+     *
+     * Consider EL2 (aa64, vq=4) -> EL0 (aa32) -> EL1 (aa64, vq=0).
+     * If we ignore aa32 state, we would fail to see the vq4->vq0 transition
+     * from EL2->EL1.  Thus we go ahead and narrow when entering aa32 so that
+     * we already have the correct register contents when encountering the
+     * vq0->vq0 transition between EL0->EL1.
+     */
+    old_len = (arm_el_is_aa64(env, old_el) && !sve_exception_el(env, old_el)
+               ? sve_zcr_len_for_el(env, old_el) : 0);
+    new_len = (arm_el_is_aa64(env, new_el) && !sve_exception_el(env, new_el)
+               ? sve_zcr_len_for_el(env, new_el) : 0);
+
+    /* When changing vector length, clear inaccessible state.  */
+    if (new_len < old_len) {
+        aarch64_sve_narrow_vq(env, new_len + 1);
+    }
+}
+#endif
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 952b8d122b..430c50a9f9 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -1082,6 +1082,7 @@ void HELPER(exception_return)(CPUARMState *env)
                       "AArch64 EL%d PC 0x%" PRIx64 "\n",
                       cur_el, new_el, env->pc);
     }
+    aarch64_sve_change_el(env, cur_el, new_el);
 
     qemu_mutex_lock_iothread();
     arm_call_el_change_hook(arm_env_get_cpu(env));
-- 
2.17.1
