Received: from eggs.gnu.org ([2001:4830:134:3::10]:51221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq1nS-0004Xj-EU
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:45:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq1nI-0005YL-Vc
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:45:02 -0400
Received: from mail-pf0-x22b.google.com ([2607:f8b0:400e:c00::22b]:34429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dq1nI-0005Y6-Hx
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:44:52 -0400
Received: by mail-pf0-x22b.google.com with SMTP id e1so822653pfk.1
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 11:44:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Sep 2017 11:44:45 -0700
Message-Id: <20170907184447.22752-2-richard.henderson@linaro.org>
In-Reply-To: <20170907184447.22752-1-richard.henderson@linaro.org>
References: <20170907184447.22752-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 1/3] target/hppa: Convert to DisasJumpType
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/hppa/translate.c | 601 +++++++++++++++++++++++-------------------------
 1 file changed, 294 insertions(+), 307 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 900870cd5a..cb4a3e6cb4 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -24,10 +24,9 @@
 #include "exec/exec-all.h"
 #include "tcg-op.h"
 #include "exec/cpu_ldst.h"
-
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
-
+#include "exec/translator.h"
 #include "trace-tcg.h"
 #include "exec/log.h"
 
@@ -57,32 +56,22 @@ typedef struct DisasContext {
     bool psw_n_nonzero;
 } DisasContext;
 
-/* Return values from translate_one, indicating the state of the TB.
-   Note that zero indicates that we are not exiting the TB.  */
-
-typedef enum {
-    NO_EXIT,
+/* Target-specific return values from translate_one, indicating the
+   state of the TB.  Note that DISAS_NEXT indicates that we are not
+   exiting the TB.  */
 
-    /* We have emitted one or more goto_tb.  No fixup required.  */
-    EXIT_GOTO_TB,
+/* We are not using a goto_tb (for whatever reason), but have updated
+   the iaq (for whatever reason), so don't do it again on exit.  */
+#define DISAS_IAQ_N_UPDATED  DISAS_TARGET_0
 
-    /* We are not using a goto_tb (for whatever reason), but have updated
-       the iaq (for whatever reason), so don't do it again on exit.  */
-    EXIT_IAQ_N_UPDATED,
-
-    /* We are exiting the TB, but have neither emitted a goto_tb, nor
-       updated the iaq for the next instruction to be executed.  */
-    EXIT_IAQ_N_STALE,
-
-    /* We are ending the TB with a noreturn function call, e.g. longjmp.
-       No following code will be executed.  */
-    EXIT_NORETURN,
-} ExitStatus;
+/* We are exiting the TB, but have neither emitted a goto_tb, nor
+   updated the iaq for the next instruction to be executed.  */
+#define DISAS_IAQ_N_STALE    DISAS_TARGET_1
 
 typedef struct DisasInsn {
     uint32_t insn, mask;
-    ExitStatus (*trans)(DisasContext *ctx, uint32_t insn,
-                        const struct DisasInsn *f);
+    DisasJumpType (*trans)(DisasContext *ctx, uint32_t insn,
+                           const struct DisasInsn *f);
     union {
         void (*ttt)(TCGv, TCGv, TCGv);
         void (*weww)(TCGv_i32, TCGv_env, TCGv_i32, TCGv_i32);
@@ -415,7 +404,7 @@ static void nullify_set(DisasContext *ctx, bool x)
 
 /* Mark the end of an instruction that may have been nullified.
    This is the pair to nullify_over.  */
-static ExitStatus nullify_end(DisasContext *ctx, ExitStatus status)
+static DisasJumpType nullify_end(DisasContext *ctx, DisasJumpType status)
 {
     TCGLabel *null_lab = ctx->null_lab;
 
@@ -441,9 +430,9 @@ static ExitStatus nullify_end(DisasContext *ctx, ExitStatus status)
         ctx->null_cond = cond_make_n();
     }
 
-    assert(status != EXIT_GOTO_TB && status != EXIT_IAQ_N_UPDATED);
-    if (status == EXIT_NORETURN) {
-        status = NO_EXIT;
+    assert(status != DISAS_NORETURN && status != DISAS_IAQ_N_UPDATED);
+    if (status == DISAS_NORETURN) {
+        status = DISAS_NEXT;
     }
     return status;
 }
@@ -469,16 +458,16 @@ static void gen_excp_1(int exception)
     tcg_temp_free_i32(t);
 }
 
-static ExitStatus gen_excp(DisasContext *ctx, int exception)
+static DisasJumpType gen_excp(DisasContext *ctx, int exception)
 {
     copy_iaoq_entry(cpu_iaoq_f, ctx->iaoq_f, cpu_iaoq_f);
     copy_iaoq_entry(cpu_iaoq_b, ctx->iaoq_b, cpu_iaoq_b);
     nullify_save(ctx);
     gen_excp_1(exception);
-    return EXIT_NORETURN;
+    return DISAS_NORETURN;
 }
 
-static ExitStatus gen_illegal(DisasContext *ctx)
+static DisasJumpType gen_illegal(DisasContext *ctx)
 {
     nullify_over(ctx);
     return nullify_end(ctx, gen_excp(ctx, EXCP_SIGILL));
@@ -839,9 +828,9 @@ static TCGv do_sub_sv(DisasContext *ctx, TCGv res, TCGv in1, TCGv in2)
     return sv;
 }
 
-static ExitStatus do_add(DisasContext *ctx, unsigned rt, TCGv in1, TCGv in2,
-                         unsigned shift, bool is_l, bool is_tsv, bool is_tc,
-                         bool is_c, unsigned cf)
+static DisasJumpType do_add(DisasContext *ctx, unsigned rt, TCGv in1, TCGv in2,
+                            unsigned shift, bool is_l, bool is_tsv, bool is_tc,
+                            bool is_c, unsigned cf)
 {
     TCGv dest, cb, cb_msb, sv, tmp;
     unsigned c = cf >> 1;
@@ -908,11 +897,11 @@ static ExitStatus do_add(DisasContext *ctx, unsigned rt, TCGv in1, TCGv in2,
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     ctx->null_cond = cond;
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus do_sub(DisasContext *ctx, unsigned rt, TCGv in1, TCGv in2,
-                         bool is_tsv, bool is_b, bool is_tc, unsigned cf)
+static DisasJumpType do_sub(DisasContext *ctx, unsigned rt, TCGv in1, TCGv in2,
+                            bool is_tsv, bool is_b, bool is_tc, unsigned cf)
 {
     TCGv dest, sv, cb, cb_msb, zero, tmp;
     unsigned c = cf >> 1;
@@ -974,11 +963,11 @@ static ExitStatus do_sub(DisasContext *ctx, unsigned rt, TCGv in1, TCGv in2,
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     ctx->null_cond = cond;
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus do_cmpclr(DisasContext *ctx, unsigned rt, TCGv in1,
-                            TCGv in2, unsigned cf)
+static DisasJumpType do_cmpclr(DisasContext *ctx, unsigned rt, TCGv in1,
+                               TCGv in2, unsigned cf)
 {
     TCGv dest, sv;
     DisasCond cond;
@@ -1003,11 +992,11 @@ static ExitStatus do_cmpclr(DisasContext *ctx, unsigned rt, TCGv in1,
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     ctx->null_cond = cond;
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus do_log(DisasContext *ctx, unsigned rt, TCGv in1, TCGv in2,
-                         unsigned cf, void (*fn)(TCGv, TCGv, TCGv))
+static DisasJumpType do_log(DisasContext *ctx, unsigned rt, TCGv in1, TCGv in2,
+                            unsigned cf, void (*fn)(TCGv, TCGv, TCGv))
 {
     TCGv dest = dest_gpr(ctx, rt);
 
@@ -1020,12 +1009,12 @@ static ExitStatus do_log(DisasContext *ctx, unsigned rt, TCGv in1, TCGv in2,
     if (cf) {
         ctx->null_cond = do_log_cond(cf, dest);
     }
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus do_unit(DisasContext *ctx, unsigned rt, TCGv in1,
-                          TCGv in2, unsigned cf, bool is_tc,
-                          void (*fn)(TCGv, TCGv, TCGv))
+static DisasJumpType do_unit(DisasContext *ctx, unsigned rt, TCGv in1,
+                             TCGv in2, unsigned cf, bool is_tc,
+                             void (*fn)(TCGv, TCGv, TCGv))
 {
     TCGv dest;
     DisasCond cond;
@@ -1053,7 +1042,7 @@ static ExitStatus do_unit(DisasContext *ctx, unsigned rt, TCGv in1,
         cond_free(&ctx->null_cond);
         ctx->null_cond = cond;
     }
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
 /* Emit a memory load.  The modify parameter should be
@@ -1185,9 +1174,9 @@ static void do_store_64(DisasContext *ctx, TCGv_i64 src, unsigned rb,
 #define do_store_tl do_store_32
 #endif
 
-static ExitStatus do_load(DisasContext *ctx, unsigned rt, unsigned rb,
-                          unsigned rx, int scale, target_long disp,
-                          int modify, TCGMemOp mop)
+static DisasJumpType do_load(DisasContext *ctx, unsigned rt, unsigned rb,
+                             unsigned rx, int scale, target_long disp,
+                             int modify, TCGMemOp mop)
 {
     TCGv dest;
 
@@ -1203,12 +1192,12 @@ static ExitStatus do_load(DisasContext *ctx, unsigned rt, unsigned rb,
     do_load_tl(ctx, dest, rb, rx, scale, disp, modify, mop);
     save_gpr(ctx, rt, dest);
 
-    return nullify_end(ctx, NO_EXIT);
+    return nullify_end(ctx, DISAS_NEXT);
 }
 
-static ExitStatus do_floadw(DisasContext *ctx, unsigned rt, unsigned rb,
-                            unsigned rx, int scale, target_long disp,
-                            int modify)
+static DisasJumpType do_floadw(DisasContext *ctx, unsigned rt, unsigned rb,
+                               unsigned rx, int scale, target_long disp,
+                               int modify)
 {
     TCGv_i32 tmp;
 
@@ -1223,12 +1212,12 @@ static ExitStatus do_floadw(DisasContext *ctx, unsigned rt, unsigned rb,
         gen_helper_loaded_fr0(cpu_env);
     }
 
-    return nullify_end(ctx, NO_EXIT);
+    return nullify_end(ctx, DISAS_NEXT);
 }
 
-static ExitStatus do_floadd(DisasContext *ctx, unsigned rt, unsigned rb,
-                            unsigned rx, int scale, target_long disp,
-                            int modify)
+static DisasJumpType do_floadd(DisasContext *ctx, unsigned rt, unsigned rb,
+                               unsigned rx, int scale, target_long disp,
+                               int modify)
 {
     TCGv_i64 tmp;
 
@@ -1243,20 +1232,20 @@ static ExitStatus do_floadd(DisasContext *ctx, unsigned rt, unsigned rb,
         gen_helper_loaded_fr0(cpu_env);
     }
 
-    return nullify_end(ctx, NO_EXIT);
+    return nullify_end(ctx, DISAS_NEXT);
 }
 
-static ExitStatus do_store(DisasContext *ctx, unsigned rt, unsigned rb,
-                           target_long disp, int modify, TCGMemOp mop)
+static DisasJumpType do_store(DisasContext *ctx, unsigned rt, unsigned rb,
+                              target_long disp, int modify, TCGMemOp mop)
 {
     nullify_over(ctx);
     do_store_tl(ctx, load_gpr(ctx, rt), rb, 0, 0, disp, modify, mop);
-    return nullify_end(ctx, NO_EXIT);
+    return nullify_end(ctx, DISAS_NEXT);
 }
 
-static ExitStatus do_fstorew(DisasContext *ctx, unsigned rt, unsigned rb,
-                             unsigned rx, int scale, target_long disp,
-                             int modify)
+static DisasJumpType do_fstorew(DisasContext *ctx, unsigned rt, unsigned rb,
+                                unsigned rx, int scale, target_long disp,
+                                int modify)
 {
     TCGv_i32 tmp;
 
@@ -1266,12 +1255,12 @@ static ExitStatus do_fstorew(DisasContext *ctx, unsigned rt, unsigned rb,
     do_store_32(ctx, tmp, rb, rx, scale, disp, modify, MO_TEUL);
     tcg_temp_free_i32(tmp);
 
-    return nullify_end(ctx, NO_EXIT);
+    return nullify_end(ctx, DISAS_NEXT);
 }
 
-static ExitStatus do_fstored(DisasContext *ctx, unsigned rt, unsigned rb,
-                             unsigned rx, int scale, target_long disp,
-                             int modify)
+static DisasJumpType do_fstored(DisasContext *ctx, unsigned rt, unsigned rb,
+                                unsigned rx, int scale, target_long disp,
+                                int modify)
 {
     TCGv_i64 tmp;
 
@@ -1281,11 +1270,11 @@ static ExitStatus do_fstored(DisasContext *ctx, unsigned rt, unsigned rb,
     do_store_64(ctx, tmp, rb, rx, scale, disp, modify, MO_TEQ);
     tcg_temp_free_i64(tmp);
 
-    return nullify_end(ctx, NO_EXIT);
+    return nullify_end(ctx, DISAS_NEXT);
 }
 
-static ExitStatus do_fop_wew(DisasContext *ctx, unsigned rt, unsigned ra,
-                             void (*func)(TCGv_i32, TCGv_env, TCGv_i32))
+static DisasJumpType do_fop_wew(DisasContext *ctx, unsigned rt, unsigned ra,
+                                void (*func)(TCGv_i32, TCGv_env, TCGv_i32))
 {
     TCGv_i32 tmp;
 
@@ -1296,11 +1285,11 @@ static ExitStatus do_fop_wew(DisasContext *ctx, unsigned rt, unsigned ra,
 
     save_frw_i32(rt, tmp);
     tcg_temp_free_i32(tmp);
-    return nullify_end(ctx, NO_EXIT);
+    return nullify_end(ctx, DISAS_NEXT);
 }
 
-static ExitStatus do_fop_wed(DisasContext *ctx, unsigned rt, unsigned ra,
-                             void (*func)(TCGv_i32, TCGv_env, TCGv_i64))
+static DisasJumpType do_fop_wed(DisasContext *ctx, unsigned rt, unsigned ra,
+                                void (*func)(TCGv_i32, TCGv_env, TCGv_i64))
 {
     TCGv_i32 dst;
     TCGv_i64 src;
@@ -1314,11 +1303,11 @@ static ExitStatus do_fop_wed(DisasContext *ctx, unsigned rt, unsigned ra,
     tcg_temp_free_i64(src);
     save_frw_i32(rt, dst);
     tcg_temp_free_i32(dst);
-    return nullify_end(ctx, NO_EXIT);
+    return nullify_end(ctx, DISAS_NEXT);
 }
 
-static ExitStatus do_fop_ded(DisasContext *ctx, unsigned rt, unsigned ra,
-                             void (*func)(TCGv_i64, TCGv_env, TCGv_i64))
+static DisasJumpType do_fop_ded(DisasContext *ctx, unsigned rt, unsigned ra,
+                                void (*func)(TCGv_i64, TCGv_env, TCGv_i64))
 {
     TCGv_i64 tmp;
 
@@ -1329,11 +1318,11 @@ static ExitStatus do_fop_ded(DisasContext *ctx, unsigned rt, unsigned ra,
 
     save_frd(rt, tmp);
     tcg_temp_free_i64(tmp);
-    return nullify_end(ctx, NO_EXIT);
+    return nullify_end(ctx, DISAS_NEXT);
 }
 
-static ExitStatus do_fop_dew(DisasContext *ctx, unsigned rt, unsigned ra,
-                             void (*func)(TCGv_i64, TCGv_env, TCGv_i32))
+static DisasJumpType do_fop_dew(DisasContext *ctx, unsigned rt, unsigned ra,
+                                void (*func)(TCGv_i64, TCGv_env, TCGv_i32))
 {
     TCGv_i32 src;
     TCGv_i64 dst;
@@ -1347,13 +1336,13 @@ static ExitStatus do_fop_dew(DisasContext *ctx, unsigned rt, unsigned ra,
     tcg_temp_free_i32(src);
     save_frd(rt, dst);
     tcg_temp_free_i64(dst);
-    return nullify_end(ctx, NO_EXIT);
+    return nullify_end(ctx, DISAS_NEXT);
 }
 
-static ExitStatus do_fop_weww(DisasContext *ctx, unsigned rt,
-                              unsigned ra, unsigned rb,
-                              void (*func)(TCGv_i32, TCGv_env,
-                                           TCGv_i32, TCGv_i32))
+static DisasJumpType do_fop_weww(DisasContext *ctx, unsigned rt,
+                                 unsigned ra, unsigned rb,
+                                 void (*func)(TCGv_i32, TCGv_env,
+                                              TCGv_i32, TCGv_i32))
 {
     TCGv_i32 a, b;
 
@@ -1366,13 +1355,13 @@ static ExitStatus do_fop_weww(DisasContext *ctx, unsigned rt,
     tcg_temp_free_i32(b);
     save_frw_i32(rt, a);
     tcg_temp_free_i32(a);
-    return nullify_end(ctx, NO_EXIT);
+    return nullify_end(ctx, DISAS_NEXT);
 }
 
-static ExitStatus do_fop_dedd(DisasContext *ctx, unsigned rt,
-                              unsigned ra, unsigned rb,
-                              void (*func)(TCGv_i64, TCGv_env,
-                                           TCGv_i64, TCGv_i64))
+static DisasJumpType do_fop_dedd(DisasContext *ctx, unsigned rt,
+                                 unsigned ra, unsigned rb,
+                                 void (*func)(TCGv_i64, TCGv_env,
+                                              TCGv_i64, TCGv_i64))
 {
     TCGv_i64 a, b;
 
@@ -1385,13 +1374,13 @@ static ExitStatus do_fop_dedd(DisasContext *ctx, unsigned rt,
     tcg_temp_free_i64(b);
     save_frd(rt, a);
     tcg_temp_free_i64(a);
-    return nullify_end(ctx, NO_EXIT);
+    return nullify_end(ctx, DISAS_NEXT);
 }
 
 /* Emit an unconditional branch to a direct target, which may or may not
    have already had nullification handled.  */
-static ExitStatus do_dbranch(DisasContext *ctx, target_ulong dest,
-                             unsigned link, bool is_n)
+static DisasJumpType do_dbranch(DisasContext *ctx, target_ulong dest,
+                                unsigned link, bool is_n)
 {
     if (ctx->null_cond.c == TCG_COND_NEVER && ctx->null_lab == NULL) {
         if (link != 0) {
@@ -1401,7 +1390,7 @@ static ExitStatus do_dbranch(DisasContext *ctx, target_ulong dest,
         if (is_n) {
             ctx->null_cond.c = TCG_COND_ALWAYS;
         }
-        return NO_EXIT;
+        return DISAS_NEXT;
     } else {
         nullify_over(ctx);
 
@@ -1417,18 +1406,18 @@ static ExitStatus do_dbranch(DisasContext *ctx, target_ulong dest,
             gen_goto_tb(ctx, 0, ctx->iaoq_b, dest);
         }
 
-        nullify_end(ctx, NO_EXIT);
+        nullify_end(ctx, DISAS_NEXT);
 
         nullify_set(ctx, 0);
         gen_goto_tb(ctx, 1, ctx->iaoq_b, ctx->iaoq_n);
-        return EXIT_GOTO_TB;
+        return DISAS_NORETURN;
     }
 }
 
 /* Emit a conditional branch to a direct target.  If the branch itself
    is nullified, we should have already used nullify_over.  */
-static ExitStatus do_cbranch(DisasContext *ctx, target_long disp, bool is_n,
-                             DisasCond *cond)
+static DisasJumpType do_cbranch(DisasContext *ctx, target_long disp, bool is_n,
+                                DisasCond *cond)
 {
     target_ulong dest = iaoq_dest(ctx, disp);
     TCGLabel *taken = NULL;
@@ -1480,16 +1469,16 @@ static ExitStatus do_cbranch(DisasContext *ctx, target_long disp, bool is_n,
     if (ctx->null_lab) {
         gen_set_label(ctx->null_lab);
         ctx->null_lab = NULL;
-        return EXIT_IAQ_N_STALE;
+        return DISAS_IAQ_N_STALE;
     } else {
-        return EXIT_GOTO_TB;
+        return DISAS_NORETURN;
     }
 }
 
 /* Emit an unconditional branch to an indirect target.  This handles
    nullification of the branch itself.  */
-static ExitStatus do_ibranch(DisasContext *ctx, TCGv dest,
-                             unsigned link, bool is_n)
+static DisasJumpType do_ibranch(DisasContext *ctx, TCGv dest,
+                                unsigned link, bool is_n)
 {
     TCGv a0, a1, next, tmp;
     TCGCond c;
@@ -1528,7 +1517,7 @@ static ExitStatus do_ibranch(DisasContext *ctx, TCGv dest,
             tcg_gen_movi_tl(cpu_gr[link], ctx->iaoq_n);
         }
         tcg_gen_lookup_and_goto_ptr(cpu_iaoq_f);
-        return nullify_end(ctx, NO_EXIT);
+        return nullify_end(ctx, DISAS_NEXT);
     } else {
         cond_prep(&ctx->null_cond);
         c = ctx->null_cond.c;
@@ -1560,7 +1549,7 @@ static ExitStatus do_ibranch(DisasContext *ctx, TCGv dest,
         }
     }
 
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
 /* On Linux, page zero is normally marked execute only + gateway.
@@ -1570,7 +1559,7 @@ static ExitStatus do_ibranch(DisasContext *ctx, TCGv dest,
    in than the "be disp(sr2,r0)" instruction that probably sent us
    here, is the easiest way to handle the branch delay slot on the
    aforementioned BE.  */
-static ExitStatus do_page_zero(DisasContext *ctx)
+static DisasJumpType do_page_zero(DisasContext *ctx)
 {
     /* If by some means we get here with PSW[N]=1, that implies that
        the B,GATE instruction would be skipped, and we'd fault on the
@@ -1598,55 +1587,55 @@ static ExitStatus do_page_zero(DisasContext *ctx)
     switch (ctx->iaoq_f) {
     case 0x00: /* Null pointer call */
         gen_excp_1(EXCP_SIGSEGV);
-        return EXIT_NORETURN;
+        return DISAS_NORETURN;
 
     case 0xb0: /* LWS */
         gen_excp_1(EXCP_SYSCALL_LWS);
-        return EXIT_NORETURN;
+        return DISAS_NORETURN;
 
     case 0xe0: /* SET_THREAD_POINTER */
         tcg_gen_mov_tl(cpu_cr27, cpu_gr[26]);
         tcg_gen_mov_tl(cpu_iaoq_f, cpu_gr[31]);
         tcg_gen_addi_tl(cpu_iaoq_b, cpu_iaoq_f, 4);
-        return EXIT_IAQ_N_UPDATED;
+        return DISAS_IAQ_N_UPDATED;
 
     case 0x100: /* SYSCALL */
         gen_excp_1(EXCP_SYSCALL);
-        return EXIT_NORETURN;
+        return DISAS_NORETURN;
 
     default:
     do_sigill:
         gen_excp_1(EXCP_SIGILL);
-        return EXIT_NORETURN;
+        return DISAS_NORETURN;
     }
 }
 
-static ExitStatus trans_nop(DisasContext *ctx, uint32_t insn,
-                            const DisasInsn *di)
+static DisasJumpType trans_nop(DisasContext *ctx, uint32_t insn,
+                               const DisasInsn *di)
 {
     cond_free(&ctx->null_cond);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus trans_break(DisasContext *ctx, uint32_t insn,
-                              const DisasInsn *di)
+static DisasJumpType trans_break(DisasContext *ctx, uint32_t insn,
+                                 const DisasInsn *di)
 {
     nullify_over(ctx);
     return nullify_end(ctx, gen_excp(ctx, EXCP_DEBUG));
 }
 
-static ExitStatus trans_sync(DisasContext *ctx, uint32_t insn,
-                             const DisasInsn *di)
+static DisasJumpType trans_sync(DisasContext *ctx, uint32_t insn,
+                                const DisasInsn *di)
 {
     /* No point in nullifying the memory barrier.  */
     tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
 
     cond_free(&ctx->null_cond);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus trans_mfia(DisasContext *ctx, uint32_t insn,
-                             const DisasInsn *di)
+static DisasJumpType trans_mfia(DisasContext *ctx, uint32_t insn,
+                                const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     TCGv tmp = dest_gpr(ctx, rt);
@@ -1654,11 +1643,11 @@ static ExitStatus trans_mfia(DisasContext *ctx, uint32_t insn,
     save_gpr(ctx, rt, tmp);
 
     cond_free(&ctx->null_cond);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus trans_mfsp(DisasContext *ctx, uint32_t insn,
-                             const DisasInsn *di)
+static DisasJumpType trans_mfsp(DisasContext *ctx, uint32_t insn,
+                                const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     TCGv tmp = dest_gpr(ctx, rt);
@@ -1668,11 +1657,11 @@ static ExitStatus trans_mfsp(DisasContext *ctx, uint32_t insn,
     save_gpr(ctx, rt, tmp);
 
     cond_free(&ctx->null_cond);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus trans_mfctl(DisasContext *ctx, uint32_t insn,
-                              const DisasInsn *di)
+static DisasJumpType trans_mfctl(DisasContext *ctx, uint32_t insn,
+                                 const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned ctl = extract32(insn, 21, 5);
@@ -1708,11 +1697,11 @@ static ExitStatus trans_mfctl(DisasContext *ctx, uint32_t insn,
     }
 
     cond_free(&ctx->null_cond);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus trans_mtctl(DisasContext *ctx, uint32_t insn,
-                              const DisasInsn *di)
+static DisasJumpType trans_mtctl(DisasContext *ctx, uint32_t insn,
+                                 const DisasInsn *di)
 {
     unsigned rin = extract32(insn, 16, 5);
     unsigned ctl = extract32(insn, 21, 5);
@@ -1729,11 +1718,11 @@ static ExitStatus trans_mtctl(DisasContext *ctx, uint32_t insn,
     }
 
     cond_free(&ctx->null_cond);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus trans_mtsarcm(DisasContext *ctx, uint32_t insn,
-                                const DisasInsn *di)
+static DisasJumpType trans_mtsarcm(DisasContext *ctx, uint32_t insn,
+                                   const DisasInsn *di)
 {
     unsigned rin = extract32(insn, 16, 5);
     TCGv tmp = tcg_temp_new();
@@ -1744,11 +1733,11 @@ static ExitStatus trans_mtsarcm(DisasContext *ctx, uint32_t insn,
     tcg_temp_free(tmp);
 
     cond_free(&ctx->null_cond);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus trans_ldsid(DisasContext *ctx, uint32_t insn,
-                              const DisasInsn *di)
+static DisasJumpType trans_ldsid(DisasContext *ctx, uint32_t insn,
+                                 const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     TCGv dest = dest_gpr(ctx, rt);
@@ -1758,7 +1747,7 @@ static ExitStatus trans_ldsid(DisasContext *ctx, uint32_t insn,
     save_gpr(ctx, rt, dest);
 
     cond_free(&ctx->null_cond);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
 static const DisasInsn table_system[] = {
@@ -1774,8 +1763,8 @@ static const DisasInsn table_system[] = {
     { 0x000010a0u, 0xfc1f3fe0u, trans_ldsid },
 };
 
-static ExitStatus trans_base_idx_mod(DisasContext *ctx, uint32_t insn,
-                                     const DisasInsn *di)
+static DisasJumpType trans_base_idx_mod(DisasContext *ctx, uint32_t insn,
+                                        const DisasInsn *di)
 {
     unsigned rb = extract32(insn, 21, 5);
     unsigned rx = extract32(insn, 16, 5);
@@ -1788,11 +1777,11 @@ static ExitStatus trans_base_idx_mod(DisasContext *ctx, uint32_t insn,
     save_gpr(ctx, rb, dest);
 
     cond_free(&ctx->null_cond);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus trans_probe(DisasContext *ctx, uint32_t insn,
-                              const DisasInsn *di)
+static DisasJumpType trans_probe(DisasContext *ctx, uint32_t insn,
+                                 const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned rb = extract32(insn, 21, 5);
@@ -1809,7 +1798,7 @@ static ExitStatus trans_probe(DisasContext *ctx, uint32_t insn,
         gen_helper_probe_r(dest, load_gpr(ctx, rb));
     }
     save_gpr(ctx, rt, dest);
-    return nullify_end(ctx, NO_EXIT);
+    return nullify_end(ctx, DISAS_NEXT);
 }
 
 static const DisasInsn table_mem_mgmt[] = {
@@ -1830,8 +1819,8 @@ static const DisasInsn table_mem_mgmt[] = {
     { 0x04003180u, 0xfc003fa0u, trans_probe },        /* probei */
 };
 
-static ExitStatus trans_add(DisasContext *ctx, uint32_t insn,
-                            const DisasInsn *di)
+static DisasJumpType trans_add(DisasContext *ctx, uint32_t insn,
+                               const DisasInsn *di)
 {
     unsigned r2 = extract32(insn, 21, 5);
     unsigned r1 = extract32(insn, 16, 5);
@@ -1844,7 +1833,7 @@ static ExitStatus trans_add(DisasContext *ctx, uint32_t insn,
     bool is_l = false;
     bool is_tc = false;
     bool is_tsv = false;
-    ExitStatus ret;
+    DisasJumpType ret;
 
     switch (ext) {
     case 0x6: /* ADD, SHLADD */
@@ -1874,8 +1863,8 @@ static ExitStatus trans_add(DisasContext *ctx, uint32_t insn,
     return nullify_end(ctx, ret);
 }
 
-static ExitStatus trans_sub(DisasContext *ctx, uint32_t insn,
-                            const DisasInsn *di)
+static DisasJumpType trans_sub(DisasContext *ctx, uint32_t insn,
+                               const DisasInsn *di)
 {
     unsigned r2 = extract32(insn, 21, 5);
     unsigned r1 = extract32(insn, 16, 5);
@@ -1886,7 +1875,7 @@ static ExitStatus trans_sub(DisasContext *ctx, uint32_t insn,
     bool is_b = false;
     bool is_tc = false;
     bool is_tsv = false;
-    ExitStatus ret;
+    DisasJumpType ret;
 
     switch (ext) {
     case 0x10: /* SUB */
@@ -1919,15 +1908,15 @@ static ExitStatus trans_sub(DisasContext *ctx, uint32_t insn,
     return nullify_end(ctx, ret);
 }
 
-static ExitStatus trans_log(DisasContext *ctx, uint32_t insn,
-                            const DisasInsn *di)
+static DisasJumpType trans_log(DisasContext *ctx, uint32_t insn,
+                               const DisasInsn *di)
 {
     unsigned r2 = extract32(insn, 21, 5);
     unsigned r1 = extract32(insn, 16, 5);
     unsigned cf = extract32(insn, 12, 4);
     unsigned rt = extract32(insn,  0, 5);
     TCGv tcg_r1, tcg_r2;
-    ExitStatus ret;
+    DisasJumpType ret;
 
     if (cf) {
         nullify_over(ctx);
@@ -1939,8 +1928,8 @@ static ExitStatus trans_log(DisasContext *ctx, uint32_t insn,
 }
 
 /* OR r,0,t -> COPY (according to gas) */
-static ExitStatus trans_copy(DisasContext *ctx, uint32_t insn,
-                             const DisasInsn *di)
+static DisasJumpType trans_copy(DisasContext *ctx, uint32_t insn,
+                                const DisasInsn *di)
 {
     unsigned r1 = extract32(insn, 16, 5);
     unsigned rt = extract32(insn,  0, 5);
@@ -1953,18 +1942,18 @@ static ExitStatus trans_copy(DisasContext *ctx, uint32_t insn,
         save_gpr(ctx, rt, cpu_gr[r1]);
     }
     cond_free(&ctx->null_cond);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus trans_cmpclr(DisasContext *ctx, uint32_t insn,
-                               const DisasInsn *di)
+static DisasJumpType trans_cmpclr(DisasContext *ctx, uint32_t insn,
+                                  const DisasInsn *di)
 {
     unsigned r2 = extract32(insn, 21, 5);
     unsigned r1 = extract32(insn, 16, 5);
     unsigned cf = extract32(insn, 12, 4);
     unsigned rt = extract32(insn,  0, 5);
     TCGv tcg_r1, tcg_r2;
-    ExitStatus ret;
+    DisasJumpType ret;
 
     if (cf) {
         nullify_over(ctx);
@@ -1975,15 +1964,15 @@ static ExitStatus trans_cmpclr(DisasContext *ctx, uint32_t insn,
     return nullify_end(ctx, ret);
 }
 
-static ExitStatus trans_uxor(DisasContext *ctx, uint32_t insn,
-                             const DisasInsn *di)
+static DisasJumpType trans_uxor(DisasContext *ctx, uint32_t insn,
+                                const DisasInsn *di)
 {
     unsigned r2 = extract32(insn, 21, 5);
     unsigned r1 = extract32(insn, 16, 5);
     unsigned cf = extract32(insn, 12, 4);
     unsigned rt = extract32(insn,  0, 5);
     TCGv tcg_r1, tcg_r2;
-    ExitStatus ret;
+    DisasJumpType ret;
 
     if (cf) {
         nullify_over(ctx);
@@ -1994,8 +1983,8 @@ static ExitStatus trans_uxor(DisasContext *ctx, uint32_t insn,
     return nullify_end(ctx, ret);
 }
 
-static ExitStatus trans_uaddcm(DisasContext *ctx, uint32_t insn,
-                               const DisasInsn *di)
+static DisasJumpType trans_uaddcm(DisasContext *ctx, uint32_t insn,
+                                  const DisasInsn *di)
 {
     unsigned r2 = extract32(insn, 21, 5);
     unsigned r1 = extract32(insn, 16, 5);
@@ -2003,7 +1992,7 @@ static ExitStatus trans_uaddcm(DisasContext *ctx, uint32_t insn,
     unsigned is_tc = extract32(insn, 6, 1);
     unsigned rt = extract32(insn,  0, 5);
     TCGv tcg_r1, tcg_r2, tmp;
-    ExitStatus ret;
+    DisasJumpType ret;
 
     if (cf) {
         nullify_over(ctx);
@@ -2016,15 +2005,15 @@ static ExitStatus trans_uaddcm(DisasContext *ctx, uint32_t insn,
     return nullify_end(ctx, ret);
 }
 
-static ExitStatus trans_dcor(DisasContext *ctx, uint32_t insn,
-                             const DisasInsn *di)
+static DisasJumpType trans_dcor(DisasContext *ctx, uint32_t insn,
+                                const DisasInsn *di)
 {
     unsigned r2 = extract32(insn, 21, 5);
     unsigned cf = extract32(insn, 12, 4);
     unsigned is_i = extract32(insn, 6, 1);
     unsigned rt = extract32(insn,  0, 5);
     TCGv tmp;
-    ExitStatus ret;
+    DisasJumpType ret;
 
     nullify_over(ctx);
 
@@ -2041,8 +2030,8 @@ static ExitStatus trans_dcor(DisasContext *ctx, uint32_t insn,
     return nullify_end(ctx, ret);
 }
 
-static ExitStatus trans_ds(DisasContext *ctx, uint32_t insn,
-                           const DisasInsn *di)
+static DisasJumpType trans_ds(DisasContext *ctx, uint32_t insn,
+                              const DisasInsn *di)
 {
     unsigned r2 = extract32(insn, 21, 5);
     unsigned r1 = extract32(insn, 16, 5);
@@ -2105,7 +2094,7 @@ static ExitStatus trans_ds(DisasContext *ctx, uint32_t insn,
     tcg_temp_free(add2);
     tcg_temp_free(dest);
 
-    return nullify_end(ctx, NO_EXIT);
+    return nullify_end(ctx, DISAS_NEXT);
 }
 
 static const DisasInsn table_arith_log[] = {
@@ -2126,7 +2115,7 @@ static const DisasInsn table_arith_log[] = {
     { 0x08000200u, 0xfc000320u, trans_add }, /* shladd */
 };
 
-static ExitStatus trans_addi(DisasContext *ctx, uint32_t insn)
+static DisasJumpType trans_addi(DisasContext *ctx, uint32_t insn)
 {
     target_long im = low_sextract(insn, 0, 11);
     unsigned e1 = extract32(insn, 11, 1);
@@ -2135,7 +2124,7 @@ static ExitStatus trans_addi(DisasContext *ctx, uint32_t insn)
     unsigned r2 = extract32(insn, 21, 5);
     unsigned o1 = extract32(insn, 26, 1);
     TCGv tcg_im, tcg_r2;
-    ExitStatus ret;
+    DisasJumpType ret;
 
     if (cf) {
         nullify_over(ctx);
@@ -2148,7 +2137,7 @@ static ExitStatus trans_addi(DisasContext *ctx, uint32_t insn)
     return nullify_end(ctx, ret);
 }
 
-static ExitStatus trans_subi(DisasContext *ctx, uint32_t insn)
+static DisasJumpType trans_subi(DisasContext *ctx, uint32_t insn)
 {
     target_long im = low_sextract(insn, 0, 11);
     unsigned e1 = extract32(insn, 11, 1);
@@ -2156,7 +2145,7 @@ static ExitStatus trans_subi(DisasContext *ctx, uint32_t insn)
     unsigned rt = extract32(insn, 16, 5);
     unsigned r2 = extract32(insn, 21, 5);
     TCGv tcg_im, tcg_r2;
-    ExitStatus ret;
+    DisasJumpType ret;
 
     if (cf) {
         nullify_over(ctx);
@@ -2169,14 +2158,14 @@ static ExitStatus trans_subi(DisasContext *ctx, uint32_t insn)
     return nullify_end(ctx, ret);
 }
 
-static ExitStatus trans_cmpiclr(DisasContext *ctx, uint32_t insn)
+static DisasJumpType trans_cmpiclr(DisasContext *ctx, uint32_t insn)
 {
     target_long im = low_sextract(insn, 0, 11);
     unsigned cf = extract32(insn, 12, 4);
     unsigned rt = extract32(insn, 16, 5);
     unsigned r2 = extract32(insn, 21, 5);
     TCGv tcg_im, tcg_r2;
-    ExitStatus ret;
+    DisasJumpType ret;
 
     if (cf) {
         nullify_over(ctx);
@@ -2189,8 +2178,8 @@ static ExitStatus trans_cmpiclr(DisasContext *ctx, uint32_t insn)
     return nullify_end(ctx, ret);
 }
 
-static ExitStatus trans_ld_idx_i(DisasContext *ctx, uint32_t insn,
-                                 const DisasInsn *di)
+static DisasJumpType trans_ld_idx_i(DisasContext *ctx, uint32_t insn,
+                                    const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned m = extract32(insn, 5, 1);
@@ -2204,8 +2193,8 @@ static ExitStatus trans_ld_idx_i(DisasContext *ctx, uint32_t insn,
     return do_load(ctx, rt, rb, 0, 0, disp, modify, mop);
 }
 
-static ExitStatus trans_ld_idx_x(DisasContext *ctx, uint32_t insn,
-                                 const DisasInsn *di)
+static DisasJumpType trans_ld_idx_x(DisasContext *ctx, uint32_t insn,
+                                    const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned m = extract32(insn, 5, 1);
@@ -2218,8 +2207,8 @@ static ExitStatus trans_ld_idx_x(DisasContext *ctx, uint32_t insn,
     return do_load(ctx, rt, rb, rx, u ? sz : 0, 0, m, mop);
 }
 
-static ExitStatus trans_st_idx_i(DisasContext *ctx, uint32_t insn,
-                                 const DisasInsn *di)
+static DisasJumpType trans_st_idx_i(DisasContext *ctx, uint32_t insn,
+                                    const DisasInsn *di)
 {
     int disp = low_sextract(insn, 0, 5);
     unsigned m = extract32(insn, 5, 1);
@@ -2233,8 +2222,8 @@ static ExitStatus trans_st_idx_i(DisasContext *ctx, uint32_t insn,
     return do_store(ctx, rr, rb, disp, modify, mop);
 }
 
-static ExitStatus trans_ldcw(DisasContext *ctx, uint32_t insn,
-                             const DisasInsn *di)
+static DisasJumpType trans_ldcw(DisasContext *ctx, uint32_t insn,
+                                const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned m = extract32(insn, 5, 1);
@@ -2285,11 +2274,11 @@ static ExitStatus trans_ldcw(DisasContext *ctx, uint32_t insn,
     }
     save_gpr(ctx, rt, dest);
 
-    return nullify_end(ctx, NO_EXIT);
+    return nullify_end(ctx, DISAS_NEXT);
 }
 
-static ExitStatus trans_stby(DisasContext *ctx, uint32_t insn,
-                             const DisasInsn *di)
+static DisasJumpType trans_stby(DisasContext *ctx, uint32_t insn,
+                                const DisasInsn *di)
 {
     target_long disp = low_sextract(insn, 0, 5);
     unsigned m = extract32(insn, 5, 1);
@@ -2321,7 +2310,7 @@ static ExitStatus trans_stby(DisasContext *ctx, uint32_t insn,
     }
     tcg_temp_free(addr);
 
-    return nullify_end(ctx, NO_EXIT);
+    return nullify_end(ctx, DISAS_NEXT);
 }
 
 static const DisasInsn table_index_mem[] = {
@@ -2332,7 +2321,7 @@ static const DisasInsn table_index_mem[] = {
     { 0x0c001300u, 0xfc0013c0, trans_stby },
 };
 
-static ExitStatus trans_ldil(DisasContext *ctx, uint32_t insn)
+static DisasJumpType trans_ldil(DisasContext *ctx, uint32_t insn)
 {
     unsigned rt = extract32(insn, 21, 5);
     target_long i = assemble_21(insn);
@@ -2342,10 +2331,10 @@ static ExitStatus trans_ldil(DisasContext *ctx, uint32_t insn)
     save_gpr(ctx, rt, tcg_rt);
     cond_free(&ctx->null_cond);
 
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus trans_addil(DisasContext *ctx, uint32_t insn)
+static DisasJumpType trans_addil(DisasContext *ctx, uint32_t insn)
 {
     unsigned rt = extract32(insn, 21, 5);
     target_long i = assemble_21(insn);
@@ -2356,10 +2345,10 @@ static ExitStatus trans_addil(DisasContext *ctx, uint32_t insn)
     save_gpr(ctx, 1, tcg_r1);
     cond_free(&ctx->null_cond);
 
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus trans_ldo(DisasContext *ctx, uint32_t insn)
+static DisasJumpType trans_ldo(DisasContext *ctx, uint32_t insn)
 {
     unsigned rb = extract32(insn, 21, 5);
     unsigned rt = extract32(insn, 16, 5);
@@ -2376,11 +2365,11 @@ static ExitStatus trans_ldo(DisasContext *ctx, uint32_t insn)
     save_gpr(ctx, rt, tcg_rt);
     cond_free(&ctx->null_cond);
 
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus trans_load(DisasContext *ctx, uint32_t insn,
-                             bool is_mod, TCGMemOp mop)
+static DisasJumpType trans_load(DisasContext *ctx, uint32_t insn,
+                                bool is_mod, TCGMemOp mop)
 {
     unsigned rb = extract32(insn, 21, 5);
     unsigned rt = extract32(insn, 16, 5);
@@ -2389,7 +2378,7 @@ static ExitStatus trans_load(DisasContext *ctx, uint32_t insn,
     return do_load(ctx, rt, rb, 0, 0, i, is_mod ? (i < 0 ? -1 : 1) : 0, mop);
 }
 
-static ExitStatus trans_load_w(DisasContext *ctx, uint32_t insn)
+static DisasJumpType trans_load_w(DisasContext *ctx, uint32_t insn)
 {
     unsigned rb = extract32(insn, 21, 5);
     unsigned rt = extract32(insn, 16, 5);
@@ -2410,7 +2399,7 @@ static ExitStatus trans_load_w(DisasContext *ctx, uint32_t insn)
     }
 }
 
-static ExitStatus trans_fload_mod(DisasContext *ctx, uint32_t insn)
+static DisasJumpType trans_fload_mod(DisasContext *ctx, uint32_t insn)
 {
     target_long i = assemble_16a(insn);
     unsigned t1 = extract32(insn, 1, 1);
@@ -2422,8 +2411,8 @@ static ExitStatus trans_fload_mod(DisasContext *ctx, uint32_t insn)
     return do_floadw(ctx, t1 * 32 + t0, rb, 0, 0, i, (a ? -1 : 1));
 }
 
-static ExitStatus trans_store(DisasContext *ctx, uint32_t insn,
-                              bool is_mod, TCGMemOp mop)
+static DisasJumpType trans_store(DisasContext *ctx, uint32_t insn,
+                                 bool is_mod, TCGMemOp mop)
 {
     unsigned rb = extract32(insn, 21, 5);
     unsigned rt = extract32(insn, 16, 5);
@@ -2432,7 +2421,7 @@ static ExitStatus trans_store(DisasContext *ctx, uint32_t insn,
     return do_store(ctx, rt, rb, i, is_mod ? (i < 0 ? -1 : 1) : 0, mop);
 }
 
-static ExitStatus trans_store_w(DisasContext *ctx, uint32_t insn)
+static DisasJumpType trans_store_w(DisasContext *ctx, uint32_t insn)
 {
     unsigned rb = extract32(insn, 21, 5);
     unsigned rt = extract32(insn, 16, 5);
@@ -2452,7 +2441,7 @@ static ExitStatus trans_store_w(DisasContext *ctx, uint32_t insn)
     }
 }
 
-static ExitStatus trans_fstore_mod(DisasContext *ctx, uint32_t insn)
+static DisasJumpType trans_fstore_mod(DisasContext *ctx, uint32_t insn)
 {
     target_long i = assemble_16a(insn);
     unsigned t1 = extract32(insn, 1, 1);
@@ -2464,7 +2453,7 @@ static ExitStatus trans_fstore_mod(DisasContext *ctx, uint32_t insn)
     return do_fstorew(ctx, t1 * 32 + t0, rb, 0, 0, i, (a ? -1 : 1));
 }
 
-static ExitStatus trans_copr_w(DisasContext *ctx, uint32_t insn)
+static DisasJumpType trans_copr_w(DisasContext *ctx, uint32_t insn)
 {
     unsigned t0 = extract32(insn, 0, 5);
     unsigned m = extract32(insn, 5, 1);
@@ -2499,7 +2488,7 @@ static ExitStatus trans_copr_w(DisasContext *ctx, uint32_t insn)
     return gen_illegal(ctx);
 }
 
-static ExitStatus trans_copr_dw(DisasContext *ctx, uint32_t insn)
+static DisasJumpType trans_copr_dw(DisasContext *ctx, uint32_t insn)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned m = extract32(insn, 5, 1);
@@ -2533,8 +2522,8 @@ static ExitStatus trans_copr_dw(DisasContext *ctx, uint32_t insn)
     }
 }
 
-static ExitStatus trans_cmpb(DisasContext *ctx, uint32_t insn,
-                             bool is_true, bool is_imm, bool is_dw)
+static DisasJumpType trans_cmpb(DisasContext *ctx, uint32_t insn,
+                                bool is_true, bool is_imm, bool is_dw)
 {
     target_long disp = assemble_12(insn) * 4;
     unsigned n = extract32(insn, 1, 1);
@@ -2565,8 +2554,8 @@ static ExitStatus trans_cmpb(DisasContext *ctx, uint32_t insn,
     return do_cbranch(ctx, disp, n, &cond);
 }
 
-static ExitStatus trans_addb(DisasContext *ctx, uint32_t insn,
-                             bool is_true, bool is_imm)
+static DisasJumpType trans_addb(DisasContext *ctx, uint32_t insn,
+                                bool is_true, bool is_imm)
 {
     target_long disp = assemble_12(insn) * 4;
     unsigned n = extract32(insn, 1, 1);
@@ -2607,7 +2596,7 @@ static ExitStatus trans_addb(DisasContext *ctx, uint32_t insn,
     return do_cbranch(ctx, disp, n, &cond);
 }
 
-static ExitStatus trans_bb(DisasContext *ctx, uint32_t insn)
+static DisasJumpType trans_bb(DisasContext *ctx, uint32_t insn)
 {
     target_long disp = assemble_12(insn) * 4;
     unsigned n = extract32(insn, 1, 1);
@@ -2633,7 +2622,7 @@ static ExitStatus trans_bb(DisasContext *ctx, uint32_t insn)
     return do_cbranch(ctx, disp, n, &cond);
 }
 
-static ExitStatus trans_movb(DisasContext *ctx, uint32_t insn, bool is_imm)
+static DisasJumpType trans_movb(DisasContext *ctx, uint32_t insn, bool is_imm)
 {
     target_long disp = assemble_12(insn) * 4;
     unsigned n = extract32(insn, 1, 1);
@@ -2658,8 +2647,8 @@ static ExitStatus trans_movb(DisasContext *ctx, uint32_t insn, bool is_imm)
     return do_cbranch(ctx, disp, n, &cond);
 }
 
-static ExitStatus trans_shrpw_sar(DisasContext *ctx, uint32_t insn,
-                                 const DisasInsn *di)
+static DisasJumpType trans_shrpw_sar(DisasContext *ctx, uint32_t insn,
+                                    const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned c = extract32(insn, 13, 3);
@@ -2700,11 +2689,11 @@ static ExitStatus trans_shrpw_sar(DisasContext *ctx, uint32_t insn,
     if (c) {
         ctx->null_cond = do_sed_cond(c, dest);
     }
-    return nullify_end(ctx, NO_EXIT);
+    return nullify_end(ctx, DISAS_NEXT);
 }
 
-static ExitStatus trans_shrpw_imm(DisasContext *ctx, uint32_t insn,
-                                  const DisasInsn *di)
+static DisasJumpType trans_shrpw_imm(DisasContext *ctx, uint32_t insn,
+                                     const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned cpos = extract32(insn, 5, 5);
@@ -2741,11 +2730,11 @@ static ExitStatus trans_shrpw_imm(DisasContext *ctx, uint32_t insn,
     if (c) {
         ctx->null_cond = do_sed_cond(c, dest);
     }
-    return nullify_end(ctx, NO_EXIT);
+    return nullify_end(ctx, DISAS_NEXT);
 }
 
-static ExitStatus trans_extrw_sar(DisasContext *ctx, uint32_t insn,
-                                  const DisasInsn *di)
+static DisasJumpType trans_extrw_sar(DisasContext *ctx, uint32_t insn,
+                                     const DisasInsn *di)
 {
     unsigned clen = extract32(insn, 0, 5);
     unsigned is_se = extract32(insn, 10, 1);
@@ -2780,11 +2769,11 @@ static ExitStatus trans_extrw_sar(DisasContext *ctx, uint32_t insn,
     if (c) {
         ctx->null_cond = do_sed_cond(c, dest);
     }
-    return nullify_end(ctx, NO_EXIT);
+    return nullify_end(ctx, DISAS_NEXT);
 }
 
-static ExitStatus trans_extrw_imm(DisasContext *ctx, uint32_t insn,
-                                  const DisasInsn *di)
+static DisasJumpType trans_extrw_imm(DisasContext *ctx, uint32_t insn,
+                                     const DisasInsn *di)
 {
     unsigned clen = extract32(insn, 0, 5);
     unsigned pos = extract32(insn, 5, 5);
@@ -2814,7 +2803,7 @@ static ExitStatus trans_extrw_imm(DisasContext *ctx, uint32_t insn,
     if (c) {
         ctx->null_cond = do_sed_cond(c, dest);
     }
-    return nullify_end(ctx, NO_EXIT);
+    return nullify_end(ctx, DISAS_NEXT);
 }
 
 static const DisasInsn table_sh_ex[] = {
@@ -2824,8 +2813,8 @@ static const DisasInsn table_sh_ex[] = {
     { 0xd0001800u, 0xfc001800u, trans_extrw_imm },
 };
 
-static ExitStatus trans_depw_imm_c(DisasContext *ctx, uint32_t insn,
-                                   const DisasInsn *di)
+static DisasJumpType trans_depw_imm_c(DisasContext *ctx, uint32_t insn,
+                                      const DisasInsn *di)
 {
     unsigned clen = extract32(insn, 0, 5);
     unsigned cpos = extract32(insn, 5, 5);
@@ -2865,11 +2854,11 @@ static ExitStatus trans_depw_imm_c(DisasContext *ctx, uint32_t insn,
     if (c) {
         ctx->null_cond = do_sed_cond(c, dest);
     }
-    return nullify_end(ctx, NO_EXIT);
+    return nullify_end(ctx, DISAS_NEXT);
 }
 
-static ExitStatus trans_depw_imm(DisasContext *ctx, uint32_t insn,
-                                 const DisasInsn *di)
+static DisasJumpType trans_depw_imm(DisasContext *ctx, uint32_t insn,
+                                    const DisasInsn *di)
 {
     unsigned clen = extract32(insn, 0, 5);
     unsigned cpos = extract32(insn, 5, 5);
@@ -2902,11 +2891,11 @@ static ExitStatus trans_depw_imm(DisasContext *ctx, uint32_t insn,
     if (c) {
         ctx->null_cond = do_sed_cond(c, dest);
     }
-    return nullify_end(ctx, NO_EXIT);
+    return nullify_end(ctx, DISAS_NEXT);
 }
 
-static ExitStatus trans_depw_sar(DisasContext *ctx, uint32_t insn,
-                                 const DisasInsn *di)
+static DisasJumpType trans_depw_sar(DisasContext *ctx, uint32_t insn,
+                                    const DisasInsn *di)
 {
     unsigned clen = extract32(insn, 0, 5);
     unsigned nz = extract32(insn, 10, 1);
@@ -2954,7 +2943,7 @@ static ExitStatus trans_depw_sar(DisasContext *ctx, uint32_t insn,
     if (c) {
         ctx->null_cond = do_sed_cond(c, dest);
     }
-    return nullify_end(ctx, NO_EXIT);
+    return nullify_end(ctx, DISAS_NEXT);
 }
 
 static const DisasInsn table_depw[] = {
@@ -2963,7 +2952,7 @@ static const DisasInsn table_depw[] = {
     { 0xd4001800u, 0xfc001800u, trans_depw_imm_c },
 };
 
-static ExitStatus trans_be(DisasContext *ctx, uint32_t insn, bool is_l)
+static DisasJumpType trans_be(DisasContext *ctx, uint32_t insn, bool is_l)
 {
     unsigned n = extract32(insn, 1, 1);
     unsigned b = extract32(insn, 21, 5);
@@ -2988,8 +2977,8 @@ static ExitStatus trans_be(DisasContext *ctx, uint32_t insn, bool is_l)
     }
 }
 
-static ExitStatus trans_bl(DisasContext *ctx, uint32_t insn,
-                           const DisasInsn *di)
+static DisasJumpType trans_bl(DisasContext *ctx, uint32_t insn,
+                              const DisasInsn *di)
 {
     unsigned n = extract32(insn, 1, 1);
     unsigned link = extract32(insn, 21, 5);
@@ -2998,8 +2987,8 @@ static ExitStatus trans_bl(DisasContext *ctx, uint32_t insn,
     return do_dbranch(ctx, iaoq_dest(ctx, disp), link, n);
 }
 
-static ExitStatus trans_bl_long(DisasContext *ctx, uint32_t insn,
-                                const DisasInsn *di)
+static DisasJumpType trans_bl_long(DisasContext *ctx, uint32_t insn,
+                                   const DisasInsn *di)
 {
     unsigned n = extract32(insn, 1, 1);
     target_long disp = assemble_22(insn);
@@ -3007,8 +2996,8 @@ static ExitStatus trans_bl_long(DisasContext *ctx, uint32_t insn,
     return do_dbranch(ctx, iaoq_dest(ctx, disp), 2, n);
 }
 
-static ExitStatus trans_blr(DisasContext *ctx, uint32_t insn,
-                            const DisasInsn *di)
+static DisasJumpType trans_blr(DisasContext *ctx, uint32_t insn,
+                               const DisasInsn *di)
 {
     unsigned n = extract32(insn, 1, 1);
     unsigned rx = extract32(insn, 16, 5);
@@ -3020,8 +3009,8 @@ static ExitStatus trans_blr(DisasContext *ctx, uint32_t insn,
     return do_ibranch(ctx, tmp, link, n);
 }
 
-static ExitStatus trans_bv(DisasContext *ctx, uint32_t insn,
-                           const DisasInsn *di)
+static DisasJumpType trans_bv(DisasContext *ctx, uint32_t insn,
+                              const DisasInsn *di)
 {
     unsigned n = extract32(insn, 1, 1);
     unsigned rx = extract32(insn, 16, 5);
@@ -3038,8 +3027,8 @@ static ExitStatus trans_bv(DisasContext *ctx, uint32_t insn,
     return do_ibranch(ctx, dest, 0, n);
 }
 
-static ExitStatus trans_bve(DisasContext *ctx, uint32_t insn,
-                            const DisasInsn *di)
+static DisasJumpType trans_bve(DisasContext *ctx, uint32_t insn,
+                               const DisasInsn *di)
 {
     unsigned n = extract32(insn, 1, 1);
     unsigned rb = extract32(insn, 21, 5);
@@ -3056,64 +3045,64 @@ static const DisasInsn table_branch[] = {
     { 0xe800d000u, 0xfc00dffcu, trans_bve },
 };
 
-static ExitStatus trans_fop_wew_0c(DisasContext *ctx, uint32_t insn,
-                                   const DisasInsn *di)
+static DisasJumpType trans_fop_wew_0c(DisasContext *ctx, uint32_t insn,
+                                      const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned ra = extract32(insn, 21, 5);
     return do_fop_wew(ctx, rt, ra, di->f.wew);
 }
 
-static ExitStatus trans_fop_wew_0e(DisasContext *ctx, uint32_t insn,
-                                   const DisasInsn *di)
+static DisasJumpType trans_fop_wew_0e(DisasContext *ctx, uint32_t insn,
+                                      const DisasInsn *di)
 {
     unsigned rt = assemble_rt64(insn);
     unsigned ra = assemble_ra64(insn);
     return do_fop_wew(ctx, rt, ra, di->f.wew);
 }
 
-static ExitStatus trans_fop_ded(DisasContext *ctx, uint32_t insn,
-                                const DisasInsn *di)
+static DisasJumpType trans_fop_ded(DisasContext *ctx, uint32_t insn,
+                                   const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned ra = extract32(insn, 21, 5);
     return do_fop_ded(ctx, rt, ra, di->f.ded);
 }
 
-static ExitStatus trans_fop_wed_0c(DisasContext *ctx, uint32_t insn,
-                                   const DisasInsn *di)
+static DisasJumpType trans_fop_wed_0c(DisasContext *ctx, uint32_t insn,
+                                      const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned ra = extract32(insn, 21, 5);
     return do_fop_wed(ctx, rt, ra, di->f.wed);
 }
 
-static ExitStatus trans_fop_wed_0e(DisasContext *ctx, uint32_t insn,
-                                   const DisasInsn *di)
+static DisasJumpType trans_fop_wed_0e(DisasContext *ctx, uint32_t insn,
+                                      const DisasInsn *di)
 {
     unsigned rt = assemble_rt64(insn);
     unsigned ra = extract32(insn, 21, 5);
     return do_fop_wed(ctx, rt, ra, di->f.wed);
 }
 
-static ExitStatus trans_fop_dew_0c(DisasContext *ctx, uint32_t insn,
-                                   const DisasInsn *di)
+static DisasJumpType trans_fop_dew_0c(DisasContext *ctx, uint32_t insn,
+                                      const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned ra = extract32(insn, 21, 5);
     return do_fop_dew(ctx, rt, ra, di->f.dew);
 }
 
-static ExitStatus trans_fop_dew_0e(DisasContext *ctx, uint32_t insn,
-                                   const DisasInsn *di)
+static DisasJumpType trans_fop_dew_0e(DisasContext *ctx, uint32_t insn,
+                                      const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned ra = assemble_ra64(insn);
     return do_fop_dew(ctx, rt, ra, di->f.dew);
 }
 
-static ExitStatus trans_fop_weww_0c(DisasContext *ctx, uint32_t insn,
-                                    const DisasInsn *di)
+static DisasJumpType trans_fop_weww_0c(DisasContext *ctx, uint32_t insn,
+                                       const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned rb = extract32(insn, 16, 5);
@@ -3121,8 +3110,8 @@ static ExitStatus trans_fop_weww_0c(DisasContext *ctx, uint32_t insn,
     return do_fop_weww(ctx, rt, ra, rb, di->f.weww);
 }
 
-static ExitStatus trans_fop_weww_0e(DisasContext *ctx, uint32_t insn,
-                                    const DisasInsn *di)
+static DisasJumpType trans_fop_weww_0e(DisasContext *ctx, uint32_t insn,
+                                       const DisasInsn *di)
 {
     unsigned rt = assemble_rt64(insn);
     unsigned rb = assemble_rb64(insn);
@@ -3130,8 +3119,8 @@ static ExitStatus trans_fop_weww_0e(DisasContext *ctx, uint32_t insn,
     return do_fop_weww(ctx, rt, ra, rb, di->f.weww);
 }
 
-static ExitStatus trans_fop_dedd(DisasContext *ctx, uint32_t insn,
-                                 const DisasInsn *di)
+static DisasJumpType trans_fop_dedd(DisasContext *ctx, uint32_t insn,
+                                    const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned rb = extract32(insn, 16, 5);
@@ -3179,8 +3168,8 @@ static void gen_fnegabs_d(TCGv_i64 dst, TCGv_env unused, TCGv_i64 src)
     tcg_gen_ori_i64(dst, src, INT64_MIN);
 }
 
-static ExitStatus do_fcmp_s(DisasContext *ctx, unsigned ra, unsigned rb,
-                            unsigned y, unsigned c)
+static DisasJumpType do_fcmp_s(DisasContext *ctx, unsigned ra, unsigned rb,
+                               unsigned y, unsigned c)
 {
     TCGv_i32 ta, tb, tc, ty;
 
@@ -3198,11 +3187,11 @@ static ExitStatus do_fcmp_s(DisasContext *ctx, unsigned ra, unsigned rb,
     tcg_temp_free_i32(ty);
     tcg_temp_free_i32(tc);
 
-    return nullify_end(ctx, NO_EXIT);
+    return nullify_end(ctx, DISAS_NEXT);
 }
 
-static ExitStatus trans_fcmp_s_0c(DisasContext *ctx, uint32_t insn,
-                                  const DisasInsn *di)
+static DisasJumpType trans_fcmp_s_0c(DisasContext *ctx, uint32_t insn,
+                                     const DisasInsn *di)
 {
     unsigned c = extract32(insn, 0, 5);
     unsigned y = extract32(insn, 13, 3);
@@ -3211,8 +3200,8 @@ static ExitStatus trans_fcmp_s_0c(DisasContext *ctx, uint32_t insn,
     return do_fcmp_s(ctx, ra, rb, y, c);
 }
 
-static ExitStatus trans_fcmp_s_0e(DisasContext *ctx, uint32_t insn,
-                                  const DisasInsn *di)
+static DisasJumpType trans_fcmp_s_0e(DisasContext *ctx, uint32_t insn,
+                                     const DisasInsn *di)
 {
     unsigned c = extract32(insn, 0, 5);
     unsigned y = extract32(insn, 13, 3);
@@ -3221,8 +3210,8 @@ static ExitStatus trans_fcmp_s_0e(DisasContext *ctx, uint32_t insn,
     return do_fcmp_s(ctx, ra, rb, y, c);
 }
 
-static ExitStatus trans_fcmp_d(DisasContext *ctx, uint32_t insn,
-                               const DisasInsn *di)
+static DisasJumpType trans_fcmp_d(DisasContext *ctx, uint32_t insn,
+                                  const DisasInsn *di)
 {
     unsigned c = extract32(insn, 0, 5);
     unsigned y = extract32(insn, 13, 3);
@@ -3245,11 +3234,11 @@ static ExitStatus trans_fcmp_d(DisasContext *ctx, uint32_t insn,
     tcg_temp_free_i32(ty);
     tcg_temp_free_i32(tc);
 
-    return nullify_end(ctx, NO_EXIT);
+    return nullify_end(ctx, DISAS_NEXT);
 }
 
-static ExitStatus trans_ftest_t(DisasContext *ctx, uint32_t insn,
-                                const DisasInsn *di)
+static DisasJumpType trans_ftest_t(DisasContext *ctx, uint32_t insn,
+                                   const DisasInsn *di)
 {
     unsigned y = extract32(insn, 13, 3);
     unsigned cbit = (y ^ 1) - 1;
@@ -3263,11 +3252,11 @@ static ExitStatus trans_ftest_t(DisasContext *ctx, uint32_t insn,
     ctx->null_cond = cond_make_0(TCG_COND_NE, t);
     tcg_temp_free(t);
 
-    return nullify_end(ctx, NO_EXIT);
+    return nullify_end(ctx, DISAS_NEXT);
 }
 
-static ExitStatus trans_ftest_q(DisasContext *ctx, uint32_t insn,
-                                const DisasInsn *di)
+static DisasJumpType trans_ftest_q(DisasContext *ctx, uint32_t insn,
+                                   const DisasInsn *di)
 {
     unsigned c = extract32(insn, 0, 5);
     int mask;
@@ -3317,11 +3306,11 @@ static ExitStatus trans_ftest_q(DisasContext *ctx, uint32_t insn,
         ctx->null_cond = cond_make_0(TCG_COND_EQ, t);
     }
  done:
-    return nullify_end(ctx, NO_EXIT);
+    return nullify_end(ctx, DISAS_NEXT);
 }
 
-static ExitStatus trans_xmpyu(DisasContext *ctx, uint32_t insn,
-                              const DisasInsn *di)
+static DisasJumpType trans_xmpyu(DisasContext *ctx, uint32_t insn,
+                                 const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned rb = assemble_rb64(insn);
@@ -3337,7 +3326,7 @@ static ExitStatus trans_xmpyu(DisasContext *ctx, uint32_t insn,
     tcg_temp_free_i64(a);
     tcg_temp_free_i64(b);
 
-    return nullify_end(ctx, NO_EXIT);
+    return nullify_end(ctx, DISAS_NEXT);
 }
 
 #define FOP_DED  trans_fop_ded, .f.ded
@@ -3512,7 +3501,8 @@ static inline int fmpyadd_s_reg(unsigned r)
     return (r & 16) * 2 + 16 + (r & 15);
 }
 
-static ExitStatus trans_fmpyadd(DisasContext *ctx, uint32_t insn, bool is_sub)
+static DisasJumpType trans_fmpyadd(DisasContext *ctx,
+                                   uint32_t insn, bool is_sub)
 {
     unsigned tm = extract32(insn, 0, 5);
     unsigned f = extract32(insn, 5, 1);
@@ -3540,11 +3530,11 @@ static ExitStatus trans_fmpyadd(DisasContext *ctx, uint32_t insn, bool is_sub)
                     is_sub ? gen_helper_fsub_d : gen_helper_fadd_d);
     }
 
-    return nullify_end(ctx, NO_EXIT);
+    return nullify_end(ctx, DISAS_NEXT);
 }
 
-static ExitStatus trans_fmpyfadd_s(DisasContext *ctx, uint32_t insn,
-                                   const DisasInsn *di)
+static DisasJumpType trans_fmpyfadd_s(DisasContext *ctx, uint32_t insn,
+                                      const DisasInsn *di)
 {
     unsigned rt = assemble_rt64(insn);
     unsigned neg = extract32(insn, 5, 1);
@@ -3568,11 +3558,11 @@ static ExitStatus trans_fmpyfadd_s(DisasContext *ctx, uint32_t insn,
     tcg_temp_free_i32(c);
     save_frw_i32(rt, a);
     tcg_temp_free_i32(a);
-    return nullify_end(ctx, NO_EXIT);
+    return nullify_end(ctx, DISAS_NEXT);
 }
 
-static ExitStatus trans_fmpyfadd_d(DisasContext *ctx, uint32_t insn,
-                                   const DisasInsn *di)
+static DisasJumpType trans_fmpyfadd_d(DisasContext *ctx, uint32_t insn,
+                                      const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned neg = extract32(insn, 5, 1);
@@ -3596,7 +3586,7 @@ static ExitStatus trans_fmpyfadd_d(DisasContext *ctx, uint32_t insn,
     tcg_temp_free_i64(c);
     save_frd(rt, a);
     tcg_temp_free_i64(a);
-    return nullify_end(ctx, NO_EXIT);
+    return nullify_end(ctx, DISAS_NEXT);
 }
 
 static const DisasInsn table_fp_fused[] = {
@@ -3604,8 +3594,8 @@ static const DisasInsn table_fp_fused[] = {
     { 0xb8000800u, 0xfc0019c0u, trans_fmpyfadd_d }
 };
 
-static ExitStatus translate_table_int(DisasContext *ctx, uint32_t insn,
-                                      const DisasInsn table[], size_t n)
+static DisasJumpType translate_table_int(DisasContext *ctx, uint32_t insn,
+                                         const DisasInsn table[], size_t n)
 {
     size_t i;
     for (i = 0; i < n; ++i) {
@@ -3619,7 +3609,7 @@ static ExitStatus translate_table_int(DisasContext *ctx, uint32_t insn,
 #define translate_table(ctx, insn, table) \
     translate_table_int(ctx, insn, table, ARRAY_SIZE(table))
 
-static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
+static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
 {
     uint32_t opc = extract32(insn, 26, 6);
 
@@ -3744,7 +3734,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 {
     CPUHPPAState *env = cs->env_ptr;
     DisasContext ctx;
-    ExitStatus ret;
+    DisasJumpType ret;
     int num_insns, max_insns, i;
 
     ctx.tb = tb;
@@ -3797,7 +3787,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 
         if (ctx.iaoq_f < TARGET_PAGE_SIZE) {
             ret = do_page_zero(&ctx);
-            assert(ret != NO_EXIT);
+            assert(ret != DISAS_NEXT);
         } else {
             /* Always fetch the insn, even if nullified, so that we check
                the page permissions for execute.  */
@@ -3816,7 +3806,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 
             if (unlikely(ctx.null_cond.c == TCG_COND_ALWAYS)) {
                 ctx.null_cond.c = TCG_COND_NEVER;
-                ret = NO_EXIT;
+                ret = DISAS_NEXT;
             } else {
                 ret = translate_one(&ctx, insn);
                 assert(ctx.null_lab == NULL);
@@ -3834,7 +3824,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         /* ??? The non-linear instruction restriction is purely due to
            the debugging dump.  Otherwise we *could* follow unconditional
            branches within the same page.  */
-        if (ret == NO_EXIT
+        if (ret == DISAS_NEXT
             && (ctx.iaoq_b != ctx.iaoq_f + 4
                 || num_insns >= max_insns
                 || tcg_op_buf_full())) {
@@ -3842,45 +3832,42 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
                 || ctx.null_cond.c == TCG_COND_ALWAYS) {
                 nullify_set(&ctx, ctx.null_cond.c == TCG_COND_ALWAYS);
                 gen_goto_tb(&ctx, 0, ctx.iaoq_b, ctx.iaoq_n);
-                ret = EXIT_GOTO_TB;
+                ret = DISAS_NORETURN;
             } else {
-                ret = EXIT_IAQ_N_STALE;
+                ret = DISAS_IAQ_N_STALE;
             }
         }
 
         ctx.iaoq_f = ctx.iaoq_b;
         ctx.iaoq_b = ctx.iaoq_n;
-        if (ret == EXIT_NORETURN
-            || ret == EXIT_GOTO_TB
-            || ret == EXIT_IAQ_N_UPDATED) {
+        if (ret == DISAS_NORETURN || ret == DISAS_IAQ_N_UPDATED) {
             break;
         }
         if (ctx.iaoq_f == -1) {
             tcg_gen_mov_tl(cpu_iaoq_f, cpu_iaoq_b);
             copy_iaoq_entry(cpu_iaoq_b, ctx.iaoq_n, ctx.iaoq_n_var);
             nullify_save(&ctx);
-            ret = EXIT_IAQ_N_UPDATED;
+            ret = DISAS_IAQ_N_UPDATED;
             break;
         }
         if (ctx.iaoq_b == -1) {
             tcg_gen_mov_tl(cpu_iaoq_b, ctx.iaoq_n_var);
         }
-    } while (ret == NO_EXIT);
+    } while (ret == DISAS_NEXT);
 
     if (tb->cflags & CF_LAST_IO) {
         gen_io_end();
     }
 
     switch (ret) {
-    case EXIT_GOTO_TB:
-    case EXIT_NORETURN:
+    case DISAS_NORETURN:
         break;
-    case EXIT_IAQ_N_STALE:
+    case DISAS_IAQ_N_STALE:
         copy_iaoq_entry(cpu_iaoq_f, ctx.iaoq_f, cpu_iaoq_f);
         copy_iaoq_entry(cpu_iaoq_b, ctx.iaoq_b, cpu_iaoq_b);
         nullify_save(&ctx);
         /* FALLTHRU */
-    case EXIT_IAQ_N_UPDATED:
+    case DISAS_IAQ_N_UPDATED:
         if (ctx.singlestep_enabled) {
             gen_excp_1(EXCP_DEBUG);
         } else {
-- 
2.13.5
