Received: from eggs.gnu.org ([2001:4830:134:3::10]:59584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5dOX-00021s-UT
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5dOW-0001on-Od
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:33 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d5dOW-0001oZ-JK
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:32 -0400
Received: by mail-qk0-x243.google.com with SMTP id o85so22941788qkh.0
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 12:23:32 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  2 May 2017 12:22:55 -0700
Message-Id: <20170502192300.2124-21-rth@twiddle.net>
In-Reply-To: <20170502192300.2124-1-rth@twiddle.net>
References: <20170502192300.2124-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v6 20/25] target/alpha: Use
 tcg_gen_lookup_and_goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/alpha/translate.c | 54 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 7 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index df5d695..c2941ae 100644
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
@@ -455,11 +458,17 @@ static bool in_superpage(DisasContext *ctx, int64_t addr)
 #endif
 }
 
+static bool use_exit_tb(DisasContext *ctx)
+{
+    return ((ctx->tb->cflags & CF_LAST_IO)
+            || ctx->singlestep_enabled
+            || singlestep);
+}
+
 static bool use_goto_tb(DisasContext *ctx, uint64_t dest)
 {
     /* Suppress goto_tb in the case of single-steping and IO.  */
-    if ((ctx->tb->cflags & CF_LAST_IO)
-        || ctx->singlestep_enabled || singlestep) {
+    if (unlikely(use_exit_tb(ctx))) {
         return false;
     }
 #ifndef CONFIG_USER_ONLY
@@ -492,7 +501,12 @@ static ExitStatus gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
         return EXIT_GOTO_TB;
     } else {
         tcg_gen_movi_i64(cpu_pc, dest);
-        return EXIT_PC_UPDATED;
+        if (use_exit_tb(ctx)) {
+            return EXIT_PC_UPDATED;
+        } else {
+            tcg_gen_lookup_and_goto_ptr(cpu_pc);
+            return EXIT_GOTO_TB;
+        }
     }
 }
 
@@ -2421,7 +2435,12 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
         if (ra != 31) {
             tcg_gen_movi_i64(ctx->ir[ra], ctx->pc);
         }
-        ret = EXIT_PC_UPDATED;
+        if (use_exit_tb(ctx)) {
+            ret = EXIT_PC_UPDATED;
+        } else {
+            tcg_gen_lookup_and_goto_ptr(cpu_pc);
+            ret = EXIT_GOTO_TB;
+        }
         break;
 
     case 0x1B:
@@ -2677,7 +2696,12 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
         tcg_gen_andi_i64(tmp, vb, 1);
         tcg_gen_st8_i64(tmp, cpu_env, offsetof(CPUAlphaState, pal_mode));
         tcg_gen_andi_i64(cpu_pc, vb, ~3);
-        ret = EXIT_PC_UPDATED;
+        if (use_exit_tb(ctx)) {
+            ret = EXIT_PC_UPDATED;
+        } else {
+            tcg_gen_lookup_and_goto_ptr(cpu_pc);
+            ret = EXIT_GOTO_TB;
+        }
         break;
 #else
         goto invalid_opc;
@@ -2978,7 +3002,7 @@ void gen_intermediate_code(CPUAlphaState *env, struct TranslationBlock *tb)
                 || num_insns >= max_insns
                 || singlestep
                 || ctx.singlestep_enabled)) {
-            ret = EXIT_PC_STALE;
+            ret = EXIT_FALLTHRU;
         }
     } while (ret == NO_EXIT);
 
@@ -3000,8 +3024,24 @@ void gen_intermediate_code(CPUAlphaState *env, struct TranslationBlock *tb)
             tcg_gen_exit_tb(0);
         }
         break;
+    case EXIT_FALLTHRU:
+        if (ctx.singlestep_enabled) {
+            tcg_gen_movi_i64(cpu_pc, ctx.pc);
+            gen_excp_1(EXCP_DEBUG, 0);
+        } else if (use_exit_tb(&ctx)) {
+            tcg_gen_movi_i64(cpu_pc, ctx.pc);
+            tcg_gen_exit_tb(0);
+        } else if (use_goto_tb(&ctx, ctx.pc)) {
+            tcg_gen_goto_tb(0);
+            tcg_gen_movi_i64(cpu_pc, ctx.pc);
+            tcg_gen_exit_tb((uintptr_t)ctx.tb);
+        } else {
+            tcg_gen_movi_i64(cpu_pc, ctx.pc);
+            tcg_gen_lookup_and_goto_ptr(cpu_pc);
+        }
+        break;
     default:
-        abort();
+        g_assert_not_reached();
     }
 
     gen_tb_end(tb, num_insns);
-- 
2.9.3
