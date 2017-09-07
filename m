Received: from eggs.gnu.org ([2001:4830:134:3::10]:41791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq1P2-0003IT-LV
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq1Ox-0007ZJ-1G
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:19:48 -0400
Received: from mail-pg0-x229.google.com ([2607:f8b0:400e:c05::229]:37144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dq1Ow-0007Yk-PA
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:19:42 -0400
Received: by mail-pg0-x229.google.com with SMTP id d8so854103pgt.4
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 11:19:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Sep 2017 11:19:35 -0700
Message-Id: <20170907181938.3948-2-richard.henderson@linaro.org>
In-Reply-To: <20170907181938.3948-1-richard.henderson@linaro.org>
References: <20170907181938.3948-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 1/4] target/alpha: Convert to DisasJumpType
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
 target/alpha/translate.c | 132 ++++++++++++++++++++---------------------------
 1 file changed, 55 insertions(+), 77 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index f465752208..a75bf5dd90 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -25,11 +25,10 @@
 #include "exec/exec-all.h"
 #include "tcg-op.h"
 #include "exec/cpu_ldst.h"
-
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
-
 #include "trace-tcg.h"
+#include "exec/translator.h"
 #include "exec/log.h"
 
 
@@ -73,32 +72,12 @@ struct DisasContext {
     bool singlestep_enabled;
 };
 
-/* Return values from translate_one, indicating the state of the TB.
-   Note that zero indicates that we are not exiting the TB.  */
-
-typedef enum {
-    NO_EXIT,
-
-    /* We have emitted one or more goto_tb.  No fixup required.  */
-    EXIT_GOTO_TB,
-
-    /* We are not using a goto_tb (for whatever reason), but have updated
-       the PC (for whatever reason), so there's no need to do it again on
-       exiting the TB.  */
-    EXIT_PC_UPDATED,
-    EXIT_PC_UPDATED_NOCHAIN,
-
-    /* We are exiting the TB, but have neither emitted a goto_tb, nor
-       updated the PC for the next instruction to be executed.  */
-    EXIT_PC_STALE,
-
-    /* We are exiting the TB due to page crossing or space constraints.  */
-    EXIT_FALLTHRU,
-
-    /* We are ending the TB with a noreturn function call, e.g. longjmp.
-       No following code will be executed.  */
-    EXIT_NORETURN,
-} ExitStatus;
+/* Target-specific return values from translate_one, indicating the
+   state of the TB.  Note that DISAS_NEXT indicates that we are not
+   exiting the TB.  */
+#define DISAS_PC_UPDATED_NOCHAIN  DISAS_TARGET_0
+#define DISAS_PC_UPDATED          DISAS_TARGET_1
+#define DISAS_PC_STALE            DISAS_TARGET_2
 
 /* global register indexes */
 static TCGv_env cpu_env;
@@ -301,14 +280,14 @@ static void gen_excp_1(int exception, int error_code)
     tcg_temp_free_i32(tmp1);
 }
 
-static ExitStatus gen_excp(DisasContext *ctx, int exception, int error_code)
+static DisasJumpType gen_excp(DisasContext *ctx, int exception, int error_code)
 {
     tcg_gen_movi_i64(cpu_pc, ctx->pc);
     gen_excp_1(exception, error_code);
-    return EXIT_NORETURN;
+    return DISAS_NORETURN;
 }
 
-static inline ExitStatus gen_invalid(DisasContext *ctx)
+static inline DisasJumpType gen_invalid(DisasContext *ctx)
 {
     return gen_excp(ctx, EXCP_OPCDEC, 0);
 }
@@ -434,9 +413,9 @@ static inline void gen_store_mem(DisasContext *ctx,
     tcg_temp_free(tmp);
 }
 
