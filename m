Received: from eggs.gnu.org ([2001:4830:134:3::10]:55939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYQyM-0002RP-MT
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 01:59:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYQyJ-0001qH-9s
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 01:59:34 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44457)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dYQyJ-0001pQ-4C
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 01:59:31 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 21 Jul 2017 01:59:21 -0400
Message-Id: <1500616763-26560-4-git-send-email-cota@braap.org>
In-Reply-To: <1500616763-26560-1-git-send-email-cota@braap.org>
References: <1500616763-26560-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v4 35/43] tcg: allocate optimizer temps with
 tcg_malloc
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

While at it, also allocate temps_used directly as a bitmap of the
required size, instead of using a bitmap of TCG_MAX_TEMPS via
TCGTempSet.

Performance-wise we lose about 1.12% in a translation-heavy workload
such as booting+shutting down debian-arm:

Performance counter stats for 'taskset -c 0 arm-softmmu/qemu-system-arm \
	-machine type=virt -nographic -smp 1 -m 4096 \
	-netdev user,id=unet,hostfwd=tcp::2222-:22 \
	-device virtio-net-device,netdev=unet \
	-drive file=die-on-boot.qcow2,id=myblock,index=0,if=none \
	-device virtio-blk-device,drive=myblock \
	-kernel kernel.img -append console=ttyAMA0 root=/dev/vda1 \
	-name arm,debug-threads=on -smp 1' (10 runs):

             exec time (s)  Relative slowdown wrt original (%)
---------------------------------------------------------------
 original     20.213321616                                  0.
 tcg_malloc   20.441130078                           1.1270214
 TCGContext   20.477846517                           1.3086662
 g_malloc     20.780527895                           2.8061013

The other two alternatives shown in the table are:
- TCGContext: embed temps[TCG_MAX_TEMPS] and TCGTempSet used_temps
  in TCGContext. This is simple enough but it isn't faster than using
  tcg_malloc; moreover, it wastes memory.
- g_malloc: allocate/deallocate both temps and used_temps every time
  tcg_optimize is executed.

Suggested-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/optimize.c | 306 ++++++++++++++++++++++++++++++---------------------------
 1 file changed, 161 insertions(+), 145 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index adfc56c..ce422e9 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -40,21 +40,18 @@ struct tcg_temp_info {
     tcg_target_ulong mask;
 };
 
-static struct tcg_temp_info temps[TCG_MAX_TEMPS];
-static TCGTempSet temps_used;
-
-static inline bool temp_is_const(TCGArg arg)
+static inline bool temp_is_const(const struct tcg_temp_info *temps, TCGArg arg)
 {
     return temps[arg].is_const;
 }
 
-static inline bool temp_is_copy(TCGArg arg)
+static inline bool temp_is_copy(const struct tcg_temp_info *temps, TCGArg arg)
 {
     return temps[arg].next_copy != arg;
 }
 
 /* Reset TEMP's state, possibly removing the temp for the list of copies.  */
-static void reset_temp(TCGArg temp)
+static void reset_temp(struct tcg_temp_info *temps, TCGArg temp)
 {
     temps[temps[temp].next_copy].prev_copy = temps[temp].prev_copy;
     temps[temps[temp].prev_copy].next_copy = temps[temp].next_copy;
@@ -64,21 +61,16 @@ static void reset_temp(TCGArg temp)
     temps[temp].mask = -1;
 }
 
-/* Reset all temporaries, given that there are NB_TEMPS of them.  */
-static void reset_all_temps(int nb_temps)
-{
-    bitmap_zero(temps_used.l, nb_temps);
-}
-
 /* Initialize and activate a temporary.  */
-static void init_temp_info(TCGArg temp)
+static void init_temp_info(struct tcg_temp_info *temps,
+                           unsigned long *temps_used, TCGArg temp)
 {
-    if (!test_bit(temp, temps_used.l)) {
+    if (!test_bit(temp, temps_used)) {
         temps[temp].next_copy = temp;
         temps[temp].prev_copy = temp;
         temps[temp].is_const = false;
         temps[temp].mask = -1;
-        set_bit(temp, temps_used.l);
+        set_bit(temp, temps_used);
     }
 }
 
@@ -116,7 +108,8 @@ static TCGOpcode op_to_movi(TCGOpcode op)
     }
 }
 
-static TCGArg find_better_copy(TCGContext *s, TCGArg temp)
+static TCGArg find_better_copy(TCGContext *s, const struct tcg_temp_info *temps,
+                               TCGArg temp)
 {
     TCGArg i;
 
@@ -145,7 +138,8 @@ static TCGArg find_better_copy(TCGContext *s, TCGArg temp)
     return temp;
 }
 
-static bool temps_are_copies(TCGArg arg1, TCGArg arg2)
+static bool temps_are_copies(const struct tcg_temp_info *temps, TCGArg arg1,
+                             TCGArg arg2)
 {
     TCGArg i;
 
@@ -153,7 +147,7 @@ static bool temps_are_copies(TCGArg arg1, TCGArg arg2)
         return true;
     }
 
