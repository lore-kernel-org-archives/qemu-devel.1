Received: from eggs.gnu.org ([2001:4830:134:3::10]:57306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1eR45a-0007Hj-HI
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:40:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1eR45Z-00047n-I3
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:40:50 -0500
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:43026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1eR45Z-0003vY-Bi
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:40:49 -0500
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Mon, 18 Dec 2017 23:40:29 +0100
Message-Id: <20171218224030.26726-6-aurelien@aurel32.net>
In-Reply-To: <20171218224030.26726-1-aurelien@aurel32.net>
References: <20171218224030.26726-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PULL 5/6] target/sh4: Do not singlestep after
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
Cc: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>

From: Richard Henderson <rth@twiddle.net>

If we've already raised an exception (and set NORETURN),
do not emit unreachable code to raise a debug exception.
Note that gen_goto_tb takes single-stepping into account.

Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-Id: <20170907185057.23421-4-richard.henderson@linaro.org>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index efd1081c57..dd9aaa4e63 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -270,6 +270,7 @@ static void gen_jump(DisasContext * ctx)
         } else {
             tcg_gen_lookup_and_goto_ptr();
         }
+        ctx->bstate = DISAS_NORETURN;
     } else {
 	gen_goto_tb(ctx, 0, ctx->delayed_pc);
     }
@@ -2341,24 +2342,23 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
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
2.15.1
