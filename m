Received: from eggs.gnu.org ([2001:4830:134:3::10]:46135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I72-0000LX-6x
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I70-0000H8-Ie
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:36 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:55774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7I70-0000GD-8e
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:34 -0400
Received: by mail-wm0-x243.google.com with SMTP id u138so626512wmu.4
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 02:36:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 11:35:28 +0200
Message-Id: <20171025093535.10175-45-richard.henderson@linaro.org>
In-Reply-To: <20171025093535.10175-1-richard.henderson@linaro.org>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 44/51] tcg: distribute profiling counters across
 TCGContext's
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

This is groundwork for supporting multiple TCG contexts.

To avoid scalability issues when profiling info is enabled, this patch
makes the profiling info counters distributed via the following changes:

1) Consolidate profile info into its own struct, TCGProfile, which
   TCGContext also includes. Note that tcg_table_op_count is brought
   into TCGProfile after dropping the tcg_ prefix.
2) Iterate over the TCG contexts in the system to obtain the total counts.

This change also requires updating the accessors to TCGProfile fields to
use atomic_read/set whenever there may be conflicting accesses (as defined
in C11) to them.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.h                 |  38 +++++++++-------
 accel/tcg/translate-all.c |  23 +++++-----
 tcg/tcg.c                 | 110 ++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 126 insertions(+), 45 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index cca85b4d85..4b9958a179 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -599,6 +599,26 @@ QEMU_BUILD_BUG_ON(sizeof(TCGOp) != 8 + sizeof(TCGArg) * MAX_OPC_PARAM);
 QEMU_BUILD_BUG_ON(NB_OPS > (1 << 8));
 QEMU_BUILD_BUG_ON(OPC_BUF_SIZE > (1 << 16));
 
+typedef struct TCGProfile {
+    int64_t tb_count1;
+    int64_t tb_count;
+    int64_t op_count; /* total insn count */
+    int op_count_max; /* max insn per TB */
+    int64_t temp_count;
+    int temp_count_max;
+    int64_t del_op_count;
+    int64_t code_in_len;
+    int64_t code_out_len;
+    int64_t search_out_len;
+    int64_t interm_time;
+    int64_t code_time;
+    int64_t la_time;
+    int64_t opt_time;
+    int64_t restore_count;
+    int64_t restore_time;
+    int64_t table_op_count[NB_OPS];
+} TCGProfile;
+
 struct TCGContext {
     uint8_t *pool_cur, *pool_end;
     TCGPool *pool_first, *pool_current, *pool_first_large;
@@ -623,23 +643,7 @@ struct TCGContext {
     tcg_insn_unit *code_ptr;
 
 #ifdef CONFIG_PROFILER
-    /* profiling info */
-    int64_t tb_count1;
-    int64_t tb_count;
-    int64_t op_count; /* total insn count */
-    int op_count_max; /* max insn per TB */
-    int64_t temp_count;
-    int temp_count_max;
-    int64_t del_op_count;
-    int64_t code_in_len;
-    int64_t code_out_len;
-    int64_t search_out_len;
-    int64_t interm_time;
-    int64_t code_time;
-    int64_t la_time;
-    int64_t opt_time;
-    int64_t restore_count;
-    int64_t restore_time;
+    TCGProfile prof;
 #endif
 
 #ifdef CONFIG_DEBUG_TCG
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 7cd9ad5f9c..78c150af3e 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -310,6 +310,7 @@ static int cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
     uint8_t *p = tb->tc.ptr + tb->tc.size;
     int i, j, num_insns = tb->icount;
 #ifdef CONFIG_PROFILER
+    TCGProfile *prof = &tcg_ctx->prof;
     int64_t ti = profile_getclock();
 #endif
 
@@ -344,8 +345,9 @@ static int cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
     restore_state_to_opc(env, tb, data);
 
 #ifdef CONFIG_PROFILER
-    tcg_ctx->restore_time += profile_getclock() - ti;
-    tcg_ctx->restore_count++;
+    atomic_set(&prof->restore_time,
+                prof->restore_time + profile_getclock() - ti);
+    atomic_set(&prof->restore_count, prof->restore_count + 1);
 #endif
     return 0;
 }
@@ -1300,6 +1302,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tcg_insn_unit *gen_code_buf;
     int gen_code_size, search_size;
 #ifdef CONFIG_PROFILER
+    TCGProfile *prof = &tcg_ctx->prof;
     int64_t ti;
 #endif
     assert_memory_lock();
@@ -1327,8 +1330,8 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tcg_ctx->tb_cflags = cflags;
 
 #ifdef CONFIG_PROFILER
-    tcg_ctx->tb_count1++; /* includes aborted translations because of
-                       exceptions */
+    /* includes aborted translations because of exceptions */
+    atomic_set(&prof->tb_count1, prof->tb_count1 + 1);
     ti = profile_getclock();
 #endif
 
@@ -1353,8 +1356,8 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     }
 
 #ifdef CONFIG_PROFILER
