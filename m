Received: from eggs.gnu.org ([2001:4830:134:3::10]:38045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWDSW-0004tr-GD
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWDST-0000b1-9S
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:14:04 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:37325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWDST-0000at-4v
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:14:01 -0400
Received: by mail-qt0-x243.google.com with SMTP id a18-v6so4922515qtj.4
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 21:14:01 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>
	<20180620120620.12806-14-yongbok.kim@mips.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <885b3ec1-d904-f495-fce3-194b7bc0fb3b@amsat.org>
Date: Fri, 22 Jun 2018 01:13:55 -0300
MIME-Version: 1.0
In-Reply-To: <20180620120620.12806-14-yongbok.kim@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 13/35] target/mips: Update gen_flt_ldst()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@mips.com>
Cc: qemu-devel@nongnu.org, Aleksandar.Markovic@mips.com, Paul.Burton@mips.com, Stefan.Markovic@mips.com, Matthew.Fortune@mips.com, James.Hogan@mips.com, aurelien@aurel32.net, Richard Henderson <rth@twiddle.net>

On 06/20/2018 09:05 AM, Yongbok Kim wrote:
> Update gen_flt_ldst() in order to reuse the functions for nanoMIPS
> 
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/mips/translate.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 60d9287..a581330 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -2433,11 +2433,8 @@ static void gen_st_cond (DisasContext *ctx, uint32_t opc, int rt,
>  
>  /* Load and store */
>  static void gen_flt_ldst (DisasContext *ctx, uint32_t opc, int ft,
> -                          int base, int16_t offset)
> +                          TCGv t0)
>  {
> -    TCGv t0 = tcg_temp_new();
> -
> -    gen_base_offset_addr(ctx, t0, base, offset);
>      /* Don't do NOP if destination is zero: we must perform the actual
>         memory access. */
>      switch (opc) {
> @@ -2480,15 +2477,15 @@ static void gen_flt_ldst (DisasContext *ctx, uint32_t opc, int ft,
>      default:
>          MIPS_INVAL("flt_ldst");
>          generate_exception_end(ctx, EXCP_RI);
> -        goto out;
> +        break;
>      }
> - out:
> -    tcg_temp_free(t0);
>  }
>  
>  static void gen_cop1_ldst(DisasContext *ctx, uint32_t op, int rt,
>                            int rs, int16_t imm)
>  {
> +    TCGv t0 = tcg_temp_new();
> +
>      if (ctx->CP0_Config1 & (1 << CP0C1_FP)) {
>          check_cp1_enabled(ctx);
>          switch (op) {
> @@ -2497,11 +2494,13 @@ static void gen_cop1_ldst(DisasContext *ctx, uint32_t op, int rt,
>              check_insn(ctx, ISA_MIPS2);
>              /* Fallthrough */
>          default:
> -            gen_flt_ldst(ctx, op, rt, rs, imm);
> +            gen_base_offset_addr(ctx, t0, rs, imm);
> +            gen_flt_ldst(ctx, op, rt, t0);
>          }
>      } else {
>          generate_exception_err(ctx, EXCP_CpU, 1);
>      }
> +    tcg_temp_free(t0);
>  }
>  
>  /* Arithmetic with immediate operand */
> 
