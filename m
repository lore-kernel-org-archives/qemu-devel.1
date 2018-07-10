Received: from eggs.gnu.org ([2001:4830:134:3::10]:47813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcsy9-0001DE-Uz
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 09:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcsy3-0006r1-Vk
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 09:46:18 -0400
Received: from mail-eopbgr730125.outbound.protection.outlook.com
	([40.107.73.125]:54021
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fcsy3-0006qW-Kf
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 09:46:11 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 10 Jul 2018 13:46:09 +0000
Message-ID: <BN7PR08MB48682391B15434C523DE6643C65B0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1531169431-10772-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1531169431-10772-8-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1531169431-10772-8-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 07/33] target/mips: Add emulation of
 nanoMIPS 48-bit instructions
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

> Subject: [PATCH v2 07/33] target/mips: Add emulation of nanoMIPS 48-bit i=
nstructions
>
> From: Yongbok Kim <yongbok.kim@mips.com>
>
> Add emulation of LI48, ADDIU48, ADDIUGP48, ADDIUPC48, LWPC48, and
> SWPC48 instructions.
>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 66 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 66 insertions(+)
>
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 09bb9b2..ae46de2 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -16541,6 +16541,72 @@ static int decode_nanomips_32_48_opc(CPUMIPSStat=
e *env, > DisasContext *ctx)
>          }
>          break;
>      case NM_P48I:
> +        insn =3D cpu_lduw_code(env, ctx->base.pc_next + 4);
> +        switch ((ctx->opcode >> 16) & 0x1f) {
> +        case NM_LI48:
> +            if (rt !=3D 0) {
> +                tcg_gen_movi_tl(cpu_gpr[rt],
> +                                extract32(ctx->opcode, 0, 16) | insn << =
16);
> +            }
> +            break;
> +        case NM_ADDIU48:
> +            if (rt !=3D 0) {
> +                tcg_gen_addi_tl(cpu_gpr[rt], cpu_gpr[rt],
> +                                extract32(ctx->opcode, 0, 16) | insn << =
16);
> +                tcg_gen_ext32s_tl(cpu_gpr[rt], cpu_gpr[rt]);
> +            }
> +            break;
> +        case NM_ADDIUGP48:
> +            if (rt !=3D 0) {
> +                tcg_gen_addi_tl(cpu_gpr[rt], cpu_gpr[28],
> +                                extract32(ctx->opcode, 0, 16) | insn << =
16);
> +                tcg_gen_ext32s_tl(cpu_gpr[rt], cpu_gpr[rt]);
> +            }
> +            break;
> +        case NM_ADDIUPC48:
> +            if (rt !=3D 0) {
> +                int32_t offset =3D extract32(ctx->opcode, 0, 16) | insn =
<< 16;
> +                target_long addr =3D addr_add(ctx, ctx->base.pc_next + 6=
, offset);
> +
> +                tcg_gen_movi_tl(cpu_gpr[rt], addr);
> +                tcg_gen_ext32s_tl(cpu_gpr[rt], cpu_gpr[rt]);
> +            }
> +            break;
> +        case NM_LWPC48:
> +            if (rt !=3D 0) {
> +                TCGv t0;
> +                t0 =3D tcg_temp_new();
> +
> +                int32_t offset =3D extract32(ctx->opcode, 0, 16) | insn =
<< 16;
> +                target_long addr =3D addr_add(ctx, ctx->base.pc_next + 6=
, offset);
> +
> +                tcg_gen_movi_tl(t0, addr);
> +                tcg_gen_qemu_ld_tl(cpu_gpr[rt], t0, ctx->mem_idx, MO_TES=
L);
> +                tcg_temp_free(t0);
> +            }
> +            break;
> +        case NM_SWPC48:
> +        {
> +            TCGv t0, t1;
> +            t0 =3D tcg_temp_new();
> +            t1 =3D tcg_temp_new();
> +
> +            int32_t offset =3D extract32(ctx->opcode, 0, 16) | insn << 1=
6;
> +            target_long addr =3D addr_add(ctx, ctx->base.pc_next + 6, of=
fset);
> +
> +            tcg_gen_movi_tl(t0, addr);
> +            gen_load_gpr(t1, rt);
> +
> +            tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUL);
> +
> +            tcg_temp_free(t0);
> +            tcg_temp_free(t1);
> +        }
> +            break;

Wrong indentation.

Apart from that:

Reviewed-by:  Aleksandar Markovic <amarkovic@wavecomp.com>

> +        default:
> +            generate_exception_end(ctx, EXCP_RI);
> +            break;
> +        }
>          return 6;
>      case NM_P_U12:
>          switch ((ctx->opcode >> 12) & 0x0f) {
> --
> 2.7.4
