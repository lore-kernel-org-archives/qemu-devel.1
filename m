Received: from eggs.gnu.org ([2001:4830:134:3::10]:48451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGTJN-0005D4-At
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGTJJ-0005pY-BW
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:33 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:44702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGTJI-0005o3-QN
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:29 -0400
Received: by mail-pf0-x241.google.com with SMTP id q22so25999824pff.11
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 10:55:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 May 2018 10:54:45 -0700
Message-Id: <20180509175458.15642-16-richard.henderson@linaro.org>
In-Reply-To: <20180509175458.15642-1-richard.henderson@linaro.org>
References: <20180509175458.15642-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 15/28] target/sparc: convert to TranslatorOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, Stafford Horne <shorne@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Walle <michael@walle.cc>, Max Filippov <jcmvbkbc@gmail.com>, Richard Henderson <rth@twiddle.net>, Michael Clark <mjc@sifive.com>, Eduardo Habkost <ehabkost@redhat.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, peter.maydell@linaro.org, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, qemu-s390x@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, Palmer Dabbelt <palmer@sifive.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Notes:

- Moved the cross-page check from the end of translate_insn to
  init_disas_context.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 178 +++++++++++++++++++--------------------
 1 file changed, 88 insertions(+), 90 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 889c43976d..40b2eaad39 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5737,99 +5737,91 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
     }
 }
 
-void gen_intermediate_code(CPUState *cs, TranslationBlock * tb)
+static void sparc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
     CPUSPARCState *env = cs->env_ptr;
-    DisasContext dc1, *dc = &dc1;
-    int max_insns;
-    unsigned int insn;
-
-    memset(dc, 0, sizeof(DisasContext));
-    dc->base.tb = tb;
-    dc->base.pc_first = tb->pc;
-    dc->base.pc_next = tb->pc;
-    dc->base.is_jmp = DISAS_NEXT;
-    dc->base.num_insns = 0;
-    dc->base.singlestep_enabled = cs->singlestep_enabled;
+    int bound;
 
     dc->pc = dc->base.pc_first;
-    dc->npc = (target_ulong) tb->cs_base;
+    dc->npc = (target_ulong)dc->base.tb->cs_base;
     dc->cc_op = CC_OP_DYNAMIC;
-    dc->mem_idx = tb->flags & TB_FLAG_MMU_MASK;
+    dc->mem_idx = dc->base.tb->flags & TB_FLAG_MMU_MASK;
     dc->def = &env->def;
-    dc->fpu_enabled = tb_fpu_enabled(tb->flags);
-    dc->address_mask_32bit = tb_am_enabled(tb->flags);
+    dc->fpu_enabled = tb_fpu_enabled(dc->base.tb->flags);
+    dc->address_mask_32bit = tb_am_enabled(dc->base.tb->flags);
 #ifndef CONFIG_USER_ONLY
-    dc->supervisor = (tb->flags & TB_FLAG_SUPER) != 0;
+    dc->supervisor = (dc->base.tb->flags & TB_FLAG_SUPER) != 0;
 #endif
 #ifdef TARGET_SPARC64
     dc->fprs_dirty = 0;
-    dc->asi = (tb->flags >> TB_FLAG_ASI_SHIFT) & 0xff;
+    dc->asi = (dc->base.tb->flags >> TB_FLAG_ASI_SHIFT) & 0xff;
 #ifndef CONFIG_USER_ONLY
-    dc->hypervisor = (tb->flags & TB_FLAG_HYPER) != 0;
+    dc->hypervisor = (dc->base.tb->flags & TB_FLAG_HYPER) != 0;
 #endif
 #endif
+    /*
+     * if we reach a page boundary, we stop generation so that the
+     * PC of a TT_TFAULT exception is always in the right page
+     */
+    bound = -(dc->base.pc_first | TARGET_PAGE_MASK) / 4;
+    dc->base.max_insns = MIN(dc->base.max_insns, bound);
+}
 
-    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
-    if (max_insns == 0) {
-        max_insns = CF_COUNT_MASK;
+static void sparc_tr_tb_start(DisasContextBase *db, CPUState *cs)
+{
+}
+
+static void sparc_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+
+    if (dc->npc & JUMP_PC) {
+        assert(dc->jump_pc[1] == dc->pc + 4);
+        tcg_gen_insn_start(dc->pc, dc->jump_pc[0] | JUMP_PC);
+    } else {
+        tcg_gen_insn_start(dc->pc, dc->npc);
     }
-    if (max_insns > TCG_MAX_INSNS) {
-        max_insns = TCG_MAX_INSNS;
+}
+
+static bool sparc_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
+                                      const CPUBreakpoint *bp)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+
+    if (dc->pc != dc->base.pc_first) {
+        save_state(dc);
     }
