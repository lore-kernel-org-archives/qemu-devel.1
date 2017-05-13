Received: from eggs.gnu.org ([2001:4830:134:3::10]:37153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d9TQC-0005B2-Qi
	for qemu-devel@nongnu.org; Sat, 13 May 2017 05:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d9TQA-0001M6-Qb
	for qemu-devel@nongnu.org; Sat, 13 May 2017 05:33:08 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:43760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d9TQA-0001HA-HA
	for qemu-devel@nongnu.org; Sat, 13 May 2017 05:33:06 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sat, 13 May 2017 11:32:39 +0200
Message-Id: <20170513093248.18230-7-aurelien@aurel32.net>
In-Reply-To: <20170513093248.18230-1-aurelien@aurel32.net>
References: <20170513093248.18230-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/15] target/sh4: fix BS_EXCP exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

In case of exception, there is no need to call tcg_gen_exit_tb as the
exception helper won't return.

Also fix a few cases where BS_BRANCH is called instead of BS_EXCP.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 04bc18bf7c..f608e314b6 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -339,7 +339,7 @@ static inline void gen_store_fpr64 (TCGv_i64 t, int reg)
     if (ctx->envflags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL)) {     \
         tcg_gen_movi_i32(cpu_pc, ctx->pc);                           \
         gen_helper_raise_slot_illegal_instruction(cpu_env);          \
-        ctx->bstate = BS_BRANCH;                                     \
+        ctx->bstate = BS_EXCP;                                       \
         return;                                                      \
     }
 
@@ -351,7 +351,7 @@ static inline void gen_store_fpr64 (TCGv_i64 t, int reg)
         } else {                                                     \
             gen_helper_raise_illegal_instruction(cpu_env);           \
         }                                                            \
-        ctx->bstate = BS_BRANCH;                                     \
+        ctx->bstate = BS_EXCP;                                       \
         return;                                                      \
     }
 
@@ -363,7 +363,7 @@ static inline void gen_store_fpr64 (TCGv_i64 t, int reg)
         } else {                                                     \
             gen_helper_raise_fpu_disable(cpu_env);                   \
         }                                                            \
-        ctx->bstate = BS_BRANCH;                                     \
+        ctx->bstate = BS_EXCP;                                       \
         return;                                                      \
     }
 
@@ -1289,7 +1289,7 @@ static void _decode_opc(DisasContext * ctx)
 	    imm = tcg_const_i32(B7_0);
             gen_helper_trapa(cpu_env, imm);
 	    tcg_temp_free(imm);
-	    ctx->bstate = BS_BRANCH;
+            ctx->bstate = BS_EXCP;
 	}
 	return;
     case 0xc800:		/* tst #imm,R0 */
@@ -1798,7 +1798,7 @@ static void _decode_opc(DisasContext * ctx)
     } else {
         gen_helper_raise_illegal_instruction(cpu_env);
     }
-    ctx->bstate = BS_BRANCH;
+    ctx->bstate = BS_EXCP;
 }
 
 static void decode_opc(DisasContext * ctx)
@@ -1867,7 +1867,7 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
             /* We have hit a breakpoint - make sure PC is up-to-date */
             tcg_gen_movi_i32(cpu_pc, ctx.pc);
             gen_helper_debug(cpu_env);
-            ctx.bstate = BS_BRANCH;
+            ctx.bstate = BS_EXCP;
             /* The address covered by the breakpoint must be included in
                [tb->pc, tb->pc + tb->size) in order to for it to be
                properly cleared -- thus we increment the PC here so that
@@ -1911,9 +1911,7 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
             gen_goto_tb(&ctx, 0, ctx.pc);
             break;
         case BS_EXCP:
-            /* gen_op_interrupt_restart(); */
-            tcg_gen_exit_tb(0);
-            break;
+            /* fall through */
         case BS_BRANCH:
         default:
             break;
-- 
2.11.0
