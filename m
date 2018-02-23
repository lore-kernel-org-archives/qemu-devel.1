Received: from eggs.gnu.org ([2001:4830:134:3::10]:47285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epFWL-0001om-Se
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:44:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epFWK-00008m-RH
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:44:25 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:44262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epFWK-00006l-Kh
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:44:24 -0500
Received: by mail-pg0-x242.google.com with SMTP id l4so3489098pgp.11
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 07:44:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-32-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-32-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 15:44:03 +0000
Message-ID: <CAFEAcA9kSgYNVQ6L6b94Gnz2ZnD4RKfeBqJintfgVqW47zq-qA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 31/67] target/arm: Implement
 SVE conditionally broadcast/extract element
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
>  target/arm/helper-sve.h    |   2 +
>  target/arm/sve_helper.c    |  11 ++
>  target/arm/translate-sve.c | 299 +++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      |  20 +++
>  4 files changed, 332 insertions(+)
>
> diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
> index d977aea00d..a58fb4ba01 100644
> --- a/target/arm/helper-sve.h
> +++ b/target/arm/helper-sve.h
> @@ -463,6 +463,8 @@ DEF_HELPER_FLAGS_4(sve_trn_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_4(sve_compact_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_4(sve_compact_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>
> +DEF_HELPER_FLAGS_2(sve_last_active_element, TCG_CALL_NO_RWG, s32, ptr, i32)
> +
>  DEF_HELPER_FLAGS_5(sve_and_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_5(sve_bic_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_5(sve_eor_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index 87a1a32232..ee289be642 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -2050,3 +2050,14 @@ void HELPER(sve_compact_d)(void *vd, void *vn, void *vg, uint32_t desc)
>          d[j] = 0;
>      }
>  }
> +
> +/* Similar to the ARM LastActiveElement pseudocode function, except the
> +   result is multiplied by the element size.  This includes the not found
> +   indication; e.g. not found for esz=3 is -8.  */
> +int32_t HELPER(sve_last_active_element)(void *vg, uint32_t pred_desc)
> +{
> +    intptr_t oprsz = extract32(pred_desc, 0, SIMD_OPRSZ_BITS) + 2;
> +    intptr_t esz = extract32(pred_desc, SIMD_DATA_SHIFT, 2);

pred_desc is obviously an encoding of some stuff, so the comment would
be a good place to mention what it is.


> +/* Compute CLAST for a scalar.  */
> +static void do_clast_scalar(DisasContext *s, int esz, int pg, int rm,
> +                            bool before, TCGv_i64 reg_val)
> +{
> +    TCGv_i32 last = tcg_temp_new_i32();
> +    TCGv_i64 ele, cmp, zero;
> +
> +    find_last_active(s, last, esz, pg);
> +
> +    /* Extend the original value of last prior to incrementing.  */
> +    cmp = tcg_temp_new_i64();
> +    tcg_gen_ext_i32_i64(cmp, last);
> +
> +    if (!before) {
> +        incr_last_active(s, last, esz);
> +    }
> +
> +    /* The conceit here is that while last < 0 indicates not found, after
> +       adjusting for cpu_env->vfp.zregs[rm], it is still a valid address
> +       from which we can load garbage.  We then discard the garbage with
> +       a conditional move.  */

That's a bit ugly. Can we at least do a compile time assert that the
worst case (which I guess is offset of zregs[0] minus largest-element-size)
is still positive ? That way if for some reason we reshuffle fields
in CPUARMState we'll notice if it's going to fall off the beginning
of the struct.

> +    ele = load_last_active(s, last, rm, esz);
> +    tcg_temp_free_i32(last);
> +
> +    zero = tcg_const_i64(0);
> +    tcg_gen_movcond_i64(TCG_COND_GE, reg_val, cmp, zero, ele, reg_val);
> +
> +    tcg_temp_free_i64(zero);
> +    tcg_temp_free_i64(cmp);
> +    tcg_temp_free_i64(ele);
> +}

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
