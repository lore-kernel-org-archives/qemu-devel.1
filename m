Received: from eggs.gnu.org ([2001:4830:134:3::10]:48642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fa0Tg-0003wJ-BI
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:10:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fa0Tf-0007pP-8S
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:10:56 -0400
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c]:40443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fa0Tf-0007pF-2R
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:10:55 -0400
Received: by mail-pf0-x22c.google.com with SMTP id z24-v6so7656123pfe.7
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 08:10:55 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Tue,  3 Jul 2018 00:10:04 +0900
Message-Id: <20180702151023.24532-7-shorne@gmail.com>
In-Reply-To: <20180702151023.24532-1-shorne@gmail.com>
References: <20180702151023.24532-1-shorne@gmail.com>
Subject: [Qemu-devel] [PULL v2 06/25] target/openrisc: Fix singlestep_enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Development <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, Stafford Horne <shorne@gmail.com>

From: Richard Henderson <richard.henderson@linaro.org>

We failed to store to cpu_pc before raising the exception,
which caused us to re-execute the same insn that we stepped.

Reviewed-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
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
2.17.0
