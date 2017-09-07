Received: from eggs.gnu.org ([2001:4830:134:3::10]:54143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq1tM-0000A4-PZ
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:51:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq1tI-0000VH-7l
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:51:08 -0400
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233]:35759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dq1tI-0000Ur-1b
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:51:04 -0400
Received: by mail-pf0-x233.google.com with SMTP id g13so834775pfm.2
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 11:51:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Sep 2017 11:50:55 -0700
Message-Id: <20170907185057.23421-4-richard.henderson@linaro.org>
In-Reply-To: <20170907185057.23421-1-richard.henderson@linaro.org>
References: <20170907185057.23421-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 3/5] target/sh4: Do not singlestep after
 exceptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

If we've already raised an exception (and set NORETURN),
do not emit unreachable code to raise a debug exception.
Note that gen_goto_tb takes single-stepping into account.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sh4/translate.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 6e03370871..5cda27cc0a 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -281,6 +281,7 @@ static void gen_jump(DisasContext * ctx)
         } else {
             tcg_gen_lookup_and_goto_ptr(cpu_pc);
         }
+        ctx->bstate = DISAS_NORETURN;
     } else {
 	gen_goto_tb(ctx, 0, ctx->delayed_pc);
     }
@@ -2349,24 +2350,23 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         ctx.envflags &= ~GUSA_MASK;
     }
 
-    if (cs->singlestep_enabled) {
+    switch (ctx.bstate) {
+    case DISAS_STOP:
         gen_save_cpu_state(&ctx, true);
-        gen_helper_debug(cpu_env);
-    } else {
-	switch (ctx.bstate) {
-        case DISAS_STOP:
-            gen_save_cpu_state(&ctx, true);
+        if (cs->singlestep_enabled) {
+            gen_helper_debug(cpu_env);
+        } else {
             tcg_gen_exit_tb(0);
-            break;
-        case DISAS_NEXT:
-            gen_save_cpu_state(&ctx, false);
-            gen_goto_tb(&ctx, 0, ctx.pc);
-            break;
-        case DISAS_NORETURN:
-            break;
-        default:
-            g_assert_not_reached();
-	}
+        }
+        break;
+    case DISAS_NEXT:
+        gen_save_cpu_state(&ctx, false);
+        gen_goto_tb(&ctx, 0, ctx.pc);
+        break;
+    case DISAS_NORETURN:
+        break;
+    default:
+        g_assert_not_reached();
     }
 
     gen_tb_end(tb, num_insns);
-- 
2.13.5
