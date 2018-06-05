Received: from eggs.gnu.org ([2001:4830:134:3::10]:49977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQFkI-0006hX-Q2
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 13:27:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQFkH-0004Er-Qc
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 13:27:46 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:35886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQFkH-0004EQ-KU
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 13:27:45 -0400
Received: by mail-oi0-x243.google.com with SMTP id 14-v6so2838641oie.3
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 10:27:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180530180120.13355-15-richard.henderson@linaro.org>
References: <20180530180120.13355-1-richard.henderson@linaro.org>
	<20180530180120.13355-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Jun 2018 18:27:24 +0100
Message-ID: <CAFEAcA_x8ojrswLGUwJ7iJ1voQf1Mr7qexv0NvnYRdfkanAUeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3b 14/18] target/arm: Implement SVE
 Predicate Count Group
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
>  target/arm/sve_helper.c    |  14 ++++
>  target/arm/translate-sve.c | 132 +++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      |  27 ++++++++
>  4 files changed, 175 insertions(+)

> +/*
> + *** SVE Predicate Count Group
> + */
> +
> +static void do_cntp(DisasContext *s, TCGv_i64 val, int esz, int pn, int pg)
> +{
> +    unsigned psz = pred_full_reg_size(s);
> +
> +    if (psz <= 8) {
> +        uint64_t psz_mask;
> +
> +        tcg_gen_ld_i64(val, cpu_env, pred_full_reg_offset(s, pn));
> +        if (pn != pg) {
> +            TCGv_i64 g = tcg_temp_new_i64();
> +            tcg_gen_ld_i64(g, cpu_env, pred_full_reg_offset(s, pg));
> +            tcg_gen_and_i64(val, val, g);
> +            tcg_temp_free_i64(g);
> +        }
> +
> +        /* Reduce the pred_esz_masks value simply to reduce the
> +           size of the code generated here.  */
> +        psz_mask = deposit64(0, 0, psz * 8, -1);

isn't this just psz_mask = MAKE_64BIT_MASK(0, psz * 8); ?

> +        tcg_gen_andi_i64(val, val, pred_esz_masks[esz] & psz_mask);
> +
> +        tcg_gen_ctpop_i64(val, val);
> +    } else {

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
