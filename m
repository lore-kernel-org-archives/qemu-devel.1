Received: from eggs.gnu.org ([2001:4830:134:3::10]:46426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dU6zL-0004RF-5d
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dU6zF-00031t-C4
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:43 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41119)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dU6zE-0002zn-QP
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:37 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  9 Jul 2017 03:50:07 -0400
Message-Id: <1499586614-20507-16-git-send-email-cota@braap.org>
In-Reply-To: <1499586614-20507-1-git-send-email-cota@braap.org>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 15/22] gen-icount: fold exitreq_label into
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

Before we make TCGContext thread-local.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/gen-icount.h | 7 +++----
 tcg/tcg.h                 | 2 ++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index 9b3cb14..489aff7 100644
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
+    tcg_ctx.exitreq_label = gen_new_label();
     if (tb->cflags & CF_USE_ICOUNT) {
         count = tcg_temp_local_new_i32();
     } else {
@@ -34,7 +33,7 @@ static inline void gen_tb_start(TranslationBlock *tb)
         tcg_temp_free_i32(imm);
     }
 
-    tcg_gen_brcondi_i32(TCG_COND_LT, count, 0, exitreq_label);
+    tcg_gen_brcondi_i32(TCG_COND_LT, count, 0, tcg_ctx.exitreq_label);
 
     if (tb->cflags & CF_USE_ICOUNT) {
         tcg_gen_st16_i32(count, tcg_ctx.tcg_env,
@@ -52,7 +51,7 @@ static inline void gen_tb_end(TranslationBlock *tb, int num_insns)
         tcg_set_insn_param(icount_start_insn_idx, 1, num_insns);
     }
 
-    gen_set_label(exitreq_label);
+    gen_set_label(tcg_ctx.exitreq_label);
     tcg_gen_exit_tb((uintptr_t)tb + TB_EXIT_REQUESTED);
 
     /* Terminate the linked list.  */
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 4f57878..534ead5 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -711,6 +711,8 @@ struct TCGContext {
     /* The TCGBackendData structure is private to tcg-target.inc.c.  */
     struct TCGBackendData *be;
 
+    TCGLabel *exitreq_label;
+
     TCGTempSet free_temps[TCG_TYPE_COUNT * 2];
     TCGTemp temps[TCG_MAX_TEMPS]; /* globals first, temps after */
 
-- 
2.7.4
