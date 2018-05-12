Received: from eggs.gnu.org ([2001:4830:134:3::10]:46940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHYly-0005wv-30
	for qemu-devel@nongnu.org; Sat, 12 May 2018 13:57:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHYlu-0002tL-8f
	for qemu-devel@nongnu.org; Sat, 12 May 2018 13:57:34 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:44063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fHYlu-0002t0-3R
	for qemu-devel@nongnu.org; Sat, 12 May 2018 13:57:30 -0400
Received: by mail-pl0-x241.google.com with SMTP id e6-v6so5031723plt.11
	for <qemu-devel@nongnu.org>; Sat, 12 May 2018 10:57:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 12 May 2018 10:57:21 -0700
Message-Id: <20180512175724.5923-2-richard.henderson@linaro.org>
In-Reply-To: <20180512175724.5923-1-richard.henderson@linaro.org>
References: <20180512175724.5923-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/4] target/xtensa: Replace DISAS_UPDATE with
 DISAS_NORETURN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jcmvbkbc@gmail.com

The usage of DISAS_UPDATE is after noreturn helpers.
It is thus indistinguishable from DISAS_NORETURN.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/translate.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index aad496347d..a1e63f9661 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -47,9 +47,6 @@
 #include "exec/log.h"
 
 
-/* is_jmp field values */
-#define DISAS_UPDATE  DISAS_TARGET_0 /* cpu state was modified dynamically */
-
 struct DisasContext {
     const XtensaConfig *config;
     TranslationBlock *tb;
@@ -317,7 +314,7 @@ static void gen_exception_cause(DisasContext *dc, uint32_t cause)
     tcg_temp_free(tcause);
     if (cause == ILLEGAL_INSTRUCTION_CAUSE ||
             cause == SYSCALL_CAUSE) {
-        dc->is_jmp = DISAS_UPDATE;
+        dc->is_jmp = DISAS_NORETURN;
     }
 }
 
@@ -339,7 +336,7 @@ static void gen_debug_exception(DisasContext *dc, uint32_t cause)
     tcg_temp_free(tpc);
     tcg_temp_free(tcause);
     if (cause & (DEBUGCAUSE_IB | DEBUGCAUSE_BI | DEBUGCAUSE_BN)) {
-        dc->is_jmp = DISAS_UPDATE;
+        dc->is_jmp = DISAS_NORETURN;
     }
 }
 
@@ -351,7 +348,7 @@ static bool gen_check_privilege(DisasContext *dc)
     }
 #endif
     gen_exception_cause(dc, PRIVILEGED_CAUSE);
-    dc->is_jmp = DISAS_UPDATE;
+    dc->is_jmp = DISAS_NORETURN;
     return false;
 }
 
@@ -360,7 +357,7 @@ static bool gen_check_cpenable(DisasContext *dc, unsigned cp)
     if (option_enabled(dc, XTENSA_OPTION_COPROCESSOR) &&
             !(dc->cpenable & (1 << cp))) {
         gen_exception_cause(dc, COPROCESSOR0_DISABLED + cp);
-        dc->is_jmp = DISAS_UPDATE;
+        dc->is_jmp = DISAS_NORETURN;
         return false;
     }
     return true;
@@ -382,7 +379,7 @@ static void gen_jump_slot(DisasContext *dc, TCGv dest, int slot)
             tcg_gen_exit_tb(0);
         }
     }
-    dc->is_jmp = DISAS_UPDATE;
+    dc->is_jmp = DISAS_NORETURN;
 }
 
 static void gen_jump(DisasContext *dc, TCGv dest)
@@ -918,7 +915,7 @@ static bool gen_window_check1(DisasContext *dc, unsigned r1)
         TCGv_i32 w = tcg_const_i32(r1 / 4);
 
         gen_helper_window_check(cpu_env, pc, w);
-        dc->is_jmp = DISAS_UPDATE;
+        dc->is_jmp = DISAS_NORETURN;
         return false;
     }
     return true;
@@ -1103,14 +1100,14 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
         tcg_gen_insn_start(dc.pc);
         ++insn_count;
         gen_exception(&dc, EXCP_YIELD);
-        dc.is_jmp = DISAS_UPDATE;
+        dc.is_jmp = DISAS_NORETURN;
         goto done;
     }
     if (tb->flags & XTENSA_TBFLAG_EXCEPTION) {
         tcg_gen_insn_start(dc.pc);
         ++insn_count;
         gen_exception(&dc, EXCP_DEBUG);
-        dc.is_jmp = DISAS_UPDATE;
+        dc.is_jmp = DISAS_NORETURN;
         goto done;
     }
 
@@ -1121,7 +1118,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
         if (unlikely(cpu_breakpoint_test(cs, dc.pc, BP_ANY))) {
             tcg_gen_movi_i32(cpu_pc, dc.pc);
             gen_exception(&dc, EXCP_DEBUG);
-            dc.is_jmp = DISAS_UPDATE;
+            dc.is_jmp = DISAS_NORETURN;
             /* The address covered by the breakpoint must be included in
                [tb->pc, tb->pc + tb->size) in order to for it to be
                properly cleared -- thus we increment the PC here so that
-- 
2.17.0
