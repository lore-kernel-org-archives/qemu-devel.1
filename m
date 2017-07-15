Received: from eggs.gnu.org ([2001:4830:134:3::10]:38541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJcG-0004nX-5G
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:44:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJcD-0003eU-EL
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:59 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:34412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWJcD-0003dp-6U
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:57 -0400
Received: by mail-pg0-x243.google.com with SMTP id j186so13347641pge.1
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 02:43:57 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 14 Jul 2017 23:42:42 -1000
Message-Id: <20170715094243.28371-34-rth@twiddle.net>
In-Reply-To: <20170715094243.28371-1-rth@twiddle.net>
References: <20170715094243.28371-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v14 33/34] target/arm: Split out
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
Cc: vilanova@ac.upc.edu, cota@braap.org, alex.bennee@linaro.org, crosthwaite.peter@gmail.com, pbonzini@redhat.com

We need not check for ARM vs Thumb state in order to dispatch
disassembly of every instruction.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate.c | 134 +++++++++++++++++++++++++++++++------------------
 1 file changed, 86 insertions(+), 48 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index ebe1c1a..d7c3c10 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11944,20 +11944,17 @@ static bool arm_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
     return true;
 }
 
-static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
+static bool arm_pre_translate_insn(DisasContext *dc)
 {
-    DisasContext *dc = container_of(dcbase, DisasContext, base);
-    CPUARMState *env = cpu->env_ptr;
-
 #ifdef CONFIG_USER_ONLY
-        /* Intercept jump to the magic kernel page.  */
-        if (dc->pc >= 0xffff0000) {
-            /* We always get here via a jump, so know we are not in a
-               conditional execution block.  */
-            gen_exception_internal(EXCP_KERNEL_TRAP);
-            dc->base.is_jmp = DISAS_NORETURN;
-            return;
-        }
+    /* Intercept jump to the magic kernel page.  */
+    if (dc->pc >= 0xffff0000) {
+        /* We always get here via a jump, so know we are not in a
+           conditional execution block.  */
+        gen_exception_internal(EXCP_KERNEL_TRAP);
+        dc->base.is_jmp = DISAS_NORETURN;
+        return true;
+    }
 #endif
 
     if (dc->ss_active && !dc->pstate_ss) {
@@ -11975,54 +11972,82 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
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
+    return false;
+}
+
+static void arm_post_translate_insn(CPUARMState *env, DisasContext *dc)
+{
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
 
     if (dc->condjmp && !dc->base.is_jmp) {
         gen_set_label(dc->condlabel);
         dc->condjmp = 0;
     }
+    dc->base.pc_next = dc->pc;
+    translator_loop_temp_check(&dc->base);
+}
 
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
         }
     }
 
-    dc->base.pc_next = dc->pc;
-    translator_loop_temp_check(&dc->base);
+    arm_post_translate_insn(env, dc);
 }
 
 static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
@@ -12161,12 +12186,25 @@ static const TranslatorOps arm_translator_ops = {
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
2.9.4
