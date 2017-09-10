Received: from eggs.gnu.org ([2001:4830:134:3::10]:42496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr54y-0008EW-AC
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 12:27:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr54u-0005fB-9Z
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 12:27:28 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:57808)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr54t-0005es-N1
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 12:27:24 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Sun, 10 Sep 2017 19:27:15 +0300
Message-Id: <150506083546.19604.543091497330269756.stgit@frigg.lan>
In-Reply-To: <150505986682.19604.11937392314067517230.stgit@frigg.lan>
References: <150505986682.19604.11937392314067517230.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/7] tcg: Add support for "inlining" regions of
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>

TCG BBLs and instructions have multiple exit points from where to raise
tracing events, but some of the necessary information in the generic
disassembly infrastructure is not available until after generating these
exit points.

This patch adds support for "inline points" (where the tracing code will
be placed), and "inline regions" (which identify the TCG code that must
be inlined). The TCG compiler will basically copy each inline region to
any inline points that reference it.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 include/qemu/log.h      |    1=20
 include/qemu/typedefs.h |    1=20
 tcg/tcg-op.h            |   39 +++++++++++
 tcg/tcg-opc.h           |    3 +
 tcg/tcg.c               |  166 +++++++++++++++++++++++++++++++++++++++++=
++++++
 tcg/tcg.h               |   18 +++++
 util/log.c              |    2 +
 7 files changed, 230 insertions(+)

diff --git a/include/qemu/log.h b/include/qemu/log.h
index a50e994c21..23acc63c73 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -43,6 +43,7 @@ static inline bool qemu_log_separate(void)
 #define CPU_LOG_PAGE       (1 << 14)
 #define LOG_TRACE          (1 << 15)
 #define CPU_LOG_TB_OP_IND  (1 << 16)
+#define CPU_LOG_TB_OP_INLINE (1 << 17)
=20
 /* Returns true if a bit is set in the current loglevel mask
  */
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 39bc8351a3..2fb5670af3 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -96,6 +96,7 @@ typedef struct SerialState SerialState;
 typedef struct SHPCDevice SHPCDevice;
 typedef struct SMBusDevice SMBusDevice;
 typedef struct SSIBus SSIBus;
+typedef struct TCGInlineLabel TCGInlineLabel;
 typedef struct uWireSlave uWireSlave;
 typedef struct VirtIODevice VirtIODevice;
 typedef struct Visitor Visitor;
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 5d3278f243..da3784f8f2 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -326,6 +326,45 @@ void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
=20
+static inline int _get_inline_index(TCGInlineLabel *l)
+{
+    TCGContext *s =3D &tcg_ctx;
+    return l - s->inline_labels;
+}
+
+static inline void gen_set_inline_point(TCGInlineLabel *l)
+{
+    TCGContext *s =3D &tcg_ctx;
+    TCGInlinePoint *p =3D tcg_malloc(sizeof(TCGInlinePoint));
+    p->op_idx =3D s->gen_next_op_idx;
+    p->next_point =3D l->first_point;
+    l->first_point =3D p;
+    tcg_gen_op1i(INDEX_op_set_inline_point,
+                 _get_inline_index(l));
+}
+
+static inline void gen_set_inline_region_begin(TCGInlineLabel *l)
+{
+    TCGContext *s =3D &tcg_ctx;
+    if (l->begin_op_idx !=3D -1) {
+        tcg_abort();
+    }
+    l->begin_op_idx =3D s->gen_next_op_idx;
+    tcg_gen_op1i(INDEX_op_set_inline_region_begin,
+                 _get_inline_index(l));
+}
+
+static inline void gen_set_inline_region_end(TCGInlineLabel *l)
+{
+    TCGContext *s =3D &tcg_ctx;
+    if (l->begin_op_idx =3D=3D -1) {
+        tcg_abort();
+    }
+    l->end_op_idx =3D s->gen_next_op_idx;
+    tcg_gen_op1i(INDEX_op_set_inline_region_end,
+                 _get_inline_index(l));
+}
+
 static inline void tcg_gen_discard_i32(TCGv_i32 arg)
 {
     tcg_gen_op1_i32(INDEX_op_discard, arg);
diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index 956fb1e9f3..279ac0dc1f 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -29,6 +29,9 @@
 /* predefined ops */
 DEF(discard, 1, 0, 0, TCG_OPF_NOT_PRESENT)
 DEF(set_label, 0, 0, 1, TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
+DEF(set_inline_point, 0, 0, 1, TCG_OPF_NOT_PRESENT)
+DEF(set_inline_region_begin, 0, 0, 1, TCG_OPF_NOT_PRESENT)
+DEF(set_inline_region_end, 0, 0, 1, TCG_OPF_NOT_PRESENT)
=20
 /* variable number of parameters */
 DEF(call, 0, 0, 3, TCG_OPF_CALL_CLOBBER | TCG_OPF_NOT_PRESENT)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index fd8a3dfe93..b48196da27 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -251,6 +251,23 @@ TCGLabel *gen_new_label(void)
     return l;
 }
=20
+TCGInlineLabel *gen_new_inline_label(void)
+{
+    TCGContext *s =3D &tcg_ctx;
+    int idx;
+    TCGInlineLabel *l;
+
+    if (s->nb_inline_labels >=3D TCG_MAX_INLINE_LABELS) {
+        tcg_abort();
+    }
+    idx =3D s->nb_inline_labels++;
+    l =3D &s->inline_labels[idx];
+    l->first_point =3D NULL;
+    l->begin_op_idx =3D -1;
+    l->end_op_idx =3D -1;
+    return l;
+}
+
 #include "tcg-target.inc.c"
=20
 /* pool based memory allocation */
@@ -462,6 +479,10 @@ void tcg_func_start(TCGContext *s)
     s->nb_labels =3D 0;
     s->current_frame_offset =3D s->frame_start;
=20
+    s->inline_labels =3D tcg_malloc(sizeof(TCGInlineLabel) *
+                                  TCG_MAX_INLINE_LABELS);
+    s->nb_inline_labels =3D 0;
+
 #ifdef CONFIG_DEBUG_TCG
     s->goto_tb_issue_mask =3D 0;
 #endif
@@ -1423,6 +1444,139 @@ static inline void tcg_la_bb_end(TCGContext *s, u=
int8_t *temp_state)
     }
 }
