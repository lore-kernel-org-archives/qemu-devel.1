Received: from eggs.gnu.org ([209.51.188.92]:49454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1guQ8u-00034j-0w
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:10:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1guQ05-00055L-NW
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:01:03 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136]:33464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1guQ05-00052p-DM
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:01:01 -0500
Received: by mail-lf1-x136.google.com with SMTP id q12so5834625lfm.0
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 15:00:59 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 14 Feb 2019 14:59:55 -0800
Message-Id: <20190214230000.24894-9-jcmvbkbc@gmail.com>
In-Reply-To: <20190214230000.24894-1-jcmvbkbc@gmail.com>
References: <20190214230000.24894-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 08/13] target/xtensa: only rotate window in the
 retw helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

Move return address calculation and WINDOW_START adjustment out of the
retw helper to simplify logic a bit and avoid using registers directly.
Pass a0 as a parameter to the helper.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/helper.h     | 2 +-
 target/xtensa/translate.c  | 9 +++++++--
 target/xtensa/win_helper.c | 8 ++------
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/target/xtensa/helper.h b/target/xtensa/helper.h
index b6529a8925f3..0b9ec670c86e 100644
--- a/target/xtensa/helper.h
+++ b/target/xtensa/helper.h
@@ -7,7 +7,7 @@ DEF_HELPER_1(sync_windowbase, void, env)
 DEF_HELPER_4(entry, void, env, i32, i32, i32)
 DEF_HELPER_2(test_ill_retw, void, env, i32)
 DEF_HELPER_2(test_underflow_retw, void, env, i32)
-DEF_HELPER_2(retw, i32, env, i32)
+DEF_HELPER_2(retw, void, env, i32)
 DEF_HELPER_3(window_check, noreturn, env, i32, i32)
 DEF_HELPER_1(restore_owb, void, env)
 DEF_HELPER_2(movsp, void, env, i32)
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 0213cef1b605..f991cc360889 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -2226,8 +2226,13 @@ static bool test_ill_retw(DisasContext *dc, const uint32_t arg[],
 static void translate_retw(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    TCGv_i32 tmp = tcg_const_i32(dc->pc);
-    gen_helper_retw(tmp, cpu_env, tmp);
+    TCGv_i32 tmp = tcg_const_i32(1);
+    tcg_gen_shl_i32(tmp, tmp, cpu_SR[WINDOW_BASE]);
+    tcg_gen_andc_i32(cpu_SR[WINDOW_START],
+                     cpu_SR[WINDOW_START], tmp);
+    tcg_gen_movi_i32(tmp, dc->pc);
+    tcg_gen_deposit_i32(tmp, tmp, cpu_R[0], 0, 30);
+    gen_helper_retw(cpu_env, cpu_R[0]);
     gen_jump(dc, tmp);
     tcg_temp_free(tmp);
 }
diff --git a/target/xtensa/win_helper.c b/target/xtensa/win_helper.c
index d7a4e2782186..f6f96a64c30e 100644
--- a/target/xtensa/win_helper.c
+++ b/target/xtensa/win_helper.c
@@ -184,15 +184,11 @@ void HELPER(test_underflow_retw)(CPUXtensaState *env, uint32_t pc)
     }
 }
 
-uint32_t HELPER(retw)(CPUXtensaState *env, uint32_t pc)
+void HELPER(retw)(CPUXtensaState *env, uint32_t a0)
 {
-    int n = (env->regs[0] >> 30) & 0x3;
-    uint32_t windowbase = windowbase_bound(env->sregs[WINDOW_BASE], env);
-    uint32_t ret_pc = (pc & 0xc0000000) | (env->regs[0] & 0x3fffffff);
+    int n = (a0 >> 30) & 0x3;
 
     xtensa_rotate_window(env, -n);
-    env->sregs[WINDOW_START] &= ~windowstart_bit(windowbase, env);
-    return ret_pc;
 }
 
 void xtensa_restore_owb(CPUXtensaState *env)
-- 
2.11.0