-static ExitStatus gen_store_conditional(DisasContext *ctx, int ra, int rb,
-                                        int32_t disp16, int mem_idx,
-                                        TCGMemOp op)
+static DisasJumpType gen_store_conditional(DisasContext *ctx, int ra, int rb,
+                                           int32_t disp16, int mem_idx,
+                                           TCGMemOp op)
 {
     TCGLabel *lab_fail, *lab_done;
     TCGv addr, val;
@@ -468,7 +447,7 @@ static ExitStatus gen_store_conditional(DisasContext *ctx, int ra, int rb,
 
     gen_set_label(lab_done);
     tcg_gen_movi_i64(cpu_lock_addr, -1);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
 static bool in_superpage(DisasContext *ctx, int64_t addr)
@@ -507,7 +486,7 @@ static bool use_goto_tb(DisasContext *ctx, uint64_t dest)
 #endif
 }
 
-static ExitStatus gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
+static DisasJumpType gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
 {
     uint64_t dest = ctx->pc + (disp << 2);
 
@@ -522,15 +501,15 @@ static ExitStatus gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
         tcg_gen_goto_tb(0);
         tcg_gen_movi_i64(cpu_pc, dest);
         tcg_gen_exit_tb((uintptr_t)ctx->tb);
-        return EXIT_GOTO_TB;
+        return DISAS_NORETURN;
     } else {
         tcg_gen_movi_i64(cpu_pc, dest);
-        return EXIT_PC_UPDATED;
+        return DISAS_PC_UPDATED;
     }
 }
 
-static ExitStatus gen_bcond_internal(DisasContext *ctx, TCGCond cond,
-                                     TCGv cmp, int32_t disp)
+static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
+                                        TCGv cmp, int32_t disp)
 {
     uint64_t dest = ctx->pc + (disp << 2);
     TCGLabel *lab_true = gen_new_label();
@@ -547,7 +526,7 @@ static ExitStatus gen_bcond_internal(DisasContext *ctx, TCGCond cond,
         tcg_gen_movi_i64(cpu_pc, dest);
         tcg_gen_exit_tb((uintptr_t)ctx->tb + 1);
 
-        return EXIT_GOTO_TB;
+        return DISAS_NORETURN;
     } else {
         TCGv_i64 z = tcg_const_i64(0);
         TCGv_i64 d = tcg_const_i64(dest);
@@ -558,16 +537,16 @@ static ExitStatus gen_bcond_internal(DisasContext *ctx, TCGCond cond,
         tcg_temp_free_i64(z);
         tcg_temp_free_i64(d);
         tcg_temp_free_i64(p);
-        return EXIT_PC_UPDATED;
+        return DISAS_PC_UPDATED;
     }
 }
 
-static ExitStatus gen_bcond(DisasContext *ctx, TCGCond cond, int ra,
-                            int32_t disp, int mask)
+static DisasJumpType gen_bcond(DisasContext *ctx, TCGCond cond, int ra,
+                               int32_t disp, int mask)
 {
     if (mask) {
         TCGv tmp = tcg_temp_new();
-        ExitStatus ret;
+        DisasJumpType ret;
 
         tcg_gen_andi_i64(tmp, load_gpr(ctx, ra), 1);
         ret = gen_bcond_internal(ctx, cond, tmp, disp);
@@ -609,11 +588,11 @@ static void gen_fold_mzero(TCGCond cond, TCGv dest, TCGv src)
     }
 }
 
-static ExitStatus gen_fbcond(DisasContext *ctx, TCGCond cond, int ra,
-                             int32_t disp)
+static DisasJumpType gen_fbcond(DisasContext *ctx, TCGCond cond, int ra,
+                                int32_t disp)
 {
     TCGv cmp_tmp = tcg_temp_new();
-    ExitStatus ret;
+    DisasJumpType ret;
 
     gen_fold_mzero(cond, cmp_tmp, load_fpr(ctx, ra));
     ret = gen_bcond_internal(ctx, cond, cmp_tmp, disp);
@@ -1159,7 +1138,7 @@ static void gen_rx(DisasContext *ctx, int ra, int set)
     tcg_temp_free(tmp);
 }
 
-static ExitStatus gen_call_pal(DisasContext *ctx, int palcode)
+static DisasJumpType gen_call_pal(DisasContext *ctx, int palcode)
 {
     /* We're emulating OSF/1 PALcode.  Many of these are trivial access
        to internal cpu registers.  */
@@ -1185,7 +1164,7 @@ static ExitStatus gen_call_pal(DisasContext *ctx, int palcode)
             palcode &= 0xbf;
             goto do_call_pal;
         }
-        return NO_EXIT;
+        return DISAS_NEXT;
     }
 
 #ifndef CONFIG_USER_ONLY
