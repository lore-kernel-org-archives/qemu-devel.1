Received: from eggs.gnu.org ([2001:4830:134:3::10]:47987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gRsYl-000417-Rk
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:38:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gRsYi-0004MV-Ho
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:38:51 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:44339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gRsYg-0004Ku-GE
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:38:48 -0500
Received: by mail-pf1-x436.google.com with SMTP id u6so9604940pfh.11
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 21:38:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 27 Nov 2018 21:38:29 -0800
Message-Id: <20181128053834.10861-8-richard.henderson@linaro.org>
In-Reply-To: <20181128053834.10861-1-richard.henderson@linaro.org>
References: <20181128053834.10861-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 07/12] tcg: Dump register preference info with
 liveness
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.h |  3 ---
 tcg/tcg.c | 44 +++++++++++++++++++++++++++++++++++++-------
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index b2e274b7af..ac5d01c223 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -1089,9 +1089,6 @@ TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *op, TCGOpcode opc, int narg);
 
 void tcg_optimize(TCGContext *s);
 
-/* only used for debugging purposes */
-void tcg_dump_ops(TCGContext *s);
-
 TCGv_i32 tcg_const_i32(int32_t val);
 TCGv_i64 tcg_const_i64(int64_t val);
 TCGv_i32 tcg_const_local_i32(int32_t val);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index adf6570c36..27d081e11a 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1921,7 +1921,7 @@ static inline TCGReg tcg_regset_first(TCGRegSet d)
     }
 }
 
-void tcg_dump_ops(TCGContext *s)
+static void tcg_dump_ops(TCGContext *s, bool have_prefs)
 {
     char buf[128];
     TCGOp *op;
@@ -2056,12 +2056,15 @@ void tcg_dump_ops(TCGContext *s)
                 col += qemu_log("%s$0x%" TCG_PRIlx, k ? "," : "", op->args[k]);
             }
         }
-        if (op->life) {
-            unsigned life = op->life;
 
-            for (; col < 48; ++col) {
+        if (have_prefs || op->life) {
+            for (; col < 40; ++col) {
                 putc(' ', qemu_logfile);
             }
+        }
+
+        if (op->life) {
+            unsigned life = op->life;
 
             if (life & (SYNC_ARG * 3)) {
                 qemu_log("  sync:");
@@ -2081,6 +2084,33 @@ void tcg_dump_ops(TCGContext *s)
                 }
             }
         }
+
+        if (have_prefs) {
+            for (i = 0; i < nb_oargs; ++i) {
+                TCGRegSet set = op->output_pref[i];
+
+                if (i == 0) {
+                    qemu_log("  pref=");
+                } else {
+                    qemu_log(",");
+                }
+                if (set == 0) {
+                    qemu_log("none");
+                } else if (set == MAKE_64BIT_MASK(0, TCG_TARGET_NB_REGS)) {
+                    qemu_log("all");
+#ifdef CONFIG_DEBUG_TCG
+                } else if (tcg_regset_single(set)) {
+                    TCGReg reg = tcg_regset_first(set);
+                    qemu_log("%s", tcg_target_reg_names[reg]);
+#endif
+                } else if (TCG_TARGET_NB_REGS <= 32) {
+                    qemu_log("%#x", (uint32_t)set);
+                } else {
+                    qemu_log("%#" PRIx64, (uint64_t)set);
+                }
+            }
+        }
+
         qemu_log("\n");
     }
 }
@@ -3669,7 +3699,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
                  && qemu_log_in_addr_range(tb->pc))) {
         qemu_log_lock();
         qemu_log("OP:\n");
-        tcg_dump_ops(s);
+        tcg_dump_ops(s, false);
         qemu_log("\n");
         qemu_log_unlock();
     }
@@ -3697,7 +3727,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
                      && qemu_log_in_addr_range(tb->pc))) {
             qemu_log_lock();
             qemu_log("OP before indirect lowering:\n");
-            tcg_dump_ops(s);
+            tcg_dump_ops(s, false);
             qemu_log("\n");
             qemu_log_unlock();
         }
@@ -3718,7 +3748,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
                  && qemu_log_in_addr_range(tb->pc))) {
         qemu_log_lock();
         qemu_log("OP after optimization and liveness analysis:\n");
-        tcg_dump_ops(s);
+        tcg_dump_ops(s, true);
         qemu_log("\n");
         qemu_log_unlock();
     }
-- 
2.17.2
