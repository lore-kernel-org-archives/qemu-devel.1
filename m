Received: from eggs.gnu.org ([2001:4830:134:3::10]:39293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXF2Z-0005CI-Qd
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 20:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXF2V-00081M-5E
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 20:07:31 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:34199)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXF2U-00080w-Sf
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 20:07:27 -0400
Received: by mail-pg0-x241.google.com with SMTP id q4-v6so5266110pgr.1
	for <qemu-devel@nongnu.org>; Sun, 24 Jun 2018 17:07:26 -0700 (PDT)
References: <20180620120620.12806-1-yongbok.kim@mips.com>
	<20180620120620.12806-15-yongbok.kim@mips.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <da6b1825-3839-2afc-5e45-3cae99fb03ce@linaro.org>
Date: Sun, 24 Jun 2018 17:07:23 -0700
MIME-Version: 1.0
In-Reply-To: <20180620120620.12806-15-yongbok.kim@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/35] target/mips: Add nanoMIPS p_lsx
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@mips.com>, qemu-devel@nongnu.org
Cc: Aleksandar.Markovic@mips.com, Paul.Burton@mips.com, Stefan.Markovic@mips.com, Matthew.Fortune@mips.com, James.Hogan@mips.com, aurelien@aurel32.net

On 06/20/2018 05:05 AM, Yongbok Kim wrote:
> Add nanoMIPS p_lsx and LSA instructions
> 
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> ---
>  target/mips/translate.c | 139 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 138 insertions(+), 1 deletion(-)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index a581330..819cfd9 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -16579,6 +16579,132 @@ static void gen_pool32axf_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
>      }
>  }
>  
> +
> +static void gen_p_lsx(DisasContext *ctx, int rd, int rs, int rt)
> +{
> +    TCGv t0, t1;
> +    t0 = tcg_temp_new();
> +    t1 = tcg_temp_new();
> +    tcg_gen_movi_tl(t1, 0);
> +    if (rs == 0) {
> +        tcg_gen_movi_tl(t0, 0);
> +    } else {
> +        gen_load_gpr(t0, rs);
> +    }

gen_load_gpr already does exactly this == 0 test.

> +    if (((ctx->opcode >> 6) & 1) == 1) {
> +        /* PP.LSXS instructions require shifting */
> +        switch ((ctx->opcode >> 7) & 0xf) {
> +        case NM_LHXS:
> +        case NM_SHXS:
> +        case NM_LHUXS:
> +            tcg_gen_shli_tl(t0, t0, 1);
> +            break;
> +        case NM_LWXS:
> +        case NM_SWXS:
> +        case NM_LWC1XS:
> +        case NM_SWC1XS:
> +            tcg_gen_shli_tl(t0, t0, 2);
> +            break;
> +        case NM_LDC1XS:
> +        case NM_SDC1XS:
> +            tcg_gen_shli_tl(t0, t0, 3);
> +            break;
> +        }
> +    }

If you would set a TCGMemOp mop variable in the first switch, then the shift is

  tcg_gen_shli_tl(t0, t0, mop * MO_SIZE);

> +    switch ((ctx->opcode >> 7) & 0xf) {
> +    case NM_LBX:
> +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx,
> +                           MO_SB);
> +        gen_store_gpr(t0, rd);
> +        break;
> +    case NM_LHX:
> +    /*case NM_LHXS:*/
> +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx,
> +                           MO_TESW);
> +        gen_store_gpr(t0, rd);
> +        break;
> +    case NM_LWX:
> +    /*case NM_LWXS:*/
> +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx,
> +                           MO_TESL);
> +        gen_store_gpr(t0, rd);
> +        break;
> +    case NM_LBUX:
> +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx,
> +                           MO_UB);
> +        gen_store_gpr(t0, rd);
> +        break;
> +    case NM_LHUX:
> +    /*case NM_LHUXS:*/
> +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx,
> +                           MO_TEUW);
> +        gen_store_gpr(t0, rd);
> +        break;

And all of these cases unify to

  tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, mop);

> +    case NM_SBX:
> +        gen_load_gpr(t1, rd);
> +        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
> +                           MO_8);
> +        break;
> +    case NM_SHX:
> +    /*case NM_SHXS:*/
> +        gen_load_gpr(t1, rd);
> +        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
> +                           MO_TEUW);
> +        break;
> +    case NM_SWX:
> +    /*case NM_SWXS:*/
> +        gen_load_gpr(t1, rd);
> +        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
> +                           MO_TEUL);
> +        break;

As do these.


r~
