Received: from eggs.gnu.org ([2001:4830:134:3::10]:39651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epBsS-0001yw-Fo
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 06:51:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epBsR-000856-Jd
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 06:51:00 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:36258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epBsR-00083t-DG
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 06:50:59 -0500
Received: by mail-pl0-x244.google.com with SMTP id v3so4773691plg.3
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 03:50:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-11-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 11:50:37 +0000
Message-ID: <CAFEAcA_7Tn5SWbTOY4VqMcwDngyUvRyPvWJJJeFwhGKh_kCgsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 10/67] target/arm: Implement
 SVE Integer Reduction Group
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
> Excepting MOVPRFX, which isn't a reduction.  Presumably it is
> placed within the group because of its encoding.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


> @@ -306,8 +399,6 @@ DO_ZPZZ_D(sve_udiv_zpzz_d, uint64_t, DO_DIV)
>  #undef DO_ABD
>  #undef DO_MUL
>  #undef DO_DIV
> -#undef DO_ZPZZ
> -#undef DO_ZPZZ_D
>
>  /* Similar to the ARM LastActiveElement pseudocode function, except the
>     result is multiplied by the element size.  This includes the not found

Hunk in wrong patch or incorrect?

> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index 116002792a..49251a53c1 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -276,6 +276,71 @@ void trans_UDIV_zpzz(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
>
>  #undef DO_ZPZZ
>
> +/*
> + *** SVE Integer Reduction Group
> + */
> +
> +typedef void gen_helper_gvec_reduc(TCGv_i64, TCGv_ptr, TCGv_ptr, TCGv_i32);
> +static void do_vpz_ool(DisasContext *s, arg_rpr_esz *a,
> +                       gen_helper_gvec_reduc *fn)
> +{
> +    unsigned vsz = vec_full_reg_size(s);
> +    TCGv_ptr t_zn, t_pg;
> +    TCGv_i32 desc;
> +    TCGv_i64 temp;
> +
> +    if (fn == 0) {
> +        unallocated_encoding(s);
> +        return;
> +    }

Same remarks as for patch 9 about this being too late to
catch unallocated_encodings (or alternatively needing to
do the sve/fp check after this). I won't bother to mention
this issue for later patches, but you can assume it as a
general caveat to my reviewed-by tags.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
