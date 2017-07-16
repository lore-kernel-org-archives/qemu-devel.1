Received: from eggs.gnu.org ([2001:4830:134:3::10]:46309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmd-0001BE-OF
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmY-0008Pc-Ue
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:51 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35779)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dWpmY-0008P3-RM
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:46 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 16 Jul 2017 16:04:18 -0400
Message-Id: <1500235468-15341-36-git-send-email-cota@braap.org>
In-Reply-To: <1500235468-15341-1-git-send-email-cota@braap.org>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 35/45] gen-icount: fold exitreq_label into
 TCGContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

Groundwork for supporting multiple TCG contexts.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/gen-icount.h | 7 +++----
 tcg/tcg.h                 | 2 ++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index 4a55da8..7723aa0 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -6,13 +6,12 @@
 /* Helpers for instruction counting code generation.  */
 
 static int icount_start_insn_idx;
-static TCGLabel *exitreq_label;
 
 static inline void gen_tb_start(TranslationBlock *tb)
 {
     TCGv_i32 count, imm;
 
-    exitreq_label = gen_new_label();
+    tcg_ctx->exitreq_label = gen_new_label();
     if (tb->cflags & CF_USE_ICOUNT) {
         count = tcg_temp_local_new_i32();
     } else {
@@ -34,7 +33,7 @@ static inline void gen_tb_start(TranslationBlock *tb)
         tcg_temp_free_i32(imm);
     }
 
-    tcg_gen_brcondi_i32(TCG_COND_LT, count, 0, exitreq_label);
+    tcg_gen_brcondi_i32(TCG_COND_LT, count, 0, tcg_ctx->exitreq_label);
 
     if (tb->cflags & CF_USE_ICOUNT) {
         tcg_gen_st16_i32(count, tcg_ctx->tcg_env,
@@ -52,7 +51,7 @@ static inline void gen_tb_end(TranslationBlock *tb, int num_insns)
         tcg_set_insn_param(icount_start_insn_idx, 1, num_insns);
     }
 
-    gen_set_label(exitreq_label);
+    gen_set_label(tcg_ctx->exitreq_label);
     tcg_gen_exit_tb((uintptr_t)tb + TB_EXIT_REQUESTED);
 
     /* Terminate the linked list.  */
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 6913d4b..569f823 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -712,6 +712,8 @@ struct TCGContext {
     /* The TCGBackendData structure is private to tcg-target.inc.c.  */
     struct TCGBackendData *be;
 
+    TCGLabel *exitreq_label;
+
     TCGTempSet free_temps[TCG_TYPE_COUNT * 2];
     TCGTemp temps[TCG_MAX_TEMPS]; /* globals first, temps after */
 
-- 
2.7.4
