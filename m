Received: from eggs.gnu.org ([2001:4830:134:3::10]:46052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6z-0000JL-4c
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6y-0000EX-3j
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:33 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:46394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7I6x-0000DI-Tl
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:32 -0400
Received: by mail-wm0-x242.google.com with SMTP id m72so634438wmc.1
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 02:36:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 11:35:26 +0200
Message-Id: <20171025093535.10175-43-richard.henderson@linaro.org>
In-Reply-To: <20171025093535.10175-1-richard.henderson@linaro.org>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 42/51] gen-icount: fold exitreq_label into
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
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Groundwork for supporting multiple TCG contexts.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
index 17fd146557..cca85b4d85 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -675,6 +675,8 @@ struct TCGContext {
     struct TCGLabelPoolData *pool_labels;
 #endif
 
+    TCGLabel *exitreq_label;
+
     TCGTempSet free_temps[TCG_TYPE_COUNT * 2];
     TCGTemp temps[TCG_MAX_TEMPS]; /* globals first, temps after */
 
-- 
2.13.6
