Received: from eggs.gnu.org ([2001:4830:134:3::10]:46504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dU6zM-0004S5-Ma
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dU6zF-00031Q-9W
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:44 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:49909)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dU6zE-0002zq-Q2
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:36 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  9 Jul 2017 03:50:09 -0400
Message-Id: <1499586614-20507-18-git-send-email-cota@braap.org>
In-Reply-To: <1499586614-20507-1-git-send-email-cota@braap.org>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 17/22] tcg: distribute profiling counters
 across TCGContext's
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

TCGContext is about to be made thread-local. To avoid scalability issues
when profiling info is enabled, this patch makes the profiling info counters
distributed via the following changes:

1) Consolidate profile info into its own struct, TCGProfile, which
   TCGContext also includes. Note that tcg_table_op_count is brought
   into TCGProfile after dropping the tcg_ prefix.
2) Iterate over the TCG contexts in the system to obtain the total counts.

Note that this change also requires updating the accessors to TCGProfile
fields to use atomic_read/set whenever there may be concurrent accesses
to them.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/tcg.h                 |  38 ++++++++--------
 accel/tcg/translate-all.c |  23 +++++-----
 tcg/tcg.c                 | 108 ++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 124 insertions(+), 45 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 8e1cd45..2a64ee2 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -641,6 +641,26 @@ QEMU_BUILD_BUG_ON(OPPARAM_BUF_SIZE > (1 << 14));
 /* Make sure that we don't overflow 64 bits without noticing.  */
 QEMU_BUILD_BUG_ON(sizeof(TCGOp) > 8);
 
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
@@ -664,23 +684,7 @@ struct TCGContext {
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
index 84e19d9..31a9d42 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -287,6 +287,7 @@ static int cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
     uint8_t *p = tb->tc_search;
     int i, j, num_insns = tb->icount;
 #ifdef CONFIG_PROFILER
+    TCGProfile *prof = &tcg_ctx.prof;
     int64_t ti = profile_getclock();
 #endif
 
@@ -321,8 +322,9 @@ static int cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
     restore_state_to_opc(env, tb, data);
 
 #ifdef CONFIG_PROFILER
-    tcg_ctx.restore_time += profile_getclock() - ti;
-    tcg_ctx.restore_count++;
+    atomic_set(&prof->restore_time,
+                prof->restore_time + profile_getclock() - ti);
+    atomic_set(&prof->restore_count, prof->restore_count + 1);
 #endif
     return 0;
 }
@@ -1269,6 +1271,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tcg_insn_unit *gen_code_buf;
     int gen_code_size, search_size;
 #ifdef CONFIG_PROFILER
+    TCGProfile *prof = &tcg_ctx.prof;
     int64_t ti;
 #endif
     assert_memory_lock();
@@ -1298,8 +1301,8 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb->invalid = false;
 
 #ifdef CONFIG_PROFILER
-    tcg_ctx.tb_count1++; /* includes aborted translations because of
-                       exceptions */
+    /* includes aborted translations because of exceptions */
+    atomic_set(&prof->tb_count1, prof->tb_count1 + 1);
     ti = profile_getclock();
 #endif
 
@@ -1324,8 +1327,8 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
 #endif
 
 #ifdef CONFIG_PROFILER
-    tcg_ctx.tb_count++;
-    tcg_ctx.interm_time += profile_getclock() - ti;
+    atomic_set(&prof->tb_count, prof->tb_count + 1);
+    atomic_set(&prof->interm_time, prof->interm_time + profile_getclock() - ti);
     ti = profile_getclock();
 #endif
 
@@ -1345,10 +1348,10 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb->tc_size = gen_code_size;
 
 #ifdef CONFIG_PROFILER
-    tcg_ctx.code_time += profile_getclock() - ti;
-    tcg_ctx.code_in_len += tb->size;
-    tcg_ctx.code_out_len += gen_code_size;
-    tcg_ctx.search_out_len += search_size;
+    atomic_set(&prof->code_time, prof->code_time + profile_getclock() - ti);
+    atomic_set(&prof->code_in_len, prof->code_in_len + tb->size);
+    atomic_set(&prof->code_out_len, prof->code_out_len + gen_code_size);
+    atomic_set(&prof->search_out_len, prof->search_out_len + search_size);
 #endif
 
 #ifdef DEBUG_DISAS
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 0da7c61..c19c473 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1362,7 +1362,7 @@ void tcg_op_remove(TCGContext *s, TCGOp *op)
     memset(op, 0, sizeof(*op));
 
 #ifdef CONFIG_PROFILER
-    s->del_op_count++;
+    atomic_set(&s->prof.del_op_count, s->prof.del_op_count + 1);
 #endif
 }
 
@@ -2533,15 +2533,77 @@ static void tcg_reg_alloc_call(TCGContext *s, int nb_oargs, int nb_iargs,
 
 #ifdef CONFIG_PROFILER
 
-static int64_t tcg_table_op_count[NB_OPS];
+/* avoid copy/paste errors */
+#define PROF_ADD(to, from, field)                       \
+    (to)->field += atomic_read(&((from)->field))
+
+#define PROF_ADD_MAX(to, from, field)                                   \
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
+    const TCGContext *s;
+
+    QSIMPLEQ_FOREACH(s, &ctx_list, entry) {
+        const TCGProfile *orig = &s->prof;
+
+        if (counters) {
+            PROF_ADD(prof, orig, tb_count1);
+            PROF_ADD(prof, orig, tb_count);
+            PROF_ADD(prof, orig, op_count);
+            PROF_ADD_MAX(prof, orig, op_count_max);
+            PROF_ADD(prof, orig, temp_count);
+            PROF_ADD_MAX(prof, orig, temp_count_max);
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
+#undef PROF_ADD_MAX
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
@@ -2554,6 +2616,9 @@ void tcg_dump_op_count(FILE *f, fprintf_function cpu_fprintf)
 
 int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
 {
+#ifdef CONFIG_PROFILER
+    TCGProfile *prof = &s->prof;
+#endif
     int i, oi, oi_next, num_insns;
 
 #ifdef CONFIG_PROFILER
@@ -2561,15 +2626,15 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
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
@@ -2586,7 +2651,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
 #endif
 
 #ifdef CONFIG_PROFILER
-    s->opt_time -= profile_getclock();
+    atomic_set(&prof->opt_time, prof->opt_time - profile_getclock());
 #endif
 
 #ifdef USE_TCG_OPTIMIZATIONS
@@ -2594,8 +2659,8 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
 #endif
 
 #ifdef CONFIG_PROFILER
-    s->opt_time += profile_getclock();
-    s->la_time -= profile_getclock();
+    atomic_set(&prof->opt_time, prof->opt_time + profile_getclock());
+    atomic_set(&prof->la_time, prof->la_time - profile_getclock());
 #endif
 
     {
@@ -2623,7 +2688,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
     }
 
 #ifdef CONFIG_PROFILER
-    s->la_time += profile_getclock();
+    atomic_set(&prof->la_time, prof->la_time + profile_getclock());
 #endif
 
 #ifdef DEBUG_DISAS
@@ -2654,7 +2719,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
 
         oi_next = op->next;
 #ifdef CONFIG_PROFILER
-        tcg_table_op_count[opc]++;
+        atomic_set(&prof->table_op_count[opc], prof->table_op_count[opc] + 1);
 #endif
 
         switch (opc) {
@@ -2730,10 +2795,17 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
 #ifdef CONFIG_PROFILER
 void tcg_dump_info(FILE *f, fprintf_function cpu_fprintf)
 {
-    TCGContext *s = &tcg_ctx;
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
2.7.4
