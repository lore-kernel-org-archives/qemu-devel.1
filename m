Received: from eggs.gnu.org ([2001:4830:134:3::10]:42573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gIduE-00060U-5W
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 14:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gIdu9-0007JN-Qa
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 14:10:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gIdu9-0007Fo-8A
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 14:10:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id z3-v6so2884037wru.4
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 11:10:40 -0700 (PDT)
References: <cover.1541174426.git.noring@nocrew.org>
	<fa2941ee17c35fba2512ab530bde3a1807d5769e.1541174426.git.noring@nocrew.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7152d4dd-12e4-926b-ef1c-58ba7de0ea7c@redhat.com>
Date: Fri, 2 Nov 2018 19:10:38 +0100
MIME-Version: 1.0
In-Reply-To: <fa2941ee17c35fba2512ab530bde3a1807d5769e.1541174426.git.noring@nocrew.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] target/mips: Fix decoding mechanism of
 R5900 MFLO1, MFHI1, MTLO1 and MTHI1
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
> MFLO1, MFHI1, MTLO1 and MTHI1 are generated in gen_HILO1_tx79 instead of
> the generic gen_HILO.
> 

Aleksandar, if you are OK with this patch, can you add:

Fixes: 8d927f7cb4b

> Signed-off-by: Fredrik Noring <noring@nocrew.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   target/mips/translate.c | 67 ++++++++++++++++++++++++++++++++++-------
>   1 file changed, 56 insertions(+), 11 deletions(-)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 60320cbe69..f3993cf7d7 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -4359,24 +4359,72 @@ static void gen_shift(DisasContext *ctx, uint32_t opc,
>       tcg_temp_free(t1);
>   }
>   
> +/* Move to and from TX79 HI1/LO1 registers. */
> +static void gen_HILO1_tx79(DisasContext *ctx, uint32_t opc, int reg)
> +{
> +    if (reg == 0 && (opc == TX79_MMI_MFHI1 || opc == TX79_MMI_MFLO1)) {
> +        /* Treat as NOP. */
> +        return;
> +    }
> +
> +    switch (opc) {
> +    case TX79_MMI_MFHI1:
> +#if defined(TARGET_MIPS64)
> +        tcg_gen_ext32s_tl(cpu_gpr[reg], cpu_HI[1]);
> +#else
> +        tcg_gen_mov_tl(cpu_gpr[reg], cpu_HI[1]);
> +#endif
> +        break;
> +    case TX79_MMI_MFLO1:
> +#if defined(TARGET_MIPS64)
> +        tcg_gen_ext32s_tl(cpu_gpr[reg], cpu_LO[1]);
> +#else
> +        tcg_gen_mov_tl(cpu_gpr[reg], cpu_LO[1]);
> +#endif
> +        break;
> +    case TX79_MMI_MTHI1:
> +        if (reg != 0) {
> +#if defined(TARGET_MIPS64)
> +            tcg_gen_ext32s_tl(cpu_HI[1], cpu_gpr[reg]);
> +#else
> +            tcg_gen_mov_tl(cpu_HI[1], cpu_gpr[reg]);
> +#endif
> +        } else {
> +            tcg_gen_movi_tl(cpu_HI[1], 0);
> +        }
> +        break;
> +    case TX79_MMI_MTLO1:
> +        if (reg != 0) {
> +#if defined(TARGET_MIPS64)
> +            tcg_gen_ext32s_tl(cpu_LO[1], cpu_gpr[reg]);
> +#else
> +            tcg_gen_mov_tl(cpu_LO[1], cpu_gpr[reg]);
> +#endif
> +        } else {
> +            tcg_gen_movi_tl(cpu_LO[1], 0);
> +        }
> +        break;
> +    default:
> +        MIPS_INVAL("MFTHILO TX79");
> +        generate_exception_end(ctx, EXCP_RI);
> +        break;
> +    }
> +}
> +
>   /* Arithmetic on HI/LO registers */
>   static void gen_HILO(DisasContext *ctx, uint32_t opc, int acc, int reg)
>   {
> -    if (reg == 0 && (opc == OPC_MFHI || opc == TX79_MMI_MFHI1 ||
> -                     opc == OPC_MFLO || opc == TX79_MMI_MFLO1)) {
> +    if (reg == 0 && (opc == OPC_MFHI || opc == OPC_MFLO)) {
>           /* Treat as NOP. */
>           return;
>       }
>   
>       if (acc != 0) {
> -        if (!(ctx->insn_flags & INSN_R5900)) {
> -            check_dsp(ctx);
> -        }
> +        check_dsp(ctx);
>       }
>   
>       switch (opc) {
>       case OPC_MFHI:
> -    case TX79_MMI_MFHI1:
>   #if defined(TARGET_MIPS64)
>           if (acc != 0) {
>               tcg_gen_ext32s_tl(cpu_gpr[reg], cpu_HI[acc]);
> @@ -4387,7 +4435,6 @@ static void gen_HILO(DisasContext *ctx, uint32_t opc, int acc, int reg)
>           }
>           break;
>       case OPC_MFLO:
> -    case TX79_MMI_MFLO1:
>   #if defined(TARGET_MIPS64)
>           if (acc != 0) {
>               tcg_gen_ext32s_tl(cpu_gpr[reg], cpu_LO[acc]);
> @@ -4398,7 +4445,6 @@ static void gen_HILO(DisasContext *ctx, uint32_t opc, int acc, int reg)
>           }
>           break;
>       case OPC_MTHI:
> -    case TX79_MMI_MTHI1:
>           if (reg != 0) {
>   #if defined(TARGET_MIPS64)
>               if (acc != 0) {
> @@ -4413,7 +4459,6 @@ static void gen_HILO(DisasContext *ctx, uint32_t opc, int acc, int reg)
>           }
>           break;
>       case OPC_MTLO:
> -    case TX79_MMI_MTLO1:
>           if (reg != 0) {
>   #if defined(TARGET_MIPS64)
>               if (acc != 0) {
> @@ -26500,11 +26545,11 @@ static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
>           break;
>       case TX79_MMI_MTLO1:
>       case TX79_MMI_MTHI1:
> -        gen_HILO(ctx, opc, 1, rs);
> +        gen_HILO1_tx79(ctx, opc, rs);
>           break;
>       case TX79_MMI_MFLO1:
>       case TX79_MMI_MFHI1:
> -        gen_HILO(ctx, opc, 1, rd);
> +        gen_HILO1_tx79(ctx, opc, rd);
>           break;
>       case TX79_MMI_MADD:          /* TODO: TX79_MMI_MADD */
>       case TX79_MMI_MADDU:         /* TODO: TX79_MMI_MADDU */
> 
