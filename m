Received: from eggs.gnu.org ([2001:4830:134:3::10]:59007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe1D-0006I5-I7
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:20:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe1C-0007iH-12
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:20:03 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:42986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXe1A-0007Yf-5Y
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:20:01 -0500
Received: by mail-ot1-x32c.google.com with SMTP id v23so4096851otk.9
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 19:19:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 21:19:19 -0600
Message-Id: <20181214031923.29527-30-richard.henderson@linaro.org>
In-Reply-To: <20181214031923.29527-1-richard.henderson@linaro.org>
References: <20181214031923.29527-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 28/32] tcg: Drop nargs from
 tcg_op_insert_{before, after}
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

It's unused since 75e8b9b7aa0b95a761b9add7e2f09248b101a392.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <20181209193749.12277-9-cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.h      |  4 ++--
 tcg/optimize.c |  4 ++--
 tcg/tcg.c      | 10 ++++------
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index f4efbaa680..a745e926bb 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -1073,8 +1073,8 @@ void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args);
 
 TCGOp *tcg_emit_op(TCGOpcode opc);
 void tcg_op_remove(TCGContext *s, TCGOp *op);
-TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op, TCGOpcode opc, int narg);
-TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *op, TCGOpcode opc, int narg);
+TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op, TCGOpcode opc);
+TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *op, TCGOpcode opc);
 
 void tcg_optimize(TCGContext *s);
 
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 6b98ec13e6..01e80c3e46 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1261,7 +1261,7 @@ void tcg_optimize(TCGContext *s)
                 uint64_t a = ((uint64_t)ah << 32) | al;
                 uint64_t b = ((uint64_t)bh << 32) | bl;
                 TCGArg rl, rh;
-                TCGOp *op2 = tcg_op_insert_before(s, op, INDEX_op_movi_i32, 2);
+                TCGOp *op2 = tcg_op_insert_before(s, op, INDEX_op_movi_i32);
 
                 if (opc == INDEX_op_add2_i32) {
                     a += b;
@@ -1283,7 +1283,7 @@ void tcg_optimize(TCGContext *s)
                 uint32_t b = arg_info(op->args[3])->val;
                 uint64_t r = (uint64_t)a * b;
                 TCGArg rl, rh;
-                TCGOp *op2 = tcg_op_insert_before(s, op, INDEX_op_movi_i32, 2);
+                TCGOp *op2 = tcg_op_insert_before(s, op, INDEX_op_movi_i32);
 
                 rl = op->args[0];
                 rh = op->args[1];
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 54f1272187..963cb37892 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2205,16 +2205,14 @@ TCGOp *tcg_emit_op(TCGOpcode opc)
     return op;
 }
 
-TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *old_op,
-                            TCGOpcode opc, int nargs)
+TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *old_op, TCGOpcode opc)
 {
     TCGOp *new_op = tcg_op_alloc(opc);
     QTAILQ_INSERT_BEFORE(old_op, new_op, link);
     return new_op;
 }
 
-TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *old_op,
-                           TCGOpcode opc, int nargs)
+TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *old_op, TCGOpcode opc)
 {
     TCGOp *new_op = tcg_op_alloc(opc);
     QTAILQ_INSERT_AFTER(&s->ops, old_op, new_op, link);
@@ -2552,7 +2550,7 @@ static bool liveness_pass_2(TCGContext *s)
                     TCGOpcode lopc = (arg_ts->type == TCG_TYPE_I32
                                       ? INDEX_op_ld_i32
                                       : INDEX_op_ld_i64);
-                    TCGOp *lop = tcg_op_insert_before(s, op, lopc, 3);
+                    TCGOp *lop = tcg_op_insert_before(s, op, lopc);
 
                     lop->args[0] = temp_arg(dir_ts);
                     lop->args[1] = temp_arg(arg_ts->mem_base);
@@ -2621,7 +2619,7 @@ static bool liveness_pass_2(TCGContext *s)
                 TCGOpcode sopc = (arg_ts->type == TCG_TYPE_I32
                                   ? INDEX_op_st_i32
                                   : INDEX_op_st_i64);
-                TCGOp *sop = tcg_op_insert_after(s, op, sopc, 3);
+                TCGOp *sop = tcg_op_insert_after(s, op, sopc);
 
                 sop->args[0] = temp_arg(dir_ts);
                 sop->args[1] = temp_arg(arg_ts->mem_base);
-- 
2.17.2
