Received: from eggs.gnu.org ([2001:4830:134:3::10]:39444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVDvK-0006L8-MW
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVDvI-0003zM-W5
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:27:10 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:33395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dVDvI-0003yt-MO
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:27:08 -0400
Received: by mail-wr0-x230.google.com with SMTP id r103so25341551wrb.0
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 02:27:08 -0700 (PDT)
References: <149942760788.8972.474351671751194003.stgit@frigg.lan>
	<149943106604.8972.10208441394697288474.stgit@frigg.lan>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <149943106604.8972.10208441394697288474.stgit@frigg.lan>
Date: Wed, 12 Jul 2017 10:27:06 +0100
Message-ID: <8737a29f9x.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v12 14/27] target/arm: [tcg] Port to
 init_disas_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>


Lluís Vilanova <vilanova@ac.upc.edu> writes:

> Incrementally paves the way towards using the generic instruction translation
> loop.
>
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> Reviewed-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  target/arm/translate.c |   86 +++++++++++++++++++++++++++---------------------
>  1 file changed, 48 insertions(+), 38 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 15b4fcb417..0179b1ce79 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -11786,32 +11786,12 @@ static bool insn_crosses_page(CPUARMState *env, DisasContext *s)
>      return false;
>  }
>
> -/* generate intermediate code for basic block 'tb'.  */
> -void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
> +static void arm_tr_init_disas_context(DisasContextBase *dcbase,
> +                                           CPUState *cs)
>  {
> +    DisasContext *dc = container_of(dcbase, DisasContext, base);
>      CPUARMState *env = cs->env_ptr;
>      ARMCPU *cpu = arm_env_get_cpu(env);
> -    DisasContext dc1, *dc = &dc1;
> -    target_ulong next_page_start;
> -    int max_insns;
> -    bool end_of_page;
> -
> -    /* generate intermediate code */
> -
> -    /* The A64 decoder has its own top level loop, because it doesn't need
> -     * the A32/T32 complexity to do with conditional execution/IT blocks/etc.
> -     */
> -    if (ARM_TBFLAG_AARCH64_STATE(tb->flags)) {
> -        gen_intermediate_code_a64(&dc->base, cs, tb);
> -        return;
> -    }
> -
> -    dc->base.tb = tb;
> -    dc->base.pc_first = tb->pc;
> -    dc->base.pc_next = dc->base.pc_first;
> -    dc->base.is_jmp = DISAS_NEXT;
> -    dc->base.num_insns = 0;
> -    dc->base.singlestep_enabled = cs->singlestep_enabled;
>
>      dc->pc = dc->base.pc_first;
>      dc->condjmp = 0;
> @@ -11822,23 +11802,23 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
>       */
>      dc->secure_routed_to_el3 = arm_feature(env, ARM_FEATURE_EL3) &&
>                                 !arm_el_is_aa64(env, 3);
> -    dc->thumb = ARM_TBFLAG_THUMB(tb->flags);
> -    dc->sctlr_b = ARM_TBFLAG_SCTLR_B(tb->flags);
> -    dc->be_data = ARM_TBFLAG_BE_DATA(tb->flags) ? MO_BE : MO_LE;
> -    dc->condexec_mask = (ARM_TBFLAG_CONDEXEC(tb->flags) & 0xf) << 1;
> -    dc->condexec_cond = ARM_TBFLAG_CONDEXEC(tb->flags) >> 4;
> -    dc->mmu_idx = core_to_arm_mmu_idx(env, ARM_TBFLAG_MMUIDX(tb->flags));
> +    dc->thumb = ARM_TBFLAG_THUMB(dc->base.tb->flags);
> +    dc->sctlr_b = ARM_TBFLAG_SCTLR_B(dc->base.tb->flags);
> +    dc->be_data = ARM_TBFLAG_BE_DATA(dc->base.tb->flags) ? MO_BE : MO_LE;
> +    dc->condexec_mask = (ARM_TBFLAG_CONDEXEC(dc->base.tb->flags) & 0xf) << 1;
> +    dc->condexec_cond = ARM_TBFLAG_CONDEXEC(dc->base.tb->flags) >> 4;
> +    dc->mmu_idx = core_to_arm_mmu_idx(env, ARM_TBFLAG_MMUIDX(dc->base.tb->flags));
>      dc->current_el = arm_mmu_idx_to_el(dc->mmu_idx);
>  #if !defined(CONFIG_USER_ONLY)
>      dc->user = (dc->current_el == 0);
>  #endif
> -    dc->ns = ARM_TBFLAG_NS(tb->flags);
> -    dc->fp_excp_el = ARM_TBFLAG_FPEXC_EL(tb->flags);
> -    dc->vfp_enabled = ARM_TBFLAG_VFPEN(tb->flags);
> -    dc->vec_len = ARM_TBFLAG_VECLEN(tb->flags);
> -    dc->vec_stride = ARM_TBFLAG_VECSTRIDE(tb->flags);
> -    dc->c15_cpar = ARM_TBFLAG_XSCALE_CPAR(tb->flags);
> -    dc->v7m_handler_mode = ARM_TBFLAG_HANDLER(tb->flags);
> +    dc->ns = ARM_TBFLAG_NS(dc->base.tb->flags);
> +    dc->fp_excp_el = ARM_TBFLAG_FPEXC_EL(dc->base.tb->flags);
> +    dc->vfp_enabled = ARM_TBFLAG_VFPEN(dc->base.tb->flags);
> +    dc->vec_len = ARM_TBFLAG_VECLEN(dc->base.tb->flags);
> +    dc->vec_stride = ARM_TBFLAG_VECSTRIDE(dc->base.tb->flags);
> +    dc->c15_cpar = ARM_TBFLAG_XSCALE_CPAR(dc->base.tb->flags);
> +    dc->v7m_handler_mode = ARM_TBFLAG_HANDLER(dc->base.tb->flags);
>      dc->cp_regs = cpu->cp_regs;
>      dc->features = env->features;
>
> @@ -11857,11 +11837,12 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
>       *   emit code to generate a software step exception
>       *   end the TB
>       */
> -    dc->ss_active = ARM_TBFLAG_SS_ACTIVE(tb->flags);
> -    dc->pstate_ss = ARM_TBFLAG_PSTATE_SS(tb->flags);
> +    dc->ss_active = ARM_TBFLAG_SS_ACTIVE(dc->base.tb->flags);
> +    dc->pstate_ss = ARM_TBFLAG_PSTATE_SS(dc->base.tb->flags);
>      dc->is_ldex = false;
>      dc->ss_same_el = false; /* Can't be true since EL_d must be AArch64 */
>
> +
>      cpu_F0s = tcg_temp_new_i32();
>      cpu_F1s = tcg_temp_new_i32();
>      cpu_F0d = tcg_temp_new_i64();
> @@ -11870,6 +11851,35 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
>      cpu_V1 = cpu_F1d;
>      /* FIXME: cpu_M0 can probably be the same as cpu_V0.  */
>      cpu_M0 = tcg_temp_new_i64();
> +}
> +
> +/* generate intermediate code for basic block 'tb'.  */
> +void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
> +{
> +    CPUARMState *env = cs->env_ptr;
> +    DisasContext dc1, *dc = &dc1;
> +    target_ulong next_page_start;
> +    int max_insns;
> +    bool end_of_page;
> +
> +    /* generate intermediate code */
> +
> +    /* The A64 decoder has its own top level loop, because it doesn't need
> +     * the A32/T32 complexity to do with conditional execution/IT blocks/etc.
> +     */
> +    if (ARM_TBFLAG_AARCH64_STATE(tb->flags)) {
> +        gen_intermediate_code_a64(&dc->base, cs, tb);
> +        return;
> +    }
> +
> +    dc->base.tb = tb;
> +    dc->base.pc_first = dc->base.tb->pc;
> +    dc->base.pc_next = dc->base.pc_first;
> +    dc->base.is_jmp = DISAS_NEXT;
> +    dc->base.num_insns = 0;
> +    dc->base.singlestep_enabled = cs->singlestep_enabled;
> +    arm_tr_init_disas_context(&dc->base, cs);
> +
>      next_page_start = (dc->base.pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
>      max_insns = tb->cflags & CF_COUNT_MASK;
>      if (max_insns == 0) {


--
Alex Bennée
