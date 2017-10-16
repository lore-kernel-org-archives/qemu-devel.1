Received: from eggs.gnu.org ([2001:4830:134:3::10]:52779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49Aa-0002oL-61
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49AZ-00040U-1T
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:27:16 -0400
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233]:46254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e49AY-0003yr-Ra
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:27:14 -0400
Received: by mail-pf0-x233.google.com with SMTP id p87so16296477pfj.3
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 10:27:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 16 Oct 2017 10:26:02 -0700
Message-Id: <20171016172609.23422-44-richard.henderson@linaro.org>
In-Reply-To: <20171016172609.23422-1-richard.henderson@linaro.org>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 43/50] gen-icount: fold exitreq_label into
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
Cc: cota@braap.org

From: "Emilio G. Cota" <cota@braap.org>

Groundwork for supporting multiple TCG contexts.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/gen-icount.h | 7 +++----
 tcg/tcg.h                 | 2 ++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index c58b0b2585..fe80176462 100644
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
     if (tb_cflags(tb) & CF_USE_ICOUNT) {
         count = tcg_temp_local_new_i32();
     } else {
@@ -34,7 +33,7 @@ static inline void gen_tb_start(TranslationBlock *tb)
         tcg_temp_free_i32(imm);
     }
 
-    tcg_gen_brcondi_i32(TCG_COND_LT, count, 0, exitreq_label);
+    tcg_gen_brcondi_i32(TCG_COND_LT, count, 0, tcg_ctx->exitreq_label);
 
     if (tb_cflags(tb) & CF_USE_ICOUNT) {
         tcg_gen_st16_i32(count, tcg_ctx->tcg_env,
@@ -52,7 +51,7 @@ static inline void gen_tb_end(TranslationBlock *tb, int num_insns)
         tcg_set_insn_param(icount_start_insn_idx, 1, num_insns);
     }
 
-    gen_set_label(exitreq_label);
+    gen_set_label(tcg_ctx->exitreq_label);
     tcg_gen_exit_tb((uintptr_t)tb + TB_EXIT_REQUESTED);
 
     /* Terminate the linked list.  */
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 859020a0fd..dd11d9f835 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -717,6 +717,8 @@ struct TCGContext {
     struct TCGLabelPoolData *pool_labels;
 #endif
 
+    TCGLabel *exitreq_label;
+
     TCGTempSet free_temps[TCG_TYPE_COUNT * 2];
     TCGTemp temps[TCG_MAX_TEMPS]; /* globals first, temps after */
 
-- 
2.13.6
