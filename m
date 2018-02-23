Received: from eggs.gnu.org ([2001:4830:134:3::10]:33119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epDE0-0002Bo-6D
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:17:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epDDz-0001Qw-7o
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:17:20 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:39888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epDDz-0001QG-0F
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:17:19 -0500
Received: by mail-pg0-x241.google.com with SMTP id w17so3345134pgv.6
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 05:17:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-17-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-17-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 13:16:57 +0000
Message-ID: <CAFEAcA-QyoAU8Y2DYmc2LtAD0R6ynJ_Guw44oqcMG1QxzioJTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 16/67] target/arm: Implement
 SVE Integer Arithmetic - Unpredicated Group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 17 February 2018 at 18:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-sve.c | 41 ++++++++++++++++++++++++++++++++++++++---
>  target/arm/sve.decode      | 13 +++++++++++++
>  2 files changed, 51 insertions(+), 3 deletions(-)

> @@ -254,7 +288,8 @@ static void do_zpzz_ool(DisasContext *s, arg_rprr_esz *a, gen_helper_gvec_4 *fn)
>  }
>
>  #define DO_ZPZZ(NAME, name) \
> -void trans_##NAME##_zpzz(DisasContext *s, arg_rprr_esz *a, uint32_t insn) \
> +static void trans_##NAME##_zpzz(DisasContext *s, arg_rprr_esz *a,         \
> +                                uint32_t insn)                            \
>  {                                                                         \
>      static gen_helper_gvec_4 * const fns[4] = {                           \
>          gen_helper_sve_##name##_zpzz_b, gen_helper_sve_##name##_zpzz_h,   \
> @@ -286,7 +321,7 @@ DO_ZPZZ(ASR, asr)
>  DO_ZPZZ(LSR, lsr)
>  DO_ZPZZ(LSL, lsl)
>
> -void trans_SDIV_zpzz(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
> +static void trans_SDIV_zpzz(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
>  {
>      static gen_helper_gvec_4 * const fns[4] = {
>          NULL, NULL, gen_helper_sve_sdiv_zpzz_s, gen_helper_sve_sdiv_zpzz_d
> @@ -294,7 +329,7 @@ void trans_SDIV_zpzz(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
>      do_zpzz_ool(s, a, fns[a->esz]);
>  }
>
> -void trans_UDIV_zpzz(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
> +static void trans_UDIV_zpzz(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
>  {
>      static gen_helper_gvec_4 * const fns[4] = {
>          NULL, NULL, gen_helper_sve_udiv_zpzz_s, gen_helper_sve_udiv_zpzz_d

Should these changes to 'static' have been in a different patch, or was
that to avoid compiler warnings when the functions were introduced but not
used til this patch?

> diff --git a/target/arm/sve.decode b/target/arm/sve.decode
> index 68a1823b72..b40d7dc9a2 100644
> --- a/target/arm/sve.decode
> +++ b/target/arm/sve.decode
> @@ -68,6 +68,9 @@
>  # Three prediate operand, with governing predicate, flag setting
>  @pd_pg_pn_pm_s ........ . s:1 .. rm:4 .. pg:4 . rn:4 . rd:4    &rprr_s
>
> +# Three operand, vector element size
> +@rd_rn_rm      ........ esz:2 . rm:5  ... ...  rn:5 rd:5       &rrr_esz
> +
>  # Two register operand, with governing predicate, vector element size
>  @rdn_pg_rm     ........ esz:2 ... ... ... pg:3 rm:5 rd:5 \
>                 &rprr_esz rn=%reg_movprfx
> @@ -205,6 +208,16 @@ MLS                00000100 .. 0 ..... 011 ... ..... .....   @rda_pg_rn_rm
>  MLA            00000100 .. 0 ..... 110 ... ..... .....   @rdn_pg_ra_rm # MAD
>  MLS            00000100 .. 0 ..... 111 ... ..... .....   @rdn_pg_ra_rm # MSB
>
> +### SVE Integer Arithmetic - Unpredicated Group
> +
> +# SVE integer add/subtract vectors (unpredicated)
> +ADD_zzz                00000100 .. 1 ..... 000 000 ..... .....         @rd_rn_rm
> +SUB_zzz                00000100 .. 1 ..... 000 001 ..... .....         @rd_rn_rm
> +SQADD_zzz      00000100 .. 1 ..... 000 100 ..... .....         @rd_rn_rm
> +UQADD_zzz      00000100 .. 1 ..... 000 101 ..... .....         @rd_rn_rm
> +SQSUB_zzz      00000100 .. 1 ..... 000 110 ..... .....         @rd_rn_rm
> +UQSUB_zzz      00000100 .. 1 ..... 000 111 ..... .....         @rd_rn_rm

Misaligned lines for ADD and SUB.

Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
