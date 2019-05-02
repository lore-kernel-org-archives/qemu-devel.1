Received: from eggs.gnu.org ([209.51.188.92]:34557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hM8Fd-00079y-13
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hM8FY-0003eZ-BY
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:43:35 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:35167)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hM8FV-0003Kg-TW
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:43:30 -0400
Received: by mail-wr1-x430.google.com with SMTP id f7so2415082wrs.2
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 02:42:37 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	s18sm6484964wmc.41.2019.05.02.02.42.35 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 02:42:35 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 934BA1FF87
	for <qemu-devel@nongnu.org>; Thu,  2 May 2019 10:42:35 +0100 (BST)
References: <20190501050536.15580-1-richard.henderson@linaro.org>
	<20190501050536.15580-10-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190501050536.15580-10-richard.henderson@linaro.org>
Date: Thu, 02 May 2019 10:42:35 +0100
Message-ID: <87imut5h10.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 09/29] tcg: Manually expand
 INDEX_op_dup_vec
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> This case is similar to INDEX_op_mov_* in that we need to do
> different things depending on the current location of the source.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
<snip>
>
> +static void tcg_reg_alloc_dup(TCGContext *s, const TCGOp *op)
> +{
> +    const TCGLifeData arg_life =3D op->life;
> +    TCGRegSet dup_out_regs, dup_in_regs;
> +    TCGTemp *its, *ots;
> +    TCGType itype, vtype;
> +    unsigned vece;
> +    bool ok;
> +
> +    ots =3D arg_temp(op->args[0]);
> +    its =3D arg_temp(op->args[1]);
> +
> +    /* There should be no fixed vector registers.  */
> +    tcg_debug_assert(!ots->fixed_reg);

This threw me slightly. I guess you only really duplicate vectors so I'm
wondering if this should be called tcg_vec_reg_alloc_dup? Or maybe just
a bit of verbiage in a block comment above the helper?

> +
> +    itype =3D its->type;
> +    vece =3D TCGOP_VECE(op);
> +    vtype =3D TCGOP_VECL(op) + TCG_TYPE_V64;
> +
> +    if (its->val_type =3D=3D TEMP_VAL_CONST) {
> +        /* Propagate constant via movi -> dupi.  */
> +        tcg_target_ulong val =3D its->val;
> +        if (IS_DEAD_ARG(1)) {
> +            temp_dead(s, its);
> +        }
> +        tcg_reg_alloc_do_movi(s, ots, val, arg_life, op->output_pref[0]);
> +        return;
> +    }
> +
> +    dup_out_regs =3D tcg_op_defs[INDEX_op_dup_vec].args_ct[0].u.regs;
> +    dup_in_regs =3D tcg_op_defs[INDEX_op_dup_vec].args_ct[1].u.regs;
> +
> +    /* Allocate the output register now.  */
> +    if (ots->val_type !=3D TEMP_VAL_REG) {
> +        TCGRegSet allocated_regs =3D s->reserved_regs;
> +
> +        if (!IS_DEAD_ARG(1) && its->val_type =3D=3D TEMP_VAL_REG) {
> +            /* Make sure to not spill the input register. */
> +            tcg_regset_set_reg(allocated_regs, its->reg);
> +        }
> +        ots->reg =3D tcg_reg_alloc(s, dup_out_regs, allocated_regs,
> +                                 op->output_pref[0], ots->indirect_base);
> +        ots->val_type =3D TEMP_VAL_REG;
> +        ots->mem_coherent =3D 0;
> +        s->reg_to_temp[ots->reg] =3D ots;
> +    }
> +
> +    switch (its->val_type) {
> +    case TEMP_VAL_REG:
> +        /*
> +         * The dup constriaints must be broad, covering all possible VEC=
E.
> +         * However, tcg_op_dup_vec() gets to see the VECE and we allow it
> +         * to fail, indicating that extra moves are required for that ca=
se.
> +         */
> +        if (tcg_regset_test_reg(dup_in_regs, its->reg)) {
> +            if (tcg_out_dup_vec(s, vtype, vece, ots->reg, its->reg)) {
> +                goto done;
> +            }
> +            /* Try again from memory or a vector input register.  */
> +        }
> +        if (!its->mem_coherent) {
> +            /*
> +             * The input register is not synced, and so an extra store
> +             * would be required to use memory.  Attempt an integer-vect=
or
> +             * register move first.  We do not have a TCGRegSet for this.
> +             */
> +            if (tcg_out_mov(s, itype, ots->reg, its->reg)) {
> +                break;
> +            }
> +            /* Sync the temp back to its slot and load from there.  */
> +            temp_sync(s, its, s->reserved_regs, 0, 0);
> +        }
> +        /* fall through */
> +
> +    case TEMP_VAL_MEM:
> +        /* TODO: dup from memory */
> +        tcg_out_ld(s, itype, ots->reg, its->mem_base->reg,
> its->mem_offset);

Should we be aborting here? That said it looks like you are loading
something directly from the register memory address here...

> +        break;
> +
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    /* We now have a vector input register, so dup must succeed. */
> +    ok =3D tcg_out_dup_vec(s, vtype, vece, ots->reg, ots->reg);
> +    tcg_debug_assert(ok);
> +
> + done:
> +    if (IS_DEAD_ARG(1)) {
> +        temp_dead(s, its);
> +    }
> +    if (NEED_SYNC_ARG(0)) {
> +        temp_sync(s, ots, s->reserved_regs, 0, 0);
> +    }
> +    if (IS_DEAD_ARG(0)) {
> +        temp_dead(s, ots);
> +    }
> +}
> +
>  static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>  {
>      const TCGLifeData arg_life =3D op->life;
> @@ -3981,6 +4080,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *t=
b)
>          case INDEX_op_dupi_vec:
>              tcg_reg_alloc_movi(s, op);
>              break;
> +        case INDEX_op_dup_vec:
> +            tcg_reg_alloc_dup(s, op);
> +            break;
>          case INDEX_op_insn_start:
>              if (num_insns >=3D 0) {
>                  size_t off =3D tcg_current_code_size(s);


--
Alex Benn=C3=A9e
