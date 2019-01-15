Received: from eggs.gnu.org ([209.51.188.92]:60753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gjWa3-0001De-0B
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:49:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gjWM5-0007AR-NR
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:34:44 -0500
Received: from mail-eopbgr820134.outbound.protection.outlook.com
	([40.107.82.134]:45376
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gjWM4-00071I-P1
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:34:41 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 15 Jan 2019 21:34:16 +0000
Message-ID: <BN6PR2201MB1251C737A13CAE89065E92C1C6810@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <cover.1547403692.git.noring@nocrew.org>,
	<bdfb203a65eb6d4bcdce613e7ac00d831e38de60.1547403692.git.noring@nocrew.org>
In-Reply-To: <bdfb203a65eb6d4bcdce613e7ac00d831e38de60.1547403692.git.noring@nocrew.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 5/9] target/mips: Support the R5900 LQ
 multimedia instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: =?iso-8859-1?Q?J=FCrgen_Urban?= <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


> From: Fredrik Noring <noring@nocrew.org>
> Sent: Sunday, January 13, 2019 8:05 PM
> To: Aleksandar Markovic; Aurelien Jarno; Philippe Mathieu-Daud=E9
> Cc: J=FCrgen Urban; Maciej W. Rozycki; qemu-devel@nongnu.org
> Subject: [PATCH 5/9] target/mips: Support the R5900 LQ multimedia instruc=
tion
>=20
> Signed-off-by: Fredrik Noring <noring@nocrew.org>

Please provide a commit message, even if it is the same as the patch title.

> ---
>  target/mips/translate.c | 46 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 8c350729bc..79505bb6c2 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -2626,6 +2626,17 @@ static inline void gen_store_gpr (TCGv t, int reg)
>          tcg_gen_mov_tl(cpu_gpr[reg], t);
>  }
>=20
> +#if defined(TARGET_MIPS64)
> +/* 128-bit multimedia register moves. */
> +static inline void gen_store_mmr(TCGv_i64 hi, TCGv_i64 lo, int reg)
> +{
> +    if (reg !=3D 0) {
> +        tcg_gen_mov_i64(cpu_mmr[reg], hi);
> +        tcg_gen_mov_i64(cpu_gpr[reg], lo);
> +    }
> +}
> +#endif /* defined(TARGET_MIPS64) */
> +
>  /* Moves to/from shadow registers. */
>  static inline void gen_load_srsgpr (int from, int to)
>  {
> @@ -27463,7 +27474,40 @@ static void decode_mmi(CPUMIPSState *env, DisasC=
ontext *ctx)
>=20
>  static void gen_mmi_lq(CPUMIPSState *env, DisasContext *ctx)
>  {
> -    generate_exception_end(ctx, EXCP_RI);    /* TODO: MMI_OPC_LQ */
> +#if !defined(TARGET_MIPS64)
> +    generate_exception_end(ctx, EXCP_RI);
> +#else

TARGET_MIPS64 should always be defined for R5900, IMHO.

> +    int base =3D extract32(ctx->opcode, 21, 5);
> +    int rt =3D extract32(ctx->opcode, 16, 5);
> +    int offset =3D sextract32(ctx->opcode, 0, 16);
> +
> +    TCGv_i64 addr =3D tcg_temp_new_i64();
> +    TCGv_i64 val0 =3D tcg_temp_new_i64();
> +    TCGv_i64 val1 =3D tcg_temp_new_i64();
> +
> +    gen_base_offset_addr(ctx, addr, base, offset);
> +
> +    /*
> +     * The least significant four bits of the effective address are
> +     * masked to zero, effectively creating an aligned address. No
> +     * address exceptions due to alignment are possible.
> +     */
> +    tcg_gen_andi_i64(addr, addr, ~0xFULL);
> +
> +    tcg_gen_qemu_ld_i64(val0, addr, ctx->mem_idx, MO_UNALN | MO_64);
> +    tcg_gen_addi_i64(addr, addr, 8);
> +    tcg_gen_qemu_ld_i64(val1, addr, ctx->mem_idx, MO_UNALN | MO_64);
> +
> +#if defined(TARGET_WORDS_BIGENDIAN)
> +    gen_store_mmr(val0, val1, rt);
> +#else
> +    gen_store_mmr(val1, val0, rt);
> +#endif
> +
> +    tcg_temp_free_i64(val1);
> +    tcg_temp_free_i64(val0);
> +    tcg_temp_free_i64(addr);
> +#endif /* defined(TARGET_MIPS64) */
>  }
>=20
>  static void gen_mmi_sq(DisasContext *ctx, int base, int rt, int offset)
> --
> 2.19.2
