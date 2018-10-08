Received: from eggs.gnu.org ([2001:4830:134:3::10]:46256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W5a-0001Gk-Sk
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:00:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W5V-0007Dl-P8
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:00:50 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1g9W5V-0006yM-DS
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:00:45 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W53-0003fv-8m
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:00:17 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  8 Oct 2018 14:59:40 +0100
Message-Id: <20181008140004.12612-10-peter.maydell@linaro.org>
In-Reply-To: <20181008140004.12612-1-peter.maydell@linaro.org>
References: <20181008140004.12612-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/33] target/arm: Adjust aarch64_cpu_dump_state
 for system mode SVE
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

Use the existing helpers to determine if (1) the fpu is enabled,
(2) sve state is enabled, and (3) the current sve vector length.

Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181005175350.30752-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h           | 4 ++++
 target/arm/helper.c        | 6 +++---
 target/arm/translate-a64.c | 8 ++++++--
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a4ee83dc770..da4d3888eab 100644
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
     return env->aarch64;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 72f7f5cfec2..efe42f9e079 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4406,7 +4406,7 @@ static const ARMCPRegInfo debug_lpae_cp_reginfo[] = {
  * take care of raising that exception.
  * C.f. the ARM pseudocode function CheckSVEEnabled.
  */
-static int sve_exception_el(CPUARMState *env, int el)
+int sve_exception_el(CPUARMState *env, int el)
 {
 #ifndef CONFIG_USER_ONLY
     if (el <= 1) {
@@ -4464,7 +4464,7 @@ static int sve_exception_el(CPUARMState *env, int el)
 /*
  * Given that SVE is enabled, return the vector length for EL.
  */
-static uint32_t sve_zcr_len_for_el(CPUARMState *env, int el)
+uint32_t sve_zcr_len_for_el(CPUARMState *env, int el)
 {
     ARMCPU *cpu = arm_env_get_cpu(env);
     uint32_t zcr_len = cpu->sve_max_vq - 1;
@@ -12546,7 +12546,7 @@ uint32_t HELPER(crc32c)(uint32_t acc, uint32_t val, uint32_t bytes)
 /* Return the exception level to which FP-disabled exceptions should
  * be taken, or 0 if FP is enabled.
  */
-static int fp_exception_el(CPUARMState *env, int cur_el)
+int fp_exception_el(CPUARMState *env, int cur_el)
 {
 #ifndef CONFIG_USER_ONLY
     int fpen;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 8ca3876707c..8a24278d797 100644
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
2.19.0
