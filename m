Received: from eggs.gnu.org ([209.51.188.92]:33559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guHQw-0003bQ-L5
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:52:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guHQu-0003fk-Q8
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:52:10 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41799)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guHQs-0003az-St
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:52:08 -0500
Received: by mail-ot1-x342.google.com with SMTP id u16so10528881otk.8
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 05:52:05 -0800 (PST)
MIME-Version: 1.0
References: <20190206052857.5077-1-richard.henderson@linaro.org>
	<20190206052857.5077-4-richard.henderson@linaro.org>
In-Reply-To: <20190206052857.5077-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 13:51:53 +0000
Message-ID: <CAFEAcA9qRz_xyK=O8B8O3CnFkEpZwkwpXr37XeBJO-rg4rqyXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 3/3] target/arm: Implement ARMv8.3-JSConv
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

On Wed, 6 Feb 2019 at 05:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Return 0 for NaN
> ---

> +                /* The the fraction is shifted out entirely.  */

"The the"...

> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index eb25895876..a92d06b05b 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -4066,6 +4066,21 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
>                      case 17: /* fsito */
>                          gen_vfp_sito(dp, 0);
>                          break;
> +                    case 19: /* vjcvt */
> +                        if (!dp || !dc_isar_feature(aa32_jscvt, s)) {
> +                            return 1;
> +                        } else {
> +                            TCGv_ptr fpst = get_fpstatus_ptr(0);
> +                            gen_helper_fjcvtzs(cpu_F0d, cpu_F0d, fpst);
> +                            tcg_temp_free_ptr(fpst);
> +
> +                            tcg_gen_extr_i64_i32(cpu_F0s, cpu_ZF, cpu_F0d);
> +                            tcg_gen_movi_i32(cpu_NF, 0);
> +                            tcg_gen_movi_i32(cpu_CF, 0);
> +                            tcg_gen_movi_i32(cpu_VF, 0);
> +                            dp = 0; /* always a single precision result */
> +                        }

The AArch32 version of the instruction sets the NZCV bits in
the FPSCR, not the main PSTATE ones. (It passes Is64 == FALSE
to the pseudocode FPToFixedJS().)

> +                        break;
>                      case 20: /* fshto */
>                          if (!arm_dc_feature(s, ARM_FEATURE_VFP3)) {
>                              return 1;

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
