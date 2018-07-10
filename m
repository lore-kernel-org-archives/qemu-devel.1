Received: from eggs.gnu.org ([2001:4830:134:3::10]:49175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fct3v-0004Ys-Jz
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 09:52:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fct3s-00026w-83
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 09:52:15 -0400
Received: from mail-sn1nam02on0099.outbound.protection.outlook.com
	([104.47.36.99]:16947
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fct3r-00026i-Re
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 09:52:12 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 10 Jul 2018 13:52:07 +0000
Message-ID: <BN7PR08MB48680887368A7584244847A4C65B0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1531169431-10772-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1531169431-10772-9-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1531169431-10772-9-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 08/33] target/mips: Add emulation of
 nanoMIPS FP instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "f4bug@amsat.org" <f4bug@amsat.org>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> Subject: [PATCH v2 08/33] target/mips: Add emulation of nanoMIPS FP instr=
uctions
>
> From: Yongbok Kim <yongbok.kim@mips.com>
>
> Add emulation of basic floating point arithmetic for nanoMIPS.
>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 300 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 300 insertions(+)
>
> diff --git a/target/mips/translate.c b/target/mips/translate.c

For future cleanups, the code should be organized so that there is one-to-o=
ne correspondence between functions (in the code) and instruction pools (as=
 they are defined in the documentation).

Also, opcode/register extraction should be consistent, as mentioned in othe=
r reviewer comments.

That said, for the present development stage:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

> index ae46de2..176d51d 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -16447,6 +16447,305 @@ static void gen_pool16c_nanomips_insn(DisasCont=
ext *ctx)
>      }
>  }
>
> +static void gen_pool32f_nanomips_insn(DisasContext *ctx)
> +{
> +    int rt, rs, rd;
> +
> +    rt =3D (ctx->opcode >> 21) & 0x1f;
> +    rs =3D (ctx->opcode >> 16) & 0x1f;
> +    rd =3D (ctx->opcode >> 11) & 0x1f;
> +
> +    if (!(ctx->CP0_Config1 & (1 << CP0C1_FP))) {
> +        generate_exception_end(ctx, EXCP_RI);
> +        return;
> +    }
> +    check_cp1_enabled(ctx);
> +    switch (ctx->opcode & 0x07) {
> +    case NM_POOL32F_0:
> +        switch ((ctx->opcode >> 3) & 0x7f) {
> +        case NM_RINT_S:
> +            gen_farith(ctx, OPC_RINT_S, 0, rt, rs, 0);
> +            break;
> +        case NM_RINT_D:
> +            gen_farith(ctx, OPC_RINT_D, 0, rt, rs, 0);
> +            break;
> +        case NM_CLASS_S:
> +            gen_farith(ctx, OPC_CLASS_S, 0, rt, rs, 0);
> +            break;
> +        case NM_CLASS_D:
> +            gen_farith(ctx, OPC_CLASS_D, 0, rt, rs, 0);
> +            break;
> +        case NM_ADD_S:
> +            gen_farith(ctx, OPC_ADD_S, rt, rs, rd, 0);
> +            break;
> +        case NM_ADD_D:
> +            gen_farith(ctx, OPC_ADD_D, rt, rs, rd, 0);
> +            break;
> +        case NM_SUB_S:
> +            gen_farith(ctx, OPC_SUB_S, rt, rs, rd, 0);
> +            break;
> +        case NM_SUB_D:
> +            gen_farith(ctx, OPC_SUB_D, rt, rs, rd, 0);
> +            break;
> +        case NM_MUL_S:
> +            gen_farith(ctx, OPC_MUL_S, rt, rs, rd, 0);
> +            break;
> +        case NM_MUL_D:
> +            gen_farith(ctx, OPC_MUL_D, rt, rs, rd, 0);
> +            break;
> +        case NM_DIV_S:
> +            gen_farith(ctx, OPC_DIV_S, rt, rs, rd, 0);
> +            break;
> +        case NM_DIV_D:
> +            gen_farith(ctx, OPC_DIV_D, rt, rs, rd, 0);
> +            break;
> +        case NM_SELEQZ_S:
> +            gen_sel_s(ctx, OPC_SELEQZ_S, rd, rt, rs);
> +            break;
> +        case NM_SELEQZ_D:
> +            gen_sel_d(ctx, OPC_SELEQZ_D, rd, rt, rs);
> +            break;
> +        case NM_SELNEZ_S:
> +            gen_sel_s(ctx, OPC_SELNEZ_S, rd, rt, rs);
> +            break;
> +        case NM_SELNEZ_D:
> +            gen_sel_d(ctx, OPC_SELNEZ_D, rd, rt, rs);
> +            break;
> +        case NM_SEL_S:
> +            gen_sel_s(ctx, OPC_SEL_S, rd, rt, rs);
> +            break;
> +        case NM_SEL_D:
> +            gen_sel_d(ctx, OPC_SEL_D, rd, rt, rs);
> +            break;
> +        case NM_MADDF_S:
> +            gen_farith(ctx, OPC_MADDF_S, rt, rs, rd, 0);
> +            break;
> +        case NM_MADDF_D:
> +            gen_farith(ctx, OPC_MADDF_D, rt, rs, rd, 0);
> +            break;
> +        case NM_MSUBF_S:
> +            gen_farith(ctx, OPC_MSUBF_S, rt, rs, rd, 0);
> +            break;
> +        case NM_MSUBF_D:
> +            gen_farith(ctx, OPC_MSUBF_D, rt, rs, rd, 0);
> +            break;
> +        default:
> +            generate_exception_end(ctx, EXCP_RI);
> +            break;
> +        }
> +        break;
> +    case NM_POOL32F_3:
> +        switch ((ctx->opcode >> 3) & 0x07) {
> +        case NM_MIN_FMT:
> +            switch ((ctx->opcode >> 9) & 1) {
> +            case FMT_SDPS_S:
> +                gen_farith(ctx, OPC_MIN_S, rt, rs, rd, 0);
> +                break;
> +            case FMT_SDPS_D:
> +                gen_farith(ctx, OPC_MIN_D, rt, rs, rd, 0);
> +                break;
> +            }
> +            break;
> +        case NM_MAX_FMT:
> +            switch ((ctx->opcode >> 9) & 1) {
> +            case FMT_SDPS_S:
> +                gen_farith(ctx, OPC_MAX_S, rt, rs, rd, 0);
> +                break;
> +            case FMT_SDPS_D:
> +                gen_farith(ctx, OPC_MAX_D, rt, rs, rd, 0);
> +                break;
> +            }
> +            break;
> +        case NM_MINA_FMT:
> +            switch ((ctx->opcode >> 9) & 1) {
> +            case FMT_SDPS_S:
> +                gen_farith(ctx, OPC_MINA_S, rt, rs, rd, 0);
> +                break;
> +            case FMT_SDPS_D:
> +                gen_farith(ctx, OPC_MINA_D, rt, rs, rd, 0);
> +                break;
> +            }
> +            break;
> +        case NM_MAXA_FMT:
> +            switch ((ctx->opcode >> 9) & 1) {
> +            case FMT_SDPS_S:
> +                gen_farith(ctx, OPC_MAXA_S, rt, rs, rd, 0);
> +                break;
> +            case FMT_SDPS_D:
> +                gen_farith(ctx, OPC_MAXA_D, rt, rs, rd, 0);
> +                break;
> +            }
> +            break;
> +        case NM_POOL32FXF:
> +            switch ((ctx->opcode >> 6) & 0xff) {
> +            case NM_CFC1:
> +                gen_cp1(ctx, OPC_CFC1, rt, rs);
> +                break;
> +            case NM_CTC1:
> +                gen_cp1(ctx, OPC_CTC1, rt, rs);
> +                break;
> +            case NM_MFC1:
> +                gen_cp1(ctx, OPC_MFC1, rt, rs);
> +                break;
> +            case NM_MTC1:
> +                gen_cp1(ctx, OPC_MTC1, rt, rs);
> +                break;
> +            case NM_MFHC1:
> +                gen_cp1(ctx, OPC_MFHC1, rt, rs);
> +                break;
> +            case NM_MTHC1:
> +                gen_cp1(ctx, OPC_MTHC1, rt, rs);
> +                break;
> +            case NM_CVT_S_PL:
> +                gen_farith(ctx, OPC_CVT_S_PL, -1, rs, rt, 0);
> +                break;
> +            case NM_CVT_S_PU:
> +                gen_farith(ctx, OPC_CVT_S_PU, -1, rs, rt, 0);
> +                break;
> +            default:
> +                switch ((ctx->opcode >> 6) & 0x1ff) {
> +                case NM_CVT_L_S:
> +                    gen_farith(ctx, OPC_CVT_L_S, -1, rs, rt, 0);
> +                    break;
> +                case NM_CVT_L_D:
> +                    gen_farith(ctx, OPC_CVT_L_D, -1, rs, rt, 0);
> +                    break;
> +                case NM_CVT_W_S:
> +                    gen_farith(ctx, OPC_CVT_W_S, -1, rs, rt, 0);
> +                    break;
> +                case NM_CVT_W_D:
> +                    gen_farith(ctx, OPC_CVT_W_D, -1, rs, rt, 0);
> +                    break;
> +                case NM_RSQRT_S:
> +                    gen_farith(ctx, OPC_RSQRT_S, -1, rs, rt, 0);
> +                    break;
> +                case NM_RSQRT_D:
> +                    gen_farith(ctx, OPC_RSQRT_D, -1, rs, rt, 0);
> +                    break;
> +                case NM_SQRT_S:
> +                    gen_farith(ctx, OPC_SQRT_S, -1, rs, rt, 0);
> +                    break;
> +                case NM_SQRT_D:
> +                    gen_farith(ctx, OPC_SQRT_D, -1, rs, rt, 0);
> +                    break;
> +                case NM_RECIP_S:
> +                    gen_farith(ctx, OPC_RECIP_S, -1, rs, rt, 0);
> +                    break;
> +                case NM_RECIP_D:
> +                    gen_farith(ctx, OPC_RECIP_D, -1, rs, rt, 0);
> +                    break;
> +                case NM_FLOOR_L_S:
> +                    gen_farith(ctx, OPC_FLOOR_L_S, -1, rs, rt, 0);
> +                    break;
> +                case NM_FLOOR_L_D:
> +                    gen_farith(ctx, OPC_FLOOR_L_D, -1, rs, rt, 0);
> +                    break;
> +                case NM_FLOOR_W_S:
> +                    gen_farith(ctx, OPC_FLOOR_W_S, -1, rs, rt, 0);
> +                    break;
> +                case NM_FLOOR_W_D:
> +                    gen_farith(ctx, OPC_FLOOR_W_D, -1, rs, rt, 0);
> +                    break;
> +                case NM_CEIL_L_S:
> +                    gen_farith(ctx, OPC_CEIL_L_S, -1, rs, rt, 0);
> +                    break;
> +                case NM_CEIL_L_D:
> +                    gen_farith(ctx, OPC_CEIL_L_D, -1, rs, rt, 0);
> +                    break;
> +                case NM_CEIL_W_S:
> +                    gen_farith(ctx, OPC_CEIL_W_S, -1, rs, rt, 0);
> +                    break;
> +                case NM_CEIL_W_D:
> +                    gen_farith(ctx, OPC_CEIL_W_D, -1, rs, rt, 0);
> +                    break;
> +                case NM_TRUNC_L_S:
> +                    gen_farith(ctx, OPC_TRUNC_L_S, -1, rs, rt, 0);
> +                    break;
> +                case NM_TRUNC_L_D:
> +                    gen_farith(ctx, OPC_TRUNC_L_D, -1, rs, rt, 0);
> +                    break;
> +                case NM_TRUNC_W_S:
> +                    gen_farith(ctx, OPC_TRUNC_W_S, -1, rs, rt, 0);
> +                    break;
> +                case NM_TRUNC_W_D:
> +                    gen_farith(ctx, OPC_TRUNC_W_D, -1, rs, rt, 0);
> +                    break;
> +                case NM_ROUND_L_S:
> +                    gen_farith(ctx, OPC_ROUND_L_S, -1, rs, rt, 0);
> +                    break;
> +                case NM_ROUND_L_D:
> +                    gen_farith(ctx, OPC_ROUND_L_D, -1, rs, rt, 0);
> +                    break;
> +                case NM_ROUND_W_S:
> +                    gen_farith(ctx, OPC_ROUND_W_S, -1, rs, rt, 0);
> +                    break;
> +                case NM_ROUND_W_D:
> +                    gen_farith(ctx, OPC_ROUND_W_D, -1, rs, rt, 0);
> +                    break;
> +                case NM_MOV_S:
> +                    gen_farith(ctx, OPC_MOV_S, -1, rs, rt, 0);
> +                    break;
> +                case NM_MOV_D:
> +                    gen_farith(ctx, OPC_MOV_D, -1, rs, rt, 0);
> +                    break;
> +                case NM_ABS_S:
> +                    gen_farith(ctx, OPC_ABS_S, -1, rs, rt, 0);
> +                    break;
> +                case NM_ABS_D:
> +                    gen_farith(ctx, OPC_ABS_D, -1, rs, rt, 0);
> +                    break;
> +                case NM_NEG_S:
> +                    gen_farith(ctx, OPC_NEG_S, -1, rs, rt, 0);
> +                    break;
> +                case NM_NEG_D:
> +                    gen_farith(ctx, OPC_NEG_D, -1, rs, rt, 0);
> +                    break;
> +                case NM_CVT_D_S:
> +                    gen_farith(ctx, OPC_CVT_D_S, -1, rs, rt, 0);
> +                    break;
> +                case NM_CVT_D_W:
> +                    gen_farith(ctx, OPC_CVT_D_W, -1, rs, rt, 0);
> +                    break;
> +                case NM_CVT_D_L:
> +                    gen_farith(ctx, OPC_CVT_D_L, -1, rs, rt, 0);
> +                    break;
> +                case NM_CVT_S_D:
> +                    gen_farith(ctx, OPC_CVT_S_D, -1, rs, rt, 0);
> +                    break;
> +                case NM_CVT_S_W:
> +                    gen_farith(ctx, OPC_CVT_S_W, -1, rs, rt, 0);
> +                    break;
> +                case NM_CVT_S_L:
> +                    gen_farith(ctx, OPC_CVT_S_L, -1, rs, rt, 0);
> +                    break;
> +                default:
> +                    generate_exception_end(ctx, EXCP_RI);
> +                    break;
> +                }
> +                break;
> +            }
> +            break;
> +        }
> +        break;
> +    case NM_POOL32F_5:
> +        switch ((ctx->opcode >> 3) & 0x07) {
> +        case NM_CMP_CONDN_S:
> +            gen_r6_cmp_s(ctx, (ctx->opcode >> 6) & 0x1f, rt, rs, rd);
> +            break;
> +        case NM_CMP_CONDN_D:
> +            gen_r6_cmp_d(ctx, (ctx->opcode >> 6) & 0x1f, rt, rs, rd);
> +            break;
> +        default:
> +            generate_exception_end(ctx, EXCP_RI);
> +            break;
> +        }
> +        break;
> +    default:
> +        generate_exception_end(ctx, EXCP_RI);
> +        break;
> +    }
> +}
> +
>  static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ct=
x)
>  {
>      uint16_t insn;
> @@ -16746,6 +17045,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState=
 *env, > DisasContext *ctx)
>          }
>          break;
>      case NM_POOL32F:
> +        gen_pool32f_nanomips_insn(ctx);
>          break;
>      case NM_POOL32S:
>          break;
> --
> 2.7.4
>
>
