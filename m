Received: from eggs.gnu.org ([209.51.188.92]:59080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1wT3-00077y-DP
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:06:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1wSu-0005mU-6e
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:05:55 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:34589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1wSm-0004fw-09
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:05:44 -0500
Received: by mail-pf1-x42b.google.com with SMTP id u9so11902046pfn.1
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:05:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Mar 2019 09:04:35 -0800
Message-Id: <20190307170440.3113-18-richard.henderson@linaro.org>
In-Reply-To: <20190307170440.3113-1-richard.henderson@linaro.org>
References: <20190307170440.3113-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4 17/22] target/arm: Set PSTATE.TCO on
 exception entry
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

R0085 specifies that exception handlers begin with tag checks overridden.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Only set if MTE feature present.
---
 target/arm/helper.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c8773a5528..a529d30700 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9628,6 +9628,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     target_ulong addr = env->cp15.vbar_el[new_el];
     unsigned int new_mode = aarch64_pstate_mode(new_el, true);
     unsigned int cur_el = arm_current_el(env);
+    unsigned int new_pstate;
 
     /*
      * Note that new_el can never be 0.  If cur_el is 0, then
@@ -9721,7 +9722,11 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     qemu_log_mask(CPU_LOG_INT, "...with ELR 0x%" PRIx64 "\n",
                   env->elr_el[new_el]);
 
-    pstate_write(env, PSTATE_DAIF | new_mode);
+    new_pstate = new_mode | PSTATE_DAIF;
+    if (cpu_isar_feature(aa64_mte, cpu)) {
+        new_pstate |= PSTATE_TCO;
+    }
+    pstate_write(env, new_pstate);
     env->aarch64 = 1;
     aarch64_restore_sp(env, new_el);
 
-- 
2.17.2
