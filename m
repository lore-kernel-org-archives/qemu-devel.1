Received: from eggs.gnu.org ([2001:4830:134:3::10]:38239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqfQu-0001EC-2I
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:36:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqfQt-0007Cs-5r
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:36:40 -0500
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:36995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqfQt-0007Bs-0R
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:36:39 -0500
Received: by mail-ot0-x22d.google.com with SMTP id t2so3776308otj.4
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 05:36:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-47-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-47-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 13:36:17 +0000
Message-ID: <CAFEAcA8e_Co6raEiq876ByLnkin1Vbv4-Xa6krGG1MRgbVCuzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 46/67] target/arm: Implement
 SVE load and broadcast quadword
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
>  target/arm/translate-sve.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      |  9 ++++++++
>  2 files changed, 60 insertions(+)

> +static void trans_LD1RQ_zprr(DisasContext *s, arg_rprr_load *a, uint32_t insn)
> +{
> +    TCGv_i64 addr;
> +    int msz = dtype_msz(a->dtype);
> +
> +    if (a->rm == 31) {
> +        unallocated_encoding(s);
> +        return;
> +    }
> +
> +    addr = new_tmp_a64(s);
> +    tcg_gen_shli_i64(addr, cpu_reg(s, a->rm), msz);
> +    tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, a->rn));
> +    do_ldrq(s, a->rd, a->pg, addr, msz);
> +}
> +
> +static void trans_LD1RQ_zpri(DisasContext *s, arg_rpri_load *a, uint32_t insn)
> +{
> +    TCGv_i64 addr = new_tmp_a64(s);
> +
> +    tcg_gen_addi_i64(addr, cpu_reg_sp(s, a->rn), a->imm * 16);

It confused me initially here that the calculation of the offset
for the +immediate and the +scalar cases isn't the same, but that
is indeed what the architecture does. Maybe
       /* Unlike LD1RQ_zprr, offset scaling is constant rather
        * than based on msz.
        */
?

> +    do_ldrq(s, a->rd, a->pg, addr, dtype_msz(a->dtype));
> +}
>

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
