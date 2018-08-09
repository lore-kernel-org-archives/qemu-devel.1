Received: from eggs.gnu.org ([2001:4830:134:3::10]:54042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncSv-0000rI-76
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncSu-0007JP-4G
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:25 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:44433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fncSt-0007Iz-UB
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:24 -0400
Received: by mail-pf1-x434.google.com with SMTP id k21-v6so2183604pff.11
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 21:22:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  8 Aug 2018 21:21:56 -0700
Message-Id: <20180809042206.15726-11-richard.henderson@linaro.org>
In-Reply-To: <20180809042206.15726-1-richard.henderson@linaro.org>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 10/20] target/arm: Adjust
 aarch64_cpu_dump_state for system mode SVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, alex.bennee@linaro.org

Use the existing helpers to determine if (1) the fpu is enabled,
(2) sve state is enabled, and (3) the current sve vector length.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           | 4 ++++
 target/arm/helper.c        | 6 +++---
 target/arm/translate-a64.c | 8 ++++++--
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 18b3c92c2e..33d06f2340 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -920,6 +920,10 @@ target_ulong do_arm_semihosting(CPUARMState *env);
 void aarch64_sync_32_to_64(CPUARMState *env);
 void aarch64_sync_64_to_32(CPUARMState *env);
 
+int fp_exception_el(CPUARMState *env, int cur_el);
+int sve_exception_el(CPUARMState *env, int cur_el);
+uint32_t sve_zcr_len_for_el(CPUARMState *env, int el);
+
 static inline bool is_a64(CPUARMState *env)
 {
 #ifdef CONFIG_USER_ONLY
diff --git a/target/arm/helper.c b/target/arm/helper.c
index fb79b27cf6..64ff71b722 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4344,7 +4344,7 @@ static const ARMCPRegInfo debug_lpae_cp_reginfo[] = {
  * take care of raising that exception.
  * C.f. the ARM pseudocode function CheckSVEEnabled.
  */
-static int sve_exception_el(CPUARMState *env, int el)
+int sve_exception_el(CPUARMState *env, int el)
 {
 #ifndef CONFIG_USER_ONLY
     if (el <= 1) {
@@ -4402,7 +4402,7 @@ static int sve_exception_el(CPUARMState *env, int el)
 /*
  * Given that SVE is enabled, return the vector length for EL.
  */
-static uint32_t sve_zcr_len_for_el(CPUARMState *env, int el)
+uint32_t sve_zcr_len_for_el(CPUARMState *env, int el)
 {
     ARMCPU *cpu = arm_env_get_cpu(env);
     uint32_t zcr_len = cpu->sve_max_vq - 1;
@@ -12352,7 +12352,7 @@ uint32_t HELPER(crc32c)(uint32_t acc, uint32_t val, uint32_t bytes)
 /* Return the exception level to which FP-disabled exceptions should
  * be taken, or 0 if FP is enabled.
  */
-static int fp_exception_el(CPUARMState *env, int cur_el)
+int fp_exception_el(CPUARMState *env, int cur_el)
 {
 #ifndef CONFIG_USER_ONLY
     int fpen;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index b29dc49c4f..4a0ca8c906 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -166,11 +166,15 @@ void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
         cpu_fprintf(f, "\n");
         return;
     }
+    if (fp_exception_el(env, el) != 0) {
+        cpu_fprintf(f, "    FPU disabled\n");
+        return;
+    }
     cpu_fprintf(f, "     FPCR=%08x FPSR=%08x\n",
                 vfp_get_fpcr(env), vfp_get_fpsr(env));
 
-    if (arm_feature(env, ARM_FEATURE_SVE)) {
-        int j, zcr_len = env->vfp.zcr_el[1] & 0xf; /* fix for system mode */
+    if (arm_feature(env, ARM_FEATURE_SVE) && sve_exception_el(env, el) == 0) {
+        int j, zcr_len = sve_zcr_len_for_el(env, el);
 
         for (i = 0; i <= FFR_PRED_NUM; i++) {
             bool eol;
-- 
2.17.1
