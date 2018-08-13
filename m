Received: from eggs.gnu.org ([2001:4830:134:3::10]:39505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fpHVe-0002FI-Db
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 14:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fpHVb-0002w1-8G
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 14:24:06 -0400
Received: from mail-bn3nam01on0091.outbound.protection.outlook.com
	([104.47.33.91]:38932
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fpHVb-0002vu-2a
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 14:24:03 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 13 Aug 2018 18:23:59 +0000
Message-ID: <BN7PR08MB486872E154C5754392031FD4C6390@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1534182832-554-11-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534182832-554-11-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v8 10/87] target/mips: Fix MT ASE
 instructions' availability control
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Monday, August 13, 2018 7:52 PM
> To: qemu-devel@nongnu.org
>
> Subject: [PATCH v8 10/87] target/mips: Fix MT ASE instructions' availabil=
ity control
>=20
> From: Aleksandar Rikalo <arikalo@wavecomp.com>
>=20
> Use bits from configuration registers for availability control
> of MT ASE instructions, rather than only ISA_MT bit in insn_flags.
>=20
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index b73f434..af9714b 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -8393,7 +8393,7 @@ static void gen_cp0 (CPUMIPSState *env, DisasContex=
t *ctx, uint32_t opc, int rt,
>          opn =3D "mthc0";
>          break;
>      case OPC_MFTR:
> -        check_insn(ctx, ASE_MT);
> +        check_cp0_enabled(ctx);
>          if (rd =3D=3D 0) {
>              /* Treat as NOP. */
>              return;
> @@ -8403,7 +8403,7 @@ static void gen_cp0 (CPUMIPSState *env, DisasContex=
t *ctx, uint32_t opc, int rt,
>          opn =3D "mftr";
>          break;
>      case OPC_MTTR:
> -        check_insn(ctx, ASE_MT);
> +        check_cp0_enabled(ctx);
>          gen_mttr(env, ctx, rd, rt, (ctx->opcode >> 5) & 1,
>                   ctx->opcode & 0x7, (ctx->opcode >> 4) & 1);
>          opn =3D "mttr";
> @@ -18619,7 +18619,7 @@ static void decode_opc_special3(CPUMIPSState *env=
, DisasContext *ctx)
>          gen_rdhwr(ctx, rt, rd, extract32(ctx->opcode, 6, 3));
>          break;
>      case OPC_FORK:
> -        check_insn(ctx, ASE_MT);
> +        check_mt(ctx);
>          {
>              TCGv t0 =3D tcg_temp_new();
>              TCGv t1 =3D tcg_temp_new();
> @@ -18632,7 +18632,7 @@ static void decode_opc_special3(CPUMIPSState *env=
, DisasContext *ctx)
>          }
>          break;
>      case OPC_YIELD:
> -        check_insn(ctx, ASE_MT);
> +        check_mt(ctx);
>          {
>              TCGv t0 =3D tcg_temp_new();
>=20
> @@ -19929,22 +19929,22 @@ static void decode_opc(CPUMIPSState *env, Disas=
Context *ctx)
>                  op2 =3D MASK_MFMC0(ctx->opcode);
>                  switch (op2) {
>                  case OPC_DMT:
> -                    check_insn(ctx, ASE_MT);
> +                    check_cp0_mt(ctx);
>                      gen_helper_dmt(t0);
>                      gen_store_gpr(t0, rt);
>                      break;
>                  case OPC_EMT:
> -                    check_insn(ctx, ASE_MT);
> +                    check_cp0_mt(ctx);
>                      gen_helper_emt(t0);
>                      gen_store_gpr(t0, rt);
>                      break;
>                  case OPC_DVPE:
> -                    check_insn(ctx, ASE_MT);
> +                    check_cp0_mt(ctx);
>                      gen_helper_dvpe(t0, cpu_env);
>                      gen_store_gpr(t0, rt);
>                      break;
>                  case OPC_EVPE:
> -                    check_insn(ctx, ASE_MT);
> +                    check_cp0_mt(ctx);
>                      gen_helper_evpe(t0, cpu_env);
>                      gen_store_gpr(t0, rt);
>                      break;

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
