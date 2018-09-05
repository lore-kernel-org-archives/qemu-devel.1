Received: from eggs.gnu.org ([2001:4830:134:3::10]:57825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMs0-0005wO-9C
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMrz-0006n1-0M
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:36 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136]:42888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fxMry-0006lt-My
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:34 -0400
Received: by mail-lf1-x136.google.com with SMTP id z11-v6so4568322lff.9
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 18:44:34 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue,  4 Sep 2018 18:43:43 -0700
Message-Id: <20180905014352.970-7-jcmvbkbc@gmail.com>
In-Reply-To: <20180905014352.970-1-jcmvbkbc@gmail.com>
References: <20180905014352.970-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 06/15] target/xtensa: extract test for window
 underflow exception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

- mark retw and retw.n instructions;
- extract window inderflow test from retw helper;
- put underflow exception check generation right after the overflow
  check;

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/helper.h    |  1 +
 target/xtensa/op_helper.c | 24 +++++++++++++++---------
 target/xtensa/translate.c |  9 +++++++++
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/target/xtensa/helper.h b/target/xtensa/helper.h
index c1b3bacb4cf2..10153c245360 100644
--- a/target/xtensa/helper.h
+++ b/target/xtensa/helper.h
@@ -6,6 +6,7 @@ DEF_HELPER_3(debug_exception, noreturn, env, i32, i32)
 DEF_HELPER_2(wsr_windowbase, void, env, i32)
 DEF_HELPER_4(entry, void, env, i32, i32, i32)
 DEF_HELPER_2(test_ill_retw, void, env, i32)
+DEF_HELPER_2(test_underflow_retw, void, env, i32)
 DEF_HELPER_2(retw, i32, env, i32)
 DEF_HELPER_2(rotw, void, env, i32)
 DEF_HELPER_3(window_check, noreturn, env, i32, i32)
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index 68052851af32..e4b42ab3e56c 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -310,19 +310,15 @@ void HELPER(test_ill_retw)(CPUXtensaState *env, uint32_t pc)
     }
 }
 
-uint32_t HELPER(retw)(CPUXtensaState *env, uint32_t pc)
+void HELPER(test_underflow_retw)(CPUXtensaState *env, uint32_t pc)
 {
     int n = (env->regs[0] >> 30) & 0x3;
-    uint32_t windowbase = windowbase_bound(env->sregs[WINDOW_BASE], env);
-    uint32_t windowstart = env->sregs[WINDOW_START];
-    uint32_t ret_pc = 0;
 
-    ret_pc = (pc & 0xc0000000) | (env->regs[0] & 0x3fffffff);
+    if (!(env->sregs[WINDOW_START] &
+          windowstart_bit(env->sregs[WINDOW_BASE] - n, env))) {
+        uint32_t windowbase = windowbase_bound(env->sregs[WINDOW_BASE], env);
 
-    xtensa_rotate_window(env, -n);
-    if (windowstart & windowstart_bit(env->sregs[WINDOW_BASE], env)) {
-        env->sregs[WINDOW_START] &= ~windowstart_bit(windowbase, env);
-    } else {
+        xtensa_rotate_window(env, -n);
         /* window underflow */
         env->sregs[PS] = (env->sregs[PS] & ~PS_OWB) |
             (windowbase << PS_OWB_SHIFT) | PS_EXCM;
@@ -336,6 +332,16 @@ uint32_t HELPER(retw)(CPUXtensaState *env, uint32_t pc)
             HELPER(exception)(env, EXC_WINDOW_UNDERFLOW12);
         }
     }
+}
+
+uint32_t HELPER(retw)(CPUXtensaState *env, uint32_t pc)
+{
+    int n = (env->regs[0] >> 30) & 0x3;
+    uint32_t windowbase = windowbase_bound(env->sregs[WINDOW_BASE], env);
+    uint32_t ret_pc = (pc & 0xc0000000) | (env->regs[0] & 0x3fffffff);
+
+    xtensa_rotate_window(env, -n);
+    env->sregs[WINDOW_START] &= ~windowstart_bit(windowbase, env);
     return ret_pc;
 }
 
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index de306bdfd344..deedd4c973ef 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1071,6 +1071,13 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
         return;
     }
 
+    if (op_flags & XTENSA_OP_UNDERFLOW) {
+        TCGv_i32 tmp = tcg_const_i32(dc->pc);
+
+        gen_helper_test_underflow_retw(cpu_env, tmp);
+        tcg_temp_free(tmp);
+    }
+
     for (slot = 0; slot < slots; ++slot) {
         XtensaOpcodeOps *ops = slot_prop[slot].ops;
 
@@ -3485,10 +3492,12 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "retw",
         .translate = translate_retw,
         .test_ill = test_ill_retw,
+        .op_flags = XTENSA_OP_UNDERFLOW,
     }, {
         .name = "retw.n",
         .translate = translate_retw,
         .test_ill = test_ill_retw,
+        .op_flags = XTENSA_OP_UNDERFLOW,
     }, {
         .name = "rfdd",
         .op_flags = XTENSA_OP_ILL,
-- 
2.11.0
