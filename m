Received: from eggs.gnu.org ([2001:4830:134:3::10]:36130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epBdq-0004ld-WC
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 06:35:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epBdl-0000hx-81
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 06:35:55 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:43203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epBdl-0000gf-1b
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 06:35:49 -0500
Received: by mail-pl0-x241.google.com with SMTP id f23so4743965plr.10
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 03:35:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-10-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 11:35:27 +0000
Message-ID: <CAFEAcA-jg_+4vockJi=iP9VxekLH_FBPwUDJcyDrY-J+OYwm9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 09/67] target/arm: Implement SVE Integer
 Binary Arithmetic - Predicated Group
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
>  target/arm/helper-sve.h    | 145 +++++++++++++++++++++++++++++++++
>  target/arm/sve_helper.c    | 196 ++++++++++++++++++++++++++++++++++++++++++++-
>  target/arm/translate-sve.c |  65 +++++++++++++++
>  target/arm/sve.decode      |  42 ++++++++++
>  4 files changed, 447 insertions(+), 1 deletion(-)
>

> @@ -105,7 +121,7 @@ LOGICAL_PPPP(sve_orn_pppp, DO_ORN)
>  LOGICAL_PPPP(sve_nor_pppp, DO_NOR)
>  LOGICAL_PPPP(sve_nand_pppp, DO_NAND)
>
> -#undef DO_ADD
> +#undef DO_AND

Should this be in a previous patch?

>  #undef DO_BIC
>  #undef DO_EOR
>  #undef DO_ORR

> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index a9b6ae046d..116002792a 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -211,6 +211,71 @@ static void trans_BIC_zzz(DisasContext *s, arg_BIC_zzz *a, uint32_t insn)
>      do_vector3_z(s, tcg_gen_gvec_andc, 0, a->rd, a->rn, a->rm);
>  }
>
> +/*
> + *** SVE Integer Arithmetic - Binary Predicated Group
> + */
> +
> +static void do_zpzz_ool(DisasContext *s, arg_rprr_esz *a, gen_helper_gvec_4 *fn)
> +{
> +    unsigned vsz = vec_full_reg_size(s);
> +    if (fn == NULL) {
> +        unallocated_encoding(s);
> +        return;
> +    }

I think you do not want to be catching unallocated encodings
this late in the decode process. We have to identify all
the unallocated encodings before we do the "are SVE and
FP instructions supposed to trap" tests, because those don't
apply to unallocated encodings.

> +    tcg_gen_gvec_4_ool(vec_full_reg_offset(s, a->rd),
> +                       vec_full_reg_offset(s, a->rn),
> +                       vec_full_reg_offset(s, a->rm),
> +                       pred_full_reg_offset(s, a->pg),
> +                       vsz, vsz, 0, fn);
> +}

Rest of patch looks OK.

thanks
-- PMM
