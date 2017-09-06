Received: from eggs.gnu.org ([2001:4830:134:3::10]:41807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqi-0000Hn-AN
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqb-0002Kd-RD
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:44 -0400
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:37872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dpcqb-0002Js-J7
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:37 -0400
Received: by mail-pg0-x230.google.com with SMTP id d8so15975225pgt.4
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 09:06:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Sep 2017 09:05:56 -0700
Message-Id: <20170906160612.22769-17-richard.henderson@linaro.org>
In-Reply-To: <20170906160612.22769-1-richard.henderson@linaro.org>
References: <20170906160612.22769-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/32] target/arm: [tcg] Port to
 init_disas_context
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
Message-Id: <150002316201.22386.12115078843605656029.stgit@frigg.lan>
[rth: Adjust for max_insns interface change.]
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate.c | 88 ++++++++++++++++++++++++++++----------------------
 1 file changed, 50 insertions(+), 38 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4db8978a93..a95c183cee 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11824,32 +11824,12 @@ static bool insn_crosses_page(CPUARMState *env, DisasContext *s)
     return false;
 }
 
-/* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
+static int arm_tr_init_disas_context(DisasContextBase *dcbase,
+                                     CPUState *cs, int max_insns)
 {
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
     CPUARMState *env = cs->env_ptr;
     ARMCPU *cpu = arm_env_get_cpu(env);
-    DisasContext dc1, *dc = &dc1;
-    target_ulong next_page_start;
-    int max_insns;
-    bool end_of_page;
-
-    /* generate intermediate code */
-
-    /* The A64 decoder has its own top level loop, because it doesn't need
-     * the A32/T32 complexity to do with conditional execution/IT blocks/etc.
-     */
-    if (ARM_TBFLAG_AARCH64_STATE(tb->flags)) {
-        gen_intermediate_code_a64(&dc->base, cs, tb);
-        return;
-    }
-
-    dc->base.tb = tb;
-    dc->base.pc_first = tb->pc;
-    dc->base.pc_next = dc->base.pc_first;
-    dc->base.is_jmp = DISAS_NEXT;
-    dc->base.num_insns = 0;
-    dc->base.singlestep_enabled = cs->singlestep_enabled;
 
     dc->pc = dc->base.pc_first;
     dc->condjmp = 0;
@@ -11860,23 +11840,23 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
      */
     dc->secure_routed_to_el3 = arm_feature(env, ARM_FEATURE_EL3) &&
                                !arm_el_is_aa64(env, 3);
-    dc->thumb = ARM_TBFLAG_THUMB(tb->flags);
-    dc->sctlr_b = ARM_TBFLAG_SCTLR_B(tb->flags);
-    dc->be_data = ARM_TBFLAG_BE_DATA(tb->flags) ? MO_BE : MO_LE;
-    dc->condexec_mask = (ARM_TBFLAG_CONDEXEC(tb->flags) & 0xf) << 1;
-    dc->condexec_cond = ARM_TBFLAG_CONDEXEC(tb->flags) >> 4;
-    dc->mmu_idx = core_to_arm_mmu_idx(env, ARM_TBFLAG_MMUIDX(tb->flags));
+    dc->thumb = ARM_TBFLAG_THUMB(dc->base.tb->flags);
+    dc->sctlr_b = ARM_TBFLAG_SCTLR_B(dc->base.tb->flags);
+    dc->be_data = ARM_TBFLAG_BE_DATA(dc->base.tb->flags) ? MO_BE : MO_LE;
+    dc->condexec_mask = (ARM_TBFLAG_CONDEXEC(dc->base.tb->flags) & 0xf) << 1;
+    dc->condexec_cond = ARM_TBFLAG_CONDEXEC(dc->base.tb->flags) >> 4;
+    dc->mmu_idx = core_to_arm_mmu_idx(env, ARM_TBFLAG_MMUIDX(dc->base.tb->flags));
     dc->current_el = arm_mmu_idx_to_el(dc->mmu_idx);
 #if !defined(CONFIG_USER_ONLY)
     dc->user = (dc->current_el == 0);
 #endif
