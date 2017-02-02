Received: from eggs.gnu.org ([2001:4830:134:3::10]:35228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cZIU1-0005Kg-1w
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:35:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cZITx-0005PP-3c
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:35:33 -0500
Received: from bran.ispras.ru ([83.149.199.196]:39802 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cZITw-0005Ok-IU
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:35:29 -0500
From: Kirill Batuzov <batuzovk@ispras.ru>
Date: Thu,  2 Feb 2017 17:34:45 +0300
Message-Id: <1486046099-17726-8-git-send-email-batuzovk@ispras.ru>
In-Reply-To: <1486046099-17726-1-git-send-email-batuzovk@ispras.ru>
References: <1486046099-17726-1-git-send-email-batuzovk@ispras.ru>
Subject: [Qemu-devel] [PATCH v2.1 07/21] tcg: allow globals to overlap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Kirill Batuzov <batuzovk@ispras.ru>

Sometimes the target architecture may allow some parts of a register to be
accessed as a different register. If both of these registers are
implemented as globals in QEMU, then their content will overlap and the
change to one global will also change the value of the other. To handle
such situation properly, some fixes are needed in the register allocator
and liveness analysis.

Signed-off-by: Kirill Batuzov <batuzovk@ispras.ru>
---
 tcg/optimize.c |  19 ++++++++-
 tcg/tcg.c      | 128 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tcg/tcg.h      |  20 +++++++++
 3 files changed, 166 insertions(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 2347ce3..7a69ff0 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -55,7 +55,7 @@ static inline bool temp_is_copy(TCGArg arg)
 }
 
 /* Reset TEMP's state, possibly removing the temp for the list of copies.  */
-static void reset_temp(TCGArg temp)
+static void reset_this_temp(TCGArg temp)
 {
     temps[temps[temp].next_copy].prev_copy = temps[temp].prev_copy;
     temps[temps[temp].prev_copy].next_copy = temps[temp].next_copy;
@@ -66,6 +66,23 @@ static void reset_temp(TCGArg temp)
     temps[temp].mask = -1;
 }
 
+static void reset_temp(TCGArg temp)
+{
+    int i;
+    TCGTemp *ts = &tcg_ctx.temps[temp];
+    reset_this_temp(temp);
+    if (ts->sub_temps) {
+        for (i = 0; ts->sub_temps[i] != (TCGArg)-1; i++) {
+            reset_this_temp(ts->sub_temps[i]);
+        }
+    }
+    if (ts->overlap_temps) {
+        for (i = 0; ts->overlap_temps[i] != (TCGArg)-1; i++) {
+            reset_this_temp(ts->overlap_temps[i]);
+        }
+    }
+}
+
 /* Reset all temporaries, given that there are NB_TEMPS of them.  */
 static void reset_all_temps(int nb_temps)
 {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 27e5944..a8df040 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -623,9 +623,13 @@ int tcg_global_mem_new_internal(TCGType base_type, TCGv_ptr base,
             ts2->mem_base = base_ts;
             ts2->mem_offset = offset + cur_offset;
             ts2->name = g_strdup_printf("%s_%d", name, i);
+            ts2->sub_temps = NULL;
+            ts2->overlap_temps = NULL;
             ts1 = ts2;
         }
     }
+    ts->sub_temps = NULL;
+    ts->overlap_temps = NULL;
     return temp_idx(s, ts);
 }
 
@@ -1514,6 +1518,35 @@ static int tcg_temp_overlap(TCGContext *s, const TCGTemp *tmp,
     }
 }
 
