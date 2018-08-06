Received: from eggs.gnu.org ([2001:4830:134:3::10]:58583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fmk8n-0003zb-RP
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 14:22:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fmk8k-0001St-9u
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 14:22:01 -0400
Received: from mail-sn1nam02on0110.outbound.protection.outlook.com
	([104.47.36.110]:1872
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fmk8j-0001RF-TI
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 14:21:58 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 6 Aug 2018 18:21:53 +0000
Message-ID: <BN7PR08MB4868CF1F900F491D44B2C15BC6200@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1533574847-19294-24-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1533574847-19294-24-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 23/80] target/mips: Add emulation of
 nanoMIPS 16-bit load and store instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, "thuth@redhat.com" <thuth@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Monday, August 6, 2018 6:59 PM
>=20
> From: Yongbok Kim <yongbok.kim@mips.com>
>=20
> Add emulation of LWXS16, LB16, SB16, LBU16, LH16, SH16, LHU16, LW16, LWSP=
16,
> LW4X4, SW4X4, LWGP16, SWSP16, SW16, and SWGP16 instructions.
>=20
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 81 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 81 insertions(+)
>=20

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 7a3d45b..db07cfe 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -16599,6 +16599,7 @@ static int decode_nanomips_opc(CPUMIPSState *env,=
 DisasContext *ctx)
>      int rt =3D decode_gpr_gpr3(NANOMIPS_EXTRACT_RD(ctx->opcode));
>      int rs =3D decode_gpr_gpr3(NANOMIPS_EXTRACT_RS(ctx->opcode));
>      int rd =3D decode_gpr_gpr3(NANOMIPS_EXTRACT_RS1(ctx->opcode));
> +    int offset;
>      int imm;
>=20
>      /* make sure instructions are on a halfword boundary */
> @@ -16666,6 +16667,13 @@ static int decode_nanomips_opc(CPUMIPSState *env=
, DisasContext *ctx)
>          }
>          break;
>      case NM_P16C:
> +        switch (ctx->opcode & 1) {
> +        case NM_POOL16C_0:
> +            break;
> +        case NM_LWXS16:
> +            gen_ldxs(ctx, rt, rs, rd);
> +            break;
> +        }
>          break;
>      case NM_P16_A1:
>          switch (extract32(ctx->opcode, 6, 1)) {
> @@ -16737,24 +16745,97 @@ static int decode_nanomips_opc(CPUMIPSState *en=
v, DisasContext *ctx)
>      case NM_ANDI16:
>          break;
>      case NM_P16_LB:
> +        switch (extract32(ctx->opcode, 2, 2)) {
> +        case NM_LB16:
> +            offset =3D extract32(ctx->opcode, 0, 2);
> +            gen_ld(ctx, OPC_LB, rt, rs, offset);
> +            break;
> +        case NM_SB16:
> +            offset =3D decode_gpr_gpr3_src_store(
> +                         NANOMIPS_EXTRACT_RD(ctx->opcode));
> +            gen_st(ctx, OPC_SB, rt, rs, offset);
> +            break;
> +        case NM_LBU16:
> +            offset =3D extract32(ctx->opcode, 0, 2);
> +            gen_ld(ctx, OPC_LBU, rt, rs, offset);
> +            break;
> +        default:
> +            generate_exception_end(ctx, EXCP_RI);
> +            break;
> +        }
>          break;
>      case NM_P16_LH:
> +        switch ((extract32(ctx->opcode, 3, 1) << 1) | (ctx->opcode & 1))=
 {
> +        case NM_LH16:
> +            offset =3D extract32(ctx->opcode, 1, 2) << 1;
> +            gen_ld(ctx, OPC_LH, rt, rs, offset);
> +            break;
> +        case NM_SH16:
> +            offset =3D decode_gpr_gpr3_src_store(
> +                         NANOMIPS_EXTRACT_RD(ctx->opcode));
> +            gen_st(ctx, OPC_SH, rt, rs, offset);
> +            break;
> +        case NM_LHU16:
> +            offset =3D extract32(ctx->opcode, 1, 2) << 1;
> +            gen_ld(ctx, OPC_LHU, rt, rs, offset);
> +            break;
> +        default:
> +            generate_exception_end(ctx, EXCP_RI);
> +            break;
> +        }
>          break;
>      case NM_LW16:
> +        offset =3D extract32(ctx->opcode, 0, 4) << 2;
> +        gen_ld(ctx, OPC_LW, rt, rs, offset);
>          break;
>      case NM_LWSP16:
> +        rt =3D NANOMIPS_EXTRACT_RD5(ctx->opcode);
> +        offset =3D extract32(ctx->opcode, 0, 5) << 2;
> +        gen_ld(ctx, OPC_LW, rt, 29, offset);
>          break;
>      case NM_LW4X4:
> +        rt =3D (extract32(ctx->opcode, 9, 1) << 3) |
> +             extract32(ctx->opcode, 5, 3);
> +        rs =3D (extract32(ctx->opcode, 4, 1) << 3) |
> +             extract32(ctx->opcode, 0, 3);
> +        offset =3D (extract32(ctx->opcode, 3, 1) << 3) |
> +                 (extract32(ctx->opcode, 8, 1) << 2);
> +        rt =3D decode_gpr_gpr4(rt);
> +        rs =3D decode_gpr_gpr4(rs);
> +        gen_ld(ctx, OPC_LW, rt, rs, offset);
>          break;
>      case NM_SW4X4:
> +        rt =3D (extract32(ctx->opcode, 9, 1) << 3) |
> +             extract32(ctx->opcode, 5, 3);
> +        rs =3D (extract32(ctx->opcode, 4, 1) << 3) |
> +             extract32(ctx->opcode, 0, 3);
> +        offset =3D (extract32(ctx->opcode, 3, 1) << 3) |
> +                 (extract32(ctx->opcode, 8, 1) << 2);
> +        rt =3D decode_gpr_gpr4_zero(rt);
> +        rs =3D decode_gpr_gpr4(rs);
> +        gen_st(ctx, OPC_SW, rt, rs, offset);
>          break;
>      case NM_LWGP16:
> +        offset =3D extract32(ctx->opcode, 0, 7) << 2;
> +        gen_ld(ctx, OPC_LW, rt, 28, offset);
>          break;
>      case NM_SWSP16:
> +        rt =3D NANOMIPS_EXTRACT_RD5(ctx->opcode);
> +        offset =3D extract32(ctx->opcode, 0, 5) << 2;
> +        gen_st(ctx, OPC_SW, rt, 29, offset);
>          break;
>      case NM_SW16:
> +        rt =3D decode_gpr_gpr3_src_store(
> +                 NANOMIPS_EXTRACT_RD(ctx->opcode));
> +        rs =3D decode_gpr_gpr3(NANOMIPS_EXTRACT_RS(ctx->opcode));
> +        offset =3D extract32(ctx->opcode, 0, 4) << 2;
> +        gen_st(ctx, OPC_SW, rt, rs, offset);
>          break;
>      case NM_SWGP16:
> +        rt =3D decode_gpr_gpr3_src_store(
> +                 NANOMIPS_EXTRACT_RD(ctx->opcode));
> +        offset =3D extract32(ctx->opcode, 0, 7) << 2;
> +        gen_st(ctx, OPC_SW, rt, 28, offset);
>          break;
>      case NM_BC16:
>          gen_compute_branch(ctx, OPC_BEQ, 2, 0, 0,
> --
> 2.7.4
>=20
> =
