Received: from eggs.gnu.org ([2001:4830:134:3::10]:48000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZjxx-0003L2-5V
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZjxw-0001NK-08
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:33 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dZjxv-0001Mi-Qi
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:31 -0400
Received: by mail-qt0-x242.google.com with SMTP id l55so13168932qtl.3
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 13:28:31 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 24 Jul 2017 13:27:16 -0700
Message-Id: <20170724202728.25960-21-rth@twiddle.net>
In-Reply-To: <20170724202728.25960-1-rth@twiddle.net>
References: <20170724202728.25960-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v15 20/32] target/arm: [tcg,
 a64] Port to insn_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, vilanova@ac.upc.edu

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
index 2919e5a636..2edcfe05f3 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11238,6 +11238,14 @@ static int aarch64_tr_init_disas_context(DisasContextBase *dcbase,
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
@@ -11269,8 +11277,7 @@ void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
 
     do {
         dc->base.num_insns++;
-        dc->insn_start_idx = tcg_op_buf_count();
-        tcg_gen_insn_start(dc->pc, 0, 0);
+        aarch64_tr_insn_start(&dc->base, cs);
 
         if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
             CPUBreakpoint *bp;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index c7010fffa5..30db22fa79 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11916,6 +11916,33 @@ static void arm_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
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
@@ -11964,28 +11991,15 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
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
@@ -12107,6 +12121,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
             gen_exception(EXCP_SMC, syn_aa32_smc(), 3);
             break;
         case DISAS_NEXT:
+        case DISAS_TOO_MANY:
         case DISAS_UPDATE:
             gen_set_pc_im(dc, dc->pc);
             /* fall through */
@@ -12128,6 +12143,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
          */
         switch(dc->base.is_jmp) {
         case DISAS_NEXT:
+        case DISAS_TOO_MANY:
             gen_goto_tb(dc, 1, dc->pc);
             break;
         case DISAS_JUMP:
@@ -12181,7 +12197,6 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
         }
     }
 
-done_generating:
     gen_tb_end(tb, dc->base.num_insns);
 
 #ifdef DEBUG_DISAS
-- 
2.13.3
