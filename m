Received: from eggs.gnu.org ([2001:4830:134:3::10]:59704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCTTP-00046a-78
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCTTL-00010P-1a
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:49:38 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:41139)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCTTK-0000eD-KW
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:49:34 -0400
Received: by mail-pf1-x42c.google.com with SMTP id m77-v6so11818904pfi.8
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 10:49:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 16 Oct 2018 10:48:51 -0700
Message-Id: <20181016174911.9052-2-richard.henderson@linaro.org>
In-Reply-To: <20181016174911.9052-1-richard.henderson@linaro.org>
References: <20181016174911.9052-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 01/21] tcg: Implement CPU_LOG_TB_NOCHAIN during
 expansion
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

Rather than test NOCHAIN before linking, do not emit the
goto_tb opcode at all.  We already do this for goto_ptr.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 2 +-
 tcg/tcg-op.c         | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 6bcb6d99bd..870027d435 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -416,7 +416,7 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
     }
 #endif
     /* See if we can patch the calling TB. */
-    if (last_tb && !qemu_loglevel_mask(CPU_LOG_TB_NOCHAIN)) {
+    if (last_tb) {
         tb_add_jump(last_tb, tb_exit, tb);
     }
     return tb;
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index daa416a143..7a8015c5a9 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2586,6 +2586,10 @@ void tcg_gen_exit_tb(TranslationBlock *tb, unsigned idx)
            seen this numbered exit before, via tcg_gen_goto_tb.  */
         tcg_debug_assert(tcg_ctx->goto_tb_issue_mask & (1 << idx));
 #endif
+        /* When not chaining, exit without indicating a link.  */
+        if (qemu_loglevel_mask(CPU_LOG_TB_NOCHAIN)) {
+            val = 0;
+        }
     } else {
         /* This is an exit via the exitreq label.  */
         tcg_debug_assert(idx == TB_EXIT_REQUESTED);
@@ -2603,7 +2607,10 @@ void tcg_gen_goto_tb(unsigned idx)
     tcg_debug_assert((tcg_ctx->goto_tb_issue_mask & (1 << idx)) == 0);
     tcg_ctx->goto_tb_issue_mask |= 1 << idx;
 #endif
-    tcg_gen_op1i(INDEX_op_goto_tb, idx);
+    /* When not chaining, we simply fall through to the "fallback" exit.  */
+    if (!qemu_loglevel_mask(CPU_LOG_TB_NOCHAIN)) {
+        tcg_gen_op1i(INDEX_op_goto_tb, idx);
+    }
 }
 
 void tcg_gen_lookup_and_goto_ptr(void)
-- 
2.17.2
