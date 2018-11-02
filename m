Received: from eggs.gnu.org ([2001:4830:134:3::10]:44818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gIdz7-0000Py-13
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 14:15:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gIdyz-0001uk-VC
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 14:15:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gIdyx-0001s3-KF
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 14:15:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id y15-v6so2879761wru.9
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 11:15:43 -0700 (PDT)
References: <cover.1541174426.git.noring@nocrew.org>
	<00da443f92be6ccd6b9a890529e68e8239325006.1541174426.git.noring@nocrew.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c769ae5a-aef9-27e1-eb26-caaddbaf48a8@redhat.com>
Date: Fri, 2 Nov 2018 19:15:40 +0100
MIME-Version: 1.0
In-Reply-To: <00da443f92be6ccd6b9a890529e68e8239325006.1541174426.git.noring@nocrew.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] target/mips: Fix decoding mechanism of
 R5900 DIV1 and DIVU1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: =?UTF-8?Q?J=c3=bcrgen_Urban?= <JuergenUrban@gmx.de>, qemu-devel@nongnu.org, "Maciej W. Rozycki" <macro@linux-mips.org>

On 2/11/18 17:08, Fredrik Noring wrote:
> DIV1 and DIVU1 are generated in gen_div1_tx79 instead of the generic
> gen_muldiv.
> 

Fixes: be9c42c90d1 (R5900-specific opcodes overlap with generic opcodes)

> Signed-off-by: Fredrik Noring <noring@nocrew.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   target/mips/translate.c | 65 +++++++++++++++++++++++++++++++++++++----
>   1 file changed, 59 insertions(+), 6 deletions(-)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index f3993cf7d7..6e5a8a2565 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -4759,6 +4759,63 @@ static void gen_r6_muldiv(DisasContext *ctx, int opc, int rd, int rs, int rt)
>       tcg_temp_free(t1);
>   }
>   
> +static void gen_div1_tx79(DisasContext *ctx, uint32_t opc, int rs, int rt)
> +{
> +    TCGv t0, t1;
> +
> +    t0 = tcg_temp_new();
> +    t1 = tcg_temp_new();
> +
> +    gen_load_gpr(t0, rs);
> +    gen_load_gpr(t1, rt);
> +
> +    switch (opc) {
> +    case TX79_MMI_DIV1:
> +        {
> +            TCGv t2 = tcg_temp_new();
> +            TCGv t3 = tcg_temp_new();
> +            tcg_gen_ext32s_tl(t0, t0);
> +            tcg_gen_ext32s_tl(t1, t1);
> +            tcg_gen_setcondi_tl(TCG_COND_EQ, t2, t0, INT_MIN);
> +            tcg_gen_setcondi_tl(TCG_COND_EQ, t3, t1, -1);
> +            tcg_gen_and_tl(t2, t2, t3);
> +            tcg_gen_setcondi_tl(TCG_COND_EQ, t3, t1, 0);
> +            tcg_gen_or_tl(t2, t2, t3);
> +            tcg_gen_movi_tl(t3, 0);
> +            tcg_gen_movcond_tl(TCG_COND_NE, t1, t2, t3, t2, t1);
> +            tcg_gen_div_tl(cpu_LO[1], t0, t1);
> +            tcg_gen_rem_tl(cpu_HI[1], t0, t1);
> +            tcg_gen_ext32s_tl(cpu_LO[1], cpu_LO[1]);
> +            tcg_gen_ext32s_tl(cpu_HI[1], cpu_HI[1]);
> +            tcg_temp_free(t3);
> +            tcg_temp_free(t2);
> +        }
> +        break;
> +    case TX79_MMI_DIVU1:
> +        {
> +            TCGv t2 = tcg_const_tl(0);
> +            TCGv t3 = tcg_const_tl(1);
> +            tcg_gen_ext32u_tl(t0, t0);
> +            tcg_gen_ext32u_tl(t1, t1);
> +            tcg_gen_movcond_tl(TCG_COND_EQ, t1, t1, t2, t3, t1);
> +            tcg_gen_divu_tl(cpu_LO[1], t0, t1);
> +            tcg_gen_remu_tl(cpu_HI[1], t0, t1);
> +            tcg_gen_ext32s_tl(cpu_LO[1], cpu_LO[1]);
> +            tcg_gen_ext32s_tl(cpu_HI[1], cpu_HI[1]);
> +            tcg_temp_free(t3);
> +            tcg_temp_free(t2);
> +        }
> +        break;
> +    default:
> +        MIPS_INVAL("div1 TX79");
> +        generate_exception_end(ctx, EXCP_RI);
> +        goto out;
> +    }
> + out:
> +    tcg_temp_free(t0);
> +    tcg_temp_free(t1);
> +}
> +
>   static void gen_muldiv(DisasContext *ctx, uint32_t opc,
>                          int acc, int rs, int rt)
>   {
> @@ -4771,14 +4828,11 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
>       gen_load_gpr(t1, rt);
>   
>       if (acc != 0) {
> -        if (!(ctx->insn_flags & INSN_R5900)) {
> -            check_dsp(ctx);
> -        }
> +        check_dsp(ctx);
>       }
>   
>       switch (opc) {
>       case OPC_DIV:
> -    case TX79_MMI_DIV1:
>           {
>               TCGv t2 = tcg_temp_new();
>               TCGv t3 = tcg_temp_new();
> @@ -4800,7 +4854,6 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
>           }
>           break;
>       case OPC_DIVU:
> -    case TX79_MMI_DIVU1:
>           {
>               TCGv t2 = tcg_const_tl(0);
>               TCGv t3 = tcg_const_tl(1);
> @@ -26541,7 +26594,7 @@ static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
>           break;
>       case TX79_MMI_DIV1:
>       case TX79_MMI_DIVU1:
> -        gen_muldiv(ctx, opc, 1, rs, rt);
> +        gen_div1_tx79(ctx, opc, rs, rt);
>           break;
>       case TX79_MMI_MTLO1:
>       case TX79_MMI_MTHI1:
> 
