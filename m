Received: from eggs.gnu.org ([2001:4830:134:3::10]:50885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPkf-00037y-DI
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPke-0003sU-2B
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:25 -0500
Received: from bran.ispras.ru ([83.149.199.196]:50100 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPkd-0003ro-Lo
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:24 -0500
From: Kirill Batuzov <batuzovk@ispras.ru>
Date: Tue, 17 Jan 2017 12:07:44 +0300
Message-Id: <1484644078-21312-5-git-send-email-batuzovk@ispras.ru>
In-Reply-To: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
References: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
Subject: [Qemu-devel] [PATCH 04/18] tcg: add simple alias analysis
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Kirill Batuzov <batuzovk@ispras.ru>

Add a simple alias analysis to TCG which finds out memory loads and stores
that overlap with CPUState. This information can be used later in liveness
analysis to ensure correctness of register allocation. In particular, if load
or store overlaps with memory location of some global variable, this variable
should be spilled and reloaded at appropriate times.

Previously no such analysis was performed and for correctness reasons it was
required that no load/store operations overlap with memory locations of global
variables.

Signed-off-by: Kirill Batuzov <batuzovk@ispras.ru>
---

checkpatch complains here, but I believe this to be false-positive.

---
 tcg/optimize.c | 146 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tcg/tcg.h      |  17 +++++++
 2 files changed, 163 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 0f13490..1d0eac2 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -34,6 +34,7 @@
 
 struct tcg_temp_info {
     bool is_const;
+    bool is_base;
     uint16_t prev_copy;
     uint16_t next_copy;
     tcg_target_ulong val;
@@ -61,6 +62,7 @@ static void reset_temp(TCGArg temp)
     temps[temp].next_copy = temp;
     temps[temp].prev_copy = temp;
     temps[temp].is_const = false;
+    temps[temp].is_base = false;
     temps[temp].mask = -1;
 }
 
@@ -1335,3 +1337,147 @@ void tcg_optimize(TCGContext *s)
         }
     }
 }
