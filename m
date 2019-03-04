Received: from eggs.gnu.org ([209.51.188.92]:48272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1h0sJP-0008Le-U6
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:27:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1h0sJO-0000l5-TN
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:27:39 -0500
Received: from mail-eopbgr820101.outbound.protection.outlook.com
	([40.107.82.101]:36632
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1h0sJO-0000e2-IG
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:27:38 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 4 Mar 2019 18:27:33 +0000
Message-ID: <BN6PR2201MB1251A6A94C986D2E391EF774C6710@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1551712405-2530-1-git-send-email-mateja.marjanovic@rt-rk.com>,
	<1551712405-2530-7-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1551712405-2530-7-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 06/13] target/mips: Add emulation of MMI
 instruction PEXEH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>

> From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> Subject: [PATCH v3 06/13] target/mips: Add emulation of MMI instruction P=
EXEH
>=20
> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>=20
> Add emulation of MMI instruction PEXEH. The emulation is implemented
> using TCG front end operations directly to achieve better performance.
>=20
> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> ---
>  target/mips/translate.c | 75 +++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 74 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 64eb10c..01efcde 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -24650,6 +24650,77 @@ static void gen_mmi_pexcw(DisasContext *ctx)
>      }
>  }
>=20
> +/*
> + *  PEXEH rd, rt
> + *
> + *  Parallel Exchange Even Halfword

Indentation...

> + *
> + *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
> + *  +-----------+---------+---------+---------+---------+-----------+
> + *  |    MMI    |0 0 0 0 0|   rt    |   rd    |  PEXEH  |    MMI2   |
> + *  +-----------+---------+---------+---------+---------+-----------+
> + */
> +
> +static void gen_mmi_pexeh(DisasContext *ctx)
> +{
> +    uint32_t pd, rt, rd;
> +    uint32_t opcode;
> +
> +    opcode =3D ctx->opcode;
> +
> +    pd =3D extract32(opcode, 21, 5);
> +    rt =3D extract32(opcode, 16, 5);
> +    rd =3D extract32(opcode, 11, 5);
> +
> +    if (unlikely(pd !=3D 0)) {
> +        generate_exception_end(ctx, EXCP_RI);
> +    } else if (rd =3D=3D 0) {
> +        /* nop */
> +    } else if (rt =3D=3D 0) {
> +        tcg_gen_movi_i64(cpu_gpr[rd], 0);
> +        tcg_gen_movi_i64(cpu_mmr[rd], 0);
> +    } else {
> +        TCGv_i64 t0 =3D tcg_temp_new();
> +        TCGv_i64 t1 =3D tcg_temp_new();
> +        uint64_t mask0 =3D (1ULL << 16) - 1;
> +        uint64_t mask1 =3D mask0 << 16;
> +        uint64_t mask2 =3D mask1 << 16;
> +        uint64_t mask3 =3D mask2 << 16;

What about:

       uint64_t mask2 =3D mask0 << 32;
       uint64_t mask3 =3D mask0 << 48;

> +
> +        tcg_gen_movi_i64(t1, 0);
> +

The last blank line should be deleted IMO.

> +        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask0);
> +        tcg_gen_shli_i64(t0, t0, 32);
> +        tcg_gen_or_i64(t1, t0, t1);
> +        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask1);
> +        tcg_gen_or_i64(t1, t0, t1);
> +        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask2);
> +        tcg_gen_shri_i64(t0, t0, 32);
> +        tcg_gen_or_i64(t1, t0, t1);
> +        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask3);
> +        tcg_gen_or_i64(t1, t0, t1);
> +
> +        tcg_gen_mov_i64(cpu_gpr[rd], t1);
> +        tcg_gen_movi_i64(t1, 0);
> +
> +        tcg_gen_andi_i64(t0, cpu_mmr[rt], mask0);

Better (more logical nad consistent with other patches) spacing is like
this:

        tcg_gen_mov_i64(cpu_gpr[rd], t1);

        tcg_gen_movi_i64(t1, 0);
        tcg_gen_andi_i64(t0, cpu_mmr[rt], mask0);

> +        tcg_gen_shli_i64(t0, t0, 32);
> +        tcg_gen_or_i64(t1, t0, t1);
> +        tcg_gen_andi_i64(t0, cpu_mmr[rt], mask1);
> +        tcg_gen_or_i64(t1, t0, t1);
> +        tcg_gen_andi_i64(t0, cpu_mmr[rt], mask2);
> +        tcg_gen_shri_i64(t0, t0, 32);
> +        tcg_gen_or_i64(t1, t0, t1);
> +        tcg_gen_andi_i64(t0, cpu_mmr[rt], mask3);
> +        tcg_gen_or_i64(t1, t0, t1);
> +
> +        tcg_gen_mov_i64(cpu_mmr[rd], t1);
> +
> +        tcg_temp_free(t0);
> +        tcg_temp_free(t1);
> +    }

I think that if rt =3D=3D rd this whole block can be rewritten in a more op=
timal
and clearer way:

        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask0);
        tcg_gen_shli_i64(t0, t0, 32);
        tcg_gen_andi_i64(t1, cpu_gpr[rt], mask2);
        tcg_gen_shri_i64(t1, t1, 32);

        tcg_gen_andi_i64(cpu_gpr[rd], mask3 || mask1);
        tcg_gen_or_i64(cpu_gpr[rd], t0);
        tcg_gen_or_i64(cpu_gpr[rd], t1);

and the same for "mmr" half.

Aleksandar

> +}
> +
>  #endif
>=20
>=20
> @@ -27670,7 +27741,6 @@ static void decode_mmi2(CPUMIPSState *env, DisasC=
ontext *ctx)
>      case MMI_OPC_2_PXOR:      /* TODO: MMI_OPC_2_PXOR */
>      case MMI_OPC_2_PMSUBH:    /* TODO: MMI_OPC_2_PMSUBH */
>      case MMI_OPC_2_PHMSBH:    /* TODO: MMI_OPC_2_PHMSBH */
> -    case MMI_OPC_2_PEXEH:     /* TODO: MMI_OPC_2_PEXEH */
>      case MMI_OPC_2_PREVH:     /* TODO: MMI_OPC_2_PREVH */
>      case MMI_OPC_2_PMULTH:    /* TODO: MMI_OPC_2_PMULTH */
>      case MMI_OPC_2_PDIVBW:    /* TODO: MMI_OPC_2_PDIVBW */
> @@ -27681,6 +27751,9 @@ static void decode_mmi2(CPUMIPSState *env, DisasC=
ontext *ctx)
>      case MMI_OPC_2_PCPYLD:
>          gen_mmi_pcpyld(ctx);
>          break;
> +    case MMI_OPC_2_PEXEH:
> +        gen_mmi_pexeh(ctx);
> +        break;
>      default:
>          MIPS_INVAL("TX79 MMI class MMI2");
>          generate_exception_end(ctx, EXCP_RI);
> --
> 2.7.4
>=20
> =
