Received: from eggs.gnu.org ([209.51.188.92]:37587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hIqPM-0000s7-Qn
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hIqPL-0002yO-BQ
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:04:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1hIqPL-0002yB-3A
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:04:03 -0400
References: <20190420073442.7488-1-richard.henderson@linaro.org>
	<20190420073442.7488-3-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <834f5c7b-c6b5-87b8-2154-3a3875726343@redhat.com>
Date: Tue, 23 Apr 2019 10:03:59 +0200
MIME-Version: 1.0
In-Reply-To: <20190420073442.7488-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/38] tcg: Assert fixed_reg is read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 20.04.19 09:34, Richard Henderson wrote:
> The only fixed_reg is cpu_env, and it should not be modified
> during any TB.  Therefore code that tries to special-case moves
> into a fixed_reg is dead.  Remove it.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg.c | 85 +++++++++++++++++++++++++------------------------------
>  1 file changed, 38 insertions(+), 47 deletions(-)
> 
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index ade6050982..4f77a957b0 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -3279,11 +3279,8 @@ static void tcg_reg_alloc_do_movi(TCGContext *s, TCGTemp *ots,
>                                    tcg_target_ulong val, TCGLifeData arg_life,
>                                    TCGRegSet preferred_regs)
>  {
> -    if (ots->fixed_reg) {
> -        /* For fixed registers, we do not do any constant propagation.  */
> -        tcg_out_movi(s, ots->type, ots->reg, val);
> -        return;
> -    }
> +    /* ENV should not be modified.  */
> +    tcg_debug_assert(!ots->fixed_reg);
>  
>      /* The movi is not explicitly generated here.  */
>      if (ots->val_type == TEMP_VAL_REG) {
> @@ -3319,6 +3316,9 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
>      ots = arg_temp(op->args[0]);
>      ts = arg_temp(op->args[1]);
>  
> +    /* ENV should not be modified.  */
> +    tcg_debug_assert(!ots->fixed_reg);
> +
>      /* Note that otype != itype for no-op truncation.  */
>      otype = ots->type;
>      itype = ts->type;
> @@ -3343,7 +3343,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
>      }
>  
>      tcg_debug_assert(ts->val_type == TEMP_VAL_REG);
> -    if (IS_DEAD_ARG(0) && !ots->fixed_reg) {
> +    if (IS_DEAD_ARG(0)) {
>          /* mov to a non-saved dead register makes no sense (even with
>             liveness analysis disabled). */
>          tcg_debug_assert(NEED_SYNC_ARG(0));
> @@ -3356,7 +3356,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
>          }
>          temp_dead(s, ots);
>      } else {
> -        if (IS_DEAD_ARG(1) && !ts->fixed_reg && !ots->fixed_reg) {
> +        if (IS_DEAD_ARG(1) && !ts->fixed_reg) {
>              /* the mov can be suppressed */
>              if (ots->val_type == TEMP_VAL_REG) {
>                  s->reg_to_temp[ots->reg] = NULL;
> @@ -3509,6 +3509,10 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>              arg = op->args[i];
>              arg_ct = &def->args_ct[i];
>              ts = arg_temp(arg);
> +
> +            /* ENV should not be modified.  */
> +            tcg_debug_assert(!ts->fixed_reg);
> +
>              if ((arg_ct->ct & TCG_CT_ALIAS)
>                  && !const_args[arg_ct->alias_index]) {
>                  reg = new_args[arg_ct->alias_index];
> @@ -3517,29 +3521,19 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>                                      i_allocated_regs | o_allocated_regs,
>                                      op->output_pref[k], ts->indirect_base);
>              } else {
> -                /* if fixed register, we try to use it */
> -                reg = ts->reg;
> -                if (ts->fixed_reg &&
> -                    tcg_regset_test_reg(arg_ct->u.regs, reg)) {
> -                    goto oarg_end;
> -                }
>                  reg = tcg_reg_alloc(s, arg_ct->u.regs, o_allocated_regs,
>                                      op->output_pref[k], ts->indirect_base);
>              }
>              tcg_regset_set_reg(o_allocated_regs, reg);
> -            /* if a fixed register is used, then a move will be done afterwards */
> -            if (!ts->fixed_reg) {
> -                if (ts->val_type == TEMP_VAL_REG) {
> -                    s->reg_to_temp[ts->reg] = NULL;
> -                }
> -                ts->val_type = TEMP_VAL_REG;
> -                ts->reg = reg;
> -                /* temp value is modified, so the value kept in memory is
> -                   potentially not the same */
> -                ts->mem_coherent = 0;
> -                s->reg_to_temp[reg] = ts;
> +            if (ts->val_type == TEMP_VAL_REG) {
> +                s->reg_to_temp[ts->reg] = NULL;
>              }
> -        oarg_end:
> +            ts->val_type = TEMP_VAL_REG;
> +            ts->reg = reg;
> +            /* temp value is modified, so the value kept in memory is
> +               potentially not the same */
> +            ts->mem_coherent = 0;
> +            s->reg_to_temp[reg] = ts;
>              new_args[i] = reg;
>          }
>      }
> @@ -3555,10 +3549,10 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>      /* move the outputs in the correct register if needed */
>      for(i = 0; i < nb_oargs; i++) {
>          ts = arg_temp(op->args[i]);
> -        reg = new_args[i];
> -        if (ts->fixed_reg && ts->reg != reg) {
> -            tcg_out_mov(s, ts->type, ts->reg, reg);
> -        }
> +
> +        /* ENV should not be modified.  */
> +        tcg_debug_assert(!ts->fixed_reg);
> +
>          if (NEED_SYNC_ARG(i)) {
>              temp_sync(s, ts, o_allocated_regs, 0, IS_DEAD_ARG(i));
>          } else if (IS_DEAD_ARG(i)) {
> @@ -3679,26 +3673,23 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
>      for(i = 0; i < nb_oargs; i++) {
>          arg = op->args[i];
>          ts = arg_temp(arg);
> +
> +        /* ENV should not be modified.  */
> +        tcg_debug_assert(!ts->fixed_reg);
> +
>          reg = tcg_target_call_oarg_regs[i];
>          tcg_debug_assert(s->reg_to_temp[reg] == NULL);
> -
> -        if (ts->fixed_reg) {
> -            if (ts->reg != reg) {
> -                tcg_out_mov(s, ts->type, ts->reg, reg);
> -            }
> -        } else {
> -            if (ts->val_type == TEMP_VAL_REG) {
> -                s->reg_to_temp[ts->reg] = NULL;
> -            }
> -            ts->val_type = TEMP_VAL_REG;
> -            ts->reg = reg;
> -            ts->mem_coherent = 0;
> -            s->reg_to_temp[reg] = ts;
> -            if (NEED_SYNC_ARG(i)) {
> -                temp_sync(s, ts, allocated_regs, 0, IS_DEAD_ARG(i));
> -            } else if (IS_DEAD_ARG(i)) {
> -                temp_dead(s, ts);
> -            }
> +        if (ts->val_type == TEMP_VAL_REG) {
> +            s->reg_to_temp[ts->reg] = NULL;
> +        }
> +        ts->val_type = TEMP_VAL_REG;
> +        ts->reg = reg;
> +        ts->mem_coherent = 0;
> +        s->reg_to_temp[reg] = ts;
> +        if (NEED_SYNC_ARG(i)) {
> +            temp_sync(s, ts, allocated_regs, 0, IS_DEAD_ARG(i));
> +        } else if (IS_DEAD_ARG(i)) {
> +            temp_dead(s, ts);
>          }
>      }
>  }
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
