Received: from eggs.gnu.org ([2001:4830:134:3::10]:34656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXEUR-00082g-3h
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 19:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXEUM-0003HC-G0
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 19:32:15 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:34670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXEUM-0003Gt-8i
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 19:32:10 -0400
Received: by mail-pl0-x243.google.com with SMTP id g20-v6so5931179plq.1
	for <qemu-devel@nongnu.org>; Sun, 24 Jun 2018 16:32:10 -0700 (PDT)
References: <20180620120620.12806-1-yongbok.kim@mips.com>
	<20180620120620.12806-9-yongbok.kim@mips.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <91ea24a1-e14d-8682-c77e-384adadfc86b@linaro.org>
Date: Sun, 24 Jun 2018 16:32:06 -0700
MIME-Version: 1.0
In-Reply-To: <20180620120620.12806-9-yongbok.kim@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/35] target/mips: Add nanoMIPS 32bit
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
> Add nanoMIPS 32bit instructions
> 
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> ---
>  target/mips/translate.c | 285 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 284 insertions(+), 1 deletion(-)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 4ce80bf..c9b46dd 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> +        } else {
> +            uint16_t imm;
> +            imm = (uint16_t) extract32(ctx->opcode, 0, 16);

Unnecessary cast.

> +            if (rs != 0) {
> +                tcg_gen_addi_tl(cpu_gpr[rt], cpu_gpr[rs], imm);
> +                tcg_gen_ext32s_tl(cpu_gpr[rt], cpu_gpr[rt]);
> +            } else {
> +                tcg_gen_movi_tl(cpu_gpr[rt], imm);
> +            }
> +        }
> +        break;
> +    case NM_ADDIUPC:
> +        if (rt != 0) {
> +            int32_t offset = sextract32(ctx->opcode, 0, 1) << 21
> +                            | extract32(ctx->opcode, 1, 20) << 1;
> +            target_long addr = addr_add(ctx, ctx->base.pc_next + 4, offset);
> +            tcg_gen_movi_tl(cpu_gpr[rt], addr);
> +            tcg_gen_ext32s_tl(cpu_gpr[rt], cpu_gpr[rt]);

ext32s is unnecessary.
The addr passed to movi_tl is signed and properly sized.

> +        case NM_ADDIUGP_W:
> +            if (rt != 0) {
> +                uint32_t offset = extract32(ctx->opcode, 0, 21);
> +                if (offset == 0) {
> +                    gen_load_gpr(cpu_gpr[rt], 28);
> +                } else {
> +                    TCGv t0;
> +                    t0 = tcg_temp_new();
> +                    tcg_gen_movi_tl(t0, offset);
> +                    gen_op_addr_add(ctx, cpu_gpr[rt], cpu_gpr[28], t0);
> +                    tcg_temp_free(t0);
> +                }

Your special-case of here fails to sign-extend for 0.
That would want fixing for 64-bit nanoMIPS with AWRAP.

It would be worthwhile to have a gen_op_addr_addi,
and not special-case offset here -- tcg_gen_addi_tl
would do that for you.

> +        case NM_SLTI:
> +            gen_slt_imm(ctx, OPC_SLTI, rt, rs, extract32(ctx->opcode, 0, 12));
> +            break;
> +        case NM_SLTIU:
> +            gen_slt_imm(ctx, OPC_SLTIU, rt, rs, extract32(ctx->opcode, 0, 12));
> +            break;
> +        case NM_SEQI:
> +        {
> +            TCGv t0 = tcg_temp_new();
> +            TCGv t1 = tcg_temp_new();
> +            TCGv t2 = tcg_temp_local_new();
> +            TCGLabel *l1 = gen_new_label();
> +
> +            gen_load_gpr(t0, rs);
> +            tcg_gen_movi_tl(t1, extract32(ctx->opcode, 0, 12));
> +            tcg_gen_movi_tl(t2, 0);
> +            tcg_gen_brcond_tl(TCG_COND_NE, t0, t1, l1);
> +            tcg_gen_movi_tl(t2, 1);
> +            gen_set_label(l1);

No labels required.  This is

    tcg_gen_setcondi_tl(TCG_COND_NE, t2, t0, extract32(...));

> +            gen_store_gpr(t2, rt);
> +
> +            tcg_temp_free(t0);
> +            tcg_temp_free(t1);
> +            tcg_temp_free(t2);
> +        }
> +            break;
> +        case NM_ADDIUNEG:
> +        {
> +            int16_t imm;
> +            imm = (int16_t) extract32(ctx->opcode, 0, 12);

Cast is unnecessary.


r~
