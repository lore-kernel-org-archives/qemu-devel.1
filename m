Received: from eggs.gnu.org ([2001:4830:134:3::10]:56667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fPmtV-0005GJ-Ay
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:39:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fPmtQ-0004gp-3F
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:39:21 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:55365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fPmtP-0004gF-OV
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:39:16 -0400
Received: by mail-wm0-x22e.google.com with SMTP id v16-v6so8084650wmh.5
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 03:39:15 -0700 (PDT)
References: <20180602002203.19725-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180602002203.19725-1-richard.henderson@linaro.org>
Date: Mon, 04 Jun 2018 11:39:12 +0100
Message-ID: <87o9gqdeen.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/sh4: Fix translator.c assertion
 failure for gUSA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth7680@gmail.com>
Cc: qemu-devel@nongnu.org, aurelien@aurel32.net


Richard Henderson <rth7680@gmail.com> writes:

> The translator loop does not allow the tb_start hook to set
> dc->base.is_jmp; the only hook allowed to do that is translate_insn.
>
> Split the work between init_disas_context where we validate
> the gUSA parameters, and translate_insn where we emit code.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>
> This fixes the threadtest failure on Alex's check-tcg branch.
>
>
> r~
>
> ---
>  target/sh4/translate.c | 81 +++++++++++++++++++++++-------------------
>  1 file changed, 44 insertions(+), 37 deletions(-)
>
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index 58bdfeb4fb..5295d9cb0d 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -1895,35 +1895,18 @@ static void decode_opc(DisasContext * ctx)
>     any sequence via cpu_exec_step_atomic, we can recognize the "normal"
>     sequences and transform them into atomic operations as seen by the ho=
st.
>  */
> -static int decode_gusa(DisasContext *ctx, CPUSH4State *env, int *pmax_in=
sns)
> +static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
>  {
>      uint16_t insns[5];
>      int ld_adr, ld_dst, ld_mop;
>      int op_dst, op_src, op_opc;
>      int mv_src, mt_dst, st_src, st_mop;
>      TCGv op_arg;
> -
>      uint32_t pc =3D ctx->base.pc_next;
>      uint32_t pc_end =3D ctx->base.tb->cs_base;
> -    int backup =3D sextract32(ctx->tbflags, GUSA_SHIFT, 8);
>      int max_insns =3D (pc_end - pc) / 2;
>      int i;
>
> -    if (pc !=3D pc_end + backup || max_insns < 2) {
> -        /* This is a malformed gUSA region.  Don't do anything special,
> -           since the interpreter is likely to get confused.  */
> -        ctx->envflags &=3D ~GUSA_MASK;
> -        return 0;
> -    }
> -
> -    if (ctx->tbflags & GUSA_EXCLUSIVE) {
> -        /* Regardless of single-stepping or the end of the page,
> -           we must complete execution of the gUSA region while
> -           holding the exclusive lock.  */
> -        *pmax_insns =3D max_insns;
> -        return 0;
> -    }
> -
>      /* The state machine below will consume only a few insns.
>         If there are more than that in a region, fail now.  */
>      if (max_insns > ARRAY_SIZE(insns)) {
> @@ -2140,7 +2123,6 @@ static int decode_gusa(DisasContext *ctx, CPUSH4Sta=
te *env, int *pmax_insns)
>      /*
>       * Emit the operation.
>       */
> -    tcg_gen_insn_start(pc, ctx->envflags);
>      switch (op_opc) {
>      case -1:
>          /* No operation found.  Look for exchange pattern.  */
> @@ -2235,7 +2217,8 @@ static int decode_gusa(DisasContext *ctx, CPUSH4Sta=
te *env, int *pmax_insns)
>      /* The entire region has been translated.  */
>      ctx->envflags &=3D ~GUSA_MASK;
>      ctx->base.pc_next =3D pc_end;
> -    return max_insns;
> +    ctx->base.num_insns +=3D max_insns - 1;
> +    return;
>
>   fail:
>      qemu_log_mask(LOG_UNIMP, "Unrecognized gUSA sequence %08x-%08x\n",
> @@ -2243,7 +2226,6 @@ static int decode_gusa(DisasContext *ctx, CPUSH4Sta=
te *env, int *pmax_insns)
>
>      /* Restart with the EXCLUSIVE bit set, within a TB run via
>         cpu_exec_step_atomic holding the exclusive lock.  */
> -    tcg_gen_insn_start(pc, ctx->envflags);
>      ctx->envflags |=3D GUSA_EXCLUSIVE;
>      gen_save_cpu_state(ctx, false);
>      gen_helper_exclusive(cpu_env);
> @@ -2254,7 +2236,7 @@ static int decode_gusa(DisasContext *ctx, CPUSH4Sta=
te *env, int *pmax_insns)
>         entire region consumed via ctx->base.pc_next so that it's immedia=
tely
>         available in the disassembly dump.  */
>      ctx->base.pc_next =3D pc_end;
> -    return 1;
> +    ctx->base.num_insns +=3D max_insns - 1;
>  }
>  #endif
>
> @@ -2262,19 +2244,39 @@ static void sh4_tr_init_disas_context(DisasContex=
tBase *dcbase, CPUState *cs)
>  {
>      DisasContext *ctx =3D container_of(dcbase, DisasContext, base);
>      CPUSH4State *env =3D cs->env_ptr;
> +    uint32_t tbflags;
>      int bound;
>
> -    ctx->tbflags =3D (uint32_t)ctx->base.tb->flags;
> -    ctx->envflags =3D ctx->base.tb->flags & TB_FLAG_ENVFLAGS_MASK;
> -    ctx->memidx =3D (ctx->tbflags & (1u << SR_MD)) =3D=3D 0 ? 1 : 0;
> +    ctx->tbflags =3D tbflags =3D ctx->base.tb->flags;
> +    ctx->envflags =3D tbflags & TB_FLAG_ENVFLAGS_MASK;
> +    ctx->memidx =3D (tbflags & (1u << SR_MD)) =3D=3D 0 ? 1 : 0;
>      /* We don't know if the delayed pc came from a dynamic or static bra=
nch,
>         so assume it is a dynamic branch.  */
>      ctx->delayed_pc =3D -1; /* use delayed pc from env pointer */
>      ctx->features =3D env->features;
> -    ctx->has_movcal =3D (ctx->tbflags & TB_FLAG_PENDING_MOVCA);
> -    ctx->gbank =3D ((ctx->tbflags & (1 << SR_MD)) &&
> -                  (ctx->tbflags & (1 << SR_RB))) * 0x10;
> -    ctx->fbank =3D ctx->tbflags & FPSCR_FR ? 0x10 : 0;
> +    ctx->has_movcal =3D (tbflags & TB_FLAG_PENDING_MOVCA);
> +    ctx->gbank =3D ((tbflags & (1 << SR_MD)) &&
> +                  (tbflags & (1 << SR_RB))) * 0x10;
> +    ctx->fbank =3D tbflags & FPSCR_FR ? 0x10 : 0;
> +
> +    if (tbflags & GUSA_MASK) {
> +        uint32_t pc =3D ctx->base.pc_next;
> +        uint32_t pc_end =3D ctx->base.tb->cs_base;
> +        int backup =3D sextract32(ctx->tbflags, GUSA_SHIFT, 8);
> +        int max_insns =3D (pc_end - pc) / 2;
> +
> +        if (pc !=3D pc_end + backup || max_insns < 2) {
> +            /* This is a malformed gUSA region.  Don't do anything speci=
al,
> +               since the interpreter is likely to get confused.  */
> +            ctx->envflags &=3D ~GUSA_MASK;
> +        } else if (tbflags & GUSA_EXCLUSIVE) {
> +            /* Regardless of single-stepping or the end of the page,
> +               we must complete execution of the gUSA region while
> +               holding the exclusive lock.  */
> +            ctx->base.max_insns =3D max_insns;
> +            return;
> +        }
> +    }
>
>      /* Since the ISA is fixed-width, we can bound by the number
>         of instructions remaining on the page.  */
> @@ -2284,14 +2286,6 @@ static void sh4_tr_init_disas_context(DisasContext=
Base *dcbase, CPUState *cs)
>
>  static void sh4_tr_tb_start(DisasContextBase *dcbase, CPUState *cs)
>  {
> -#ifdef CONFIG_USER_ONLY
> -    DisasContext *ctx =3D container_of(dcbase, DisasContext, base);
> -    CPUSH4State *env =3D cs->env_ptr;
> -
> -    if (ctx->tbflags & GUSA_MASK) {
> -        ctx->base.num_insns =3D decode_gusa(ctx, env, &ctx->base.max_ins=
ns);
> -    }
> -#endif
>  }
>
>  static void sh4_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
> @@ -2323,6 +2317,19 @@ static void sh4_tr_translate_insn(DisasContextBase=
 *dcbase, CPUState *cs)
>      CPUSH4State *env =3D cs->env_ptr;
>      DisasContext *ctx =3D container_of(dcbase, DisasContext, base);
>
> +#ifdef CONFIG_USER_ONLY
> +    if (unlikely(ctx->envflags & GUSA_MASK)
> +        && !(ctx->envflags & GUSA_EXCLUSIVE)) {
> +        /* We're in an gUSA region, and we have not already fallen
> +           back on using an exclusive region.  Attempt to parse the
> +           region into a single supported atomic operation.  Failure
> +           is handled within the parser by raising an exception to
> +           retry using an exclusive region.  */
> +        decode_gusa(ctx, env);
> +        return;
> +    }
> +#endif
> +
>      ctx->opcode =3D cpu_lduw_code(env, ctx->base.pc_next);
>      decode_opc(ctx);
>      ctx->base.pc_next +=3D 2;


--
Alex Benn=C3=A9e
