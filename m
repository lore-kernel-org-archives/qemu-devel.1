Received: from eggs.gnu.org ([2001:4830:134:3::10]:33410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4uF-0001SW-9S
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4uA-0005jJ-6n
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:23 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:41879)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gW4u6-0004wc-PS
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:16 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  9 Dec 2018 14:37:19 -0500
Message-Id: <20181209193749.12277-9-cota@braap.org>
In-Reply-To: <20181209193749.12277-1-cota@braap.org>
References: <20181209193749.12277-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v2 08/38] tcg: drop nargs from
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

It's unused.

Signed-off-by: Emilio G. Cota <cota@braap.org>
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
index 5dbe11c3c8..a2247f6de3 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1249,7 +1249,7 @@ void tcg_optimize(TCGContext *s)
                 uint64_t a = ((uint64_t)ah << 32) | al;
                 uint64_t b = ((uint64_t)bh << 32) | bl;
                 TCGArg rl, rh;
-                TCGOp *op2 = tcg_op_insert_before(s, op, INDEX_op_movi_i32, 2);
+                TCGOp *op2 = tcg_op_insert_before(s, op, INDEX_op_movi_i32);
 
                 if (opc == INDEX_op_add2_i32) {
                     a += b;
@@ -1271,7 +1271,7 @@ void tcg_optimize(TCGContext *s)
                 uint32_t b = arg_info(op->args[3])->val;
                 uint64_t r = (uint64_t)a * b;
                 TCGArg rl, rh;
-                TCGOp *op2 = tcg_op_insert_before(s, op, INDEX_op_movi_i32, 2);
+                TCGOp *op2 = tcg_op_insert_before(s, op, INDEX_op_movi_i32);
 
                 rl = op->args[0];
                 rh = op->args[1];
diff --git a/tcg/tcg.c b/tcg/tcg.c
index e85133ef05..e87c662a18 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2203,16 +2203,14 @@ TCGOp *tcg_emit_op(TCGOpcode opc)
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
@@ -2550,7 +2548,7 @@ static bool liveness_pass_2(TCGContext *s)
                     TCGOpcode lopc = (arg_ts->type == TCG_TYPE_I32
                                       ? INDEX_op_ld_i32
                                       : INDEX_op_ld_i64);
-                    TCGOp *lop = tcg_op_insert_before(s, op, lopc, 3);
+                    TCGOp *lop = tcg_op_insert_before(s, op, lopc);
 
                     lop->args[0] = temp_arg(dir_ts);
                     lop->args[1] = temp_arg(arg_ts->mem_base);
@@ -2619,7 +2617,7 @@ static bool liveness_pass_2(TCGContext *s)
                 TCGOpcode sopc = (arg_ts->type == TCG_TYPE_I32
                                   ? INDEX_op_st_i32
                                   : INDEX_op_st_i64);
-                TCGOp *sop = tcg_op_insert_after(s, op, sopc, 3);
+                TCGOp *sop = tcg_op_insert_after(s, op, sopc);
 
                 sop->args[0] = temp_arg(dir_ts);
                 sop->args[1] = temp_arg(arg_ts->mem_base);
-- 
2.17.1
