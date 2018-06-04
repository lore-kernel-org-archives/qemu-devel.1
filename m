Received: from eggs.gnu.org ([2001:4830:134:3::10]:38355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPsde-0002RK-Ih
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 12:47:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPsdd-0004DG-Fp
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 12:47:22 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:36302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fPsdd-0004Cv-9X
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 12:47:21 -0400
Received: by mail-oi0-x242.google.com with SMTP id 14-v6so21014861oie.3
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 09:47:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180530180120.13355-7-richard.henderson@linaro.org>
References: <20180530180120.13355-1-richard.henderson@linaro.org>
	<20180530180120.13355-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Jun 2018 17:46:59 +0100
Message-ID: <CAFEAcA_z+UmmJcqzqtq7RiPnEZDLwpfESQbP4ajRZLFLsVKmqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3b 06/18] target/arm: Implement SVE
 conditionally broadcast/extract element
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

On 30 May 2018 at 19:01, Richard Henderson <richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    |   2 +
>  target/arm/sve_helper.c    |  11 ++
>  target/arm/translate-sve.c | 318 +++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      |  20 +++
>  4 files changed, 351 insertions(+)
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
> index ed3c6d4ca9..941a098234 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -2070,3 +2070,14 @@ void HELPER(sve_compact_d)(void *vd, void *vn, void *vg, uint32_t desc)
>          d[j] = 0;
>      }
>  }
> +
> +/* Similar to the ARM LastActiveElement pseudocode function, except the
> +   result is multiplied by the element size.  This includes the not found
> +   indication; e.g. not found for esz=3 is -8.  */

Non-standard multiline comment form... (I won't bother to note
this in other patches, but please check those too.)

> +int32_t HELPER(sve_last_active_element)(void *vg, uint32_t pred_desc)
> +{
> +    intptr_t oprsz = extract32(pred_desc, 0, SIMD_OPRSZ_BITS) + 2;
> +    intptr_t esz = extract32(pred_desc, SIMD_DATA_SHIFT, 2);
> +
> +    return last_active_element(vg, DIV_ROUND_UP(oprsz, 8), esz);
> +}
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index ed0f48a927..edcef277f8 100644

> +/* Compute CLAST for a Zreg.  */
> +static bool do_clast_vector(DisasContext *s, arg_rprr_esz *a, bool before)
> +{
> +    if (!sve_access_check(s)) {
> +        return true;
> +    }
> +
> +    TCGv_i32 last = tcg_temp_local_new_i32();
> +    TCGLabel *over = gen_new_label();
> +    TCGv_i64 ele;
> +    unsigned vsz, esz = a->esz;

Declarations should be at the start of the block. (There's
another instance of this for the sve_access_check() in a
function below; please check other patches too.)


> +/* Compute CLAST for a Xreg.  */
> +static bool do_clast_general(DisasContext *s, arg_rpr_esz *a, bool before)
> +{
> +    if (!sve_access_check(s)) {
> +        return true;
> +    }
> +
> +    TCGv_i64 reg = cpu_reg(s, a->rd);
> +
> +    switch (a->esz) {
> +    case 0:
> +        tcg_gen_ext8u_i64(reg, reg);
> +        break;
> +    case 1:
> +        tcg_gen_ext16u_i64(reg, reg);
> +        break;
> +    case 2:
> +        tcg_gen_ext32u_i64(reg, reg);
> +        break;
> +    case 3:
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    do_clast_scalar(s, a->esz, a->pg, a->rn, before, cpu_reg(s, a->rd));

Why do we use cpu_reg() again here rather than just using 'reg' ?

> +    return true;
> +}
> +

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>


thanks
-- PMM
