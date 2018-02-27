Received: from eggs.gnu.org ([2001:4830:134:3::10]:48832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqg2O-0001BP-Ot
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:15:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqg2N-0005bt-Kq
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:15:24 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:46938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqg2N-0005bC-DL
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:15:23 -0500
Received: by mail-ot0-x241.google.com with SMTP id g97so3853267otg.13
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 06:15:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-52-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-52-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 14:15:02 +0000
Message-ID: <CAFEAcA8EbsNyfefQ05VKhsQ5sDW1PFqjw2pL6_YFm-pPTphSxw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 51/67] target/arm: Implement
 SVE load and broadcast element
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

On 17 February 2018 at 18:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    |  5 +++++
>  target/arm/sve_helper.c    | 43 ++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 55 +++++++++++++++++++++++++++++++++++++++++++++-
>  target/arm/sve.decode      |  5 +++++
>  4 files changed, 107 insertions(+), 1 deletion(-)
>

>
> +/* Load and broadcast element.  */
> +static void trans_LD1R_zpri(DisasContext *s, arg_rpri_load *a, uint32_t insn)
> +{
> +    unsigned vsz = vec_full_reg_size(s);
> +    unsigned psz = pred_full_reg_size(s);
> +    unsigned esz = dtype_esz[a->dtype];
> +    TCGLabel *over = gen_new_label();
> +    TCGv_i64 temp;
> +
> +    /* If the guarding predicate has no bits set, no load occurs.  */
> +    if (psz <= 8) {
> +        temp = tcg_temp_new_i64();
> +        tcg_gen_ld_i64(temp, cpu_env, pred_full_reg_offset(s, a->pg));
> +        tcg_gen_andi_i64(temp, temp,
> +                         deposit64(0, 0, psz * 8, pred_esz_masks[esz]));
> +        tcg_gen_brcondi_i64(TCG_COND_EQ, temp, 0, over);
> +        tcg_temp_free_i64(temp);
> +    } else {
> +        TCGv_i32 t32 = tcg_temp_new_i32();
> +        find_last_active(s, t32, esz, a->pg);
> +        tcg_gen_brcondi_i32(TCG_COND_LT, t32, 0, over);
> +        tcg_temp_free_i32(t32);
> +    }
> +
> +    /* Load the data.  */
> +    temp = tcg_temp_new_i64();
> +    tcg_gen_addi_i64(temp, cpu_reg_sp(s, a->rn), a->imm);

Isn't the immediate offset supposed to be scaled by mbytes ?

> +    tcg_gen_qemu_ld_i64(temp, temp, get_mem_index(s),
> +                        s->be_data | dtype_mop[a->dtype]);
> +
> +    /* Broadcast to *all* elements.  */
> +    tcg_gen_gvec_dup_i64(esz, vec_full_reg_offset(s, a->rd),
> +                         vsz, vsz, temp);
> +    tcg_temp_free_i64(temp);
> +
> +    /* Zero the inactive elements.  */
> +    gen_set_label(over);
> +    do_clr_inactive_zp(s, a->rd, a->pg, esz);
> +}
> +

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
