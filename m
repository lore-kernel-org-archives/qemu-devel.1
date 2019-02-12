Received: from eggs.gnu.org ([209.51.188.92]:49790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtQ95-0002nR-L6
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:58:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtQ8n-0001sm-CW
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:58:08 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:32960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtQ8l-0001TG-6K
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:57:52 -0500
Received: by mail-pl1-x642.google.com with SMTP id y10so705440plp.0
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 20:57:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 20:56:58 -0800
Message-Id: <20190212045721.28041-2-richard.henderson@linaro.org>
In-Reply-To: <20190212045721.28041-1-richard.henderson@linaro.org>
References: <20190212045721.28041-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 01/24] target/hppa: Use DisasContextBase.is_jmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Instead of returning DisasJumpType, immediately store it.
Return true in preparation for conversion to the decodetree script.

Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Sven Schnelle <svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 1011 ++++++++++++++++++++-------------------
 1 file changed, 528 insertions(+), 483 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 51bfd9849d..a4f253a022 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -278,10 +278,6 @@ typedef struct DisasContext {
     bool psw_n_nonzero;
 } DisasContext;
 
-/* Target-specific return values from translate_one, indicating the
-   state of the TB.  Note that DISAS_NEXT indicates that we are not
-   exiting the TB.  */
-
 /* We are not using a goto_tb (for whatever reason), but have updated
    the iaq (for whatever reason), so don't do it again on exit.  */
 #define DISAS_IAQ_N_UPDATED  DISAS_TARGET_0
@@ -296,8 +292,8 @@ typedef struct DisasContext {
 
 typedef struct DisasInsn {
     uint32_t insn, mask;
-    DisasJumpType (*trans)(DisasContext *ctx, uint32_t insn,
-                           const struct DisasInsn *f);
+    bool (*trans)(DisasContext *ctx, uint32_t insn,
+                  const struct DisasInsn *f);
     union {
         void (*ttt)(TCGv_reg, TCGv_reg, TCGv_reg);
         void (*weww)(TCGv_i32, TCGv_env, TCGv_i32, TCGv_i32);
@@ -666,9 +662,10 @@ static void nullify_set(DisasContext *ctx, bool x)
 
 /* Mark the end of an instruction that may have been nullified.
    This is the pair to nullify_over.  */
-static DisasJumpType nullify_end(DisasContext *ctx, DisasJumpType status)
+static bool nullify_end(DisasContext *ctx)
 {
     TCGLabel *null_lab = ctx->null_lab;
+    DisasJumpType status = ctx->base.is_jmp;
 
     /* For NEXT, NORETURN, STALE, we can easily continue (or exit).
        For UPDATED, we cannot update on the nullified path.  */
@@ -678,7 +675,7 @@ static DisasJumpType nullify_end(DisasContext *ctx, DisasJumpType status)
         /* The current insn wasn't conditional or handled the condition
            applied to it without a branch, so the (new) setting of
            NULL_COND can be applied directly to the next insn.  */
-        return status;
+        return true;
     }
     ctx->null_lab = NULL;
 
@@ -696,9 +693,9 @@ static DisasJumpType nullify_end(DisasContext *ctx, DisasJumpType status)
         ctx->null_cond = cond_make_n();
     }
     if (status == DISAS_NORETURN) {
-        status = DISAS_NEXT;
+        ctx->base.is_jmp = DISAS_NEXT;
     }
-    return status;
+    return true;
 }
 
 static void copy_iaoq_entry(TCGv_reg dest, target_ureg ival, TCGv_reg vval)
@@ -722,41 +719,44 @@ static void gen_excp_1(int exception)
     tcg_temp_free_i32(t);
 }
 
-static DisasJumpType gen_excp(DisasContext *ctx, int exception)
+static void gen_excp(DisasContext *ctx, int exception)
 {
     copy_iaoq_entry(cpu_iaoq_f, ctx->iaoq_f, cpu_iaoq_f);
     copy_iaoq_entry(cpu_iaoq_b, ctx->iaoq_b, cpu_iaoq_b);
     nullify_save(ctx);
     gen_excp_1(exception);
-    return DISAS_NORETURN;
+    ctx->base.is_jmp = DISAS_NORETURN;
 }
 
-static DisasJumpType gen_excp_iir(DisasContext *ctx, int exc)
+static bool gen_excp_iir(DisasContext *ctx, int exc)
 {
-    TCGv_reg tmp = tcg_const_reg(ctx->insn);
+    TCGv_reg tmp;
+
+    nullify_over(ctx);
+    tmp = tcg_const_reg(ctx->insn);
     tcg_gen_st_reg(tmp, cpu_env, offsetof(CPUHPPAState, cr[CR_IIR]));
     tcg_temp_free(tmp);
-    return gen_excp(ctx, exc);
+    gen_excp(ctx, exc);
+    return nullify_end(ctx);
 }
 
-static DisasJumpType gen_illegal(DisasContext *ctx)
+static bool gen_illegal(DisasContext *ctx)
 {
-    nullify_over(ctx);
-    return nullify_end(ctx, gen_excp_iir(ctx, EXCP_ILL));
+    return gen_excp_iir(ctx, EXCP_ILL);
 }
 
