Received: from eggs.gnu.org ([2001:4830:134:3::10]:55869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ej15z-0001kd-9A
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:07:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ej15q-0001tX-Rv
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:07:27 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:37844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ej15q-0001tC-HQ
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:07:18 -0500
Received: by mail-wr0-x243.google.com with SMTP id a43so1449426wrc.4
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 03:07:18 -0800 (PST)
References: <20180126045742.5487-1-richard.henderson@linaro.org>
	<20180126045742.5487-11-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180126045742.5487-11-richard.henderson@linaro.org>
Date: Tue, 06 Feb 2018 11:07:15 +0000
Message-ID: <87o9l2wf4s.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 10/20] tcg/optimize: Handle vector
 opcodes during optimize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Trivial move and constant propagation.  Some identity and constant
> function folding, but nothing that requires knowledge of the size
> of the vector element.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/optimize.c | 150 +++++++++++++++++++++++++++++----------------------=
------
>  1 file changed, 77 insertions(+), 73 deletions(-)
>
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 2cbbeefd53..d4ea67e541 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -32,6 +32,11 @@
>          glue(glue(case INDEX_op_, x), _i32):    \
>          glue(glue(case INDEX_op_, x), _i64)
>
> +#define CASE_OP_32_64_VEC(x)                    \
> +        glue(glue(case INDEX_op_, x), _i32):    \
> +        glue(glue(case INDEX_op_, x), _i64):    \
> +        glue(glue(case INDEX_op_, x), _vec)
> +
>  struct tcg_temp_info {
>      bool is_const;
>      TCGTemp *prev_copy;
> @@ -108,40 +113,6 @@ static void init_arg_info(struct tcg_temp_info *info=
s,
>      init_ts_info(infos, temps_used, arg_temp(arg));
>  }
>
> -static int op_bits(TCGOpcode op)
> -{
> -    const TCGOpDef *def =3D &tcg_op_defs[op];
> -    return def->flags & TCG_OPF_64BIT ? 64 : 32;
> -}
> -
> -static TCGOpcode op_to_mov(TCGOpcode op)
> -{
> -    switch (op_bits(op)) {
> -    case 32:
> -        return INDEX_op_mov_i32;
> -    case 64:
> -        return INDEX_op_mov_i64;
> -    default:
> -        fprintf(stderr, "op_to_mov: unexpected return value of "
> -                "function op_bits.\n");
> -        tcg_abort();
> -    }
> -}
> -
> -static TCGOpcode op_to_movi(TCGOpcode op)
> -{
> -    switch (op_bits(op)) {
> -    case 32:
> -        return INDEX_op_movi_i32;
> -    case 64:
> -        return INDEX_op_movi_i64;
> -    default:
> -        fprintf(stderr, "op_to_movi: unexpected return value of "
> -                "function op_bits.\n");
> -        tcg_abort();
> -    }
> -}
> -
>  static TCGTemp *find_better_copy(TCGContext *s, TCGTemp *ts)
>  {
>      TCGTemp *i;
> @@ -199,11 +170,23 @@ static bool args_are_copies(TCGArg arg1, TCGArg arg=
2)
>
>  static void tcg_opt_gen_movi(TCGContext *s, TCGOp *op, TCGArg dst, TCGAr=
g val)
>  {
> -    TCGOpcode new_op =3D op_to_movi(op->opc);
> +    const TCGOpDef *def;
> +    TCGOpcode new_op;
>      tcg_target_ulong mask;
>      struct tcg_temp_info *di =3D arg_info(dst);
>
> +    def =3D &tcg_op_defs[op->opc];
> +    if (def->flags & TCG_OPF_VECTOR) {
> +        new_op =3D INDEX_op_dupi_vec;
> +    } else if (def->flags & TCG_OPF_64BIT) {
> +        new_op =3D INDEX_op_movi_i64;
> +    } else {
> +        new_op =3D INDEX_op_movi_i32;
> +    }
>      op->opc =3D new_op;
> +    /* TCGOP_VECL and TCGOP_VECE remain unchanged.  */
> +    op->args[0] =3D dst;
> +    op->args[1] =3D val;
>
>      reset_temp(dst);
>      di->is_const =3D true;
> @@ -214,15 +197,13 @@ static void tcg_opt_gen_movi(TCGContext *s, TCGOp *=
op, TCGArg dst, TCGArg val)
>          mask |=3D ~0xffffffffull;
>      }
>      di->mask =3D mask;
> -
> -    op->args[0] =3D dst;
> -    op->args[1] =3D val;
>  }
>
>  static void tcg_opt_gen_mov(TCGContext *s, TCGOp *op, TCGArg dst, TCGArg=
 src)
>  {
>      TCGTemp *dst_ts =3D arg_temp(dst);
>      TCGTemp *src_ts =3D arg_temp(src);
> +    const TCGOpDef *def;
>      struct tcg_temp_info *di;
>      struct tcg_temp_info *si;
>      tcg_target_ulong mask;
> @@ -236,9 +217,16 @@ static void tcg_opt_gen_mov(TCGContext *s, TCGOp *op=
, TCGArg dst, TCGArg src)
>      reset_ts(dst_ts);
>      di =3D ts_info(dst_ts);
>      si =3D ts_info(src_ts);
> -    new_op =3D op_to_mov(op->opc);
> -
> +    def =3D &tcg_op_defs[op->opc];
> +    if (def->flags & TCG_OPF_VECTOR) {
> +        new_op =3D INDEX_op_mov_vec;
> +    } else if (def->flags & TCG_OPF_64BIT) {
> +        new_op =3D INDEX_op_mov_i64;
> +    } else {
> +        new_op =3D INDEX_op_mov_i32;
> +    }
>      op->opc =3D new_op;
> +    /* TCGOP_VECL and TCGOP_VECE remain unchanged.  */
>      op->args[0] =3D dst;
>      op->args[1] =3D src;
>
> @@ -417,8 +405,9 @@ static TCGArg do_constant_folding_2(TCGOpcode op, TCG=
Arg x, TCGArg y)
>
>  static TCGArg do_constant_folding(TCGOpcode op, TCGArg x, TCGArg y)
>  {
> +    const TCGOpDef *def =3D &tcg_op_defs[op];
>      TCGArg res =3D do_constant_folding_2(op, x, y);
> -    if (op_bits(op) =3D=3D 32) {
> +    if (!(def->flags & TCG_OPF_64BIT)) {
>          res =3D (int32_t)res;
>      }
>      return res;
> @@ -508,13 +497,12 @@ static TCGArg do_constant_folding_cond(TCGOpcode op=
, TCGArg x,
>      tcg_target_ulong xv =3D arg_info(x)->val;
>      tcg_target_ulong yv =3D arg_info(y)->val;
>      if (arg_is_const(x) && arg_is_const(y)) {
> -        switch (op_bits(op)) {
> -        case 32:
> -            return do_constant_folding_cond_32(xv, yv, c);
> -        case 64:
> +        const TCGOpDef *def =3D &tcg_op_defs[op];
> +        tcg_debug_assert(!(def->flags & TCG_OPF_VECTOR));
> +        if (def->flags & TCG_OPF_64BIT) {
>              return do_constant_folding_cond_64(xv, yv, c);
> -        default:
> -            tcg_abort();
> +        } else {
> +            return do_constant_folding_cond_32(xv, yv, c);
>          }
>      } else if (args_are_copies(x, y)) {
>          return do_constant_folding_cond_eq(c);
> @@ -653,11 +641,11 @@ void tcg_optimize(TCGContext *s)
>
>          /* For commutative operations make constant second argument */
>          switch (opc) {
> -        CASE_OP_32_64(add):
> -        CASE_OP_32_64(mul):
> -        CASE_OP_32_64(and):
> -        CASE_OP_32_64(or):
> -        CASE_OP_32_64(xor):
> +        CASE_OP_32_64_VEC(add):
> +        CASE_OP_32_64_VEC(mul):
> +        CASE_OP_32_64_VEC(and):
> +        CASE_OP_32_64_VEC(or):
> +        CASE_OP_32_64_VEC(xor):
>          CASE_OP_32_64(eqv):
>          CASE_OP_32_64(nand):
>          CASE_OP_32_64(nor):
> @@ -722,7 +710,7 @@ void tcg_optimize(TCGContext *s)
>                  continue;
>              }
>              break;
> -        CASE_OP_32_64(sub):
> +        CASE_OP_32_64_VEC(sub):
>              {
>                  TCGOpcode neg_op;
>                  bool have_neg;
> @@ -734,9 +722,12 @@ void tcg_optimize(TCGContext *s)
>                  if (opc =3D=3D INDEX_op_sub_i32) {
>                      neg_op =3D INDEX_op_neg_i32;
>                      have_neg =3D TCG_TARGET_HAS_neg_i32;
> -                } else {
> +                } else if (opc =3D=3D INDEX_op_sub_i64) {
>                      neg_op =3D INDEX_op_neg_i64;
>                      have_neg =3D TCG_TARGET_HAS_neg_i64;
> +                } else {
> +                    neg_op =3D INDEX_op_neg_vec;
> +                    have_neg =3D TCG_TARGET_HAS_neg_vec;
>                  }
>                  if (!have_neg) {
>                      break;
> @@ -750,7 +741,7 @@ void tcg_optimize(TCGContext *s)
>                  }
>              }
>              break;
> -        CASE_OP_32_64(xor):
> +        CASE_OP_32_64_VEC(xor):
>          CASE_OP_32_64(nand):
>              if (!arg_is_const(op->args[1])
>                  && arg_is_const(op->args[2])
> @@ -767,7 +758,7 @@ void tcg_optimize(TCGContext *s)
>                  goto try_not;
>              }
>              break;
> -        CASE_OP_32_64(andc):
> +        CASE_OP_32_64_VEC(andc):
>              if (!arg_is_const(op->args[2])
>                  && arg_is_const(op->args[1])
>                  && arg_info(op->args[1])->val =3D=3D -1) {
> @@ -775,7 +766,7 @@ void tcg_optimize(TCGContext *s)
>                  goto try_not;
>              }
>              break;
> -        CASE_OP_32_64(orc):
> +        CASE_OP_32_64_VEC(orc):
>          CASE_OP_32_64(eqv):
>              if (!arg_is_const(op->args[2])
>                  && arg_is_const(op->args[1])
> @@ -789,7 +780,10 @@ void tcg_optimize(TCGContext *s)
>                  TCGOpcode not_op;
>                  bool have_not;
>
> -                if (def->flags & TCG_OPF_64BIT) {
> +                if (def->flags & TCG_OPF_VECTOR) {
> +                    not_op =3D INDEX_op_not_vec;
> +                    have_not =3D TCG_TARGET_HAS_not_vec;
> +                } else if (def->flags & TCG_OPF_64BIT) {
>                      not_op =3D INDEX_op_not_i64;
>                      have_not =3D TCG_TARGET_HAS_not_i64;
>                  } else {
> @@ -810,16 +804,16 @@ void tcg_optimize(TCGContext *s)
>
>          /* Simplify expression for "op r, a, const =3D> mov r, a" cases =
*/
>          switch (opc) {
> -        CASE_OP_32_64(add):
> -        CASE_OP_32_64(sub):
> +        CASE_OP_32_64_VEC(add):
> +        CASE_OP_32_64_VEC(sub):
> +        CASE_OP_32_64_VEC(or):
> +        CASE_OP_32_64_VEC(xor):
> +        CASE_OP_32_64_VEC(andc):
>          CASE_OP_32_64(shl):
>          CASE_OP_32_64(shr):
>          CASE_OP_32_64(sar):
>          CASE_OP_32_64(rotl):
>          CASE_OP_32_64(rotr):
> -        CASE_OP_32_64(or):
> -        CASE_OP_32_64(xor):
> -        CASE_OP_32_64(andc):
>              if (!arg_is_const(op->args[1])
>                  && arg_is_const(op->args[2])
>                  && arg_info(op->args[2])->val =3D=3D 0) {
> @@ -827,8 +821,8 @@ void tcg_optimize(TCGContext *s)
>                  continue;
>              }
>              break;
> -        CASE_OP_32_64(and):
> -        CASE_OP_32_64(orc):
> +        CASE_OP_32_64_VEC(and):
> +        CASE_OP_32_64_VEC(orc):
>          CASE_OP_32_64(eqv):
>              if (!arg_is_const(op->args[1])
>                  && arg_is_const(op->args[2])
> @@ -1042,8 +1036,8 @@ void tcg_optimize(TCGContext *s)
>
>          /* Simplify expression for "op r, a, 0 =3D> movi r, 0" cases */
>          switch (opc) {
> -        CASE_OP_32_64(and):
> -        CASE_OP_32_64(mul):
> +        CASE_OP_32_64_VEC(and):
> +        CASE_OP_32_64_VEC(mul):
>          CASE_OP_32_64(muluh):
>          CASE_OP_32_64(mulsh):
>              if (arg_is_const(op->args[2])
> @@ -1058,8 +1052,8 @@ void tcg_optimize(TCGContext *s)
>
>          /* Simplify expression for "op r, a, a =3D> mov r, a" cases */
>          switch (opc) {
> -        CASE_OP_32_64(or):
> -        CASE_OP_32_64(and):
> +        CASE_OP_32_64_VEC(or):
> +        CASE_OP_32_64_VEC(and):
>              if (args_are_copies(op->args[1], op->args[2])) {
>                  tcg_opt_gen_mov(s, op, op->args[0], op->args[1]);
>                  continue;
> @@ -1071,9 +1065,9 @@ void tcg_optimize(TCGContext *s)
>
>          /* Simplify expression for "op r, a, a =3D> movi r, 0" cases */
>          switch (opc) {
> -        CASE_OP_32_64(andc):
> -        CASE_OP_32_64(sub):
> -        CASE_OP_32_64(xor):
> +        CASE_OP_32_64_VEC(andc):
> +        CASE_OP_32_64_VEC(sub):
> +        CASE_OP_32_64_VEC(xor):
>              if (args_are_copies(op->args[1], op->args[2])) {
>                  tcg_opt_gen_movi(s, op, op->args[0], 0);
>                  continue;
> @@ -1087,13 +1081,23 @@ void tcg_optimize(TCGContext *s)
>             folding.  Constants will be substituted to arguments by regis=
ter
>             allocator where needed and possible.  Also detect copies. */
>          switch (opc) {
> -        CASE_OP_32_64(mov):
> +        CASE_OP_32_64_VEC(mov):
>              tcg_opt_gen_mov(s, op, op->args[0], op->args[1]);
>              break;
>          CASE_OP_32_64(movi):
> +        case INDEX_op_dupi_vec:
>              tcg_opt_gen_movi(s, op, op->args[0], op->args[1]);
>              break;
>
> +        case INDEX_op_dup_vec:
> +            if (arg_is_const(op->args[1])) {
> +                tmp =3D arg_info(op->args[1])->val;
> +                tmp =3D dup_const(TCGOP_VECE(op), tmp);
> +                tcg_opt_gen_movi(s, op, op->args[0], tmp);
> +                continue;
> +            }
> +            break;
> +
>          CASE_OP_32_64(not):
>          CASE_OP_32_64(neg):
>          CASE_OP_32_64(ext8s):


--
Alex Benn=C3=A9e
