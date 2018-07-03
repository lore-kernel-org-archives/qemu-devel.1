Received: from eggs.gnu.org ([2001:4830:134:3::10]:57646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1faN3k-0006IL-1g
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:17:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1faN3h-0000Ls-9q
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:17:40 -0400
Received: from mail-pg0-x236.google.com ([2607:f8b0:400e:c05::236]:42736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1faN3h-0000LQ-3t
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:17:37 -0400
Received: by mail-pg0-x236.google.com with SMTP id c10-v6so1126238pgu.9
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 08:17:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue,  3 Jul 2018 08:17:26 -0700
Message-Id: <20180703151732.29843-2-richard.henderson@linaro.org>
In-Reply-To: <20180703151732.29843-1-richard.henderson@linaro.org>
References: <20180703151732.29843-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/7] target/ppc: Enable fp exceptions for
 user-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: programmingkidx@gmail.com, david@gibson.dropbear.id.au, qemu-ppc@nongnu.org

While just setting the MSR bits is sufficient, we can tidy
the helper code by extracting the MSR test to a helper and
then forcing it true for user-only.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/fpu_helper.c         | 15 ++++++++++++---
 target/ppc/translate_init.inc.c |  2 ++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 7714bfe0f9..119826b5a7 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -36,6 +36,15 @@ static inline float128 float128_snan_to_qnan(float128 x)
 #define float32_snan_to_qnan(x) ((x) | 0x00400000)
 #define float16_snan_to_qnan(x) ((x) | 0x0200)
 
+static inline bool fp_exceptions_enabled(CPUPPCState *env)
+{
+#ifdef CONFIG_USER_ONLY
+    return true;
+#else
+    return (env->msr & ((1U << MSR_FE0) | (1U << MSR_FE1))) != 0;
+#endif
+}
+
 /*****************************************************************************/
 /* Floating point operations helpers */
 uint64_t helper_float32_to_float64(CPUPPCState *env, uint32_t arg)
@@ -207,7 +216,7 @@ uint64_t float_invalid_op_excp(CPUPPCState *env, int op, int set_fpcc)
     if (ve != 0) {
         /* Update the floating-point enabled exception summary */
         env->fpscr |= 1 << FPSCR_FEX;
-        if (msr_fe0 != 0 || msr_fe1 != 0) {
+        if (fp_exceptions_enabled(env)) {
             /* GETPC() works here because this is inline */
             raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
                                    POWERPC_EXCP_FP | op, GETPC());
@@ -225,7 +234,7 @@ static inline void float_zero_divide_excp(CPUPPCState *env, uintptr_t raddr)
     if (fpscr_ze != 0) {
         /* Update the floating-point enabled exception summary */
         env->fpscr |= 1 << FPSCR_FEX;
-        if (msr_fe0 != 0 || msr_fe1 != 0) {
+        if (fp_exceptions_enabled(env)) {
             raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
                                    POWERPC_EXCP_FP | POWERPC_EXCP_FP_ZX,
                                    raddr);
@@ -547,7 +556,7 @@ static void do_float_check_status(CPUPPCState *env, uintptr_t raddr)
     if (cs->exception_index == POWERPC_EXCP_PROGRAM &&
         (env->error_code & POWERPC_EXCP_FP)) {
         /* Differred floating-point exception after target FPR update */
-        if (msr_fe0 != 0 || msr_fe1 != 0) {
+        if (fp_exceptions_enabled(env)) {
             raise_exception_err_ra(env, cs->exception_index,
                                    env->error_code, raddr);
         }
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 76d6f3fd5e..ffa74a1026 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -10278,6 +10278,8 @@ static void ppc_cpu_reset(CPUState *s)
 #endif
 #if defined(CONFIG_USER_ONLY)
     msr |= (target_ulong)1 << MSR_FP; /* Allow floating point usage */
+    msr |= (target_ulong)1 << MSR_FE0; /* Allow floating point exceptions */
+    msr |= (target_ulong)1 << MSR_FE1;
     msr |= (target_ulong)1 << MSR_VR; /* Allow altivec usage */
     msr |= (target_ulong)1 << MSR_VSX; /* Allow VSX usage */
     msr |= (target_ulong)1 << MSR_SPE; /* Allow SPE usage */
-- 
2.17.1
