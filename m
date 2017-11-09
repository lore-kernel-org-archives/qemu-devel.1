Received: from eggs.gnu.org ([2001:4830:134:3::10]:57515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1eCo2O-0005os-Ua
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:42:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1eCo2M-0002vf-0W
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:42:37 -0500
Received: from bran.ispras.ru ([83.149.199.196]:54493 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1eCo2L-0002vH-GO
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:42:33 -0500
From: Kirill Batuzov <batuzovk@ispras.ru>
Date: Thu,  9 Nov 2017 17:41:54 +0300
Message-Id: <20171109144155.17076-3-batuzovk@ispras.ru>
In-Reply-To: <20171109144155.17076-1-batuzovk@ispras.ru>
References: <20171109144155.17076-1-batuzovk@ispras.ru>
Subject: [Qemu-devel] [PATCH RFC 2/3] tcg/optimize: do copy propagation for
 memory locations
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

During copy propagation phase, keep track of memory locations that store value
of a known live variable. Only memory locations that are addressed relative to
ENV are accounted. Any other access types are handled conservatively.

When a load is encountered, source memory location is checked against list of
known memory locations. If its content is a copy of some variable, then MOV or
EXT from this variable is issued instead of load. This allows us to keep values
of some CPUState fields that are not represented by global variables on host
registers during computations involving them.

Signed-off-by: Kirill Batuzov <batuzovk@ispras.ru>
---
 tcg/optimize.c | 266 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 266 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 847dfa44c9..da7f069444 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -38,8 +38,28 @@ struct tcg_temp_info {
     TCGTemp *next_copy;
     tcg_target_ulong val;
     tcg_target_ulong mask;
+    struct TCGMemLocation *mem_loc;
 };
 
+typedef struct TCGMemLocation {
+    /* Offset is relative to ENV. Only fields of CPUState are accounted.  */
+    tcg_target_ulong offset;
+    tcg_target_ulong size;
+    TCGType type;
+    /* Pointer to a temp containing a valid copy of this memory location.  */
+    TCGTemp *copy;
+    /* Pointer to the next memory location containing copy of the same
+       content.  */
+    struct TCGMemLocation *next_copy;
+
+    /* Double-linked list of all memory locations.  */
+    struct TCGMemLocation *next;
+    struct TCGMemLocation **prev_ptr;
+} TCGMemLocation;
+
+struct TCGMemLocation *mem_locations;
+struct TCGMemLocation *free_mls;
+
 static inline struct tcg_temp_info *ts_info(TCGTemp *ts)
 {
     return ts->state_ptr;
@@ -70,6 +90,34 @@ static inline bool arg_is_copy(TCGArg arg)
     return ts_is_copy(arg_temp(arg));
 }
 
+/* Reset MEMORY LOCATION state. */
+static void reset_ml(TCGMemLocation *ml)
+{
+    if (!ml) {
+        return ;
+    }
+    if (ml->copy) {
+        TCGMemLocation **prev_ptr = &ts_info(ml->copy)->mem_loc;
+        TCGMemLocation *cur_ptr = ts_info(ml->copy)->mem_loc;
+        while (cur_ptr && cur_ptr != ml) {
+            prev_ptr = &cur_ptr->next_copy;
+            cur_ptr = cur_ptr->next_copy;
+        }
+        *prev_ptr = ml->next_copy;
+        if (ts_info(ml->copy)->mem_loc == ml) {
+            ts_info(ml->copy)->mem_loc = ml->next_copy;
+        }
+    }
+
+    *ml->prev_ptr = ml->next;
+    if (ml->next) {
+        ml->next->prev_ptr = ml->prev_ptr;
+    }
+    ml->prev_ptr = NULL;
+    ml->next = free_mls;
+    free_mls = ml;
+}
+
 /* Reset TEMP's state, possibly removing the temp for the list of copies.  */
 static void reset_ts(TCGTemp *ts)
 {
@@ -77,12 +125,27 @@ static void reset_ts(TCGTemp *ts)
     struct tcg_temp_info *pi = ts_info(ti->prev_copy);
     struct tcg_temp_info *ni = ts_info(ti->next_copy);
 
+    if (ti->mem_loc && ts_is_copy(ts) && 0) {
+        TCGMemLocation *ml, *nml;
+        for (ml = ti->mem_loc; ml; ml = nml) {
+            nml = ml->next_copy;
+            ml->copy = ti->next_copy;
+            ml->next_copy = ni->mem_loc;
+            ni->mem_loc = ml;
+        }
+    } else {
+        while (ti->mem_loc) {
+            reset_ml(ti->mem_loc);
+        }
+    }
+
     ni->prev_copy = ti->prev_copy;
     pi->next_copy = ti->next_copy;
     ti->next_copy = ts;
     ti->prev_copy = ts;
     ti->is_const = false;
     ti->mask = -1;
+    ti->mem_loc = NULL;
 }
 
 static void reset_temp(TCGArg arg)
@@ -103,6 +166,7 @@ static void init_ts_info(struct tcg_temp_info *infos,
         ti->prev_copy = ts;
         ti->is_const = false;
         ti->mask = -1;
+        ti->mem_loc = NULL;
         set_bit(idx, temps_used->l);
     }
 }
@@ -119,6 +183,92 @@ static int op_bits(TCGOpcode op)
     return def->flags & TCG_OPF_64BIT ? 64 : 32;
 }
 
