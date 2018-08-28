Received: from eggs.gnu.org ([2001:4830:134:3::10]:51610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fueu2-00026w-PX
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 10:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fuetz-0004uv-GC
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 10:23:30 -0400
Received: from mail-co1nam05on072b.outbound.protection.outlook.com
	([2a01:111:f400:fe50::72b]:55912
	helo=NAM05-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fuety-0004r5-VE
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 10:23:27 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 28 Aug 2018 14:23:04 +0000
Message-ID: <BN7PR08MB4868B0E06C13DE35AA4327DBC60A0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <20180828130041.26445-1-jancraig@amazon.com>,
	<20180828130041.26445-5-jancraig@amazon.com>
In-Reply-To: <20180828130041.26445-5-jancraig@amazon.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 4/8] target/mips: Add MXU instruction
 S8LDD
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
> Subject: [PATCH v3 4/8] target/mips: Add MXU instruction S8LDD
>=20
> Adds support for emulating the S8LDD MXU instruction.
>=20
> Signed-off-by: Craig Janeczek <jancraig@amazon.com>
> ---
>  v1
>     - initial patch
>  v2
>     - changed bitfield usage to extract32
>     - used deposit_tl instructions instead of shift and bitmask
>  v3
>     - Split gen_mxu function into command specific gen_mxu_<ins> function=
s
>=20
>  target/mips/translate.c | 69 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>=20
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index f6991aa8ef..024e48baf6 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -3851,6 +3851,71 @@ static void gen_mxu_s32m2i(DisasContext *ctx, uint=
32_t opc)
>      tcg_temp_free(t0);
>  }
>=20
> +/* S8LDD XRa, rb, S8, OPTN3 - Load a byte from memory to XRF */
> +static void gen_mxu_s8ldd(DisasContext *ctx, uint32_t opc)
> +{
> +    TCGv t0, t1;
> +    uint32_t xra, s8, optn3, rb;
> +
> +    t0 =3D tcg_temp_new();
> +    t1 =3D tcg_temp_new();
> +
> +    xra =3D extract32(ctx->opcode, 6, 4);
> +    s8 =3D extract32(ctx->opcode, 10, 8);
> +    optn3 =3D extract32(ctx->opcode, 18, 3);
> +    rb =3D extract32(ctx->opcode, 21, 5);
> +
> +    gen_load_gpr(t0, rb);
> +    tcg_gen_addi_tl(t0, t0, (int8_t)s8);
> +    switch (optn3) {
> +    case 0: /*XRa[7:0] =3D tmp8 */
> +        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
> +        gen_load_mxu_gpr(t0, xra);
> +        tcg_gen_deposit_tl(t0, t0, t1, 0, 8);
> +        break;
> +    case 1: /* XRa[15:8] =3D tmp8 */
> +        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
> +        gen_load_mxu_gpr(t0, xra);
> +        tcg_gen_deposit_tl(t0, t0, t1, 8, 8);
> +        break;
> +    case 2: /* XRa[23:16] =3D tmp8 */
> +        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
> +        gen_load_mxu_gpr(t0, xra);
> +        tcg_gen_deposit_tl(t0, t0, t1, 16, 8);
> +        break;
> +    case 3: /* XRa[31:24] =3D tmp8 */
> +        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
> +        gen_load_mxu_gpr(t0, xra);
> +        tcg_gen_deposit_tl(t0, t0, t1, 24, 8);
> +        break;
> +    case 4: /* XRa =3D {8'b0, tmp8, 8'b0, tmp8} */
> +        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
> +        tcg_gen_deposit_tl(t0, t1, t1, 16, 16);
> +        break;
> +    case 5: /* XRa =3D {tmp8, 8'b0, tmp8, 8'b0} */
> +        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
> +        tcg_gen_shli_tl(t1, t1, 8);
> +        tcg_gen_deposit_tl(t0, t1, t1, 16, 16);
> +        break;
> +    case 6: /* XRa =3D {{8{sign of tmp8}}, tmp8, {8{sign of tmp8}}, tmp8=
} */
> +        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_SB);
> +        tcg_gen_mov_tl(t0, t1);
> +        tcg_gen_andi_tl(t0, t0, 0xFF00FFFF);
> +        tcg_gen_shli_tl(t1, t1, 16);
> +        tcg_gen_or_tl(t0, t0, t1);
> +        break;
> +    case 7: /* XRa =3D {tmp8, tmp8, tmp8, tmp8} */
> +        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
> +        tcg_gen_deposit_tl(t1, t1, t1, 8, 8);
> +        tcg_gen_deposit_tl(t0, t1, t1, 16, 16);
> +        break;
> +    }

Similar to the situation in patch 6, the following is missing:

/* MXU operand getting patterns OPTN3 */
#define MXU_OPTN3_PTN0  0
#define MXU_OPTN3_PTN1  1
#define MXU_OPTN3_PTN2  2
#define MXU_OPTN3_PTN3  3
#define MXU_OPTN3_PTN4  4
#define MXU_OPTN3_PTN5  5
#define MXU_OPTN3_PTN6  6
#define MXU_OPTN3_PTN7  7

> +    gen_store_mxu_gpr(t0, xra);
> +
> +    tcg_temp_free(t0);
> +    tcg_temp_free(t1);
> +}
> +
>  /* Godson integer instructions */
>  static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
>                                   int rd, int rs, int rt)
> @@ -17956,6 +18021,10 @@ static void decode_opc_special2_legacy(CPUMIPSSt=
ate *env, DisasContext *ctx)
>          gen_mxu_s32m2i(ctx, op1);
>          break;
>=20
> +    case OPC_MXU_S8LDD:
> +        gen_mxu_s8ldd(ctx, op1);
> +        break;
> +
>      case OPC_CLO:
>      case OPC_CLZ:
>          check_insn(ctx, ISA_MIPS32);
> --
> 2.18.0
>=20

Thanks,
Aleksandar=
