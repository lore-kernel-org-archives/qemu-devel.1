Received: from eggs.gnu.org ([2001:4830:134:3::10]:52866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49Af-0002u3-Am
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:27:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49Ad-000462-Ei
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:27:21 -0400
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230]:54268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e49Ad-00044r-7a
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:27:19 -0400
Received: by mail-pf0-x230.google.com with SMTP id t188so13795001pfd.10
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 10:27:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 16 Oct 2017 10:26:05 -0700
Message-Id: <20171016172609.23422-47-richard.henderson@linaro.org>
In-Reply-To: <20171016172609.23422-1-richard.henderson@linaro.org>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 46/50] tcg: allocate optimizer temps with
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
Cc: cota@braap.org

From: "Emilio G. Cota" <cota@braap.org>

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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index ead7bb5e4f..847dfa44c9 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -40,9 +40,6 @@ struct tcg_temp_info {
     tcg_target_ulong mask;
 };
 
-static struct tcg_temp_info temps_[TCG_MAX_TEMPS];
-static TCGTempSet temps_used;
-
 static inline struct tcg_temp_info *ts_info(TCGTemp *ts)
 {
     return ts->state_ptr;
@@ -93,31 +90,27 @@ static void reset_temp(TCGArg arg)
     reset_ts(arg_temp(arg));
 }
 
-/* Reset all temporaries, given that there are NB_TEMPS of them.  */
-static void reset_all_temps(int nb_temps)
-{
-    bitmap_zero(temps_used.l, nb_temps);
-}
-
 /* Initialize and activate a temporary.  */
-static void init_ts_info(TCGTemp *ts)
+static void init_ts_info(struct tcg_temp_info *infos,
+                         TCGTempSet *temps_used, TCGTemp *ts)
 {
     size_t idx = temp_idx(ts);
-    if (!test_bit(idx, temps_used.l)) {
-        struct tcg_temp_info *ti = &temps_[idx];
+    if (!test_bit(idx, temps_used->l)) {
+        struct tcg_temp_info *ti = &infos[idx];
 
         ts->state_ptr = ti;
         ti->next_copy = ts;
         ti->prev_copy = ts;
         ti->is_const = false;
         ti->mask = -1;
-        set_bit(idx, temps_used.l);
+        set_bit(idx, temps_used->l);
     }
 }
 
-static void init_arg_info(TCGArg arg)
+static void init_arg_info(struct tcg_temp_info *infos,
+                          TCGTempSet *temps_used, TCGArg arg)
 {
-    init_ts_info(arg_temp(arg));
+    init_ts_info(infos, temps_used, arg_temp(arg));
 }
 
 static int op_bits(TCGOpcode op)
@@ -616,6 +609,8 @@ void tcg_optimize(TCGContext *s)
 {
     int oi, oi_next, nb_temps, nb_globals;
     TCGOp *prev_mb = NULL;
+    struct tcg_temp_info *infos;
+    TCGTempSet temps_used;
 
     /* Array VALS has an element for each temp.
        If this temp holds a constant then its value is kept in VALS' element.
@@ -624,7 +619,8 @@ void tcg_optimize(TCGContext *s)
 
     nb_temps = s->nb_temps;
     nb_globals = s->nb_globals;
-    reset_all_temps(nb_temps);
+    bitmap_zero(temps_used.l, nb_temps);
+    infos = tcg_malloc(sizeof(struct tcg_temp_info) * nb_temps);
 
     for (oi = s->gen_op_buf[0].next; oi != 0; oi = oi_next) {
         tcg_target_ulong mask, partmask, affected;
@@ -645,14 +641,14 @@ void tcg_optimize(TCGContext *s)
             for (i = 0; i < nb_oargs + nb_iargs; i++) {
                 TCGTemp *ts = arg_temp(op->args[i]);
                 if (ts) {
-                    init_ts_info(ts);
+                    init_ts_info(infos, &temps_used, ts);
                 }
             }
         } else {
             nb_oargs = def->nb_oargs;
             nb_iargs = def->nb_iargs;
             for (i = 0; i < nb_oargs + nb_iargs; i++) {
-                init_arg_info(op->args[i]);
+                init_arg_info(infos, &temps_used, op->args[i]);
             }
         }
 
@@ -1213,7 +1209,7 @@ void tcg_optimize(TCGContext *s)
                                            op->args[1], op->args[2]);
             if (tmp != 2) {
                 if (tmp) {
-                    reset_all_temps(nb_temps);
+                    bitmap_zero(temps_used.l, nb_temps);
                     op->opc = INDEX_op_br;
                     op->args[0] = op->args[3];
                 } else {
@@ -1302,7 +1298,7 @@ void tcg_optimize(TCGContext *s)
             if (tmp != 2) {
                 if (tmp) {
             do_brcond_true:
-                    reset_all_temps(nb_temps);
+                    bitmap_zero(temps_used.l, nb_temps);
                     op->opc = INDEX_op_br;
                     op->args[0] = op->args[5];
                 } else {
@@ -1318,7 +1314,7 @@ void tcg_optimize(TCGContext *s)
                 /* Simplify LT/GE comparisons vs zero to a single compare
                    vs the high word of the input.  */
             do_brcond_high:
-                reset_all_temps(nb_temps);
+                bitmap_zero(temps_used.l, nb_temps);
                 op->opc = INDEX_op_brcond_i32;
                 op->args[0] = op->args[1];
                 op->args[1] = op->args[3];
@@ -1344,7 +1340,7 @@ void tcg_optimize(TCGContext *s)
                     goto do_default;
                 }
             do_brcond_low:
-                reset_all_temps(nb_temps);
+                bitmap_zero(temps_used.l, nb_temps);
                 op->opc = INDEX_op_brcond_i32;
                 op->args[1] = op->args[2];
                 op->args[2] = op->args[4];
@@ -1464,7 +1460,7 @@ void tcg_optimize(TCGContext *s)
                block, otherwise we only trash the output args.  "mask" is
                the non-zero bits mask for the first output arg.  */
             if (def->flags & TCG_OPF_BB_END) {
-                reset_all_temps(nb_temps);
+                bitmap_zero(temps_used.l, nb_temps);
             } else {
         do_reset_output:
                 for (i = 0; i < nb_oargs; i++) {
-- 
2.13.6