@@ -1232,7 +1211,7 @@ static ExitStatus gen_call_pal(DisasContext *ctx, int palcode)
 
             /* Allow interrupts to be recognized right away.  */
             tcg_gen_movi_i64(cpu_pc, ctx->pc);
-            return EXIT_PC_UPDATED_NOCHAIN;
+            return DISAS_PC_UPDATED_NOCHAIN;
 
         case 0x36:
             /* RDPS */
@@ -1270,7 +1249,7 @@ static ExitStatus gen_call_pal(DisasContext *ctx, int palcode)
             palcode &= 0x3f;
             goto do_call_pal;
         }
-        return NO_EXIT;
+        return DISAS_NEXT;
     }
 #endif
     return gen_invalid(ctx);
@@ -1307,10 +1286,10 @@ static ExitStatus gen_call_pal(DisasContext *ctx, int palcode)
             tcg_gen_goto_tb(0);
             tcg_gen_movi_i64(cpu_pc, entry);
             tcg_gen_exit_tb((uintptr_t)ctx->tb);
-            return EXIT_GOTO_TB;
+            return DISAS_NORETURN;
         } else {
             tcg_gen_movi_i64(cpu_pc, entry);
-            return EXIT_PC_UPDATED;
+            return DISAS_PC_UPDATED;
         }
     }
 #endif
@@ -1344,7 +1323,7 @@ static int cpu_pr_data(int pr)
     return 0;
 }
 
-static ExitStatus gen_mfpr(DisasContext *ctx, TCGv va, int regno)
+static DisasJumpType gen_mfpr(DisasContext *ctx, TCGv va, int regno)
 {
     void (*helper)(TCGv);
     int data;
@@ -1366,7 +1345,7 @@ static ExitStatus gen_mfpr(DisasContext *ctx, TCGv va, int regno)
             gen_io_start();
             helper(va);
             gen_io_end();
-            return EXIT_PC_STALE;
+            return DISAS_PC_STALE;
         } else {
             helper(va);
         }
@@ -1393,10 +1372,10 @@ static ExitStatus gen_mfpr(DisasContext *ctx, TCGv va, int regno)
         break;
     }
 
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus gen_mtpr(DisasContext *ctx, TCGv vb, int regno)
+static DisasJumpType gen_mtpr(DisasContext *ctx, TCGv vb, int regno)
 {
     int data;
 
@@ -1424,7 +1403,7 @@ static ExitStatus gen_mtpr(DisasContext *ctx, TCGv vb, int regno)
     case 252:
         /* HALT */
         gen_helper_halt(vb);
-        return EXIT_PC_STALE;
+        return DISAS_PC_STALE;
 
     case 251:
         /* ALARM */
@@ -1438,7 +1417,7 @@ static ExitStatus gen_mtpr(DisasContext *ctx, TCGv vb, int regno)
            that ended with a CALL_PAL.  Since the base register usually only
            changes during boot, flushing everything works well.  */
         gen_helper_tb_flush(cpu_env);
-        return EXIT_PC_STALE;
+        return DISAS_PC_STALE;
 
     case 32 ... 39:
         /* Accessing the "non-shadow" general registers.  */
@@ -1467,7 +1446,7 @@ static ExitStatus gen_mtpr(DisasContext *ctx, TCGv vb, int regno)
         break;
     }
 
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 #endif /* !USER_ONLY*/
 
