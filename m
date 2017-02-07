Received: from eggs.gnu.org ([2001:4830:134:3::10]:48408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cavao-0003WO-4h
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:33:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1caval-0005X3-IJ
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:33:18 -0500
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:34655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1caval-0005Wt-DZ
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:33:15 -0500
Received: by mail-it0-x243.google.com with SMTP id o185so10989079itb.1
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 18:33:15 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon,  6 Feb 2017 18:32:28 -0800
Message-Id: <20170207023229.29431-5-rth@twiddle.net>
In-Reply-To: <20170207023229.29431-1-rth@twiddle.net>
References: <20170207023229.29431-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 4/5] target/hppa: Tidy do_cbranch
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

Removes some dead code detected by Covarity.

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/hppa/translate.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 4d243f7..5d571f0 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1433,7 +1433,6 @@ static ExitStatus do_cbranch(DisasContext *ctx, target_long disp, bool is_n,
     target_ulong dest = iaoq_dest(ctx, disp);
     TCGLabel *taken = NULL;
     TCGCond c = cond->c;
-    int which = 0;
     bool n;
 
     assert(ctx->null_cond.c == TCG_COND_NEVER);
@@ -1455,14 +1454,14 @@ static ExitStatus do_cbranch(DisasContext *ctx, target_long disp, bool is_n,
     n = is_n && disp < 0;
     if (n && use_nullify_skip(ctx)) {
         nullify_set(ctx, 0);
-        gen_goto_tb(ctx, which++, ctx->iaoq_n, ctx->iaoq_n + 4);
+        gen_goto_tb(ctx, 0, ctx->iaoq_n, ctx->iaoq_n + 4);
     } else {
         if (!n && ctx->null_lab) {
             gen_set_label(ctx->null_lab);
             ctx->null_lab = NULL;
         }
         nullify_set(ctx, n);
-        gen_goto_tb(ctx, which++, ctx->iaoq_b, ctx->iaoq_n);
+        gen_goto_tb(ctx, 0, ctx->iaoq_b, ctx->iaoq_n);
     }
 
     gen_set_label(taken);
@@ -1471,23 +1470,17 @@ static ExitStatus do_cbranch(DisasContext *ctx, target_long disp, bool is_n,
     n = is_n && disp >= 0;
     if (n && use_nullify_skip(ctx)) {
         nullify_set(ctx, 0);
-        gen_goto_tb(ctx, which++, dest, dest + 4);
+        gen_goto_tb(ctx, 1, dest, dest + 4);
     } else {
         nullify_set(ctx, n);
-        gen_goto_tb(ctx, which++, ctx->iaoq_b, dest);
+        gen_goto_tb(ctx, 1, ctx->iaoq_b, dest);
     }
 
     /* Not taken: the branch itself was nullified.  */
     if (ctx->null_lab) {
         gen_set_label(ctx->null_lab);
         ctx->null_lab = NULL;
-        if (which < 2) {
-            nullify_set(ctx, 0);
-            gen_goto_tb(ctx, which, ctx->iaoq_b, ctx->iaoq_n);
-            return EXIT_GOTO_TB;
-        } else {
-            return EXIT_IAQ_N_STALE;
-        }
+        return EXIT_IAQ_N_STALE;
     } else {
         return EXIT_GOTO_TB;
     }
-- 
2.9.3
