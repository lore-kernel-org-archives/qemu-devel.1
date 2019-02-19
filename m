Received: from eggs.gnu.org ([209.51.188.92]:57490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwEuK-0007Xh-Bo
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 18:34:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwEuJ-0001Wd-If
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 18:34:36 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwEuH-0001Rn-MF
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 18:34:35 -0500
Received: by mail-pg1-x542.google.com with SMTP id h11so8511917pgl.0
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 15:34:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 19 Feb 2019 15:34:21 -0800
Message-Id: <20190219233421.388-4-richard.henderson@linaro.org>
In-Reply-To: <20190219233421.388-1-richard.henderson@linaro.org>
References: <20190219233421.388-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 3/3] target/arm: Rely on hflags correct in
 cpu_get_tb_cpu_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, cota@braap.org

This is the payoff.

>From perf record -g data of ubuntu 18 boot and shutdown:

BEFORE:

-   23.02%     2.82%  qemu-system-aar  [.] helper_lookup_tb_ptr
   - 20.22% helper_lookup_tb_ptr
      + 10.05% tb_htable_lookup
      - 9.13% cpu_get_tb_cpu_state
           3.20% aa64_va_parameters_both
           0.55% fp_exception_el

-   11.66%     4.74%  qemu-system-aar  [.] cpu_get_tb_cpu_state
   - 6.96% cpu_get_tb_cpu_state
        3.63% aa64_va_parameters_both
        0.60% fp_exception_el
        0.53% sve_exception_el

AFTER:

-   16.40%     3.40%  qemu-system-aar  [.] helper_lookup_tb_ptr
   - 13.03% helper_lookup_tb_ptr
      + 11.19% tb_htable_lookup
        0.55% cpu_get_tb_cpu_state

     0.98%     0.71%  qemu-system-aar  [.] cpu_get_tb_cpu_state

     0.87%     0.24%  qemu-system-aar  [.] rebuild_hflags_a64

Before, helper_lookup_tb_ptr is the second hottest function in the
application, consuming almost a quarter of the runtime.  Within the
entire execution, cpu_get_tb_cpu_state consumes about 12%.

After, helper_lookup_tb_ptr has dropped to the fourth hottest function,
with consumption dropping to a sixth of the runtime.  Within the
entire execution, cpu_get_tb_cpu_state has dropped below 1%, and the
supporting function to rebuild hflags also consumes about 1%.

Assertions are retained for --enable-debug-tcg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Retain asserts for future debugging.
---
 target/arm/helper.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 909535a3e3..990a87876f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -14034,19 +14034,29 @@ void HELPER(rebuild_hflags_a64)(CPUARMState *env, uint32_t el)
 void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                           target_ulong *cs_base, uint32_t *pflags)
 {
-    int current_el = arm_current_el(env);
-    uint32_t flags;
+    uint32_t flags = env->hflags;
     uint32_t pstate_for_ss;
 
+#ifdef CONFIG_DEBUG_TCG
+    {
+        int el = arm_current_el(env);
+        uint32_t check_flags;
+        if (is_a64(env)) {
+            check_flags = rebuild_hflags_a64(env, el);
+        } else {
+            check_flags = rebuild_hflags_a32(env, el);
+        }
+        g_assert_cmphex(flags, ==, check_flags);
+    }
+#endif
+
     *cs_base = 0;
-    if (is_a64(env)) {
+    if (FIELD_EX32(flags, TBFLAG_ANY, AARCH64_STATE)) {
         *pc = env->pc;
-        flags = rebuild_hflags_a64(env, current_el);
         flags = FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
         pstate_for_ss = env->pstate;
     } else {
         *pc = env->regs[15];
-        flags = rebuild_hflags_a32(env, current_el);
         flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
         flags = FIELD_DP32(flags, TBFLAG_A32, CONDEXEC, env->condexec_bits);
         pstate_for_ss = env->uncached_cpsr;
-- 
2.17.1
