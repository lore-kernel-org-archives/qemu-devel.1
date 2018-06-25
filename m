Received: from eggs.gnu.org ([2001:4830:134:3::10]:56752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXVb9-0003yv-5e
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:48:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXVb8-0005Mv-AO
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:48:19 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:35183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXVb8-0005Ml-3f
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:48:18 -0400
Received: by mail-oi0-x242.google.com with SMTP id e8-v6so13337929oii.2
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 10:48:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621015359.12018-19-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-19-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Jun 2018 18:47:56 +0100
Message-ID: <CAFEAcA-9uU1GNZoq2N5-Mn3zSccL59ygaQq_RWQjqpaX0imeiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 18/35] target/arm: Implement SVE
 Floating Point Multiply Indexed Group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 June 2018 at 02:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h        | 14 +++++++++++
>  target/arm/translate-sve.c | 50 ++++++++++++++++++++++++++++++++++++++
>  target/arm/vec_helper.c    | 48 ++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      | 19 +++++++++++++++
>  4 files changed, 131 insertions(+)

> +static bool trans_FMLA_zzxz(DisasContext *s, arg_FMLA_zzxz *a, uint32_t insn)
> +{
> +    static gen_helper_gvec_4_ptr * const fns[3] = {
> +        gen_helper_gvec_fmla_idx_h,
> +        gen_helper_gvec_fmla_idx_s,
> +        gen_helper_gvec_fmla_idx_d,
> +    };
> +
> +    if (sve_access_check(s)) {
> +        unsigned vsz = vec_full_reg_size(s);
> +        TCGv_ptr status = get_fpstatus_ptr(a->esz == MO_16);
> +        tcg_gen_gvec_4_ptr(vec_full_reg_offset(s, a->rd),
> +                           vec_full_reg_offset(s, a->rn),
> +                           vec_full_reg_offset(s, a->rm),
> +                           vec_full_reg_offset(s, a->ra),
> +                           status, vsz, vsz, a->index * 2 + a->sub,

Why are we multiplying the index by 2 here? Are we just encoding
(index, sub) into a constant to pull out again the other side?
If so, comment might help. (Also I find shifts and ors make it
clearer that we're just shifting values around; multiplication
and addition to me implies that we're really doing arithmetic.)

> +                           fns[a->esz - 1]);
> +        tcg_temp_free_ptr(status);
> +    }
> +    return true;
> +}

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
