Received: from eggs.gnu.org ([2001:4830:134:3::10]:48845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGTJh-0005f7-Tr
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:56:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGTJZ-0006GW-VJ
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:53 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:42109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGTJZ-0006F9-LG
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:45 -0400
Received: by mail-pf0-x241.google.com with SMTP id p14so14621730pfh.9
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 10:55:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 May 2018 10:54:55 -0700
Message-Id: <20180509175458.15642-26-richard.henderson@linaro.org>
In-Reply-To: <20180509175458.15642-1-richard.henderson@linaro.org>
References: <20180509175458.15642-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 25/28] target/openrisc: convert to TranslatorOps
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

- Changed the num_insns test in insn_start to check for
  dc->base.num_insns > 1, since when tb_start is first
  called in a TB, base.num_insns is already set to 1.

- Removed DISAS_NEXT from the switch in tb_stop; use
  DISAS_TOO_MANY instead.

- Added an assert_not_reached on tb_stop for DISAS_NEXT
  and the default case.

- Merged the two separate log_target_disas calls into the
  disas_log op.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Cc: Stafford Horne <shorne@gmail.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/translate.c | 165 +++++++++++++++++-------------------
 1 file changed, 80 insertions(+), 85 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index b37414fb27..7cf29cd5b0 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1520,46 +1520,22 @@ static void disas_openrisc_insn(DisasContext *dc, OpenRISCCPU *cpu)
     }
 }
 
-void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
+static void openrisc_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
 {
+    DisasContext *dc = container_of(dcb, DisasContext, base);
     CPUOpenRISCState *env = cs->env_ptr;
-    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
-    struct DisasContext ctx, *dc = &ctx;
-    uint32_t pc_start;
-    uint32_t next_page_start;
-    int num_insns;
-    int max_insns;
+    int bound;
 
-    pc_start = tb->pc;
-
-    dc->base.tb = tb;
-    dc->base.singlestep_enabled = cs->singlestep_enabled;
-    dc->base.pc_next = pc_start;
-    dc->base.is_jmp = DISAS_NEXT;
-
-    dc->mem_idx = cpu_mmu_index(&cpu->env, false);
+    dc->mem_idx = cpu_mmu_index(env, false);
     dc->tb_flags = dc->base.tb->flags;
     dc->delayed_branch = (dc->tb_flags & TB_FLAGS_DFLAG) != 0;
+    bound = -(dc->base.pc_first | TARGET_PAGE_MASK) / 4;
+    dc->base.max_insns = MIN(dc->base.max_insns, bound);
+}
 
-    next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
-    num_insns = 0;
-    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
-
-    if (max_insns == 0) {
-        max_insns = CF_COUNT_MASK;
-    }
-    if (max_insns > TCG_MAX_INSNS) {
-        max_insns = TCG_MAX_INSNS;
-    }
-
-    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
-        && qemu_log_in_addr_range(pc_start)) {
-        qemu_log_lock();
-        qemu_log("----------------\n");
-        qemu_log("IN: %s\n", lookup_symbol(pc_start));
-    }
-
-    gen_tb_start(tb);
+static void openrisc_tr_tb_start(DisasContextBase *db, CPUState *cs)
+{
+    DisasContext *dc = container_of(db, DisasContext, base);
 
     /* Allow the TCG optimizer to see that R0 == 0,
        when it's true, which is the common case.  */
@@ -1568,50 +1544,55 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     } else {
         cpu_R[0] = cpu_R0;
     }
+}
 
