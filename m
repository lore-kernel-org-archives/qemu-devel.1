Received: from eggs.gnu.org ([2001:4830:134:3::10]:57268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUz5G-0003Lf-NY
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:40:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUz5F-0004QR-Ss
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:40:58 -0400
Received: from mail-pg0-x231.google.com ([2607:f8b0:400e:c05::231]:44218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fUz5F-0004O3-Mi
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:40:57 -0400
Received: by mail-pg0-x231.google.com with SMTP id p21-v6so7919533pgd.11
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 11:40:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Jun 2018 08:40:27 -1000
Message-Id: <20180618184046.6270-4-richard.henderson@linaro.org>
In-Reply-To: <20180618184046.6270-1-richard.henderson@linaro.org>
References: <20180618184046.6270-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 03/22] target/openrisc: Fix
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
index c7c1f40782..5c0c9dee09 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1449,31 +1449,30 @@ static void openrisc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
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
