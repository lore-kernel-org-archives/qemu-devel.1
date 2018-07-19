Received: from eggs.gnu.org ([2001:4830:134:3::10]:42647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgDJY-0007tb-Rp
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:06:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgDJW-0006wQ-4g
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:06:08 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:35585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgDJV-0006w8-QR
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:06:06 -0400
Received: by mail-pl0-x242.google.com with SMTP id w3-v6so3994894plq.2
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 11:06:05 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-7-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c35fe7b1-56ef-1ac6-0a48-07d27f91aac6@linaro.org>
Date: Thu, 19 Jul 2018 11:06:01 -0700
MIME-Version: 1.0
In-Reply-To: <1532004912-13899-7-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 06/40] target/mips: Add emulation of
 misc nanoMIPS 16-bit instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/19/2018 05:54 AM, Stefan Markovic wrote:
> From: Yongbok Kim <yongbok.kim@mips.com>
> 
> Add emulation of misc nanoMIPS 16-bit instructions from instruction
> pools P16, P16.BR, P16.BRI, P16.4X4 and other related pools.
> 
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 258 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 258 insertions(+)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 4e6ae1f..798f977 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -16502,6 +16502,264 @@ static int decode_gpr_gpr4_zero(int r)
>  
>  static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
>  {
> +    uint32_t op;
> +    int rt = decode_gpr_gpr3(NANOMIPS_EXTRACT_RD(ctx->opcode));
> +    int rs = decode_gpr_gpr3(NANOMIPS_EXTRACT_RS(ctx->opcode));
> +    int rd = decode_gpr_gpr3(NANOMIPS_EXTRACT_RS1(ctx->opcode));
> +
> +    /* make sure instructions are on a halfword boundary */
> +    if (ctx->base.pc_next & 0x1) {
> +        env->CP0_BadVAddr = ctx->base.pc_next;

You can't assign to ENV here.  You must generate code to do this:

    TCGv tmp = tcg_const_tl(ctx->base.pc_next);
    tcg_gen_st_tl(tmp, cpu_env, offsetof(CPUMIPSState, CP0_BadVAddr));
    tcg_temp_free(tmp);

> +        generate_exception_end(ctx, EXCP_AdEL);
> +        return 2;
> +    }


> +
> +    op = (ctx->opcode >> 10) & 0x3f;
> +    switch (op) {
> +    case NM_P16_MV:
> +        {
> +            int rt = NANOMIPS_EXTRACT_RD5(ctx->opcode);
> +            if (rt != 0) {
> +                /* MOVE */
> +                int rs = NANOMIPS_EXTRACT_RS5(ctx->opcode);
> +                gen_arith(ctx, OPC_ADDU, rt, rs, 0);

If you've any thought for nanoMIPS64 in future, consider using OR instead.

> +        case NM_ADDIUR2:
> +        {
> +            uint8_t u = (uint8_t) extract32(ctx->opcode, 0, 3) << 2;
> +            gen_arith_imm(ctx, OPC_ADDIU, rt, rs, u);

Drop the useless cast?  And the variable, come to that; just above you extract
the immediate to gen_arith_imm as an argument.
	
> +        }
> +            break;
> +        case NM_P_ADDIURS5:
> +        {
> +            int rt  = extract32(ctx->opcode, 5, 5);

This shadows the outer rt variable.  Just overwrite the original.

> +            if (rt != 0) {
> +                int s = (sextract32(ctx->opcode, 4, 1) << 3) |
> +                        extract32(ctx->opcode, 0, 3);
> +                /* s = sign_extend( s[3] . s[2:0] , from_nbits = 4)*/
> +                gen_arith_imm(ctx, OPC_ADDIU, rt, rt, s);
> +            }
> +        }
> +            break;
> +        }
> +        break;

There's some really bad indentation going on here.

> +    case NM_P16_4X4:
> +        {
> +            int rt = (extract32(ctx->opcode, 9, 1) << 3) |
> +                      extract32(ctx->opcode, 5, 3);
> +            int rs = (extract32(ctx->opcode, 4, 1) << 3) |
> +                      extract32(ctx->opcode, 0, 3);

Shadowing again.

> +        default:
> +            /* P16.BRI */
> +            if (extract32(ctx->opcode, 4, 3) < extract32(ctx->opcode, 7, 3)) {

These are already extracted into rs and rt...

> +                /* BEQC16 */
> +                gen_compute_branch(ctx, OPC_BEQ, 2, rs, rt,
> +                                   extract32(ctx->opcode, 0, 4) << 1, 0);

... which you are using here.

And surely, merge these as

    gen_compute_branch(ctx, rs < rt ? OPC_BEQ : OPC_BNE, 2, rs, rt,
                       extract32(ctx->opcode, 0, 4) << 1, 0);


r~
