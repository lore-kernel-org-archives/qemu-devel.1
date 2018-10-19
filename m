Received: from eggs.gnu.org ([2001:4830:134:3::10]:54607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gDYMt-000362-3A
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gDYMl-0001m9-OH
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:15:21 -0400
Received: from mail-co1nam03on0094.outbound.protection.outlook.com
	([104.47.40.94]:32640
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gDYMl-0001j8-AH
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:15:15 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 19 Oct 2018 17:15:10 +0000
Message-ID: <BN6PR2201MB1251DFE0C7DA3AA4581A26E2C6F90@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1539966828-20947-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1539966828-20947-11-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539966828-20947-11-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 10/14] target/mips: Add emulation of MXU
 instruction S8LDD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, "jancraig@amazon.com" <jancraig@amazon.com>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>


> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Friday, October 19, 2018 6:33 PM
> Subject: [PATCH v5 10/14] target/mips: Add emulation of MXU instruction S=
8LDD
>=20
> From: Craig Janeczek <jancraig@amazon.com>
>=20
> Add support for emulating the S8LDD MXU instruction.
>=20
> Signed-off-by: Craig Janeczek <jancraig@amazon.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 90 +++++++++++++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 87 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index c2b3463..71a6533 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -23410,6 +23410,92 @@ static void gen_mxu_s32m2i(DisasContext *ctx)
>      tcg_temp_free(t0);
>  }
>=20
> +/*
> + * S8LDD XRa, Rb, s8, optn3 - Load a byte from memory to XRF
> + */
> +static void gen_mxu_s8ldd(DisasContext *ctx)
> +{
> +    TCGv t0, t1;
> +    TCGLabel *l0;
> +    uint32_t XRa, Rb, s8, optn3;
> +
> +    t0 =3D tcg_temp_new();
> +    t1 =3D tcg_temp_new();
> +
> +    l0 =3D gen_new_label();
> +
> +    XRa =3D extract32(ctx->opcode, 6, 4);
> +    s8 =3D extract32(ctx->opcode, 10, 8);
> +    optn3 =3D extract32(ctx->opcode, 18, 3);
> +    Rb =3D extract32(ctx->opcode, 21, 5);
> +
> +    gen_load_mxu_cr(t0);
> +    tcg_gen_andi_tl(t0, t0, MXU_CR_MXU_EN);
> +    tcg_gen_brcondi_tl(TCG_COND_NE, t0, MXU_CR_MXU_EN, l0);
> +

Is there any way to move MXU_CR_MXU_EN check to the one level higher functi=
on, to avoid repetition?

I think all MXU instructions need this check, except S32I2M, S32M2I, and no=
n-MXU MUL.

Thanks,
Aleksandar

> +    gen_load_gpr(t0, Rb);
> +    tcg_gen_addi_tl(t0, t0, (int8_t)s8);
> +
> +    switch (optn3) {
> +    /* XRa[7:0] =3D tmp8 */
> +    case MXU_OPTN3_PTN0:
> +        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
> +        gen_load_mxu_gpr(t0, XRa);
> +        tcg_gen_deposit_tl(t0, t0, t1, 0, 8);
> +        break;
> +    /* XRa[15:8] =3D tmp8 */
> +    case MXU_OPTN3_PTN1:
> +        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
> +        gen_load_mxu_gpr(t0, XRa);
> +        tcg_gen_deposit_tl(t0, t0, t1, 8, 8);
> +        break;
> +    /* XRa[23:16] =3D tmp8 */
> +    case MXU_OPTN3_PTN2:
> +        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
> +        gen_load_mxu_gpr(t0, XRa);
> +        tcg_gen_deposit_tl(t0, t0, t1, 16, 8);
> +        break;
> +    /* XRa[31:24] =3D tmp8 */
> +    case MXU_OPTN3_PTN3:
> +        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
> +        gen_load_mxu_gpr(t0, XRa);
> +        tcg_gen_deposit_tl(t0, t0, t1, 24, 8);
> +        break;
> +    /* XRa =3D {8'b0, tmp8, 8'b0, tmp8} */
> +    case MXU_OPTN3_PTN4:
> +        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
> +        tcg_gen_deposit_tl(t0, t1, t1, 16, 16);
> +        break;
> +    /* XRa =3D {tmp8, 8'b0, tmp8, 8'b0} */
> +    case MXU_OPTN3_PTN5:
> +        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
> +        tcg_gen_shli_tl(t1, t1, 8);
> +        tcg_gen_deposit_tl(t0, t1, t1, 16, 16);
> +        break;
> +    /* XRa =3D {{8{sign of tmp8}}, tmp8, {8{sign of tmp8}}, tmp8} */
> +    case MXU_OPTN3_PTN6:
> +        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_SB);
> +        tcg_gen_mov_tl(t0, t1);
> +        tcg_gen_andi_tl(t0, t0, 0xFF00FFFF);
> +        tcg_gen_shli_tl(t1, t1, 16);
> +        tcg_gen_or_tl(t0, t0, t1);
> +        break;
> +    /* XRa =3D {tmp8, tmp8, tmp8, tmp8} */
> +    case MXU_OPTN3_PTN7:
> +        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
> +        tcg_gen_deposit_tl(t1, t1, t1, 8, 8);
> +        tcg_gen_deposit_tl(t0, t1, t1, 16, 16);
> +        break;
> +    }
> +
> +    gen_store_mxu_gpr(t0, XRa);
> +
> +    gen_set_label(l0);
> +
> +    tcg_temp_free(t0);
> +    tcg_temp_free(t1);
> +}
> +
>=20
>  /*
>   * Decoding engine for MXU
> @@ -24469,9 +24555,7 @@ static void decode_opc_mxu(CPUMIPSState *env, Dis=
asContext *ctx)
>          generate_exception_end(ctx, EXCP_RI);
>          break;
>      case OPC_MXU_S8LDD:
> -        /* TODO: Implement emulation of S8LDD instruction. */
> -        MIPS_INVAL("OPC_MXU_S8LDD");
> -        generate_exception_end(ctx, EXCP_RI);
> +        gen_mxu_s8ldd(ctx);
>          break;
>      case OPC_MXU_S8STD:
>          /* TODO: Implement emulation of S8STD instruction. */
> --
> 2.7.4
>=20