+static void tcg_temp_arr_apply(const TCGArg *arr, uint8_t *temp_state,
+                               uint8_t temp_val)
+{
+    TCGArg i;
+    if (!arr) {
+        return ;
+    }
+    for (i = 0; arr[i] != (TCGArg)-1; i++) {
+        temp_state[arr[i]] = temp_val;
+    }
+}
+
+static void tcg_sub_temps_dead(TCGContext *s, TCGArg tmp, uint8_t *temp_state)
+{
+    tcg_temp_arr_apply(s->temps[tmp].sub_temps, temp_state, TS_DEAD);
+}
+
+static void tcg_sub_temps_sync(TCGContext *s, TCGArg tmp, uint8_t *temp_state)
+{
+    tcg_temp_arr_apply(s->temps[tmp].sub_temps, temp_state, TS_MEM | TS_DEAD);
+}
+
+static void tcg_overlap_temps_sync(TCGContext *s, TCGArg tmp,
+                                   uint8_t *temp_state)
+{
+    tcg_temp_arr_apply(s->temps[tmp].overlap_temps, temp_state,
+                       TS_MEM | TS_DEAD);
+}
+
 /* Liveness analysis : update the opc_arg_life array to tell if a
    given input arguments is dead. Instructions updating dead
    temporaries are removed. */
@@ -1568,6 +1601,11 @@ static void liveness_pass_1(TCGContext *s, uint8_t *temp_state)
                         if (temp_state[arg] & TS_MEM) {
                             arg_life |= SYNC_ARG << i;
                         }
+                        /* sub_temps are also dead */
+                        tcg_sub_temps_dead(&tcg_ctx, arg, temp_state);
+                        /* overlap_temps need to go to memory */
+                        tcg_overlap_temps_sync(&tcg_ctx, arg, temp_state);
+
                         temp_state[arg] = TS_DEAD;
                     }
 
@@ -1595,6 +1633,11 @@ static void liveness_pass_1(TCGContext *s, uint8_t *temp_state)
                     for (i = nb_oargs; i < nb_iargs + nb_oargs; i++) {
                         arg = args[i];
                         if (arg != TCG_CALL_DUMMY_ARG) {
+                            /* both sub_temps and overlap_temps need to go
+                               to memory */
+                            tcg_sub_temps_sync(&tcg_ctx, arg, temp_state);
+                            tcg_overlap_temps_sync(&tcg_ctx, arg, temp_state);
+
                             temp_state[arg] &= ~TS_DEAD;
                         }
                     }
@@ -1713,6 +1756,11 @@ static void liveness_pass_1(TCGContext *s, uint8_t *temp_state)
                     if (temp_state[arg] & TS_MEM) {
                         arg_life |= SYNC_ARG << i;
                     }
+                    /* sub_temps are also dead */
+                    tcg_sub_temps_dead(&tcg_ctx, arg, temp_state);
+                    /* overlap_temps need to go to memory */
+                    tcg_overlap_temps_sync(&tcg_ctx, arg, temp_state);
+
                     temp_state[arg] = TS_DEAD;
                 }
 
@@ -1753,6 +1801,9 @@ static void liveness_pass_1(TCGContext *s, uint8_t *temp_state)
                 /* input arguments are live for preceding opcodes */
                 for (i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
                     temp_state[args[i]] &= ~TS_DEAD;
+                    /* both sub_temps and overlap_temps need to go to memory */
+                    tcg_sub_temps_sync(&tcg_ctx, args[i], temp_state);
+                    tcg_overlap_temps_sync(&tcg_ctx, args[i], temp_state);
                 }
             }
             break;
@@ -3139,3 +3190,80 @@ void tcg_register_jit(void *buf, size_t buf_size)
 {
 }
 #endif /* ELF_HOST_MACHINE */
