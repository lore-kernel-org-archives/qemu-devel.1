Received: from eggs.gnu.org ([209.51.188.92]:34833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gi4sB-0006Ff-9y
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 17:01:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gi4s9-0003WV-LX
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 17:01:51 -0500
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:45435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gi4s9-0003W4-AG
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 17:01:49 -0500
Received: by mail-lf1-x143.google.com with SMTP id b20so11832895lfa.12
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 14:01:49 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 11 Jan 2019 14:01:31 -0800
Message-Id: <20190111220131.27153-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH v2] target/xtensa: rework zero overhead loops
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

Don't invalidate TB with the end of zero overhead loop when LBEG or LEND
change. Instead encode the distance from the start of the page where the
TB starts to the LEND in the TB cs_base and generate loopback code when
the next PC matches encoded LEND. Distance to a destination within the
same page and up to a maximum instruction length into the next page is
encoded literally, otherwise it's zero. The distance from LEND to LBEG
is also encoded in the cs_base: it's encoded literally when less than
256 or as 0 otherwise. This allows for TB chaining for the loopback
branch at the end of a loop for the most common loop sizes.

With this change the resulting emulation speed is about 10% higher in
softmmu mode on uClibc-ng and LTP tests. Emulation speed in linux
user mode is a few percent lower because there's no direct TB chaining
between different memory pages. Testing with lower limit on direct TB
chainig range shows gradual slowdown to ~15% for the block size of 64
bytes and ~50% for the block size of 32 bytes.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:
- drop LINKABLE_*;
- add comment about LEND offset encoding;

 target/xtensa/cpu.h          | 32 ++++++++++++++++++++++++++
 target/xtensa/helper.h       |  2 --
 target/xtensa/op_helper.c    | 24 --------------------
 target/xtensa/overlay_tool.h |  1 +
 target/xtensa/translate.c    | 53 +++++++++++++-------------------------------
 5 files changed, 49 insertions(+), 63 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 34e5ccd9f1d6..6c2636d06c5e 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -400,6 +400,7 @@ struct XtensaConfig {
     int excm_level;
     int ndepc;
     unsigned inst_fetch_width;
+    unsigned max_insn_size;
     uint32_t vecbase;
     uint32_t exception_vector[EXC_MAX];
     unsigned ninterrupt;
@@ -695,6 +696,11 @@ static inline int cpu_mmu_index(CPUXtensaState *env, bool ifetch)
 #define XTENSA_TBFLAG_CALLINC_MASK 0x180000
 #define XTENSA_TBFLAG_CALLINC_SHIFT 19
 
+#define XTENSA_CSBASE_LEND_MASK 0x0000ffff
+#define XTENSA_CSBASE_LEND_SHIFT 0
+#define XTENSA_CSBASE_LBEG_OFF_MASK 0x00ff0000
+#define XTENSA_CSBASE_LBEG_OFF_SHIFT 16
+
 static inline void cpu_get_tb_cpu_state(CPUXtensaState *env, target_ulong *pc,
         target_ulong *cs_base, uint32_t *flags)
 {
@@ -706,6 +712,32 @@ static inline void cpu_get_tb_cpu_state(CPUXtensaState *env, target_ulong *pc,
     *flags |= xtensa_get_ring(env);
     if (env->sregs[PS] & PS_EXCM) {
         *flags |= XTENSA_TBFLAG_EXCM;
+    } else if (xtensa_option_enabled(env->config, XTENSA_OPTION_LOOP)) {
+        target_ulong lend_dist =
+            env->sregs[LEND] - (env->pc & -(1u << TARGET_PAGE_BITS));
+
+        /*
+         * 0 in the csbase_lend field means that there may not be a loopback
+         * for any instruction that starts inside this page. Any other value
+         * means that an instruction that ends at this offset from the page
+         * start may loop back.
+         *
+         * lend_dist is 0 when LEND points to the start of the page, but
+         * no instruction that starts inside this page may end at offset 0,
+         * so it's still correct.
+         *
+         * When an instruction ends at a page boundary it may only start in
+         * the previous page. lend_dist will be encoded as TARGET_PAGE_SIZE
+         * for the TB that contains this instruction.
+         */
+        if (lend_dist < (1u << TARGET_PAGE_BITS) + env->config->max_insn_size) {
+            target_ulong lbeg_off = env->sregs[LEND] - env->sregs[LBEG];
+
+            *cs_base = lend_dist;
+            if (lbeg_off < 256) {
+                *cs_base |= lbeg_off << XTENSA_CSBASE_LBEG_OFF_SHIFT;
+            }
+        }
     }
     if (xtensa_option_enabled(env->config, XTENSA_OPTION_EXTENDED_L32R) &&
             (env->sregs[LITBASE] & 1)) {
diff --git a/target/xtensa/helper.h b/target/xtensa/helper.h
index 10153c245360..2ebba0b2c2bf 100644
--- a/target/xtensa/helper.h
+++ b/target/xtensa/helper.h
@@ -12,8 +12,6 @@ DEF_HELPER_2(rotw, void, env, i32)
 DEF_HELPER_3(window_check, noreturn, env, i32, i32)
 DEF_HELPER_1(restore_owb, void, env)
 DEF_HELPER_2(movsp, void, env, i32)
-DEF_HELPER_2(wsr_lbeg, void, env, i32)
-DEF_HELPER_2(wsr_lend, void, env, i32)
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(simcall, void, env)
 #endif
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index e4b42ab3e56c..078aeb6c2c94 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -107,13 +107,6 @@ static void tb_invalidate_virtual_addr(CPUXtensaState *env, uint32_t vaddr)
     }
 }
 
-#else
-
-static void tb_invalidate_virtual_addr(CPUXtensaState *env, uint32_t vaddr)
-{
-    tb_invalidate_phys_addr(vaddr);
-}
-
 #endif
 
 void HELPER(exception)(CPUXtensaState *env, uint32_t excp)
@@ -370,23 +363,6 @@ void HELPER(movsp)(CPUXtensaState *env, uint32_t pc)
     }
 }
 
