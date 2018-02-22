Received: from eggs.gnu.org ([2001:4830:134:3::10]:56268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eow1t-0004jn-W5
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 13:55:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eow1t-0003Iq-1V
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 13:55:42 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:43981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eow1s-0003IV-RB
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 13:55:40 -0500
Received: by mail-oi0-x241.google.com with SMTP id a207so4459951oii.10
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 10:55:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-8-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 18:55:19 +0000
Message-ID: <CAFEAcA-PzKt-gZe2FjvqZuJqFmgoziNKaDLyen9o+hToMboQWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 07/67] target/arm: Implement
 SVE Predicate Logical Operations Group
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

> -void trans_PTEST(DisasContext *s, arg_PTEST *a, uint32_t insn)
> +static void trans_PTEST(DisasContext *s, arg_PTEST *a, uint32_t insn)
>  {

Should this be in a previous patch?

>      int nofs = pred_full_reg_offset(s, a->rn);
>      int gofs = pred_full_reg_offset(s, a->pg);
> diff --git a/target/arm/sve.decode b/target/arm/sve.decode
> index 7efaa8fe8e..d92886127a 100644
> --- a/target/arm/sve.decode
> +++ b/target/arm/sve.decode
> @@ -31,6 +31,7 @@
>
>  &rri           rd rn imm
>  &rrr_esz       rd rn rm esz
> +&rprr_s                rd pg rn rm s
>
>  ###########################################################################
>  # Named instruction formats.  These are generally used to
> @@ -39,6 +40,9 @@
>  # Three operand with unused vector element size
>  @rd_rn_rm_e0   ........ ... rm:5 ... ... rn:5 rd:5             &rrr_esz esz=0
>
> +# Three prediate operand, with governing predicate, flag setting

Three what?

> +@pd_pg_pn_pm_s ........ . s:1 .. rm:4 .. pg:4 . rn:4 . rd:4    &rprr_s
> +
>  # Basic Load/Store with 9-bit immediate offset
>  @pd_rn_i9      ........ ........ ...... rn:5 . rd:4    \
>                 &rri imm=%imm9_16_10
> @@ -56,6 +60,18 @@ ORR_zzz              00000100 01 1 ..... 001 100 ..... .....         @rd_rn_rm_e0
>  EOR_zzz                00000100 10 1 ..... 001 100 ..... .....         @rd_rn_rm_e0
>  BIC_zzz                00000100 11 1 ..... 001 100 ..... .....         @rd_rn_rm_e0
>
> +### SVE Predicate Logical Operations Group
> +
> +# SVE predicate logical operations
> +AND_pppp       00100101 0. 00 .... 01 .... 0 .... 0 ....       @pd_pg_pn_pm_s
> +BIC_pppp       00100101 0. 00 .... 01 .... 0 .... 1 ....       @pd_pg_pn_pm_s
> +EOR_pppp       00100101 0. 00 .... 01 .... 1 .... 0 ....       @pd_pg_pn_pm_s
> +SEL_pppp       00100101 0. 00 .... 01 .... 1 .... 1 ....       @pd_pg_pn_pm_s
> +ORR_pppp       00100101 1. 00 .... 01 .... 0 .... 0 ....       @pd_pg_pn_pm_s
> +ORN_pppp       00100101 1. 00 .... 01 .... 0 .... 1 ....       @pd_pg_pn_pm_s
> +NOR_pppp       00100101 1. 00 .... 01 .... 1 .... 0 ....       @pd_pg_pn_pm_s
> +NAND_pppp      00100101 1. 00 .... 01 .... 1 .... 1 ....       @pd_pg_pn_pm_s
> +
>  ### SVE Predicate Misc Group

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