=20
+static inline int _get_op_next(TCGContext *s, int idx)
+{
+    return s->gen_op_buf[idx].next;
+}
+
+static inline void _set_op_next(TCGContext *s, int idx, int next)
+{
+    s->gen_op_buf[idx].next =3D next;
+}
+
+static inline int _get_op_prev(TCGContext *s, int idx)
+{
+    return s->gen_op_buf[idx].prev;
+}
+
+static inline void _set_op_prev(TCGContext *s, int idx, int prev)
+{
+    s->gen_op_buf[idx].prev =3D prev;
+}
+
+static inline void _inline_region_ignore(TCGContext *s, TCGInlineLabel *=
l)
+{
+    int l_prev =3D _get_op_prev(s, l->begin_op_idx);
+    int l_next =3D _get_op_next(s, l->end_op_idx);
+    _set_op_next(s, l_prev, l_next);
+    _set_op_prev(s, l_next, l_prev);
+}
+
+static inline void _op_ignore(TCGContext *s, int op_idx)
+{
+    int p_prev =3D _get_op_prev(s, op_idx);
+    int p_next =3D _get_op_next(s, op_idx);
+    _set_op_next(s, p_prev, p_next);
+    _set_op_prev(s, p_next, p_prev);
+}
+
+static inline void _inline_point_ignore(TCGContext *s, TCGInlinePoint *p=
)
+{
+    _op_ignore(s, p->op_idx);
+}
+
+static inline void _inline_weave(TCGContext *s, TCGInlinePoint *p,
+                                 int begin, int end)
+{
+    int begin_prev =3D _get_op_prev(s, begin);
+    int end_next =3D _get_op_next(s, end);
+    int p_prev =3D _get_op_prev(s, p->op_idx);
+    int p_next =3D _get_op_next(s, p->op_idx);
+    /* point.prev -> begin */
+    _set_op_next(s, p_prev, begin);
+    _set_op_prev(s, begin, p_prev);
+    /* end -> point.next */
+    _set_op_next(s, end, p_next);
+    _set_op_prev(s, p_next, end);
+    /* begin.prev -> end.next */
+    _set_op_next(s, begin_prev, end_next);
+    _set_op_prev(s, end_next, begin_prev);
+}
+
+/*
+ * Handles inline_set_label/inline_region_begin/inline_region_end opcode=
s (which
+ * will disappear after this optimization).
+ */
+static void tcg_inline(TCGContext *s)
+{
+    int i;
+    for (i =3D 0; i < s->nb_inline_labels; i++) {
+        TCGInlineLabel *l =3D &s->inline_labels[i];
+        size_t region_op_count =3D l->end_op_idx - l->begin_op_idx - 1;
+
+        /* open region is an error */
+        if (l->begin_op_idx !=3D -1 && l->end_op_idx =3D=3D -1) {
+            tcg_abort();
+        }
+
+        if (l->first_point =3D=3D NULL) {   /* region without points  */
+            _inline_region_ignore(s, l);
+        } else if (l->begin_op_idx =3D=3D -1) { /* points without region=
 */
+            TCGInlinePoint *p;
+            for (p =3D l->first_point; p !=3D NULL; p =3D p->next_point)=
 {
+                _inline_point_ignore(s, p);
+            }
+        } else if (region_op_count =3D=3D 0) { /* empty region */
+            TCGInlinePoint *p;
+            for (p =3D l->first_point; p !=3D NULL; p =3D p->next_point)=
 {
+                _inline_point_ignore(s, p);
+            }
+            _inline_region_ignore(s, l);
+        } else {                        /* actual inlining */
+            bool first_point =3D true;
+            int l_begin =3D _get_op_next(s, l->begin_op_idx);
+            int l_end =3D _get_op_prev(s, l->end_op_idx);
+            TCGInlinePoint *p;
+            for (p =3D l->first_point; p !=3D NULL; p =3D p->next_point)=
 {
+                if (first_point) {
+                    /* redirect point to existing region (skip markers) =
*/
+                    _inline_weave(s, p, l_begin, l_end);
+                    _op_ignore(s, l->begin_op_idx);
+                    _op_ignore(s, l->end_op_idx);
+                } else {
+                    /* create a copy of the region */
+                    int l_end_next =3D _get_op_next(s, l_end);
+                    int op;
+                    int pos =3D p->op_idx;
+                    for (op =3D l_begin; op !=3D l_end_next;
+                         op =3D _get_op_next(s, op)) {
+                        /* insert opcode copies */
+                        int insert_idx =3D s->gen_next_op_idx;
+                        int opc =3D s->gen_op_buf[op].opc;
+                        int args =3D s->gen_op_buf[op].args;
+                        int nargs =3D tcg_op_defs[opc].nb_args;
+                        if (opc =3D=3D INDEX_op_call) {
+                            nargs +=3D s->gen_op_buf[op].calli;
+                            nargs +=3D s->gen_op_buf[op].callo;
+                        }
+                        tcg_op_insert_after(s, &s->gen_op_buf[pos], opc,=
 nargs);
+                        pos =3D insert_idx;
+                        s->gen_op_buf[pos].calli =3D s->gen_op_buf[op].c=
alli;
+                        s->gen_op_buf[pos].callo =3D s->gen_op_buf[op].c=
allo;
+                        /* insert argument copies */
+                        memcpy(&s->gen_opparam_buf[s->gen_op_buf[pos].ar=
gs],
+                               &s->gen_opparam_buf[args],
+                               nargs * sizeof(s->gen_opparam_buf[0]));
+                    }
+                    _op_ignore(s, p->op_idx);
+                }
+                first_point =3D false;
+            }
+        }
+    }
+}
+
+
 /* Liveness analysis : update the opc_arg_life array to tell if a
    given input arguments is dead. Instructions updating dead
    temporaries are removed. */
