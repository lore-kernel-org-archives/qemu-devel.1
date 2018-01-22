Received: from eggs.gnu.org ([2001:4830:134:3::10]:47933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edhEQ-00069l-2m
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 13:54:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edhEO-0007Ie-AI
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 13:54:10 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:38398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1edhEO-0007IR-42
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 13:54:08 -0500
Received: by mail-ot0-x244.google.com with SMTP id v5so8408708oth.5
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 10:54:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180117161435.28981-3-richard.henderson@linaro.org>
References: <20180117161435.28981-1-richard.henderson@linaro.org>
	<20180117161435.28981-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2018 18:53:46 +0000
Message-ID: <CAFEAcA-R0XrQrLRAt5XQtOki0jk1qFnPuBQsf7a5xh2MX37usA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v10.5 02/20] tcg: Add types and basic
 operations for host vectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 17 January 2018 at 16:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Nothing uses or enables them yet.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  Makefile.target  |   4 +-
>  tcg/tcg-op.h     |  30 +++++
>  tcg/tcg-opc.h    |  26 ++++
>  tcg/tcg.h        |  56 +++++++++
>  tcg/tcg-op-vec.c | 362 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tcg/tcg.c        | 100 ++++++++++++++-
>  tcg/README       |  58 +++++++++
>  7 files changed, 630 insertions(+), 6 deletions(-)
>  create mode 100644 tcg/tcg-op-vec.c