@@ -1499,7 +1478,7 @@ static ExitStatus gen_mtpr(DisasContext *ctx, TCGv vb, int regno)
         }                                       \
     } while (0)
 
-static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
+static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
 {
     int32_t disp21, disp16, disp12 __attribute__((unused));
     uint16_t fn11;
@@ -1507,7 +1486,7 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
     bool islit, real_islit;
     TCGv va, vb, vc, tmp, tmp2;
     TCGv_i32 t32;
-    ExitStatus ret;
+    DisasJumpType ret;
 
     /* Decode all instruction fields */
     opc = extract32(insn, 26, 6);
@@ -1530,7 +1509,7 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
         lit = 0;
     }
 
-    ret = NO_EXIT;
+    ret = DISAS_NEXT;
     switch (opc) {
     case 0x00:
         /* CALL_PAL */
@@ -2432,7 +2411,7 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
                 gen_io_start();
                 gen_helper_load_pcc(va, cpu_env);
                 gen_io_end();
-                ret = EXIT_PC_STALE;
+                ret = DISAS_PC_STALE;
             } else {
                 gen_helper_load_pcc(va, cpu_env);
             }
@@ -2480,7 +2459,7 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
         if (ra != 31) {
             tcg_gen_movi_i64(ctx->ir[ra], ctx->pc);
         }
-        ret = EXIT_PC_UPDATED;
+        ret = DISAS_PC_UPDATED;
         break;
 
     case 0x1B:
@@ -2738,7 +2717,7 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
         tcg_temp_free(tmp);
         tcg_gen_andi_i64(cpu_pc, vb, ~3);
         /* Allow interrupts to be recognized right away.  */
-        ret = EXIT_PC_UPDATED_NOCHAIN;
+        ret = DISAS_PC_UPDATED_NOCHAIN;
         break;
 #else
         goto invalid_opc;
@@ -2959,7 +2938,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     target_ulong pc_start;
     target_ulong pc_mask;
     uint32_t insn;
-    ExitStatus ret;
+    DisasJumpType ret;
     int num_insns;
     int max_insns;
 
@@ -3040,41 +3019,40 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 
         /* If we reach a page boundary, are single stepping,
            or exhaust instruction count, stop generation.  */
-        if (ret == NO_EXIT
+        if (ret == DISAS_NEXT
             && ((ctx.pc & pc_mask) == 0
                 || tcg_op_buf_full()
                 || num_insns >= max_insns
                 || singlestep
                 || ctx.singlestep_enabled)) {
-            ret = EXIT_FALLTHRU;
+            ret = DISAS_TOO_MANY;
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
-    case EXIT_FALLTHRU:
+    case DISAS_TOO_MANY:
         if (use_goto_tb(&ctx, ctx.pc)) {
             tcg_gen_goto_tb(0);
             tcg_gen_movi_i64(cpu_pc, ctx.pc);
             tcg_gen_exit_tb((uintptr_t)ctx.tb);
         }
         /* FALLTHRU */
-    case EXIT_PC_STALE:
+    case DISAS_PC_STALE:
         tcg_gen_movi_i64(cpu_pc, ctx.pc);
         /* FALLTHRU */
-    case EXIT_PC_UPDATED:
+    case DISAS_PC_UPDATED:
         if (!use_exit_tb(&ctx)) {
             tcg_gen_lookup_and_goto_ptr(cpu_pc);
             break;
         }
         /* FALLTHRU */
-    case EXIT_PC_UPDATED_NOCHAIN:
+    case DISAS_PC_UPDATED_NOCHAIN:
         if (ctx.singlestep_enabled) {
             gen_excp_1(EXCP_DEBUG, 0);
         } else {
-- 
2.13.5
