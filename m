Received: from eggs.gnu.org ([2001:4830:134:3::10]:47812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fuehi-0003dB-8y
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 10:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fuehe-0007bJ-8S
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 10:10:46 -0400
Received: from mail-eopbgr700096.outbound.protection.outlook.com
	([40.107.70.96]:27777
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fuehd-0007YU-Vd
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 10:10:42 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 28 Aug 2018 14:10:37 +0000
Message-ID: <BN7PR08MB4868067D52019A7732AF61B1C60A0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <20180828130041.26445-1-jancraig@amazon.com>,
	<20180828130041.26445-7-jancraig@amazon.com>
In-Reply-To: <20180828130041.26445-7-jancraig@amazon.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 6/8] target/mips: Add MXU instruction
 D16MAC
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

> From: Craig Janeczek <jancraig@amazon.com>
> Sent: Tuesday, August 28, 2018 3:00 PM
> To: qemu-devel@nongnu.org
> Cc: Aleksandar Markovic; aurelien@aurel32.net; Craig Janeczek
> Subject: [PATCH v3 6/8] target/mips: Add MXU instruction D16MAC
>=20
> Adds support for emulating the D16MAC instruction.
>=20
> Signed-off-by: Craig Janeczek <jancraig@amazon.com>
> ---
>  v1
>     - initial patch
>  v2
>     - changed bitfield usage to extract32
>     - used sextract_tl instructions instead of shift and ext
>  v3
>     - Split gen_mxu function into command specific gen_mxu_<ins> function=
s
>=20
>  target/mips/translate.c | 78 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
>=20
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index f693e45203..7c17867d30 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -3967,6 +3967,80 @@ static void gen_mxu_d16mul(DisasContext *ctx, uint=
32_t opc)
>      tcg_temp_free(t3);
>  }
>=20
> +/* D16MAC XRa, XRb, XRc, XRd, APTN2, OPTN2
> + * Signed 16 bit pattern multiply and accumulate */

In QEMU, for all new code, the multiline comment should be in this format:

/*
 * This is a
 * multiline comment.
 */

Sometimes it is allowed to wtite this:

/*
 * Single line comment in multiline format.
 */

"Classic" comment format is reserved just for such single-line cases:

/* This is a classic way to wtite a comment. */

> +static void gen_mxu_d16mac(DisasContext *ctx, uint32_t opc)
> +{
> +    TCGv t0, t1, t2, t3;
> +    uint32_t xra, xrb, xrc, xrd, optn2, aptn2;
> +
> +    t0 =3D tcg_temp_new();
> +    t1 =3D tcg_temp_new();
> +    t2 =3D tcg_temp_new();
> +    t3 =3D tcg_temp_new();
> +
> +    xra =3D extract32(ctx->opcode, 6, 4);
> +    xrb =3D extract32(ctx->opcode, 10, 4);
> +    xrc =3D extract32(ctx->opcode, 14, 4);
> +    xrd =3D extract32(ctx->opcode, 18, 4);
> +    optn2 =3D extract32(ctx->opcode, 22, 2);
> +    aptn2 =3D extract32(ctx->opcode, 24, 2);
> +
> +    gen_load_mxu_gpr(t1, xrb);
> +    tcg_gen_sextract_tl(t0, t1, 0, 16);
> +    tcg_gen_sextract_tl(t1, t1, 16, 16);
> +    gen_load_mxu_gpr(t3, xrc);
> +    tcg_gen_sextract_tl(t2, t3, 0, 16);
> +    tcg_gen_sextract_tl(t3, t3, 16, 16);
> +
> +    switch (optn2) {
> +    case 0: /* XRB.H*XRC.H =3D=3D lop, XRB.L*XRC.L =3D=3D rop */
> +        tcg_gen_mul_tl(t3, t1, t3);
> +        tcg_gen_mul_tl(t2, t0, t2);
> +        break;
> +    case 1: /* XRB.L*XRC.H =3D=3D lop, XRB.L*XRC.L =3D=3D rop */
> +        tcg_gen_mul_tl(t3, t0, t3);
> +        tcg_gen_mul_tl(t2, t0, t2);
> +        break;
> +    case 2: /* XRB.H*XRC.H =3D=3D lop, XRB.H*XRC.L =3D=3D rop */
> +        tcg_gen_mul_tl(t3, t1, t3);
> +        tcg_gen_mul_tl(t2, t1, t2);
> +        break;
> +    case 3: /* XRB.L*XRC.H =3D=3D lop, XRB.H*XRC.L =3D=3D rop */
> +        tcg_gen_mul_tl(t3, t0, t3);
> +        tcg_gen_mul_tl(t2, t1, t2);
> +        break;
> +    }

Somewhere above all gem_mxu_XXX() functions, the following code segment sho=
uld be inserted:

/* MXU operand getting patterns */
#define MXU_OPTN2_WW    0
#define MXU_OPTN2_LW    1
#define MXU_OPTN2_HW    2
#define MXU_OPTN2_XW    3

... and these constants should be used in the switch statement just above.

> +    gen_load_mxu_gpr(t0, xra);
> +    gen_load_mxu_gpr(t1, xrd);
> +
> +    switch (aptn2) {
> +    case 0:
> +        tcg_gen_add_tl(t3, t0, t3);
> +        tcg_gen_add_tl(t2, t1, t2);
> +        break;
> +    case 1:
> +        tcg_gen_add_tl(t3, t0, t3);
> +        tcg_gen_sub_tl(t2, t1, t2);
> +        break;
> +    case 2:
> +        tcg_gen_sub_tl(t3, t0, t3);
> +        tcg_gen_add_tl(t2, t1, t2);
> +        break;
> +    case 3:
> +        tcg_gen_sub_tl(t3, t0, t3);
> +        tcg_gen_sub_tl(t2, t1, t2);
> +        break;
> +    }

Somewhere above all gem_mxu_XXX() functions, the following code segment sho=
uld be inserted:

/* MXU acumulate patterns */
#define MXU_APTN2_AA    0
#define MXU_APTN2_AS    1
#define MXU_APTN2_SA    2
#define MXU_APTN2_SS    3

... and these constants should be used in the switch statement just above.

> +    gen_store_mxu_gpr(t3, xra);
> +    gen_store_mxu_gpr(t2, xrd);
> +
> +    tcg_temp_free(t0);
> +    tcg_temp_free(t1);
> +    tcg_temp_free(t2);
> +    tcg_temp_free(t3);
> +}
> +
>  /* Godson integer instructions */
>  static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
>                                   int rd, int rs, int rt)
> @@ -18080,6 +18154,10 @@ static void decode_opc_special2_legacy(CPUMIPSSt=
ate *env, DisasContext *ctx)
>          gen_mxu_d16mul(ctx, op1);
>          break;
>=20
> +    case OPC_MXU_D16MAC:
> +        gen_mxu_d16mac(ctx, op1);
> +        break;
> +
>      case OPC_CLO:
>      case OPC_CLZ:
>          check_insn(ctx, ISA_MIPS32);
