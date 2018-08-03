Received: from eggs.gnu.org ([2001:4830:134:3::10]:52394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1flXjt-0008LS-CK
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 06:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1flXjq-0002N0-59
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 06:55:21 -0400
Received: from mail-sn1nam01on0102.outbound.protection.outlook.com
	([104.47.32.102]:34070
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1flXjp-0002MZ-O8
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 06:55:18 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 3 Aug 2018 10:55:04 +0000
Message-ID: <BN7PR08MB48683BB5F8768979B33F03E4C6230@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>,
	<1533219424-7627-39-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1533219424-7627-39-git-send-email-stefan.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6 38/77] target/mips: Add emulation of DSP
 ASE for nanoMIPS - part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

>=20
> From: Stefan Markovic <stefan.markovic@rt-rk.com>
> Sent: Thursday, August 2, 2018 4:16 PM
> Subject: [PATCH v6 38/77] target/mips: Add emulation of DSP ASE for nanoM=
IPS - part 1
>=20
> From: Stefan Markovic <smarkovic@wavecomp.com>
>=20
> Add emulation of DSP ASE instructions for nanoMIPS - part 1.
>=20
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 579 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 579 insertions(+)
>=20
> diff --git a/target/mips/translate.c b/target/mips/translate.c

> +    case OPC_ADDQH_R_PH:
> +        switch (extract32(ctx->opcode, 10, 1)) {
> +        case 0:
> +            /* ADDQH_PH */
> +            gen_helper_addqh_ph(v1_t, v1_t, v2_t);
> +            gen_store_gpr(v1_t, ret);
> +            break;

check_dsp(ctx) or check_dspr2(ctx) missing, whatever is needed. Here and in=
 many places in this patch.

Also, constants OPC_ADDQH_R_W should not be used, but their corresponding N=
M_XXX, which should be defined in one of preceding patches for DSP opcodes.

> +    case OPC_APPEND:
> +        {
> +            gen_load_gpr(t0, rs);
> +
> +            if (rd !=3D 0) {
> +                tcg_gen_deposit_tl(cpu_gpr[rt], t0, cpu_gpr[rt], rd, 32 =
- rd);
> +            }
> +            tcg_gen_ext32s_tl(cpu_gpr[rt], cpu_gpr[rt]);
> +        }
> +        break;

Indentation not needed, checkdsp()/checkdspr2().

> +    case OPC_SHRA_R_W:
> +        {
> +            tcg_gen_movi_tl(t0, rd);
> +
> +            check_dsp(ctx);
> +            gen_helper_shra_r_w(v1_t, t0, v1_t);
> +            gen_store_gpr(v1_t, rt);
> +        }
> +        break;

Indentation not needed, checkdsp()/checkdspr2().

> +    case OPC_SHRA_R_PH:
> +        {
> +            tcg_gen_movi_tl(t0, rd >> 1);
> +
> +            switch (extract32(ctx->opcode, 10, 1)) {
> +            case 0:
> +                /* SHRA_PH */
> +                check_dsp(ctx);
> +                gen_helper_shra_ph(v1_t, t0, v1_t);
> +                break;
> +                gen_store_gpr(v1_t, rt);
> +            case 1:
> +                /* SHRA_R_PH */
> +                check_dsp(ctx);
> +                gen_helper_shra_r_ph(v1_t, t0, v1_t);
> +                gen_store_gpr(v1_t, rt);
> +                break;
> +            }
> +        }
> +        break;

Indentation not needed.

> +    case OPC_SHLL_S_PH:
> +        {
> +            tcg_gen_movi_tl(t0, rd >> 1);
> +
> +            switch (extract32(ctx->opcode, 10, 2)) {
> +            case 0:
> +                /* SHLL_PH */
> +                check_dsp(ctx);
> +                gen_helper_shll_ph(v1_t, t0, v1_t, cpu_env);
> +                gen_store_gpr(v1_t, rt);
> +                break;
> +            case 2:
> +                /* SHLL_S_PH */
> +                check_dsp(ctx);
> +                gen_helper_shll_s_ph(v1_t, t0, v1_t, cpu_env);
> +                gen_store_gpr(v1_t, rt);
> +                break;
> +            }
> +        }
> +        break;

Missing default case, indentation not needed.

>  static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ct=
x)
>  {
>      uint16_t insn;
> @@ -17587,6 +18160,12 @@ static int decode_nanomips_32_48_opc(CPUMIPSStat=
e *env, > DisasContext *ctx)
>          case NM_POOL32A0:
>              gen_pool32a0_nanomips_insn(env, ctx);
>              break;
> +        case NM_POOL32A5:
> +            {
> +                int32_t op1 =3D (ctx->opcode >> 3) & 0x7F;

extract32().

Aleksandar M.
