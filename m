Received: from eggs.gnu.org ([2001:4830:134:3::10]:50905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPkg-00038e-Ac
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPkf-0003tL-6l
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:26 -0500
Received: from bran.ispras.ru ([83.149.199.196]:50140 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPke-0003ss-PU
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:25 -0500
From: Kirill Batuzov <batuzovk@ispras.ru>
Date: Tue, 17 Jan 2017 12:07:46 +0300
Message-Id: <1484644078-21312-7-git-send-email-batuzovk@ispras.ru>
In-Reply-To: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
References: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
Subject: [Qemu-devel] [PATCH 06/18] tcg: allow globals to overlap
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

Sometimes the target architecture may allow some parts of a register to be
accessed as a different register. If both of these registers are
implemented as globals in QEMU, then their content will overlap and the
change to one global will also change the value of the other. To handle
such situation properly, some fixes are needed in the register allocator
and liveness analysis.

Signed-off-by: Kirill Batuzov <batuzovk@ispras.ru>
---
 tcg/tcg.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 tcg/tcg.h | 18 ++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 2f97c13..330a1c0 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -572,6 +572,8 @@ int tcg_global_mem_new_internal(TCGType type, TCGv_ptr base,
         ts->mem_offset = offset;
         ts->name = name;
     }
+    ts->sub_temps = NULL;
+    ts->overlap_temps = NULL;
     return temp_idx(s, ts);
 }
 
@@ -1500,6 +1502,35 @@ static int tcg_temp_overlap(TCGContext *s, const TCGTemp *tmp,
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
@@ -1554,6 +1585,11 @@ static void liveness_pass_1(TCGContext *s, uint8_t *temp_state)
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
 
@@ -1581,6 +1617,11 @@ static void liveness_pass_1(TCGContext *s, uint8_t *temp_state)
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
@@ -1699,6 +1740,11 @@ static void liveness_pass_1(TCGContext *s, uint8_t *temp_state)
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
 
@@ -1739,6 +1785,9 @@ static void liveness_pass_1(TCGContext *s, uint8_t *temp_state)
                 /* input arguments are live for preceding opcodes */
                 for (i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
                     temp_state[args[i]] &= ~TS_DEAD;
+                    /* both sub_temps and overlap_temps need to go to memory */
+                    tcg_sub_temps_sync(&tcg_ctx, arg, temp_state);
+                    tcg_overlap_temps_sync(&tcg_ctx, arg, temp_state);
                 }
             }
             break;
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 921892f..6473228 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -623,6 +623,14 @@ typedef struct TCGTemp {
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
@@ -826,6 +834,16 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb);
 
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
-- 
2.1.4