@@ -2560,6 +2714,18 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *=
tb)
     }
 #endif
=20
+    /* inline code regions before any optimization pass */
+    tcg_inline(s);
+
+#ifdef DEBUG_DISAS
+    if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP_INLINE)
+                 && qemu_log_in_addr_range(tb->pc))) {
+        qemu_log("OP after inline:\n");
+        tcg_dump_ops(s);
+        qemu_log("\n");
+    }
+#endif
+
 #ifdef CONFIG_PROFILER
     s->opt_time -=3D profile_getclock();
 #endif
diff --git a/tcg/tcg.h b/tcg/tcg.h
index ac94133870..c6e3c6e68d 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -397,6 +397,20 @@ static inline unsigned get_alignment_bits(TCGMemOp m=
emop)
=20
 typedef tcg_target_ulong TCGArg;
=20
+#define TCG_MAX_INLINE_REGIONS 1
+#define TCG_MAX_INLINE_LABELS TCG_MAX_INLINE_REGIONS
+
+typedef struct TCGInlinePoint {
+    int op_idx;
+    struct TCGInlinePoint *next_point;
+} TCGInlinePoint;
+
+typedef struct TCGInlineLabel {
+    TCGInlinePoint *first_point;
+    int begin_op_idx, end_op_idx;
+} TCGInlineLabel;
+
+
 /* Define type and accessor macros for TCG variables.
=20
    TCG variables are the inputs and outputs of TCG ops, as described
@@ -649,6 +663,9 @@ struct TCGContext {
     int nb_temps;
     int nb_indirects;
=20
+    TCGInlineLabel *inline_labels;
+    int nb_inline_labels;
+
     /* goto_tb support */
     tcg_insn_unit *code_buf;
     uint16_t *tb_jmp_reset_offset; /* tb->jmp_reset_offset */
@@ -950,6 +967,7 @@ TCGv_i32 tcg_const_local_i32(int32_t val);
 TCGv_i64 tcg_const_local_i64(int64_t val);
=20
 TCGLabel *gen_new_label(void);
+TCGInlineLabel *gen_new_inline_label(void);
=20
 /**
  * label_arg
diff --git a/util/log.c b/util/log.c
index 96f30dd21a..947a982c74 100644
--- a/util/log.c
+++ b/util/log.c
@@ -246,6 +246,8 @@ const QEMULogItem qemu_log_items[] =3D {
       "show target assembly code for each compiled TB" },
     { CPU_LOG_TB_OP, "op",
       "show micro ops for each compiled TB" },
+    { CPU_LOG_TB_OP_INLINE, "op_inline",
+      "show micro ops after inlining" },
     { CPU_LOG_TB_OP_OPT, "op_opt",
       "show micro ops after optimization" },
     { CPU_LOG_TB_OP_IND, "op_ind",