-    tcg_ctx->tb_count++;
-    tcg_ctx->interm_time += profile_getclock() - ti;
+    atomic_set(&prof->tb_count, prof->tb_count + 1);
+    atomic_set(&prof->interm_time, prof->interm_time + profile_getclock() - ti);
     ti = profile_getclock();
 #endif
 
@@ -1374,10 +1377,10 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb->tc.size = gen_code_size;
 
 #ifdef CONFIG_PROFILER
-    tcg_ctx->code_time += profile_getclock() - ti;
-    tcg_ctx->code_in_len += tb->size;
-    tcg_ctx->code_out_len += gen_code_size;
-    tcg_ctx->search_out_len += search_size;
+    atomic_set(&prof->code_time, prof->code_time + profile_getclock() - ti);
+    atomic_set(&prof->code_in_len, prof->code_in_len + tb->size);
+    atomic_set(&prof->code_out_len, prof->code_out_len + gen_code_size);
+    atomic_set(&prof->search_out_len, prof->search_out_len + search_size);
 #endif
 
 #ifdef DEBUG_DISAS
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 24ef6df6b5..f1bbfe37ff 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1547,7 +1547,7 @@ void tcg_op_remove(TCGContext *s, TCGOp *op)
     memset(op, 0, sizeof(*op));
 
 #ifdef CONFIG_PROFILER
-    s->del_op_count++;
+    atomic_set(&s->prof.del_op_count, s->prof.del_op_count + 1);
 #endif
 }
 
@@ -2715,15 +2715,79 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
 
 #ifdef CONFIG_PROFILER
 
-static int64_t tcg_table_op_count[NB_OPS];
+/* avoid copy/paste errors */
+#define PROF_ADD(to, from, field)                       \
+    do {                                                \
+        (to)->field += atomic_read(&((from)->field));   \
+    } while (0)
+
+#define PROF_MAX(to, from, field)                                       \
+    do {                                                                \
+        typeof((from)->field) val__ = atomic_read(&((from)->field));    \
+        if (val__ > (to)->field) {                                      \
+            (to)->field = val__;                                        \
+        }                                                               \
+    } while (0)
+
+/* Pass in a zero'ed @prof */
+static inline
+void tcg_profile_snapshot(TCGProfile *prof, bool counters, bool table)
+{
+    unsigned int i;
+
+    for (i = 0; i < n_tcg_ctxs; i++) {
+        const TCGProfile *orig = &tcg_ctxs[i]->prof;
+
+        if (counters) {
+            PROF_ADD(prof, orig, tb_count1);
+            PROF_ADD(prof, orig, tb_count);
+            PROF_ADD(prof, orig, op_count);
+            PROF_MAX(prof, orig, op_count_max);
+            PROF_ADD(prof, orig, temp_count);
+            PROF_MAX(prof, orig, temp_count_max);
+            PROF_ADD(prof, orig, del_op_count);
+            PROF_ADD(prof, orig, code_in_len);
+            PROF_ADD(prof, orig, code_out_len);
+            PROF_ADD(prof, orig, search_out_len);
+            PROF_ADD(prof, orig, interm_time);
+            PROF_ADD(prof, orig, code_time);
+            PROF_ADD(prof, orig, la_time);
+            PROF_ADD(prof, orig, opt_time);
+            PROF_ADD(prof, orig, restore_count);
+            PROF_ADD(prof, orig, restore_time);
+        }
+        if (table) {
+            int i;
+
+            for (i = 0; i < NB_OPS; i++) {
+                PROF_ADD(prof, orig, table_op_count[i]);
+            }
+        }
+    }
+}
+
+#undef PROF_ADD
+#undef PROF_MAX
+
+static void tcg_profile_snapshot_counters(TCGProfile *prof)
+{
+    tcg_profile_snapshot(prof, true, false);
+}
+
+static void tcg_profile_snapshot_table(TCGProfile *prof)
+{
+    tcg_profile_snapshot(prof, false, true);
+}
 
 void tcg_dump_op_count(FILE *f, fprintf_function cpu_fprintf)
 {
+    TCGProfile prof = {};
     int i;
 
+    tcg_profile_snapshot_table(&prof);
     for (i = 0; i < NB_OPS; i++) {
         cpu_fprintf(f, "%s %" PRId64 "\n", tcg_op_defs[i].name,
-                    tcg_table_op_count[i]);
+                    prof.table_op_count[i]);
     }
 }
 #else
