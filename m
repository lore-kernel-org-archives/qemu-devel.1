Received: from eggs.gnu.org ([2001:4830:134:3::10]:45023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fvoO6-0005UQ-K5
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 14:44:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fvoLT-00052U-H2
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 14:43:16 -0400
Received: from mail-bn3nam01on0109.outbound.protection.outlook.com
	([104.47.33.109]:36064
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fvoLR-0004vv-PB
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 14:40:35 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 31 Aug 2018 18:40:29 +0000
Message-ID: <BN7PR08MB4868D242CAD42AB129B61EB5C60F0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <20180830193019.20104-1-jancraig@amazon.com>,
	<20180830193019.20104-4-jancraig@amazon.com>
In-Reply-To: <20180830193019.20104-4-jancraig@amazon.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 3/9] target/mips: Split mips instruction
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Craig Janeczek <jancraig@amazon.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Richard Henderson <richard.henderson@linaro.org>

Hi, Craig,

> From: Craig Janeczek <jancraig@amazon.com>
> Sent: Thursday, August 30, 2018 9:30 PM
> To: qemu-devel@nongnu.org
> Cc: Aleksandar Markovic; aurelien@aurel32.net; Craig Janeczek
> Subject: [PATCH v4 3/9] target/mips: Split mips instruction handling
>=20
> Splits the instruction handling switch statement from the original
> legacy code.
>=20
> Signed-off-by: Craig Janeczek <jancraig@amazon.com>
> ---
>  v1
>     - NA
>  v2
>     - NA
>  v3
>     - NA
>  v4
>     - Initial patch
>=20
>  target/mips/mips-defs.h |  1 +
>  target/mips/translate.c | 28 +++++++++++++++++++++++++++-
>  2 files changed, 28 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
> index d239069975..5a409757f0 100644
> --- a/target/mips/mips-defs.h
> +++ b/target/mips/mips-defs.h
> @@ -50,6 +50,7 @@
>  #define   ASE_SMARTMIPS 0x00400000
>  #define   ASE_MICROMIPS 0x00800000
>  #define   ASE_MSA       0x01000000
> +#define   ASE_MXU       0x02000000
>=20
>  /* Chip specific instructions. */
>  #define                INSN_LOONGSON2E  0x20000000
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index a598f45558..53d896ebf9 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -17855,6 +17855,28 @@ static void decode_opc_special(CPUMIPSState *env=
, DisasContext *ctx)
>      }
>  }
>=20
> +static void decode_opc_special2_mxu(CPUMIPSState *env, DisasContext *ctx=
)
> +{
> +    int rs, rt, rd;
> +    uint32_t op1;
> +
> +    rs =3D (ctx->opcode >> 21) & 0x1f;
> +    rt =3D (ctx->opcode >> 16) & 0x1f;
> +    rd =3D (ctx->opcode >> 11) & 0x1f;
> +
> +    op1 =3D MASK_SPECIAL2(ctx->opcode);
> +
> +    switch (op1) {
> +    case OPC_MUL:
> +        gen_arith(ctx, op1, rd, rs, rt);
> +        break;
> +    default:            /* Invalid */
> +        MIPS_INVAL("special2_mxu");
> +        generate_exception_end(ctx, EXCP_RI);
> +        break;
> +    }
> +}
> +

This (case OPC_MUL) just looks very odd to me. Why would OPC_MUL somehow be=
 supposed to be included here? Is there any documentation to support this? =
For example of other kind: OPC_MADD is not included in this switch, but the=
re is an OPC_MADD equivalent in MXU. At the same time, there is an OPC_MUL =
equivalent in MXU too.

This looks to me as a very unclear opcode organization. Too bad the MXU doc=
umentation that you linked to doesn't have opcode specifications. Xburst ba=
se set documentation would be very helpful, but there is no such doc to my =
knowledge.

Sincerely,
Aleksandar

>  static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *=
ctx)
>  {
>      int rs, rt, rd;
> @@ -19836,7 +19858,11 @@ static void decode_opc(CPUMIPSState *env, DisasC=
ontext *ctx)
>          decode_opc_special(env, ctx);
>          break;
>      case OPC_SPECIAL2:
> -        decode_opc_special2_legacy(env, ctx);
> +        if (ctx->insn_flags & ASE_MXU) {
> +            decode_opc_special2_mxu(env, ctx);
> +        } else {
> +            decode_opc_special2_legacy(env, ctx);
> +        }
>          break;
>      case OPC_SPECIAL3:
>          decode_opc_special3(env, ctx);
> --
> 2.18.0
>=20
