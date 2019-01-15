Received: from eggs.gnu.org ([209.51.188.92]:55941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gjWCT-0004oc-0V
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:24:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gjWCR-0007zx-TR
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:24:44 -0500
Received: from mail-eopbgr700114.outbound.protection.outlook.com
	([40.107.70.114]:44546
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gjWCR-0007wn-JJ
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:24:43 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 15 Jan 2019 21:24:39 +0000
Message-ID: <BN6PR2201MB1251C7D96D9B196AF9C12614C6810@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <cover.1547403692.git.noring@nocrew.org>,
	<b05a382fc4a444e74b3787052248b1f9fda5ab88.1547403692.git.noring@nocrew.org>
In-Reply-To: <b05a382fc4a444e74b3787052248b1f9fda5ab88.1547403692.git.noring@nocrew.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 3/9] target/mips: Support the R5900 PCPYLD
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
> Sent: Sunday, January 13, 2019 8:03 PM
> To: Aleksandar Markovic; Aurelien Jarno; Philippe Mathieu-Daud=E9
> Cc: J=FCrgen Urban; Maciej W. Rozycki; qemu-devel@nongnu.org
> Subject: [PATCH 3/9] target/mips: Support the R5900 PCPYLD multimedia ins=
truction
>=20
> Signed-off-by: Fredrik Noring <noring@nocrew.org>
> ---
>  target/mips/translate.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 9d5150ec8b..40faf9cb36 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -27293,11 +27293,34 @@ static void decode_mmi1(CPUMIPSState *env, Disa=
sContext *ctx)
>      }
>  }
>=20
> +static void gen_mmi_pcpyld(DisasContext *ctx, int rd, int rs, int rt)
> +{
> +    if (rd !=3D 0) {
> +        if (rs !=3D 0) {
> +            tcg_gen_mov_i64(cpu_mmr[rd], cpu_gpr[rs]);
> +        } else {
> +            tcg_gen_movi_i64(cpu_mmr[rd], 0);
> +        }
> +
> +        if (rt !=3D 0) {
> +            tcg_gen_mov_i64(cpu_gpr[rd], cpu_gpr[rt]);
> +        } else {
> +            tcg_gen_movi_i64(cpu_gpr[rd], 0);
> +        }
> +    }
> +}
> +
>  static void decode_mmi2(CPUMIPSState *env, DisasContext *ctx)
>  {
>      uint32_t opc =3D MASK_MMI2(ctx->opcode);
> +    int rs =3D extract32(ctx->opcode, 21, 5);
> +    int rt =3D extract32(ctx->opcode, 16, 5);
> +    int rd =3D extract32(ctx->opcode, 11, 5);
>=20

If you move last three lines to gen_mmi_pcpyld(), and correct its arguments=
,
this patch has:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

>      switch (opc) {
> +    case MMI_OPC_2_PCPYLD:
> +        gen_mmi_pcpyld(ctx, rd, rs, rt);
> +        break;
>      case MMI_OPC_2_PMADDW:    /* TODO: MMI_OPC_2_PMADDW */
>      case MMI_OPC_2_PSLLVW:    /* TODO: MMI_OPC_2_PSLLVW */
>      case MMI_OPC_2_PSRLVW:    /* TODO: MMI_OPC_2_PSRLVW */
> @@ -27307,7 +27330,6 @@ static void decode_mmi2(CPUMIPSState *env, DisasC=
ontext *ctx)
>      case MMI_OPC_2_PINTH:     /* TODO: MMI_OPC_2_PINTH */
>      case MMI_OPC_2_PMULTW:    /* TODO: MMI_OPC_2_PMULTW */
>      case MMI_OPC_2_PDIVW:     /* TODO: MMI_OPC_2_PDIVW */
> -    case MMI_OPC_2_PCPYLD:    /* TODO: MMI_OPC_2_PCPYLD */
>      case MMI_OPC_2_PMADDH:    /* TODO: MMI_OPC_2_PMADDH */
>      case MMI_OPC_2_PHMADH:    /* TODO: MMI_OPC_2_PHMADH */
>      case MMI_OPC_2_PAND:      /* TODO: MMI_OPC_2_PAND */
> --
> 2.19.2=