+/* Allocate a new MEMORY LOCATION of reuse a free one.  */
+static TCGMemLocation *alloc_ml(void)
+{
+    if (free_mls) {
+        TCGMemLocation *ml = free_mls;
+        free_mls = free_mls->next;
+        return ml;
+    }
+    return tcg_malloc(sizeof(TCGMemLocation));
+}
+
+/* Allocate and initialize MEMORY LOCATION.  */
+static TCGMemLocation *new_ml(tcg_target_ulong off, tcg_target_ulong sz,
+                              TCGTemp *copy)
+{
+    TCGMemLocation *ml = alloc_ml();
+
+    ml->offset = off;
+    ml->size = sz;
+    ml->copy = copy;
+    if (copy) {
+        ml->type = copy->base_type;
+        ml->next_copy = ts_info(copy)->mem_loc;
+        ts_info(copy)->mem_loc = ml;
+    } else {
+        tcg_abort();
+    }
+    ml->next = mem_locations;
+    if (ml->next) {
+        ml->next->prev_ptr = &ml->next;
+    }
+    ml->prev_ptr = &mem_locations;
+    mem_locations = ml;
+    return ml;
+}
+
+static TCGMemLocation *find_ml(tcg_target_ulong off, tcg_target_ulong sz,
+                               TCGType type)
+{
+    TCGMemLocation *mi;
+    for (mi = mem_locations; mi; mi = mi->next) {
+        if (mi->offset == off && mi->size == sz && mi->type == type) {
+            return mi;
+        }
+    }
+    return NULL;
+}
+
+static bool range_intersect(tcg_target_ulong off1, tcg_target_ulong sz1,
+                            tcg_target_ulong off2, tcg_target_ulong sz2)
+{
+    if (off1 + sz1 <= off2) {
+        return false;
+    }
+    if (off2 + sz2 <= off1) {
+        return false;
+    }
+    return true;
+}
+
+static void remove_ml_range(tcg_target_ulong off, tcg_target_ulong sz)
+{
+    TCGMemLocation *mi, *next;
+    for (mi = mem_locations; mi; mi = next) {
+        next = mi->next;
+        if (range_intersect(mi->offset, mi->size, off, sz)) {
+            reset_ml(mi);
+        }
+    }
+}
+
+static void reset_all_ml(void)
+{
+    TCGMemLocation *ml, *nml;
+    for (ml = mem_locations; ml; ml = nml) {
+        nml = ml->next;
+        if (ml->copy) {
+            ts_info(ml->copy)->mem_loc = NULL;
+        }
+        ml->next = free_mls;
+        ml->copy = NULL;
+        free_mls = ml;
+    }
+    mem_locations = NULL;
+}
+
 static TCGOpcode op_to_mov(TCGOpcode op)
 {
     switch (op_bits(op)) {
@@ -147,6 +297,34 @@ static TCGOpcode op_to_movi(TCGOpcode op)
     }
 }
 
+static TCGOpcode ld_to_mov(TCGOpcode op)
+{
+#define LD_TO_EXT(sz, w)                                 \
+    case glue(glue(INDEX_op_ld, sz), glue(_i, w)):       \
+        return glue(glue(INDEX_op_ext, sz), glue(_i, w))
+
+    switch (op) {
+    LD_TO_EXT(8s, 32);
+    LD_TO_EXT(8u, 32);
+    LD_TO_EXT(16s, 32);
+    LD_TO_EXT(16u, 32);
+    LD_TO_EXT(8s, 64);
+    LD_TO_EXT(8u, 64);
+    LD_TO_EXT(16s, 64);
+    LD_TO_EXT(16u, 64);
+    LD_TO_EXT(32s, 64);
+    LD_TO_EXT(32u, 64);
+    case INDEX_op_ld_i32:
+        return INDEX_op_mov_i32;
+    case INDEX_op_ld_i64:
+        return INDEX_op_mov_i64;
+    default:
+        tcg_abort();
+    }
+
+#undef LD_TO_EXT
+}
+
 static TCGTemp *find_better_copy(TCGContext *s, TCGTemp *ts)
 {
     TCGTemp *i;
@@ -604,6 +782,32 @@ static bool swap_commutative2(TCGArg *p1, TCGArg *p2)
     return false;
 }
 
