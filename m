Received: from eggs.gnu.org ([2001:4830:134:3::10]:58053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fBxkT-00034v-Bb
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 03:24:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fBxkR-0007UH-OW
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 03:24:53 -0400
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:42670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fBxkR-0007Tv-E8
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 03:24:51 -0400
Received: by mail-ot0-x229.google.com with SMTP id l13-v6so989834otk.9
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 00:24:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180427002651.28356-6-richard.henderson@linaro.org>
References: <20180427002651.28356-1-richard.henderson@linaro.org>
	<20180427002651.28356-6-richard.henderson@linaro.org>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 27 Apr 2018 19:24:50 +1200
Message-ID: <CAHNT7NujtwKtCtsxG91DtgriDd2sjVZwyqKhAp03LR=eJjdMtQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 5/9] target/riscv: Use new atomic min/max
 expanders
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm@nongnu.org, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, "Emilio G. Cota" <cota@braap.org>

On Fri, Apr 27, 2018 at 12:26 PM, Richard Henderson <
richard.henderson@linaro.org> wrote:

> Cc: Michael Clark <mjc@sifive.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>

Reviewed-by: Michael Clark <mjc@sifive.com>

If you give me a remote I can pull into my local workspace and test. The
change looks pretty straight-forward. There are tests for amos in
riscv-tests but no parallel tests (i.e. contended case).

Regarding this target/riscv/translate.c. I'd like to make a patch to
remove CPURISCVState *env arguments from several gen functions.

---
>  target/riscv/translate.c | 72 ++++++++++++++----------------
> ------------------
>  1 file changed, 20 insertions(+), 52 deletions(-)
>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 808eab7f50..9cab717088 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -725,7 +725,6 @@ static void gen_atomic(DisasContext *ctx, uint32_t opc,
>      TCGv src1, src2, dat;
>      TCGLabel *l1, *l2;
>      TCGMemOp mop;
> -    TCGCond cond;
>      bool aq, rl;
>
>      /* Extract the size of the atomic operation.  */
> @@ -823,60 +822,29 @@ static void gen_atomic(DisasContext *ctx, uint32_t
> opc,
>          tcg_gen_atomic_fetch_or_tl(src2, src1, src2, ctx->mem_idx, mop);
>          gen_set_gpr(rd, src2);
>          break;
> -
>      case OPC_RISC_AMOMIN:
> -        cond = TCG_COND_LT;
> -        goto do_minmax;
> -    case OPC_RISC_AMOMAX:
> -        cond = TCG_COND_GT;
> -        goto do_minmax;
> -    case OPC_RISC_AMOMINU:
> -        cond = TCG_COND_LTU;
> -        goto do_minmax;
> -    case OPC_RISC_AMOMAXU:
> -        cond = TCG_COND_GTU;
> -        goto do_minmax;
> -    do_minmax:
> -        /* Handle the RL barrier.  The AQ barrier is handled along the
> -           parallel path by the SC atomic cmpxchg.  On the serial path,
> -           of course, barriers do not matter.  */
> -        if (rl) {
> -            tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
> -        }
> -        if (tb_cflags(ctx->tb) & CF_PARALLEL) {
> -            l1 = gen_new_label();
> -            gen_set_label(l1);
> -        } else {
> -            l1 = NULL;
> -        }
> -
>          gen_get_gpr(src1, rs1);
>          gen_get_gpr(src2, rs2);
> -        if ((mop & MO_SSIZE) == MO_SL) {
> -            /* Sign-extend the register comparison input.  */
> -            tcg_gen_ext32s_tl(src2, src2);
> -        }
> -        dat = tcg_temp_local_new();
> -        tcg_gen_qemu_ld_tl(dat, src1, ctx->mem_idx, mop);
> -        tcg_gen_movcond_tl(cond, src2, dat, src2, dat, src2);
> -
> -        if (tb_cflags(ctx->tb) & CF_PARALLEL) {
> -            /* Parallel context.  Make this operation atomic by verifying
> -               that the memory didn't change while we computed the
> result.  */
> -            tcg_gen_atomic_cmpxchg_tl(src2, src1, dat, src2,
> ctx->mem_idx, mop);
> -
> -            /* If the cmpxchg failed, retry. */
> -            /* ??? There is an assumption here that this will eventually
> -               succeed, such that we don't live-lock.  This is not unlike
> -               a similar loop that the compiler would generate for e.g.
> -               __atomic_fetch_and_xor, so don't worry about it.  */
> -            tcg_gen_brcond_tl(TCG_COND_NE, dat, src2, l1);
> -        } else {
> -            /* Serial context.  Directly store the result.  */
> -            tcg_gen_qemu_st_tl(src2, src1, ctx->mem_idx, mop);
> -        }
> -        gen_set_gpr(rd, dat);
> -        tcg_temp_free(dat);
> +        tcg_gen_atomic_fetch_smin_tl(src2, src1, src2, ctx->mem_idx,
> mop);
> +        gen_set_gpr(rd, src2);
> +        break;
> +    case OPC_RISC_AMOMAX:
> +        gen_get_gpr(src1, rs1);
> +        gen_get_gpr(src2, rs2);
> +        tcg_gen_atomic_fetch_smax_tl(src2, src1, src2, ctx->mem_idx,
> mop);
> +        gen_set_gpr(rd, src2);
> +        break;
> +    case OPC_RISC_AMOMINU:
> +        gen_get_gpr(src1, rs1);
> +        gen_get_gpr(src2, rs2);
> +        tcg_gen_atomic_fetch_umin_tl(src2, src1, src2, ctx->mem_idx,
> mop);
> +        gen_set_gpr(rd, src2);
> +        break;
> +    case OPC_RISC_AMOMAXU:
> +        gen_get_gpr(src1, rs1);
> +        gen_get_gpr(src2, rs2);
> +        tcg_gen_atomic_fetch_umax_tl(src2, src1, src2, ctx->mem_idx,
> mop);
> +        gen_set_gpr(rd, src2);
>          break;
>
>      default:
> --
> 2.14.3
>
>
