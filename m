Received: from eggs.gnu.org ([2001:4830:134:3::10]:46342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpme-0001Bb-HR
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmZ-0008QD-9f
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:52 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39975)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dWpmZ-0008PO-2o
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:47 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 16 Jul 2017 16:04:19 -0400
Message-Id: <1500235468-15341-37-git-send-email-cota@braap.org>
In-Reply-To: <1500235468-15341-1-git-send-email-cota@braap.org>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 36/45] tcg: dynamically allocate optimizer
 globals + fold into TCGContext
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

Groundwork for supporting multiple TCG contexts.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/tcg.h      | 12 ++++++++++++
 tcg/optimize.c | 40 +++++++++++++++++++++++-----------------
 2 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 569f823..175d4de 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -641,6 +641,14 @@ QEMU_BUILD_BUG_ON(OPPARAM_BUF_SIZE > (1 << 14));
 /* Make sure that we don't overflow 64 bits without noticing.  */
 QEMU_BUILD_BUG_ON(sizeof(TCGOp) > 8);
 
+struct tcg_temp_info {
+    bool is_const;
+    uint16_t prev_copy;
+    uint16_t next_copy;
+    tcg_target_ulong val;
+    tcg_target_ulong mask;
+};
+
 struct TCGContext {
     uint8_t *pool_cur, *pool_end;
     TCGPool *pool_first, *pool_current, *pool_first_large;
@@ -717,6 +725,10 @@ struct TCGContext {
     TCGTempSet free_temps[TCG_TYPE_COUNT * 2];
     TCGTemp temps[TCG_MAX_TEMPS]; /* globals first, temps after */
 
+    /* optimizer */
+    struct tcg_temp_info *opt_temps;
+    TCGTempSet opt_temps_used;
+
     /* Tells which temporary holds a given register.
        It does not take into account fixed registers */
     TCGTemp *reg_to_temp[TCG_TARGET_NB_REGS];
diff --git a/tcg/optimize.c b/tcg/optimize.c
index adfc56c..61ca870 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -32,30 +32,21 @@
         glue(glue(case INDEX_op_, x), _i32):    \
         glue(glue(case INDEX_op_, x), _i64)
 
-struct tcg_temp_info {
-    bool is_const;
-    uint16_t prev_copy;
-    uint16_t next_copy;
-    tcg_target_ulong val;
-    tcg_target_ulong mask;
-};
-
-static struct tcg_temp_info temps[TCG_MAX_TEMPS];
-static TCGTempSet temps_used;
-
 static inline bool temp_is_const(TCGArg arg)
 {
-    return temps[arg].is_const;
+    return tcg_ctx->opt_temps[arg].is_const;
 }
 
 static inline bool temp_is_copy(TCGArg arg)
 {
-    return temps[arg].next_copy != arg;
+    return tcg_ctx->opt_temps[arg].next_copy != arg;
 }
 
 /* Reset TEMP's state, possibly removing the temp for the list of copies.  */
 static void reset_temp(TCGArg temp)
 {
+    struct tcg_temp_info *temps = tcg_ctx->opt_temps;
+
     temps[temps[temp].next_copy].prev_copy = temps[temp].prev_copy;
     temps[temps[temp].prev_copy].next_copy = temps[temp].next_copy;
     temps[temp].next_copy = temp;
@@ -67,18 +58,20 @@ static void reset_temp(TCGArg temp)
 /* Reset all temporaries, given that there are NB_TEMPS of them.  */
 static void reset_all_temps(int nb_temps)
 {
-    bitmap_zero(temps_used.l, nb_temps);
+    bitmap_zero(tcg_ctx->opt_temps_used.l, nb_temps);
 }
 
 /* Initialize and activate a temporary.  */
 static void init_temp_info(TCGArg temp)
 {
-    if (!test_bit(temp, temps_used.l)) {
+    struct tcg_temp_info *temps = tcg_ctx->opt_temps;
+
+    if (!test_bit(temp, tcg_ctx->opt_temps_used.l)) {
         temps[temp].next_copy = temp;
         temps[temp].prev_copy = temp;
         temps[temp].is_const = false;
         temps[temp].mask = -1;
-        set_bit(temp, temps_used.l);
+        set_bit(temp, tcg_ctx->opt_temps_used.l);
     }
 }
 
@@ -118,6 +111,7 @@ static TCGOpcode op_to_movi(TCGOpcode op)
 
 static TCGArg find_better_copy(TCGContext *s, TCGArg temp)
 {
+    struct tcg_temp_info *temps = tcg_ctx->opt_temps;
     TCGArg i;
 
     /* If this is already a global, we can't do better. */
@@ -147,6 +141,7 @@ static TCGArg find_better_copy(TCGContext *s, TCGArg temp)
 
 static bool temps_are_copies(TCGArg arg1, TCGArg arg2)
 {
+    struct tcg_temp_info *temps = tcg_ctx->opt_temps;
     TCGArg i;
 
     if (arg1 == arg2) {
@@ -169,6 +164,7 @@ static bool temps_are_copies(TCGArg arg1, TCGArg arg2)
 static void tcg_opt_gen_movi(TCGContext *s, TCGOp *op, TCGArg *args,
                              TCGArg dst, TCGArg val)
 {
+    struct tcg_temp_info *temps = tcg_ctx->opt_temps;
     TCGOpcode new_op = op_to_movi(op->opc);
     tcg_target_ulong mask;
 
@@ -196,6 +192,7 @@ static void tcg_opt_gen_mov(TCGContext *s, TCGOp *op, TCGArg *args,
         return;
     }
 
+    struct tcg_temp_info *temps = tcg_ctx->opt_temps;
     TCGOpcode new_op = op_to_mov(op->opc);
     tcg_target_ulong mask;
 
@@ -466,6 +463,8 @@ static bool do_constant_folding_cond_eq(TCGCond c)
 static TCGArg do_constant_folding_cond(TCGOpcode op, TCGArg x,
                                        TCGArg y, TCGCond c)
 {
+    struct tcg_temp_info *temps = tcg_ctx->opt_temps;
+
     if (temp_is_const(x) && temp_is_const(y)) {
         switch (op_bits(op)) {
         case 32:
@@ -494,6 +493,7 @@ static TCGArg do_constant_folding_cond(TCGOpcode op, TCGArg x,
    of the condition (0 or 1) if it can */
 static TCGArg do_constant_folding_cond2(TCGArg *p1, TCGArg *p2, TCGCond c)
 {
+    struct tcg_temp_info *temps = tcg_ctx->opt_temps;
     TCGArg al = p1[0], ah = p1[1];
     TCGArg bl = p2[0], bh = p2[1];
 
@@ -558,9 +558,15 @@ static bool swap_commutative2(TCGArg *p1, TCGArg *p2)
 /* Propagate constants and copies, fold constant expressions. */
 void tcg_optimize(TCGContext *s)
 {
+    struct tcg_temp_info *temps;
     int oi, oi_next, nb_temps, nb_globals;
     TCGArg *prev_mb_args = NULL;
 
+    if (tcg_ctx->opt_temps == NULL) {
+        tcg_ctx->opt_temps = g_new(struct tcg_temp_info, TCG_MAX_TEMPS);
+    }
+    temps = tcg_ctx->opt_temps;
+
     /* Array VALS has an element for each temp.
        If this temp holds a constant then its value is kept in VALS' element.
        If this temp is a copy of other ones then the other copies are
@@ -1360,7 +1366,7 @@ void tcg_optimize(TCGContext *s)
             if (!(args[nb_oargs + nb_iargs + 1]
                   & (TCG_CALL_NO_READ_GLOBALS | TCG_CALL_NO_WRITE_GLOBALS))) {
                 for (i = 0; i < nb_globals; i++) {
-                    if (test_bit(i, temps_used.l)) {
+                    if (test_bit(i, tcg_ctx->opt_temps_used.l)) {
                         reset_temp(i);
                     }
                 }
-- 
2.7.4
