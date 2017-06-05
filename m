Received: from eggs.gnu.org ([2001:4830:134:3::10]:56885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHvFZ-0004jT-06
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHvFY-0003y2-8E
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:53:05 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHvFY-0003xa-3y
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:53:04 -0400
Received: by mail-qt0-x243.google.com with SMTP id s33so9908071qtg.3
	for <qemu-devel@nongnu.org>; Mon, 05 Jun 2017 09:53:03 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon,  5 Jun 2017 09:52:27 -0700
Message-Id: <20170605165233.4135-21-rth@twiddle.net>
In-Reply-To: <20170605165233.4135-1-rth@twiddle.net>
References: <20170605165233.4135-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 20/26] target/hppa: Use
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

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/hppa/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 9e8c233..e10abc5 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -517,7 +517,7 @@ static void gen_goto_tb(DisasContext *ctx, int which,
         if (ctx->singlestep_enabled) {
             gen_excp_1(EXCP_DEBUG);
         } else {
-            tcg_gen_exit_tb(0);
+            tcg_gen_lookup_and_goto_ptr(cpu_iaoq_f);
         }
     }
 }
@@ -1510,7 +1510,7 @@ static ExitStatus do_ibranch(DisasContext *ctx, TCGv dest,
     } else if (is_n && use_nullify_skip(ctx)) {
         /* The (conditional) branch, B, nullifies the next insn, N,
            and we're allowed to skip execution N (no single-step or
-           tracepoint in effect).  Since the exit_tb that we must use
+           tracepoint in effect).  Since the goto_ptr that we must use
            for the indirect branch consumes no special resources, we
            can (conditionally) skip B and continue execution.  */
         /* The use_nullify_skip test implies we have a known control path.  */
@@ -1527,7 +1527,7 @@ static ExitStatus do_ibranch(DisasContext *ctx, TCGv dest,
         if (link != 0) {
             tcg_gen_movi_tl(cpu_gr[link], ctx->iaoq_n);
         }
-        tcg_gen_exit_tb(0);
+        tcg_gen_lookup_and_goto_ptr(cpu_iaoq_f);
         return nullify_end(ctx, NO_EXIT);
     } else {
         cond_prep(&ctx->null_cond);
@@ -3885,7 +3885,7 @@ void gen_intermediate_code(CPUHPPAState *env, struct TranslationBlock *tb)
         if (ctx.singlestep_enabled) {
             gen_excp_1(EXCP_DEBUG);
         } else {
-            tcg_gen_exit_tb(0);
+            tcg_gen_lookup_and_goto_ptr(cpu_iaoq_f);
         }
         break;
     default:
-- 
2.9.4
