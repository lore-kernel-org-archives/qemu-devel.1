Received: from eggs.gnu.org ([2001:4830:134:3::10]:35266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP4HU-0006n3-RI
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 05:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP4HR-0007Bh-Q3
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 05:56:36 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Sun, 25 Jun 2017 12:56:22 +0300
Message-Id: <149838458211.6497.11741295397438731209.stgit@frigg.lan>
In-Reply-To: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 18/26] target: [tcg,
 arm] Port to init_disas_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

Incrementally paves the way towards using the generic instruction transla=
tion
loop.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 target/arm/translate-a64.c |   51 +++++++++++++++-----------
 target/arm/translate.c     |   87 ++++++++++++++++++++++++--------------=
------
 2 files changed, 78 insertions(+), 60 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 8d48251321..1959f27377 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11202,21 +11202,12 @@ static void disas_a64_insn(CPUARMState *env, Di=
sasContext *s)
     free_tmp_a64(s);
 }
=20
-void gen_intermediate_code_a64(DisasContextBase *db, ARMCPU *cpu,
-                               TranslationBlock *tb)
+static void aarch64_trblock_init_disas_context(DisasContextBase *db,
+                                               CPUState *cpu)
 {
-    CPUState *cs =3D CPU(cpu);
-    CPUARMState *env =3D &cpu->env;
     DisasContext *dc =3D container_of(db, DisasContext, base);
-    target_ulong next_page_start;
-    int max_insns;
-
-    db->tb =3D tb;
-    db->pc_first =3D tb->pc;
-    db->pc_next =3D db->pc_first;
-    db->is_jmp =3D DJ_NEXT;
-    db->num_insns =3D 0;
-    db->singlestep_enabled =3D cs->singlestep_enabled;
+    CPUARMState *env =3D cpu->env_ptr;
+    ARMCPU *arm_cpu =3D arm_env_get_cpu(env);
=20
     dc->pc =3D db->pc_first;
     dc->condjmp =3D 0;
@@ -11229,20 +11220,20 @@ void gen_intermediate_code_a64(DisasContextBase=
 *db, ARMCPU *cpu,
                                !arm_el_is_aa64(env, 3);
     dc->thumb =3D 0;
     dc->sctlr_b =3D 0;
-    dc->be_data =3D ARM_TBFLAG_BE_DATA(tb->flags) ? MO_BE : MO_LE;
+    dc->be_data =3D ARM_TBFLAG_BE_DATA(db->tb->flags) ? MO_BE : MO_LE;
     dc->condexec_mask =3D 0;
     dc->condexec_cond =3D 0;
-    dc->mmu_idx =3D core_to_arm_mmu_idx(env, ARM_TBFLAG_MMUIDX(tb->flags=
));
-    dc->tbi0 =3D ARM_TBFLAG_TBI0(tb->flags);
-    dc->tbi1 =3D ARM_TBFLAG_TBI1(tb->flags);
+    dc->mmu_idx =3D core_to_arm_mmu_idx(env, ARM_TBFLAG_MMUIDX(db->tb->f=
lags));
+    dc->tbi0 =3D ARM_TBFLAG_TBI0(db->tb->flags);
+    dc->tbi1 =3D ARM_TBFLAG_TBI1(db->tb->flags);
     dc->current_el =3D arm_mmu_idx_to_el(dc->mmu_idx);
 #if !defined(CONFIG_USER_ONLY)
     dc->user =3D (dc->current_el =3D=3D 0);
 #endif
-    dc->fp_excp_el =3D ARM_TBFLAG_FPEXC_EL(tb->flags);
+    dc->fp_excp_el =3D ARM_TBFLAG_FPEXC_EL(db->tb->flags);
     dc->vec_len =3D 0;
     dc->vec_stride =3D 0;
-    dc->cp_regs =3D cpu->cp_regs;
+    dc->cp_regs =3D arm_cpu->cp_regs;
     dc->features =3D env->features;
=20
     /* Single step state. The code-generation logic here is:
@@ -11260,12 +11251,30 @@ void gen_intermediate_code_a64(DisasContextBase=
 *db, ARMCPU *cpu,
      *   emit code to generate a software step exception
      *   end the TB
      */
-    dc->ss_active =3D ARM_TBFLAG_SS_ACTIVE(tb->flags);
-    dc->pstate_ss =3D ARM_TBFLAG_PSTATE_SS(tb->flags);
+    dc->ss_active =3D ARM_TBFLAG_SS_ACTIVE(db->tb->flags);
+    dc->pstate_ss =3D ARM_TBFLAG_PSTATE_SS(db->tb->flags);
     dc->is_ldex =3D false;
     dc->ss_same_el =3D (arm_debug_target_el(env) =3D=3D dc->current_el);
=20
     init_tmp_a64_array(dc);
+}
+
+void gen_intermediate_code_a64(DisasContextBase *db, ARMCPU *cpu,
+                               TranslationBlock *tb)
+{
+    CPUState *cs =3D CPU(cpu);
+    CPUARMState *env =3D &cpu->env;
+    DisasContext *dc =3D container_of(db, DisasContext, base);
+    target_ulong next_page_start;
+    int max_insns;
+
+    db->tb =3D tb;
+    db->pc_first =3D tb->pc;
+    db->pc_next =3D db->pc_first;
+    db->is_jmp =3D DISAS_NEXT;
+    db->num_insns =3D 0;
+    db->singlestep_enabled =3D cs->singlestep_enabled;
+    aarch64_trblock_init_disas_context(db, cs);
=20
     next_page_start =3D (db->pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_=
SIZE;
     max_insns =3D tb->cflags & CF_COUNT_MASK;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 19d042d843..c469bc70ac 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11823,33 +11823,11 @@ static bool insn_crosses_page(CPUARMState *env,=
 DisasContext *s)
     return false;
 }
=20
-/* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
+static void arm_trblock_init_disas_context(DisasContextBase *db, CPUStat=
e *cpu)
 {
+    DisasContext *dc =3D container_of(db, DisasContext, base);
     CPUARMState *env =3D cpu->env_ptr;
     ARMCPU *arm_cpu =3D arm_env_get_cpu(env);
-    DisasContext dc1, *dc =3D &dc1;
-    DisasContextBase *db =3D &dc->base;
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
-        gen_intermediate_code_a64(db, arm_cpu, tb);
-        return;
-    }
-
-    db->tb =3D tb;
-    db->pc_first =3D tb->pc;
-    db->pc_next =3D db->pc_first;
-    db->is_jmp =3D DJ_NEXT;
-    db->num_insns =3D 0;
-    db->singlestep_enabled =3D cpu->singlestep_enabled;
=20
     dc->pc =3D db->pc_first;
     dc->condjmp =3D 0;
@@ -11860,23 +11838,23 @@ void gen_intermediate_code(CPUState *cpu, Trans=
lationBlock *tb)
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
+    dc->thumb =3D ARM_TBFLAG_THUMB(db->tb->flags);
+    dc->sctlr_b =3D ARM_TBFLAG_SCTLR_B(db->tb->flags);
+    dc->be_data =3D ARM_TBFLAG_BE_DATA(db->tb->flags) ? MO_BE : MO_LE;
+    dc->condexec_mask =3D (ARM_TBFLAG_CONDEXEC(db->tb->flags) & 0xf) << =
1;
+    dc->condexec_cond =3D ARM_TBFLAG_CONDEXEC(db->tb->flags) >> 4;
+    dc->mmu_idx =3D core_to_arm_mmu_idx(env, ARM_TBFLAG_MMUIDX(db->tb->f=
lags));
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
+    dc->ns =3D ARM_TBFLAG_NS(db->tb->flags);
+    dc->fp_excp_el =3D ARM_TBFLAG_FPEXC_EL(db->tb->flags);
+    dc->vfp_enabled =3D ARM_TBFLAG_VFPEN(db->tb->flags);
+    dc->vec_len =3D ARM_TBFLAG_VECLEN(db->tb->flags);
+    dc->vec_stride =3D ARM_TBFLAG_VECSTRIDE(db->tb->flags);
+    dc->c15_cpar =3D ARM_TBFLAG_XSCALE_CPAR(db->tb->flags);
+    dc->v7m_handler_mode =3D ARM_TBFLAG_HANDLER(db->tb->flags);
     dc->cp_regs =3D arm_cpu->cp_regs;
     dc->features =3D env->features;
=20
@@ -11895,10 +11873,41 @@ void gen_intermediate_code(CPUState *cpu, Trans=
lationBlock *tb)
      *   emit code to generate a software step exception
      *   end the TB
      */
-    dc->ss_active =3D ARM_TBFLAG_SS_ACTIVE(tb->flags);
-    dc->pstate_ss =3D ARM_TBFLAG_PSTATE_SS(tb->flags);
+    dc->ss_active =3D ARM_TBFLAG_SS_ACTIVE(db->tb->flags);
+    dc->pstate_ss =3D ARM_TBFLAG_PSTATE_SS(db->tb->flags);
     dc->is_ldex =3D false;
     dc->ss_same_el =3D false; /* Can't be true since EL_d must be AArch6=
4 */
+}
+
+/* generate intermediate code for basic block 'tb'.  */
+void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
+{
+    CPUARMState *env =3D cpu->env_ptr;
+    ARMCPU *arm_cpu =3D arm_env_get_cpu(env);
+    DisasContext dc1, *dc =3D &dc1;
+    DisasContextBase *db =3D &dc->base;
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
+        gen_intermediate_code_a64(db, arm_cpu, tb);
+        return;
+    }
+
+    db->tb =3D tb;
+    db->pc_first =3D tb->pc;
+    db->pc_next =3D db->pc_first;
+    db->is_jmp =3D DISAS_NEXT;
+    db->num_insns =3D 0;
+    db->singlestep_enabled =3D cpu->singlestep_enabled;
+    arm_trblock_init_disas_context(db, cpu);
+
=20
     cpu_F0s =3D tcg_temp_new_i32();
     cpu_F1s =3D tcg_temp_new_i32();
