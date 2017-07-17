Received: from eggs.gnu.org ([2001:4830:134:3::10]:53992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dX6iz-0002VG-Qe
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:10:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dX6iy-0001lt-CX
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:10:13 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:35000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dX6iy-0001lD-6S
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:10:12 -0400
Date: Mon, 17 Jul 2017 16:10:09 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170717141009.na4es4x3dcugri23@aurel32.net>
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-8-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170707022111.21836-8-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 07/27] target/sh4: Recognize common gUSA
 sequences
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

On 2017-07-06 16:20, Richard Henderson wrote:
> For many of the sequences produced by gcc or glibc,
> we can translate these as host atomic operations.
> Which saves the need to acquire the exclusive lock.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/sh4/translate.c | 316 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 316 insertions(+)
> 
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index 653c06c..73b3e02 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -1894,10 +1894,17 @@ static void decode_opc(DisasContext * ctx)
>  */
>  static int decode_gusa(DisasContext *ctx, CPUSH4State *env, int *pmax_insns)
>  {
> +    uint16_t insns[5];
> +    int ld_adr, ld_dst, ld_mop;
> +    int op_dst, op_src, op_opc;
> +    int mv_src, mt_dst, st_src, st_mop;
> +    TCGv op_arg;
> +
>      uint32_t pc = ctx->pc;
>      uint32_t pc_end = ctx->tb->cs_base;
>      int backup = sextract32(ctx->tbflags, GUSA_SHIFT, 8);
>      int max_insns = (pc_end - pc) / 2;
> +    int i;
>  
>      if (pc != pc_end + backup || max_insns < 2) {
>          /* This is a malformed gUSA region.  Don't do anything special,
> @@ -1914,6 +1921,315 @@ static int decode_gusa(DisasContext *ctx, CPUSH4State *env, int *pmax_insns)
>          return 0;
>      }
>  
> +    /* The state machine below will consume only a few insns.
> +       If there are more than that in a region, fail now.  */
> +    if (max_insns > ARRAY_SIZE(insns)) {
> +        goto fail;
> +    }
> +
> +    /* Read all of the insns for the region.  */
> +    for (i = 0; i < max_insns; ++i) {
> +        insns[i] = cpu_lduw_code(env, pc + i * 2);
> +    }
> +
> +    ld_adr = ld_dst = ld_mop = -1;
> +    mv_src = -1;
> +    op_dst = op_src = op_opc = -1;
> +    mt_dst = -1;
> +    st_src = st_mop = -1;
> +    TCGV_UNUSED(op_arg);
> +    i = 0;
> +
> +#define NEXT_INSN \
> +    do { if (i >= max_insns) goto fail; ctx->opcode = insns[i++]; } while (0)
> +
> +    /*
> +     * Expect a load to begin the region.
> +     */
> +    NEXT_INSN;
> +    switch (ctx->opcode & 0xf00f) {
> +    case 0x6000: /* mov.b @Rm,Rn */
> +        ld_mop = MO_SB;
> +        break;
> +    case 0x6001: /* mov.w @Rm,Rn */
> +        ld_mop = MO_TESW;
> +        break;
> +    case 0x6002: /* mov.l @Rm,Rn */
> +        ld_mop = MO_TESL;
> +        break;
> +    default:
> +        goto fail;
> +    }
> +    ld_adr = B7_4;
> +    ld_dst = B11_8;
> +    if (ld_adr == ld_dst) {
> +        goto fail;
> +    }
> +    /* Unless we see a mov, any two-operand operation must use ld_dst.  */
> +    op_dst = ld_dst;
> +
> +    /*
> +     * Expect an optional register move.
> +     */
> +    NEXT_INSN;
> +    switch (ctx->opcode & 0xf00f) {
> +    case 0x6003: /* mov Rm,Rn */
> +        /* Here we want to recognize ld_dst being saved for later consumtion,
> +           or for another input register being copied so that ld_dst need not
> +           be clobbered during the operation.  */
> +        op_dst = B11_8;
> +        mv_src = B7_4;
> +        if (op_dst == ld_dst) {
> +            /* Overwriting the load output.  */
> +            goto fail;
> +        }
> +        if (mv_src != ld_dst) {
> +            /* Copying a new input; constrain op_src to match the load.  */
> +            op_src = ld_dst;
> +        }
> +        break;
> +
> +    default:
> +        /* Put back and re-examine as operation.  */
> +        --i;
> +    }
> +
> +    /*
> +     * Expect the operation.
> +     */
> +    NEXT_INSN;
> +    switch (ctx->opcode & 0xf00f) {
> +    case 0x300c: /* add Rm,Rn */
> +        op_opc = INDEX_op_add_i32;
> +        goto do_reg_op;
> +    case 0x2009: /* and Rm,Rn */
> +        op_opc = INDEX_op_and_i32;
> +        goto do_reg_op;
> +    case 0x200a: /* xor Rm,Rn */
> +        op_opc = INDEX_op_xor_i32;
> +        goto do_reg_op;
> +    case 0x200b: /* or Rm,Rn */
> +        op_opc = INDEX_op_or_i32;
> +    do_reg_op:
> +        /* The operation register should be as expected, and the
> +           other input cannot depend on the load.  */
> +        if (op_dst != B11_8) {
> +            goto fail;
> +        }
> +        if (op_src < 0) {
> +            /* Unconstrainted input.  */
> +            op_src = B7_4;
> +        } else if (op_src == B7_4) {
> +            /* Constrained input matched load.  All operations are
> +               commutative; "swap" them by "moving" the load output
> +               to the (implicit) first argument and the move source
> +               to the (explicit) second argument.  */
> +            op_src = mv_src;
> +        } else {
> +            goto fail;
> +        }
> +        op_arg = REG(op_src);
> +        break;
> +
> +    case 0x6007: /* not Rm,Rn */
> +        if (ld_dst != B7_4 || mv_src >= 0) {
> +            goto fail;
> +        }
> +        op_dst = B11_8;
> +        op_opc = INDEX_op_xor_i32;
> +        op_arg = tcg_const_i32(-1);

This temp is never freed. Same for a few others below.

Overall, parsing the atomic sequence ends up being complex. I have
verified the most common sequences from GCC or GLIBC, and your code
seems fine for at least those cases.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
