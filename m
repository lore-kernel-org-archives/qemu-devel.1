Received: from eggs.gnu.org ([2001:4830:134:3::10]:38816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb9pW-0003Iq-Mc
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:49:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb9pV-0007sV-K2
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:49:58 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:43582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eb9pV-0007s7-DQ
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:49:57 -0500
Received: by mail-ot0-x243.google.com with SMTP id p36so3417960otd.10
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 10:49:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171218172425.18200-11-richard.henderson@linaro.org>
References: <20171218172425.18200-1-richard.henderson@linaro.org>
	<20171218172425.18200-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2018 18:49:36 +0000
Message-ID: <CAFEAcA9TEUfY3oDzWxouG5J5AKBWPoHwfcY+yuO0K+X_K_u7wQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 10/11] target/arm: Decode aa32 armv8.3
 3-same
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

On 18 December 2017 at 17:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 1a0b0eaced..e57844c019 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -7662,6 +7662,65 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
>      return 0;
>  }
>
> +/* ARMv8.3 reclaims a portion of the LDC2/STC2 coprocessor 8 space.  */
> +
> +static int disas_neon_insn_cp8_3same(DisasContext *s, uint32_t insn)
> +{
> +    void (*fn_gvec_ptr)(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_i32);
> +    int rd, rn, rm, rot, size, opr_sz;
> +    TCGv_ptr fpst;
> +    bool q;
> +
> +    /* FIXME: this access check should not take precedence over UNDEF
> +     * for invalid encodings; we will generate incorrect syndrome information
> +     * for attempts to execute invalid vfp/neon encodings with FP disabled.
> +     */

(Forgot this bit before hitting send on the other email...)

Unlike the sprawling disas_vfp_insn(), we're in a position to get the
order of checks right here. Just move it and the vfp_enabled test a
bit further down...

> +    if (s->fp_excp_el) {
> +        gen_exception_insn(s, 4, EXCP_UDEF,
> +                           syn_fp_access_trap(1, 0xe, false), s->fp_excp_el);
> +        return 0;
> +    }
> +    if (!s->vfp_enabled) {
> +        return 1;
> +    }
> +    if (!arm_dc_feature(s, ARM_FEATURE_V8_FCMA)) {
> +        return 1;
> +    }
> +
> +    q = extract32(insn, 6, 1);
> +    size = extract32(insn, 20, 1);
> +    VFP_DREG_D(rd, insn);
> +    VFP_DREG_N(rn, insn);
> +    VFP_DREG_M(rm, insn);
> +    if ((rd | rn | rm) & q) {
> +        return 1;
> +    }
> +
> +    if (extract32(insn, 21, 1)) {
> +        /* VCMLA */
> +        rot = extract32(insn, 23, 2);
> +        fn_gvec_ptr = size ? gen_helper_gvec_fcmlas : gen_helper_gvec_fcmlah;
> +    } else if (extract32(insn, 23, 1)) {
> +        /* VCADD */
> +        rot = extract32(insn, 24, 1);
> +        fn_gvec_ptr = size ? gen_helper_gvec_fcadds : gen_helper_gvec_fcaddh;
> +    } else {
> +        /* Assuming the register fields remain, only bit 24 remains undecoded:
> +         * 1111_110x_0d0s_nnnn_dddd_1000_nqm0_mmmm
> +         */
> +        return 1;
> +    }

...to here.

> +
> +    opr_sz = (1 + q) * 8;
> +    fpst = get_fpstatus_ptr(1);
> +    tcg_gen_gvec_3_ptr(vfp_reg_offset(1, rd),
> +                       vfp_reg_offset(1, rn),
> +                       vfp_reg_offset(1, rm), fpst,
> +                       opr_sz, opr_sz, rot, fn_gvec_ptr);
> +    tcg_temp_free_ptr(fpst);
> +    return 0;
> +}
> +

thanks
-- PMM
