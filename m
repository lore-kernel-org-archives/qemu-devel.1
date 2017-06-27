Received: from eggs.gnu.org ([2001:4830:134:3::10]:49831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dPmJ1-00019l-Pm
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 04:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dPmIy-0006hm-Le
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 04:57:07 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:37171)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dPmIy-0006h4-AB
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 04:57:04 -0400
Received: by mail-wm0-x22c.google.com with SMTP id i127so19662262wma.0
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 01:57:04 -0700 (PDT)
References: <20170621024831.26019-1-rth@twiddle.net>
	<20170621024831.26019-10-rth@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170621024831.26019-10-rth@twiddle.net>
Date: Tue, 27 Jun 2017 09:57:53 +0100
Message-ID: <87vanhx0xa.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 09/16] tcg: Use per-temp state data in
 liveness
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

> This avoids having to allocate external memory for each temporary.
>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  tcg/tcg.c | 232 ++++++++++++++++++++++++++++++--------------------------------
>  tcg/tcg.h |   6 ++
>  2 files changed, 120 insertions(+), 118 deletions(-)
>
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 0d758e4..e78140b 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1399,42 +1399,54 @@ TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *old_op,
>
>  /* liveness analysis: end of function: all temps are dead, and globals
>     should be in memory. */
> -static inline void tcg_la_func_end(TCGContext *s, uint8_t *temp_state)
> +static void tcg_la_func_end(TCGContext *s)
>  {
> -    memset(temp_state, TS_DEAD | TS_MEM, s->nb_globals);
> -    memset(temp_state + s->nb_globals, TS_DEAD, s->nb_temps - s->nb_globals);
> +    int ng = s->nb_globals;
> +    int nt = s->nb_temps;
> +    int i;
> +
> +    for (i = 0; i < ng; ++i) {
> +        s->temps[i].state = TS_DEAD | TS_MEM;
> +    }
> +    for (i = ng; i < nt; ++i) {
> +        s->temps[i].state = TS_DEAD;
> +    }
>  }
>
>  /* liveness analysis: end of basic block: all temps are dead, globals
>     and local temps should be in memory. */
> -static inline void tcg_la_bb_end(TCGContext *s, uint8_t *temp_state)
> +static void tcg_la_bb_end(TCGContext *s)
>  {
> -    int i, n;
> +    int ng = s->nb_globals;
> +    int nt = s->nb_temps;
> +    int i;
>
> -    tcg_la_func_end(s, temp_state);
> -    for (i = s->nb_globals, n = s->nb_temps; i < n; i++) {
> -        if (s->temps[i].temp_local) {
> -            temp_state[i] |= TS_MEM;
> -        }
> +    for (i = 0; i < ng; ++i) {
> +        s->temps[i].state = TS_DEAD | TS_MEM;
> +    }
> +    for (i = ng; i < nt; ++i) {
> +        s->temps[i].state = (s->temps[i].temp_local
> +                             ? TS_DEAD | TS_MEM
> +                             : TS_DEAD);
>      }
>  }
>
>  /* Liveness analysis : update the opc_arg_life array to tell if a
>     given input arguments is dead. Instructions updating dead
>     temporaries are removed. */
> -static void liveness_pass_1(TCGContext *s, uint8_t *temp_state)
> +static void liveness_pass_1(TCGContext *s)
>  {
>      int nb_globals = s->nb_globals;
>      int oi, oi_prev;
>
> -    tcg_la_func_end(s, temp_state);
> +    tcg_la_func_end(s);
>
>      for (oi = s->gen_op_buf[0].prev; oi != 0; oi = oi_prev) {
>          int i, nb_iargs, nb_oargs;
>          TCGOpcode opc_new, opc_new2;
>          bool have_opc_new2;
>          TCGLifeData arg_life = 0;
> -        TCGArg arg;
> +        TCGTemp *arg_ts;
>
>          TCGOp * const op = &s->gen_op_buf[oi];
>          TCGOpcode opc = op->opc;
> @@ -1454,8 +1466,8 @@ static void liveness_pass_1(TCGContext *s, uint8_t *temp_state)
>                  /* pure functions can be removed if their result is unused */
>                  if (call_flags & TCG_CALL_NO_SIDE_EFFECTS) {
>                      for (i = 0; i < nb_oargs; i++) {
> -                        arg = op->args[i];
> -                        if (temp_state[arg] != TS_DEAD) {
> +                        arg_ts = arg_temp(op->args[i]);
> +                        if (arg_ts->state != TS_DEAD) {
>                              goto do_not_remove_call;
>                          }
>                      }
> @@ -1465,41 +1477,41 @@ static void liveness_pass_1(TCGContext *s, uint8_t *temp_state)
>
>                      /* output args are dead */
>                      for (i = 0; i < nb_oargs; i++) {
> -                        arg = op->args[i];
> -                        if (temp_state[arg] & TS_DEAD) {
> +                        arg_ts = arg_temp(op->args[i]);
> +                        if (arg_ts->state & TS_DEAD) {
>                              arg_life |= DEAD_ARG << i;
>                          }
> -                        if (temp_state[arg] & TS_MEM) {
> +                        if (arg_ts->state & TS_MEM) {
>                              arg_life |= SYNC_ARG << i;
>                          }
> -                        temp_state[arg] = TS_DEAD;
> +                        arg_ts->state = TS_DEAD;
>                      }
>
>                      if (!(call_flags & (TCG_CALL_NO_WRITE_GLOBALS |
>                                          TCG_CALL_NO_READ_GLOBALS))) {
>                          /* globals should go back to memory */
> -                        memset(temp_state, TS_DEAD | TS_MEM, nb_globals);
> +                        for (i = 0; i < nb_globals; i++) {
> +                            s->temps[i].state = TS_DEAD | TS_MEM;
> +                        }
>                      } else if (!(call_flags & TCG_CALL_NO_READ_GLOBALS)) {
>                          /* globals should be synced to memory */
>                          for (i = 0; i < nb_globals; i++) {
> -                            temp_state[i] |= TS_MEM;
> +                            s->temps[i].state |= TS_MEM;
>                          }
>                      }
>
>                      /* record arguments that die in this helper */
>                      for (i = nb_oargs; i < nb_iargs + nb_oargs; i++) {
> -                        arg = op->args[i];
> -                        if (arg != TCG_CALL_DUMMY_ARG) {
> -                            if (temp_state[arg] & TS_DEAD) {
> -                                arg_life |= DEAD_ARG << i;
> -                            }
> +                        arg_ts = arg_temp(op->args[i]);
> +                        if (arg_ts && arg_ts->state & TS_DEAD) {
> +                            arg_life |= DEAD_ARG << i;
>                          }
>                      }
>                      /* input arguments are live for preceding opcodes */
>                      for (i = nb_oargs; i < nb_iargs + nb_oargs; i++) {
> -                        arg = op->args[i];
> -                        if (arg != TCG_CALL_DUMMY_ARG) {
> -                            temp_state[arg] &= ~TS_DEAD;
> +                        arg_ts = arg_temp(op->args[i]);
> +                        if (arg_ts) {
> +                            arg_ts->state &= ~TS_DEAD;
>                          }
>                      }
>                  }
> @@ -1509,7 +1521,7 @@ static void liveness_pass_1(TCGContext *s, uint8_t *temp_state)
>              break;
>          case INDEX_op_discard:
>              /* mark the temporary as dead */
> -            temp_state[op->args[0]] = TS_DEAD;
> +            arg_temp(op->args[0])->state = TS_DEAD;
>              break;
>
>          case INDEX_op_add2_i32:
> @@ -1530,8 +1542,8 @@ static void liveness_pass_1(TCGContext *s, uint8_t *temp_state)
>                 the low part.  The result can be optimized to a simple
>                 add or sub.  This happens often for x86_64 guest when the
>                 cpu mode is set to 32 bit.  */
> -            if (temp_state[op->args[1]] == TS_DEAD) {
> -                if (temp_state[op->args[0]] == TS_DEAD) {
> +            if (arg_temp(op->args[1])->state == TS_DEAD) {
> +                if (arg_temp(op->args[0])->state == TS_DEAD) {
>                      goto do_remove;
>                  }
>                  /* Replace the opcode and adjust the args in place,
> @@ -1568,8 +1580,8 @@ static void liveness_pass_1(TCGContext *s, uint8_t *temp_state)
>          do_mul2:
>              nb_iargs = 2;
>              nb_oargs = 2;
> -            if (temp_state[op->args[1]] == TS_DEAD) {
> -                if (temp_state[op->args[0]] == TS_DEAD) {
> +            if (arg_temp(op->args[1])->state == TS_DEAD) {
> +                if (arg_temp(op->args[0])->state == TS_DEAD) {
>                      /* Both parts of the operation are dead.  */
>                      goto do_remove;
>                  }
> @@ -1577,7 +1589,7 @@ static void liveness_pass_1(TCGContext *s, uint8_t *temp_state)
>                  op->opc = opc = opc_new;
>                  op->args[1] = op->args[2];
>                  op->args[2] = op->args[3];
> -            } else if (temp_state[op->args[0]] == TS_DEAD && have_opc_new2) {
> +            } else if (arg_temp(op->args[0])->state == TS_DEAD && have_opc_new2) {
>                  /* The low part of the operation is dead; generate the high. */
>                  op->opc = opc = opc_new2;
>                  op->args[0] = op->args[1];
> @@ -1600,7 +1612,7 @@ static void liveness_pass_1(TCGContext *s, uint8_t *temp_state)
>                 implies side effects */
>              if (!(def->flags & TCG_OPF_SIDE_EFFECTS) && nb_oargs != 0) {
>                  for (i = 0; i < nb_oargs; i++) {
> -                    if (temp_state[op->args[i]] != TS_DEAD) {
> +                    if (arg_temp(op->args[i])->state != TS_DEAD) {
>                          goto do_not_remove;
>                      }
>                  }
> @@ -1610,36 +1622,36 @@ static void liveness_pass_1(TCGContext *s, uint8_t *temp_state)
>              do_not_remove:
>                  /* output args are dead */
>                  for (i = 0; i < nb_oargs; i++) {
> -                    arg = op->args[i];
> -                    if (temp_state[arg] & TS_DEAD) {
> +                    arg_ts = arg_temp(op->args[i]);
> +                    if (arg_ts->state & TS_DEAD) {
>                          arg_life |= DEAD_ARG << i;
>                      }
> -                    if (temp_state[arg] & TS_MEM) {
> +                    if (arg_ts->state & TS_MEM) {
>                          arg_life |= SYNC_ARG << i;
>                      }
> -                    temp_state[arg] = TS_DEAD;
> +                    arg_ts->state = TS_DEAD;
>                  }
>
>                  /* if end of basic block, update */
>                  if (def->flags & TCG_OPF_BB_END) {
> -                    tcg_la_bb_end(s, temp_state);
> +                    tcg_la_bb_end(s);
>                  } else if (def->flags & TCG_OPF_SIDE_EFFECTS) {
>                      /* globals should be synced to memory */
>                      for (i = 0; i < nb_globals; i++) {
> -                        temp_state[i] |= TS_MEM;
> +                        s->temps[i].state |= TS_MEM;
>                      }
>                  }
>
>                  /* record arguments that die in this opcode */
>                  for (i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
> -                    arg = op->args[i];
> -                    if (temp_state[arg] & TS_DEAD) {
> +                    arg_ts = arg_temp(op->args[i]);
> +                    if (arg_ts->state & TS_DEAD) {
>                          arg_life |= DEAD_ARG << i;
>                      }
>                  }
>                  /* input arguments are live for preceding opcodes */
>                  for (i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
> -                    temp_state[op->args[i]] &= ~TS_DEAD;
> +                    arg_temp(op->args[i])->state &= ~TS_DEAD;
>                  }
>              }
>              break;
> @@ -1649,16 +1661,12 @@ static void liveness_pass_1(TCGContext *s, uint8_t *temp_state)
>  }
>
>  /* Liveness analysis: Convert indirect regs to direct temporaries.  */
> -static bool liveness_pass_2(TCGContext *s, uint8_t *temp_state)
> +static bool liveness_pass_2(TCGContext *s)
>  {
>      int nb_globals = s->nb_globals;
> -    int16_t *dir_temps;
>      int i, oi, oi_next;
>      bool changes = false;
>
> -    dir_temps = tcg_malloc(nb_globals * sizeof(int16_t));
> -    memset(dir_temps, 0, nb_globals * sizeof(int16_t));
> -
>      /* Create a temporary for each indirect global.  */
>      for (i = 0; i < nb_globals; ++i) {
>          TCGTemp *its = &s->temps[i];
> @@ -1666,19 +1674,19 @@ static bool liveness_pass_2(TCGContext *s, uint8_t *temp_state)
>              TCGTemp *dts = tcg_temp_alloc(s);
>              dts->type = its->type;
>              dts->base_type = its->base_type;
> -            dir_temps[i] = temp_idx(s, dts);
> +            its->state_ptr = dts;
>          }
> +        /* All globals begin dead.  */
> +        its->state = TS_DEAD;
>      }
>
> -    memset(temp_state, TS_DEAD, nb_globals);
> -
>      for (oi = s->gen_op_buf[0].next; oi != 0; oi = oi_next) {
>          TCGOp *op = &s->gen_op_buf[oi];
>          TCGOpcode opc = op->opc;
>          const TCGOpDef *def = &tcg_op_defs[opc];
>          TCGLifeData arg_life = op->life;
>          int nb_iargs, nb_oargs, call_flags;
> -        TCGArg arg, dir;
> +        TCGTemp *arg_ts, *dir_ts;
>
>          oi_next = op->next;
>
> @@ -1706,24 +1714,20 @@ static bool liveness_pass_2(TCGContext *s, uint8_t *temp_state)
>
>          /* Make sure that input arguments are available.  */
>          for (i = nb_oargs; i < nb_iargs + nb_oargs; i++) {
> -            arg = op->args[i];
> -            /* Note this unsigned test catches TCG_CALL_ARG_DUMMY too.  */
> -            if (arg < nb_globals) {

This test is gone but....

> -                dir = dir_temps[arg];
> -                if (dir != 0 && temp_state[arg] == TS_DEAD) {
> -                    TCGTemp *its = arg_temp(arg);
> -                    TCGOpcode lopc = (its->type == TCG_TYPE_I32
> -                                      ? INDEX_op_ld_i32
> -                                      : INDEX_op_ld_i64);
> -                    TCGOp *lop = tcg_op_insert_before(s, op, lopc, 3);
> -
> -                    lop->args[0] = dir;
> -                    lop->args[1] = temp_arg(its->mem_base);
> -                    lop->args[2] = its->mem_offset;
> -
> -                    /* Loaded, but synced with memory.  */
> -                    temp_state[arg] = TS_MEM;
> -                }
> +            arg_ts = arg_temp(op->args[i]);
> +            dir_ts = arg_ts->state_ptr;
> +            if (dir_ts && arg_ts->state == TS_DEAD) {

...we de-ref arg_ts here. So what if it was a TCG_CALL_ARG_DUMMY?

> +                TCGOpcode lopc = (arg_ts->type == TCG_TYPE_I32
> +                                  ? INDEX_op_ld_i32
> +                                  : INDEX_op_ld_i64);
> +                TCGOp *lop = tcg_op_insert_before(s, op, lopc, 3);
> +
> +                lop->args[0] = temp_arg(dir_ts);
> +                lop->args[1] = temp_arg(arg_ts->mem_base);
> +                lop->args[2] = arg_ts->mem_offset;
> +
> +                /* Loaded, but synced with memory.  */
> +                arg_ts->state = TS_MEM;
>              }
>          }
>
> @@ -1731,15 +1735,13 @@ static bool liveness_pass_2(TCGContext *s, uint8_t *temp_state)
>             No action is required except keeping temp_state up to date
>             so that we reload when needed.  */
>          for (i = nb_oargs; i < nb_iargs + nb_oargs; i++) {
> -            arg = op->args[i];
> -            if (arg < nb_globals) {
> -                dir = dir_temps[arg];
> -                if (dir != 0) {
> -                    op->args[i] = dir;
> -                    changes = true;
> -                    if (IS_DEAD_ARG(i)) {
> -                        temp_state[arg] = TS_DEAD;
> -                    }
> +            arg_ts = arg_temp(op->args[i]);
> +            dir_ts = arg_ts->state_ptr;
> +            if (dir_ts) {
> +                op->args[i] = temp_arg(dir_ts);
> +                changes = true;
> +                if (IS_DEAD_ARG(i)) {
> +                    arg_ts->state = TS_DEAD;
>                  }
>              }
>          }
> @@ -1752,51 +1754,49 @@ static bool liveness_pass_2(TCGContext *s, uint8_t *temp_state)
>              for (i = 0; i < nb_globals; ++i) {
>                  /* Liveness should see that globals are synced back,
>                     that is, either TS_DEAD or TS_MEM.  */
> -                tcg_debug_assert(dir_temps[i] == 0
> -                                 || temp_state[i] != 0);
> +                arg_ts = &s->temps[i];
> +                tcg_debug_assert(arg_ts->state_ptr == 0
> +                                 || arg_ts->state != 0);
>              }
>          } else {
>              for (i = 0; i < nb_globals; ++i) {
>                  /* Liveness should see that globals are saved back,
>                     that is, TS_DEAD, waiting to be reloaded.  */
> -                tcg_debug_assert(dir_temps[i] == 0
> -                                 || temp_state[i] == TS_DEAD);
> +                arg_ts = &s->temps[i];
> +                tcg_debug_assert(arg_ts->state_ptr == 0
> +                                 || arg_ts->state == TS_DEAD);
>              }
>          }
>
>          /* Outputs become available.  */
>          for (i = 0; i < nb_oargs; i++) {
> -            arg = op->args[i];
> -            if (arg >= nb_globals) {
> -                continue;
> -            }
> -            dir = dir_temps[arg];
> -            if (dir == 0) {
> +            arg_ts = arg_temp(op->args[i]);
> +            dir_ts = arg_ts->state_ptr;
> +            if (!dir_ts) {
>                  continue;
>              }
> -            op->args[i] = dir;
> +            op->args[i] = temp_arg(dir_ts);
>              changes = true;
>
>              /* The output is now live and modified.  */
> -            temp_state[arg] = 0;
> +            arg_ts->state = 0;
>
>              /* Sync outputs upon their last write.  */
>              if (NEED_SYNC_ARG(i)) {
> -                TCGTemp *its = arg_temp(arg);
> -                TCGOpcode sopc = (its->type == TCG_TYPE_I32
> +                TCGOpcode sopc = (arg_ts->type == TCG_TYPE_I32
>                                    ? INDEX_op_st_i32
>                                    : INDEX_op_st_i64);
>                  TCGOp *sop = tcg_op_insert_after(s, op, sopc, 3);
>
> -                sop->args[0] = dir;
> -                sop->args[1] = temp_arg(its->mem_base);
> -                sop->args[2] = its->mem_offset;
> +                sop->args[0] = temp_arg(dir_ts);
> +                sop->args[1] = temp_arg(arg_ts->mem_base);
> +                sop->args[2] = arg_ts->mem_offset;
>
> -                temp_state[arg] = TS_MEM;
> +                arg_ts->state = TS_MEM;
>              }
>              /* Drop outputs that are dead.  */
>              if (IS_DEAD_ARG(i)) {
> -                temp_state[arg] = TS_DEAD;
> +                arg_ts->state = TS_DEAD;
>              }
>          }
>      }
> @@ -2569,27 +2569,23 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
>      s->la_time -= profile_getclock();
>  #endif
>
> -    {
> -        uint8_t *temp_state = tcg_malloc(s->nb_temps + s->nb_indirects);
> -
> -        liveness_pass_1(s, temp_state);
> +    liveness_pass_1(s);
>
> -        if (s->nb_indirects > 0) {
> +    if (s->nb_indirects > 0) {
>  #ifdef DEBUG_DISAS
> -            if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP_IND)
> -                         && qemu_log_in_addr_range(tb->pc))) {
> -                qemu_log_lock();
> -                qemu_log("OP before indirect lowering:\n");
> -                tcg_dump_ops(s);
> -                qemu_log("\n");
> -                qemu_log_unlock();
> -            }
> +        if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP_IND)
> +                     && qemu_log_in_addr_range(tb->pc))) {
> +            qemu_log_lock();
> +            qemu_log("OP before indirect lowering:\n");
> +            tcg_dump_ops(s);
> +            qemu_log("\n");
> +            qemu_log_unlock();
> +        }
>  #endif
> -            /* Replace indirect temps with direct temps.  */
> -            if (liveness_pass_2(s, temp_state)) {
> -                /* If changes were made, re-run liveness.  */
> -                liveness_pass_1(s, temp_state);
> -            }
> +        /* Replace indirect temps with direct temps.  */
> +        if (liveness_pass_2(s)) {
> +            /* If changes were made, re-run liveness.  */
> +            liveness_pass_1(s);
>          }
>      }
>
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index 80012b5..1eeeca5 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -599,6 +599,12 @@ typedef struct TCGTemp {
>      struct TCGTemp *mem_base;
>      intptr_t mem_offset;
>      const char *name;
> +
> +    /* Pass-specific information that can be stored for a temporary.
> +       One word worth of integer data, and one pointer to data
> +       allocated separately.  */
> +    uintptr_t state;
> +    void *state_ptr;
>  } TCGTemp;
>
>  typedef struct TCGContext TCGContext;


--
Alex Bennée
