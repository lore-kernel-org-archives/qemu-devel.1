Received: from eggs.gnu.org ([209.51.188.92]:38670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLOi-0005ss-8Z
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:54:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLOg-00053O-6W
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:54:00 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:33354)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtLOf-0004Z9-Dw
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:57 -0500
Received: by mail-pf1-x42a.google.com with SMTP id c123so349260pfb.0
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 15:53:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 15:52:51 -0800
Message-Id: <20190211235258.542-22-richard.henderson@linaro.org>
In-Reply-To: <20190211235258.542-1-richard.henderson@linaro.org>
References: <20190211235258.542-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 21/28] target/arm: Set PSTATE.TCO on
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

R0085 specifies that exception handlers begin with tag checks overridden.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Only set if MTE feature present.
---
 target/arm/helper.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f17e045706..b979ca0255 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9476,6 +9476,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     target_ulong addr = env->cp15.vbar_el[new_el];
     unsigned int new_mode = aarch64_pstate_mode(new_el, true);
     unsigned int cur_el = arm_current_el(env);
+    unsigned int new_pstate;
 
     /*
      * Note that new_el can never be 0.  If cur_el is 0, then
@@ -9569,7 +9570,11 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
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
