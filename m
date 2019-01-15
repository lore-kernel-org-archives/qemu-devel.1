Received: from eggs.gnu.org ([209.51.188.92]:33928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gjWZy-0001jK-Qe
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:49:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gjWPI-0001Zg-Uv
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:38:02 -0500
Received: from mail-eopbgr710122.outbound.protection.outlook.com
	([40.107.71.122]:28354
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gjWPG-0001Wc-TH
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:38:00 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 15 Jan 2019 21:37:52 +0000
Message-ID: <BN6PR2201MB12519CA9BC089508F14AA138C6810@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <cover.1547403692.git.noring@nocrew.org>,
	<68f0239c8a101f2dd3d86f110f79496db89fb440.1547403692.git.noring@nocrew.org>
In-Reply-To: <68f0239c8a101f2dd3d86f110f79496db89fb440.1547403692.git.noring@nocrew.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 6/9] target/mips: Support the R5900 SQ
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
> Sent: Sunday, January 13, 2019 8:06 PM
> To: Aleksandar Markovic; Aurelien Jarno; Philippe Mathieu-Daud=E9
> Cc: J=FCrgen Urban; Maciej W. Rozycki; qemu-devel@nongnu.org
> Subject: [PATCH 6/9] target/mips: Support the R5900 SQ multimedia instruc=
tion
>=20
> Signed-off-by: Fredrik Noring <noring@nocrew.org>
> ---
>  target/mips/translate.c | 44 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 42 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 79505bb6c2..1c7c649d36 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -2628,6 +2628,17 @@ static inline void gen_store_gpr (TCGv t, int reg)
>=20
>  #if defined(TARGET_MIPS64)
>  /* 128-bit multimedia register moves. */
> +static inline void gen_load_mmr(TCGv_i64 hi, TCGv_i64 lo, int reg)
> +{
> +    if (reg =3D=3D 0) {
> +        tcg_gen_movi_i64(hi, 0);
> +        tcg_gen_movi_i64(lo, 0);
> +    } else {
> +        tcg_gen_mov_i64(hi, cpu_mmr[reg]);
> +        tcg_gen_mov_i64(lo, cpu_gpr[reg]);
> +    }
> +}
> +
>  static inline void gen_store_mmr(TCGv_i64 hi, TCGv_i64 lo, int reg)
>  {
>      if (reg !=3D 0) {
> @@ -27512,7 +27523,36 @@ static void gen_mmi_lq(CPUMIPSState *env, DisasC=
ontext *ctx)
>=20
>  static void gen_mmi_sq(DisasContext *ctx, int base, int rt, int offset)
>  {
> -    generate_exception_end(ctx, EXCP_RI);    /* TODO: MMI_OPC_SQ */
> +#if !defined(TARGET_MIPS64)
> +    generate_exception_end(ctx, EXCP_RI);
> +#else

The same objection as in the previous patch.

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
> +#if defined(TARGET_WORDS_BIGENDIAN)
> +    gen_load_mmr(val0, val1, rt);
> +#else
> +    gen_load_mmr(val1, val0, rt);
> +#endif
> +
> +    tcg_gen_qemu_st_i64(val0, addr, ctx->mem_idx, MO_UNALN | MO_64);
> +    tcg_gen_addi_i64(addr, addr, 8);
> +    tcg_gen_qemu_st_i64(val1, addr, ctx->mem_idx, MO_UNALN | MO_64);
> +
> +    tcg_temp_free_i64(val1);
> +    tcg_temp_free_i64(val0);
> +    tcg_temp_free_i64(addr);
> +#endif /* defined(TARGET_MIPS64) */
>  }
>=20
>  /*
> @@ -27540,7 +27580,7 @@ static void decode_mmi_sq(CPUMIPSState *env, Disa=
sContext *ctx)
>  {
>      int base =3D extract32(ctx->opcode, 21, 5);
>      int rt =3D extract32(ctx->opcode, 16, 5);
> -    int offset =3D extract32(ctx->opcode, 0, 16);
> +    int offset =3D sextract32(ctx->opcode, 0, 16);
>=20
>  #ifdef CONFIG_USER_ONLY
>      uint32_t op1 =3D MASK_SPECIAL3(ctx->opcode);
> --
> 2.19.2