-    if (dc->base.singlestep_enabled || singlestep) {
-        max_insns = 1;
+    gen_helper_debug(cpu_env);
+    tcg_gen_exit_tb(0);
+    dc->base.is_jmp = DISAS_NORETURN;
+    /* update pc_next so that the current instruction is included in tb->size */
+    dc->base.pc_next += 4;
+    return true;
+}
+
+static void sparc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+    CPUSPARCState *env = cs->env_ptr;
+    unsigned int insn;
+
+    insn = cpu_ldl_code(env, dc->pc);
+    dc->base.pc_next += 4;
+    disas_sparc_insn(dc, insn);
+
+    if (dc->base.is_jmp == DISAS_NORETURN) {
+        return;
     }
-
-    gen_tb_start(tb);
-    do {
-        if (dc->npc & JUMP_PC) {
-            assert(dc->jump_pc[1] == dc->pc + 4);
-            tcg_gen_insn_start(dc->pc, dc->jump_pc[0] | JUMP_PC);
-        } else {
-            tcg_gen_insn_start(dc->pc, dc->npc);
-        }
-        dc->base.num_insns++;
-
-        if (unlikely(cpu_breakpoint_test(cs, dc->base.pc_next, BP_ANY))) {
-            if (dc->pc != dc->base.pc_first) {
-                save_state(dc);
-            }
-            gen_helper_debug(cpu_env);
-            tcg_gen_exit_tb(0);
-            dc->base.is_jmp = DISAS_NORETURN;
-            dc->base.pc_next += 4;
-            goto exit_gen_loop;
-        }
-
-        if (dc->base.num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
-            gen_io_start();
-        }
-
-        insn = cpu_ldl_code(env, dc->pc);
-        dc->base.pc_next += 4;
-
-        disas_sparc_insn(dc, insn);
-
-        if (dc->base.is_jmp == DISAS_NORETURN) {
-            break;
-        }
-        /* if the next PC is different, we abort now */
-        if (dc->pc != dc->base.pc_next) {
-            break;
-        }
-        /* if we reach a page boundary, we stop generation so that the
-           PC of a TT_TFAULT exception is always in the right page */
-        if ((dc->pc & (TARGET_PAGE_SIZE - 1)) == 0)
-            break;
-    } while (!tcg_op_buf_full() &&
-             (dc->pc - dc->base.pc_first) < (TARGET_PAGE_SIZE - 32) &&
-             dc->base.num_insns < max_insns);
-
- exit_gen_loop:
-    if (tb_cflags(tb) & CF_LAST_IO) {
-        gen_io_end();
+    if (dc->pc != dc->base.pc_next) {
+        dc->base.is_jmp = DISAS_TOO_MANY;
     }
+}
+
+static void sparc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+
     if (dc->base.is_jmp != DISAS_NORETURN) {
         if (dc->pc != DYNAMIC_PC &&
             (dc->npc != DYNAMIC_PC && dc->npc != JUMP_PC)) {
@@ -5843,23 +5835,29 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock * tb)
             tcg_gen_exit_tb(0);
         }
     }
-    gen_tb_end(tb, dc->base.num_insns);
+}
 
-    tb->size = dc->base.pc_next - dc->base.pc_first;
-    tb->icount = dc->base.num_insns;
+static void sparc_tr_disas_log(const DisasContextBase *dcbase, CPUState *cpu)
+{
+    qemu_log("IN: %s\n", lookup_symbol(dcbase->pc_first));
+    log_target_disas(cpu, dcbase->pc_first, dcbase->tb->size);
+}
 
-#ifdef DEBUG_DISAS
-    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
-        && qemu_log_in_addr_range(dc->base.pc_first)) {
-        qemu_log_lock();
-        qemu_log("--------------\n");
-        qemu_log("IN: %s\n", lookup_symbol(dc->base.pc_first));
-        log_target_disas(cs, dc->base.pc_first,
-                         dc->base.pc_next - dc->base.pc_first);
-        qemu_log("\n");
-        qemu_log_unlock();
-    }
-#endif
+static const TranslatorOps sparc_tr_ops = {
+    .init_disas_context = sparc_tr_init_disas_context,
+    .tb_start           = sparc_tr_tb_start,
+    .insn_start         = sparc_tr_insn_start,
+    .breakpoint_check   = sparc_tr_breakpoint_check,
+    .translate_insn     = sparc_tr_translate_insn,
+    .tb_stop            = sparc_tr_tb_stop,
+    .disas_log          = sparc_tr_disas_log,
+};
+
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
+{
+    DisasContext dc = {};
+
+    translator_loop(&sparc_tr_ops, &dc.base, cs, tb);
 }
 
 void sparc_tcg_init(void)
-- 
2.17.0
