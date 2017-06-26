Received: from eggs.gnu.org ([2001:4830:134:3::10]:54407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dPVcJ-0004XW-TS
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 11:07:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dPVcF-0000bI-4I
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 11:07:55 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:38078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dPVcE-0000aR-PW
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 11:07:51 -0400
Received: by mail-wm0-x22c.google.com with SMTP id b184so342735wme.1
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 08:07:50 -0700 (PDT)
References: <20170621024831.26019-1-rth@twiddle.net>
	<20170621024831.26019-5-rth@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170621024831.26019-5-rth@twiddle.net>
Date: Mon, 26 Jun 2017 16:08:39 +0100
Message-ID: <874lv2yefc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 04/16] tcg: Propagate TCGOp down to
 allocators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, aurelien@aurel32.net


Richard Henderson <rth@twiddle.net> writes:

> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  tcg/tcg.c | 82 +++++++++++++++++++++++++++++++--------------------------------
>  1 file changed, 40 insertions(+), 42 deletions(-)
>
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index be5b69c..e2248a6 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -2111,25 +2111,24 @@ static void tcg_reg_alloc_do_movi(TCGContext *s, TCGTemp *ots,
>      }
>  }
>
> -static void tcg_reg_alloc_movi(TCGContext *s, const TCGArg *args,
> -                               TCGLifeData arg_life)
> +static void tcg_reg_alloc_movi(TCGContext *s, const TCGOp *op)
>  {
> -    TCGTemp *ots = &s->temps[args[0]];
> -    tcg_target_ulong val = args[1];
> +    TCGTemp *ots = &s->temps[op->args[0]];
> +    tcg_target_ulong val = op->args[1];
>
> -    tcg_reg_alloc_do_movi(s, ots, val, arg_life);
> +    tcg_reg_alloc_do_movi(s, ots, val, op->life);
>  }
>
> -static void tcg_reg_alloc_mov(TCGContext *s, const TCGOpDef *def,
> -                              const TCGArg *args, TCGLifeData arg_life)
> +static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
>  {
> +    const TCGLifeData arg_life = op->life;
>      TCGRegSet allocated_regs;
>      TCGTemp *ts, *ots;
>      TCGType otype, itype;
>
>      tcg_regset_set(allocated_regs, s->reserved_regs);
> -    ots = &s->temps[args[0]];
> -    ts = &s->temps[args[1]];
> +    ots = &s->temps[op->args[0]];
> +    ts = &s->temps[op->args[1]];
>
>      /* Note that otype != itype for no-op truncation.  */
>      otype = ots->type;
> @@ -2159,7 +2158,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOpDef *def,
>             liveness analysis disabled). */
>          tcg_debug_assert(NEED_SYNC_ARG(0));
>          if (!ots->mem_allocated) {
> -            temp_allocate_frame(s, args[0]);
> +            temp_allocate_frame(s, op->args[0]);
>          }
>          tcg_out_st(s, otype, ts->reg, ots->mem_base->reg, ots->mem_offset);
>          if (IS_DEAD_ARG(1)) {
> @@ -2193,10 +2192,10 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOpDef *def,
>      }
>  }
>
> -static void tcg_reg_alloc_op(TCGContext *s,
> -                             const TCGOpDef *def, TCGOpcode opc,
> -                             const TCGArg *args, TCGLifeData arg_life)
> +static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>  {
> +    const TCGLifeData arg_life = op->life;
> +    const TCGOpDef * const def = &tcg_op_defs[op->opc];
>      TCGRegSet i_allocated_regs;
>      TCGRegSet o_allocated_regs;
>      int i, k, nb_iargs, nb_oargs;
> @@ -2207,21 +2206,24 @@ static void tcg_reg_alloc_op(TCGContext *s,
>      TCGArg new_args[TCG_MAX_OP_ARGS];
>      int const_args[TCG_MAX_OP_ARGS];
>
> +    /* Sanity check that we've not introduced any unhandled opcodes. */
> +    tcg_debug_assert(!(def->flags & TCG_OPF_NOT_PRESENT));
> +
>      nb_oargs = def->nb_oargs;
>      nb_iargs = def->nb_iargs;
>
>      /* copy constants */
>      memcpy(new_args + nb_oargs + nb_iargs,
> -           args + nb_oargs + nb_iargs,
> +           op->args + nb_oargs + nb_iargs,
>             sizeof(TCGArg) * def->nb_cargs);
>
>      tcg_regset_set(i_allocated_regs, s->reserved_regs);
>      tcg_regset_set(o_allocated_regs, s->reserved_regs);
>
>      /* satisfy input constraints */
> -    for(k = 0; k < nb_iargs; k++) {
> +    for (k = 0; k < nb_iargs; k++) {
>          i = def->sorted_args[nb_oargs + k];
> -        arg = args[i];
> +        arg = op->args[i];
>          arg_ct = &def->args_ct[i];
>          ts = &s->temps[arg];
>
> @@ -2239,7 +2241,7 @@ static void tcg_reg_alloc_op(TCGContext *s,
>              if (ts->fixed_reg) {
>                  /* if fixed register, we must allocate a new register
>                     if the alias is not the same register */
> -                if (arg != args[arg_ct->alias_index])
> +                if (arg != op->args[arg_ct->alias_index])
>                      goto allocate_in_reg;
>              } else {
>                  /* if the input is aliased to an output and if it is
> @@ -2280,7 +2282,7 @@ static void tcg_reg_alloc_op(TCGContext *s,
>      /* mark dead temporaries and free the associated registers */
>      for (i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
>          if (IS_DEAD_ARG(i)) {
> -            temp_dead(s, &s->temps[args[i]]);
> +            temp_dead(s, &s->temps[op->args[i]]);
>          }
>      }
>
> @@ -2304,7 +2306,7 @@ static void tcg_reg_alloc_op(TCGContext *s,
>          /* satisfy the output constraints */
>          for(k = 0; k < nb_oargs; k++) {
>              i = def->sorted_args[k];
> -            arg = args[i];
> +            arg = op->args[i];
>              arg_ct = &def->args_ct[i];
>              ts = &s->temps[arg];
>              if ((arg_ct->ct & TCG_CT_ALIAS)
> @@ -2343,11 +2345,11 @@ static void tcg_reg_alloc_op(TCGContext *s,
>      }
>
>      /* emit instruction */
> -    tcg_out_op(s, opc, new_args, const_args);
> +    tcg_out_op(s, op->opc, new_args, const_args);
>
>      /* move the outputs in the correct register if needed */
>      for(i = 0; i < nb_oargs; i++) {
> -        ts = &s->temps[args[i]];
> +        ts = &s->temps[op->args[i]];
>          reg = new_args[i];
>          if (ts->fixed_reg && ts->reg != reg) {
>              tcg_out_mov(s, ts->type, ts->reg, reg);
> @@ -2366,9 +2368,11 @@ static void tcg_reg_alloc_op(TCGContext *s,
>  #define STACK_DIR(x) (x)
>  #endif
>
> -static void tcg_reg_alloc_call(TCGContext *s, int nb_oargs, int nb_iargs,
> -                               const TCGArg * const args, TCGLifeData arg_life)
> +static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
>  {
> +    const int nb_oargs = op->callo;
> +    const int nb_iargs = op->calli;
> +    const TCGLifeData arg_life = op->life;
>      int flags, nb_regs, i;
>      TCGReg reg;
>      TCGArg arg;
> @@ -2379,8 +2383,8 @@ static void tcg_reg_alloc_call(TCGContext *s, int nb_oargs, int nb_iargs,
>      int allocate_args;
>      TCGRegSet allocated_regs;
>
> -    func_addr = (tcg_insn_unit *)(intptr_t)args[nb_oargs + nb_iargs];
> -    flags = args[nb_oargs + nb_iargs + 1];
> +    func_addr = (tcg_insn_unit *)(intptr_t)op->args[nb_oargs + nb_iargs];
> +    flags = op->args[nb_oargs + nb_iargs + 1];
>
>      nb_regs = ARRAY_SIZE(tcg_target_call_iarg_regs);
>      if (nb_regs > nb_iargs) {
> @@ -2399,8 +2403,8 @@ static void tcg_reg_alloc_call(TCGContext *s, int nb_oargs, int nb_iargs,
>      }
>
>      stack_offset = TCG_TARGET_CALL_STACK_OFFSET;
> -    for(i = nb_regs; i < nb_iargs; i++) {
> -        arg = args[nb_oargs + i];
> +    for (i = nb_regs; i < nb_iargs; i++) {
> +        arg = op->args[nb_oargs + i];
>  #ifdef TCG_TARGET_STACK_GROWSUP
>          stack_offset -= sizeof(tcg_target_long);
>  #endif
> @@ -2417,8 +2421,8 @@ static void tcg_reg_alloc_call(TCGContext *s, int nb_oargs, int nb_iargs,
>
>      /* assign input registers */
>      tcg_regset_set(allocated_regs, s->reserved_regs);
> -    for(i = 0; i < nb_regs; i++) {
> -        arg = args[nb_oargs + i];
> +    for (i = 0; i < nb_regs; i++) {
> +        arg = op->args[nb_oargs + i];
>          if (arg != TCG_CALL_DUMMY_ARG) {
>              ts = &s->temps[arg];
>              reg = tcg_target_call_iarg_regs[i];
> @@ -2441,9 +2445,9 @@ static void tcg_reg_alloc_call(TCGContext *s, int nb_oargs, int nb_iargs,
>      }
>
>      /* mark dead temporaries and free the associated registers */
> -    for(i = nb_oargs; i < nb_iargs + nb_oargs; i++) {
> +    for (i = nb_oargs; i < nb_iargs + nb_oargs; i++) {
>          if (IS_DEAD_ARG(i)) {
> -            temp_dead(s, &s->temps[args[i]]);
> +            temp_dead(s, &s->temps[op->args[i]]);
>          }
>      }
>
> @@ -2468,7 +2472,7 @@ static void tcg_reg_alloc_call(TCGContext *s, int nb_oargs, int nb_iargs,
>
>      /* assign output registers and emit moves if needed */
>      for(i = 0; i < nb_oargs; i++) {
> -        arg = args[i];
> +        arg = op->args[i];
>          ts = &s->temps[arg];
>          reg = tcg_target_call_oarg_regs[i];
>          tcg_debug_assert(s->reg_to_temp[reg] == NULL);
> @@ -2611,8 +2615,6 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
>      for (oi = s->gen_op_buf[0].next; oi != 0; oi = oi_next) {
>          TCGOp * const op = &s->gen_op_buf[oi];
>          TCGOpcode opc = op->opc;
> -        const TCGOpDef *def = &tcg_op_defs[opc];
> -        TCGLifeData arg_life = op->life;
>
>          oi_next = op->next;
>  #ifdef CONFIG_PROFILER
> @@ -2622,11 +2624,11 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
>          switch (opc) {
>          case INDEX_op_mov_i32:
>          case INDEX_op_mov_i64:
> -            tcg_reg_alloc_mov(s, def, op->args, arg_life);
> +            tcg_reg_alloc_mov(s, op);
>              break;
>          case INDEX_op_movi_i32:
>          case INDEX_op_movi_i64:
> -            tcg_reg_alloc_movi(s, op->args, arg_life);
> +            tcg_reg_alloc_movi(s, op);
>              break;
>          case INDEX_op_insn_start:
>              if (num_insns >= 0) {
> @@ -2651,17 +2653,13 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
>              tcg_out_label(s, arg_label(op->args[0]), s->code_ptr);
>              break;
>          case INDEX_op_call:
> -            tcg_reg_alloc_call(s, op->callo, op->calli, op->args, arg_life);
> +            tcg_reg_alloc_call(s, op);
>              break;
>          default:
> -            /* Sanity check that we've not introduced any unhandled opcodes. */
> -            if (def->flags & TCG_OPF_NOT_PRESENT) {
> -                tcg_abort();
> -            }
>              /* Note: in order to speed up the code, it would be much
>                 faster to have specialized register allocator functions for
>                 some common argument patterns */
> -            tcg_reg_alloc_op(s, def, opc, op->args, arg_life);
> +            tcg_reg_alloc_op(s, op);
>              break;
>          }
>  #ifdef CONFIG_DEBUG_TCG


--
Alex Bennée