@@ -2736,6 +2800,9 @@ void tcg_dump_op_count(FILE *f, fprintf_function cpu_fprintf)
 
 int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
 {
+#ifdef CONFIG_PROFILER
+    TCGProfile *prof = &s->prof;
+#endif
     int i, oi, oi_next, num_insns;
 
 #ifdef CONFIG_PROFILER
@@ -2743,15 +2810,15 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
         int n;
 
         n = s->gen_op_buf[0].prev + 1;
-        s->op_count += n;
-        if (n > s->op_count_max) {
-            s->op_count_max = n;
+        atomic_set(&prof->op_count, prof->op_count + n);
+        if (n > prof->op_count_max) {
+            atomic_set(&prof->op_count_max, n);
         }
 
         n = s->nb_temps;
-        s->temp_count += n;
-        if (n > s->temp_count_max) {
-            s->temp_count_max = n;
+        atomic_set(&prof->temp_count, prof->temp_count + n);
+        if (n > prof->temp_count_max) {
+            atomic_set(&prof->temp_count_max, n);
         }
     }
 #endif
@@ -2768,7 +2835,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
 #endif
 
 #ifdef CONFIG_PROFILER
-    s->opt_time -= profile_getclock();
+    atomic_set(&prof->opt_time, prof->opt_time - profile_getclock());
 #endif
 
 #ifdef USE_TCG_OPTIMIZATIONS
@@ -2776,8 +2843,8 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
 #endif
 
 #ifdef CONFIG_PROFILER
-    s->opt_time += profile_getclock();
-    s->la_time -= profile_getclock();
+    atomic_set(&prof->opt_time, prof->opt_time + profile_getclock());
+    atomic_set(&prof->la_time, prof->la_time - profile_getclock());
 #endif
 
     liveness_pass_1(s);
@@ -2801,7 +2868,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
     }
 
 #ifdef CONFIG_PROFILER
-    s->la_time += profile_getclock();
+    atomic_set(&prof->la_time, prof->la_time + profile_getclock());
 #endif
 
 #ifdef DEBUG_DISAS
@@ -2834,7 +2901,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
 
         oi_next = op->next;
 #ifdef CONFIG_PROFILER
-        tcg_table_op_count[opc]++;
+        atomic_set(&prof->table_op_count[opc], prof->table_op_count[opc] + 1);
 #endif
 
         switch (opc) {
@@ -2915,10 +2982,17 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
 #ifdef CONFIG_PROFILER
 void tcg_dump_info(FILE *f, fprintf_function cpu_fprintf)
 {
-    TCGContext *s = tcg_ctx;
-    int64_t tb_count = s->tb_count;
-    int64_t tb_div_count = tb_count ? tb_count : 1;
-    int64_t tot = s->interm_time + s->code_time;
+    TCGProfile prof = {};
+    const TCGProfile *s;
+    int64_t tb_count;
+    int64_t tb_div_count;
+    int64_t tot;
+
+    tcg_profile_snapshot_counters(&prof);
+    s = &prof;
+    tb_count = s->tb_count;
+    tb_div_count = tb_count ? tb_count : 1;
+    tot = s->interm_time + s->code_time;
 
     cpu_fprintf(f, "JIT cycles          %" PRId64 " (%0.3f s at 2.4 GHz)\n",
                 tot, tot / 2.4e9);
-- 
2.13.6
