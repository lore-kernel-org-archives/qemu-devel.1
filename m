Received: from eggs.gnu.org ([2001:4830:134:3::10]:39889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYNDj-0004w4-7d
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:03:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYNDi-0007g3-CW
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:03:43 -0400
Received: from mail-pl0-x230.google.com ([2607:f8b0:400e:c01::230]:44071)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fYNDi-0007fQ-7L
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:03:42 -0400
Received: by mail-pl0-x230.google.com with SMTP id m16-v6so2005323pls.11
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 20:03:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 27 Jun 2018 20:03:13 -0700
Message-Id: <20180628030330.15615-7-richard.henderson@linaro.org>
In-Reply-To: <20180628030330.15615-1-richard.henderson@linaro.org>
References: <20180628030330.15615-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 06/23] target/openrisc: Fix
 singlestep_enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: shorne@gmail.com

We failed to store to cpu_pc before raising the exception,
which caused us to re-execute the same insn that we stepped.

Reviewed-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/translate.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 43bdf378eb..22848b17ad 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1335,31 +1335,30 @@ static void openrisc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
+    /* If we have already exited the TB, nothing following has effect.  */
+    if (dc->base.is_jmp == DISAS_NORETURN) {
+        return;
+    }
+
     if ((dc->tb_flags & TB_FLAGS_DFLAG ? 1 : 0) != (dc->delayed_branch != 0)) {
         tcg_gen_movi_i32(cpu_dflag, dc->delayed_branch != 0);
     }
 
     tcg_gen_movi_tl(cpu_ppc, dc->base.pc_next - 4);
-    if (dc->base.is_jmp == DISAS_NEXT) {
-        dc->base.is_jmp = DISAS_UPDATE;
-        tcg_gen_movi_tl(cpu_pc, dc->base.pc_next);
-    }
-    if (unlikely(dc->base.singlestep_enabled)) {
-        gen_exception(dc, EXCP_DEBUG);
-    } else {
-        switch (dc->base.is_jmp) {
-        case DISAS_TOO_MANY:
-            gen_goto_tb(dc, 0, dc->base.pc_next);
-            break;
-        case DISAS_NORETURN:
-            break;
-        case DISAS_UPDATE:
-        case DISAS_EXIT:
+    switch (dc->base.is_jmp) {
+    case DISAS_TOO_MANY:
+        gen_goto_tb(dc, 0, dc->base.pc_next);
+        break;
+    case DISAS_UPDATE:
+    case DISAS_EXIT:
+        if (unlikely(dc->base.singlestep_enabled)) {
+            gen_exception(dc, EXCP_DEBUG);
+        } else {
             tcg_gen_exit_tb(NULL, 0);
-            break;
-        default:
-            g_assert_not_reached();
         }
+        break;
+    default:
+        g_assert_not_reached();
     }
 }
 
-- 
2.17.1
