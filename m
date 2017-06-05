Received: from eggs.gnu.org ([2001:4830:134:3::10]:56977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHvFh-0004sL-0e
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:53:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHvFg-00046b-1Y
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:53:13 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHvFf-00046X-TE
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:53:11 -0400
Received: by mail-qt0-x243.google.com with SMTP id x58so9855281qtc.2
	for <qemu-devel@nongnu.org>; Mon, 05 Jun 2017 09:53:11 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon,  5 Jun 2017 09:52:33 -0700
Message-Id: <20170605165233.4135-27-rth@twiddle.net>
In-Reply-To: <20170605165233.4135-1-rth@twiddle.net>
References: <20170605165233.4135-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 26/26] target/alpha: Use goto_tb for fallthru
 between TBs
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

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/alpha/translate.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 4523c4c..7c45ae3 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -89,6 +89,9 @@ typedef enum {
        updated the PC for the next instruction to be executed.  */
     EXIT_PC_STALE,
 
+    /* We are exiting the TB due to page crossing or space constraints.  */
+    EXIT_FALLTHRU,
+
     /* We are ending the TB with a noreturn function call, e.g. longjmp.
        No following code will be executed.  */
     EXIT_NORETURN,
@@ -2984,7 +2987,7 @@ void gen_intermediate_code(CPUAlphaState *env, struct TranslationBlock *tb)
                 || num_insns >= max_insns
                 || singlestep
                 || ctx.singlestep_enabled)) {
-            ret = EXIT_PC_STALE;
+            ret = EXIT_FALLTHRU;
         }
     } while (ret == NO_EXIT);
 
@@ -2996,6 +2999,13 @@ void gen_intermediate_code(CPUAlphaState *env, struct TranslationBlock *tb)
     case EXIT_GOTO_TB:
     case EXIT_NORETURN:
         break;
+    case EXIT_FALLTHRU:
+        if (use_goto_tb(&ctx, ctx.pc)) {
+            tcg_gen_goto_tb(0);
+            tcg_gen_movi_i64(cpu_pc, ctx.pc);
+            tcg_gen_exit_tb((uintptr_t)ctx.tb);
+        }
+        /* FALLTHRU */
     case EXIT_PC_STALE:
         tcg_gen_movi_i64(cpu_pc, ctx.pc);
         /* FALLTHRU */
@@ -3007,7 +3017,7 @@ void gen_intermediate_code(CPUAlphaState *env, struct TranslationBlock *tb)
         }
         break;
     default:
-        abort();
+        g_assert_not_reached();
     }
 
     gen_tb_end(tb, num_insns);
-- 
2.9.4