+
+static int tcg_temp_is_sub_temp(const TCGTemp *t1, const TCGTemp *t2)
+{
+    if (t2->mem_offset < t1->mem_offset) {
+        return 0;
+    }
+    if (t2->mem_offset + tcg_temp_size(t2) >
+        t1->mem_offset + tcg_temp_size(t1)) {
+        return 0;
+    }
+    return 1;
+}
+
+static int tcg_temp_is_overlap_temp(const TCGTemp *t1, const TCGTemp *t2)
+{
+    if (t2->mem_offset >= t1->mem_offset + tcg_temp_size(t1)) {
+        return 0;
+    }
+    if (t2->mem_offset + tcg_temp_size(t2) <= t1->mem_offset) {
+        return 0;
+    }
+    return 1;
+}
+
+void tcg_detect_overlapping_temps(TCGContext *s)
+{
+    int i, j;
+    int overlap_count, subtemps_count;
+    TCGArg *sub_temps, *overlap_temps;
+    TCGTemp *ts;
+    for (i = 0; i < s->nb_globals; i++) {
+        ts = &s->temps[i];
+        if (ts->fixed_reg ||
+            ts->mem_base != &s->temps[GET_TCGV_PTR(s->tcg_env)]) {
+            continue;
+        }
+        overlap_count = 0;
+        subtemps_count = 0;
+        overlap_temps = NULL;
+        sub_temps = NULL;
+        for (j = 0; j < s->nb_globals; j++) {
+            if (i != j && !s->temps[j].fixed_reg &&
+                s->temps[j].mem_base == &s->temps[GET_TCGV_PTR(s->tcg_env)]) {
+                if (tcg_temp_is_sub_temp(ts, &s->temps[j])) {
+                    subtemps_count++;
+                } else if (tcg_temp_is_overlap_temp(ts, &s->temps[j])) {
+                    overlap_count++;
+                }
+            }
+        }
+        if (subtemps_count == 0 && overlap_count == 0) {
+            continue;
+        }
+        if (subtemps_count > 0) {
+            sub_temps = g_malloc0((subtemps_count + 1) * sizeof(TCGArg));
+            sub_temps[subtemps_count] = (TCGArg)-1;
+            tcg_temp_set_sub_temps(i, sub_temps);
+        }
+        if (overlap_count > 0) {
+            overlap_temps = g_malloc0((overlap_count + 1) * sizeof(TCGArg));
+            overlap_temps[overlap_count] = (TCGArg)-1;
+            tcg_temp_set_overlap_temps(i, overlap_temps);
+        }
+        overlap_count = 0;
+        subtemps_count = 0;
+        for (j = 0; j < s->nb_globals; j++) {
+            if (i != j && !s->temps[j].fixed_reg &&
+                s->temps[j].mem_base == &s->temps[GET_TCGV_PTR(s->tcg_env)]) {
+                if (tcg_temp_is_sub_temp(ts, &s->temps[j])) {
+                    sub_temps[subtemps_count++] = (TCGArg)j;
+                } else if (tcg_temp_is_overlap_temp(ts, &s->temps[j])) {
+                    overlap_temps[overlap_count++] = (TCGArg)j;
+                }
+            }
+        }
+    }
+}
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 0e1fbe9..01299cc 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -634,6 +634,14 @@ typedef struct TCGTemp {
     struct TCGTemp *mem_base;
     intptr_t mem_offset;
     const char *name;
+
+    /* -1 terminated array of temps that are parts of this temp.
+       All bits of them are part of this temp. */
+    const TCGArg *sub_temps;
+    /* -1 terminated array of temps that overlap with this temp.
+       Some bits of them are part of this temp, but some are not. sub_temps
+       are not included here. */
+    const TCGArg *overlap_temps;
 } TCGTemp;
 
 typedef struct TCGContext TCGContext;
@@ -837,6 +845,16 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb);
 
 void tcg_set_frame(TCGContext *s, TCGReg reg, intptr_t start, intptr_t size);
 
+static inline void tcg_temp_set_sub_temps(TCGArg temp, const TCGArg *arr)
+{
+    tcg_ctx.temps[temp].sub_temps = arr;
+}
+
+static inline void tcg_temp_set_overlap_temps(TCGArg temp, const TCGArg *arr)
+{
+    tcg_ctx.temps[temp].overlap_temps = arr;
+}
+
 int tcg_global_mem_new_internal(TCGType, TCGv_ptr, intptr_t, const char *);
 
 TCGv_i32 tcg_global_reg_new_i32(TCGReg reg, const char *name);
@@ -1382,4 +1400,6 @@ void helper_atomic_sto_be_mmu(CPUArchState *env, target_ulong addr, Int128 val,
 
 #endif /* CONFIG_ATOMIC128 */
 
+void tcg_detect_overlapping_temps(TCGContext *s);
+
 #endif /* TCG_H */
-- 
2.1.4
