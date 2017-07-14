Received: from eggs.gnu.org ([2001:4830:134:3::10]:54686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVwYC-0007Jv-V4
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:06:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVwY8-0007Hj-W3
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:06:16 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Fri, 14 Jul 2017 12:06:02 +0300
Message-Id: <150002316201.22386.12115078843605656029.stgit@frigg.lan>
In-Reply-To: <150002001195.22386.4679134058536830996.stgit@frigg.lan>
References: <150002001195.22386.4679134058536830996.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v13 13/26] target/arm: [tcg] Port to
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
Cc: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

Incrementally paves the way towards using the generic instruction transla=
tion
loop.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Alex Benne=C3=A9 <alex.benee@linaro.org>
---
 target/arm/translate.c |   86 +++++++++++++++++++++++++++---------------=
------
 1 file changed, 48 insertions(+), 38 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 15b4fcb417..0179b1ce79 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11786,32 +11786,12 @@ static bool insn_crosses_page(CPUARMState *env,=
 DisasContext *s)
     return false;
 }
=20
-/* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
+static void arm_tr_init_disas_context(DisasContextBase *dcbase,
+                                           CPUState *cs)
 {
+    DisasContext *dc =3D container_of(dcbase, DisasContext, base);
     CPUARMState *env =3D cs->env_ptr;
     ARMCPU *cpu =3D arm_env_get_cpu(env);
-    DisasContext dc1, *dc =3D &dc1;
-    target_ulong next_page_start;
-    int max_insns;
-    bool end_of_page;
-
-    /* generate intermediate code */
-
-    /* The A64 decoder has its own top level loop, because it doesn't ne=
ed
-     * the A32/T32 complexity to do with conditional execution/IT blocks=
/etc.
-     */
-    if (ARM_TBFLAG_AARCH64_STATE(tb->flags)) {
-        gen_intermediate_code_a64(&dc->base, cs, tb);
-        return;
-    }
-
-    dc->base.tb =3D tb;
-    dc->base.pc_first =3D tb->pc;
-    dc->base.pc_next =3D dc->base.pc_first;
-    dc->base.is_jmp =3D DISAS_NEXT;
-    dc->base.num_insns =3D 0;
-    dc->base.singlestep_enabled =3D cs->singlestep_enabled;
=20
     dc->pc =3D dc->base.pc_first;
     dc->condjmp =3D 0;
@@ -11822,23 +11802,23 @@ void gen_intermediate_code(CPUState *cs, Transl=
ationBlock *tb)
      */
     dc->secure_routed_to_el3 =3D arm_feature(env, ARM_FEATURE_EL3) &&
                                !arm_el_is_aa64(env, 3);
-    dc->thumb =3D ARM_TBFLAG_THUMB(tb->flags);
-    dc->sctlr_b =3D ARM_TBFLAG_SCTLR_B(tb->flags);
-    dc->be_data =3D ARM_TBFLAG_BE_DATA(tb->flags) ? MO_BE : MO_LE;
-    dc->condexec_mask =3D (ARM_TBFLAG_CONDEXEC(tb->flags) & 0xf) << 1;
-    dc->condexec_cond =3D ARM_TBFLAG_CONDEXEC(tb->flags) >> 4;
-    dc->mmu_idx =3D core_to_arm_mmu_idx(env, ARM_TBFLAG_MMUIDX(tb->flags=
));
+    dc->thumb =3D ARM_TBFLAG_THUMB(dc->base.tb->flags);
+    dc->sctlr_b =3D ARM_TBFLAG_SCTLR_B(dc->base.tb->flags);
+    dc->be_data =3D ARM_TBFLAG_BE_DATA(dc->base.tb->flags) ? MO_BE : MO_=
LE;
+    dc->condexec_mask =3D (ARM_TBFLAG_CONDEXEC(dc->base.tb->flags) & 0xf=
) << 1;
+    dc->condexec_cond =3D ARM_TBFLAG_CONDEXEC(dc->base.tb->flags) >> 4;
+    dc->mmu_idx =3D core_to_arm_mmu_idx(env, ARM_TBFLAG_MMUIDX(dc->base.=
tb->flags));
     dc->current_el =3D arm_mmu_idx_to_el(dc->mmu_idx);
 #if !defined(CONFIG_USER_ONLY)
     dc->user =3D (dc->current_el =3D=3D 0);
 #endif