+
+/* Simple alias analysis. It finds out which load/store operations overlap
+   with CPUArchState. The result is stored in TCGContext and can be used
+   during liveness analysis and register allocation. */
+void tcg_alias_analysis(TCGContext *s)
+{
+    int oi, oi_next;
+
+    reset_all_temps(s->nb_temps);
+    temps[GET_TCGV_PTR(s->tcg_env)].is_base = true;
+    temps[GET_TCGV_PTR(s->tcg_env)].val = 0;
+
+    for (oi = s->gen_op_buf[0].next; oi != 0; oi = oi_next) {
+        int nb_oargs, i;
+        int size;
+        TCGAliasType tp;
+
+        TCGOp * const op = &s->gen_op_buf[oi];
+        TCGArg * const args = &s->gen_opparam_buf[op->args];
+        TCGOpcode opc = op->opc;
+        const TCGOpDef *def = &tcg_op_defs[opc];
+
+        oi_next = op->next;
+
+        if (opc == INDEX_op_call) {
+            nb_oargs = op->callo;
+        } else {
+            nb_oargs = def->nb_oargs;
+        }
+
+        s->alias_info[oi] = (TCGAliasInfo){
+                TCG_NOT_ALIAS,
+                false,
+                0,
+                0
+            };
+
+        switch (opc) {
+        CASE_OP_32_64(movi):
+            temps[args[0]].is_const = 1;
+            temps[args[0]].val = args[1];
+            break;
+        CASE_OP_32_64(mov):
+            temps[args[0]].is_const = temps[args[1]].is_const;
+            temps[args[0]].is_base = temps[args[1]].is_base;
+            temps[args[0]].val = temps[args[1]].val;
+            break;
+        CASE_OP_32_64(add):
+        CASE_OP_32_64(sub):
+            if (temps[args[1]].is_base && temps[args[2]].is_const) {
+                temps[args[0]].is_base = true;
+                temps[args[0]].is_const = false;
+                temps[args[0]].val =
+                    do_constant_folding(opc, temps[args[1]].val,
+                                        temps[args[2]].val);
+            } else {
+                reset_temp(args[0]);
+            }
+        CASE_OP_32_64(ld8s):
+        CASE_OP_32_64(ld8u):
+            size = 1;
+            tp = TCG_ALIAS_READ;
+            goto do_ldst;
+        CASE_OP_32_64(ld16s):
+        CASE_OP_32_64(ld16u):
+            size = 2;
+            tp = TCG_ALIAS_READ;
+            goto do_ldst;
+        case INDEX_op_ld_i32:
+        case INDEX_op_ld32s_i64:
+        case INDEX_op_ld32u_i64:
+            size = 4;
+            tp = TCG_ALIAS_READ;
+            goto do_ldst;
+        case INDEX_op_ld_i64:
+            size = 8;
+            tp = TCG_ALIAS_READ;
+            goto do_ldst;
+        case INDEX_op_ld_v128:
+            size = 16;
+            tp = TCG_ALIAS_READ;
+            goto do_ldst;
+        CASE_OP_32_64(st8):
+            size = 1;
+            tp = TCG_ALIAS_WRITE;
+            goto do_ldst;
+        CASE_OP_32_64(st16):
+            size = 2;
+            tp = TCG_ALIAS_WRITE;
+            goto do_ldst;
+        case INDEX_op_st_i32:
+        case INDEX_op_st32_i64:
+            size = 4;
+            tp = TCG_ALIAS_WRITE;
+            goto do_ldst;
+        case INDEX_op_st_i64:
+            size = 8;
+            tp = TCG_ALIAS_WRITE;
+            goto do_ldst;
+        case INDEX_op_st_v128:
+            size = 16;
+            tp = TCG_ALIAS_WRITE;
+            goto do_ldst;
+        do_ldst:
+            if (temps[args[1]].is_base) {
+                TCGArg val;
+#if TCG_TARGET_REG_BITS == 32
+                val = do_constant_folding(INDEX_op_add_i32,
+                                          temps[args[1]].val,
+                                          args[2]);
+#else
+                val = do_constant_folding(INDEX_op_add_i64,
+                                          temps[args[1]].val,
+                                          args[2]);
+#endif
+                if ((tcg_target_long)val < sizeof(CPUArchState) &&
+                    (tcg_target_long)val + size > 0) {
+                    s->alias_info[oi].alias_type = tp;
+                    s->alias_info[oi].fixed_offset = true;
+                    s->alias_info[oi].offset = val;
+                    s->alias_info[oi].size = size;
+                } else {
+                    s->alias_info[oi].alias_type = TCG_NOT_ALIAS;
+                }
+            } else {
+                s->alias_info[oi].alias_type = tp;
+                s->alias_info[oi].fixed_offset = false;
+            }
+            goto do_reset_output;
+        default:
+            if (def->flags & TCG_OPF_BB_END) {
+                reset_all_temps(s->nb_temps);
+                temps[GET_TCGV_PTR(s->tcg_env)].is_base = true;
+                temps[GET_TCGV_PTR(s->tcg_env)].val = 0;
+            } else {
+        do_reset_output:
+                for (i = 0; i < nb_oargs; i++) {
+                    reset_temp(args[i]);
+                }
+            }
+            break;
+        }
+    }
+}
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 397ba86..921892f 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -667,6 +667,20 @@ QEMU_BUILD_BUG_ON(OPPARAM_BUF_SIZE > (1 << 14));
 /* Make sure that we don't overflow 64 bits without noticing.  */
 QEMU_BUILD_BUG_ON(sizeof(TCGOp) > 8);
 
+typedef enum TCGAliasType {
+    TCG_NOT_ALIAS = 0,
+    TCG_ALIAS_READ = 1,
+    TCG_ALIAS_WRITE = 2,
+    TCG_ALIAS_RW = TCG_ALIAS_READ | TCG_ALIAS_WRITE
+} TCGAliasType;
+
+typedef struct TCGAliasInfo {
+    TCGAliasType alias_type;
+    bool fixed_offset;
+    tcg_target_long offset;
+    tcg_target_long size;
+} TCGAliasInfo;
+
 struct TCGContext {
     uint8_t *pool_cur, *pool_end;
     TCGPool *pool_first, *pool_current, *pool_first_large;
@@ -751,6 +765,8 @@ struct TCGContext {
     TCGOp gen_op_buf[OPC_BUF_SIZE];
     TCGArg gen_opparam_buf[OPPARAM_BUF_SIZE];
 
+    TCGAliasInfo alias_info[OPC_BUF_SIZE];
+
     uint16_t gen_insn_end_off[TCG_MAX_INSNS];
     target_ulong gen_insn_data[TCG_MAX_INSNS][TARGET_INSN_START_WORDS];
 };
@@ -999,6 +1015,7 @@ TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op, TCGOpcode opc, int narg);
 TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *op, TCGOpcode opc, int narg);
 
 void tcg_optimize(TCGContext *s);
+void tcg_alias_analysis(TCGContext *s);
 
 /* only used for debugging purposes */
 void tcg_dump_ops(TCGContext *s);
-- 
2.1.4