-    do {
-        tcg_gen_insn_start(dc->base.pc_next, (dc->delayed_branch ? 1 : 0)
-			   | (num_insns ? 2 : 0));
-        num_insns++;
+static void openrisc_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
 
-        if (unlikely(cpu_breakpoint_test(cs, dc->base.pc_next, BP_ANY))) {
-            tcg_gen_movi_tl(cpu_pc, dc->base.pc_next);
-            gen_exception(dc, EXCP_DEBUG);
-            dc->base.is_jmp = DISAS_NORETURN;
-            /* The address covered by the breakpoint must be included in
-               [tb->pc, tb->pc + tb->size) in order to for it to be
-               properly cleared -- thus we increment the PC here so that
-               the logic setting tb->size below does the right thing.  */
-            dc->base.pc_next += 4;
-            break;
+    tcg_gen_insn_start(dc->base.pc_next, (dc->delayed_branch ? 1 : 0)
+                       | (dc->base.num_insns > 1 ? 2 : 0));
+}
+
+static bool openrisc_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
+                                         const CPUBreakpoint *bp)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+
+    tcg_gen_movi_tl(cpu_pc, dc->base.pc_next);
+    gen_exception(dc, EXCP_DEBUG);
+    dc->base.is_jmp = DISAS_NORETURN;
+    /* The address covered by the breakpoint must be included in
+       [tb->pc, tb->pc + tb->size) in order to for it to be
+       properly cleared -- thus we increment the PC here so that
+       the logic setting tb->size below does the right thing.  */
+    dc->base.pc_next += 4;
+    return true;
+}
+
+static void openrisc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+    OpenRISCCPU *cpu = OPENRISC_CPU(cs);
+
+    disas_openrisc_insn(dc, cpu);
+    dc->base.pc_next += 4;
+
+    /* delay slot */
+    if (dc->delayed_branch) {
+        dc->delayed_branch--;
+        if (!dc->delayed_branch) {
+            tcg_gen_mov_tl(cpu_pc, jmp_pc);
+            tcg_gen_discard_tl(jmp_pc);
+            dc->base.is_jmp = DISAS_UPDATE;
+            return;
         }
-
-        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
-            gen_io_start();
-        }
-        disas_openrisc_insn(dc, cpu);
-        dc->base.pc_next += 4;
-
-        /* delay slot */
-        if (dc->delayed_branch) {
-            dc->delayed_branch--;
-            if (!dc->delayed_branch) {
-                tcg_gen_mov_tl(cpu_pc, jmp_pc);
-                tcg_gen_discard_tl(jmp_pc);
-                dc->base.is_jmp = DISAS_UPDATE;
-                break;
-            }
-        }
-    } while (!dc->base.is_jmp
-             && !tcg_op_buf_full()
-             && !dc->base.singlestep_enabled
-             && !singlestep
-             && (dc->base.pc_next < next_page_start)
-             && num_insns < max_insns);
-
-    if (tb_cflags(tb) & CF_LAST_IO) {
-        gen_io_end();
     }
+}
+
+static void openrisc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
 
     if ((dc->tb_flags & TB_FLAGS_DFLAG ? 1 : 0) != (dc->delayed_branch != 0)) {
         tcg_gen_movi_i32(cpu_dflag, dc->delayed_branch != 0);
@@ -1626,10 +1607,9 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         gen_exception(dc, EXCP_DEBUG);
     } else {
         switch (dc->base.is_jmp) {
-        case DISAS_NEXT:
+        case DISAS_TOO_MANY:
             gen_goto_tb(dc, 0, dc->base.pc_next);
             break;
-        default:
         case DISAS_NORETURN:
         case DISAS_JUMP:
         case DISAS_TB_JUMP:
@@ -1639,20 +1619,35 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
                to find the next TB */
             tcg_gen_exit_tb(0);
             break;
+        default:
+            g_assert_not_reached();
         }
     }
+}
 
-    gen_tb_end(tb, num_insns);
+static void openrisc_tr_disas_log(const DisasContextBase *dcbase, CPUState *cs)
+{
+    DisasContext *s = container_of(dcbase, DisasContext, base);
 
-    tb->size = dc->base.pc_next - pc_start;
-    tb->icount = num_insns;
+    qemu_log("IN: %s\n", lookup_symbol(s->base.pc_first));
+    log_target_disas(cs, s->base.pc_first, s->base.tb->size);
+}
 
-    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
-        && qemu_log_in_addr_range(pc_start)) {
-        log_target_disas(cs, pc_start, tb->size);
-        qemu_log("\n");
-        qemu_log_unlock();
-    }
+static const TranslatorOps openrisc_tr_ops = {
+    .init_disas_context = openrisc_tr_init_disas_context,
+    .tb_start           = openrisc_tr_tb_start,
+    .insn_start         = openrisc_tr_insn_start,
+    .breakpoint_check   = openrisc_tr_breakpoint_check,
+    .translate_insn     = openrisc_tr_translate_insn,
+    .tb_stop            = openrisc_tr_tb_stop,
+    .disas_log          = openrisc_tr_disas_log,
+};
+
+void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
+{
+    DisasContext ctx;
+
+    translator_loop(&openrisc_tr_ops, &ctx.base, cs, tb);
 }
 
 void openrisc_cpu_dump_state(CPUState *cs, FILE *f,
-- 
2.17.0
