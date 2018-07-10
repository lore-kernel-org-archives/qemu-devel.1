Received: from eggs.gnu.org ([2001:4830:134:3::10]:54744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcx8F-0003s6-Q6
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:13:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcx8B-0004mc-EE
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:12:59 -0400
Received: from mail-bn3nam01on0114.outbound.protection.outlook.com
	([104.47.33.114]:34976
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fcx8B-0004mQ-7M
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:12:55 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 10 Jul 2018 18:12:51 +0000
Message-ID: <BN7PR08MB4868AACA64544BD3C0BD8652C65B0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1531169431-10772-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1531169431-10772-19-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1531169431-10772-19-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 18/33] target/mips: Add handling of
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
Cc: "f4bug@amsat.org" <f4bug@amsat.org>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> Subject: [PATCH v2 18/33] target/mips: Add handling of branch delay slots=
 for nanoMIPS
>
> From: Matthew Fortune <matthew.fortune@mips.com>
>
> ISA mode bit (LSB of address) is no longer required but is also
> masked to allow for tools transition. The flag has_isa_mode has the
> key role in the implementation.
>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 564d459..c9087d2 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -1458,6 +1458,7 @@ typedef struct DisasContext {
>      bool mrp;
>      bool nan2008;
>      bool abs2008;
> +    bool has_isa_mode;
>  } DisasContext;
>
>  #define DISAS_STOP       DISAS_TARGET_0
> @@ -4538,7 +4539,7 @@ static void gen_compute_branch (DisasContext *ctx, =
uint32_t opc,
>
>      if (blink > 0) {
>          int post_delay =3D insn_bytes + delayslot_size;
> -        int lowbit =3D !!(ctx->hflags & MIPS_HFLAG_M16);
> +        int lowbit =3D ctx->has_isa_mode && !!(ctx->hflags & MIPS_HFLAG_=
M16);
>
>          tcg_gen_movi_tl(cpu_gpr[blink],
>                          ctx->base.pc_next + post_delay + lowbit);
> @@ -10991,7 +10992,8 @@ static void gen_branch(DisasContext *ctx, int ins=
n_bytes)
>              break;
>          case MIPS_HFLAG_BR:
>              /* unconditional branch to register */
> -            if (ctx->insn_flags & (ASE_MIPS16 | ASE_MICROMIPS)) {
> +            if (ctx->has_isa_mode &&
> +                    (ctx->insn_flags & (ASE_MIPS16 | ASE_MICROMIPS))) {
>                  TCGv t0 =3D tcg_temp_new();
>                  TCGv_i32 t1 =3D tcg_temp_new_i32();
>
> @@ -11027,7 +11029,7 @@ static void gen_compute_compact_branch(DisasConte=
xt *ctx, uint32_t > opc,
>      int bcond_compute =3D 0;
>      TCGv t0 =3D tcg_temp_new();
>      TCGv t1 =3D tcg_temp_new();
> -    int m16_lowbit =3D (ctx->hflags & MIPS_HFLAG_M16) !=3D 0;
> +    int m16_lowbit =3D ctx->has_isa_mode && ((ctx->hflags & MIPS_HFLAG_M=
16) !=3D 0);
>
>      if (ctx->hflags & MIPS_HFLAG_BMASK) {
>  #ifdef MIPS_DEBUG_DISAS
> @@ -24749,6 +24751,7 @@ static void mips_tr_init_disas_context(DisasConte=
xtBase *dcbase, > CPUState *cs)
>      ctx->mrp =3D (env->CP0_Config5 >> CP0C5_MRP) & 1;
>      ctx->nan2008 =3D (env->active_fpu.fcr31 >> FCR31_NAN2008) & 1;
>      ctx->abs2008 =3D (env->active_fpu.fcr31 >> FCR31_ABS2008) & 1;
> +    ctx->has_isa_mode =3D ((env->CP0_Config3 >> CP0C3_MMAR) & 0x7) !=3D =
3;

The architecture documentation for CP0 MMAR register says that "!=3D 3;" sh=
ould actually read "< 3;". Also, is "has_isa_mode" the best name? Would "is=
_no_nanomips" be better? Or "is_nanomips", with reverse logic in the code?

>      restore_cpu_state(env, ctx);
>  #ifdef CONFIG_USER_ONLY
>          ctx->mem_idx =3D MIPS_HFLAG_UM;
> --
> 2.7.4
>
>
