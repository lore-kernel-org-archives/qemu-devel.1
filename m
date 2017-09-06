Received: from eggs.gnu.org ([2001:4830:134:3::10]:41811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqi-0000Hu-E2
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqh-0002b4-8D
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:44 -0400
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233]:33133)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dpcqh-0002Yz-1G
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:43 -0400
Received: by mail-pf0-x233.google.com with SMTP id y68so13496497pfd.0
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 09:06:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Sep 2017 09:06:00 -0700
Message-Id: <20170906160612.22769-21-richard.henderson@linaro.org>
In-Reply-To: <20170906160612.22769-1-richard.henderson@linaro.org>
References: <20170906160612.22769-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/32] target/arm: [tcg, a64] Port to insn_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Richard Henderson <rth@twiddle.net>

From: Lluís Vilanova <vilanova@ac.upc.edu>

Incrementally paves the way towards using the generic instruction translation
loop.

Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Alex Benneé <alex.benee@linaro.org>
Message-Id: <150002413187.22386.156315485813606121.stgit@frigg.lan>
[rth: Use DISAS_TOO_MANY for "execute only one more" after bp.]
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate-a64.c | 11 ++++++++--
 target/arm/translate.c     | 55 +++++++++++++++++++++++++++++-----------------
 2 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e8dc96c28a..1eab10696c 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11259,6 +11259,14 @@ static int aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     return max_insns;
 }
 
+static void aarch64_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+
+    dc->insn_start_idx = tcg_op_buf_count();
+    tcg_gen_insn_start(dc->pc, 0, 0);
+}
+
 void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
                                TranslationBlock *tb)
 {
@@ -11290,8 +11298,7 @@ void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
 
     do {
         dc->base.num_insns++;
-        dc->insn_start_idx = tcg_op_buf_count();
-        tcg_gen_insn_start(dc->pc, 0, 0);
+        aarch64_tr_insn_start(&dc->base, cs);
 
         if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
             CPUBreakpoint *bp;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 005157225c..2f5f65310d 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11946,6 +11946,33 @@ static void arm_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
                        0);
 }
 
+static bool arm_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
+                                    const CPUBreakpoint *bp)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+
+    if (bp->flags & BP_CPU) {
+        gen_set_condexec(dc);
+        gen_set_pc_im(dc, dc->pc);
+        gen_helper_check_breakpoints(cpu_env);
+        /* End the TB early; it's likely not going to be executed */
+        dc->base.is_jmp = DISAS_TOO_MANY;
+    } else {
+        gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
+        /* The address covered by the breakpoint must be
+           included in [tb->pc, tb->pc + tb->size) in order
+           to for it to be properly cleared -- thus we
+           increment the PC here so that the logic setting
+           tb->size below does the right thing.  */
+        /* TODO: Advance PC by correct instruction length to
+         * avoid disassembler error messages */
+        dc->pc += 2;
+        dc->base.is_jmp = DISAS_NORETURN;
+    }
+
+    return true;
+}
+
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
@@ -11994,28 +12021,15 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
         if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
             CPUBreakpoint *bp;
             QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
-                if (bp->pc == dc->pc) {
-                    if (bp->flags & BP_CPU) {
-                        gen_set_condexec(dc);
-                        gen_set_pc_im(dc, dc->pc);
-                        gen_helper_check_breakpoints(cpu_env);
-                        /* End the TB early; it's likely not going to be executed */
-                        dc->base.is_jmp = DISAS_UPDATE;
-                    } else {
-                        gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
-                        /* The address covered by the breakpoint must be
-                           included in [tb->pc, tb->pc + tb->size) in order
-                           to for it to be properly cleared -- thus we
-                           increment the PC here so that the logic setting
-                           tb->size below does the right thing.  */
-                        /* TODO: Advance PC by correct instruction length to
-                         * avoid disassembler error messages */
-                        dc->pc += 2;
-                        goto done_generating;
+                if (bp->pc == dc->base.pc_next) {
+                    if (arm_tr_breakpoint_check(&dc->base, cs, bp)) {
+                        break;
                     }
-                    break;
                 }
             }
+            if (dc->base.is_jmp > DISAS_TOO_MANY) {
+                break;
+            }
         }
 
         if (dc->base.num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
@@ -12137,6 +12151,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
             gen_exception(EXCP_SMC, syn_aa32_smc(), 3);
             break;
         case DISAS_NEXT:
+        case DISAS_TOO_MANY:
         case DISAS_UPDATE:
             gen_set_pc_im(dc, dc->pc);
             /* fall through */
@@ -12158,6 +12173,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
          */
         switch(dc->base.is_jmp) {
         case DISAS_NEXT:
+        case DISAS_TOO_MANY:
             gen_goto_tb(dc, 1, dc->pc);
             break;
         case DISAS_JUMP:
@@ -12211,7 +12227,6 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
         }
     }
 
-done_generating:
     gen_tb_end(tb, dc->base.num_insns);
 
 #ifdef DEBUG_DISAS
-- 
2.13.5
