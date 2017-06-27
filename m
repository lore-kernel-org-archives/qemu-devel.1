Received: from eggs.gnu.org ([2001:4830:134:3::10]:34624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dPnGd-0002NQ-Fw
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:58:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dPnGa-0004gN-2s
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:58:43 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:35717)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dPnGZ-0004fy-L1
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:58:40 -0400
Received: by mail-wm0-x230.google.com with SMTP id w126so19685640wme.0
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 02:58:39 -0700 (PDT)
References: <20170621024831.26019-1-rth@twiddle.net>
	<20170621024831.26019-15-rth@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170621024831.26019-15-rth@twiddle.net>
Date: Tue, 27 Jun 2017 10:59:28 +0100
Message-ID: <87podpwy2n.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 14/16] tcg: Use per-temp state data in
 optimize
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

> While we're touching many of the lines anyway, adjust the naming
> of the functions to better distinguish when "TCGArg" vs "TCGTemp"
> should be used.

Could we add definitions of TCGArg and TCGTemp into tcg/README?

>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  tcg/optimize.c | 424 +++++++++++++++++++++++++++++++++------------------------
>  tcg/tcg.h      |   5 +
>  2 files changed, 249 insertions(+), 180 deletions(-)
>
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 55f9e83..eb09ae5 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -34,34 +34,63 @@
>
>  struct tcg_temp_info {
>      bool is_const;
> -    uint16_t prev_copy;
> -    uint16_t next_copy;
> +    TCGTemp *prev_copy;
> +    TCGTemp *next_copy;
>      tcg_target_ulong val;
>      tcg_target_ulong mask;
>  };
>
> -static struct tcg_temp_info temps[TCG_MAX_TEMPS];
> +static struct tcg_temp_info temps_[TCG_MAX_TEMPS];
>  static TCGTempSet temps_used;
>
> -static inline bool temp_is_const(TCGArg arg)
> +static inline struct tcg_temp_info *ts_info(TCGTemp *ts)
>  {
> -    return temps[arg].is_const;
> +    return ts->state_ptr;
>  }
>
> -static inline bool temp_is_copy(TCGArg arg)
> +static inline struct tcg_temp_info *arg_info(TCGArg arg)
>  {
> -    return temps[arg].next_copy != arg;
> +    return ts_info(arg_temp(arg));
> +}
> +
> +static inline bool ts_is_const(TCGTemp *ts)
> +{
> +    return ts_info(ts)->is_const;
> +}
> +
> +static inline bool arg_is_const(TCGArg arg)
> +{
> +    return ts_is_const(arg_temp(arg));
> +}
> +
> +static inline bool ts_is_copy(TCGTemp *ts)
> +{
> +    return ts_info(ts)->next_copy != ts;
> +}
> +
> +static inline bool arg_is_copy(TCGArg arg)
> +{
> +    return ts_is_copy(arg_temp(arg));
>  }
>
>  /* Reset TEMP's state, possibly removing the temp for the list of copies.  */
> -static void reset_temp(TCGArg temp)
> +static void reset_ts(TCGTemp *ts)
>  {
> -    temps[temps[temp].next_copy].prev_copy = temps[temp].prev_copy;
> -    temps[temps[temp].prev_copy].next_copy = temps[temp].next_copy;
> -    temps[temp].next_copy = temp;
> -    temps[temp].prev_copy = temp;
> -    temps[temp].is_const = false;
> -    temps[temp].mask = -1;
> +    struct tcg_temp_info *ti = ts_info(ts);
> +    struct tcg_temp_info *pi = ts_info(ti->prev_copy);
> +    struct tcg_temp_info *ni = ts_info(ti->next_copy);
> +
> +    ni->prev_copy = ti->prev_copy;
> +    pi->next_copy = ti->next_copy;
> +    ti->next_copy = ts;
> +    ti->prev_copy = ts;
> +    ti->is_const = false;
> +    ti->mask = -1;
> +}
> +
> +static void reset_temp(TCGArg arg)
> +{
> +    reset_ts(arg_temp(arg));
>  }
>
>  /* Reset all temporaries, given that there are NB_TEMPS of them.  */
> @@ -71,17 +100,26 @@ static void reset_all_temps(int nb_temps)
>  }
>
>  /* Initialize and activate a temporary.  */
> -static void init_temp_info(TCGArg temp)
> +static void init_ts_info(TCGTemp *ts)
>  {
> -    if (!test_bit(temp, temps_used.l)) {
> -        temps[temp].next_copy = temp;
> -        temps[temp].prev_copy = temp;
> -        temps[temp].is_const = false;
> -        temps[temp].mask = -1;
> -        set_bit(temp, temps_used.l);
> +    size_t idx = temp_idx(ts);
> +    if (!test_bit(idx, temps_used.l)) {
> +        struct tcg_temp_info *ti = &temps_[idx];
> +
> +        ts->state_ptr = ti;
> +        ti->next_copy = ts;
> +        ti->prev_copy = ts;
> +        ti->is_const = false;
> +        ti->mask = -1;
> +        set_bit(idx, temps_used.l);
>      }
>  }
>
> +static void init_arg_info(TCGArg arg)
> +{
> +    init_ts_info(arg_temp(arg));
> +}
> +
>  static int op_bits(TCGOpcode op)
>  {
>      const TCGOpDef *def = &tcg_op_defs[op];
> @@ -119,7 +157,7 @@ static TCGOpcode op_to_movi(TCGOpcode op)
>  static TCGArg find_better_copy(TCGContext *s, TCGArg arg)
>  {
>      TCGTemp *ts = arg_temp(arg);
> -    TCGArg i;
> +    TCGTemp *i;
>
>      /* If this is already a global, we can't do better. */
>      if (ts->temp_global) {
> @@ -127,17 +165,17 @@ static TCGArg find_better_copy(TCGContext *s, TCGArg arg)
>      }
>
>      /* Search for a global first. */
> -    for (i = temps[arg].next_copy ; i != arg; i = temps[i].next_copy) {
> -        if (i < s->nb_globals) {
> -            return i;
> +    for (i = ts_info(ts)->next_copy; i != ts; i = ts_info(i)->next_copy) {
> +        if (i->temp_global) {
> +            return temp_arg(i);
>          }
>      }
>
>      /* If it is a temp, search for a temp local. */
>      if (!ts->temp_local) {
> -        for (i = temps[arg].next_copy ; i != arg; i = temps[i].next_copy) {
> -            if (s->temps[i].temp_local) {
> -                return i;
> +        for (i = ts_info(ts)->next_copy; i != ts; i = ts_info(i)->next_copy) {
> +            if (ts->temp_local) {
> +                return temp_arg(i);
>              }
>          }
>      }
> @@ -146,20 +184,20 @@ static TCGArg find_better_copy(TCGContext *s, TCGArg arg)
>      return arg;
>  }
>
> -static bool temps_are_copies(TCGArg arg1, TCGArg arg2)
> +static bool ts_are_copies(TCGTemp *ts1, TCGTemp *ts2)
>  {
> -    TCGArg i;
> +    TCGTemp *i;
>
> -    if (arg1 == arg2) {
> +    if (ts1 == ts2) {
>          return true;
>      }
>
> -    if (!temp_is_copy(arg1) || !temp_is_copy(arg2)) {
> +    if (!ts_is_copy(ts1) || !ts_is_copy(ts2)) {
>          return false;
>      }
>
> -    for (i = temps[arg1].next_copy ; i != arg1 ; i = temps[i].next_copy) {
> -        if (i == arg2) {
> +    for (i = ts_info(ts1)->next_copy; i != ts1; i = ts_info(i)->next_copy) {
> +        if (i == ts2) {
>              return true;
>          }
>      }
> @@ -167,22 +205,28 @@ static bool temps_are_copies(TCGArg arg1, TCGArg arg2)
>      return false;
>  }
>
> +static bool args_are_copies(TCGArg arg1, TCGArg arg2)
> +{
> +    return ts_are_copies(arg_temp(arg1), arg_temp(arg2));
> +}
> +
>  static void tcg_opt_gen_movi(TCGContext *s, TCGOp *op, TCGArg dst, TCGArg val)
>  {
>      TCGOpcode new_op = op_to_movi(op->opc);
>      tcg_target_ulong mask;
> +    struct tcg_temp_info *di = arg_info(dst);
>
>      op->opc = new_op;
>
>      reset_temp(dst);
> -    temps[dst].is_const = true;
> -    temps[dst].val = val;
> +    di->is_const = true;
> +    di->val = val;
>      mask = val;
>      if (TCG_TARGET_REG_BITS > 32 && new_op == INDEX_op_movi_i32) {
>          /* High bits of the destination are now garbage.  */
>          mask |= ~0xffffffffull;
>      }
> -    temps[dst].mask = mask;
> +    di->mask = mask;
>
>      op->args[0] = dst;
>      op->args[1] = val;
> @@ -190,35 +234,44 @@ static void tcg_opt_gen_movi(TCGContext *s, TCGOp *op, TCGArg dst, TCGArg val)
>
>  static void tcg_opt_gen_mov(TCGContext *s, TCGOp *op, TCGArg dst, TCGArg src)
>  {
> -    if (temps_are_copies(dst, src)) {
> +    TCGTemp *dst_ts = arg_temp(dst);
> +    TCGTemp *src_ts = arg_temp(src);
> +    struct tcg_temp_info *di;
> +    struct tcg_temp_info *si;
> +    tcg_target_ulong mask;
> +    TCGOpcode new_op;
> +
> +    if (ts_are_copies(dst_ts, src_ts)) {
>          tcg_op_remove(s, op);
>          return;
>      }
>
> -    TCGOpcode new_op = op_to_mov(op->opc);
> -    tcg_target_ulong mask;
> +    reset_ts(dst_ts);
> +    di = ts_info(dst_ts);
> +    si = ts_info(src_ts);
> +    new_op = op_to_mov(op->opc);
>
>      op->opc = new_op;
> +    op->args[0] = dst;
> +    op->args[1] = src;
>
> -    reset_temp(dst);
> -    mask = temps[src].mask;
> +    mask = si->mask;
>      if (TCG_TARGET_REG_BITS > 32 && new_op == INDEX_op_mov_i32) {
>          /* High bits of the destination are now garbage.  */
>          mask |= ~0xffffffffull;
>      }
> -    temps[dst].mask = mask;
> -
> -    if (arg_temp(src)->type == arg_temp(dst)->type) {
> -        temps[dst].next_copy = temps[src].next_copy;
> -        temps[dst].prev_copy = src;
> -        temps[temps[dst].next_copy].prev_copy = dst;
> -        temps[src].next_copy = dst;
> -        temps[dst].is_const = temps[src].is_const;
> -        temps[dst].val = temps[src].val;
> -    }
> +    di->mask = mask;
>
> -    op->args[0] = dst;
> -    op->args[1] = src;
> +    if (src_ts->type == dst_ts->type) {
> +        struct tcg_temp_info *ni = ts_info(si->next_copy);
> +
> +        di->next_copy = si->next_copy;
> +        di->prev_copy = src_ts;
> +        ni->prev_copy = dst_ts;
> +        si->next_copy = dst_ts;
> +        di->is_const = si->is_const;
> +        di->val = si->val;
> +    }
>  }
>
>  static TCGArg do_constant_folding_2(TCGOpcode op, TCGArg x, TCGArg y)
> @@ -465,18 +518,20 @@ static bool do_constant_folding_cond_eq(TCGCond c)
>  static TCGArg do_constant_folding_cond(TCGOpcode op, TCGArg x,
>                                         TCGArg y, TCGCond c)
>  {
> -    if (temp_is_const(x) && temp_is_const(y)) {
> +    tcg_target_ulong xv = arg_info(x)->val;
> +    tcg_target_ulong yv = arg_info(y)->val;
> +    if (arg_is_const(x) && arg_is_const(y)) {
>          switch (op_bits(op)) {
>          case 32:
> -            return do_constant_folding_cond_32(temps[x].val, temps[y].val, c);
> +            return do_constant_folding_cond_32(xv, yv, c);
>          case 64:
> -            return do_constant_folding_cond_64(temps[x].val, temps[y].val, c);
> +            return do_constant_folding_cond_64(xv, yv, c);
>          default:
>              tcg_abort();
>          }
> -    } else if (temps_are_copies(x, y)) {
> +    } else if (args_are_copies(x, y)) {
>          return do_constant_folding_cond_eq(c);
> -    } else if (temp_is_const(y) && temps[y].val == 0) {
> +    } else if (arg_is_const(y) && yv == 0) {
>          switch (c) {
>          case TCG_COND_LTU:
>              return 0;
> @@ -496,12 +551,15 @@ static TCGArg do_constant_folding_cond2(TCGArg *p1, TCGArg *p2, TCGCond c)
>      TCGArg al = p1[0], ah = p1[1];
>      TCGArg bl = p2[0], bh = p2[1];
>
> -    if (temp_is_const(bl) && temp_is_const(bh)) {
> -        uint64_t b = ((uint64_t)temps[bh].val << 32) | (uint32_t)temps[bl].val;
> +    if (arg_is_const(bl) && arg_is_const(bh)) {
> +        tcg_target_ulong blv = arg_info(bl)->val;
> +        tcg_target_ulong bhv = arg_info(bh)->val;
> +        uint64_t b = deposit64(blv, 32, 32, bhv);
>
> -        if (temp_is_const(al) && temp_is_const(ah)) {
> -            uint64_t a;
> -            a = ((uint64_t)temps[ah].val << 32) | (uint32_t)temps[al].val;
> +        if (arg_is_const(al) && arg_is_const(ah)) {
> +            tcg_target_ulong alv = arg_info(al)->val;
> +            tcg_target_ulong ahv = arg_info(ah)->val;
> +            uint64_t a = deposit64(alv, 32, 32, ahv);
>              return do_constant_folding_cond_64(a, b, c);
>          }
>          if (b == 0) {
> @@ -515,7 +573,7 @@ static TCGArg do_constant_folding_cond2(TCGArg *p1, TCGArg *p2, TCGCond c)
>              }
>          }
>      }
> -    if (temps_are_copies(al, bl) && temps_are_copies(ah, bh)) {
> +    if (args_are_copies(al, bl) && args_are_copies(ah, bh)) {
>          return do_constant_folding_cond_eq(c);
>      }
>      return 2;
> @@ -525,8 +583,8 @@ static bool swap_commutative(TCGArg dest, TCGArg *p1, TCGArg *p2)
>  {
>      TCGArg a1 = *p1, a2 = *p2;
>      int sum = 0;
> -    sum += temp_is_const(a1);
> -    sum -= temp_is_const(a2);
> +    sum += arg_is_const(a1);
> +    sum -= arg_is_const(a2);
>
>      /* Prefer the constant in second argument, and then the form
>         op a, a, b, which is better handled on non-RISC hosts. */
> @@ -541,10 +599,10 @@ static bool swap_commutative(TCGArg dest, TCGArg *p1, TCGArg *p2)
>  static bool swap_commutative2(TCGArg *p1, TCGArg *p2)
>  {
>      int sum = 0;
> -    sum += temp_is_const(p1[0]);
> -    sum += temp_is_const(p1[1]);
> -    sum -= temp_is_const(p2[0]);
> -    sum -= temp_is_const(p2[1]);
> +    sum += arg_is_const(p1[0]);
> +    sum += arg_is_const(p1[1]);
> +    sum -= arg_is_const(p2[0]);
> +    sum -= arg_is_const(p2[1]);
>      if (sum > 0) {
>          TCGArg t;
>          t = p1[0], p1[0] = p2[0], p2[0] = t;
> @@ -586,22 +644,22 @@ void tcg_optimize(TCGContext *s)
>              nb_oargs = op->callo;
>              nb_iargs = op->calli;
>              for (i = 0; i < nb_oargs + nb_iargs; i++) {
> -                tmp = op->args[i];
> -                if (tmp != TCG_CALL_DUMMY_ARG) {
> -                    init_temp_info(tmp);
> +                TCGTemp *ts = arg_temp(op->args[i]);
> +                if (ts) {
> +                    init_ts_info(ts);
>                  }
>              }
>          } else {
>              nb_oargs = def->nb_oargs;
>              nb_iargs = def->nb_iargs;
>              for (i = 0; i < nb_oargs + nb_iargs; i++) {
> -                init_temp_info(op->args[i]);
> +                init_arg_info(op->args[i]);
>              }
>          }
>
>          /* Do copy propagation */
>          for (i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
> -            if (temp_is_copy(op->args[i])) {
> +            if (arg_is_copy(op->args[i])) {
>                  op->args[i] = find_better_copy(s, op->args[i]);
>              }
>          }
> @@ -671,7 +729,8 @@ void tcg_optimize(TCGContext *s)
>          CASE_OP_32_64(sar):
>          CASE_OP_32_64(rotl):
>          CASE_OP_32_64(rotr):
> -            if (temp_is_const(op->args[1]) && temps[op->args[1]].val == 0) {
> +            if (arg_is_const(op->args[1])
> +                && arg_info(op->args[1])->val == 0) {
>                  tcg_opt_gen_movi(s, op, op->args[0], 0);
>                  continue;
>              }
> @@ -681,7 +740,7 @@ void tcg_optimize(TCGContext *s)
>                  TCGOpcode neg_op;
>                  bool have_neg;
>
> -                if (temp_is_const(op->args[2])) {
> +                if (arg_is_const(op->args[2])) {
>                      /* Proceed with possible constant folding. */
>                      break;
>                  }
> @@ -695,8 +754,8 @@ void tcg_optimize(TCGContext *s)
>                  if (!have_neg) {
>                      break;
>                  }
> -                if (temp_is_const(op->args[1])
> -                    && temps[op->args[1]].val == 0) {
> +                if (arg_is_const(op->args[1])
> +                    && arg_info(op->args[1])->val == 0) {
>                      op->opc = neg_op;
>                      reset_temp(op->args[0]);
>                      op->args[1] = op->args[2];
> @@ -706,34 +765,34 @@ void tcg_optimize(TCGContext *s)
>              break;
>          CASE_OP_32_64(xor):
>          CASE_OP_32_64(nand):
> -            if (!temp_is_const(op->args[1])
> -                && temp_is_const(op->args[2])
> -                && temps[op->args[2]].val == -1) {
> +            if (!arg_is_const(op->args[1])
> +                && arg_is_const(op->args[2])
> +                && arg_info(op->args[2])->val == -1) {
>                  i = 1;
>                  goto try_not;
>              }
>              break;
>          CASE_OP_32_64(nor):
> -            if (!temp_is_const(op->args[1])
> -                && temp_is_const(op->args[2])
> -                && temps[op->args[2]].val == 0) {
> +            if (!arg_is_const(op->args[1])
> +                && arg_is_const(op->args[2])
> +                && arg_info(op->args[2])->val == 0) {
>                  i = 1;
>                  goto try_not;
>              }
>              break;
>          CASE_OP_32_64(andc):
> -            if (!temp_is_const(op->args[2])
> -                && temp_is_const(op->args[1])
> -                && temps[op->args[1]].val == -1) {
> +            if (!arg_is_const(op->args[2])
> +                && arg_is_const(op->args[1])
> +                && arg_info(op->args[1])->val == -1) {
>                  i = 2;
>                  goto try_not;
>              }
>              break;
>          CASE_OP_32_64(orc):
>          CASE_OP_32_64(eqv):
> -            if (!temp_is_const(op->args[2])
> -                && temp_is_const(op->args[1])
> -                && temps[op->args[1]].val == 0) {
> +            if (!arg_is_const(op->args[2])
> +                && arg_is_const(op->args[1])
> +                && arg_info(op->args[1])->val == 0) {
>                  i = 2;
>                  goto try_not;
>              }
> @@ -774,9 +833,9 @@ void tcg_optimize(TCGContext *s)
>          CASE_OP_32_64(or):
>          CASE_OP_32_64(xor):
>          CASE_OP_32_64(andc):
> -            if (!temp_is_const(op->args[1])
> -                && temp_is_const(op->args[2])
> -                && temps[op->args[2]].val == 0) {
> +            if (!arg_is_const(op->args[1])
> +                && arg_is_const(op->args[2])
> +                && arg_info(op->args[2])->val == 0) {
>                  tcg_opt_gen_mov(s, op, op->args[0], op->args[1]);
>                  continue;
>              }
> @@ -784,9 +843,9 @@ void tcg_optimize(TCGContext *s)
>          CASE_OP_32_64(and):
>          CASE_OP_32_64(orc):
>          CASE_OP_32_64(eqv):
> -            if (!temp_is_const(op->args[1])
> -                && temp_is_const(op->args[2])
> -                && temps[op->args[2]].val == -1) {
> +            if (!arg_is_const(op->args[1])
> +                && arg_is_const(op->args[2])
> +                && arg_info(op->args[2])->val == -1) {
>                  tcg_opt_gen_mov(s, op, op->args[0], op->args[1]);
>                  continue;
>              }
> @@ -801,21 +860,21 @@ void tcg_optimize(TCGContext *s)
>          affected = -1;
>          switch (opc) {
>          CASE_OP_32_64(ext8s):
> -            if ((temps[op->args[1]].mask & 0x80) != 0) {
> +            if ((arg_info(op->args[1])->mask & 0x80) != 0) {
>                  break;
>              }
>          CASE_OP_32_64(ext8u):
>              mask = 0xff;
>              goto and_const;
>          CASE_OP_32_64(ext16s):
> -            if ((temps[op->args[1]].mask & 0x8000) != 0) {
> +            if ((arg_info(op->args[1])->mask & 0x8000) != 0) {
>                  break;
>              }
>          CASE_OP_32_64(ext16u):
>              mask = 0xffff;
>              goto and_const;
>          case INDEX_op_ext32s_i64:
> -            if ((temps[op->args[1]].mask & 0x80000000) != 0) {
> +            if ((arg_info(op->args[1])->mask & 0x80000000) != 0) {
>                  break;
>              }
>          case INDEX_op_ext32u_i64:
> @@ -823,111 +882,114 @@ void tcg_optimize(TCGContext *s)
>              goto and_const;
>
>          CASE_OP_32_64(and):
> -            mask = temps[op->args[2]].mask;
> -            if (temp_is_const(op->args[2])) {
> +            mask = arg_info(op->args[2])->mask;
> +            if (arg_is_const(op->args[2])) {
>          and_const:
> -                affected = temps[op->args[1]].mask & ~mask;
> +                affected = arg_info(op->args[1])->mask & ~mask;
>              }
> -            mask = temps[op->args[1]].mask & mask;
> +            mask = arg_info(op->args[1])->mask & mask;
>              break;
>
>          case INDEX_op_ext_i32_i64:
> -            if ((temps[op->args[1]].mask & 0x80000000) != 0) {
> +            if ((arg_info(op->args[1])->mask & 0x80000000) != 0) {
>                  break;
>              }
>          case INDEX_op_extu_i32_i64:
>              /* We do not compute affected as it is a size changing op.  */
> -            mask = (uint32_t)temps[op->args[1]].mask;
> +            mask = (uint32_t)arg_info(op->args[1])->mask;
>              break;
>
>          CASE_OP_32_64(andc):
>              /* Known-zeros does not imply known-ones.  Therefore unless
>                 op->args[2] is constant, we can't infer anything from it.  */
> -            if (temp_is_const(op->args[2])) {
> -                mask = ~temps[op->args[2]].mask;
> +            if (arg_is_const(op->args[2])) {
> +                mask = ~arg_info(op->args[2])->mask;
>                  goto and_const;
>              }
> -            /* But we certainly know nothing outside op->args[1] may be set. */
> -            mask = temps[op->args[1]].mask;
> +            /* But we certainly know nothing outside args[1] may be set. */
> +            mask = arg_info(op->args[1])->mask;
>              break;
>
>          case INDEX_op_sar_i32:
> -            if (temp_is_const(op->args[2])) {
> -                tmp = temps[op->args[2]].val & 31;
> -                mask = (int32_t)temps[op->args[1]].mask >> tmp;
> +            if (arg_is_const(op->args[2])) {
> +                tmp = arg_info(op->args[2])->val & 31;
> +                mask = (int32_t)arg_info(op->args[1])->mask >> tmp;
>              }
>              break;
>          case INDEX_op_sar_i64:
> -            if (temp_is_const(op->args[2])) {
> -                tmp = temps[op->args[2]].val & 63;
> -                mask = (int64_t)temps[op->args[1]].mask >> tmp;
> +            if (arg_is_const(op->args[2])) {
> +                tmp = arg_info(op->args[2])->val & 63;
> +                mask = (int64_t)arg_info(op->args[1])->mask >> tmp;
>              }
>              break;
>
>          case INDEX_op_shr_i32:
> -            if (temp_is_const(op->args[2])) {
> -                tmp = temps[op->args[2]].val & 31;
> -                mask = (uint32_t)temps[op->args[1]].mask >> tmp;
> +            if (arg_is_const(op->args[2])) {
> +                tmp = arg_info(op->args[2])->val & 31;
> +                mask = (uint32_t)arg_info(op->args[1])->mask >> tmp;
>              }
>              break;
>          case INDEX_op_shr_i64:
> -            if (temp_is_const(op->args[2])) {
> -                tmp = temps[op->args[2]].val & 63;
> -                mask = (uint64_t)temps[op->args[1]].mask >> tmp;
> +            if (arg_is_const(op->args[2])) {
> +                tmp = arg_info(op->args[2])->val & 63;
> +                mask = (uint64_t)arg_info(op->args[1])->mask >> tmp;
>              }
>              break;
>
>          case INDEX_op_extrl_i64_i32:
> -            mask = (uint32_t)temps[op->args[1]].mask;
> +            mask = (uint32_t)arg_info(op->args[1])->mask;
>              break;
>          case INDEX_op_extrh_i64_i32:
> -            mask = (uint64_t)temps[op->args[1]].mask >> 32;
> +            mask = (uint64_t)arg_info(op->args[1])->mask >> 32;
>              break;
>
>          CASE_OP_32_64(shl):
> -            if (temp_is_const(op->args[2])) {
> -                tmp = temps[op->args[2]].val & (TCG_TARGET_REG_BITS - 1);
> -                mask = temps[op->args[1]].mask << tmp;
> +            if (arg_is_const(op->args[2])) {
> +                tmp = arg_info(op->args[2])->val & (TCG_TARGET_REG_BITS - 1);
> +                mask = arg_info(op->args[1])->mask << tmp;
>              }
>              break;
>
>          CASE_OP_32_64(neg):
>              /* Set to 1 all bits to the left of the rightmost.  */
> -            mask = -(temps[op->args[1]].mask & -temps[op->args[1]].mask);
> +            mask = -(arg_info(op->args[1])->mask
> +                     & -arg_info(op->args[1])->mask);
>              break;
>
>          CASE_OP_32_64(deposit):
> -            mask = deposit64(temps[op->args[1]].mask, op->args[3],
> -                             op->args[4], temps[op->args[2]].mask);
> +            mask = deposit64(arg_info(op->args[1])->mask,
> +                             op->args[3], op->args[4],
> +                             arg_info(op->args[2])->mask);
>              break;
>
>          CASE_OP_32_64(extract):
> -            mask = extract64(temps[op->args[1]].mask, op->args[2], op->args[3]);
> +            mask = extract64(arg_info(op->args[1])->mask,
> +                             op->args[2], op->args[3]);
>              if (op->args[2] == 0) {
> -                affected = temps[op->args[1]].mask & ~mask;
> +                affected = arg_info(op->args[1])->mask & ~mask;
>              }
>              break;
>          CASE_OP_32_64(sextract):
> -            mask = sextract64(temps[op->args[1]].mask,
> +            mask = sextract64(arg_info(op->args[1])->mask,
>                                op->args[2], op->args[3]);
>              if (op->args[2] == 0 && (tcg_target_long)mask >= 0) {
> -                affected = temps[op->args[1]].mask & ~mask;
> +                affected = arg_info(op->args[1])->mask & ~mask;
>              }
>              break;
>
>          CASE_OP_32_64(or):
>          CASE_OP_32_64(xor):
> -            mask = temps[op->args[1]].mask | temps[op->args[2]].mask;
> +            mask = arg_info(op->args[1])->mask | arg_info(op->args[2])->mask;
>              break;
>
>          case INDEX_op_clz_i32:
>          case INDEX_op_ctz_i32:
> -            mask = temps[op->args[2]].mask | 31;
> +            mask = arg_info(op->args[2])->mask | 31;
>              break;
>
>          case INDEX_op_clz_i64:
>          case INDEX_op_ctz_i64:
> -            mask = temps[op->args[2]].mask | 63;
> +            mask = arg_info(op->args[2])->mask | 63;
>              break;
>
>          case INDEX_op_ctpop_i32:
> @@ -943,7 +1005,7 @@ void tcg_optimize(TCGContext *s)
>              break;
>
>          CASE_OP_32_64(movcond):
> -            mask = temps[op->args[3]].mask | temps[op->args[4]].mask;
> +            mask = arg_info(op->args[3])->mask | arg_info(op->args[4])->mask;
>              break;
>
>          CASE_OP_32_64(ld8u):
> @@ -997,7 +1059,8 @@ void tcg_optimize(TCGContext *s)
>          CASE_OP_32_64(mul):
>          CASE_OP_32_64(muluh):
>          CASE_OP_32_64(mulsh):
> -            if ((temp_is_const(op->args[2]) && temps[op->args[2]].val == 0)) {
> +            if (arg_is_const(op->args[2])
> +                && arg_info(op->args[2])->val == 0) {
>                  tcg_opt_gen_movi(s, op, op->args[0], 0);
>                  continue;
>              }
> @@ -1010,7 +1073,7 @@ void tcg_optimize(TCGContext *s)
>          switch (opc) {
>          CASE_OP_32_64(or):
>          CASE_OP_32_64(and):
> -            if (temps_are_copies(op->args[1], op->args[2])) {
> +            if (args_are_copies(op->args[1], op->args[2])) {
>                  tcg_opt_gen_mov(s, op, op->args[0], op->args[1]);
>                  continue;
>              }
> @@ -1024,7 +1087,7 @@ void tcg_optimize(TCGContext *s)
>          CASE_OP_32_64(andc):
>          CASE_OP_32_64(sub):
>          CASE_OP_32_64(xor):
> -            if (temps_are_copies(op->args[1], op->args[2])) {
> +            if (args_are_copies(op->args[1], op->args[2])) {
>                  tcg_opt_gen_movi(s, op, op->args[0], 0);
>                  continue;
>              }
> @@ -1057,8 +1120,8 @@ void tcg_optimize(TCGContext *s)
>          case INDEX_op_extu_i32_i64:
>          case INDEX_op_extrl_i64_i32:
>          case INDEX_op_extrh_i64_i32:
> -            if (temp_is_const(op->args[1])) {
> -                tmp = do_constant_folding(opc, temps[op->args[1]].val, 0);
> +            if (arg_is_const(op->args[1])) {
> +                tmp = do_constant_folding(opc, arg_info(op->args[1])->val, 0);
>                  tcg_opt_gen_movi(s, op, op->args[0], tmp);
>                  break;
>              }
> @@ -1086,9 +1149,9 @@ void tcg_optimize(TCGContext *s)
>          CASE_OP_32_64(divu):
>          CASE_OP_32_64(rem):
>          CASE_OP_32_64(remu):
> -            if (temp_is_const(op->args[1]) && temp_is_const(op->args[2])) {
> -                tmp = do_constant_folding(opc, temps[op->args[1]].val,
> -                                          temps[op->args[2]].val);
> +            if (arg_is_const(op->args[1]) && arg_is_const(op->args[2])) {
> +                tmp = do_constant_folding(opc, arg_info(op->args[1])->val,
> +                                          arg_info(op->args[2])->val);
>                  tcg_opt_gen_movi(s, op, op->args[0], tmp);
>                  break;
>              }
> @@ -1096,8 +1159,8 @@ void tcg_optimize(TCGContext *s)
>
>          CASE_OP_32_64(clz):
>          CASE_OP_32_64(ctz):
> -            if (temp_is_const(op->args[1])) {
> -                TCGArg v = temps[op->args[1]].val;
> +            if (arg_is_const(op->args[1])) {
> +                TCGArg v = arg_info(op->args[1])->val;
>                  if (v != 0) {
>                      tmp = do_constant_folding(opc, v, 0);
>                      tcg_opt_gen_movi(s, op, op->args[0], tmp);
> @@ -1109,17 +1172,18 @@ void tcg_optimize(TCGContext *s)
>              goto do_default;
>
>          CASE_OP_32_64(deposit):
> -            if (temp_is_const(op->args[1]) && temp_is_const(op->args[2])) {
> -                tmp = deposit64(temps[op->args[1]].val, op->args[3],
> -                                op->args[4], temps[op->args[2]].val);
> +            if (arg_is_const(op->args[1]) && arg_is_const(op->args[2])) {
> +                tmp = deposit64(arg_info(op->args[1])->val,
> +                                op->args[3], op->args[4],
> +                                arg_info(op->args[2])->val);
>                  tcg_opt_gen_movi(s, op, op->args[0], tmp);
>                  break;
>              }
>              goto do_default;
>
>          CASE_OP_32_64(extract):
> -            if (temp_is_const(op->args[1])) {
> -                tmp = extract64(temps[op->args[1]].val,
> +            if (arg_is_const(op->args[1])) {
> +                tmp = extract64(arg_info(op->args[1])->val,
>                                  op->args[2], op->args[3]);
>                  tcg_opt_gen_movi(s, op, op->args[0], tmp);
>                  break;
> @@ -1127,8 +1191,8 @@ void tcg_optimize(TCGContext *s)
>              goto do_default;
>
>          CASE_OP_32_64(sextract):
> -            if (temp_is_const(op->args[1])) {
> -                tmp = sextract64(temps[op->args[1]].val,
> +            if (arg_is_const(op->args[1])) {
> +                tmp = sextract64(arg_info(op->args[1])->val,
>                                   op->args[2], op->args[3]);
>                  tcg_opt_gen_movi(s, op, op->args[0], tmp);
>                  break;
> @@ -1166,9 +1230,9 @@ void tcg_optimize(TCGContext *s)
>                  tcg_opt_gen_mov(s, op, op->args[0], op->args[4-tmp]);
>                  break;
>              }
> -            if (temp_is_const(op->args[3]) && temp_is_const(op->args[4])) {
> -                tcg_target_ulong tv = temps[op->args[3]].val;
> -                tcg_target_ulong fv = temps[op->args[4]].val;
> +            if (arg_is_const(op->args[3]) && arg_is_const(op->args[4])) {
> +                tcg_target_ulong tv = arg_info(op->args[3])->val;
> +                tcg_target_ulong fv = arg_info(op->args[4])->val;
>                  TCGCond cond = op->args[5];
>                  if (fv == 1 && tv == 0) {
>                      cond = tcg_invert_cond(cond);
> @@ -1185,12 +1249,12 @@ void tcg_optimize(TCGContext *s)
>
>          case INDEX_op_add2_i32:
>          case INDEX_op_sub2_i32:
> -            if (temp_is_const(op->args[2]) && temp_is_const(op->args[3])
> -                && temp_is_const(op->args[4]) && temp_is_const(op->args[5])) {
> -                uint32_t al = temps[op->args[2]].val;
> -                uint32_t ah = temps[op->args[3]].val;
> -                uint32_t bl = temps[op->args[4]].val;
> -                uint32_t bh = temps[op->args[5]].val;
> +            if (arg_is_const(op->args[2]) && arg_is_const(op->args[3])
> +                && arg_is_const(op->args[4]) && arg_is_const(op->args[5])) {
> +                uint32_t al = arg_info(op->args[2])->val;
> +                uint32_t ah = arg_info(op->args[3])->val;
> +                uint32_t bl = arg_info(op->args[4])->val;
> +                uint32_t bh = arg_info(op->args[5])->val;
>                  uint64_t a = ((uint64_t)ah << 32) | al;
>                  uint64_t b = ((uint64_t)bh << 32) | bl;
>                  TCGArg rl, rh;
> @@ -1214,9 +1278,9 @@ void tcg_optimize(TCGContext *s)
>              goto do_default;
>
>          case INDEX_op_mulu2_i32:
> -            if (temp_is_const(op->args[2]) && temp_is_const(op->args[3])) {
> -                uint32_t a = temps[op->args[2]].val;
> -                uint32_t b = temps[op->args[3]].val;
> +            if (arg_is_const(op->args[2]) && arg_is_const(op->args[3])) {
> +                uint32_t a = arg_info(op->args[2])->val;
> +                uint32_t b = arg_info(op->args[3])->val;
>                  uint64_t r = (uint64_t)a * b;
>                  TCGArg rl, rh;
>                  TCGOp *op2 = tcg_op_insert_before(s, op, INDEX_op_movi_i32, 2);
> @@ -1247,10 +1311,10 @@ void tcg_optimize(TCGContext *s)
>                  }
>              } else if ((op->args[4] == TCG_COND_LT
>                          || op->args[4] == TCG_COND_GE)
> -                       && temp_is_const(op->args[2])
> -                       && temps[op->args[2]].val == 0
> -                       && temp_is_const(op->args[3])
> -                       && temps[op->args[3]].val == 0) {
> +                       && arg_is_const(op->args[2])
> +                       && arg_info(op->args[2])->val == 0
> +                       && arg_is_const(op->args[3])
> +                       && arg_info(op->args[3])->val == 0) {
>                  /* Simplify LT/GE comparisons vs zero to a single compare
>                     vs the high word of the input.  */
>              do_brcond_high:
> @@ -1318,15 +1382,15 @@ void tcg_optimize(TCGContext *s)
>                  tcg_opt_gen_movi(s, op, op->args[0], tmp);
>              } else if ((op->args[5] == TCG_COND_LT
>                          || op->args[5] == TCG_COND_GE)
> -                       && temp_is_const(op->args[3])
> -                       && temps[op->args[3]].val == 0
> -                       && temp_is_const(op->args[4])
> -                       && temps[op->args[4]].val == 0) {
> +                       && arg_is_const(op->args[3])
> +                       && arg_info(op->args[3])->val == 0
> +                       && arg_is_const(op->args[4])
> +                       && arg_info(op->args[4])->val == 0) {
>                  /* Simplify LT/GE comparisons vs zero to a single compare
>                     vs the high word of the input.  */
>              do_setcond_high:
>                  reset_temp(op->args[0]);
> -                temps[op->args[0]].mask = 1;
> +                arg_info(op->args[0])->mask = 1;
>                  op->opc = INDEX_op_setcond_i32;
>                  op->args[1] = op->args[2];
>                  op->args[2] = op->args[4];
> @@ -1352,7 +1416,7 @@ void tcg_optimize(TCGContext *s)
>                  }
>              do_setcond_low:
>                  reset_temp(op->args[0]);
> -                temps[op->args[0]].mask = 1;
> +                arg_info(op->args[0])->mask = 1;
>                  op->opc = INDEX_op_setcond_i32;
>                  op->args[2] = op->args[3];
>                  op->args[3] = op->args[5];
> @@ -1386,7 +1450,7 @@ void tcg_optimize(TCGContext *s)
>                    & (TCG_CALL_NO_READ_GLOBALS | TCG_CALL_NO_WRITE_GLOBALS))) {
>                  for (i = 0; i < nb_globals; i++) {
>                      if (test_bit(i, temps_used.l)) {
> -                        reset_temp(i);
> +                        reset_ts(&s->temps[i]);
>                      }
>                  }
>              }
> @@ -1408,7 +1472,7 @@ void tcg_optimize(TCGContext *s)
>                      /* Save the corresponding known-zero bits mask for the
>                         first output argument (only one supported so far). */
>                      if (i == 0) {
> -                        temps[op->args[i]].mask = mask;
> +                        arg_info(op->args[i])->mask = mask;
>                      }
>                  }
>              }
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index b75a745..018c01c 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -750,6 +750,11 @@ static inline TCGTemp *arg_temp(TCGArg a)
>      return a == TCG_CALL_DUMMY_ARG ? NULL : &tcg_ctx.temps[a];
>  }
>
> +static inline size_t arg_index(TCGArg a)
> +{
> +    return a;
> +}
> +
>  static inline void tcg_set_insn_param(int op_idx, int arg, TCGArg v)
>  {
>      tcg_ctx.gen_op_buf[op_idx].args[arg] = v;


--
Alex Bennée