-#define CHECK_MOST_PRIVILEGED(EXCP)                               \
-    do {                                                          \
-        if (ctx->privilege != 0) {                                \
-            nullify_over(ctx);                                    \
-            return nullify_end(ctx, gen_excp_iir(ctx, EXCP));     \
-        }                                                         \
+#define CHECK_MOST_PRIVILEGED(EXCP)          \
+    do {                                     \
+        if (ctx->privilege != 0) {           \
+            return gen_excp_iir(ctx, EXCP);  \
+        }                                    \
     } while (0)
 
 static bool use_goto_tb(DisasContext *ctx, target_ureg dest)
 {
     /* Suppress goto_tb in the case of single-steping and IO.  */
-    if ((tb_cflags(ctx->base.tb) & CF_LAST_IO) || ctx->base.singlestep_enabled) {
+    if ((tb_cflags(ctx->base.tb) & CF_LAST_IO)
+        || ctx->base.singlestep_enabled) {
         return false;
     }
     return true;
@@ -1119,9 +1119,9 @@ static TCGv_reg do_sub_sv(DisasContext *ctx, TCGv_reg res,
     return sv;
 }
 
-static DisasJumpType do_add(DisasContext *ctx, unsigned rt, TCGv_reg in1,
-                            TCGv_reg in2, unsigned shift, bool is_l,
-                            bool is_tsv, bool is_tc, bool is_c, unsigned cf)
+static void do_add(DisasContext *ctx, unsigned rt, TCGv_reg in1,
+                   TCGv_reg in2, unsigned shift, bool is_l,
+                   bool is_tsv, bool is_tc, bool is_c, unsigned cf)
 {
     TCGv_reg dest, cb, cb_msb, sv, tmp;
     unsigned c = cf >> 1;
@@ -1188,12 +1188,11 @@ static DisasJumpType do_add(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     ctx->null_cond = cond;
-    return DISAS_NEXT;
 }
 
-static DisasJumpType do_sub(DisasContext *ctx, unsigned rt, TCGv_reg in1,
-                            TCGv_reg in2, bool is_tsv, bool is_b,
-                            bool is_tc, unsigned cf)
+static void do_sub(DisasContext *ctx, unsigned rt, TCGv_reg in1,
+                   TCGv_reg in2, bool is_tsv, bool is_b,
+                   bool is_tc, unsigned cf)
 {
     TCGv_reg dest, sv, cb, cb_msb, zero, tmp;
     unsigned c = cf >> 1;
@@ -1255,11 +1254,10 @@ static DisasJumpType do_sub(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     ctx->null_cond = cond;
-    return DISAS_NEXT;
 }
 
-static DisasJumpType do_cmpclr(DisasContext *ctx, unsigned rt, TCGv_reg in1,
-                               TCGv_reg in2, unsigned cf)
+static void do_cmpclr(DisasContext *ctx, unsigned rt, TCGv_reg in1,
+                      TCGv_reg in2, unsigned cf)
 {
     TCGv_reg dest, sv;
     DisasCond cond;
@@ -1284,12 +1282,11 @@ static DisasJumpType do_cmpclr(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     ctx->null_cond = cond;
-    return DISAS_NEXT;
 }
 
-static DisasJumpType do_log(DisasContext *ctx, unsigned rt, TCGv_reg in1,
-                            TCGv_reg in2, unsigned cf,
-                            void (*fn)(TCGv_reg, TCGv_reg, TCGv_reg))
+static void do_log(DisasContext *ctx, unsigned rt, TCGv_reg in1,
+                   TCGv_reg in2, unsigned cf,
+                   void (*fn)(TCGv_reg, TCGv_reg, TCGv_reg))
 {
     TCGv_reg dest = dest_gpr(ctx, rt);
 
@@ -1302,12 +1299,11 @@ static DisasJumpType do_log(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     if (cf) {
         ctx->null_cond = do_log_cond(cf, dest);
     }
-    return DISAS_NEXT;
 }
 
-static DisasJumpType do_unit(DisasContext *ctx, unsigned rt, TCGv_reg in1,
-                             TCGv_reg in2, unsigned cf, bool is_tc,
-                             void (*fn)(TCGv_reg, TCGv_reg, TCGv_reg))
+static void do_unit(DisasContext *ctx, unsigned rt, TCGv_reg in1,
+                    TCGv_reg in2, unsigned cf, bool is_tc,
+                    void (*fn)(TCGv_reg, TCGv_reg, TCGv_reg))
 {
     TCGv_reg dest;
     DisasCond cond;
@@ -1335,7 +1331,6 @@ static DisasJumpType do_unit(DisasContext *ctx, unsigned rt, TCGv_reg in1,
         cond_free(&ctx->null_cond);
         ctx->null_cond = cond;
     }
-    return DISAS_NEXT;
 }
 
 #ifndef CONFIG_USER_ONLY
@@ -1498,9 +1493,9 @@ static void do_store_64(DisasContext *ctx, TCGv_i64 src, unsigned rb,
 #define do_store_reg  do_store_32
 #endif
 
-static DisasJumpType do_load(DisasContext *ctx, unsigned rt, unsigned rb,
-                             unsigned rx, int scale, target_sreg disp,
-                             unsigned sp, int modify, TCGMemOp mop)
+static void do_load(DisasContext *ctx, unsigned rt, unsigned rb,
+                    unsigned rx, int scale, target_sreg disp,
+                    unsigned sp, int modify, TCGMemOp mop)
 {
     TCGv_reg dest;
 
@@ -1516,12 +1511,12 @@ static DisasJumpType do_load(DisasContext *ctx, unsigned rt, unsigned rb,
     do_load_reg(ctx, dest, rb, rx, scale, disp, sp, modify, mop);
     save_gpr(ctx, rt, dest);
 
-    return nullify_end(ctx, DISAS_NEXT);
+    nullify_end(ctx);
 }
 
-static DisasJumpType do_floadw(DisasContext *ctx, unsigned rt, unsigned rb,
-                               unsigned rx, int scale, target_sreg disp,
-                               unsigned sp, int modify)
+static void do_floadw(DisasContext *ctx, unsigned rt, unsigned rb,
+                      unsigned rx, int scale, target_sreg disp,
+                      unsigned sp, int modify)
 {
     TCGv_i32 tmp;
 
@@ -1536,12 +1531,12 @@ static DisasJumpType do_floadw(DisasContext *ctx, unsigned rt, unsigned rb,
         gen_helper_loaded_fr0(cpu_env);
     }
 
-    return nullify_end(ctx, DISAS_NEXT);
+    nullify_end(ctx);
 }
 
-static DisasJumpType do_floadd(DisasContext *ctx, unsigned rt, unsigned rb,
-                               unsigned rx, int scale, target_sreg disp,
-                               unsigned sp, int modify)
+static void do_floadd(DisasContext *ctx, unsigned rt, unsigned rb,
+                      unsigned rx, int scale, target_sreg disp,
+                      unsigned sp, int modify)
 {
     TCGv_i64 tmp;
 
@@ -1556,21 +1551,21 @@ static DisasJumpType do_floadd(DisasContext *ctx, unsigned rt, unsigned rb,
         gen_helper_loaded_fr0(cpu_env);
     }
 
-    return nullify_end(ctx, DISAS_NEXT);
+    nullify_end(ctx);
 }
 
-static DisasJumpType do_store(DisasContext *ctx, unsigned rt, unsigned rb,
-                              target_sreg disp, unsigned sp,
-                              int modify, TCGMemOp mop)
+static void do_store(DisasContext *ctx, unsigned rt, unsigned rb,
+                     target_sreg disp, unsigned sp,
+                     int modify, TCGMemOp mop)
 {
     nullify_over(ctx);
     do_store_reg(ctx, load_gpr(ctx, rt), rb, 0, 0, disp, sp, modify, mop);
-    return nullify_end(ctx, DISAS_NEXT);
+    nullify_end(ctx);
 }
 
-static DisasJumpType do_fstorew(DisasContext *ctx, unsigned rt, unsigned rb,
-                                unsigned rx, int scale, target_sreg disp,
-                                unsigned sp, int modify)
+static void do_fstorew(DisasContext *ctx, unsigned rt, unsigned rb,
+                       unsigned rx, int scale, target_sreg disp,
+                       unsigned sp, int modify)
 {
     TCGv_i32 tmp;
 
@@ -1580,12 +1575,12 @@ static DisasJumpType do_fstorew(DisasContext *ctx, unsigned rt, unsigned rb,
     do_store_32(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TEUL);
     tcg_temp_free_i32(tmp);
 
-    return nullify_end(ctx, DISAS_NEXT);
+    nullify_end(ctx);
 }
 
-static DisasJumpType do_fstored(DisasContext *ctx, unsigned rt, unsigned rb,
-                                unsigned rx, int scale, target_sreg disp,
-                                unsigned sp, int modify)
+static void do_fstored(DisasContext *ctx, unsigned rt, unsigned rb,
+                       unsigned rx, int scale, target_sreg disp,
+                       unsigned sp, int modify)
 {
     TCGv_i64 tmp;
 
@@ -1595,11 +1590,11 @@ static DisasJumpType do_fstored(DisasContext *ctx, unsigned rt, unsigned rb,
     do_store_64(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TEQ);
     tcg_temp_free_i64(tmp);
 
-    return nullify_end(ctx, DISAS_NEXT);
+    nullify_end(ctx);
 }
 
-static DisasJumpType do_fop_wew(DisasContext *ctx, unsigned rt, unsigned ra,
-                                void (*func)(TCGv_i32, TCGv_env, TCGv_i32))
+static void do_fop_wew(DisasContext *ctx, unsigned rt, unsigned ra,
+                       void (*func)(TCGv_i32, TCGv_env, TCGv_i32))
 {
     TCGv_i32 tmp;
 
@@ -1610,11 +1605,11 @@ static DisasJumpType do_fop_wew(DisasContext *ctx, unsigned rt, unsigned ra,
 
     save_frw_i32(rt, tmp);
     tcg_temp_free_i32(tmp);
-    return nullify_end(ctx, DISAS_NEXT);
+    nullify_end(ctx);
 }
 
-static DisasJumpType do_fop_wed(DisasContext *ctx, unsigned rt, unsigned ra,
-                                void (*func)(TCGv_i32, TCGv_env, TCGv_i64))
+static void do_fop_wed(DisasContext *ctx, unsigned rt, unsigned ra,
+                       void (*func)(TCGv_i32, TCGv_env, TCGv_i64))
 {
     TCGv_i32 dst;
     TCGv_i64 src;
@@ -1628,11 +1623,11 @@ static DisasJumpType do_fop_wed(DisasContext *ctx, unsigned rt, unsigned ra,
     tcg_temp_free_i64(src);
     save_frw_i32(rt, dst);
     tcg_temp_free_i32(dst);
-    return nullify_end(ctx, DISAS_NEXT);
+    nullify_end(ctx);
 }
 
-static DisasJumpType do_fop_ded(DisasContext *ctx, unsigned rt, unsigned ra,
-                                void (*func)(TCGv_i64, TCGv_env, TCGv_i64))
+static void do_fop_ded(DisasContext *ctx, unsigned rt, unsigned ra,
+                       void (*func)(TCGv_i64, TCGv_env, TCGv_i64))
 {
     TCGv_i64 tmp;
 
@@ -1643,11 +1638,11 @@ static DisasJumpType do_fop_ded(DisasContext *ctx, unsigned rt, unsigned ra,
 
     save_frd(rt, tmp);
     tcg_temp_free_i64(tmp);
-    return nullify_end(ctx, DISAS_NEXT);
+    nullify_end(ctx);
 }
 
-static DisasJumpType do_fop_dew(DisasContext *ctx, unsigned rt, unsigned ra,
-                                void (*func)(TCGv_i64, TCGv_env, TCGv_i32))
+static void do_fop_dew(DisasContext *ctx, unsigned rt, unsigned ra,
+                       void (*func)(TCGv_i64, TCGv_env, TCGv_i32))
 {
     TCGv_i32 src;
     TCGv_i64 dst;
@@ -1661,13 +1656,12 @@ static DisasJumpType do_fop_dew(DisasContext *ctx, unsigned rt, unsigned ra,
     tcg_temp_free_i32(src);
     save_frd(rt, dst);
     tcg_temp_free_i64(dst);
-    return nullify_end(ctx, DISAS_NEXT);
+    nullify_end(ctx);
 }
 
-static DisasJumpType do_fop_weww(DisasContext *ctx, unsigned rt,
-                                 unsigned ra, unsigned rb,
-                                 void (*func)(TCGv_i32, TCGv_env,
-                                              TCGv_i32, TCGv_i32))
+static void do_fop_weww(DisasContext *ctx, unsigned rt,
+                        unsigned ra, unsigned rb,
+                        void (*func)(TCGv_i32, TCGv_env, TCGv_i32, TCGv_i32))
 {
     TCGv_i32 a, b;
 
@@ -1680,13 +1674,12 @@ static DisasJumpType do_fop_weww(DisasContext *ctx, unsigned rt,
     tcg_temp_free_i32(b);
     save_frw_i32(rt, a);
     tcg_temp_free_i32(a);
-    return nullify_end(ctx, DISAS_NEXT);
+    nullify_end(ctx);
 }
 
-static DisasJumpType do_fop_dedd(DisasContext *ctx, unsigned rt,
-                                 unsigned ra, unsigned rb,
-                                 void (*func)(TCGv_i64, TCGv_env,
-                                              TCGv_i64, TCGv_i64))
+static void do_fop_dedd(DisasContext *ctx, unsigned rt,
+                        unsigned ra, unsigned rb,
+                        void (*func)(TCGv_i64, TCGv_env, TCGv_i64, TCGv_i64))
 {
     TCGv_i64 a, b;
 
@@ -1699,13 +1692,13 @@ static DisasJumpType do_fop_dedd(DisasContext *ctx, unsigned rt,
     tcg_temp_free_i64(b);
     save_frd(rt, a);
     tcg_temp_free_i64(a);
-    return nullify_end(ctx, DISAS_NEXT);
+    nullify_end(ctx);
 }
 
 /* Emit an unconditional branch to a direct target, which may or may not
    have already had nullification handled.  */
-static DisasJumpType do_dbranch(DisasContext *ctx, target_ureg dest,
-                                unsigned link, bool is_n)
+static void do_dbranch(DisasContext *ctx, target_ureg dest,
+                       unsigned link, bool is_n)
 {
     if (ctx->null_cond.c == TCG_COND_NEVER && ctx->null_lab == NULL) {
         if (link != 0) {
@@ -1715,7 +1708,6 @@ static DisasJumpType do_dbranch(DisasContext *ctx, target_ureg dest,
         if (is_n) {
             ctx->null_cond.c = TCG_COND_ALWAYS;
         }
-        return DISAS_NEXT;
     } else {
         nullify_over(ctx);
 
@@ -1731,18 +1723,18 @@ static DisasJumpType do_dbranch(DisasContext *ctx, target_ureg dest,
             gen_goto_tb(ctx, 0, ctx->iaoq_b, dest);
         }
 
-        nullify_end(ctx, DISAS_NEXT);
+        nullify_end(ctx);
 
         nullify_set(ctx, 0);
         gen_goto_tb(ctx, 1, ctx->iaoq_b, ctx->iaoq_n);
-        return DISAS_NORETURN;
+        ctx->base.is_jmp = DISAS_NORETURN;
     }
 }
 
 /* Emit a conditional branch to a direct target.  If the branch itself
    is nullified, we should have already used nullify_over.  */
-static DisasJumpType do_cbranch(DisasContext *ctx, target_sreg disp, bool is_n,
-                                DisasCond *cond)
+static void do_cbranch(DisasContext *ctx, target_sreg disp, bool is_n,
+                       DisasCond *cond)
 {
     target_ureg dest = iaoq_dest(ctx, disp);
     TCGLabel *taken = NULL;
@@ -1753,10 +1745,12 @@ static DisasJumpType do_cbranch(DisasContext *ctx, target_sreg disp, bool is_n,
 
     /* Handle TRUE and NEVER as direct branches.  */
     if (c == TCG_COND_ALWAYS) {
-        return do_dbranch(ctx, dest, 0, is_n && disp >= 0);
+        do_dbranch(ctx, dest, 0, is_n && disp >= 0);
+        return;
     }
     if (c == TCG_COND_NEVER) {
-        return do_dbranch(ctx, ctx->iaoq_n, 0, is_n && disp < 0);
+        do_dbranch(ctx, ctx->iaoq_n, 0, is_n && disp < 0);
+        return;
     }
 
     taken = gen_new_label();
@@ -1799,16 +1793,16 @@ static DisasJumpType do_cbranch(DisasContext *ctx, target_sreg disp, bool is_n,
     if (ctx->null_lab) {
         gen_set_label(ctx->null_lab);
         ctx->null_lab = NULL;
-        return DISAS_IAQ_N_STALE;
+        ctx->base.is_jmp = DISAS_IAQ_N_STALE;
     } else {
-        return DISAS_NORETURN;
+        ctx->base.is_jmp = DISAS_NORETURN;
     }
 }
 
 /* Emit an unconditional branch to an indirect target.  This handles
    nullification of the branch itself.  */
-static DisasJumpType do_ibranch(DisasContext *ctx, TCGv_reg dest,
-                                unsigned link, bool is_n)
+static void do_ibranch(DisasContext *ctx, TCGv_reg dest,
+                       unsigned link, bool is_n)
 {
     TCGv_reg a0, a1, next, tmp;
     TCGCond c;
@@ -1826,7 +1820,8 @@ static DisasJumpType do_ibranch(DisasContext *ctx, TCGv_reg dest,
                 tcg_gen_mov_reg(cpu_iaoq_f, next);
                 tcg_gen_addi_reg(cpu_iaoq_b, next, 4);
                 nullify_set(ctx, 0);
-                return DISAS_IAQ_N_UPDATED;
+                ctx->base.is_jmp = DISAS_IAQ_N_UPDATED;
+                return;
             }
             ctx->null_cond.c = TCG_COND_ALWAYS;
         }
@@ -1853,7 +1848,7 @@ static DisasJumpType do_ibranch(DisasContext *ctx, TCGv_reg dest,
             tcg_gen_movi_reg(cpu_gr[link], ctx->iaoq_n);
         }
         tcg_gen_lookup_and_goto_ptr();
-        return nullify_end(ctx, DISAS_NEXT);
+        nullify_end(ctx);
     } else {
         cond_prep(&ctx->null_cond);
         c = ctx->null_cond.c;
@@ -1884,8 +1879,6 @@ static DisasJumpType do_ibranch(DisasContext *ctx, TCGv_reg dest,
             cond_free(&ctx->null_cond);
         }
     }
-
-    return DISAS_NEXT;
 }
 
 /* Implement
@@ -1926,7 +1919,7 @@ static TCGv_reg do_ibranch_priv(DisasContext *ctx, TCGv_reg offset)
    in than the "be disp(sr2,r0)" instruction that probably sent us
    here, is the easiest way to handle the branch delay slot on the
    aforementioned BE.  */
-static DisasJumpType do_page_zero(DisasContext *ctx)
+static void do_page_zero(DisasContext *ctx)
 {
     /* If by some means we get here with PSW[N]=1, that implies that
        the B,GATE instruction would be skipped, and we'd fault on the
@@ -1954,56 +1947,56 @@ static DisasJumpType do_page_zero(DisasContext *ctx)
     switch (ctx->iaoq_f & -4) {
     case 0x00: /* Null pointer call */
         gen_excp_1(EXCP_IMP);
-        return DISAS_NORETURN;
+        ctx->base.is_jmp = DISAS_NORETURN;
+        break;
 
     case 0xb0: /* LWS */
         gen_excp_1(EXCP_SYSCALL_LWS);
-        return DISAS_NORETURN;
+        ctx->base.is_jmp = DISAS_NORETURN;
+        break;
 
     case 0xe0: /* SET_THREAD_POINTER */
         tcg_gen_st_reg(cpu_gr[26], cpu_env, offsetof(CPUHPPAState, cr[27]));
         tcg_gen_ori_reg(cpu_iaoq_f, cpu_gr[31], 3);
         tcg_gen_addi_reg(cpu_iaoq_b, cpu_iaoq_f, 4);
-        return DISAS_IAQ_N_UPDATED;
+        ctx->base.is_jmp = DISAS_IAQ_N_UPDATED;
+        break;
 
     case 0x100: /* SYSCALL */
         gen_excp_1(EXCP_SYSCALL);
-        return DISAS_NORETURN;
+        ctx->base.is_jmp = DISAS_NORETURN;
+        break;
 
     default:
     do_sigill:
         gen_excp_1(EXCP_ILL);
-        return DISAS_NORETURN;
+        ctx->base.is_jmp = DISAS_NORETURN;
+        break;
     }
 }
 #endif
 
-static DisasJumpType trans_nop(DisasContext *ctx, uint32_t insn,
-                               const DisasInsn *di)
+static bool trans_nop(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     cond_free(&ctx->null_cond);
-    return DISAS_NEXT;
+    return true;
 }
 
-static DisasJumpType trans_break(DisasContext *ctx, uint32_t insn,
-                                 const DisasInsn *di)
+static bool trans_break(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
-    nullify_over(ctx);
-    return nullify_end(ctx, gen_excp_iir(ctx, EXCP_BREAK));
+    return gen_excp_iir(ctx, EXCP_BREAK);
 }
 
-static DisasJumpType trans_sync(DisasContext *ctx, uint32_t insn,
-                                const DisasInsn *di)
+static bool trans_sync(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     /* No point in nullifying the memory barrier.  */
     tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
 
     cond_free(&ctx->null_cond);
-    return DISAS_NEXT;
+    return true;
 }
 
-static DisasJumpType trans_mfia(DisasContext *ctx, uint32_t insn,
-                                const DisasInsn *di)
+static bool trans_mfia(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     TCGv_reg tmp = dest_gpr(ctx, rt);
@@ -2011,11 +2004,10 @@ static DisasJumpType trans_mfia(DisasContext *ctx, uint32_t insn,
     save_gpr(ctx, rt, tmp);
 
     cond_free(&ctx->null_cond);
-    return DISAS_NEXT;
+    return true;
 }
 
-static DisasJumpType trans_mfsp(DisasContext *ctx, uint32_t insn,
-                                const DisasInsn *di)
+static bool trans_mfsp(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned rs = assemble_sr3(insn);
@@ -2031,16 +2023,14 @@ static DisasJumpType trans_mfsp(DisasContext *ctx, uint32_t insn,
     tcg_temp_free_i64(t0);
 
     cond_free(&ctx->null_cond);
-    return DISAS_NEXT;
+    return true;
 }
 
-static DisasJumpType trans_mfctl(DisasContext *ctx, uint32_t insn,
-                                 const DisasInsn *di)
+static bool trans_mfctl(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned ctl = extract32(insn, 21, 5);
     TCGv_reg tmp;
-    DisasJumpType ret;
 
     switch (ctl) {
     case CR_SAR:
@@ -2063,13 +2053,12 @@ static DisasJumpType trans_mfctl(DisasContext *ctx, uint32_t insn,
             gen_io_start();
             gen_helper_read_interval_timer(tmp);
             gen_io_end();
-            ret = DISAS_IAQ_N_STALE;
+            ctx->base.is_jmp = DISAS_IAQ_N_STALE;
         } else {
             gen_helper_read_interval_timer(tmp);
-            ret = DISAS_NEXT;
         }
         save_gpr(ctx, rt, tmp);
-        return nullify_end(ctx, ret);
+        return nullify_end(ctx);
     case 26:
     case 27:
         break;
@@ -2085,11 +2074,10 @@ static DisasJumpType trans_mfctl(DisasContext *ctx, uint32_t insn,
 
  done:
     cond_free(&ctx->null_cond);
-    return DISAS_NEXT;
+    return true;
 }
 
-static DisasJumpType trans_mtsp(DisasContext *ctx, uint32_t insn,
-                                const DisasInsn *di)
+static bool trans_mtsp(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned rr = extract32(insn, 16, 5);
     unsigned rs = assemble_sr3(insn);
@@ -2112,11 +2100,10 @@ static DisasJumpType trans_mtsp(DisasContext *ctx, uint32_t insn,
     }
     tcg_temp_free_i64(t64);
 
-    return nullify_end(ctx, DISAS_NEXT);
+    return nullify_end(ctx);
 }
 
-static DisasJumpType trans_mtctl(DisasContext *ctx, uint32_t insn,
-                                 const DisasInsn *di)
+static bool trans_mtctl(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned rin = extract32(insn, 16, 5);
     unsigned ctl = extract32(insn, 21, 5);
@@ -2130,7 +2117,7 @@ static DisasJumpType trans_mtctl(DisasContext *ctx, uint32_t insn,
         tcg_temp_free(tmp);
 
         cond_free(&ctx->null_cond);
-        return DISAS_NEXT;
+        return true;
     }
 
     /* All other control registers are privileged or read-only.  */
@@ -2139,8 +2126,6 @@ static DisasJumpType trans_mtctl(DisasContext *ctx, uint32_t insn,
 #ifdef CONFIG_USER_ONLY
     g_assert_not_reached();
 #else
-    DisasJumpType ret = DISAS_NEXT;
-
     nullify_over(ctx);
     switch (ctl) {
     case CR_IT:
@@ -2151,7 +2136,7 @@ static DisasJumpType trans_mtctl(DisasContext *ctx, uint32_t insn,
         break;
     case CR_EIEM:
         gen_helper_write_eiem(cpu_env, reg);
-        ret = DISAS_IAQ_N_STALE_EXIT;
+        ctx->base.is_jmp = DISAS_IAQ_N_STALE_EXIT;
         break;
 
     case CR_IIASQ:
@@ -2170,12 +2155,11 @@ static DisasJumpType trans_mtctl(DisasContext *ctx, uint32_t insn,
         tcg_gen_st_reg(reg, cpu_env, offsetof(CPUHPPAState, cr[ctl]));
         break;
     }
-    return nullify_end(ctx, ret);
+    return nullify_end(ctx);
 #endif
 }
 
-static DisasJumpType trans_mtsarcm(DisasContext *ctx, uint32_t insn,
-                                   const DisasInsn *di)
+static bool trans_mtsarcm(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned rin = extract32(insn, 16, 5);
     TCGv_reg tmp = tcg_temp_new();
@@ -2186,11 +2170,10 @@ static DisasJumpType trans_mtsarcm(DisasContext *ctx, uint32_t insn,
     tcg_temp_free(tmp);
 
     cond_free(&ctx->null_cond);
-    return DISAS_NEXT;
+    return true;
 }
 
-static DisasJumpType trans_ldsid(DisasContext *ctx, uint32_t insn,
-                                 const DisasInsn *di)
+static bool trans_ldsid(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     TCGv_reg dest = dest_gpr(ctx, rt);
@@ -2212,7 +2195,7 @@ static DisasJumpType trans_ldsid(DisasContext *ctx, uint32_t insn,
     save_gpr(ctx, rt, dest);
 
     cond_free(&ctx->null_cond);
-    return DISAS_NEXT;
+    return true;
 }
 
 #ifndef CONFIG_USER_ONLY
@@ -2230,8 +2213,7 @@ static target_ureg extract_sm_imm(uint32_t insn)
     return val;
 }
 
-static DisasJumpType trans_rsm(DisasContext *ctx, uint32_t insn,
-                               const DisasInsn *di)
+static bool trans_rsm(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     target_ureg sm = extract_sm_imm(insn);
@@ -2247,11 +2229,11 @@ static DisasJumpType trans_rsm(DisasContext *ctx, uint32_t insn,
     save_gpr(ctx, rt, tmp);
 
     /* Exit the TB to recognize new interrupts, e.g. PSW_M.  */
-    return nullify_end(ctx, DISAS_IAQ_N_STALE_EXIT);
+    ctx->base.is_jmp = DISAS_IAQ_N_STALE_EXIT;
+    return nullify_end(ctx);
 }
 
-static DisasJumpType trans_ssm(DisasContext *ctx, uint32_t insn,
-                               const DisasInsn *di)
+static bool trans_ssm(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     target_ureg sm = extract_sm_imm(insn);
@@ -2267,11 +2249,11 @@ static DisasJumpType trans_ssm(DisasContext *ctx, uint32_t insn,
     save_gpr(ctx, rt, tmp);
 
     /* Exit the TB to recognize new interrupts, e.g. PSW_I.  */
-    return nullify_end(ctx, DISAS_IAQ_N_STALE_EXIT);
+    ctx->base.is_jmp = DISAS_IAQ_N_STALE_EXIT;
+    return nullify_end(ctx);
 }
 
-static DisasJumpType trans_mtsm(DisasContext *ctx, uint32_t insn,
-                                const DisasInsn *di)
+static bool trans_mtsm(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned rr = extract32(insn, 16, 5);
     TCGv_reg tmp, reg;
@@ -2284,11 +2266,11 @@ static DisasJumpType trans_mtsm(DisasContext *ctx, uint32_t insn,
     gen_helper_swap_system_mask(tmp, cpu_env, reg);
 
     /* Exit the TB to recognize new interrupts.  */
-    return nullify_end(ctx, DISAS_IAQ_N_STALE_EXIT);
+    ctx->base.is_jmp = DISAS_IAQ_N_STALE_EXIT;
+    return nullify_end(ctx);
 }
 
-static DisasJumpType trans_rfi(DisasContext *ctx, uint32_t insn,
-                               const DisasInsn *di)
+static bool trans_rfi(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned comp = extract32(insn, 5, 4);
 
@@ -2300,17 +2282,18 @@ static DisasJumpType trans_rfi(DisasContext *ctx, uint32_t insn,
     } else {
         gen_helper_rfi(cpu_env);
     }
+    /* Exit the TB to recognize new interrupts.  */
     if (ctx->base.singlestep_enabled) {
         gen_excp_1(EXCP_DEBUG);
     } else {
         tcg_gen_exit_tb(NULL, 0);
     }
+    ctx->base.is_jmp = DISAS_NORETURN;
 
-    /* Exit the TB to recognize new interrupts.  */
-    return nullify_end(ctx, DISAS_NORETURN);
+    return nullify_end(ctx);
 }
 
-static DisasJumpType gen_hlt(DisasContext *ctx, int reset)
+static bool gen_hlt(DisasContext *ctx, int reset)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
     nullify_over(ctx);
@@ -2319,7 +2302,8 @@ static DisasJumpType gen_hlt(DisasContext *ctx, int reset)
     } else {
         gen_helper_halt(cpu_env);
     }
-    return nullify_end(ctx, DISAS_NORETURN);
+    ctx->base.is_jmp = DISAS_NORETURN;
+    return nullify_end(ctx);
 }
 #endif /* !CONFIG_USER_ONLY */
 
@@ -2342,8 +2326,8 @@ static const DisasInsn table_system[] = {
 #endif
 };
 
-static DisasJumpType trans_base_idx_mod(DisasContext *ctx, uint32_t insn,
-                                        const DisasInsn *di)
+static bool trans_base_idx_mod(DisasContext *ctx, uint32_t insn,
+                               const DisasInsn *di)
 {
     unsigned rb = extract32(insn, 21, 5);
     unsigned rx = extract32(insn, 16, 5);
@@ -2356,11 +2340,10 @@ static DisasJumpType trans_base_idx_mod(DisasContext *ctx, uint32_t insn,
     save_gpr(ctx, rb, dest);
 
     cond_free(&ctx->null_cond);
-    return DISAS_NEXT;
+    return true;
 }
 
-static DisasJumpType trans_probe(DisasContext *ctx, uint32_t insn,
-                                 const DisasInsn *di)
+static bool trans_probe(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned sp = extract32(insn, 14, 2);
@@ -2392,12 +2375,11 @@ static DisasJumpType trans_probe(DisasContext *ctx, uint32_t insn,
     tcg_temp_free_i32(level);
 
     save_gpr(ctx, rt, dest);
-    return nullify_end(ctx, DISAS_NEXT);
+    return nullify_end(ctx);
 }
 
 #ifndef CONFIG_USER_ONLY
-static DisasJumpType trans_ixtlbx(DisasContext *ctx, uint32_t insn,
-                                  const DisasInsn *di)
+static bool trans_ixtlbx(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned sp;
     unsigned rr = extract32(insn, 16, 5);
@@ -2426,12 +2408,13 @@ static DisasJumpType trans_ixtlbx(DisasContext *ctx, uint32_t insn,
 
     /* Exit TB for ITLB change if mmu is enabled.  This *should* not be
        the case, since the OS TLB fill handler runs with mmu disabled.  */
-    return nullify_end(ctx, !is_data && (ctx->tb_flags & PSW_C)
-                       ? DISAS_IAQ_N_STALE : DISAS_NEXT);
+    if (!is_data && (ctx->tb_flags & PSW_C)) {
+        ctx->base.is_jmp = DISAS_IAQ_N_STALE;
+    }
+    return nullify_end(ctx);
 }
 
-static DisasJumpType trans_pxtlbx(DisasContext *ctx, uint32_t insn,
-                                  const DisasInsn *di)
+static bool trans_pxtlbx(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned m = extract32(insn, 5, 1);
     unsigned sp;
@@ -2462,12 +2445,13 @@ static DisasJumpType trans_pxtlbx(DisasContext *ctx, uint32_t insn,
     }
 
     /* Exit TB for TLB change if mmu is enabled.  */
-    return nullify_end(ctx, !is_data && (ctx->tb_flags & PSW_C)
-                       ? DISAS_IAQ_N_STALE : DISAS_NEXT);
+    if (!is_data && (ctx->tb_flags & PSW_C)) {
+        ctx->base.is_jmp = DISAS_IAQ_N_STALE;
+    }
+    return nullify_end(ctx);
 }
 
-static DisasJumpType trans_lpa(DisasContext *ctx, uint32_t insn,
-                               const DisasInsn *di)
+static bool trans_lpa(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned m = extract32(insn, 5, 1);
@@ -2492,11 +2476,10 @@ static DisasJumpType trans_lpa(DisasContext *ctx, uint32_t insn,
     save_gpr(ctx, rt, paddr);
     tcg_temp_free(paddr);
 
-    return nullify_end(ctx, DISAS_NEXT);
+    return nullify_end(ctx);
 }
 
-static DisasJumpType trans_lci(DisasContext *ctx, uint32_t insn,
-                               const DisasInsn *di)
+static bool trans_lci(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     TCGv_reg ci;
@@ -2511,7 +2494,8 @@ static DisasJumpType trans_lci(DisasContext *ctx, uint32_t insn,
     save_gpr(ctx, rt, ci);
     tcg_temp_free(ci);
 
-    return DISAS_NEXT;
+    cond_free(&ctx->null_cond);
+    return true;
 }
 #endif /* !CONFIG_USER_ONLY */
 
@@ -2545,8 +2529,7 @@ static const DisasInsn table_mem_mgmt[] = {
 #endif
 };
 
-static DisasJumpType trans_add(DisasContext *ctx, uint32_t insn,
-                               const DisasInsn *di)
+static bool trans_add(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned r2 = extract32(insn, 21, 5);
     unsigned r1 = extract32(insn, 16, 5);
@@ -2559,7 +2542,6 @@ static DisasJumpType trans_add(DisasContext *ctx, uint32_t insn,
     bool is_l = false;
     bool is_tc = false;
     bool is_tsv = false;
-    DisasJumpType ret;
 
     switch (ext) {
     case 0x6: /* ADD, SHLADD */
@@ -2585,12 +2567,11 @@ static DisasJumpType trans_add(DisasContext *ctx, uint32_t insn,
     }
     tcg_r1 = load_gpr(ctx, r1);
     tcg_r2 = load_gpr(ctx, r2);
-    ret = do_add(ctx, rt, tcg_r1, tcg_r2, shift, is_l, is_tsv, is_tc, is_c, cf);
-    return nullify_end(ctx, ret);
+    do_add(ctx, rt, tcg_r1, tcg_r2, shift, is_l, is_tsv, is_tc, is_c, cf);
+    return nullify_end(ctx);
 }
 
-static DisasJumpType trans_sub(DisasContext *ctx, uint32_t insn,
-                               const DisasInsn *di)
+static bool trans_sub(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned r2 = extract32(insn, 21, 5);
     unsigned r1 = extract32(insn, 16, 5);
@@ -2601,7 +2582,6 @@ static DisasJumpType trans_sub(DisasContext *ctx, uint32_t insn,
     bool is_b = false;
     bool is_tc = false;
     bool is_tsv = false;
-    DisasJumpType ret;
 
     switch (ext) {
     case 0x10: /* SUB */
@@ -2630,32 +2610,29 @@ static DisasJumpType trans_sub(DisasContext *ctx, uint32_t insn,
     }
     tcg_r1 = load_gpr(ctx, r1);
     tcg_r2 = load_gpr(ctx, r2);
-    ret = do_sub(ctx, rt, tcg_r1, tcg_r2, is_tsv, is_b, is_tc, cf);
-    return nullify_end(ctx, ret);
+    do_sub(ctx, rt, tcg_r1, tcg_r2, is_tsv, is_b, is_tc, cf);
+    return nullify_end(ctx);
 }
 
-static DisasJumpType trans_log(DisasContext *ctx, uint32_t insn,
-                               const DisasInsn *di)
+static bool trans_log(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned r2 = extract32(insn, 21, 5);
     unsigned r1 = extract32(insn, 16, 5);
     unsigned cf = extract32(insn, 12, 4);
     unsigned rt = extract32(insn,  0, 5);
     TCGv_reg tcg_r1, tcg_r2;
-    DisasJumpType ret;
 
     if (cf) {
         nullify_over(ctx);
     }
     tcg_r1 = load_gpr(ctx, r1);
     tcg_r2 = load_gpr(ctx, r2);
-    ret = do_log(ctx, rt, tcg_r1, tcg_r2, cf, di->f.ttt);
-    return nullify_end(ctx, ret);
+    do_log(ctx, rt, tcg_r1, tcg_r2, cf, di->f.ttt);
+    return nullify_end(ctx);
 }
 
 /* OR r,0,t -> COPY (according to gas) */
-static DisasJumpType trans_copy(DisasContext *ctx, uint32_t insn,
-                                const DisasInsn *di)
+static bool trans_copy(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned r1 = extract32(insn, 16, 5);
     unsigned rt = extract32(insn,  0, 5);
@@ -2668,49 +2645,44 @@ static DisasJumpType trans_copy(DisasContext *ctx, uint32_t insn,
         save_gpr(ctx, rt, cpu_gr[r1]);
     }
     cond_free(&ctx->null_cond);
-    return DISAS_NEXT;
+    return true;
 }
 
-static DisasJumpType trans_cmpclr(DisasContext *ctx, uint32_t insn,
-                                  const DisasInsn *di)
+static bool trans_cmpclr(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned r2 = extract32(insn, 21, 5);
     unsigned r1 = extract32(insn, 16, 5);
     unsigned cf = extract32(insn, 12, 4);
     unsigned rt = extract32(insn,  0, 5);
     TCGv_reg tcg_r1, tcg_r2;
-    DisasJumpType ret;
 
     if (cf) {
         nullify_over(ctx);
     }
     tcg_r1 = load_gpr(ctx, r1);
     tcg_r2 = load_gpr(ctx, r2);
-    ret = do_cmpclr(ctx, rt, tcg_r1, tcg_r2, cf);
-    return nullify_end(ctx, ret);
+    do_cmpclr(ctx, rt, tcg_r1, tcg_r2, cf);
+    return nullify_end(ctx);
 }
 
-static DisasJumpType trans_uxor(DisasContext *ctx, uint32_t insn,
-                                const DisasInsn *di)
+static bool trans_uxor(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned r2 = extract32(insn, 21, 5);
     unsigned r1 = extract32(insn, 16, 5);
     unsigned cf = extract32(insn, 12, 4);
     unsigned rt = extract32(insn,  0, 5);
     TCGv_reg tcg_r1, tcg_r2;
-    DisasJumpType ret;
 
     if (cf) {
         nullify_over(ctx);
     }
     tcg_r1 = load_gpr(ctx, r1);
     tcg_r2 = load_gpr(ctx, r2);
-    ret = do_unit(ctx, rt, tcg_r1, tcg_r2, cf, false, tcg_gen_xor_reg);
-    return nullify_end(ctx, ret);
+    do_unit(ctx, rt, tcg_r1, tcg_r2, cf, false, tcg_gen_xor_reg);
+    return nullify_end(ctx);
 }
 
-static DisasJumpType trans_uaddcm(DisasContext *ctx, uint32_t insn,
-                                  const DisasInsn *di)
+static bool trans_uaddcm(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned r2 = extract32(insn, 21, 5);
     unsigned r1 = extract32(insn, 16, 5);
@@ -2718,7 +2690,6 @@ static DisasJumpType trans_uaddcm(DisasContext *ctx, uint32_t insn,
     unsigned is_tc = extract32(insn, 6, 1);
     unsigned rt = extract32(insn,  0, 5);
     TCGv_reg tcg_r1, tcg_r2, tmp;
-    DisasJumpType ret;
 
     if (cf) {
         nullify_over(ctx);
@@ -2727,19 +2698,17 @@ static DisasJumpType trans_uaddcm(DisasContext *ctx, uint32_t insn,
     tcg_r2 = load_gpr(ctx, r2);
     tmp = get_temp(ctx);
     tcg_gen_not_reg(tmp, tcg_r2);
-    ret = do_unit(ctx, rt, tcg_r1, tmp, cf, is_tc, tcg_gen_add_reg);
-    return nullify_end(ctx, ret);
+    do_unit(ctx, rt, tcg_r1, tmp, cf, is_tc, tcg_gen_add_reg);
+    return nullify_end(ctx);
 }
 
-static DisasJumpType trans_dcor(DisasContext *ctx, uint32_t insn,
-                                const DisasInsn *di)
+static bool trans_dcor(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned r2 = extract32(insn, 21, 5);
     unsigned cf = extract32(insn, 12, 4);
     unsigned is_i = extract32(insn, 6, 1);
     unsigned rt = extract32(insn,  0, 5);
     TCGv_reg tmp;
-    DisasJumpType ret;
 
     nullify_over(ctx);
 
@@ -2750,14 +2719,13 @@ static DisasJumpType trans_dcor(DisasContext *ctx, uint32_t insn,
     }
     tcg_gen_andi_reg(tmp, tmp, 0x11111111);
     tcg_gen_muli_reg(tmp, tmp, 6);
-    ret = do_unit(ctx, rt, tmp, load_gpr(ctx, r2), cf, false,
-                  is_i ? tcg_gen_add_reg : tcg_gen_sub_reg);
+    do_unit(ctx, rt, tmp, load_gpr(ctx, r2), cf, false,
+            is_i ? tcg_gen_add_reg : tcg_gen_sub_reg);
 
-    return nullify_end(ctx, ret);
+    return nullify_end(ctx);
 }
 
-static DisasJumpType trans_ds(DisasContext *ctx, uint32_t insn,
-                              const DisasInsn *di)
+static bool trans_ds(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned r2 = extract32(insn, 21, 5);
     unsigned r1 = extract32(insn, 16, 5);
@@ -2819,7 +2787,7 @@ static DisasJumpType trans_ds(DisasContext *ctx, uint32_t insn,
     tcg_temp_free(add2);
     tcg_temp_free(dest);
 
-    return nullify_end(ctx, DISAS_NEXT);
+    return nullify_end(ctx);
 }
 
 #ifndef CONFIG_USER_ONLY
@@ -2829,8 +2797,7 @@ static DisasJumpType trans_ds(DisasContext *ctx, uint32_t insn,
  * or %r31,%r31,%r31 -- death loop; offline cpu
  *                      currently implemented as idle.
  */
-static DisasJumpType trans_pause(DisasContext *ctx, uint32_t insn,
-                                 const DisasInsn *di)
+static bool trans_pause(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     TCGv_i32 tmp;
 
@@ -2849,8 +2816,9 @@ static DisasJumpType trans_pause(DisasContext *ctx, uint32_t insn,
                                  offsetof(CPUState, halted));
     tcg_temp_free_i32(tmp);
     gen_excp_1(EXCP_HALTED);
+    ctx->base.is_jmp = DISAS_NORETURN;
 
-    return nullify_end(ctx, DISAS_NORETURN);
+    return nullify_end(ctx);
 }
 #endif
 
@@ -2876,7 +2844,7 @@ static const DisasInsn table_arith_log[] = {
     { 0x08000200u, 0xfc000320u, trans_add }, /* shladd */
 };
 
-static DisasJumpType trans_addi(DisasContext *ctx, uint32_t insn)
+static bool trans_addi(DisasContext *ctx, uint32_t insn)
 {
     target_sreg im = low_sextract(insn, 0, 11);
     unsigned e1 = extract32(insn, 11, 1);
@@ -2885,7 +2853,6 @@ static DisasJumpType trans_addi(DisasContext *ctx, uint32_t insn)
     unsigned r2 = extract32(insn, 21, 5);
     unsigned o1 = extract32(insn, 26, 1);
     TCGv_reg tcg_im, tcg_r2;
-    DisasJumpType ret;
 
     if (cf) {
         nullify_over(ctx);
@@ -2893,12 +2860,12 @@ static DisasJumpType trans_addi(DisasContext *ctx, uint32_t insn)
 
     tcg_im = load_const(ctx, im);
     tcg_r2 = load_gpr(ctx, r2);
-    ret = do_add(ctx, rt, tcg_im, tcg_r2, 0, false, e1, !o1, false, cf);
+    do_add(ctx, rt, tcg_im, tcg_r2, 0, false, e1, !o1, false, cf);
 
-    return nullify_end(ctx, ret);
+    return nullify_end(ctx);
 }
 
-static DisasJumpType trans_subi(DisasContext *ctx, uint32_t insn)
+static bool trans_subi(DisasContext *ctx, uint32_t insn)
 {
     target_sreg im = low_sextract(insn, 0, 11);
     unsigned e1 = extract32(insn, 11, 1);
@@ -2906,7 +2873,6 @@ static DisasJumpType trans_subi(DisasContext *ctx, uint32_t insn)
     unsigned rt = extract32(insn, 16, 5);
     unsigned r2 = extract32(insn, 21, 5);
     TCGv_reg tcg_im, tcg_r2;
-    DisasJumpType ret;
 
     if (cf) {
         nullify_over(ctx);
@@ -2914,19 +2880,18 @@ static DisasJumpType trans_subi(DisasContext *ctx, uint32_t insn)
 
     tcg_im = load_const(ctx, im);
     tcg_r2 = load_gpr(ctx, r2);
-    ret = do_sub(ctx, rt, tcg_im, tcg_r2, e1, false, false, cf);
+    do_sub(ctx, rt, tcg_im, tcg_r2, e1, false, false, cf);
 
-    return nullify_end(ctx, ret);
+    return nullify_end(ctx);
 }
 
-static DisasJumpType trans_cmpiclr(DisasContext *ctx, uint32_t insn)
+static bool trans_cmpiclr(DisasContext *ctx, uint32_t insn)
 {
     target_sreg im = low_sextract(insn, 0, 11);
     unsigned cf = extract32(insn, 12, 4);
     unsigned rt = extract32(insn, 16, 5);
     unsigned r2 = extract32(insn, 21, 5);
     TCGv_reg tcg_im, tcg_r2;
-    DisasJumpType ret;
 
     if (cf) {
         nullify_over(ctx);
@@ -2934,13 +2899,13 @@ static DisasJumpType trans_cmpiclr(DisasContext *ctx, uint32_t insn)
 
     tcg_im = load_const(ctx, im);
     tcg_r2 = load_gpr(ctx, r2);
-    ret = do_cmpclr(ctx, rt, tcg_im, tcg_r2, cf);
+    do_cmpclr(ctx, rt, tcg_im, tcg_r2, cf);
 
-    return nullify_end(ctx, ret);
+    return nullify_end(ctx);
 }
 
-static DisasJumpType trans_ld_idx_i(DisasContext *ctx, uint32_t insn,
-                                    const DisasInsn *di)
+static bool trans_ld_idx_i(DisasContext *ctx, uint32_t insn,
+                           const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned m = extract32(insn, 5, 1);
@@ -2952,11 +2917,12 @@ static DisasJumpType trans_ld_idx_i(DisasContext *ctx, uint32_t insn,
     int modify = (m ? (a ? -1 : 1) : 0);
     TCGMemOp mop = MO_TE | sz;
 
-    return do_load(ctx, rt, rb, 0, 0, disp, sp, modify, mop);
+    do_load(ctx, rt, rb, 0, 0, disp, sp, modify, mop);
+    return true;
 }
 
-static DisasJumpType trans_ld_idx_x(DisasContext *ctx, uint32_t insn,
-                                    const DisasInsn *di)
+static bool trans_ld_idx_x(DisasContext *ctx, uint32_t insn,
+                           const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned m = extract32(insn, 5, 1);
@@ -2967,11 +2933,12 @@ static DisasJumpType trans_ld_idx_x(DisasContext *ctx, uint32_t insn,
     unsigned rb = extract32(insn, 21, 5);
     TCGMemOp mop = MO_TE | sz;
 
-    return do_load(ctx, rt, rb, rx, u ? sz : 0, 0, sp, m, mop);
+    do_load(ctx, rt, rb, rx, u ? sz : 0, 0, sp, m, mop);
+    return true;
 }
 
-static DisasJumpType trans_st_idx_i(DisasContext *ctx, uint32_t insn,
-                                    const DisasInsn *di)
+static bool trans_st_idx_i(DisasContext *ctx, uint32_t insn,
+                           const DisasInsn *di)
 {
     int disp = low_sextract(insn, 0, 5);
     unsigned m = extract32(insn, 5, 1);
@@ -2983,11 +2950,11 @@ static DisasJumpType trans_st_idx_i(DisasContext *ctx, uint32_t insn,
     int modify = (m ? (a ? -1 : 1) : 0);
     TCGMemOp mop = MO_TE | sz;
 
-    return do_store(ctx, rr, rb, disp, sp, modify, mop);
+    do_store(ctx, rr, rb, disp, sp, modify, mop);
+    return true;
 }
 
-static DisasJumpType trans_ldcw(DisasContext *ctx, uint32_t insn,
-                                const DisasInsn *di)
+static bool trans_ldcw(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned m = extract32(insn, 5, 1);
@@ -3030,11 +2997,10 @@ static DisasJumpType trans_ldcw(DisasContext *ctx, uint32_t insn,
     }
     save_gpr(ctx, rt, dest);
 
-    return nullify_end(ctx, DISAS_NEXT);
+    return nullify_end(ctx);
 }
 
-static DisasJumpType trans_stby(DisasContext *ctx, uint32_t insn,
-                                const DisasInsn *di)
+static bool trans_stby(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     target_sreg disp = low_sextract(insn, 0, 5);
     unsigned m = extract32(insn, 5, 1);
@@ -3069,56 +3035,53 @@ static DisasJumpType trans_stby(DisasContext *ctx, uint32_t insn,
         save_gpr(ctx, rb, ofs);
     }
 
-    return nullify_end(ctx, DISAS_NEXT);
+    return nullify_end(ctx);
 }
 
 #ifndef CONFIG_USER_ONLY
-static DisasJumpType trans_ldwa_idx_i(DisasContext *ctx, uint32_t insn,
-                                      const DisasInsn *di)
+static bool trans_ldwa_idx_i(DisasContext *ctx, uint32_t insn,
+                             const DisasInsn *di)
 {
     int hold_mmu_idx = ctx->mmu_idx;
-    DisasJumpType ret;
 
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
 
     /* ??? needs fixing for hppa64 -- ldda does not follow the same
        format wrt the sub-opcode in bits 6:9.  */
     ctx->mmu_idx = MMU_PHYS_IDX;
-    ret = trans_ld_idx_i(ctx, insn, di);
+    trans_ld_idx_i(ctx, insn, di);
     ctx->mmu_idx = hold_mmu_idx;
-    return ret;
+    return true;
 }
 
-static DisasJumpType trans_ldwa_idx_x(DisasContext *ctx, uint32_t insn,
-                                      const DisasInsn *di)
+static bool trans_ldwa_idx_x(DisasContext *ctx, uint32_t insn,
+                             const DisasInsn *di)
 {
     int hold_mmu_idx = ctx->mmu_idx;
-    DisasJumpType ret;
 
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
 
     /* ??? needs fixing for hppa64 -- ldda does not follow the same
        format wrt the sub-opcode in bits 6:9.  */
     ctx->mmu_idx = MMU_PHYS_IDX;
-    ret = trans_ld_idx_x(ctx, insn, di);
+    trans_ld_idx_x(ctx, insn, di);
     ctx->mmu_idx = hold_mmu_idx;
-    return ret;
+    return true;
 }
 
-static DisasJumpType trans_stwa_idx_i(DisasContext *ctx, uint32_t insn,
-                                      const DisasInsn *di)
+static bool trans_stwa_idx_i(DisasContext *ctx, uint32_t insn,
+                             const DisasInsn *di)
 {
     int hold_mmu_idx = ctx->mmu_idx;
-    DisasJumpType ret;
 
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
 
     /* ??? needs fixing for hppa64 -- ldda does not follow the same
        format wrt the sub-opcode in bits 6:9.  */
     ctx->mmu_idx = MMU_PHYS_IDX;
-    ret = trans_st_idx_i(ctx, insn, di);
+    trans_st_idx_i(ctx, insn, di);
     ctx->mmu_idx = hold_mmu_idx;
-    return ret;
+    return true;
 }
 #endif
 
@@ -3135,7 +3098,7 @@ static const DisasInsn table_index_mem[] = {
 #endif
 };
 
-static DisasJumpType trans_ldil(DisasContext *ctx, uint32_t insn)
+static bool trans_ldil(DisasContext *ctx, uint32_t insn)
 {
     unsigned rt = extract32(insn, 21, 5);
     target_sreg i = assemble_21(insn);
@@ -3144,11 +3107,10 @@ static DisasJumpType trans_ldil(DisasContext *ctx, uint32_t insn)
     tcg_gen_movi_reg(tcg_rt, i);
     save_gpr(ctx, rt, tcg_rt);
     cond_free(&ctx->null_cond);
-
-    return DISAS_NEXT;
+    return true;
 }
 
-static DisasJumpType trans_addil(DisasContext *ctx, uint32_t insn)
+static bool trans_addil(DisasContext *ctx, uint32_t insn)
 {
     unsigned rt = extract32(insn, 21, 5);
     target_sreg i = assemble_21(insn);
@@ -3158,11 +3120,10 @@ static DisasJumpType trans_addil(DisasContext *ctx, uint32_t insn)
     tcg_gen_addi_reg(tcg_r1, tcg_rt, i);
     save_gpr(ctx, 1, tcg_r1);
     cond_free(&ctx->null_cond);
-
-    return DISAS_NEXT;
+    return true;
 }
 
-static DisasJumpType trans_ldo(DisasContext *ctx, uint32_t insn)
+static bool trans_ldo(DisasContext *ctx, uint32_t insn)
 {
     unsigned rb = extract32(insn, 21, 5);
     unsigned rt = extract32(insn, 16, 5);
@@ -3178,23 +3139,22 @@ static DisasJumpType trans_ldo(DisasContext *ctx, uint32_t insn)
     }
     save_gpr(ctx, rt, tcg_rt);
     cond_free(&ctx->null_cond);
-
-    return DISAS_NEXT;
+    return true;
 }
 
-static DisasJumpType trans_load(DisasContext *ctx, uint32_t insn,
-                                bool is_mod, TCGMemOp mop)
+static bool trans_load(DisasContext *ctx, uint32_t insn,
+                       bool is_mod, TCGMemOp mop)
 {
     unsigned rb = extract32(insn, 21, 5);
     unsigned rt = extract32(insn, 16, 5);
     unsigned sp = extract32(insn, 14, 2);
     target_sreg i = assemble_16(insn);
 
-    return do_load(ctx, rt, rb, 0, 0, i, sp,
-                   is_mod ? (i < 0 ? -1 : 1) : 0, mop);
+    do_load(ctx, rt, rb, 0, 0, i, sp, is_mod ? (i < 0 ? -1 : 1) : 0, mop);
+    return true;
 }
 
-static DisasJumpType trans_load_w(DisasContext *ctx, uint32_t insn)
+static bool trans_load_w(DisasContext *ctx, uint32_t insn)
 {
     unsigned rb = extract32(insn, 21, 5);
     unsigned rt = extract32(insn, 16, 5);
@@ -3206,17 +3166,20 @@ static DisasJumpType trans_load_w(DisasContext *ctx, uint32_t insn)
     case 0:
     case 1:
         /* FLDW without modification.  */
-        return do_floadw(ctx, ext2 * 32 + rt, rb, 0, 0, i, sp, 0);
+        do_floadw(ctx, ext2 * 32 + rt, rb, 0, 0, i, sp, 0);
+        break;
     case 2:
         /* LDW with modification.  Note that the sign of I selects
            post-dec vs pre-inc.  */
-        return do_load(ctx, rt, rb, 0, 0, i, sp, (i < 0 ? 1 : -1), MO_TEUL);
+        do_load(ctx, rt, rb, 0, 0, i, sp, (i < 0 ? 1 : -1), MO_TEUL);
+        break;
     default:
         return gen_illegal(ctx);
     }
+    return true;
 }
 
-static DisasJumpType trans_fload_mod(DisasContext *ctx, uint32_t insn)
+static bool trans_fload_mod(DisasContext *ctx, uint32_t insn)
 {
     target_sreg i = assemble_16a(insn);
     unsigned t1 = extract32(insn, 1, 1);
@@ -3226,21 +3189,23 @@ static DisasJumpType trans_fload_mod(DisasContext *ctx, uint32_t insn)
     unsigned rb = extract32(insn, 21, 5);
 
     /* FLDW with modification.  */
-    return do_floadw(ctx, t1 * 32 + t0, rb, 0, 0, i, sp, (a ? -1 : 1));
+    do_floadw(ctx, t1 * 32 + t0, rb, 0, 0, i, sp, (a ? -1 : 1));
+    return true;
 }
 
-static DisasJumpType trans_store(DisasContext *ctx, uint32_t insn,
-                                 bool is_mod, TCGMemOp mop)
+static bool trans_store(DisasContext *ctx, uint32_t insn,
+                        bool is_mod, TCGMemOp mop)
 {
     unsigned rb = extract32(insn, 21, 5);
     unsigned rt = extract32(insn, 16, 5);
     unsigned sp = extract32(insn, 14, 2);
     target_sreg i = assemble_16(insn);
 
-    return do_store(ctx, rt, rb, i, sp, is_mod ? (i < 0 ? -1 : 1) : 0, mop);
+    do_store(ctx, rt, rb, i, sp, is_mod ? (i < 0 ? -1 : 1) : 0, mop);
+    return true;
 }
 
-static DisasJumpType trans_store_w(DisasContext *ctx, uint32_t insn)
+static bool trans_store_w(DisasContext *ctx, uint32_t insn)
 {
     unsigned rb = extract32(insn, 21, 5);
     unsigned rt = extract32(insn, 16, 5);
@@ -3252,16 +3217,19 @@ static DisasJumpType trans_store_w(DisasContext *ctx, uint32_t insn)
     case 0:
     case 1:
         /* FSTW without modification.  */
-        return do_fstorew(ctx, ext2 * 32 + rt, rb, 0, 0, i, sp, 0);
+        do_fstorew(ctx, ext2 * 32 + rt, rb, 0, 0, i, sp, 0);
+        break;
     case 2:
         /* STW with modification.  */
-        return do_store(ctx, rt, rb, i, sp, (i < 0 ? 1 : -1), MO_TEUL);
+        do_store(ctx, rt, rb, i, sp, (i < 0 ? 1 : -1), MO_TEUL);
+        break;
     default:
         return gen_illegal(ctx);
     }
+    return true;
 }
 
-static DisasJumpType trans_fstore_mod(DisasContext *ctx, uint32_t insn)
+static bool trans_fstore_mod(DisasContext *ctx, uint32_t insn)
 {
     target_sreg i = assemble_16a(insn);
     unsigned t1 = extract32(insn, 1, 1);
@@ -3271,10 +3239,11 @@ static DisasJumpType trans_fstore_mod(DisasContext *ctx, uint32_t insn)
     unsigned rb = extract32(insn, 21, 5);
 
     /* FSTW with modification.  */
-    return do_fstorew(ctx, t1 * 32 + t0, rb, 0, 0, i, sp, (a ? -1 : 1));
+    do_fstorew(ctx, t1 * 32 + t0, rb, 0, 0, i, sp, (a ? -1 : 1));
+    return true;
 }
 
-static DisasJumpType trans_copr_w(DisasContext *ctx, uint32_t insn)
+static bool trans_copr_w(DisasContext *ctx, uint32_t insn)
 {
     unsigned t0 = extract32(insn, 0, 5);
     unsigned m = extract32(insn, 5, 1);
@@ -3303,14 +3272,18 @@ static DisasJumpType trans_copr_w(DisasContext *ctx, uint32_t insn)
 
     switch (ext3) {
     case 0: /* FLDW */
-        return do_floadw(ctx, rt, rb, rx, scale, disp, sp, modify);
+        do_floadw(ctx, rt, rb, rx, scale, disp, sp, modify);
+        break;
     case 4: /* FSTW */
-        return do_fstorew(ctx, rt, rb, rx, scale, disp, sp, modify);
+        do_fstorew(ctx, rt, rb, rx, scale, disp, sp, modify);
+        break;
+    default:
+        return gen_illegal(ctx);
     }
-    return gen_illegal(ctx);
+    return true;
 }
 
-static DisasJumpType trans_copr_dw(DisasContext *ctx, uint32_t insn)
+static bool trans_copr_dw(DisasContext *ctx, uint32_t insn)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned m = extract32(insn, 5, 1);
@@ -3337,16 +3310,19 @@ static DisasJumpType trans_copr_dw(DisasContext *ctx, uint32_t insn)
 
     switch (ext4) {
     case 0: /* FLDD */
-        return do_floadd(ctx, rt, rb, rx, scale, disp, sp, modify);
+        do_floadd(ctx, rt, rb, rx, scale, disp, sp, modify);
+        break;
     case 8: /* FSTD */
-        return do_fstored(ctx, rt, rb, rx, scale, disp, sp, modify);
+        do_fstored(ctx, rt, rb, rx, scale, disp, sp, modify);
+        break;
     default:
         return gen_illegal(ctx);
     }
+    return true;
 }
 
-static DisasJumpType trans_cmpb(DisasContext *ctx, uint32_t insn,
-                                bool is_true, bool is_imm, bool is_dw)
+static bool trans_cmpb(DisasContext *ctx, uint32_t insn,
+                       bool is_true, bool is_imm, bool is_dw)
 {
     target_sreg disp = assemble_12(insn) * 4;
     unsigned n = extract32(insn, 1, 1);
@@ -3374,11 +3350,12 @@ static DisasJumpType trans_cmpb(DisasContext *ctx, uint32_t insn,
     }
 
     cond = do_sub_cond(cf, dest, in1, in2, sv);
-    return do_cbranch(ctx, disp, n, &cond);
+    do_cbranch(ctx, disp, n, &cond);
+    return true;
 }
 
-static DisasJumpType trans_addb(DisasContext *ctx, uint32_t insn,
-                                bool is_true, bool is_imm)
+static bool trans_addb(DisasContext *ctx, uint32_t insn,
+                       bool is_true, bool is_imm)
 {
     target_sreg disp = assemble_12(insn) * 4;
     unsigned n = extract32(insn, 1, 1);
@@ -3416,10 +3393,11 @@ static DisasJumpType trans_addb(DisasContext *ctx, uint32_t insn,
     }
 
     cond = do_cond(cf, dest, cb_msb, sv);
-    return do_cbranch(ctx, disp, n, &cond);
+    do_cbranch(ctx, disp, n, &cond);
+    return true;
 }
 
-static DisasJumpType trans_bb(DisasContext *ctx, uint32_t insn)
+static bool trans_bb(DisasContext *ctx, uint32_t insn)
 {
     target_sreg disp = assemble_12(insn) * 4;
     unsigned n = extract32(insn, 1, 1);
@@ -3442,10 +3420,11 @@ static DisasJumpType trans_bb(DisasContext *ctx, uint32_t insn)
 
     cond = cond_make_0(c ? TCG_COND_GE : TCG_COND_LT, tmp);
     tcg_temp_free(tmp);
-    return do_cbranch(ctx, disp, n, &cond);
+    do_cbranch(ctx, disp, n, &cond);
+    return true;
 }
 
-static DisasJumpType trans_movb(DisasContext *ctx, uint32_t insn, bool is_imm)
+static bool trans_movb(DisasContext *ctx, uint32_t insn, bool is_imm)
 {
     target_sreg disp = assemble_12(insn) * 4;
     unsigned n = extract32(insn, 1, 1);
@@ -3467,11 +3446,12 @@ static DisasJumpType trans_movb(DisasContext *ctx, uint32_t insn, bool is_imm)
     }
 
     cond = do_sed_cond(c, dest);
-    return do_cbranch(ctx, disp, n, &cond);
+    do_cbranch(ctx, disp, n, &cond);
+    return true;
 }
 
-static DisasJumpType trans_shrpw_sar(DisasContext *ctx, uint32_t insn,
-                                    const DisasInsn *di)
+static bool trans_shrpw_sar(DisasContext *ctx, uint32_t insn,
+                            const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned c = extract32(insn, 13, 3);
@@ -3512,11 +3492,11 @@ static DisasJumpType trans_shrpw_sar(DisasContext *ctx, uint32_t insn,
     if (c) {
         ctx->null_cond = do_sed_cond(c, dest);
     }
-    return nullify_end(ctx, DISAS_NEXT);
+    return nullify_end(ctx);
 }
 
-static DisasJumpType trans_shrpw_imm(DisasContext *ctx, uint32_t insn,
-                                     const DisasInsn *di)
+static bool trans_shrpw_imm(DisasContext *ctx, uint32_t insn,
+                            const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned cpos = extract32(insn, 5, 5);
@@ -3553,11 +3533,11 @@ static DisasJumpType trans_shrpw_imm(DisasContext *ctx, uint32_t insn,
     if (c) {
         ctx->null_cond = do_sed_cond(c, dest);
     }
-    return nullify_end(ctx, DISAS_NEXT);
+    return nullify_end(ctx);
 }
 
-static DisasJumpType trans_extrw_sar(DisasContext *ctx, uint32_t insn,
-                                     const DisasInsn *di)
+static bool trans_extrw_sar(DisasContext *ctx, uint32_t insn,
+                            const DisasInsn *di)
 {
     unsigned clen = extract32(insn, 0, 5);
     unsigned is_se = extract32(insn, 10, 1);
@@ -3592,11 +3572,11 @@ static DisasJumpType trans_extrw_sar(DisasContext *ctx, uint32_t insn,
     if (c) {
         ctx->null_cond = do_sed_cond(c, dest);
     }
-    return nullify_end(ctx, DISAS_NEXT);
+    return nullify_end(ctx);
 }
 
-static DisasJumpType trans_extrw_imm(DisasContext *ctx, uint32_t insn,
-                                     const DisasInsn *di)
+static bool trans_extrw_imm(DisasContext *ctx, uint32_t insn,
+                            const DisasInsn *di)
 {
     unsigned clen = extract32(insn, 0, 5);
     unsigned pos = extract32(insn, 5, 5);
@@ -3626,7 +3606,7 @@ static DisasJumpType trans_extrw_imm(DisasContext *ctx, uint32_t insn,
     if (c) {
         ctx->null_cond = do_sed_cond(c, dest);
     }
-    return nullify_end(ctx, DISAS_NEXT);
+    return nullify_end(ctx);
 }
 
 static const DisasInsn table_sh_ex[] = {
@@ -3636,8 +3616,8 @@ static const DisasInsn table_sh_ex[] = {
     { 0xd0001800u, 0xfc001800u, trans_extrw_imm },
 };
 
-static DisasJumpType trans_depw_imm_c(DisasContext *ctx, uint32_t insn,
-                                      const DisasInsn *di)
+static bool trans_depw_imm_c(DisasContext *ctx, uint32_t insn,
+                             const DisasInsn *di)
 {
     unsigned clen = extract32(insn, 0, 5);
     unsigned cpos = extract32(insn, 5, 5);
@@ -3677,11 +3657,11 @@ static DisasJumpType trans_depw_imm_c(DisasContext *ctx, uint32_t insn,
     if (c) {
         ctx->null_cond = do_sed_cond(c, dest);
     }
-    return nullify_end(ctx, DISAS_NEXT);
+    return nullify_end(ctx);
 }
 
-static DisasJumpType trans_depw_imm(DisasContext *ctx, uint32_t insn,
-                                    const DisasInsn *di)
+static bool trans_depw_imm(DisasContext *ctx, uint32_t insn,
+                           const DisasInsn *di)
 {
     unsigned clen = extract32(insn, 0, 5);
     unsigned cpos = extract32(insn, 5, 5);
@@ -3714,11 +3694,11 @@ static DisasJumpType trans_depw_imm(DisasContext *ctx, uint32_t insn,
     if (c) {
         ctx->null_cond = do_sed_cond(c, dest);
     }
-    return nullify_end(ctx, DISAS_NEXT);
+    return nullify_end(ctx);
 }
 
-static DisasJumpType trans_depw_sar(DisasContext *ctx, uint32_t insn,
-                                    const DisasInsn *di)
+static bool trans_depw_sar(DisasContext *ctx, uint32_t insn,
+                           const DisasInsn *di)
 {
     unsigned clen = extract32(insn, 0, 5);
     unsigned nz = extract32(insn, 10, 1);
@@ -3766,7 +3746,7 @@ static DisasJumpType trans_depw_sar(DisasContext *ctx, uint32_t insn,
     if (c) {
         ctx->null_cond = do_sed_cond(c, dest);
     }
-    return nullify_end(ctx, DISAS_NEXT);
+    return nullify_end(ctx);
 }
 
 static const DisasInsn table_depw[] = {
@@ -3775,7 +3755,7 @@ static const DisasInsn table_depw[] = {
     { 0xd4001800u, 0xfc001800u, trans_depw_imm_c },
 };
 
-static DisasJumpType trans_be(DisasContext *ctx, uint32_t insn, bool is_l)
+static bool trans_be(DisasContext *ctx, uint32_t insn, bool is_l)
 {
     unsigned n = extract32(insn, 1, 1);
     unsigned b = extract32(insn, 21, 5);
@@ -3792,7 +3772,8 @@ static DisasJumpType trans_be(DisasContext *ctx, uint32_t insn, bool is_l)
        case of "be disp(*,r0)" using a direct branch to disp, so that we can
        goto_tb to the TB containing the syscall.  */
     if (b == 0) {
-        return do_dbranch(ctx, disp, is_l ? 31 : 0, n);
+        do_dbranch(ctx, disp, is_l ? 31 : 0, n);
+        return true;
     }
 #else
     int sp = assemble_sr3(insn);
@@ -3804,7 +3785,7 @@ static DisasJumpType trans_be(DisasContext *ctx, uint32_t insn, bool is_l)
     tmp = do_ibranch_priv(ctx, tmp);
 
 #ifdef CONFIG_USER_ONLY
-    return do_ibranch(ctx, tmp, is_l ? 31 : 0, n);
+    do_ibranch(ctx, tmp, is_l ? 31 : 0, n);
 #else
     TCGv_i64 new_spc = tcg_temp_new_i64();
 
@@ -3829,22 +3810,23 @@ static DisasJumpType trans_be(DisasContext *ctx, uint32_t insn, bool is_l)
     }
     tcg_temp_free_i64(new_spc);
     tcg_gen_lookup_and_goto_ptr();
-    return nullify_end(ctx, DISAS_NORETURN);
+    ctx->base.is_jmp = DISAS_NORETURN;
+    return nullify_end(ctx);
 #endif
+    return true;
 }
 
-static DisasJumpType trans_bl(DisasContext *ctx, uint32_t insn,
-                              const DisasInsn *di)
+static bool trans_bl(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned n = extract32(insn, 1, 1);
     unsigned link = extract32(insn, 21, 5);
     target_sreg disp = assemble_17(insn);
 
-    return do_dbranch(ctx, iaoq_dest(ctx, disp), link, n);
+    do_dbranch(ctx, iaoq_dest(ctx, disp), link, n);
+    return true;
 }
 
-static DisasJumpType trans_b_gate(DisasContext *ctx, uint32_t insn,
-                                  const DisasInsn *di)
+static bool trans_b_gate(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned n = extract32(insn, 1, 1);
     unsigned link = extract32(insn, 21, 5);
@@ -3876,7 +3858,8 @@ static DisasJumpType trans_b_gate(DisasContext *ctx, uint32_t insn,
            we will re-translate, at which point we *will* be able to find
            the TLB entry and determine if this is in fact a gateway page.  */
         if (type < 0) {
-            return gen_excp(ctx, EXCP_ITLB_MISS);
+            gen_excp(ctx, EXCP_ITLB_MISS);
+            return true;
         }
         /* No change for non-gateway pages or for priv decrease.  */
         if (type >= 4 && type - 4 < ctx->privilege) {
@@ -3887,20 +3870,20 @@ static DisasJumpType trans_b_gate(DisasContext *ctx, uint32_t insn,
     }
 #endif
 
-    return do_dbranch(ctx, dest, link, n);
+    do_dbranch(ctx, dest, link, n);
+    return true;
 }
 
-static DisasJumpType trans_bl_long(DisasContext *ctx, uint32_t insn,
-                                   const DisasInsn *di)
+static bool trans_bl_long(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned n = extract32(insn, 1, 1);
     target_sreg disp = assemble_22(insn);
 
-    return do_dbranch(ctx, iaoq_dest(ctx, disp), 2, n);
+    do_dbranch(ctx, iaoq_dest(ctx, disp), 2, n);
+    return true;
 }
 
-static DisasJumpType trans_blr(DisasContext *ctx, uint32_t insn,
-                               const DisasInsn *di)
+static bool trans_blr(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned n = extract32(insn, 1, 1);
     unsigned rx = extract32(insn, 16, 5);
@@ -3910,11 +3893,11 @@ static DisasJumpType trans_blr(DisasContext *ctx, uint32_t insn,
     tcg_gen_shli_reg(tmp, load_gpr(ctx, rx), 3);
     tcg_gen_addi_reg(tmp, tmp, ctx->iaoq_f + 8);
     /* The computation here never changes privilege level.  */
-    return do_ibranch(ctx, tmp, link, n);
+    do_ibranch(ctx, tmp, link, n);
+    return true;
 }
 
-static DisasJumpType trans_bv(DisasContext *ctx, uint32_t insn,
-                              const DisasInsn *di)
+static bool trans_bv(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned n = extract32(insn, 1, 1);
     unsigned rx = extract32(insn, 16, 5);
@@ -3929,11 +3912,11 @@ static DisasJumpType trans_bv(DisasContext *ctx, uint32_t insn,
         tcg_gen_add_reg(dest, dest, load_gpr(ctx, rb));
     }
     dest = do_ibranch_priv(ctx, dest);
-    return do_ibranch(ctx, dest, 0, n);
+    do_ibranch(ctx, dest, 0, n);
+    return true;
 }
 
-static DisasJumpType trans_bve(DisasContext *ctx, uint32_t insn,
-                               const DisasInsn *di)
+static bool trans_bve(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned n = extract32(insn, 1, 1);
     unsigned rb = extract32(insn, 21, 5);
@@ -3942,7 +3925,7 @@ static DisasJumpType trans_bve(DisasContext *ctx, uint32_t insn,
 
 #ifdef CONFIG_USER_ONLY
     dest = do_ibranch_priv(ctx, load_gpr(ctx, rb));
-    return do_ibranch(ctx, dest, link, n);
+    do_ibranch(ctx, dest, link, n);
 #else
     nullify_over(ctx);
     dest = do_ibranch_priv(ctx, load_gpr(ctx, rb));
@@ -3958,8 +3941,10 @@ static DisasJumpType trans_bve(DisasContext *ctx, uint32_t insn,
     }
     nullify_set(ctx, n);
     tcg_gen_lookup_and_goto_ptr();
-    return nullify_end(ctx, DISAS_NORETURN);
+    ctx->base.is_jmp = DISAS_NORETURN;
+    return nullify_end(ctx);
 #endif
+    return true;
 }
 
 static const DisasInsn table_branch[] = {
@@ -3971,87 +3956,97 @@ static const DisasInsn table_branch[] = {
     { 0xe8002000u, 0xfc00e000u, trans_b_gate },
 };
 
-static DisasJumpType trans_fop_wew_0c(DisasContext *ctx, uint32_t insn,
-                                      const DisasInsn *di)
+static bool trans_fop_wew_0c(DisasContext *ctx, uint32_t insn,
+                             const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned ra = extract32(insn, 21, 5);
-    return do_fop_wew(ctx, rt, ra, di->f.wew);
+    do_fop_wew(ctx, rt, ra, di->f.wew);
+    return true;
 }
 
-static DisasJumpType trans_fop_wew_0e(DisasContext *ctx, uint32_t insn,
-                                      const DisasInsn *di)
+static bool trans_fop_wew_0e(DisasContext *ctx, uint32_t insn,
+                             const DisasInsn *di)
 {
     unsigned rt = assemble_rt64(insn);
     unsigned ra = assemble_ra64(insn);
-    return do_fop_wew(ctx, rt, ra, di->f.wew);
+    do_fop_wew(ctx, rt, ra, di->f.wew);
+    return true;
 }
 
-static DisasJumpType trans_fop_ded(DisasContext *ctx, uint32_t insn,
-                                   const DisasInsn *di)
+static bool trans_fop_ded(DisasContext *ctx, uint32_t insn,
+                          const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned ra = extract32(insn, 21, 5);
-    return do_fop_ded(ctx, rt, ra, di->f.ded);
+    do_fop_ded(ctx, rt, ra, di->f.ded);
+    return true;
 }
 
-static DisasJumpType trans_fop_wed_0c(DisasContext *ctx, uint32_t insn,
-                                      const DisasInsn *di)
+static bool trans_fop_wed_0c(DisasContext *ctx, uint32_t insn,
+                             const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned ra = extract32(insn, 21, 5);
-    return do_fop_wed(ctx, rt, ra, di->f.wed);
+    do_fop_wed(ctx, rt, ra, di->f.wed);
+    return true;
 }
 
-static DisasJumpType trans_fop_wed_0e(DisasContext *ctx, uint32_t insn,
-                                      const DisasInsn *di)
+static bool trans_fop_wed_0e(DisasContext *ctx, uint32_t insn,
+                             const DisasInsn *di)
 {
     unsigned rt = assemble_rt64(insn);
     unsigned ra = extract32(insn, 21, 5);
-    return do_fop_wed(ctx, rt, ra, di->f.wed);
+    do_fop_wed(ctx, rt, ra, di->f.wed);
+    return true;
 }
 
-static DisasJumpType trans_fop_dew_0c(DisasContext *ctx, uint32_t insn,
-                                      const DisasInsn *di)
+static bool trans_fop_dew_0c(DisasContext *ctx, uint32_t insn,
+                             const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned ra = extract32(insn, 21, 5);
-    return do_fop_dew(ctx, rt, ra, di->f.dew);
+    do_fop_dew(ctx, rt, ra, di->f.dew);
+    return true;
 }
 
-static DisasJumpType trans_fop_dew_0e(DisasContext *ctx, uint32_t insn,
-                                      const DisasInsn *di)
+static bool trans_fop_dew_0e(DisasContext *ctx, uint32_t insn,
+                             const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned ra = assemble_ra64(insn);
-    return do_fop_dew(ctx, rt, ra, di->f.dew);
+    do_fop_dew(ctx, rt, ra, di->f.dew);
+    return true;
 }
 
-static DisasJumpType trans_fop_weww_0c(DisasContext *ctx, uint32_t insn,
-                                       const DisasInsn *di)
+static bool trans_fop_weww_0c(DisasContext *ctx, uint32_t insn,
+                              const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned rb = extract32(insn, 16, 5);
     unsigned ra = extract32(insn, 21, 5);
-    return do_fop_weww(ctx, rt, ra, rb, di->f.weww);
+    do_fop_weww(ctx, rt, ra, rb, di->f.weww);
+    return true;
 }
 
-static DisasJumpType trans_fop_weww_0e(DisasContext *ctx, uint32_t insn,
-                                       const DisasInsn *di)
+static bool trans_fop_weww_0e(DisasContext *ctx, uint32_t insn,
+                              const DisasInsn *di)
 {
     unsigned rt = assemble_rt64(insn);
     unsigned rb = assemble_rb64(insn);
     unsigned ra = assemble_ra64(insn);
-    return do_fop_weww(ctx, rt, ra, rb, di->f.weww);
+    do_fop_weww(ctx, rt, ra, rb, di->f.weww);
+    return true;
 }
 
-static DisasJumpType trans_fop_dedd(DisasContext *ctx, uint32_t insn,
-                                    const DisasInsn *di)
+static bool trans_fop_dedd(DisasContext *ctx, uint32_t insn,
+                           const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned rb = extract32(insn, 16, 5);
     unsigned ra = extract32(insn, 21, 5);
-    return do_fop_dedd(ctx, rt, ra, rb, di->f.dedd);
+    do_fop_dedd(ctx, rt, ra, rb, di->f.dedd);
+    return true;
 }
 
 static void gen_fcpy_s(TCGv_i32 dst, TCGv_env unused, TCGv_i32 src)
@@ -4094,8 +4089,8 @@ static void gen_fnegabs_d(TCGv_i64 dst, TCGv_env unused, TCGv_i64 src)
     tcg_gen_ori_i64(dst, src, INT64_MIN);
 }
 
-static DisasJumpType do_fcmp_s(DisasContext *ctx, unsigned ra, unsigned rb,
-                               unsigned y, unsigned c)
+static void do_fcmp_s(DisasContext *ctx, unsigned ra, unsigned rb,
+                      unsigned y, unsigned c)
 {
     TCGv_i32 ta, tb, tc, ty;
 
@@ -4113,31 +4108,32 @@ static DisasJumpType do_fcmp_s(DisasContext *ctx, unsigned ra, unsigned rb,
     tcg_temp_free_i32(ty);
     tcg_temp_free_i32(tc);
 
-    return nullify_end(ctx, DISAS_NEXT);
+    nullify_end(ctx);
 }
 
-static DisasJumpType trans_fcmp_s_0c(DisasContext *ctx, uint32_t insn,
-                                     const DisasInsn *di)
+static bool trans_fcmp_s_0c(DisasContext *ctx, uint32_t insn,
+                            const DisasInsn *di)
 {
     unsigned c = extract32(insn, 0, 5);
     unsigned y = extract32(insn, 13, 3);
     unsigned rb = extract32(insn, 16, 5);
     unsigned ra = extract32(insn, 21, 5);
-    return do_fcmp_s(ctx, ra, rb, y, c);
+    do_fcmp_s(ctx, ra, rb, y, c);
+    return true;
 }
 
-static DisasJumpType trans_fcmp_s_0e(DisasContext *ctx, uint32_t insn,
-                                     const DisasInsn *di)
+static bool trans_fcmp_s_0e(DisasContext *ctx, uint32_t insn,
+                            const DisasInsn *di)
 {
     unsigned c = extract32(insn, 0, 5);
     unsigned y = extract32(insn, 13, 3);
     unsigned rb = assemble_rb64(insn);
     unsigned ra = assemble_ra64(insn);
-    return do_fcmp_s(ctx, ra, rb, y, c);
+    do_fcmp_s(ctx, ra, rb, y, c);
+    return true;
 }
 
-static DisasJumpType trans_fcmp_d(DisasContext *ctx, uint32_t insn,
-                                  const DisasInsn *di)
+static bool trans_fcmp_d(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned c = extract32(insn, 0, 5);
     unsigned y = extract32(insn, 13, 3);
@@ -4160,11 +4156,11 @@ static DisasJumpType trans_fcmp_d(DisasContext *ctx, uint32_t insn,
     tcg_temp_free_i32(ty);
     tcg_temp_free_i32(tc);
 
-    return nullify_end(ctx, DISAS_NEXT);
+    return nullify_end(ctx);
 }
 
-static DisasJumpType trans_ftest_t(DisasContext *ctx, uint32_t insn,
-                                   const DisasInsn *di)
+static bool trans_ftest_t(DisasContext *ctx, uint32_t insn,
+                          const DisasInsn *di)
 {
     unsigned y = extract32(insn, 13, 3);
     unsigned cbit = (y ^ 1) - 1;
@@ -4178,11 +4174,11 @@ static DisasJumpType trans_ftest_t(DisasContext *ctx, uint32_t insn,
     ctx->null_cond = cond_make_0(TCG_COND_NE, t);
     tcg_temp_free(t);
 
-    return nullify_end(ctx, DISAS_NEXT);
+    return nullify_end(ctx);
 }
 
-static DisasJumpType trans_ftest_q(DisasContext *ctx, uint32_t insn,
-                                   const DisasInsn *di)
+static bool trans_ftest_q(DisasContext *ctx, uint32_t insn,
+                          const DisasInsn *di)
 {
     unsigned c = extract32(insn, 0, 5);
     int mask;
@@ -4232,11 +4228,10 @@ static DisasJumpType trans_ftest_q(DisasContext *ctx, uint32_t insn,
         ctx->null_cond = cond_make_0(TCG_COND_EQ, t);
     }
  done:
-    return nullify_end(ctx, DISAS_NEXT);
+    return nullify_end(ctx);
 }
 
-static DisasJumpType trans_xmpyu(DisasContext *ctx, uint32_t insn,
-                                 const DisasInsn *di)
+static bool trans_xmpyu(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned rb = assemble_rb64(insn);
@@ -4252,7 +4247,7 @@ static DisasJumpType trans_xmpyu(DisasContext *ctx, uint32_t insn,
     tcg_temp_free_i64(a);
     tcg_temp_free_i64(b);
 
-    return nullify_end(ctx, DISAS_NEXT);
+    return nullify_end(ctx);
 }
 
 #define FOP_DED  trans_fop_ded, .f.ded
@@ -4427,8 +4422,7 @@ static inline int fmpyadd_s_reg(unsigned r)
     return (r & 16) * 2 + 16 + (r & 15);
 }
 
-static DisasJumpType trans_fmpyadd(DisasContext *ctx,
-                                   uint32_t insn, bool is_sub)
+static bool trans_fmpyadd(DisasContext *ctx, uint32_t insn, bool is_sub)
 {
     unsigned tm = extract32(insn, 0, 5);
     unsigned f = extract32(insn, 5, 1);
@@ -4456,11 +4450,11 @@ static DisasJumpType trans_fmpyadd(DisasContext *ctx,
                     is_sub ? gen_helper_fsub_d : gen_helper_fadd_d);
     }
 
-    return nullify_end(ctx, DISAS_NEXT);
+    return nullify_end(ctx);
 }
 
-static DisasJumpType trans_fmpyfadd_s(DisasContext *ctx, uint32_t insn,
-                                      const DisasInsn *di)
+static bool trans_fmpyfadd_s(DisasContext *ctx, uint32_t insn,
+                             const DisasInsn *di)
 {
     unsigned rt = assemble_rt64(insn);
     unsigned neg = extract32(insn, 5, 1);
@@ -4484,11 +4478,11 @@ static DisasJumpType trans_fmpyfadd_s(DisasContext *ctx, uint32_t insn,
     tcg_temp_free_i32(c);
     save_frw_i32(rt, a);
     tcg_temp_free_i32(a);
-    return nullify_end(ctx, DISAS_NEXT);
+    return nullify_end(ctx);
 }
 
-static DisasJumpType trans_fmpyfadd_d(DisasContext *ctx, uint32_t insn,
-                                      const DisasInsn *di)
+static bool trans_fmpyfadd_d(DisasContext *ctx, uint32_t insn,
+                             const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned neg = extract32(insn, 5, 1);
@@ -4512,7 +4506,7 @@ static DisasJumpType trans_fmpyfadd_d(DisasContext *ctx, uint32_t insn,
     tcg_temp_free_i64(c);
     save_frd(rt, a);
     tcg_temp_free_i64(a);
-    return nullify_end(ctx, DISAS_NEXT);
+    return nullify_end(ctx);
 }
 
 static const DisasInsn table_fp_fused[] = {
@@ -4520,127 +4514,175 @@ static const DisasInsn table_fp_fused[] = {
     { 0xb8000800u, 0xfc0019c0u, trans_fmpyfadd_d }
 };
 
-static DisasJumpType translate_table_int(DisasContext *ctx, uint32_t insn,
-                                         const DisasInsn table[], size_t n)
+static void translate_table_int(DisasContext *ctx, uint32_t insn,
+                                const DisasInsn table[], size_t n)
 {
     size_t i;
     for (i = 0; i < n; ++i) {
         if ((insn & table[i].mask) == table[i].insn) {
-            return table[i].trans(ctx, insn, &table[i]);
+            table[i].trans(ctx, insn, &table[i]);
+            return;
         }
     }
     qemu_log_mask(LOG_UNIMP, "UNIMP insn %08x @ " TARGET_FMT_lx "\n",
                   insn, ctx->base.pc_next);
-    return gen_illegal(ctx);
+    gen_illegal(ctx);
 }
 
 #define translate_table(ctx, insn, table) \
     translate_table_int(ctx, insn, table, ARRAY_SIZE(table))
 
-static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
+static void translate_one(DisasContext *ctx, uint32_t insn)
 {
     uint32_t opc = extract32(insn, 26, 6);
 
     switch (opc) {
     case 0x00: /* system op */
-        return translate_table(ctx, insn, table_system);
+        translate_table(ctx, insn, table_system);
+        return;
     case 0x01:
-        return translate_table(ctx, insn, table_mem_mgmt);
+        translate_table(ctx, insn, table_mem_mgmt);
+        return;
     case 0x02:
-        return translate_table(ctx, insn, table_arith_log);
+        translate_table(ctx, insn, table_arith_log);
+        return;
     case 0x03:
-        return translate_table(ctx, insn, table_index_mem);
+        translate_table(ctx, insn, table_index_mem);
+        return;
     case 0x06:
-        return trans_fmpyadd(ctx, insn, false);
+        trans_fmpyadd(ctx, insn, false);
+        return;
     case 0x08:
-        return trans_ldil(ctx, insn);
+        trans_ldil(ctx, insn);
+        return;
     case 0x09:
-        return trans_copr_w(ctx, insn);
+        trans_copr_w(ctx, insn);
+        return;
     case 0x0A:
-        return trans_addil(ctx, insn);
+        trans_addil(ctx, insn);
+        return;
     case 0x0B:
-        return trans_copr_dw(ctx, insn);
+        trans_copr_dw(ctx, insn);
+        return;
     case 0x0C:
-        return translate_table(ctx, insn, table_float_0c);
+        translate_table(ctx, insn, table_float_0c);
+        return;
     case 0x0D:
-        return trans_ldo(ctx, insn);
+        trans_ldo(ctx, insn);
+        return;
     case 0x0E:
-        return translate_table(ctx, insn, table_float_0e);
+        translate_table(ctx, insn, table_float_0e);
+        return;
 
     case 0x10:
-        return trans_load(ctx, insn, false, MO_UB);
+        trans_load(ctx, insn, false, MO_UB);
+        return;
     case 0x11:
-        return trans_load(ctx, insn, false, MO_TEUW);
+        trans_load(ctx, insn, false, MO_TEUW);
+        return;
     case 0x12:
-        return trans_load(ctx, insn, false, MO_TEUL);
+        trans_load(ctx, insn, false, MO_TEUL);
+        return;
     case 0x13:
-        return trans_load(ctx, insn, true, MO_TEUL);
+        trans_load(ctx, insn, true, MO_TEUL);
+        return;
     case 0x16:
-        return trans_fload_mod(ctx, insn);
+        trans_fload_mod(ctx, insn);
+        return;
     case 0x17:
-        return trans_load_w(ctx, insn);
+        trans_load_w(ctx, insn);
+        return;
     case 0x18:
-        return trans_store(ctx, insn, false, MO_UB);
+        trans_store(ctx, insn, false, MO_UB);
+        return;
     case 0x19:
-        return trans_store(ctx, insn, false, MO_TEUW);
+        trans_store(ctx, insn, false, MO_TEUW);
+        return;
     case 0x1A:
-        return trans_store(ctx, insn, false, MO_TEUL);
+        trans_store(ctx, insn, false, MO_TEUL);
+        return;
     case 0x1B:
-        return trans_store(ctx, insn, true, MO_TEUL);
+        trans_store(ctx, insn, true, MO_TEUL);
+        return;
     case 0x1E:
-        return trans_fstore_mod(ctx, insn);
+        trans_fstore_mod(ctx, insn);
+        return;
     case 0x1F:
-        return trans_store_w(ctx, insn);
+        trans_store_w(ctx, insn);
+        return;
 
     case 0x20:
-        return trans_cmpb(ctx, insn, true, false, false);
+        trans_cmpb(ctx, insn, true, false, false);
+        return;
     case 0x21:
-        return trans_cmpb(ctx, insn, true, true, false);
+        trans_cmpb(ctx, insn, true, true, false);
+        return;
     case 0x22:
-        return trans_cmpb(ctx, insn, false, false, false);
+        trans_cmpb(ctx, insn, false, false, false);
+        return;
     case 0x23:
-        return trans_cmpb(ctx, insn, false, true, false);
+        trans_cmpb(ctx, insn, false, true, false);
+        return;
     case 0x24:
-        return trans_cmpiclr(ctx, insn);
+        trans_cmpiclr(ctx, insn);
+        return;
     case 0x25:
-        return trans_subi(ctx, insn);
+        trans_subi(ctx, insn);
+        return;
     case 0x26:
-        return trans_fmpyadd(ctx, insn, true);
+        trans_fmpyadd(ctx, insn, true);
+        return;
     case 0x27:
-        return trans_cmpb(ctx, insn, true, false, true);
+        trans_cmpb(ctx, insn, true, false, true);
+        return;
     case 0x28:
-        return trans_addb(ctx, insn, true, false);
+        trans_addb(ctx, insn, true, false);
+        return;
     case 0x29:
-        return trans_addb(ctx, insn, true, true);
+        trans_addb(ctx, insn, true, true);
+        return;
     case 0x2A:
-        return trans_addb(ctx, insn, false, false);
+        trans_addb(ctx, insn, false, false);
+        return;
     case 0x2B:
-        return trans_addb(ctx, insn, false, true);
+        trans_addb(ctx, insn, false, true);
+        return;
     case 0x2C:
     case 0x2D:
-        return trans_addi(ctx, insn);
+        trans_addi(ctx, insn);
+        return;
     case 0x2E:
-        return translate_table(ctx, insn, table_fp_fused);
+        translate_table(ctx, insn, table_fp_fused);
+        return;
     case 0x2F:
-        return trans_cmpb(ctx, insn, false, false, true);
+        trans_cmpb(ctx, insn, false, false, true);
+        return;
 
     case 0x30:
     case 0x31:
-        return trans_bb(ctx, insn);
+        trans_bb(ctx, insn);
+        return;
     case 0x32:
-        return trans_movb(ctx, insn, false);
+        trans_movb(ctx, insn, false);
+        return;
     case 0x33:
-        return trans_movb(ctx, insn, true);
+        trans_movb(ctx, insn, true);
+        return;
     case 0x34:
-        return translate_table(ctx, insn, table_sh_ex);
+        translate_table(ctx, insn, table_sh_ex);
+        return;
     case 0x35:
-        return translate_table(ctx, insn, table_depw);
+        translate_table(ctx, insn, table_depw);
+        return;
     case 0x38:
-        return trans_be(ctx, insn, false);
+        trans_be(ctx, insn, false);
+        return;
     case 0x39:
-        return trans_be(ctx, insn, true);
+        trans_be(ctx, insn, true);
+        return;
     case 0x3A:
-        return translate_table(ctx, insn, table_branch);
+        translate_table(ctx, insn, table_branch);
+        return;
 
     case 0x04: /* spopn */
     case 0x05: /* diag */
@@ -4656,17 +4698,19 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
 #ifndef CONFIG_USER_ONLY
         /* Unassigned, but use as system-halt.  */
         if (insn == 0xfffdead0) {
-            return gen_hlt(ctx, 0); /* halt system */
+            gen_hlt(ctx, 0); /* halt system */
+            return;
         }
         if (insn == 0xfffdead1) {
-            return gen_hlt(ctx, 1); /* reset system */
+            gen_hlt(ctx, 1); /* reset system */
+            return;
         }
 #endif
         break;
     default:
         break;
     }
-    return gen_illegal(ctx);
+    gen_illegal(ctx);
 }
 
 static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
@@ -4733,7 +4777,7 @@ static bool hppa_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    ctx->base.is_jmp = gen_excp(ctx, EXCP_DEBUG);
+    gen_excp(ctx, EXCP_DEBUG);
     ctx->base.pc_next += 4;
     return true;
 }
@@ -4748,7 +4792,8 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     /* Execute one insn.  */
 #ifdef CONFIG_USER_ONLY
     if (ctx->base.pc_next < TARGET_PAGE_SIZE) {
-        ret = do_page_zero(ctx);
+        do_page_zero(ctx);
+        ret = ctx->base.is_jmp;
         assert(ret != DISAS_NEXT);
     } else
 #endif
@@ -4773,7 +4818,8 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
             ret = DISAS_NEXT;
         } else {
             ctx->insn = insn;
-            ret = translate_one(ctx, insn);
+            translate_one(ctx, insn);
+            ret = ctx->base.is_jmp;
             assert(ctx->null_lab == NULL);
         }
     }
@@ -4799,14 +4845,13 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
                 || ctx->null_cond.c == TCG_COND_ALWAYS)) {
             nullify_set(ctx, ctx->null_cond.c == TCG_COND_ALWAYS);
             gen_goto_tb(ctx, 0, ctx->iaoq_b, ctx->iaoq_n);
-            ret = DISAS_NORETURN;
+            ctx->base.is_jmp = ret = DISAS_NORETURN;
         } else {
-            ret = DISAS_IAQ_N_STALE;
+            ctx->base.is_jmp = ret = DISAS_IAQ_N_STALE;
         }
     }
     ctx->iaoq_f = ctx->iaoq_b;
     ctx->iaoq_b = ctx->iaoq_n;
-    ctx->base.is_jmp = ret;
     ctx->base.pc_next += 4;
 
     if (ret == DISAS_NORETURN || ret == DISAS_IAQ_N_UPDATED) {
-- 
2.17.2
