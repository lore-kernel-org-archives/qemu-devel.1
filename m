Received: from eggs.gnu.org ([2001:4830:134:3::10]:57558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1eCo2S-0005rW-09
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:42:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1eCo2R-000304-0T
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:42:40 -0500
Received: from bran.ispras.ru ([83.149.199.196]:54554 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1eCo2Q-0002zO-Os
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:42:38 -0500
From: Kirill Batuzov <batuzovk@ispras.ru>
Date: Thu,  9 Nov 2017 17:41:55 +0300
Message-Id: <20171109144155.17076-4-batuzovk@ispras.ru>
In-Reply-To: <20171109144155.17076-1-batuzovk@ispras.ru>
References: <20171109144155.17076-1-batuzovk@ispras.ru>
Subject: [Qemu-devel] [PATCH RFC 3/3] tcg/optimize: handle vector loads and
 stores during copy propagation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kirill Batuzov <batuzovk@ispras.ru>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Kirill Batuzov <batuzovk@ispras.ru>
---
 tcg/optimize.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index da7f069444..1b6962c6c5 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -318,6 +318,8 @@ static TCGOpcode ld_to_mov(TCGOpcode op)
         return INDEX_op_mov_i32;
     case INDEX_op_ld_i64:
         return INDEX_op_mov_i64;
+    case INDEX_op_ld_vec:
+        return INDEX_op_mov_vec;
     default:
         tcg_abort();
     }
@@ -782,6 +784,13 @@ static bool swap_commutative2(TCGArg *p1, TCGArg *p2)
     return false;
 }
 
+static int tcg_vec_size(const TCGOp *op)
+{
+    TCGArg arg = op->args[0];
+    TCGTemp *tmp = arg_temp(arg);
+    return 1 << (3 + tmp->base_type - TCG_TYPE_V64);
+}
+
 static int ldst_size(const TCGOp *op)
 {
     switch (op->opc) {
@@ -802,6 +811,9 @@ static int ldst_size(const TCGOp *op)
     case INDEX_op_st_i64:
     case INDEX_op_ld_i64:
         return 8;
+    case INDEX_op_ld_vec:
+    case INDEX_op_st_vec:
+        return tcg_vec_size(op);
     default:
         /* Some unsupported opcode? */
         tcg_abort();
@@ -1660,6 +1672,7 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(st16):
         CASE_OP_32_64(st):
         case INDEX_op_st32_i64:
+        case INDEX_op_st_vec:
             if (op->args[1] == tcgv_ptr_arg(cpu_env)) {
                 remove_ml_range(op->args[2], ldst_size(op));
                 new_ml(op->args[2], ldst_size(op), arg_temp(op->args[0]));
@@ -1677,6 +1690,7 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(ld):
         case INDEX_op_ld32s_i64:
         case INDEX_op_ld32u_i64:
+        case INDEX_op_ld_vec:
             /* Only loads that are relative to ENV can be handled.  */
             if (op->args[1] == tcgv_ptr_arg(cpu_env)) {
                 ml = find_ml(op->args[2], ldst_size(op),
@@ -1689,6 +1703,14 @@ void tcg_optimize(TCGContext *s)
                         TCGTemp *copy = find_better_copy(s, ml->copy);
                         tcg_opt_gen_mov(s, op, op->args[0], temp_arg(copy));
                         break;
+                    } else if (re == INDEX_op_mov_vec) {
+                        if (ts_are_copies(arg_temp(op->args[0]), ml->copy)) {
+                            tcg_op_remove(s, op);
+                            break;
+                        }
+                        op->opc = re;
+                        op->args[1] = temp_arg(find_better_copy(s, ml->copy));
+                        op->args[2] = op->args[3];
                     } else {
                         if (tcg_op_defs[re].flags & TCG_OPF_NOT_PRESENT) {
                             /* Required operation is not supported by host.  */
-- 
2.11.0
