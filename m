Received: from eggs.gnu.org ([2001:4830:134:3::10]:56423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMp-00047S-7R
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMl-0000Ic-0C
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:06 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 21 Aug 2018 14:33:20 +1000
Message-Id: <20180821043343.7514-4-david@gibson.dropbear.id.au>
In-Reply-To: <20180821043343.7514-1-david@gibson.dropbear.id.au>
References: <20180821043343.7514-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 03/26] target/ppc: Enable fp exceptions for
 user-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, lvivier@redhat.com, Richard Henderson <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

From: Richard Henderson <richard.henderson@linaro.org>

While just setting the MSR bits is sufficient, we can tidy
the helper code by extracting the MSR test to a helper and
then forcing it true for user-only.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c         | 15 ++++++++++++---
 target/ppc/translate_init.inc.c |  2 ++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 8675d931b6..9b39c4b3e5 100644
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
@@ -555,7 +564,7 @@ static void do_float_check_status(CPUPPCState *env, uintptr_t raddr)
     if (cs->exception_index == POWERPC_EXCP_PROGRAM &&
         (env->error_code & POWERPC_EXCP_FP)) {
         /* Differred floating-point exception after target FPR update */
-        if (msr_fe0 != 0 || msr_fe1 != 0) {
+        if (fp_exceptions_enabled(env)) {
             raise_exception_err_ra(env, cs->exception_index,
                                    env->error_code, raddr);
         }
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 7813b1b004..fe0cb98e6d 100644
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
