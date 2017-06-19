Received: from eggs.gnu.org ([2001:4830:134:3::10]:33399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN1GJ-0008Qd-N9
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN1GI-0002I0-Q0
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:55 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:34194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dN1GI-0002Hk-Jw
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:54 -0400
Received: by mail-pf0-x244.google.com with SMTP id d5so18589405pfe.1
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 11:18:54 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 19 Jun 2017 11:18:37 -0700
Message-Id: <20170619181839.25249-11-rth@twiddle.net>
In-Reply-To: <20170619181839.25249-1-rth@twiddle.net>
References: <20170619181839.25249-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/12] target/alpha: Use
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
Cc: peter.maydell@linaro.org

Tested-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/alpha/translate.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 7c45ae3..232af9e 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -84,6 +84,7 @@ typedef enum {
        the PC (for whatever reason), so there's no need to do it again on
        exiting the TB.  */
     EXIT_PC_UPDATED,
+    EXIT_PC_UPDATED_NOCHAIN,
 
     /* We are exiting the TB, but have neither emitted a goto_tb, nor
        updated the PC for the next instruction to be executed.  */
@@ -458,11 +459,17 @@ static bool in_superpage(DisasContext *ctx, int64_t addr)
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
@@ -1198,7 +1205,10 @@ static ExitStatus gen_call_pal(DisasContext *ctx, int palcode)
             tcg_gen_andi_i64(tmp, ctx->ir[IR_A0], PS_INT_MASK);
             tcg_gen_st8_i64(tmp, cpu_env, offsetof(CPUAlphaState, ps));
             tcg_temp_free(tmp);
-            break;
+
+            /* Allow interrupts to be recognized right away.  */
+            tcg_gen_movi_i64(cpu_pc, ctx->pc);
+            return EXIT_PC_UPDATED_NOCHAIN;
 
         case 0x36:
             /* RDPS */
@@ -1266,7 +1276,7 @@ static ExitStatus gen_call_pal(DisasContext *ctx, int palcode)
            need the page permissions check.  We'll see the existence of
            the page when we create the TB, and we'll flush all TBs if
            we change the PAL base register.  */
-        if (!ctx->singlestep_enabled && !(ctx->tb->cflags & CF_LAST_IO)) {
+        if (!use_exit_tb(ctx)) {
             tcg_gen_goto_tb(0);
             tcg_gen_movi_i64(cpu_pc, entry);
             tcg_gen_exit_tb((uintptr_t)ctx->tb);
@@ -2686,7 +2696,8 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
         tcg_gen_andi_i64(tmp, vb, 1);
         tcg_gen_st8_i64(tmp, cpu_env, offsetof(CPUAlphaState, pal_mode));
         tcg_gen_andi_i64(cpu_pc, vb, ~3);
-        ret = EXIT_PC_UPDATED;
+        /* Allow interrupts to be recognized right away.  */
+        ret = EXIT_PC_UPDATED_NOCHAIN;
         break;
 #else
         goto invalid_opc;
@@ -3010,6 +3021,12 @@ void gen_intermediate_code(CPUAlphaState *env, struct TranslationBlock *tb)
         tcg_gen_movi_i64(cpu_pc, ctx.pc);
         /* FALLTHRU */
     case EXIT_PC_UPDATED:
+        if (!use_exit_tb(&ctx)) {
+            tcg_gen_lookup_and_goto_ptr(cpu_pc);
+            break;
+        }
+        /* FALLTHRU */
+    case EXIT_PC_UPDATED_NOCHAIN:
         if (ctx.singlestep_enabled) {
             gen_excp_1(EXCP_DEBUG, 0);
         } else {
-- 
2.9.4
