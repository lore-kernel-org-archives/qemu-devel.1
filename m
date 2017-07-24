Received: from eggs.gnu.org ([2001:4830:134:3::10]:48167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZjyJ-0003of-RW
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:29:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZjyI-0001yZ-GA
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:55 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33479)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dZjyI-0001yJ-AO
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:54 -0400
Received: by mail-qk0-x244.google.com with SMTP id d145so8411914qkc.0
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 13:28:54 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 24 Jul 2017 13:27:27 -0700
Message-Id: <20170724202728.25960-32-rth@twiddle.net>
In-Reply-To: <20170724202728.25960-1-rth@twiddle.net>
References: <20170724202728.25960-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v15 31/32] target/arm: Split out
 thumb_tr_translate_insn
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

We need not check for ARM vs Thumb state in order to dispatch
disassembly of every instruction.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate.c | 121 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 80 insertions(+), 41 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index cdf2917cef..554b05816b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11951,11 +11951,8 @@ static bool arm_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
     return true;
 }
 
-static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
+static bool arm_pre_translate_insn(DisasContext *dc)
 {
-    DisasContext *dc = container_of(dcbase, DisasContext, base);
-    CPUARMState *env = cpu->env_ptr;
-
 #ifdef CONFIG_USER_ONLY
     /* Intercept jump to the magic kernel page.  */
     if (dc->pc >= 0xffff0000) {
@@ -11963,7 +11960,7 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
            conditional execution block.  */
         gen_exception_internal(EXCP_KERNEL_TRAP);
         dc->base.is_jmp = DISAS_NORETURN;
-        return;
+        return true;
     }
 #endif
 
@@ -11982,56 +11979,85 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
         gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
                       default_exception_el(dc));
         dc->base.is_jmp = DISAS_NORETURN;
-        return;
+        return true;
     }
 
-    if (dc->thumb) {
-        disas_thumb_insn(env, dc);
-        if (dc->condexec_mask) {
-            dc->condexec_cond = (dc->condexec_cond & 0xe)
-                | ((dc->condexec_mask >> 4) & 1);
-            dc->condexec_mask = (dc->condexec_mask << 1) & 0x1f;
-            if (dc->condexec_mask == 0) {
-                dc->condexec_cond = 0;
-            }
-        }
-    } else {
-        unsigned int insn = arm_ldl_code(env, dc->pc, dc->sctlr_b);
-        dc->pc += 4;
-        disas_arm_insn(dc, insn);
-    }
+    return false;
+}
 
+static void arm_post_translate_insn(CPUARMState *env, DisasContext *dc)
+{
     if (dc->condjmp && !dc->base.is_jmp) {
         gen_set_label(dc->condlabel);
         dc->condjmp = 0;
     }
 
-    if (dc->base.is_jmp == DISAS_NEXT) {
-        /* Translation stops when a conditional branch is encountered.
-         * Otherwise the subsequent code could get translated several times.
-         * Also stop translation when a page boundary is reached.  This
-         * ensures prefetch aborts occur at the right place.  */
-
-        if (dc->pc >= dc->next_page_start ||
-            (dc->pc >= dc->next_page_start - 3 &&
-             insn_crosses_page(env, dc))) {
-            /* We want to stop the TB if the next insn starts in a new page,
-             * or if it spans between this page and the next. This means that
-             * if we're looking at the last halfword in the page we need to
-             * see if it's a 16-bit Thumb insn (which will fit in this TB)
-             * or a 32-bit Thumb insn (which won't).
-             * This is to avoid generating a silly TB with a single 16-bit insn
-             * in it at the end of this page (which would execute correctly
-             * but isn't very efficient).
-             */
-            dc->base.is_jmp = DISAS_TOO_MANY;
-        }
+    /* Translation stops when a conditional branch is encountered.
+     * Otherwise the subsequent code could get translated several times.
+     * Also stop translation when a page boundary is reached.  This
+     * ensures prefetch aborts occur at the right place.
+     *
+     * We want to stop the TB if the next insn starts in a new page,
+     * or if it spans between this page and the next. This means that
+     * if we're looking at the last halfword in the page we need to
+     * see if it's a 16-bit Thumb insn (which will fit in this TB)
+     * or a 32-bit Thumb insn (which won't).
+     * This is to avoid generating a silly TB with a single 16-bit insn
+     * in it at the end of this page (which would execute correctly
+     * but isn't very efficient).
+     */
+    if (dc->base.is_jmp == DISAS_NEXT
+        && (dc->pc >= dc->next_page_start
+            || (dc->pc >= dc->next_page_start - 3
+                && insn_crosses_page(env, dc)))) {
+        dc->base.is_jmp = DISAS_TOO_MANY;
     }
 
     dc->base.pc_next = dc->pc;
     translator_loop_temp_check(&dc->base);
 }
 
+static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+    CPUARMState *env = cpu->env_ptr;
+    unsigned int insn;
+
+    if (arm_pre_translate_insn(dc)) {
+        return;
+    }
+
+    insn = arm_ldl_code(env, dc->pc, dc->sctlr_b);
+    dc->pc += 4;
+    disas_arm_insn(dc, insn);
+
+    arm_post_translate_insn(env, dc);
+}
+
+static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+    CPUARMState *env = cpu->env_ptr;
+
+    if (arm_pre_translate_insn(dc)) {
+        return;
+    }
+
+    disas_thumb_insn(env, dc);
+
+    /* Advance the Thumb condexec condition.  */
+    if (dc->condexec_mask) {
+        dc->condexec_cond = ((dc->condexec_cond & 0xe) |
+                             ((dc->condexec_mask >> 4) & 1));
+        dc->condexec_mask = (dc->condexec_mask << 1) & 0x1f;
+        if (dc->condexec_mask == 0) {
+            dc->condexec_cond = 0;
+        }
+    }
+
+    arm_post_translate_insn(env, dc);
+}
+
 static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
@@ -12168,12 +12194,25 @@ static const TranslatorOps arm_translator_ops = {
     .disas_log          = arm_tr_disas_log,
 };
 
+static const TranslatorOps thumb_translator_ops = {
+    .init_disas_context = arm_tr_init_disas_context,
+    .tb_start           = arm_tr_tb_start,
+    .insn_start         = arm_tr_insn_start,
+    .breakpoint_check   = arm_tr_breakpoint_check,
+    .translate_insn     = thumb_tr_translate_insn,
+    .tb_stop            = arm_tr_tb_stop,
+    .disas_log          = arm_tr_disas_log,
+};
+
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
 {
     DisasContext dc;
     const TranslatorOps *ops = &arm_translator_ops;
 
+    if (ARM_TBFLAG_THUMB(tb->flags)) {
+        ops = &thumb_translator_ops;
+    }
 #ifdef TARGET_AARCH64
     if (ARM_TBFLAG_AARCH64_STATE(tb->flags)) {
         ops = &aarch64_translator_ops;
-- 
2.13.3
