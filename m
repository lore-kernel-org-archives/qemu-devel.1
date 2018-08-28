Received: from eggs.gnu.org ([2001:4830:134:3::10]:57607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fufDG-0003Tx-2P
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 10:43:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fufDA-0006wW-Ky
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 10:43:21 -0400
Received: from mail-eopbgr730106.outbound.protection.outlook.com
	([40.107.73.106]:24112
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fufDA-0006vE-5u
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 10:43:16 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 28 Aug 2018 14:43:12 +0000
Message-ID: <BN7PR08MB4868C15DDF3A45B9E4719EEAC60A0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <20180828130041.26445-1-jancraig@amazon.com>,
	<20180828130041.26445-4-jancraig@amazon.com>
In-Reply-To: <20180828130041.26445-4-jancraig@amazon.com>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 3/8] target/mips: Add MXU instructions
 S32I2M and S32M2I
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Craig Janeczek <jancraig@amazon.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>

> From: Craig Janeczek <jancraig@amazon.com>
> Sent: Tuesday, August 28, 2018 3:00 PM
> To: qemu-devel@nongnu.org
> Cc: Aleksandar Markovic; aurelien@aurel32.net; Craig Janeczek
> Subject: [PATCH v3 3/8] target/mips: Add MXU instructions S32I2M and S32M=
2I
>=20
> This commit makes the MXU registers and the utility functions for
> reading/writing to them. This is required for full MXU instruction
> support.
>=20
> Adds support for emulating the S32I2M and S32M2I MXU instructions.
>=20
> Signed-off-by: Craig Janeczek <jancraig@amazon.com>
> ---
>  v1
>     - initial patch
>  v2
>     - Fix checkpatch.pl errors
>     - remove mips64 ifdef
>     - changed bitfield usage to extract32
>     - squashed register addition patch into this one
>  v3
>     - Split register addition and opcode enum definition into seperate pa=
tches
>     - Split gen_mxu function into command specific gen_mxu_<ins> function=
s
>=20
>  target/mips/translate.c | 62 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>=20
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index ae6b16ecd7..f6991aa8ef 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -1610,6 +1610,23 @@ static inline void gen_store_gpr (TCGv t, int reg)
>          tcg_gen_mov_tl(cpu_gpr[reg], t);
>  }
>=20
> +/* MXU General purpose registers moves. */
> +static inline void gen_load_mxu_gpr(TCGv t, int reg)
> +{
> +    if (reg =3D=3D 0) {
> +        tcg_gen_movi_tl(t, 0);
> +    } else {
> +        tcg_gen_mov_tl(t, mxu_gpr[reg - 1]);
> +    }
> +}

What happens if reg > 16? Also, the argument reg should be unsigned.

> +
> +static inline void gen_store_mxu_gpr(TCGv t, int reg)
> +{
> +    if (reg !=3D 0) {
> +        tcg_gen_mov_tl(mxu_gpr[reg - 1], t);
> +    }
> +}
> +

What happens if reg > 16? Also, the argument reg should be unsigned.

>  /* Moves to/from shadow registers. */
>  static inline void gen_load_srsgpr (int from, int to)
>  {
> @@ -3798,6 +3815,42 @@ static void gen_cl (DisasContext *ctx, uint32_t op=
c,
>      }
>  }
>=20
> +/* MXU Instructions */
> +
> +/* S32I2M XRa, rb - Register move from GRF to XRF */
> +static void gen_mxu_s32i2m(DisasContext *ctx, uint32_t opc)
> +{
> +    TCGv t0;
> +    uint32_t xra, rb;
> +
> +    t0 =3D tcg_temp_new();
> +
> +    xra =3D extract32(ctx->opcode, 6, 5);
> +    rb =3D extract32(ctx->opcode, 16, 5);
> +
> +    gen_load_gpr(t0, rb);
> +    gen_store_mxu_gpr(t0, xra);
> +
> +    tcg_temp_free(t0);
> +}

This does not handle the case xra =3D=3D XR16. From the doc:

"In MXU, a dedicated register file named XRF comprises sixteen 32-bit gener=
al purpose registers =96 XR0~XR15. XR0 is a special one, which always is re=
ad as zero. Moreover, XR16 is an alias of MXU_CR described below and it can=
 only be accessed by S32I2M/S32M2I instructions."

> +
> +/* S32M2I XRa, rb - Register move from XRF to GRF */
> +static void gen_mxu_s32m2i(DisasContext *ctx, uint32_t opc)
> +{
> +    TCGv t0;
> +    uint32_t xra, rb;
> +
> +    t0 =3D tcg_temp_new();
> +
> +    xra =3D extract32(ctx->opcode, 6, 5);
> +    rb =3D extract32(ctx->opcode, 16, 5);
> +
> +    gen_load_mxu_gpr(t0, xra);
> +    gen_store_gpr(t0, rb);
> +
> +    tcg_temp_free(t0);
> +}
> +
>  /* Godson integer instructions */
>  static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
>                                   int rd, int rs, int rt)
> @@ -17894,6 +17947,15 @@ static void decode_opc_special2_legacy(CPUMIPSSt=
ate *env, DisasContext *ctx)
>          check_insn(ctx, INSN_LOONGSON2F);
>          gen_loongson_integer(ctx, op1, rd, rs, rt);
>          break;
> +
> +    case OPC_MXU_S32I2M:
> +        gen_mxu_s32i2m(ctx, op1);
> +        break;
> +
> +    case OPC_MXU_S32M2I:
> +        gen_mxu_s32m2i(ctx, op1);
> +        break;
> +
>      case OPC_CLO:
>      case OPC_CLZ:
>          check_insn(ctx, ISA_MIPS32);