> --- /dev/null
> +++ b/tcg/tcg-op-vec.c
> @@ -0,0 +1,362 @@
> +/*
> + * Tiny Code Generator for QEMU
> + *
> + * Copyright (c) 2008 Fabrice Bellard

Surely this should have some newer date and copyright owner too?


> +void vec_gen_2(TCGOpcode opc, TCGType type, unsigned vece, TCGArg r, TCGArg a)
> +{
> +    TCGOp *op = tcg_emit_op(opc);
> +    TCGOP_VECL(op) = type - TCG_TYPE_V64;
> +    TCGOP_VECE(op) = vece;
> +    op->args[0] = r;
> +    op->args[1] = a;
> +}
> +
> +void vec_gen_3(TCGOpcode opc, TCGType type, unsigned vece,
> +               TCGArg r, TCGArg a, TCGArg b)
> +{
> +    TCGOp *op = tcg_emit_op(opc);
> +    TCGOP_VECL(op) = type - TCG_TYPE_V64;
> +    TCGOP_VECE(op) = vece;
> +    op->args[0] = r;
> +    op->args[1] = a;
> +    op->args[2] = b;
> +}
> +
> +void vec_gen_4(TCGOpcode opc, TCGType type, unsigned vece,
> +               TCGArg r, TCGArg a, TCGArg b, TCGArg c)
> +{
> +    TCGOp *op = tcg_emit_op(opc);
> +    TCGOP_VECL(op) = type - TCG_TYPE_V64;
> +    TCGOP_VECE(op) = vece;
> +    op->args[0] = r;
> +    op->args[1] = a;
> +    op->args[2] = b;
> +    op->args[3] = c;
> +}
> +
> +static void vec_gen_op2(TCGOpcode opc, unsigned vece, TCGv_vec r, TCGv_vec a)
> +{
> +    TCGTemp *rt = tcgv_vec_temp(r);
> +    TCGTemp *at = tcgv_vec_temp(a);
> +    TCGType type = rt->base_type;
> +
> +    tcg_debug_assert(at->base_type == type);
> +    vec_gen_2(opc, type, vece, temp_arg(rt), temp_arg(at));
> +}
> +
> +static void vec_gen_op3(TCGOpcode opc, unsigned vece,
> +                        TCGv_vec r, TCGv_vec a, TCGv_vec b)
> +{
> +    TCGTemp *rt = tcgv_vec_temp(r);
> +    TCGTemp *at = tcgv_vec_temp(a);
> +    TCGTemp *bt = tcgv_vec_temp(b);
> +    TCGType type = rt->base_type;
> +
> +    tcg_debug_assert(at->base_type == type);
> +    tcg_debug_assert(bt->base_type == type);
> +    vec_gen_3(opc, type, vece, temp_arg(rt), temp_arg(at), temp_arg(bt));
> +}
> +
> +void tcg_gen_mov_vec(TCGv_vec r, TCGv_vec a)
> +{
> +    if (r != a) {
> +        vec_gen_op2(INDEX_op_mov_vec, 0, r, a);
> +    }
> +}
> +
> +#define MO_REG  (TCG_TARGET_REG_BITS == 64 ? MO_64 : MO_32)
> +
> +static void tcg_gen_dupi_vec(TCGv_vec r, unsigned vece, TCGArg a)
> +{
> +    TCGTemp *rt = tcgv_vec_temp(r);
> +    vec_gen_2(INDEX_op_dupi_vec, rt->base_type, vece, temp_arg(rt), a);
> +}
> +
> +TCGv_vec tcg_const_zeros_vec(TCGType type)
> +{
> +    TCGv_vec ret = tcg_temp_new_vec(type);
> +    tcg_gen_dupi_vec(ret, MO_REG, 0);
> +    return ret;
> +}
> +
> +TCGv_vec tcg_const_ones_vec(TCGType type)
> +{
> +    TCGv_vec ret = tcg_temp_new_vec(type);
> +    tcg_gen_dupi_vec(ret, MO_REG, -1);
> +    return ret;
> +}
> +
> +TCGv_vec tcg_const_zeros_vec_matching(TCGv_vec m)
> +{
> +    TCGTemp *t = tcgv_vec_temp(m);
> +    return tcg_const_zeros_vec(t->base_type);
> +}
> +
> +TCGv_vec tcg_const_ones_vec_matching(TCGv_vec m)
> +{
> +    TCGTemp *t = tcgv_vec_temp(m);
> +    return tcg_const_ones_vec(t->base_type);
> +}
> +
> +void tcg_gen_dup64i_vec(TCGv_vec r, uint64_t a)
> +{
> +    if (TCG_TARGET_REG_BITS == 32 && a == deposit64(a, 32, 32, a)) {
> +        tcg_gen_dupi_vec(r, MO_32, a);
> +    } else if (TCG_TARGET_REG_BITS == 64 || a == (uint64_t)(int32_t)a) {
> +        tcg_gen_dupi_vec(r, MO_64, a);
> +    } else {
> +        TCGv_i64 c = tcg_const_i64(a);
> +        tcg_gen_dup_i64_vec(MO_64, r, c);
> +        tcg_temp_free_i64(c);
> +    }
> +}
> +
> +void tcg_gen_dup32i_vec(TCGv_vec r, uint32_t a)
> +{
> +    tcg_gen_dupi_vec(r, MO_REG, ((TCGArg)-1 / 0xffffffffu) * a);
> +}
> +
> +void tcg_gen_dup16i_vec(TCGv_vec r, uint32_t a)
> +{
> +    tcg_gen_dupi_vec(r, MO_REG, ((TCGArg)-1 / 0xffff) * (a & 0xffff));
> +}
> +
> +void tcg_gen_dup8i_vec(TCGv_vec r, uint32_t a)
> +{
> +    tcg_gen_dupi_vec(r, MO_REG, ((TCGArg)-1 / 0xff) * (a & 0xff));
> +}
> +
> +void tcg_gen_movi_v64(TCGv_vec r, uint64_t a)
> +{
> +    TCGTemp *rt = tcgv_vec_temp(r);
> +    TCGArg ri = temp_arg(rt);
> +
> +    tcg_debug_assert(rt->base_type == TCG_TYPE_V64);
> +    if (TCG_TARGET_REG_BITS == 64) {
> +        vec_gen_2(INDEX_op_movi_vec, TCG_TYPE_V64, 0, ri, a);
> +    } else {
> +        vec_gen_3(INDEX_op_movi_vec, TCG_TYPE_V64, 0, ri, a, a >> 32);
> +    }
> +}
> +
> +void tcg_gen_movi_v128(TCGv_vec r, uint64_t a, uint64_t b)
> +{
> +    TCGTemp *rt = tcgv_vec_temp(r);
> +    TCGArg ri = temp_arg(rt);
> +
> +    tcg_debug_assert(rt->base_type == TCG_TYPE_V128);
> +    if (a == b) {
> +        tcg_gen_dup64i_vec(r, a);
> +    } else if (TCG_TARGET_REG_BITS == 64) {
> +        vec_gen_3(INDEX_op_movi_vec, TCG_TYPE_V128, 0, ri, a, b);
> +    } else {
> +        TCGOp *op = tcg_emit_op(INDEX_op_movi_vec);
> +        TCGOP_VECL(op) = TCG_TYPE_V128 - TCG_TYPE_V64;
> +        op->args[0] = ri;
> +        op->args[1] = a;
> +        op->args[2] = a >> 32;
> +        op->args[3] = b;
> +        op->args[4] = b >> 32;

Is it intentional that this doesn't set TCGOP_VECE(op) ?
The vec_gen_* functions all do.

This seems like it ought to be a vec_gen_5().

> +    }
> +}
> +
> +void tcg_gen_movi_v256(TCGv_vec r, uint64_t a, uint64_t b,
> +                       uint64_t c, uint64_t d)
> +{
> +    TCGArg ri = tcgv_vec_arg(r);
> +    TCGTemp *rt = arg_temp(ri);
> +
> +    tcg_debug_assert(rt->base_type == TCG_TYPE_V256);
> +    if (a == b && a == c && a == d) {
> +        tcg_gen_dup64i_vec(r, a);
> +    } else {
> +        TCGOp *op = tcg_emit_op(INDEX_op_movi_vec);
> +        TCGOP_VECL(op) = TCG_TYPE_V256 - TCG_TYPE_V64;
> +        op->args[0] = ri;
> +        if (TCG_TARGET_REG_BITS == 64) {
> +            op->args[1] = a;
> +            op->args[2] = b;
> +            op->args[3] = c;
> +            op->args[4] = d;
> +        } else {
> +            op->args[1] = a;
> +            op->args[2] = a >> 32;
> +            op->args[3] = b;
> +            op->args[4] = b >> 32;
> +            op->args[5] = c;
> +            op->args[6] = c >> 32;
> +            op->args[7] = d;
> +            op->args[8] = d >> 32;
> +        }

and this would be vec_gen_5() and vec_gen_9(), I guess.

> +    }
> +}
> +
> +void tcg_gen_dup_i64_vec(unsigned vece, TCGv_vec r, TCGv_i64 a)
> +{
> +    TCGArg ri = tcgv_vec_arg(r);
> +    TCGTemp *rt = arg_temp(ri);
> +    TCGType type = rt->base_type;
> +
> +    if (TCG_TARGET_REG_BITS == 64) {
> +        TCGArg ai = tcgv_i64_arg(a);
> +        vec_gen_2(INDEX_op_dup_vec, type, MO_64, ri, ai);
> +    } else if (vece == MO_64) {
> +        TCGArg al = tcgv_i32_arg(TCGV_LOW(a));
> +        TCGArg ah = tcgv_i32_arg(TCGV_HIGH(a));
> +        vec_gen_3(INDEX_op_dup2_vec, type, MO_64, ri, al, ah);
> +    } else {
> +        TCGArg ai = tcgv_i32_arg(TCGV_LOW(a));
> +        vec_gen_2(INDEX_op_dup_vec, type, MO_64, ri, ai);
> +    }
> +}
> +

> diff --git a/tcg/README b/tcg/README
> index 03bfb6acd4..e14990fb9b 100644
> --- a/tcg/README
> +++ b/tcg/README
> @@ -503,6 +503,64 @@ of the memory access.
>  For a 32-bit host, qemu_ld/st_i64 is guaranteed to only be used with a
>  64-bit memory access specified in flags.
>
> +********* Host vector operations
> +
> +All of the vector ops have two parameters, TCGOP_VECL & TCGOP_VECE.
> +The former specifies the length of the vector in log2 64-bit units; the
> +later specifies the length of the element (if applicable) in log2 8-bit units.
> +E.g. VECL=1 -> 64 << 1 -> v128, and VECE=2 -> 1 << 2 -> i32.

...but at the tcg_gen_and_vec() function level, the functions
take a parameter for VECE but not one for VECL ? That's a bit
confusing. (I think this is perhaps an example of the awkwardness of
our documenting the TCG interface only at an abstract "ops" level
and not documenting the concrete function APIs at all.)

thanks
-- PMM