-    dc->ns =3D ARM_TBFLAG_NS(tb->flags);
-    dc->fp_excp_el =3D ARM_TBFLAG_FPEXC_EL(tb->flags);
-    dc->vfp_enabled =3D ARM_TBFLAG_VFPEN(tb->flags);
-    dc->vec_len =3D ARM_TBFLAG_VECLEN(tb->flags);
-    dc->vec_stride =3D ARM_TBFLAG_VECSTRIDE(tb->flags);
-    dc->c15_cpar =3D ARM_TBFLAG_XSCALE_CPAR(tb->flags);
-    dc->v7m_handler_mode =3D ARM_TBFLAG_HANDLER(tb->flags);
+    dc->ns =3D ARM_TBFLAG_NS(dc->base.tb->flags);
+    dc->fp_excp_el =3D ARM_TBFLAG_FPEXC_EL(dc->base.tb->flags);
+    dc->vfp_enabled =3D ARM_TBFLAG_VFPEN(dc->base.tb->flags);
+    dc->vec_len =3D ARM_TBFLAG_VECLEN(dc->base.tb->flags);
+    dc->vec_stride =3D ARM_TBFLAG_VECSTRIDE(dc->base.tb->flags);
+    dc->c15_cpar =3D ARM_TBFLAG_XSCALE_CPAR(dc->base.tb->flags);
+    dc->v7m_handler_mode =3D ARM_TBFLAG_HANDLER(dc->base.tb->flags);
     dc->cp_regs =3D cpu->cp_regs;
     dc->features =3D env->features;
=20
@@ -11857,11 +11837,12 @@ void gen_intermediate_code(CPUState *cs, Transl=
ationBlock *tb)
      *   emit code to generate a software step exception
      *   end the TB
      */
-    dc->ss_active =3D ARM_TBFLAG_SS_ACTIVE(tb->flags);
-    dc->pstate_ss =3D ARM_TBFLAG_PSTATE_SS(tb->flags);
+    dc->ss_active =3D ARM_TBFLAG_SS_ACTIVE(dc->base.tb->flags);
+    dc->pstate_ss =3D ARM_TBFLAG_PSTATE_SS(dc->base.tb->flags);
     dc->is_ldex =3D false;
     dc->ss_same_el =3D false; /* Can't be true since EL_d must be AArch6=
4 */
=20
+
     cpu_F0s =3D tcg_temp_new_i32();
     cpu_F1s =3D tcg_temp_new_i32();
     cpu_F0d =3D tcg_temp_new_i64();
@@ -11870,6 +11851,35 @@ void gen_intermediate_code(CPUState *cs, Transla=
tionBlock *tb)
     cpu_V1 =3D cpu_F1d;
     /* FIXME: cpu_M0 can probably be the same as cpu_V0.  */
     cpu_M0 =3D tcg_temp_new_i64();
+}
+
+/* generate intermediate code for basic block 'tb'.  */
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
+{
+    CPUARMState *env =3D cs->env_ptr;
+    DisasContext dc1, *dc =3D &dc1;
+    target_ulong next_page_start;
+    int max_insns;
+    bool end_of_page;
+
+    /* generate intermediate code */
+
+    /* The A64 decoder has its own top level loop, because it doesn't ne=
ed
+     * the A32/T32 complexity to do with conditional execution/IT blocks=
/etc.
+     */
+    if (ARM_TBFLAG_AARCH64_STATE(tb->flags)) {
+        gen_intermediate_code_a64(&dc->base, cs, tb);
+        return;
+    }
+
+    dc->base.tb =3D tb;
+    dc->base.pc_first =3D dc->base.tb->pc;
+    dc->base.pc_next =3D dc->base.pc_first;
+    dc->base.is_jmp =3D DISAS_NEXT;
+    dc->base.num_insns =3D 0;
+    dc->base.singlestep_enabled =3D cs->singlestep_enabled;
+    arm_tr_init_disas_context(&dc->base, cs);
+
     next_page_start =3D (dc->base.pc_first & TARGET_PAGE_MASK) + TARGET_=
PAGE_SIZE;
     max_insns =3D tb->cflags & CF_COUNT_MASK;
     if (max_insns =3D=3D 0) {
