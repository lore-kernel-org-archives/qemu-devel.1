Received: from eggs.gnu.org ([2001:4830:134:3::10]:46644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1g7s4v-0001v1-OV
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 21:05:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1g7s4t-0003J8-SQ
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 21:05:21 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:40515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1g7s4t-0003C8-3a
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 21:05:19 -0400
Received: by mail-lf1-x142.google.com with SMTP id t22-v6so5516044lfb.7
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 18:05:16 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed,  3 Oct 2018 18:05:05 -0700
Message-Id: <20181004010505.26184-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [RFC] target/xtensa: rework zero overhead loops
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
change. Instead encode the distance from the TB start to the LEND in the
TB flags and generate loopback code when offset of the next PC from the
TB start equals that distance. Distance not greater than the maximal
instruction length is encoded literally, greater distances are capped at
the target page size and encoded as the maximal instruction length plus
the greatest power of 2 that is not bigger than the distance.

Although this change adds dynamic TB search at the end of each zero
overhead loop the resulting emulation speed is about 10% higher in
uClibc-ng and LTP tests.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 dtc                       |  2 +-
 target/xtensa/cpu.h       | 11 ++++++++++
 target/xtensa/helper.h    |  2 --
 target/xtensa/op_helper.c | 24 ---------------------
 target/xtensa/translate.c | 53 ++++++++++++++++++++---------------------------
 5 files changed, 34 insertions(+), 58 deletions(-)

diff --git a/dtc b/dtc
index 88f18909db73..e54388015af1 160000
--- a/dtc
+++ b/dtc
@@ -1 +1 @@
-Subproject commit 88f18909db731a627456f26d779445f84e449536
+Subproject commit e54388015af1fb4bf04d0bca99caba1074d9cc42
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 34e5ccd9f1d6..ad76d75aadde 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -694,6 +694,8 @@ static inline int cpu_mmu_index(CPUXtensaState *env, bool ifetch)
 #define XTENSA_TBFLAG_CWOE 0x40000
 #define XTENSA_TBFLAG_CALLINC_MASK 0x180000
 #define XTENSA_TBFLAG_CALLINC_SHIFT 19
+#define XTENSA_TBFLAG_LEND_MASK 0xfe00000
+#define XTENSA_TBFLAG_LEND_SHIFT 21
 
 static inline void cpu_get_tb_cpu_state(CPUXtensaState *env, target_ulong *pc,
         target_ulong *cs_base, uint32_t *flags)
@@ -706,6 +708,15 @@ static inline void cpu_get_tb_cpu_state(CPUXtensaState *env, target_ulong *pc,
     *flags |= xtensa_get_ring(env);
     if (env->sregs[PS] & PS_EXCM) {
         *flags |= XTENSA_TBFLAG_EXCM;
+    } else if (xtensa_option_enabled(env->config, XTENSA_OPTION_LOOP)) {
+        target_ulong lend_dist = env->sregs[LEND] - env->pc;
+
+        if (lend_dist > (1u << TARGET_PAGE_BITS)) {
+            lend_dist = MAX_INSN_LENGTH + 31 - TARGET_PAGE_BITS;
+        } else if (lend_dist > MAX_INSN_LENGTH) {
+            lend_dist = MAX_INSN_LENGTH + 31 - clz32(lend_dist);
+        }
+        *flags |= lend_dist << XTENSA_TBFLAG_LEND_SHIFT;
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
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 46e13384488e..c48285ce207e 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -54,7 +54,7 @@ struct DisasContext {
     int cring;
     int ring;
     uint32_t lbeg;
-    uint32_t lend;
+    uint32_t lend_dist;
 
     bool sar_5bit;
     bool sar_m32_5bit;
@@ -431,14 +431,13 @@ static void gen_callwi(DisasContext *dc, int callinc, uint32_t dest, int slot)
 
 static bool gen_check_loop_end(DisasContext *dc, int slot)
 {
-    if (option_enabled(dc, XTENSA_OPTION_LOOP) &&
-            !(dc->base.tb->flags & XTENSA_TBFLAG_EXCM) &&
-            dc->base.pc_next == dc->lend) {
+    if (dc->lend_dist && dc->lend_dist <= MAX_INSN_LENGTH &&
+        dc->base.pc_next - dc->base.pc_first == dc->lend_dist) {
         TCGLabel *label = gen_new_label();
 
         tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_SR[LCOUNT], 0, label);
         tcg_gen_subi_i32(cpu_SR[LCOUNT], cpu_SR[LCOUNT], 1);
-        gen_jumpi(dc, dc->lbeg, slot);
+        gen_jump(dc, cpu_SR[LBEG]);
         gen_set_label(label);
         gen_jumpi(dc, dc->base.pc_next, -1);
         return true;
@@ -534,16 +533,6 @@ static void gen_rsr(DisasContext *dc, TCGv_i32 d, uint32_t sr)
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
@@ -743,8 +732,6 @@ static void gen_wsr(DisasContext *dc, uint32_t sr, TCGv_i32 s)
 {
     static void (* const wsr_handler[256])(DisasContext *dc,
                                            uint32_t sr, TCGv_i32 v) = {
-        [LBEG] = gen_wsr_lbeg,
-        [LEND] = gen_wsr_lend,
         [SAR] = gen_wsr_sar,
         [BR] = gen_wsr_br,
         [LITBASE] = gen_wsr_litbase,
@@ -1098,7 +1085,11 @@ static void xtensa_tr_init_disas_context(DisasContextBase *dcbase,
     dc->ring = tb_flags & XTENSA_TBFLAG_RING_MASK;
     dc->cring = (tb_flags & XTENSA_TBFLAG_EXCM) ? 0 : dc->ring;
     dc->lbeg = env->sregs[LBEG];
-    dc->lend = env->sregs[LEND];
+    dc->lend_dist = (tb_flags & XTENSA_TBFLAG_LEND_MASK) >>
+        XTENSA_TBFLAG_LEND_SHIFT;
+    if (dc->lend_dist > MAX_INSN_LENGTH) {
+        dc->lend_dist = (1 << (dc->lend_dist - MAX_INSN_LENGTH)) + 1;
+    }
     dc->debug = tb_flags & XTENSA_TBFLAG_DEBUG;
     dc->icount = tb_flags & XTENSA_TBFLAG_ICOUNT;
     dc->cpenable = (tb_flags & XTENSA_TBFLAG_CPENABLE_MASK) >>
@@ -1150,7 +1141,6 @@ static void xtensa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     CPUXtensaState *env = cpu->env_ptr;
-    target_ulong page_start;
 
     /* These two conditions only apply to the first insn in the TB,
        but this is the first TranslateOps hook that allows exiting.  */
@@ -1189,11 +1179,16 @@ static void xtensa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     }
 
     /* End the TB if the next insn will cross into the next page.  */
-    page_start = dc->base.pc_first & TARGET_PAGE_MASK;
-    if (dc->base.is_jmp == DISAS_NEXT &&
-        (dc->pc - page_start >= TARGET_PAGE_SIZE ||
-         dc->pc - page_start + xtensa_insn_len(env, dc) > TARGET_PAGE_SIZE)) {
-        dc->base.is_jmp = DISAS_TOO_MANY;
+    if (dc->base.is_jmp == DISAS_NEXT) {
+        target_ulong page_start = dc->base.pc_first & TARGET_PAGE_MASK;
+        unsigned next_insn_len = xtensa_insn_len(env, dc);
+
+        if (dc->pc - page_start >= TARGET_PAGE_SIZE ||
+            dc->pc - page_start + next_insn_len > TARGET_PAGE_SIZE ||
+            (dc->lend_dist &&
+             dc->pc - dc->base.pc_first + next_insn_len > dc->lend_dist)) {
+            dc->base.is_jmp = DISAS_TOO_MANY;
+        }
     }
 }
 
@@ -1712,12 +1707,10 @@ static void translate_loop(DisasContext *dc, const uint32_t arg[],
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
@@ -4609,7 +4602,6 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){LBEG},
-        .op_flags = XTENSA_OP_EXIT_TB_0,
         .windowed_register_op = 0x1,
     }, {
         .name = "wsr.lcount",
@@ -4622,7 +4614,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){LEND},
-        .op_flags = XTENSA_OP_EXIT_TB_0,
+        .op_flags = XTENSA_OP_EXIT_TB_M1,
         .windowed_register_op = 0x1,
     }, {
         .name = "wsr.litbase",
@@ -5183,7 +5175,6 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){LBEG},
-        .op_flags = XTENSA_OP_EXIT_TB_0,
         .windowed_register_op = 0x1,
     }, {
         .name = "xsr.lcount",
@@ -5196,7 +5187,7 @@ static const XtensaOpcodeOps core_ops[] = {
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
