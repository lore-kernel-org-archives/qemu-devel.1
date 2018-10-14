Received: from eggs.gnu.org ([2001:4830:134:3::10]:48983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBojJ-0006q5-FF
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 18:19:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBoj9-0007ch-6K
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 18:19:17 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBoj5-0007YL-BX
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 18:19:08 -0400
Received: by mail-yw1-f66.google.com with SMTP id y14-v6so6874060ywa.4
	for <qemu-devel@nongnu.org>; Sun, 14 Oct 2018 15:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <1539362376-12010-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1539362376-12010-19-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539362376-12010-19-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>
Date: Mon, 15 Oct 2018 00:18:53 +0200
Message-ID: <CAAdtpL7MbqK9FvMSfw9FYpAkGXQDGrV08B1LBu45rDEATm3XQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 18/28] target/mips: Add availability
 control for DSP R3 ASE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Stefan Markovic <smarkovic@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Aleksandar Markovic <amarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

On Fri, Oct 12, 2018 at 6:52 PM Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Stefan Markovic <smarkovic@wavecomp.com>
>
> Add infrastructure for availability control for DSP R3 ASE MIPS
> instructions. Only BPOSGE32C currently belongs to DSP R3 ASE, but
> this is likely to be changed in near future.
>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  target/mips/internal.h           | 11 ++++++++---
>  target/mips/translate.c          | 13 ++++++++++++-
>  target/mips/translate_init.inc.c |  3 ++-
>  3 files changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/target/mips/internal.h b/target/mips/internal.h
> index 54bf39f..e367d7e 100644
> --- a/target/mips/internal.h
> +++ b/target/mips/internal.h
> @@ -310,8 +310,8 @@ static inline void compute_hflags(CPUMIPSState *env)
>      env->hflags &=3D ~(MIPS_HFLAG_COP1X | MIPS_HFLAG_64 | MIPS_HFLAG_CP0=
 |
>                       MIPS_HFLAG_F64 | MIPS_HFLAG_FPU | MIPS_HFLAG_KSU |
>                       MIPS_HFLAG_AWRAP | MIPS_HFLAG_DSP | MIPS_HFLAG_DSPR=
2 |
> -                     MIPS_HFLAG_SBRI | MIPS_HFLAG_MSA | MIPS_HFLAG_FRE |
> -                     MIPS_HFLAG_ELPA | MIPS_HFLAG_ERL);
> +                     MIPS_HFLAG_DSPR3 | MIPS_HFLAG_SBRI | MIPS_HFLAG_MSA=
 |
> +                     MIPS_HFLAG_FRE | MIPS_HFLAG_ELPA | MIPS_HFLAG_ERL);
>      if (env->CP0_Status & (1 << CP0St_ERL)) {
>          env->hflags |=3D MIPS_HFLAG_ERL;
>      }
> @@ -358,7 +358,12 @@ static inline void compute_hflags(CPUMIPSState *env)
>          (env->CP0_Config5 & (1 << CP0C5_SBRI))) {
>          env->hflags |=3D MIPS_HFLAG_SBRI;
>      }
> -    if (env->insn_flags & ASE_DSPR2) {
> +    if (env->insn_flags & ASE_DSPR3) {
> +        if (env->CP0_Status & (1 << CP0St_MX)) {
> +            env->hflags |=3D MIPS_HFLAG_DSP | MIPS_HFLAG_DSPR2 |
> +                           MIPS_HFLAG_DSPR3;
> +        }
> +    } else if (env->insn_flags & ASE_DSPR2) {
>          /* Enables access MIPS DSP resources, now our cpu is DSP ASER2,
>             so enable to access DSPR2 resources. */
>          if (env->CP0_Status & (1 << CP0St_MX)) {
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index e9c3a14..c3ad65c 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -1869,6 +1869,17 @@ static inline void check_dspr2(DisasContext *ctx)
>      }
>  }
>
> +static inline void check_dspr3(DisasContext *ctx)
> +{
> +    if (unlikely(!(ctx->hflags & MIPS_HFLAG_DSPR3))) {
> +        if (ctx->insn_flags & ASE_DSP) {
> +            generate_exception_end(ctx, EXCP_DSPDIS);
> +        } else {
> +            generate_exception_end(ctx, EXCP_RI);
> +        }
> +    }
> +}
> +
>  /* This code generates a "reserved instruction" exception if the
>     CPU does not support the instruction set corresponding to flags. */
>  static inline void check_insn(DisasContext *ctx, int flags)
> @@ -20285,7 +20296,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState=
 *env, DisasContext *ctx)
>                      gen_compute_branch_cp1_nm(ctx, OPC_BC1NEZ, rt, s);
>                      break;
>                  case NM_BPOSGE32C:
> -                    check_dspr2(ctx);
> +                    check_dspr3(ctx);
>                      {
>                          int32_t imm =3D extract32(ctx->opcode, 1, 13) |
>                                        extract32(ctx->opcode, 0, 1) << 13=
;
> diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_ini=
t.inc.c
> index b3320b9..d7cd4ee 100644
> --- a/target/mips/translate_init.inc.c
> +++ b/target/mips/translate_init.inc.c
> @@ -485,7 +485,8 @@ const mips_def_t mips_defs[] =3D
>          .CP1_fcr31 =3D (1 << FCR31_ABS2008) | (1 << FCR31_NAN2008),
>          .SEGBITS =3D 32,
>          .PABITS =3D 32,
> -        .insn_flags =3D CPU_NANOMIPS32 | ASE_DSP | ASE_DSPR2 | ASE_MT,
> +        .insn_flags =3D CPU_NANOMIPS32 | ASE_DSP | ASE_DSPR2 | ASE_DSPR3=
 |
> +                      ASE_MT,
>          .mmu_type =3D MMU_TYPE_R4000,
>      },
>  #if defined(TARGET_MIPS64)
> --
> 2.7.4
>
>
