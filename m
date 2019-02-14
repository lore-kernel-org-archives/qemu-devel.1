Received: from eggs.gnu.org ([209.51.188.92]:35065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gu8Im-0003Ij-3I
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:07:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gu8If-0005gp-Ai
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:07:05 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gu8Ie-0005eq-Uk
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:07:01 -0500
Received: by mail-pl1-x641.google.com with SMTP id 101so2402079pld.6
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 20:07:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 13 Feb 2019 20:06:52 -0800
Message-Id: <20190214040652.4811-5-richard.henderson@linaro.org>
In-Reply-To: <20190214040652.4811-1-richard.henderson@linaro.org>
References: <20190214040652.4811-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 4/4] target/arm: Rely on hflags correct in
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3c8724883d..1bdb87267e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -13894,21 +13894,16 @@ void HELPER(rebuild_hflags_a64)(CPUARMState *env, uint32_t el)
 void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                           target_ulong *cs_base, uint32_t *pflags)
 {
-    int current_el = arm_current_el(env);
-    uint32_t flags;
+    uint32_t flags = env->hflags;
     uint32_t pstate_for_ss;
 
     *cs_base = 0;
-    if (is_a64(env)) {
+    if (FIELD_EX32(flags, TBFLAG_ANY, AARCH64_STATE)) {
         *pc = env->pc;
-        flags = rebuild_hflags_a64(env, current_el);
-        assert(flags == env->hflags);
         flags = FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
         pstate_for_ss = env->pstate;
     } else {
         *pc = env->regs[15];
-        flags = rebuild_hflags_a32(env, current_el);
-        assert(flags == env->hflags);
         flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
         flags = FIELD_DP32(flags, TBFLAG_A32, CONDEXEC, env->condexec_bits);
         pstate_for_ss = env->uncached_cpsr;
-- 
2.17.1
