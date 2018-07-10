Received: from eggs.gnu.org ([2001:4830:134:3::10]:35958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcs8e-0001BD-JH
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 08:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcs8b-00085D-U8
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 08:53:04 -0400
Received: from mail-bn3nam01on0118.outbound.protection.outlook.com
	([104.47.33.118]:49808
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fcs8b-00084e-OG
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 08:53:01 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 10 Jul 2018 12:52:58 +0000
Message-ID: <BN7PR08MB4868AE8C20B2E33D3F177278C65B0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1531169431-10772-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1531169431-10772-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1531169431-10772-6-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 05/33] target/mips: Add emulation of
 nanoMIPS 16-bit save and restore instructions
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

> Subject: [PATCH v2 05/33] target/mips: Add emulation of nanoMIPS 16-bit s=
ave and restore > instructions
>
> From: Matthew Fortune <matthew.fortune@mips.com>
>
> Add emulation of SAVE16 and RESTORE.JRC16 instructions. Routines
> gen_save(), gen_restore(), and gen_adjust_sp() are provided for this
> purpose.
>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 73 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 73 insertions(+)
>
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 9b87fed..379b6ba 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -16367,6 +16367,65 @@ static int decode_gpr_gpr4_zero(int r)
>      return map[r & 0xf];
>  }
>
> +static void gen_adjust_sp(DisasContext *ctx, int u)
> +{
> +    TCGv tsp =3D tcg_temp_new();
> +    gen_base_offset_addr(ctx, tsp, 29, u);
> +    gen_store_gpr(tsp, 29);

What is the meaning and origin of these two instances of the constant 29?
Shouldn't it be defined as a preprocessor constant?
Is this unique for nanoMIPS?

> +    tcg_temp_free(tsp);
> +}
> +
> +static void gen_save(DisasContext *ctx, uint8_t rt, uint8_t count,
> +                     uint8_t gp, uint16_t u)
> +{
> +    int counter =3D 0;
> +    TCGv va =3D tcg_temp_new();
> +    TCGv t0 =3D tcg_temp_new();
> +
> +    while (counter !=3D count) {
> +        bool use_gp =3D gp && (counter =3D=3D count - 1);
> +        int this_rt =3D use_gp ? 28 : (rt & 0x10) | ((rt + counter) & 0x=
1f);
> +        int this_offset =3D -((counter + 1) << 2);
> +        gen_base_offset_addr(ctx, va, 29, this_offset);
> +        gen_load_gpr(t0, this_rt);
> +        tcg_gen_qemu_st_tl(t0, va, ctx->mem_idx,
> +                           (MO_TEUL | ctx->default_tcg_memop_mask));
> +        counter++;
> +    }
> +
> +    /* adjust stack pointer */
> +    gen_adjust_sp(ctx, -u);
> +
> +    tcg_temp_free(t0);
> +    tcg_temp_free(va);
> +}
> +
> +static void gen_restore(DisasContext *ctx, uint8_t rt, uint8_t count,
> +                        uint8_t gp, uint16_t u)
> +{
> +    int counter =3D 0;
> +    TCGv va =3D tcg_temp_new();
> +    TCGv t0 =3D tcg_temp_new();
> +
> +    while (counter !=3D count) {
> +        bool use_gp =3D gp && (counter =3D=3D count - 1);
> +        int this_rt =3D use_gp ? 28 : (rt & 0x10) | ((rt + counter) & 0x=
1f);

Now we have even 28...

> +        int this_offset =3D u - ((counter + 1) << 2);
> +        gen_base_offset_addr(ctx, va, 29, this_offset);

29 again... too unclear...

> +        tcg_gen_qemu_ld_tl(t0, va, ctx->mem_idx, MO_TESL |
> +                        ctx->default_tcg_memop_mask);
> +        tcg_gen_ext32s_tl(t0, t0);
> +        gen_store_gpr(t0, this_rt);
> +        counter++;
> +    }
> +
> +    /* adjust stack pointer */
> +    gen_adjust_sp(ctx, u);
> +
> +    tcg_temp_free(t0);
> +    tcg_temp_free(va);
> +}
> +
>  static void gen_pool16c_nanomips_insn(DisasContext *ctx)
>  {
>      int rt =3D decode_gpr_gpr3(NANOMIPS_EXTRACT_RD(ctx->opcode));
> @@ -16715,6 +16774,20 @@ static int decode_nanomips_opc(CPUMIPSState *env=
, DisasContext > *ctx)
>          }
>          break;
>      case NM_P16_SR:
> +    {
> +        int count =3D extract32(ctx->opcode, 0, 4);
> +        int u =3D extract32(ctx->opcode, 4, 4) << 4;
> +        int rt =3D 30 + ((ctx->opcode >> 9) & 1);

What is the meaning and origin of constant 30?
Shouldn't it be defined as a preprocessor constant?
Is this unique for nanoMIPS?

> +        switch ((ctx->opcode >> 8) & 1) {
> +        case NM_SAVE16:
> +            gen_save(ctx, rt, count, 0, u);
> +            break;
> +        case NM_RESTORE_JRC16:
> +            gen_restore(ctx, rt, count, 0, u);
> +            gen_compute_branch(ctx, OPC_JR, 2, 31, 0, 0, 0);
> +            break;
> +        }
> +    }
>          break;
>      case NM_MOVEP:
>      case NM_MOVEPREV:
> --
> 2.7.4
