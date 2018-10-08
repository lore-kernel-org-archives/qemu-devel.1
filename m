Received: from eggs.gnu.org ([2001:4830:134:3::10]:57892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9d4P-000505-AF
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:28:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9cyy-0008Cf-MG
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:22:30 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:44388)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g9cyu-0008Am-QP
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:22:26 -0400
Received: by mail-pf1-x441.google.com with SMTP id r9-v6so8786869pff.11
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 14:22:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  8 Oct 2018 14:22:04 -0700
Message-Id: <20181008212205.17752-10-richard.henderson@linaro.org>
In-Reply-To: <20181008212205.17752-1-richard.henderson@linaro.org>
References: <20181008212205.17752-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 09/10] target/arm: Convert sve from feature
 bit to aa64pfr0 test
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h            | 16 +++++++++++++++-
 target/arm/translate-a64.h  |  1 +
 linux-user/aarch64/signal.c |  4 ++--
 linux-user/elfload.c        |  2 +-
 linux-user/syscall.c        | 10 ++++++----
 target/arm/cpu64.c          |  5 ++++-
 target/arm/helper.c         |  9 ++++++---
 target/arm/machine.c        |  3 +--
 target/arm/translate-a64.c  |  4 ++--
 9 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d8cb9633d2..a97b471fff 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1531,6 +1531,16 @@ FIELD(ID_AA64ISAR1, FRINTTS, 32, 4)
 FIELD(ID_AA64ISAR1, SB, 36, 4)
 FIELD(ID_AA64ISAR1, SPECRES, 40, 4)
 
+FIELD(ID_AA64PFR0, EL0, 0, 4)
+FIELD(ID_AA64PFR0, EL1, 4, 4)
+FIELD(ID_AA64PFR0, EL2, 8, 4)
+FIELD(ID_AA64PFR0, EL3, 12, 4)
+FIELD(ID_AA64PFR0, FP, 16, 4)
+FIELD(ID_AA64PFR0, ADVSIMD, 20, 4)
+FIELD(ID_AA64PFR0, GIC, 24, 4)
+FIELD(ID_AA64PFR0, RAS, 28, 4)
+FIELD(ID_AA64PFR0, SVE, 32, 4)
+
 QEMU_BUILD_BUG_ON(ARRAY_SIZE(((ARMCPU *)0)->ccsidr) <= R_V7M_CSSELR_INDEX_MASK);
 
 /* If adding a feature bit which corresponds to a Linux ELF
@@ -1579,7 +1589,6 @@ enum arm_features {
     ARM_FEATURE_PMU, /* has PMU support */
     ARM_FEATURE_VBAR, /* has cp15 VBAR */
     ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
-    ARM_FEATURE_SVE, /* has Scalable Vector Extension */
     ARM_FEATURE_V8_FP16, /* implements v8.2 half-precision float */
     ARM_FEATURE_M_MAIN, /* M profile Main Extension */
 };
@@ -3263,4 +3272,9 @@ static inline bool aa64_feature_fcma(ARMCPU *cpu)
     return FIELD_EX64(cpu->id_aa64isar1, ID_AA64ISAR1, FCMA) != 0;
 }
 
+static inline bool aa64_feature_sve(ARMCPU *cpu)
+{
+    return FIELD_EX64(cpu->id_aa64pfr0, ID_AA64PFR0, SVE) != 0;
+}
+
 #endif
diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index b4ef9eb024..636f3fded3 100644
--- a/target/arm/translate-a64.h
+++ b/target/arm/translate-a64.h
@@ -140,6 +140,7 @@ FORWARD_FEATURE(sm3)
 FORWARD_FEATURE(sm4)
 FORWARD_FEATURE(dp)
 FORWARD_FEATURE(fcma)
+FORWARD_FEATURE(sve)
 
 #undef FORWARD_FEATURE
 
diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index 07fedfc33c..65272fb7a9 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -314,7 +314,7 @@ static int target_restore_sigframe(CPUARMState *env,
             break;
 
         case TARGET_SVE_MAGIC:
-            if (arm_feature(env, ARM_FEATURE_SVE)) {
+            if (aa64_feature_sve(arm_env_get_cpu(env))) {
                 vq = (env->vfp.zcr_el[1] & 0xf) + 1;
                 sve_size = QEMU_ALIGN_UP(TARGET_SVE_SIG_CONTEXT_SIZE(vq), 16);
                 if (!sve && size == sve_size) {
@@ -433,7 +433,7 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
                                       &layout);
 
     /* SVE state needs saving only if it exists.  */
-    if (arm_feature(env, ARM_FEATURE_SVE)) {
+    if (aa64_feature_sve(arm_env_get_cpu(env))) {
         vq = (env->vfp.zcr_el[1] & 0xf) + 1;
         sve_size = QEMU_ALIGN_UP(TARGET_SVE_SIG_CONTEXT_SIZE(vq), 16);
         sve_ofs = alloc_sigframe_space(sve_size, &layout);
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 3061d703b2..e3585f4cb6 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -593,7 +593,7 @@ static uint32_t get_elf_hwcap(void)
     GET_FEATURE_ID(rdm, ARM_HWCAP_A64_ASIMDRDM);
     GET_FEATURE_ID(dp, ARM_HWCAP_A64_ASIMDDP);
     GET_FEATURE_ID(fcma, ARM_HWCAP_A64_FCMA);
-    GET_FEATURE(ARM_FEATURE_SVE, ARM_HWCAP_A64_SVE);
+    GET_FEATURE_ID(sve, ARM_HWCAP_A64_SVE);
 
 #undef GET_FEATURE
 #undef GET_FEATURE_ID
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ae3c0dfef7..37f315ad4a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9356,7 +9356,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
              * even though the current architectural maximum is VQ=16.
              */
             ret = -TARGET_EINVAL;
-            if (arm_feature(cpu_env, ARM_FEATURE_SVE)
+            if (aa64_feature_sve(arm_env_get_cpu(cpu_env))
                 && arg2 >= 0 && arg2 <= 512 * 16 && !(arg2 & 15)) {
                 CPUARMState *env = cpu_env;
                 ARMCPU *cpu = arm_env_get_cpu(env);
@@ -9375,9 +9375,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             return ret;
         case TARGET_PR_SVE_GET_VL:
             ret = -TARGET_EINVAL;
-            if (arm_feature(cpu_env, ARM_FEATURE_SVE)) {
-                CPUARMState *env = cpu_env;
-                ret = ((env->vfp.zcr_el[1] & 0xf) + 1) * 16;
+            {
+                ARMCPU *cpu = arm_env_get_cpu(cpu_env);
+                if (aa64_feature_sve(cpu)) {
+                    ret = ((cpu->env.vfp.zcr_el[1] & 0xf) + 1) * 16;
+                }
             }
             return ret;
 #endif /* AARCH64 */
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index a0cc29d356..ee2c04a627 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -264,6 +264,10 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 1);
         cpu->id_aa64isar1 = t;
 
+        t = cpu->id_aa64pfr0;
+        t = FIELD_DP64(t, ID_AA64PFR0, SVE, 1);
+        cpu->id_aa64pfr0 = t;
+
         /* Replicate the same data to the 32-bit id registers.  */
         u = cpu->id_isar5;
         u = FIELD_DP32(u, ID_ISAR5, AES, 2); /* AES + PMULL */
@@ -286,7 +290,6 @@ static void aarch64_max_initfn(Object *obj)
          * present in either.
          */
         set_feature(&cpu->env, ARM_FEATURE_V8_FP16);
-        set_feature(&cpu->env, ARM_FEATURE_SVE);
         /* For usermode -cpu max we can use a larger and more efficient DCZ
          * blocksize since we don't have to follow what the hardware does.
          */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0da13175be..2b981a09e4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5615,7 +5615,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_one_arm_cp_reg(cpu, &sctlr);
     }
 
-    if (arm_feature(env, ARM_FEATURE_SVE)) {
+    if (aa64_feature_sve(cpu)) {
         define_one_arm_cp_reg(cpu, &zcr_el1_reginfo);
         if (arm_feature(env, ARM_FEATURE_EL2)) {
             define_one_arm_cp_reg(cpu, &zcr_el2_reginfo);
@@ -12668,13 +12668,15 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
     uint32_t flags;
 
     if (is_a64(env)) {
+        ARMCPU *cpu = arm_env_get_cpu(env);
+
         *pc = env->pc;
         flags = ARM_TBFLAG_AARCH64_STATE_MASK;
         /* Get control bits for tagged addresses */
         flags |= (arm_regime_tbi0(env, mmu_idx) << ARM_TBFLAG_TBI0_SHIFT);
         flags |= (arm_regime_tbi1(env, mmu_idx) << ARM_TBFLAG_TBI1_SHIFT);
 
-        if (arm_feature(env, ARM_FEATURE_SVE)) {
+        if (aa64_feature_sve(cpu)) {
             int sve_el = sve_exception_el(env, current_el);
             uint32_t zcr_len;
 
@@ -12798,11 +12800,12 @@ void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq)
 void aarch64_sve_change_el(CPUARMState *env, int old_el,
                            int new_el, bool el0_a64)
 {
+    ARMCPU *cpu = arm_env_get_cpu(env);
     int old_len, new_len;
     bool old_a64, new_a64;
 
     /* Nothing to do if no SVE.  */
-    if (!arm_feature(env, ARM_FEATURE_SVE)) {
+    if (!aa64_feature_sve(cpu)) {
         return;
     }
 
diff --git a/target/arm/machine.c b/target/arm/machine.c
index d44e891533..8b3ba96889 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -131,9 +131,8 @@ static const VMStateDescription vmstate_iwmmxt = {
 static bool sve_needed(void *opaque)
 {
     ARMCPU *cpu = opaque;
-    CPUARMState *env = &cpu->env;
 
-    return arm_feature(env, ARM_FEATURE_SVE);
+    return aa64_feature_sve(cpu);
 }
 
 /* The first two words of each Zreg is stored in VFP state.  */
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 55a050dc50..448723fbe4 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -173,7 +173,7 @@ void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
     cpu_fprintf(f, "     FPCR=%08x FPSR=%08x\n",
                 vfp_get_fpcr(env), vfp_get_fpsr(env));
 
-    if (arm_feature(env, ARM_FEATURE_SVE) && sve_exception_el(env, el) == 0) {
+    if (aa64_feature_sve(cpu) && sve_exception_el(env, el) == 0) {
         int j, zcr_len = sve_zcr_len_for_el(env, el);
 
         for (i = 0; i <= FFR_PRED_NUM; i++) {
@@ -13790,7 +13790,7 @@ static void disas_a64_insn(CPUARMState *env, DisasContext *s)
         unallocated_encoding(s);
         break;
     case 0x2:
-        if (!arm_dc_feature(s, ARM_FEATURE_SVE) || !disas_sve(s, insn)) {
+        if (!aa64_dc_feature_sve(s) || !disas_sve(s, insn)) {
             unallocated_encoding(s);
         }
         break;
-- 
2.17.1