-    dc->ns = ARM_TBFLAG_NS(tb->flags);
-    dc->fp_excp_el = ARM_TBFLAG_FPEXC_EL(tb->flags);
-    dc->vfp_enabled = ARM_TBFLAG_VFPEN(tb->flags);
-    dc->vec_len = ARM_TBFLAG_VECLEN(tb->flags);
-    dc->vec_stride = ARM_TBFLAG_VECSTRIDE(tb->flags);
-    dc->c15_cpar = ARM_TBFLAG_XSCALE_CPAR(tb->flags);
-    dc->v7m_handler_mode = ARM_TBFLAG_HANDLER(tb->flags);
+    dc->ns = ARM_TBFLAG_NS(dc->base.tb->flags);
+    dc->fp_excp_el = ARM_TBFLAG_FPEXC_EL(dc->base.tb->flags);
+    dc->vfp_enabled = ARM_TBFLAG_VFPEN(dc->base.tb->flags);
+    dc->vec_len = ARM_TBFLAG_VECLEN(dc->base.tb->flags);
+    dc->vec_stride = ARM_TBFLAG_VECSTRIDE(dc->base.tb->flags);
+    dc->c15_cpar = ARM_TBFLAG_XSCALE_CPAR(dc->base.tb->flags);
+    dc->v7m_handler_mode = ARM_TBFLAG_HANDLER(dc->base.tb->flags);
     dc->cp_regs = cpu->cp_regs;
     dc->features = env->features;
 
@@ -11895,11 +11875,12 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
      *   emit code to generate a software step exception
      *   end the TB
      */
-    dc->ss_active = ARM_TBFLAG_SS_ACTIVE(tb->flags);
-    dc->pstate_ss = ARM_TBFLAG_PSTATE_SS(tb->flags);
+    dc->ss_active = ARM_TBFLAG_SS_ACTIVE(dc->base.tb->flags);
+    dc->pstate_ss = ARM_TBFLAG_PSTATE_SS(dc->base.tb->flags);
     dc->is_ldex = false;
     dc->ss_same_el = false; /* Can't be true since EL_d must be AArch64 */
 
+
     cpu_F0s = tcg_temp_new_i32();
     cpu_F1s = tcg_temp_new_i32();
     cpu_F0d = tcg_temp_new_i64();
@@ -11908,6 +11889,36 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     cpu_V1 = cpu_F1d;
     /* FIXME: cpu_M0 can probably be the same as cpu_V0.  */
     cpu_M0 = tcg_temp_new_i64();
+
+    return max_insns;
+}
+
+/* generate intermediate code for basic block 'tb'.  */
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
+{
+    CPUARMState *env = cs->env_ptr;
+    DisasContext dc1, *dc = &dc1;
+    target_ulong next_page_start;
+    int max_insns;
+    bool end_of_page;
+
+    /* generate intermediate code */
+
+    /* The A64 decoder has its own top level loop, because it doesn't need
+     * the A32/T32 complexity to do with conditional execution/IT blocks/etc.
+     */
+    if (ARM_TBFLAG_AARCH64_STATE(tb->flags)) {
+        gen_intermediate_code_a64(&dc->base, cs, tb);
+        return;
+    }
+
+    dc->base.tb = tb;
+    dc->base.pc_first = dc->base.tb->pc;
+    dc->base.pc_next = dc->base.pc_first;
+    dc->base.is_jmp = DISAS_NEXT;
+    dc->base.num_insns = 0;
+    dc->base.singlestep_enabled = cs->singlestep_enabled;
+
     next_page_start = (dc->base.pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
     max_insns = tb->cflags & CF_COUNT_MASK;
     if (max_insns == 0) {
@@ -11916,6 +11927,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     if (max_insns > TCG_MAX_INSNS) {
         max_insns = TCG_MAX_INSNS;
     }
+    max_insns = arm_tr_init_disas_context(&dc->base, cs, max_insns);
 
     gen_tb_start(tb);
 
-- 
2.13.5