+static int ldst_size(const TCGOp *op)
+{
+    switch (op->opc) {
+    CASE_OP_32_64(st8):
+    CASE_OP_32_64(ld8u):
+    CASE_OP_32_64(ld8s):
+        return 1;
+    CASE_OP_32_64(st16):
+    CASE_OP_32_64(ld16u):
+    CASE_OP_32_64(ld16s):
+        return 2;
+    case INDEX_op_st32_i64:
+    case INDEX_op_ld32u_i64:
+    case INDEX_op_ld32s_i64:
+    case INDEX_op_st_i32:
+    case INDEX_op_ld_i32:
+        return 4;
+    case INDEX_op_st_i64:
+    case INDEX_op_ld_i64:
+        return 8;
+    default:
+        /* Some unsupported opcode? */
+        tcg_abort();
+    }
+}
+
 /* Propagate constants and copies, fold constant expressions. */
 void tcg_optimize(TCGContext *s)
 {
@@ -611,6 +815,10 @@ void tcg_optimize(TCGContext *s)
     TCGOp *prev_mb = NULL;
     struct tcg_temp_info *infos;
     TCGTempSet temps_used;
+    TCGMemLocation *ml;
+
+    mem_locations = NULL;
+    free_mls = NULL;
 
     /* Array VALS has an element for each temp.
        If this temp holds a constant then its value is kept in VALS' element.
@@ -644,6 +852,9 @@ void tcg_optimize(TCGContext *s)
                     init_ts_info(infos, &temps_used, ts);
                 }
             }
+            if (!(op->args[nb_oargs + nb_iargs + 1] & TCG_CALL_NO_SE)) {
+                reset_all_ml();
+            }
         } else {
             nb_oargs = def->nb_oargs;
             nb_iargs = def->nb_iargs;
@@ -660,6 +871,10 @@ void tcg_optimize(TCGContext *s)
             }
         }
 
+        if (def->flags & TCG_OPF_BB_END) {
+            reset_all_ml();
+        }
+
         /* For commutative operations make constant second argument */
         switch (opc) {
         CASE_OP_32_64(add):
@@ -1441,6 +1656,57 @@ void tcg_optimize(TCGContext *s)
             }
             break;
 
+        CASE_OP_32_64(st8):
+        CASE_OP_32_64(st16):
+        CASE_OP_32_64(st):
+        case INDEX_op_st32_i64:
+            if (op->args[1] == tcgv_ptr_arg(cpu_env)) {
+                remove_ml_range(op->args[2], ldst_size(op));
+                new_ml(op->args[2], ldst_size(op), arg_temp(op->args[0]));
+            } else {
+                /* Store to an unknown location.  Any of the exisitng
+                   locations could be affected.  Reset them all.  */
+                reset_all_ml();
+            }
+            goto do_default;
+
+        CASE_OP_32_64(ld8u):
+        CASE_OP_32_64(ld8s):
+        CASE_OP_32_64(ld16u):
+        CASE_OP_32_64(ld16s):
+        CASE_OP_32_64(ld):
+        case INDEX_op_ld32s_i64:
+        case INDEX_op_ld32u_i64:
+            /* Only loads that are relative to ENV can be handled.  */
+            if (op->args[1] == tcgv_ptr_arg(cpu_env)) {
+                ml = find_ml(op->args[2], ldst_size(op),
+                             arg_temp(op->args[0])->base_type);
+                if (ml && ml->copy) {
+                    TCGOpcode re = ld_to_mov(opc);
+                    if (re == INDEX_op_mov_i32 || re == INDEX_op_mov_i64) {
+                        /* No sign/zero extension needed. OP is a move.
+                           Handle this case separately to track copies.  */
+                        TCGTemp *copy = find_better_copy(s, ml->copy);
+                        tcg_opt_gen_mov(s, op, op->args[0], temp_arg(copy));
+                        break;
+                    } else {
+                        if (tcg_op_defs[re].flags & TCG_OPF_NOT_PRESENT) {
+                            /* Required operation is not supported by host.  */
+                            goto do_default;
+                        }
+                        op->opc = re;
+                        op->args[1] = temp_arg(find_better_copy(s, ml->copy));
+                    }
+                } else {
+                    assert(!ml);
+                    reset_temp(op->args[0]);
+                    arg_info(op->args[0])->mask = mask;
+                    new_ml(op->args[2], ldst_size(op), arg_temp(op->args[0]));
+                    break;
+                }
+            }
+            goto do_reset_output;
+
         case INDEX_op_call:
             if (!(op->args[nb_oargs + nb_iargs + 1]
                   & (TCG_CALL_NO_READ_GLOBALS | TCG_CALL_NO_WRITE_GLOBALS))) {
-- 
2.11.0
