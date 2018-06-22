Received: from eggs.gnu.org ([2001:4830:134:3::10]:33104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Aleksandar.Markovic@mips.com>) id 1fWMOg-0002e7-RS
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:46:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Aleksandar.Markovic@mips.com>) id 1fWMOc-0006GG-TA
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:46:42 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:51769)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Aleksandar.Markovic@mips.com>)
	id 1fWMOc-0006Eh-MY
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:46:38 -0400
From: Aleksandar Markovic <Aleksandar.Markovic@mips.com>
Date: Fri, 22 Jun 2018 13:46:28 +0000
Message-ID: <54cc6357df884065b52987da6ed4b65f@mips.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>,
	<20180620120620.12806-14-yongbok.kim@mips.com>
In-Reply-To: <20180620120620.12806-14-yongbok.kim@mips.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 13/35] target/mips: Update gen_flt_ldst()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <Yongbok.Kim@mips.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, James Hogan <James.Hogan@mips.com>, Paul Burton <Paul.Burton@mips.com>, Matthew Fortune <Matthew.Fortune@mips.com>, Stefan Markovic <Stefan.Markovic@mips.com>

> From: Yongbok Kim <yongbok.kim@imgtec.com>
>
> Update gen_flt_ldst() in order to reuse the functions for nanoMIPS
>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>

Reviewed-by: Aleksandar Markovic <aleksandar.markovic@mips.com>

> ---
>  target/mips/translate.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 60d9287..a581330 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -2433,11 +2433,8 @@ static void gen_st_cond (DisasContext *ctx, uint32=
_t opc, int rt,
>
>  /* Load and store */
>  static void gen_flt_ldst (DisasContext *ctx, uint32_t opc, int ft,
> -                          int base, int16_t offset)
> +                          TCGv t0)
>  {
> -    TCGv t0 =3D tcg_temp_new();
> -
> -    gen_base_offset_addr(ctx, t0, base, offset);
>      /* Don't do NOP if destination is zero: we must perform the actual
>         memory access. */
>      switch (opc) {
> @@ -2480,15 +2477,15 @@ static void gen_flt_ldst (DisasContext *ctx, uint=
32_t opc, int ft,
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
> +    TCGv t0 =3D tcg_temp_new();
> +
>      if (ctx->CP0_Config1 & (1 << CP0C1_FP)) {
>          check_cp1_enabled(ctx);
>          switch (op) {
> @@ -2497,11 +2494,13 @@ static void gen_cop1_ldst(DisasContext *ctx, uint=
32_t op, int rt,
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
> --
> 1.9.1
