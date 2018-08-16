Received: from eggs.gnu.org ([2001:4830:134:3::10]:48598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fqHuG-0003UZ-S0
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:01:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fqHuA-0001Uh-Jg
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:01:40 -0400
Received: from mail-sn1nam01on0113.outbound.protection.outlook.com
	([104.47.32.113]:44032
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fqHu6-0001T7-Ni
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:01:32 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 16 Aug 2018 13:01:26 +0000
Message-ID: <BN7PR08MB4868A573D7E52993A214F274C63E0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1534182832-554-53-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534182832-554-53-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v8 52/87] target/mips: Add handling of
 branch delay slots for nanoMIPS
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
> Sent: Monday, August 13, 2018 7:53 PM
>=20
> Subject: [PATCH v8 52/87] target/mips: Add handling of branch delay slots=
 for nanoMIPS
>=20
> From: Matthew Fortune <matthew.fortune@mips.com>
>=20
> ISA mode bit (LSB of address) is no longer required but is also
> masked to allow for tools transition. The flag has_isa_mode has the
> key role in the implementation.
>=20
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 3282fca..e4427e4 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -1471,6 +1471,7 @@ typedef struct DisasContext {
>      bool mrp;
>      bool nan2008;
>      bool abs2008;
> +    bool has_isa_mode;
>  } DisasContext;
>=20
>  #define DISAS_STOP       DISAS_TARGET_0
> @@ -4674,7 +4675,7 @@ static void gen_compute_branch (DisasContext *ctx, =
uint32_t opc,
>=20
>      if (blink > 0) {
>          int post_delay =3D insn_bytes + delayslot_size;
> -        int lowbit =3D !!(ctx->hflags & MIPS_HFLAG_M16);
> +        int lowbit =3D ctx->has_isa_mode && !!(ctx->hflags & MIPS_HFLAG_=
M16);
>=20
>          tcg_gen_movi_tl(cpu_gpr[blink],
>                          ctx->base.pc_next + post_delay + lowbit);
> @@ -11171,7 +11172,7 @@ static void gen_compute_compact_branch(DisasConte=
xt *ctx, uint32_t opc,
>      int bcond_compute =3D 0;
>      TCGv t0 =3D tcg_temp_new();
>      TCGv t1 =3D tcg_temp_new();
> -    int m16_lowbit =3D (ctx->hflags & MIPS_HFLAG_M16) !=3D 0;
> +    int m16_lowbit =3D ctx->has_isa_mode && ((ctx->hflags & MIPS_HFLAG_M=
16) !=3D 0);
>=20
>      if (ctx->hflags & MIPS_HFLAG_BMASK) {
>  #ifdef MIPS_DEBUG_DISAS
> @@ -24970,6 +24971,7 @@ static void mips_tr_init_disas_context(DisasConte=
xtBase *dcbase, > CPUState *cs)
>      ctx->mrp =3D (env->CP0_Config5 >> CP0C5_MRP) & 1;
>      ctx->nan2008 =3D (env->active_fpu.fcr31 >> FCR31_NAN2008) & 1;
>      ctx->abs2008 =3D (env->active_fpu.fcr31 >> FCR31_ABS2008) & 1;
> +    ctx->has_isa_mode =3D ((env->CP0_Config3 >> CP0C3_MMAR) & 0x7) < 3;
>      restore_cpu_state(env, ctx);
>  #ifdef CONFIG_USER_ONLY
>          ctx->mem_idx =3D MIPS_HFLAG_UM;
> --
> 2.7.4
>=20

This patch should be renamed to reflect its real content. Also, the code se=
gments in question should be re-examined in follow-up clean ups. That said,=
 it isn't still show-stopper:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>=
