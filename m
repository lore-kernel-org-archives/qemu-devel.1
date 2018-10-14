Received: from eggs.gnu.org ([2001:4830:134:3::10]:50675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBov7-000114-8A
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 18:31:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBouz-0005kr-15
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 18:31:30 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:33610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBoux-0005jc-63
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 18:31:24 -0400
Received: by mail-yb1-f194.google.com with SMTP id u88-v6so6830088ybi.0
	for <qemu-devel@nongnu.org>; Sun, 14 Oct 2018 15:31:21 -0700 (PDT)
MIME-Version: 1.0
References: <1539362376-12010-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1539362376-12010-9-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539362376-12010-9-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>
Date: Mon, 15 Oct 2018 00:31:10 +0200
Message-ID: <CAAdtpL44km+bdSVfx=M-eMaXSrAKvChbAvED--9-nQxv=5-Esg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 08/28] target/mips: Add CPO PWBase
 register
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

On Fri, Oct 12, 2018 at 6:47 PM Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Yongbok Kim <yongbok.kim@mips.com>
>
> Add PWBase register (CP0 Register 5, Select 5).
>
> The PWBase register contains the Page Table Base virtual address.
>
> This register is required for the hardware page walker feature. It
> exists only if Config3 PW bit is set to 1.
>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/cpu.h       |  1 +
>  target/mips/machine.c   |  5 +++--
>  target/mips/translate.c | 31 +++++++++++++++++++++++++++++++
>  3 files changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 28af4d1..c8999a8 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -289,6 +289,7 @@ struct CPUMIPSState {
>  #define CP0SC2_XR       56
>  #define CP0SC2_XR_MASK  (0xFFULL << CP0SC2_XR)
>  #define CP0SC2_MASK     (CP0SC_1GMASK | (CP0SC_1GMASK << 16) | CP0SC2_XR_MASK)
> +    target_ulong CP0_PWBase;
>      int32_t CP0_Wired;
>      int32_t CP0_SRSConf0_rw_bitmask;
>      int32_t CP0_SRSConf0;
> diff --git a/target/mips/machine.c b/target/mips/machine.c
> index 5ba78ac..3592bb7 100644
> --- a/target/mips/machine.c
> +++ b/target/mips/machine.c
> @@ -212,8 +212,8 @@ const VMStateDescription vmstate_tlb = {
>
>  const VMStateDescription vmstate_mips_cpu = {
>      .name = "cpu",
> -    .version_id = 11,
> -    .minimum_version_id = 11,
> +    .version_id = 12,
> +    .minimum_version_id = 12,
>      .post_load = cpu_post_load,
>      .fields = (VMStateField[]) {
>          /* Active TC */
> @@ -256,6 +256,7 @@ const VMStateDescription vmstate_mips_cpu = {
>          VMSTATE_UINTTL(env.CP0_SegCtl0, MIPSCPU),
>          VMSTATE_UINTTL(env.CP0_SegCtl1, MIPSCPU),
>          VMSTATE_UINTTL(env.CP0_SegCtl2, MIPSCPU),
> +        VMSTATE_UINTTL(env.CP0_PWBase, MIPSCPU),
>          VMSTATE_INT32(env.CP0_Wired, MIPSCPU),
>          VMSTATE_INT32(env.CP0_SRSConf0, MIPSCPU),
>          VMSTATE_INT32(env.CP0_SRSConf1, MIPSCPU),
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index ab16cdb..7af9a21 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -1929,6 +1929,17 @@ static inline void check_xnp(DisasContext *ctx)
>
>  /*
>   * This code generates a "reserved instruction" exception if the
> + * Config3 PW bit is NOT set.
> + */
> +static inline void check_pw(DisasContext *ctx)
> +{
> +    if (unlikely(!(ctx->CP0_Config3 & (1 << CP0C3_PW)))) {
> +        generate_exception_end(ctx, EXCP_RI);
> +    }
> +}
> +
> +/*
> + * This code generates a "reserved instruction" exception if the
>   * Config3 MT bit is NOT set.
>   */
>  static inline void check_mt(DisasContext *ctx)
> @@ -5537,6 +5548,11 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>              tcg_gen_ext32s_tl(arg, arg);
>              rn = "SegCtl2";
>              break;
> +        case 5:
> +            check_pw(ctx);
> +            gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PWBase));
> +            rn = "PWBase";
> +            break;
>          default:
>              goto cp0_unimplemented;
>          }
> @@ -6238,6 +6254,11 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>              gen_helper_mtc0_segctl2(cpu_env, arg);
>              rn = "SegCtl2";
>              break;
> +        case 5:
> +            check_pw(ctx);
> +            gen_mtc0_store32(arg, offsetof(CPUMIPSState, CP0_PWBase));
> +            rn = "PWBase";
> +            break;
>          default:
>              goto cp0_unimplemented;
>          }
> @@ -6948,6 +6969,11 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>              tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_SegCtl2));
>              rn = "SegCtl2";
>              break;
> +        case 5:
> +            check_pw(ctx);
> +            tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_PWBase));

Shouldn't you use gen_mfc0_load64()?

> +            rn = "PWBase";
> +            break;
>          default:
>              goto cp0_unimplemented;
>          }
> @@ -7631,6 +7657,11 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>              gen_helper_mtc0_segctl2(cpu_env, arg);
>              rn = "SegCtl2";
>              break;
> +        case 5:
> +            check_pw(ctx);
> +            tcg_gen_st_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_PWBase));
> +            rn = "PWBase";
> +            break;
>          default:
>              goto cp0_unimplemented;
>          }
> --
> 2.7.4
>
>