-    if (!temp_is_copy(arg1) || !temp_is_copy(arg2)) {
+    if (!temp_is_copy(temps, arg1) || !temp_is_copy(temps, arg2)) {
         return false;
     }
 
@@ -166,15 +160,15 @@ static bool temps_are_copies(TCGArg arg1, TCGArg arg2)
     return false;
 }
 
-static void tcg_opt_gen_movi(TCGContext *s, TCGOp *op, TCGArg *args,
-                             TCGArg dst, TCGArg val)
+static void tcg_opt_gen_movi(TCGContext *s, struct tcg_temp_info *temps,
+                             TCGOp *op, TCGArg *args, TCGArg dst, TCGArg val)
 {
     TCGOpcode new_op = op_to_movi(op->opc);
     tcg_target_ulong mask;
 
     op->opc = new_op;
 
-    reset_temp(dst);
+    reset_temp(temps, dst);
     temps[dst].is_const = true;
     temps[dst].val = val;
     mask = val;
@@ -188,10 +182,10 @@ static void tcg_opt_gen_movi(TCGContext *s, TCGOp *op, TCGArg *args,
     args[1] = val;
 }
 
-static void tcg_opt_gen_mov(TCGContext *s, TCGOp *op, TCGArg *args,
-                            TCGArg dst, TCGArg src)
+static void tcg_opt_gen_mov(TCGContext *s, struct tcg_temp_info *temps,
+                            TCGOp *op, TCGArg *args, TCGArg dst, TCGArg src)
 {
-    if (temps_are_copies(dst, src)) {
+    if (temps_are_copies(temps, dst, src)) {
         tcg_op_remove(s, op);
         return;
     }
@@ -201,7 +195,7 @@ static void tcg_opt_gen_mov(TCGContext *s, TCGOp *op, TCGArg *args,
 
     op->opc = new_op;
 
-    reset_temp(dst);
+    reset_temp(temps, dst);
     mask = temps[src].mask;
     if (TCG_TARGET_REG_BITS > 32 && new_op == INDEX_op_mov_i32) {
         /* High bits of the destination are now garbage.  */
@@ -463,10 +457,11 @@ static bool do_constant_folding_cond_eq(TCGCond c)
 
 /* Return 2 if the condition can't be simplified, and the result
    of the condition (0 or 1) if it can */
-static TCGArg do_constant_folding_cond(TCGOpcode op, TCGArg x,
-                                       TCGArg y, TCGCond c)
+static TCGArg
+do_constant_folding_cond(const struct tcg_temp_info *temps, TCGOpcode op,
+                         TCGArg x, TCGArg y, TCGCond c)
 {
-    if (temp_is_const(x) && temp_is_const(y)) {
+    if (temp_is_const(temps, x) && temp_is_const(temps, y)) {
         switch (op_bits(op)) {
         case 32:
             return do_constant_folding_cond_32(temps[x].val, temps[y].val, c);
@@ -475,9 +470,9 @@ static TCGArg do_constant_folding_cond(TCGOpcode op, TCGArg x,
         default:
             tcg_abort();
         }
-    } else if (temps_are_copies(x, y)) {
+    } else if (temps_are_copies(temps, x, y)) {
         return do_constant_folding_cond_eq(c);
-    } else if (temp_is_const(y) && temps[y].val == 0) {
+    } else if (temp_is_const(temps, y) && temps[y].val == 0) {
         switch (c) {
         case TCG_COND_LTU:
             return 0;
@@ -492,15 +487,17 @@ static TCGArg do_constant_folding_cond(TCGOpcode op, TCGArg x,
 
 /* Return 2 if the condition can't be simplified, and the result
    of the condition (0 or 1) if it can */
-static TCGArg do_constant_folding_cond2(TCGArg *p1, TCGArg *p2, TCGCond c)
+static TCGArg
+do_constant_folding_cond2(const struct tcg_temp_info *temps, TCGArg *p1,
+                          TCGArg *p2, TCGCond c)
 {
     TCGArg al = p1[0], ah = p1[1];
     TCGArg bl = p2[0], bh = p2[1];
 
-    if (temp_is_const(bl) && temp_is_const(bh)) {
+    if (temp_is_const(temps, bl) && temp_is_const(temps, bh)) {
         uint64_t b = ((uint64_t)temps[bh].val << 32) | (uint32_t)temps[bl].val;
 
-        if (temp_is_const(al) && temp_is_const(ah)) {
+        if (temp_is_const(temps, al) && temp_is_const(temps, ah)) {
             uint64_t a;
             a = ((uint64_t)temps[ah].val << 32) | (uint32_t)temps[al].val;
             return do_constant_folding_cond_64(a, b, c);
@@ -516,18 +513,19 @@ static TCGArg do_constant_folding_cond2(TCGArg *p1, TCGArg *p2, TCGCond c)
             }
         }
     }
-    if (temps_are_copies(al, bl) && temps_are_copies(ah, bh)) {
+    if (temps_are_copies(temps, al, bl) && temps_are_copies(temps, ah, bh)) {
         return do_constant_folding_cond_eq(c);
     }
     return 2;
 }
 
-static bool swap_commutative(TCGArg dest, TCGArg *p1, TCGArg *p2)
+static bool swap_commutative(const struct tcg_temp_info *temps, TCGArg dest,
+                             TCGArg *p1, TCGArg *p2)
 {
     TCGArg a1 = *p1, a2 = *p2;
     int sum = 0;
-    sum += temp_is_const(a1);
-    sum -= temp_is_const(a2);
+    sum += temp_is_const(temps, a1);
+    sum -= temp_is_const(temps, a2);
 
     /* Prefer the constant in second argument, and then the form
        op a, a, b, which is better handled on non-RISC hosts. */
@@ -539,13 +537,14 @@ static bool swap_commutative(TCGArg dest, TCGArg *p1, TCGArg *p2)
     return false;
 }
 
-static bool swap_commutative2(TCGArg *p1, TCGArg *p2)
+static bool swap_commutative2(const struct tcg_temp_info *temps, TCGArg *p1,
+                              TCGArg *p2)
 {
     int sum = 0;
-    sum += temp_is_const(p1[0]);
-    sum += temp_is_const(p1[1]);
-    sum -= temp_is_const(p2[0]);
-    sum -= temp_is_const(p2[1]);
+    sum += temp_is_const(temps, p1[0]);
+    sum += temp_is_const(temps, p1[1]);
+    sum -= temp_is_const(temps, p2[0]);
+    sum -= temp_is_const(temps, p2[1]);
     if (sum > 0) {
         TCGArg t;
         t = p1[0], p1[0] = p2[0], p2[0] = t;
@@ -558,6 +557,8 @@ static bool swap_commutative2(TCGArg *p1, TCGArg *p2)
 /* Propagate constants and copies, fold constant expressions. */
 void tcg_optimize(TCGContext *s)
 {
+    struct tcg_temp_info *temps;
+    unsigned long *temps_used;
     int oi, oi_next, nb_temps, nb_globals;
     TCGArg *prev_mb_args = NULL;
 
@@ -568,7 +569,9 @@ void tcg_optimize(TCGContext *s)
 
     nb_temps = s->nb_temps;
     nb_globals = s->nb_globals;
-    reset_all_temps(nb_temps);
+    temps = tcg_malloc(nb_temps * sizeof(*temps));
+    temps_used = tcg_malloc(BITS_TO_LONGS(nb_temps) * sizeof(*temps_used));
+    bitmap_zero(temps_used, nb_temps);
 
     for (oi = s->gen_op_buf[0].next; oi != 0; oi = oi_next) {
         tcg_target_ulong mask, partmask, affected;
@@ -590,21 +593,21 @@ void tcg_optimize(TCGContext *s)
             for (i = 0; i < nb_oargs + nb_iargs; i++) {
                 tmp = args[i];
                 if (tmp != TCG_CALL_DUMMY_ARG) {
-                    init_temp_info(tmp);
+                    init_temp_info(temps, temps_used, tmp);
                 }
             }
         } else {
             nb_oargs = def->nb_oargs;
             nb_iargs = def->nb_iargs;
             for (i = 0; i < nb_oargs + nb_iargs; i++) {
-                init_temp_info(args[i]);
+                init_temp_info(temps, temps_used, args[i]);
             }
         }
 
         /* Do copy propagation */
         for (i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
-            if (temp_is_copy(args[i])) {
-                args[i] = find_better_copy(s, args[i]);
+            if (temp_is_copy(temps, args[i])) {
+                args[i] = find_better_copy(s, temps, args[i]);
             }
         }
 
@@ -620,44 +623,44 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(nor):
         CASE_OP_32_64(muluh):
         CASE_OP_32_64(mulsh):
-            swap_commutative(args[0], &args[1], &args[2]);
+            swap_commutative(temps, args[0], &args[1], &args[2]);
             break;
         CASE_OP_32_64(brcond):
-            if (swap_commutative(-1, &args[0], &args[1])) {
+            if (swap_commutative(temps, -1, &args[0], &args[1])) {
                 args[2] = tcg_swap_cond(args[2]);
             }
             break;
         CASE_OP_32_64(setcond):
-            if (swap_commutative(args[0], &args[1], &args[2])) {
+            if (swap_commutative(temps, args[0], &args[1], &args[2])) {
                 args[3] = tcg_swap_cond(args[3]);
             }
             break;
         CASE_OP_32_64(movcond):
-            if (swap_commutative(-1, &args[1], &args[2])) {
+            if (swap_commutative(temps, -1, &args[1], &args[2])) {
                 args[5] = tcg_swap_cond(args[5]);
             }
             /* For movcond, we canonicalize the "false" input reg to match
                the destination reg so that the tcg backend can implement
                a "move if true" operation.  */
-            if (swap_commutative(args[0], &args[4], &args[3])) {
+            if (swap_commutative(temps, args[0], &args[4], &args[3])) {
                 args[5] = tcg_invert_cond(args[5]);
             }
             break;
         CASE_OP_32_64(add2):
-            swap_commutative(args[0], &args[2], &args[4]);
-            swap_commutative(args[1], &args[3], &args[5]);
+            swap_commutative(temps, args[0], &args[2], &args[4]);
+            swap_commutative(temps, args[1], &args[3], &args[5]);
             break;
         CASE_OP_32_64(mulu2):
         CASE_OP_32_64(muls2):
-            swap_commutative(args[0], &args[2], &args[3]);
+            swap_commutative(temps, args[0], &args[2], &args[3]);
             break;
         case INDEX_op_brcond2_i32:
-            if (swap_commutative2(&args[0], &args[2])) {
+            if (swap_commutative2(temps, &args[0], &args[2])) {
                 args[4] = tcg_swap_cond(args[4]);
             }
             break;
         case INDEX_op_setcond2_i32:
-            if (swap_commutative2(&args[1], &args[3])) {
+            if (swap_commutative2(temps, &args[1], &args[3])) {
                 args[5] = tcg_swap_cond(args[5]);
             }
             break;
@@ -673,8 +676,8 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(sar):
         CASE_OP_32_64(rotl):
         CASE_OP_32_64(rotr):
-            if (temp_is_const(args[1]) && temps[args[1]].val == 0) {
-                tcg_opt_gen_movi(s, op, args, args[0], 0);
+            if (temp_is_const(temps, args[1]) && temps[args[1]].val == 0) {
+                tcg_opt_gen_movi(s, temps, op, args, args[0], 0);
                 continue;
             }
             break;
@@ -683,7 +686,7 @@ void tcg_optimize(TCGContext *s)
                 TCGOpcode neg_op;
                 bool have_neg;
 
-                if (temp_is_const(args[2])) {
+                if (temp_is_const(temps, args[2])) {
                     /* Proceed with possible constant folding. */
                     break;
                 }
@@ -697,9 +700,9 @@ void tcg_optimize(TCGContext *s)
                 if (!have_neg) {
                     break;
                 }
-                if (temp_is_const(args[1]) && temps[args[1]].val == 0) {
+                if (temp_is_const(temps, args[1]) && temps[args[1]].val == 0) {
                     op->opc = neg_op;
-                    reset_temp(args[0]);
+                    reset_temp(temps, args[0]);
                     args[1] = args[2];
                     continue;
                 }
@@ -707,30 +710,30 @@ void tcg_optimize(TCGContext *s)
             break;
         CASE_OP_32_64(xor):
         CASE_OP_32_64(nand):
-            if (!temp_is_const(args[1])
-                && temp_is_const(args[2]) && temps[args[2]].val == -1) {
+            if (!temp_is_const(temps, args[1])
+                && temp_is_const(temps, args[2]) && temps[args[2]].val == -1) {
                 i = 1;
                 goto try_not;
             }
             break;
         CASE_OP_32_64(nor):
-            if (!temp_is_const(args[1])
-                && temp_is_const(args[2]) && temps[args[2]].val == 0) {
+            if (!temp_is_const(temps, args[1])
+                && temp_is_const(temps, args[2]) && temps[args[2]].val == 0) {
                 i = 1;
                 goto try_not;
             }
             break;
         CASE_OP_32_64(andc):
-            if (!temp_is_const(args[2])
-                && temp_is_const(args[1]) && temps[args[1]].val == -1) {
+            if (!temp_is_const(temps, args[2])
+                && temp_is_const(temps, args[1]) && temps[args[1]].val == -1) {
                 i = 2;
                 goto try_not;
             }
             break;
         CASE_OP_32_64(orc):
         CASE_OP_32_64(eqv):
-            if (!temp_is_const(args[2])
-                && temp_is_const(args[1]) && temps[args[1]].val == 0) {
+            if (!temp_is_const(temps, args[2])
+                && temp_is_const(temps, args[1]) && temps[args[1]].val == 0) {
                 i = 2;
                 goto try_not;
             }
@@ -751,7 +754,7 @@ void tcg_optimize(TCGContext *s)
                     break;
                 }
                 op->opc = not_op;
-                reset_temp(args[0]);
+                reset_temp(temps, args[0]);
                 args[1] = args[i];
                 continue;
             }
@@ -771,18 +774,18 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(or):
         CASE_OP_32_64(xor):
         CASE_OP_32_64(andc):
-            if (!temp_is_const(args[1])
-                && temp_is_const(args[2]) && temps[args[2]].val == 0) {
-                tcg_opt_gen_mov(s, op, args, args[0], args[1]);
+            if (!temp_is_const(temps, args[1])
+                && temp_is_const(temps, args[2]) && temps[args[2]].val == 0) {
+                tcg_opt_gen_mov(s, temps, op, args, args[0], args[1]);
                 continue;
             }
             break;
         CASE_OP_32_64(and):
         CASE_OP_32_64(orc):
         CASE_OP_32_64(eqv):
-            if (!temp_is_const(args[1])
-                && temp_is_const(args[2]) && temps[args[2]].val == -1) {
-                tcg_opt_gen_mov(s, op, args, args[0], args[1]);
+            if (!temp_is_const(temps, args[1])
+                && temp_is_const(temps, args[2]) && temps[args[2]].val == -1) {
+                tcg_opt_gen_mov(s, temps, op, args, args[0], args[1]);
                 continue;
             }
             break;
@@ -819,7 +822,7 @@ void tcg_optimize(TCGContext *s)
 
         CASE_OP_32_64(and):
             mask = temps[args[2]].mask;
-            if (temp_is_const(args[2])) {
+            if (temp_is_const(temps, args[2])) {
         and_const:
                 affected = temps[args[1]].mask & ~mask;
             }
@@ -838,7 +841,7 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(andc):
             /* Known-zeros does not imply known-ones.  Therefore unless
                args[2] is constant, we can't infer anything from it.  */
-            if (temp_is_const(args[2])) {
+            if (temp_is_const(temps, args[2])) {
                 mask = ~temps[args[2]].mask;
                 goto and_const;
             }
@@ -847,26 +850,26 @@ void tcg_optimize(TCGContext *s)
             break;
 
         case INDEX_op_sar_i32:
-            if (temp_is_const(args[2])) {
+            if (temp_is_const(temps, args[2])) {
                 tmp = temps[args[2]].val & 31;
                 mask = (int32_t)temps[args[1]].mask >> tmp;
             }
             break;
         case INDEX_op_sar_i64:
-            if (temp_is_const(args[2])) {
+            if (temp_is_const(temps, args[2])) {
                 tmp = temps[args[2]].val & 63;
                 mask = (int64_t)temps[args[1]].mask >> tmp;
             }
             break;
 
         case INDEX_op_shr_i32:
-            if (temp_is_const(args[2])) {
+            if (temp_is_const(temps, args[2])) {
                 tmp = temps[args[2]].val & 31;
                 mask = (uint32_t)temps[args[1]].mask >> tmp;
             }
             break;
         case INDEX_op_shr_i64:
-            if (temp_is_const(args[2])) {
+            if (temp_is_const(temps, args[2])) {
                 tmp = temps[args[2]].val & 63;
                 mask = (uint64_t)temps[args[1]].mask >> tmp;
             }
@@ -880,7 +883,7 @@ void tcg_optimize(TCGContext *s)
             break;
 
         CASE_OP_32_64(shl):
-            if (temp_is_const(args[2])) {
+            if (temp_is_const(temps, args[2])) {
                 tmp = temps[args[2]].val & (TCG_TARGET_REG_BITS - 1);
                 mask = temps[args[1]].mask << tmp;
             }
@@ -976,12 +979,12 @@ void tcg_optimize(TCGContext *s)
 
         if (partmask == 0) {
             tcg_debug_assert(nb_oargs == 1);
-            tcg_opt_gen_movi(s, op, args, args[0], 0);
+            tcg_opt_gen_movi(s, temps, op, args, args[0], 0);
             continue;
         }
         if (affected == 0) {
             tcg_debug_assert(nb_oargs == 1);
-            tcg_opt_gen_mov(s, op, args, args[0], args[1]);
+            tcg_opt_gen_mov(s, temps, op, args, args[0], args[1]);
             continue;
         }
 
@@ -991,8 +994,8 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(mul):
         CASE_OP_32_64(muluh):
         CASE_OP_32_64(mulsh):
-            if ((temp_is_const(args[2]) && temps[args[2]].val == 0)) {
-                tcg_opt_gen_movi(s, op, args, args[0], 0);
+            if ((temp_is_const(temps, args[2]) && temps[args[2]].val == 0)) {
+                tcg_opt_gen_movi(s, temps, op, args, args[0], 0);
                 continue;
             }
             break;
@@ -1004,8 +1007,8 @@ void tcg_optimize(TCGContext *s)
         switch (opc) {
         CASE_OP_32_64(or):
         CASE_OP_32_64(and):
-            if (temps_are_copies(args[1], args[2])) {
-                tcg_opt_gen_mov(s, op, args, args[0], args[1]);
+            if (temps_are_copies(temps, args[1], args[2])) {
+                tcg_opt_gen_mov(s, temps, op, args, args[0], args[1]);
                 continue;
             }
             break;
@@ -1018,8 +1021,8 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(andc):
         CASE_OP_32_64(sub):
         CASE_OP_32_64(xor):
-            if (temps_are_copies(args[1], args[2])) {
-                tcg_opt_gen_movi(s, op, args, args[0], 0);
+            if (temps_are_copies(temps, args[1], args[2])) {
+                tcg_opt_gen_movi(s, temps, op, args, args[0], 0);
                 continue;
             }
             break;
@@ -1032,10 +1035,10 @@ void tcg_optimize(TCGContext *s)
            allocator where needed and possible.  Also detect copies. */
         switch (opc) {
         CASE_OP_32_64(mov):
-            tcg_opt_gen_mov(s, op, args, args[0], args[1]);
+            tcg_opt_gen_mov(s, temps, op, args, args[0], args[1]);
             break;
         CASE_OP_32_64(movi):
-            tcg_opt_gen_movi(s, op, args, args[0], args[1]);
+            tcg_opt_gen_movi(s, temps, op, args, args[0], args[1]);
             break;
 
         CASE_OP_32_64(not):
@@ -1051,9 +1054,9 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_extu_i32_i64:
         case INDEX_op_extrl_i64_i32:
         case INDEX_op_extrh_i64_i32:
-            if (temp_is_const(args[1])) {
+            if (temp_is_const(temps, args[1])) {
                 tmp = do_constant_folding(opc, temps[args[1]].val, 0);
-                tcg_opt_gen_movi(s, op, args, args[0], tmp);
+                tcg_opt_gen_movi(s, temps, op, args, args[0], tmp);
                 break;
             }
             goto do_default;
@@ -1080,66 +1083,70 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(divu):
         CASE_OP_32_64(rem):
         CASE_OP_32_64(remu):
-            if (temp_is_const(args[1]) && temp_is_const(args[2])) {
+            if (temp_is_const(temps, args[1]) &&
+                temp_is_const(temps, args[2])) {
                 tmp = do_constant_folding(opc, temps[args[1]].val,
                                           temps[args[2]].val);
-                tcg_opt_gen_movi(s, op, args, args[0], tmp);
+                tcg_opt_gen_movi(s, temps, op, args, args[0], tmp);
                 break;
             }
             goto do_default;
 
         CASE_OP_32_64(clz):
         CASE_OP_32_64(ctz):
-            if (temp_is_const(args[1])) {
+            if (temp_is_const(temps, args[1])) {
                 TCGArg v = temps[args[1]].val;
                 if (v != 0) {
                     tmp = do_constant_folding(opc, v, 0);
-                    tcg_opt_gen_movi(s, op, args, args[0], tmp);
+                    tcg_opt_gen_movi(s, temps, op, args, args[0], tmp);
                 } else {
-                    tcg_opt_gen_mov(s, op, args, args[0], args[2]);
+                    tcg_opt_gen_mov(s, temps, op, args, args[0], args[2]);
                 }
                 break;
             }
             goto do_default;
 
         CASE_OP_32_64(deposit):
-            if (temp_is_const(args[1]) && temp_is_const(args[2])) {
+            if (temp_is_const(temps, args[1]) &&
+                temp_is_const(temps, args[2])) {
                 tmp = deposit64(temps[args[1]].val, args[3], args[4],
                                 temps[args[2]].val);
-                tcg_opt_gen_movi(s, op, args, args[0], tmp);
+                tcg_opt_gen_movi(s, temps, op, args, args[0], tmp);
                 break;
             }
             goto do_default;
 
         CASE_OP_32_64(extract):
-            if (temp_is_const(args[1])) {
+            if (temp_is_const(temps, args[1])) {
                 tmp = extract64(temps[args[1]].val, args[2], args[3]);
-                tcg_opt_gen_movi(s, op, args, args[0], tmp);
+                tcg_opt_gen_movi(s, temps, op, args, args[0], tmp);
                 break;
             }
             goto do_default;
 
         CASE_OP_32_64(sextract):
-            if (temp_is_const(args[1])) {
+            if (temp_is_const(temps, args[1])) {
                 tmp = sextract64(temps[args[1]].val, args[2], args[3]);
-                tcg_opt_gen_movi(s, op, args, args[0], tmp);
+                tcg_opt_gen_movi(s, temps, op, args, args[0], tmp);
                 break;
             }
             goto do_default;
 
         CASE_OP_32_64(setcond):
-            tmp = do_constant_folding_cond(opc, args[1], args[2], args[3]);
+            tmp = do_constant_folding_cond(temps, opc, args[1], args[2],
+                                           args[3]);
             if (tmp != 2) {
-                tcg_opt_gen_movi(s, op, args, args[0], tmp);
+                tcg_opt_gen_movi(s, temps, op, args, args[0], tmp);
                 break;
             }
             goto do_default;
 
         CASE_OP_32_64(brcond):
-            tmp = do_constant_folding_cond(opc, args[0], args[1], args[2]);
+            tmp = do_constant_folding_cond(temps, opc, args[0], args[1],
+                                           args[2]);
             if (tmp != 2) {
                 if (tmp) {
-                    reset_all_temps(nb_temps);
+                    bitmap_zero(temps_used, nb_temps);
                     op->opc = INDEX_op_br;
                     args[0] = args[3];
                 } else {
@@ -1150,12 +1157,14 @@ void tcg_optimize(TCGContext *s)
             goto do_default;
 
         CASE_OP_32_64(movcond):
-            tmp = do_constant_folding_cond(opc, args[1], args[2], args[5]);
+            tmp = do_constant_folding_cond(temps, opc, args[1], args[2],
+                                           args[5]);
             if (tmp != 2) {
-                tcg_opt_gen_mov(s, op, args, args[0], args[4-tmp]);
+                tcg_opt_gen_mov(s, temps, op, args, args[0], args[4 - tmp]);
                 break;
             }
-            if (temp_is_const(args[3]) && temp_is_const(args[4])) {
+            if (temp_is_const(temps, args[3]) &&
+                temp_is_const(temps, args[4])) {
                 tcg_target_ulong tv = temps[args[3]].val;
                 tcg_target_ulong fv = temps[args[4]].val;
                 TCGCond cond = args[5];
@@ -1174,8 +1183,10 @@ void tcg_optimize(TCGContext *s)
 
         case INDEX_op_add2_i32:
         case INDEX_op_sub2_i32:
-            if (temp_is_const(args[2]) && temp_is_const(args[3])
-                && temp_is_const(args[4]) && temp_is_const(args[5])) {
+            if (temp_is_const(temps, args[2]) &&
+                temp_is_const(temps, args[3]) &&
+                temp_is_const(temps, args[4]) &&
+                temp_is_const(temps, args[5])) {
                 uint32_t al = temps[args[2]].val;
                 uint32_t ah = temps[args[3]].val;
                 uint32_t bl = temps[args[4]].val;
@@ -1194,8 +1205,8 @@ void tcg_optimize(TCGContext *s)
 
                 rl = args[0];
                 rh = args[1];
-                tcg_opt_gen_movi(s, op, args, rl, (int32_t)a);
-                tcg_opt_gen_movi(s, op2, args2, rh, (int32_t)(a >> 32));
+                tcg_opt_gen_movi(s, temps, op, args, rl, (int32_t)a);
+                tcg_opt_gen_movi(s, temps, op2, args2, rh, (int32_t)(a >> 32));
 
                 /* We've done all we need to do with the movi.  Skip it.  */
                 oi_next = op2->next;
@@ -1204,7 +1215,8 @@ void tcg_optimize(TCGContext *s)
             goto do_default;
 
         case INDEX_op_mulu2_i32:
-            if (temp_is_const(args[2]) && temp_is_const(args[3])) {
+            if (temp_is_const(temps, args[2]) &&
+                temp_is_const(temps, args[3])) {
                 uint32_t a = temps[args[2]].val;
                 uint32_t b = temps[args[3]].val;
                 uint64_t r = (uint64_t)a * b;
@@ -1214,8 +1226,8 @@ void tcg_optimize(TCGContext *s)
 
                 rl = args[0];
                 rh = args[1];
-                tcg_opt_gen_movi(s, op, args, rl, (int32_t)r);
-                tcg_opt_gen_movi(s, op2, args2, rh, (int32_t)(r >> 32));
+                tcg_opt_gen_movi(s, temps, op, args, rl, (int32_t)r);
+                tcg_opt_gen_movi(s, temps, op2, args2, rh, (int32_t)(r >> 32));
 
                 /* We've done all we need to do with the movi.  Skip it.  */
                 oi_next = op2->next;
@@ -1224,11 +1236,11 @@ void tcg_optimize(TCGContext *s)
             goto do_default;
 
         case INDEX_op_brcond2_i32:
-            tmp = do_constant_folding_cond2(&args[0], &args[2], args[4]);
+            tmp = do_constant_folding_cond2(temps, &args[0], &args[2], args[4]);
             if (tmp != 2) {
                 if (tmp) {
             do_brcond_true:
-                    reset_all_temps(nb_temps);
+                    bitmap_zero(temps_used, nb_temps);
                     op->opc = INDEX_op_br;
                     args[0] = args[5];
                 } else {
@@ -1236,12 +1248,14 @@ void tcg_optimize(TCGContext *s)
                     tcg_op_remove(s, op);
                 }
             } else if ((args[4] == TCG_COND_LT || args[4] == TCG_COND_GE)
-                       && temp_is_const(args[2]) && temps[args[2]].val == 0
-                       && temp_is_const(args[3]) && temps[args[3]].val == 0) {
+                       && temp_is_const(temps, args[2])
+                       && temps[args[2]].val == 0
+                       && temp_is_const(temps, args[3])
+                       && temps[args[3]].val == 0) {
                 /* Simplify LT/GE comparisons vs zero to a single compare
                    vs the high word of the input.  */
             do_brcond_high:
-                reset_all_temps(nb_temps);
+                bitmap_zero(temps_used, nb_temps);
                 op->opc = INDEX_op_brcond_i32;
                 args[0] = args[1];
                 args[1] = args[3];
@@ -1250,14 +1264,14 @@ void tcg_optimize(TCGContext *s)
             } else if (args[4] == TCG_COND_EQ) {
                 /* Simplify EQ comparisons where one of the pairs
                    can be simplified.  */
-                tmp = do_constant_folding_cond(INDEX_op_brcond_i32,
+                tmp = do_constant_folding_cond(temps, INDEX_op_brcond_i32,
                                                args[0], args[2], TCG_COND_EQ);
                 if (tmp == 0) {
                     goto do_brcond_false;
                 } else if (tmp == 1) {
                     goto do_brcond_high;
                 }
-                tmp = do_constant_folding_cond(INDEX_op_brcond_i32,
+                tmp = do_constant_folding_cond(temps, INDEX_op_brcond_i32,
                                                args[1], args[3], TCG_COND_EQ);
                 if (tmp == 0) {
                     goto do_brcond_false;
@@ -1265,7 +1279,7 @@ void tcg_optimize(TCGContext *s)
                     goto do_default;
                 }
             do_brcond_low:
-                reset_all_temps(nb_temps);
+                bitmap_zero(temps_used, nb_temps);
                 op->opc = INDEX_op_brcond_i32;
                 args[1] = args[2];
                 args[2] = args[4];
@@ -1273,14 +1287,14 @@ void tcg_optimize(TCGContext *s)
             } else if (args[4] == TCG_COND_NE) {
                 /* Simplify NE comparisons where one of the pairs
                    can be simplified.  */
-                tmp = do_constant_folding_cond(INDEX_op_brcond_i32,
+                tmp = do_constant_folding_cond(temps, INDEX_op_brcond_i32,
                                                args[0], args[2], TCG_COND_NE);
                 if (tmp == 0) {
                     goto do_brcond_high;
                 } else if (tmp == 1) {
                     goto do_brcond_true;
                 }
-                tmp = do_constant_folding_cond(INDEX_op_brcond_i32,
+                tmp = do_constant_folding_cond(temps, INDEX_op_brcond_i32,
                                                args[1], args[3], TCG_COND_NE);
                 if (tmp == 0) {
                     goto do_brcond_low;
@@ -1294,17 +1308,19 @@ void tcg_optimize(TCGContext *s)
             break;
 
         case INDEX_op_setcond2_i32:
-            tmp = do_constant_folding_cond2(&args[1], &args[3], args[5]);
+            tmp = do_constant_folding_cond2(temps, &args[1], &args[3], args[5]);
             if (tmp != 2) {
             do_setcond_const:
-                tcg_opt_gen_movi(s, op, args, args[0], tmp);
+                tcg_opt_gen_movi(s, temps, op, args, args[0], tmp);
             } else if ((args[5] == TCG_COND_LT || args[5] == TCG_COND_GE)
-                       && temp_is_const(args[3]) && temps[args[3]].val == 0
-                       && temp_is_const(args[4]) && temps[args[4]].val == 0) {
+                       && temp_is_const(temps, args[3])
+                       && temps[args[3]].val == 0
+                       && temp_is_const(temps, args[4])
+                       && temps[args[4]].val == 0) {
                 /* Simplify LT/GE comparisons vs zero to a single compare
                    vs the high word of the input.  */
             do_setcond_high:
-                reset_temp(args[0]);
+                reset_temp(temps, args[0]);
                 temps[args[0]].mask = 1;
                 op->opc = INDEX_op_setcond_i32;
                 args[1] = args[2];
@@ -1313,14 +1329,14 @@ void tcg_optimize(TCGContext *s)
             } else if (args[5] == TCG_COND_EQ) {
                 /* Simplify EQ comparisons where one of the pairs
                    can be simplified.  */
-                tmp = do_constant_folding_cond(INDEX_op_setcond_i32,
+                tmp = do_constant_folding_cond(temps, INDEX_op_setcond_i32,
                                                args[1], args[3], TCG_COND_EQ);
                 if (tmp == 0) {
                     goto do_setcond_const;
                 } else if (tmp == 1) {
                     goto do_setcond_high;
                 }
-                tmp = do_constant_folding_cond(INDEX_op_setcond_i32,
+                tmp = do_constant_folding_cond(temps, INDEX_op_setcond_i32,
                                                args[2], args[4], TCG_COND_EQ);
                 if (tmp == 0) {
                     goto do_setcond_high;
@@ -1328,7 +1344,7 @@ void tcg_optimize(TCGContext *s)
                     goto do_default;
                 }
             do_setcond_low:
-                reset_temp(args[0]);
+                reset_temp(temps, args[0]);
                 temps[args[0]].mask = 1;
                 op->opc = INDEX_op_setcond_i32;
                 args[2] = args[3];
@@ -1336,14 +1352,14 @@ void tcg_optimize(TCGContext *s)
             } else if (args[5] == TCG_COND_NE) {
                 /* Simplify NE comparisons where one of the pairs
                    can be simplified.  */
-                tmp = do_constant_folding_cond(INDEX_op_setcond_i32,
+                tmp = do_constant_folding_cond(temps, INDEX_op_setcond_i32,
                                                args[1], args[3], TCG_COND_NE);
                 if (tmp == 0) {
                     goto do_setcond_high;
                 } else if (tmp == 1) {
                     goto do_setcond_const;
                 }
-                tmp = do_constant_folding_cond(INDEX_op_setcond_i32,
+                tmp = do_constant_folding_cond(temps, INDEX_op_setcond_i32,
                                                args[2], args[4], TCG_COND_NE);
                 if (tmp == 0) {
                     goto do_setcond_low;
@@ -1360,8 +1376,8 @@ void tcg_optimize(TCGContext *s)
             if (!(args[nb_oargs + nb_iargs + 1]
                   & (TCG_CALL_NO_READ_GLOBALS | TCG_CALL_NO_WRITE_GLOBALS))) {
                 for (i = 0; i < nb_globals; i++) {
-                    if (test_bit(i, temps_used.l)) {
-                        reset_temp(i);
+                    if (test_bit(i, temps_used)) {
+                        reset_temp(temps, i);
                     }
                 }
             }
@@ -1375,11 +1391,11 @@ void tcg_optimize(TCGContext *s)
                block, otherwise we only trash the output args.  "mask" is
                the non-zero bits mask for the first output arg.  */
             if (def->flags & TCG_OPF_BB_END) {
-                reset_all_temps(nb_temps);
+                bitmap_zero(temps_used, nb_temps);
             } else {
         do_reset_output:
                 for (i = 0; i < nb_oargs; i++) {
-                    reset_temp(args[i]);
+                    reset_temp(temps, args[i]);
                     /* Save the corresponding known-zero bits mask for the
                        first output argument (only one supported so far). */
                     if (i == 0) {
-- 
2.7.4
