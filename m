Received: from eggs.gnu.org ([2001:4830:134:3::10]:50126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYjY-0006xo-SB
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYjY-0005Bq-17
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:40 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXYjX-0005Bh-Sj
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:39 -0400
Received: by mail-qt0-x244.google.com with SMTP id 50so2614079qtz.0
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 13:04:39 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 10:02:52 -1000
Message-Id: <20170718200255.31647-28-rth@twiddle.net>
In-Reply-To: <20170718200255.31647-1-rth@twiddle.net>
References: <20170718200255.31647-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v3 27/30] target/sh4: Use
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
Cc: aurelien@aurel32.net

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sh4/translate.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 12d5ed7..ab81084 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -235,12 +235,15 @@ static inline void gen_save_cpu_state(DisasContext *ctx, bool save_pc)
     }
 }
 
+static inline bool use_exit_tb(DisasContext *ctx)
+{
+    return (ctx->tbflags & GUSA_EXCLUSIVE) != 0;
+}
+
 static inline bool use_goto_tb(DisasContext *ctx, target_ulong dest)
 {
-    if (unlikely(ctx->singlestep_enabled)) {
-        return false;
-    }
-    if (ctx->tbflags & GUSA_EXCLUSIVE) {
+    /* Use a direct jump if in same page and singlestep not enabled */
+    if (unlikely(ctx->singlestep_enabled || use_exit_tb(ctx))) {
         return false;
     }
 #ifndef CONFIG_USER_ONLY
@@ -253,28 +256,35 @@ static inline bool use_goto_tb(DisasContext *ctx, target_ulong dest)
 static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
 {
     if (use_goto_tb(ctx, dest)) {
-	/* Use a direct jump if in same page and singlestep not enabled */
         tcg_gen_goto_tb(n);
         tcg_gen_movi_i32(cpu_pc, dest);
         tcg_gen_exit_tb((uintptr_t)ctx->tb + n);
     } else {
         tcg_gen_movi_i32(cpu_pc, dest);
-        if (ctx->singlestep_enabled)
+        if (ctx->singlestep_enabled) {
             gen_helper_debug(cpu_env);
-        tcg_gen_exit_tb(0);
+        } else if (use_exit_tb(ctx)) {
+            tcg_gen_exit_tb(0);
+        } else {
+            tcg_gen_lookup_and_goto_ptr(cpu_pc);
+        }
     }
 }
 
 static void gen_jump(DisasContext * ctx)
 {
-    if (ctx->delayed_pc == (uint32_t) - 1) {
+    if (ctx->delayed_pc == -1) {
 	/* Target is not statically known, it comes necessarily from a
 	   delayed jump as immediate jump are conditinal jumps */
 	tcg_gen_mov_i32(cpu_pc, cpu_delayed_pc);
         tcg_gen_discard_i32(cpu_delayed_pc);
-	if (ctx->singlestep_enabled)
+	if (ctx->singlestep_enabled) {
             gen_helper_debug(cpu_env);
-	tcg_gen_exit_tb(0);
+        } else if (use_exit_tb(ctx)) {
+            tcg_gen_exit_tb(0);
+        } else {
+            tcg_gen_lookup_and_goto_ptr(cpu_pc);
+        }
     } else {
 	gen_goto_tb(ctx, 0, ctx->delayed_pc);
     }
-- 
2.9.4
