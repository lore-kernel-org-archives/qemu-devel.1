Received: from eggs.gnu.org ([2001:4830:134:3::10]:52131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dPVWG-0000rf-5p
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 11:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dPVWB-00067D-Dx
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 11:01:40 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:35948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dPVWB-000675-2B
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 11:01:35 -0400
Received: by mail-wr0-x234.google.com with SMTP id c11so146069095wrc.3
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 08:01:34 -0700 (PDT)
References: <20170621024831.26019-1-rth@twiddle.net>
	<20170621024831.26019-4-rth@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170621024831.26019-4-rth@twiddle.net>
Date: Mon, 26 Jun 2017 16:02:23 +0100
Message-ID: <8760fiyeps.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 03/16] tcg: Propagate args to op->args in
 tcg.c
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
> ---
>  tcg/tcg.c | 121 ++++++++++++++++++++++++++++++--------------------------------
>  1 file changed, 58 insertions(+), 63 deletions(-)
>
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 298aa0c..be5b69c 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1054,14 +1054,12 @@ void tcg_dump_ops(TCGContext *s)
>      for (oi = s->gen_op_buf[0].next; oi != 0; oi = op->next) {
>          int i, k, nb_oargs, nb_iargs, nb_cargs;
>          const TCGOpDef *def;
> -        const TCGArg *args;
>          TCGOpcode c;
>          int col = 0;
>
>          op = &s->gen_op_buf[oi];
>          c = op->opc;
>          def = &tcg_op_defs[c];
> -        args = op->args;
>
>          if (c == INDEX_op_insn_start) {
>              col += qemu_log("%s ----", oi != s->gen_op_buf[0].next ? "\n" : "");
> @@ -1069,9 +1067,9 @@ void tcg_dump_ops(TCGContext *s)
>              for (i = 0; i < TARGET_INSN_START_WORDS; ++i) {
>                  target_ulong a;
>  #if TARGET_LONG_BITS > TCG_TARGET_REG_BITS
> -                a = ((target_ulong)args[i * 2 + 1] << 32) | args[i * 2];
> +                a = deposit64(op->args[i * 2], 32, 32, op->args[i * 2
>              + 1]);

It doesn't now but should be assert against us overflowing the args
buffer here when dealing with encoded data? Or should it have faulted
when planting the ops?

>  #else
> -                a = args[i];
> +                a = op->args[i];
>  #endif
>                  col += qemu_log(" " TARGET_FMT_lx, a);
>              }
> @@ -1083,14 +1081,14 @@ void tcg_dump_ops(TCGContext *s)
>
>              /* function name, flags, out args */
>              col += qemu_log(" %s %s,$0x%" TCG_PRIlx ",$%d", def->name,
> -                            tcg_find_helper(s, args[nb_oargs + nb_iargs]),
> -                            args[nb_oargs + nb_iargs + 1], nb_oargs);
> +                            tcg_find_helper(s, op->args[nb_oargs + nb_iargs]),
> +                            op->args[nb_oargs + nb_iargs + 1], nb_oargs);
>              for (i = 0; i < nb_oargs; i++) {
>                  col += qemu_log(",%s", tcg_get_arg_str_idx(s, buf, sizeof(buf),
> -                                                           args[i]));
> +                                                           op->args[i]));
>              }
>              for (i = 0; i < nb_iargs; i++) {
> -                TCGArg arg = args[nb_oargs + i];
> +                TCGArg arg = op->args[nb_oargs + i];
>                  const char *t = "<dummy>";
>                  if (arg != TCG_CALL_DUMMY_ARG) {
>                      t = tcg_get_arg_str_idx(s, buf, sizeof(buf), arg);
> @@ -1110,14 +1108,14 @@ void tcg_dump_ops(TCGContext *s)
>                      col += qemu_log(",");
>                  }
>                  col += qemu_log("%s", tcg_get_arg_str_idx(s, buf, sizeof(buf),
> -                                                          args[k++]));
> +                                                          op->args[k++]));
>              }
>              for (i = 0; i < nb_iargs; i++) {
>                  if (k != 0) {
>                      col += qemu_log(",");
>                  }
>                  col += qemu_log("%s", tcg_get_arg_str_idx(s, buf, sizeof(buf),
> -                                                          args[k++]));
> +                                                          op->args[k++]));
>              }
>              switch (c) {
>              case INDEX_op_brcond_i32:
> @@ -1128,10 +1126,11 @@ void tcg_dump_ops(TCGContext *s)
>              case INDEX_op_brcond_i64:
>              case INDEX_op_setcond_i64:
>              case INDEX_op_movcond_i64:
> -                if (args[k] < ARRAY_SIZE(cond_name) && cond_name[args[k]]) {
> -                    col += qemu_log(",%s", cond_name[args[k++]]);
> +                if (op->args[k] < ARRAY_SIZE(cond_name)
> +                    && cond_name[op->args[k]]) {
> +                    col += qemu_log(",%s", cond_name[op->args[k++]]);
>                  } else {
> -                    col += qemu_log(",$0x%" TCG_PRIlx, args[k++]);
> +                    col += qemu_log(",$0x%" TCG_PRIlx, op->args[k++]);
>                  }
>                  i = 1;
>                  break;
> @@ -1140,7 +1139,7 @@ void tcg_dump_ops(TCGContext *s)
>              case INDEX_op_qemu_ld_i64:
>              case INDEX_op_qemu_st_i64:
>                  {
> -                    TCGMemOpIdx oi = args[k++];
> +                    TCGMemOpIdx oi = op->args[k++];
>                      TCGMemOp op = get_memop(oi);
>                      unsigned ix = get_mmuidx(oi);
>
> @@ -1165,14 +1164,15 @@ void tcg_dump_ops(TCGContext *s)
>              case INDEX_op_brcond_i32:
>              case INDEX_op_brcond_i64:
>              case INDEX_op_brcond2_i32:
> -                col += qemu_log("%s$L%d", k ? "," : "", arg_label(args[k])->id);
> +                col += qemu_log("%s$L%d", k ? "," : "",
> +                                arg_label(op->args[k])->id);
>                  i++, k++;
>                  break;
>              default:
>                  break;
>              }
>              for (; i < nb_cargs; i++, k++) {
> -                col += qemu_log("%s$0x%" TCG_PRIlx, k ? "," : "", args[k]);
> +                col += qemu_log("%s$0x%" TCG_PRIlx, k ? "," : "", op->args[k]);
>              }
>          }
>          if (op->life) {
> @@ -1433,7 +1433,6 @@ static void liveness_pass_1(TCGContext *s, uint8_t *temp_state)
>          TCGArg arg;
>
>          TCGOp * const op = &s->gen_op_buf[oi];
> -        TCGArg * const args = op->args;
>          TCGOpcode opc = op->opc;
>          const TCGOpDef *def = &tcg_op_defs[opc];
>
> @@ -1446,12 +1445,12 @@ static void liveness_pass_1(TCGContext *s, uint8_t *temp_state)
>
>                  nb_oargs = op->callo;
>                  nb_iargs = op->calli;
> -                call_flags = args[nb_oargs + nb_iargs + 1];
> +                call_flags = op->args[nb_oargs + nb_iargs + 1];
>
>                  /* pure functions can be removed if their result is unused */
>                  if (call_flags & TCG_CALL_NO_SIDE_EFFECTS) {
>                      for (i = 0; i < nb_oargs; i++) {
> -                        arg = args[i];
> +                        arg = op->args[i];
>                          if (temp_state[arg] != TS_DEAD) {
>                              goto do_not_remove_call;
>                          }
> @@ -1462,7 +1461,7 @@ static void liveness_pass_1(TCGContext *s, uint8_t *temp_state)
>
>                      /* output args are dead */
>                      for (i = 0; i < nb_oargs; i++) {
> -                        arg = args[i];
> +                        arg = op->args[i];
>                          if (temp_state[arg] & TS_DEAD) {
>                              arg_life |= DEAD_ARG << i;
>                          }
> @@ -1485,7 +1484,7 @@ static void liveness_pass_1(TCGContext *s, uint8_t *temp_state)
>
>                      /* record arguments that die in this helper */
>                      for (i = nb_oargs; i < nb_iargs + nb_oargs; i++) {
> -                        arg = args[i];
> +                        arg = op->args[i];
>                          if (arg != TCG_CALL_DUMMY_ARG) {
>                              if (temp_state[arg] & TS_DEAD) {
>                                  arg_life |= DEAD_ARG << i;
> @@ -1494,7 +1493,7 @@ static void liveness_pass_1(TCGContext *s, uint8_t *temp_state)
>                      }
>                      /* input arguments are live for preceding opcodes */
>                      for (i = nb_oargs; i < nb_iargs + nb_oargs; i++) {
> -                        arg = args[i];
> +                        arg = op->args[i];
>                          if (arg != TCG_CALL_DUMMY_ARG) {
>                              temp_state[arg] &= ~TS_DEAD;
>                          }
> @@ -1506,7 +1505,7 @@ static void liveness_pass_1(TCGContext *s, uint8_t *temp_state)
>              break;
>          case INDEX_op_discard:
>              /* mark the temporary as dead */
> -            temp_state[args[0]] = TS_DEAD;
> +            temp_state[op->args[0]] = TS_DEAD;
>              break;
>
>          case INDEX_op_add2_i32:
> @@ -1527,15 +1526,15 @@ static void liveness_pass_1(TCGContext *s, uint8_t *temp_state)
>                 the low part.  The result can be optimized to a simple
>                 add or sub.  This happens often for x86_64 guest when the
>                 cpu mode is set to 32 bit.  */
> -            if (temp_state[args[1]] == TS_DEAD) {
> -                if (temp_state[args[0]] == TS_DEAD) {
> +            if (temp_state[op->args[1]] == TS_DEAD) {
> +                if (temp_state[op->args[0]] == TS_DEAD) {
>                      goto do_remove;
>                  }
>                  /* Replace the opcode and adjust the args in place,
>                     leaving 3 unused args at the end.  */
>                  op->opc = opc = opc_new;
> -                args[1] = args[2];
> -                args[2] = args[4];
> +                op->args[1] = op->args[2];
> +                op->args[2] = op->args[4];
>                  /* Fall through and mark the single-word operation live.  */
>                  nb_iargs = 2;
>                  nb_oargs = 1;
> @@ -1565,21 +1564,21 @@ static void liveness_pass_1(TCGContext *s, uint8_t *temp_state)
>          do_mul2:
>              nb_iargs = 2;
>              nb_oargs = 2;
> -            if (temp_state[args[1]] == TS_DEAD) {
> -                if (temp_state[args[0]] == TS_DEAD) {
> +            if (temp_state[op->args[1]] == TS_DEAD) {
> +                if (temp_state[op->args[0]] == TS_DEAD) {
>                      /* Both parts of the operation are dead.  */
>                      goto do_remove;
>                  }
>                  /* The high part of the operation is dead; generate the low. */
>                  op->opc = opc = opc_new;
> -                args[1] = args[2];
> -                args[2] = args[3];
> -            } else if (temp_state[args[0]] == TS_DEAD && have_opc_new2) {
> +                op->args[1] = op->args[2];
> +                op->args[2] = op->args[3];
> +            } else if (temp_state[op->args[0]] == TS_DEAD && have_opc_new2) {
>                  /* The low part of the operation is dead; generate the high. */
>                  op->opc = opc = opc_new2;
> -                args[0] = args[1];
> -                args[1] = args[2];
> -                args[2] = args[3];
> +                op->args[0] = op->args[1];
> +                op->args[1] = op->args[2];
> +                op->args[2] = op->args[3];
>              } else {
>                  goto do_not_remove;
>              }
> @@ -1597,7 +1596,7 @@ static void liveness_pass_1(TCGContext *s, uint8_t *temp_state)
>                 implies side effects */
>              if (!(def->flags & TCG_OPF_SIDE_EFFECTS) && nb_oargs != 0) {
>                  for (i = 0; i < nb_oargs; i++) {
> -                    if (temp_state[args[i]] != TS_DEAD) {
> +                    if (temp_state[op->args[i]] != TS_DEAD) {
>                          goto do_not_remove;
>                      }
>                  }
> @@ -1607,7 +1606,7 @@ static void liveness_pass_1(TCGContext *s, uint8_t *temp_state)
>              do_not_remove:
>                  /* output args are dead */
>                  for (i = 0; i < nb_oargs; i++) {
> -                    arg = args[i];
> +                    arg = op->args[i];
>                      if (temp_state[arg] & TS_DEAD) {
>                          arg_life |= DEAD_ARG << i;
>                      }
> @@ -1629,14 +1628,14 @@ static void liveness_pass_1(TCGContext *s, uint8_t *temp_state)
>
>                  /* record arguments that die in this opcode */
>                  for (i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
> -                    arg = args[i];
> +                    arg = op->args[i];
>                      if (temp_state[arg] & TS_DEAD) {
>                          arg_life |= DEAD_ARG << i;
>                      }
>                  }
>                  /* input arguments are live for preceding opcodes */
>                  for (i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
> -                    temp_state[args[i]] &= ~TS_DEAD;
> +                    temp_state[op->args[i]] &= ~TS_DEAD;
>                  }
>              }
>              break;
> @@ -1671,7 +1670,6 @@ static bool liveness_pass_2(TCGContext *s, uint8_t *temp_state)
>
>      for (oi = s->gen_op_buf[0].next; oi != 0; oi = oi_next) {
>          TCGOp *op = &s->gen_op_buf[oi];
> -        TCGArg *args = op->args;
>          TCGOpcode opc = op->opc;
>          const TCGOpDef *def = &tcg_op_defs[opc];
>          TCGLifeData arg_life = op->life;
> @@ -1683,7 +1681,7 @@ static bool liveness_pass_2(TCGContext *s, uint8_t *temp_state)
>          if (opc == INDEX_op_call) {
>              nb_oargs = op->callo;
>              nb_iargs = op->calli;
> -            call_flags = args[nb_oargs + nb_iargs + 1];
> +            call_flags = op->args[nb_oargs + nb_iargs + 1];
>          } else {
>              nb_iargs = def->nb_iargs;
>              nb_oargs = def->nb_oargs;
> @@ -1704,7 +1702,7 @@ static bool liveness_pass_2(TCGContext *s, uint8_t *temp_state)
>
>          /* Make sure that input arguments are available.  */
>          for (i = nb_oargs; i < nb_iargs + nb_oargs; i++) {
> -            arg = args[i];
> +            arg = op->args[i];
>              /* Note this unsigned test catches TCG_CALL_ARG_DUMMY too.  */
>              if (arg < nb_globals) {
>                  dir = dir_temps[arg];
> @@ -1714,11 +1712,10 @@ static bool liveness_pass_2(TCGContext *s, uint8_t *temp_state)
>                                        ? INDEX_op_ld_i32
>                                        : INDEX_op_ld_i64);
>                      TCGOp *lop = tcg_op_insert_before(s, op, lopc, 3);
> -                    TCGArg *largs = lop->args;
>
> -                    largs[0] = dir;
> -                    largs[1] = temp_idx(s, its->mem_base);
> -                    largs[2] = its->mem_offset;
> +                    lop->args[0] = dir;
> +                    lop->args[1] = temp_idx(s, its->mem_base);
> +                    lop->args[2] = its->mem_offset;
>
>                      /* Loaded, but synced with memory.  */
>                      temp_state[arg] = TS_MEM;
> @@ -1730,11 +1727,11 @@ static bool liveness_pass_2(TCGContext *s, uint8_t *temp_state)
>             No action is required except keeping temp_state up to date
>             so that we reload when needed.  */
>          for (i = nb_oargs; i < nb_iargs + nb_oargs; i++) {
> -            arg = args[i];
> +            arg = op->args[i];
>              if (arg < nb_globals) {
>                  dir = dir_temps[arg];
>                  if (dir != 0) {
> -                    args[i] = dir;
> +                    op->args[i] = dir;
>                      changes = true;
>                      if (IS_DEAD_ARG(i)) {
>                          temp_state[arg] = TS_DEAD;
> @@ -1765,7 +1762,7 @@ static bool liveness_pass_2(TCGContext *s, uint8_t *temp_state)
>
>          /* Outputs become available.  */
>          for (i = 0; i < nb_oargs; i++) {
> -            arg = args[i];
> +            arg = op->args[i];
>              if (arg >= nb_globals) {
>                  continue;
>              }
> @@ -1773,7 +1770,7 @@ static bool liveness_pass_2(TCGContext *s, uint8_t *temp_state)
>              if (dir == 0) {
>                  continue;
>              }
> -            args[i] = dir;
> +            op->args[i] = dir;
>              changes = true;
>
>              /* The output is now live and modified.  */
> @@ -1786,11 +1783,10 @@ static bool liveness_pass_2(TCGContext *s, uint8_t *temp_state)
>                                    ? INDEX_op_st_i32
>                                    : INDEX_op_st_i64);
>                  TCGOp *sop = tcg_op_insert_after(s, op, sopc, 3);
> -                TCGArg *sargs = sop->args;
>
> -                sargs[0] = dir;
> -                sargs[1] = temp_idx(s, its->mem_base);
> -                sargs[2] = its->mem_offset;
> +                sop->args[0] = dir;
> +                sop->args[1] = temp_idx(s, its->mem_base);
> +                sop->args[2] = its->mem_offset;
>
>                  temp_state[arg] = TS_MEM;
>              }
> @@ -2614,7 +2610,6 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
>      num_insns = -1;
>      for (oi = s->gen_op_buf[0].next; oi != 0; oi = oi_next) {
>          TCGOp * const op = &s->gen_op_buf[oi];
> -        TCGArg * const args = op->args;
>          TCGOpcode opc = op->opc;
>          const TCGOpDef *def = &tcg_op_defs[opc];
>          TCGLifeData arg_life = op->life;
> @@ -2627,11 +2622,11 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
>          switch (opc) {
>          case INDEX_op_mov_i32:
>          case INDEX_op_mov_i64:
> -            tcg_reg_alloc_mov(s, def, args, arg_life);
> +            tcg_reg_alloc_mov(s, def, op->args, arg_life);
>              break;
>          case INDEX_op_movi_i32:
>          case INDEX_op_movi_i64:
> -            tcg_reg_alloc_movi(s, args, arg_life);
> +            tcg_reg_alloc_movi(s, op->args, arg_life);
>              break;
>          case INDEX_op_insn_start:
>              if (num_insns >= 0) {
> @@ -2641,22 +2636,22 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
>              for (i = 0; i < TARGET_INSN_START_WORDS; ++i) {
>                  target_ulong a;
>  #if TARGET_LONG_BITS > TCG_TARGET_REG_BITS
> -                a = ((target_ulong)args[i * 2 + 1] << 32) | args[i * 2];
> +                a = deposit64(op->args[i * 2], 32, 32, op->args[i * 2 + 1]);
>  #else
> -                a = args[i];
> +                a = op->args[i];
>  #endif
>                  s->gen_insn_data[num_insns][i] = a;
>              }
>              break;
>          case INDEX_op_discard:
> -            temp_dead(s, &s->temps[args[0]]);
> +            temp_dead(s, &s->temps[op->args[0]]);
>              break;
>          case INDEX_op_set_label:
>              tcg_reg_alloc_bb_end(s, s->reserved_regs);
> -            tcg_out_label(s, arg_label(args[0]), s->code_ptr);
> +            tcg_out_label(s, arg_label(op->args[0]), s->code_ptr);
>              break;
>          case INDEX_op_call:
> -            tcg_reg_alloc_call(s, op->callo, op->calli, args, arg_life);
> +            tcg_reg_alloc_call(s, op->callo, op->calli, op->args, arg_life);
>              break;
>          default:
>              /* Sanity check that we've not introduced any unhandled opcodes. */
> @@ -2666,7 +2661,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
>              /* Note: in order to speed up the code, it would be much
>                 faster to have specialized register allocator functions for
>                 some common argument patterns */
> -            tcg_reg_alloc_op(s, def, opc, args, arg_life);
> +            tcg_reg_alloc_op(s, def, opc, op->args, arg_life);
>              break;
>          }
>  #ifdef CONFIG_DEBUG_TCG

Otherwise:

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

--
Alex Bennée
