Received: from eggs.gnu.org ([2001:4830:134:3::10]:50004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fuM1S-00054j-4B
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 14:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fuM1N-0004ip-63
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 14:13:54 -0400
Received: from mail-eopbgr690136.outbound.protection.outlook.com
	([40.107.69.136]:28376
	helo=NAM04-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fuM1M-0004hd-FQ
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 14:13:49 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 27 Aug 2018 18:13:42 +0000
Message-ID: <BN7PR08MB486825769579409337776B4FC60B0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <20180827143806.25048-1-jancraig@amazon.com>,
	<20180827143806.25048-2-jancraig@amazon.com>
In-Reply-To: <20180827143806.25048-2-jancraig@amazon.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 1/6] target/mips: Add MXU instructions
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
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Richard Henderson <richard.henderson@linaro.org>

> From: Craig Janeczek <jancraig@amazon.com>
> Sent: Monday, August 27, 2018 4:38 PM
> Subject: [PATCH v2 1/6] target/mips: Add MXU instructions S32I2M and S32M=
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
>=20
>  target/mips/cpu.h       |  1 +
>  target/mips/translate.c | 71 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+)
>=20

Hi, Craig,

So far it is going well. You respond well to the reviews. I encourage you t=
o persevere, this is a nice addition to QEMU's MIPS functionality, we want =
it.

Just something about overall patch organization:

This (1/7) patch should be split/refactored in this way:

PATCH 1: Introduce MXU registers (16 fields and their names, plus initializ=
ation)

PATCH 2: Add MXU opcodes (if possible, add ALL MXU opcodes, there are 50 to=
 60 ones, if I am not mistaken)

PATCH 3: The rest of this patch (so, S32I2M and S32M2I emulation)

... and further patches as you already organized.

However, there is more. We plan to significantly revamp translate.c in near=
 future, and this series, even though it is consistent with the rest of cod=
e in the same file, would not fit in its present state well into the new or=
ganization of translate.c. I am asking you, therefore, to reorganize code i=
n the following fashion:

- implementation of emulation of each instruction should be in a separate f=
unction (baring some exceptions); for this patch functions gen_mxu_s32i2m()=
 and gen_mxu_s32m2i() should be created; the only arguments of these functi=
on should be "DisasContext *ctx" and "uint32_t opc";

- each such function should be preceded by a comment similar to this:

/*
 * S32M2I XRa, rb - Register move from XRF to GRF
 */

- gen_mxu() would disappear;

- decode_opc_special2_legacy() should call various gen_mxu_XXX() directly, =
in separate "case" sections for each instruction.

Please rearrange the code this way.

Thanks,
Aleksandar

> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 009202cf64..4b2948a2c8 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -170,6 +170,7 @@ struct TCState {
>          MSACSR_FS_MASK)
>=20
>      float_status msa_fp_status;
> +    target_ulong mxu_gpr[16];
>  };
>=20
>  typedef struct CPUMIPSState CPUMIPSState;
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index bdd880bb77..ef819d67e0 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -364,6 +364,9 @@ enum {
>      OPC_CLO      =3D 0x21 | OPC_SPECIAL2,
>      OPC_DCLZ     =3D 0x24 | OPC_SPECIAL2,
>      OPC_DCLO     =3D 0x25 | OPC_SPECIAL2,
> +    /* MXU */
> +    OPC_MXU_S32I2M =3D 0x2F | OPC_SPECIAL2,
> +    OPC_MXU_S32M2I =3D 0x2E | OPC_SPECIAL2,
>      /* Special */
>      OPC_SDBBP    =3D 0x3F | OPC_SPECIAL2,
>  };
> @@ -1398,6 +1401,9 @@ static TCGv_i32 fpu_fcr0, fpu_fcr31;
>  static TCGv_i64 fpu_f64[32];
>  static TCGv_i64 msa_wr_d[64];
>=20
> +/* MXU registers */
> +static TCGv mxu_gpr[16];
> +
>  #include "exec/gen-icount.h"
>=20
>  #define gen_helper_0e0i(name, arg) do {                           \
> @@ -1517,6 +1523,13 @@ static const char * const msaregnames[] =3D {
>      "w30.d0", "w30.d1", "w31.d0", "w31.d1",
>  };
>=20
> +static const char * const mxuregnames[] =3D {
> +    "XR1",  "XR2",  "XR3",  "XR4",  "XR5",
> +    "XR6",  "XR7",  "XR8",  "XR9",  "XR10",
> +    "XR11", "XR12", "XR13", "XR14", "XR15",
> +    "XR16",
> +};
> +
>  #define LOG_DISAS(...)                                                  =
      \
>      do {                                                                =
      \
>          if (MIPS_DEBUG_DISAS) {                                         =
      \
> @@ -1550,6 +1563,23 @@ static inline void gen_store_gpr (TCGv t, int reg)
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
> +
> +static inline void gen_store_mxu_gpr(TCGv t, int reg)
> +{
> +    if (reg !=3D 0) {
> +        tcg_gen_mov_tl(mxu_gpr[reg - 1], t);
> +    }
> +}
> +
>  /* Moves to/from shadow registers. */
>  static inline void gen_load_srsgpr (int from, int to)
>  {
> @@ -3738,6 +3768,35 @@ static void gen_cl (DisasContext *ctx, uint32_t op=
c,
>      }
>  }
>=20
> +/* MXU Instructions */
> +static void gen_mxu(DisasContext *ctx, uint32_t opc)
> +{
> +    TCGv t0;
> +    uint32_t xra, rb;
> +
> +    t0 =3D tcg_temp_new();
> +
> +    switch (opc) {
> +    case OPC_MXU_S32I2M:
> +        xra =3D extract32(ctx->opcode, 6, 5);
> +        rb =3D extract32(ctx->opcode, 16, 5);
> +
> +        gen_load_gpr(t0, rb);
> +        gen_store_mxu_gpr(t0, xra);
> +        break;
> +
> +    case OPC_MXU_S32M2I:
> +        xra =3D extract32(ctx->opcode, 6, 5);
> +        rb =3D extract32(ctx->opcode, 16, 5);
> +
> +        gen_load_mxu_gpr(t0, xra);
> +        gen_store_gpr(t0, rb);
> +        break;
> +    }
> +
> +    tcg_temp_free(t0);
> +}
> +
>  /* Godson integer instructions */
>  static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
>                                   int rd, int rs, int rt)
> @@ -17818,6 +17877,12 @@ static void decode_opc_special2_legacy(CPUMIPSSt=
ate *env, DisasContext *ctx)
>          check_insn(ctx, INSN_LOONGSON2F);
>          gen_loongson_integer(ctx, op1, rd, rs, rt);
>          break;
> +
> +    case OPC_MXU_S32I2M:
> +    case OPC_MXU_S32M2I:
> +        gen_mxu(ctx, op1);
> +        break;
> +
>      case OPC_CLO:
>      case OPC_CLZ:
>          check_insn(ctx, ISA_MIPS32);
> @@ -20742,6 +20807,12 @@ void mips_tcg_init(void)
>      fpu_fcr31 =3D tcg_global_mem_new_i32(cpu_env,
>                                         offsetof(CPUMIPSState, active_fpu=
.fcr31),
>                                         "fcr31");
> +
> +    for (i =3D 0; i < 16; i++)
> +        mxu_gpr[i] =3D tcg_global_mem_new(cpu_env,
> +                                        offsetof(CPUMIPSState,
> +                                                 active_tc.mxu_gpr[i]),
> +                                        mxuregnames[i]);
>  }
>=20
>  #include "translate_init.inc.c"
> --
> 2.18.0
>=20
> =