-void HELPER(wsr_lbeg)(CPUXtensaState *env, uint32_t v)
-{
-    if (env->sregs[LBEG] != v) {
-        tb_invalidate_virtual_addr(env, env->sregs[LEND] - 1);
-        env->sregs[LBEG] = v;
-    }
-}
-
-void HELPER(wsr_lend)(CPUXtensaState *env, uint32_t v)
-{
-    if (env->sregs[LEND] != v) {
-        tb_invalidate_virtual_addr(env, env->sregs[LEND] - 1);
-        env->sregs[LEND] = v;
-        tb_invalidate_virtual_addr(env, env->sregs[LEND] - 1);
-    }
-}
-
 void HELPER(dump_state)(CPUXtensaState *env)
 {
     XtensaCPU *cpu = xtensa_env_get_cpu(env);
diff --git a/target/xtensa/overlay_tool.h b/target/xtensa/overlay_tool.h
index ee37a04a176c..12609a0d0c1e 100644
--- a/target/xtensa/overlay_tool.h
+++ b/target/xtensa/overlay_tool.h
@@ -457,6 +457,7 @@
     .nareg = XCHAL_NUM_AREGS, \
     .ndepc = (XCHAL_XEA_VERSION >= 2), \
     .inst_fetch_width = XCHAL_INST_FETCH_WIDTH, \
+    .max_insn_size = XCHAL_MAX_INSTRUCTION_SIZE, \
     EXCEPTIONS_SECTION, \
     INTERRUPTS_SECTION, \
     TLB_SECTION, \
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 46e13384488e..a435d9c36cf1 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -53,7 +53,7 @@ struct DisasContext {
     uint32_t pc;
     int cring;
     int ring;
-    uint32_t lbeg;
+    uint32_t lbeg_off;
     uint32_t lend;
 
     bool sar_5bit;
@@ -390,11 +390,9 @@ static void gen_jump(DisasContext *dc, TCGv dest)
 static void gen_jumpi(DisasContext *dc, uint32_t dest, int slot)
 {
     TCGv_i32 tmp = tcg_const_i32(dest);
-#ifndef CONFIG_USER_ONLY
     if (((dc->base.pc_first ^ dest) & TARGET_PAGE_MASK) != 0) {
         slot = -1;
     }
-#endif
     gen_jump_slot(dc, tmp, slot);
     tcg_temp_free(tmp);
 }
@@ -420,25 +418,25 @@ static void gen_callw(DisasContext *dc, int callinc, TCGv_i32 dest)
 static void gen_callwi(DisasContext *dc, int callinc, uint32_t dest, int slot)
 {
     TCGv_i32 tmp = tcg_const_i32(dest);
-#ifndef CONFIG_USER_ONLY
     if (((dc->base.pc_first ^ dest) & TARGET_PAGE_MASK) != 0) {
         slot = -1;
     }
-#endif
     gen_callw_slot(dc, callinc, tmp, slot);
     tcg_temp_free(tmp);
 }
 
 static bool gen_check_loop_end(DisasContext *dc, int slot)
 {
-    if (option_enabled(dc, XTENSA_OPTION_LOOP) &&
-            !(dc->base.tb->flags & XTENSA_TBFLAG_EXCM) &&
-            dc->base.pc_next == dc->lend) {
+    if (dc->base.pc_next == dc->lend) {
         TCGLabel *label = gen_new_label();
 
         tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_SR[LCOUNT], 0, label);
         tcg_gen_subi_i32(cpu_SR[LCOUNT], cpu_SR[LCOUNT], 1);
-        gen_jumpi(dc, dc->lbeg, slot);
+        if (dc->lbeg_off) {
+            gen_jumpi(dc, dc->base.pc_next - dc->lbeg_off, slot);
+        } else {
+            gen_jump(dc, cpu_SR[LBEG]);
+        }
         gen_set_label(label);
         gen_jumpi(dc, dc->base.pc_next, -1);
         return true;
@@ -534,16 +532,6 @@ static void gen_rsr(DisasContext *dc, TCGv_i32 d, uint32_t sr)
     }
 }
 
-static void gen_wsr_lbeg(DisasContext *dc, uint32_t sr, TCGv_i32 s)
-{
-    gen_helper_wsr_lbeg(cpu_env, s);
-}
-
-static void gen_wsr_lend(DisasContext *dc, uint32_t sr, TCGv_i32 s)
-{
-    gen_helper_wsr_lend(cpu_env, s);
-}
-
 static void gen_wsr_sar(DisasContext *dc, uint32_t sr, TCGv_i32 s)
 {
     tcg_gen_andi_i32(cpu_SR[sr], s, 0x3f);
@@ -743,8 +731,6 @@ static void gen_wsr(DisasContext *dc, uint32_t sr, TCGv_i32 s)
 {
     static void (* const wsr_handler[256])(DisasContext *dc,
                                            uint32_t sr, TCGv_i32 v) = {
-        [LBEG] = gen_wsr_lbeg,
-        [LEND] = gen_wsr_lend,
         [SAR] = gen_wsr_sar,
         [BR] = gen_wsr_br,
         [LITBASE] = gen_wsr_litbase,
@@ -906,13 +892,6 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
     }
 
     dc->base.pc_next = dc->pc + len;
-    if (xtensa_option_enabled(dc->config, XTENSA_OPTION_LOOP) &&
-        dc->lbeg == dc->pc &&
-        ((dc->pc ^ (dc->base.pc_next - 1)) & -dc->config->inst_fetch_width)) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "unaligned first instruction of a loop (pc = %08x)\n",
-                      dc->pc);
-    }
     for (i = 1; i < len; ++i) {
         b[i] = cpu_ldub_code(env, dc->pc + i);
     }
@@ -1097,8 +1076,10 @@ static void xtensa_tr_init_disas_context(DisasContextBase *dcbase,
     dc->pc = dc->base.pc_first;
     dc->ring = tb_flags & XTENSA_TBFLAG_RING_MASK;
     dc->cring = (tb_flags & XTENSA_TBFLAG_EXCM) ? 0 : dc->ring;
-    dc->lbeg = env->sregs[LBEG];
-    dc->lend = env->sregs[LEND];
+    dc->lbeg_off = (dc->base.tb->cs_base & XTENSA_CSBASE_LBEG_OFF_MASK) >>
+        XTENSA_CSBASE_LBEG_OFF_SHIFT;
+    dc->lend = (dc->base.tb->cs_base & XTENSA_CSBASE_LEND_MASK) +
+        (dc->base.pc_first & TARGET_PAGE_MASK);
     dc->debug = tb_flags & XTENSA_TBFLAG_DEBUG;
     dc->icount = tb_flags & XTENSA_TBFLAG_ICOUNT;
     dc->cpenable = (tb_flags & XTENSA_TBFLAG_CPENABLE_MASK) >>
@@ -1712,12 +1693,10 @@ static void translate_loop(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
     uint32_t lend = arg[1];
-    TCGv_i32 tmp = tcg_const_i32(lend);
 
     tcg_gen_subi_i32(cpu_SR[LCOUNT], cpu_R[arg[0]], 1);
     tcg_gen_movi_i32(cpu_SR[LBEG], dc->base.pc_next);
-    gen_helper_wsr_lend(cpu_env, tmp);
-    tcg_temp_free(tmp);
+    tcg_gen_movi_i32(cpu_SR[LEND], lend);
 
     if (par[0] != TCG_COND_NEVER) {
         TCGLabel *label = gen_new_label();
@@ -4609,7 +4588,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){LBEG},
-        .op_flags = XTENSA_OP_EXIT_TB_0,
+        .op_flags = XTENSA_OP_EXIT_TB_M1,
         .windowed_register_op = 0x1,
     }, {
         .name = "wsr.lcount",
@@ -4622,7 +4601,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){LEND},
-        .op_flags = XTENSA_OP_EXIT_TB_0,
+        .op_flags = XTENSA_OP_EXIT_TB_M1,
         .windowed_register_op = 0x1,
     }, {
         .name = "wsr.litbase",
@@ -5183,7 +5162,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){LBEG},
-        .op_flags = XTENSA_OP_EXIT_TB_0,
+        .op_flags = XTENSA_OP_EXIT_TB_M1,
         .windowed_register_op = 0x1,
     }, {
         .name = "xsr.lcount",
@@ -5196,7 +5175,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){LEND},
-        .op_flags = XTENSA_OP_EXIT_TB_0,
+        .op_flags = XTENSA_OP_EXIT_TB_M1,
         .windowed_register_op = 0x1,
     }, {
         .name = "xsr.litbase",
-- 
2.11.0
