Received: from eggs.gnu.org ([209.51.188.92]:33761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gjWGE-0006aF-1p
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:28:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gjWFu-0002LG-Mh
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:28:21 -0500
Received: from mail-eopbgr740090.outbound.protection.outlook.com
	([40.107.74.90]:39712
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gjWFp-0002IH-4N
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:28:15 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 15 Jan 2019 21:28:07 +0000
Message-ID: <BN6PR2201MB1251BECE23FBE4C975057FDBC6810@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <cover.1547403692.git.noring@nocrew.org>,
	<25ac8b01ff9243ab79efdc6912ec165b12831531.1547403692.git.noring@nocrew.org>
In-Reply-To: <25ac8b01ff9243ab79efdc6912ec165b12831531.1547403692.git.noring@nocrew.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 4/9] target/mips: Support the R5900 PCPYUD
 multimedia instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: =?iso-8859-1?Q?J=FCrgen_Urban?= <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> From: Fredrik Noring <noring@nocrew.org>
> Sent: Sunday, January 13, 2019 8:04 PM
> To: Aleksandar Markovic; Aurelien Jarno; Philippe Mathieu-Daud=E9
> Cc: J=FCrgen Urban; Maciej W. Rozycki; qemu-devel@nongnu.org
> Subject: [PATCH 4/9] target/mips: Support the R5900 PCPYUD multimedia ins=
truction
>=20
> Signed-off-by: Fredrik Noring <noring@nocrew.org>
> ---
>  target/mips/translate.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 40faf9cb36..8c350729bc 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -27351,11 +27351,34 @@ static void decode_mmi2(CPUMIPSState *env, Disa=
sContext *ctx)
>      }
>  }
>=20
> +static void gen_mmi_pcpyud(DisasContext *ctx, int rd, int rs, int rt)
> +{
> +    if (rd !=3D 0) {
> +        if (rs !=3D 0) {
> +            tcg_gen_mov_i64(cpu_gpr[rd], cpu_mmr[rs]);
> +        } else {
> +            tcg_gen_movi_i64(cpu_gpr[rd], 0);
> +        }
> +
> +        if (rt !=3D 0) {
> +            tcg_gen_mov_i64(cpu_mmr[rd], cpu_mmr[rt]);
> +        } else {
> +            tcg_gen_movi_i64(cpu_mmr[rd], 0);
> +        }
> +    }
> +}
> +
>  static void decode_mmi3(CPUMIPSState *env, DisasContext *ctx)
>  {
>      uint32_t opc =3D MASK_MMI3(ctx->opcode);
> +    int rs =3D extract32(ctx->opcode, 21, 5);
> +    int rt =3D extract32(ctx->opcode, 16, 5);
> +    int rd =3D extract32(ctx->opcode, 11, 5);
>=20

The similar caveat as in the previous patch: If you move last three lines
to gen_mmi_pcpyud(), and correct its arguments, this patch has:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

>      switch (opc) {
> +    case MMI_OPC_3_PCPYUD:
> +        gen_mmi_pcpyud(ctx, rd, rs, rt);
> +        break;
>      case MMI_OPC_3_PMADDUW:    /* TODO: MMI_OPC_3_PMADDUW */
>      case MMI_OPC_3_PSRAVW:     /* TODO: MMI_OPC_3_PSRAVW */
>      case MMI_OPC_3_PMTHI:      /* TODO: MMI_OPC_3_PMTHI */
> @@ -27363,7 +27386,6 @@ static void decode_mmi3(CPUMIPSState *env, DisasC=
ontext *ctx)
>      case MMI_OPC_3_PINTEH:     /* TODO: MMI_OPC_3_PINTEH */
>      case MMI_OPC_3_PMULTUW:    /* TODO: MMI_OPC_3_PMULTUW */
>      case MMI_OPC_3_PDIVUW:     /* TODO: MMI_OPC_3_PDIVUW */
> -    case MMI_OPC_3_PCPYUD:     /* TODO: MMI_OPC_3_PCPYUD */
>      case MMI_OPC_3_POR:        /* TODO: MMI_OPC_3_POR */
>      case MMI_OPC_3_PNOR:       /* TODO: MMI_OPC_3_PNOR */
>      case MMI_OPC_3_PEXCH:      /* TODO: MMI_OPC_3_PEXCH */
> --
> 2.19.2
