Received: from eggs.gnu.org ([2001:4830:134:3::10]:37925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb9mg-0001o6-DS
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:47:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb9mf-0006kQ-6I
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:47:02 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:35896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eb9mf-0006k2-1B
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:47:01 -0500
Received: by mail-oi0-x241.google.com with SMTP id w135so8945636oie.3
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 10:47:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171218172425.18200-11-richard.henderson@linaro.org>
References: <20171218172425.18200-1-richard.henderson@linaro.org>
	<20171218172425.18200-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2018 18:46:39 +0000
Message-ID: <CAFEAcA_bU-LWqtXL=2y_ztF4fCmr6WY0ruxFucXvUruQdKKtyA@mail.gmail.com>
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
>  static int disas_coproc_insn(DisasContext *s, uint32_t insn)
>  {
>      int cpnum, is64, crn, crm, opc1, opc2, isread, rt, rt2;
> @@ -8406,6 +8465,12 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>                      }
>                  }
>              }
> +        } else if ((insn & 0x0e000f10) == 0x0c000800) {

I think we should guard this with an ARM_FEATURE_V8 check, so
that for pre-v8 CPUs we fall back to the usual "treat it as a
coprocessor" codepath. (In theory it should work out the same
either way, but specifically limiting this to v8 makes it easier
to be sure that it's not changing the behaviour where it shouldn't.)

> +            /* ARMv8.3 neon ldc2/stc2 coprocessor 8 extension.  */
> +            if (disas_neon_insn_cp8_3same(s, insn)) {
> +                goto illegal_op;
> +            }

This doesn't seem to line up with the Arm ARM decode. Your
pattern and mask give
  op0 = 0x, op1 = 100, op2 = 0 and also bit 8 = 0.
The ARM has 3reg-same decoded with
  op0 = 0x, op1 = 1x0, op2 = x

(and some insns in the 3reg-same group have bit 8 == 1, like
VSDOT and VUDOT.)

> +            return;
>          } else if ((insn & 0x0fe00000) == 0x0c400000) {
>              /* Coprocessor double register transfer.  */
>              ARCH(5TE);

How are you proposing to do the Thumb decoding? Try to share
some of the 3same-vs-2reg+scalar decode part, or just have
them both do a similar kind of decode and call the
disas_neon_insn_cp8_3same/cp8_index functions?

thanks
-- PMM
