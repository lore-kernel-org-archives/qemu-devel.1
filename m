Received: from eggs.gnu.org ([2001:4830:134:3::10]:57061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqgTU-0007hx-IB
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:43:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqgTT-0003WC-ME
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:43:24 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:33584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqgTT-0003V1-G0
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:43:23 -0500
Received: by mail-oi0-x241.google.com with SMTP id j81so11087911oia.0
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 06:43:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-55-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-55-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 14:43:02 +0000
Message-ID: <CAFEAcA_w-KRu6-eu6iPQmro72URL13AvyMwCK0b3d1T-RKV1ag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 54/67] target/arm: Implement SVE
 prefetches
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
>  target/arm/translate-sve.c |  9 +++++++++
>  target/arm/sve.decode      | 23 +++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index ca49b94924..63c7a0e8d8 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -3958,3 +3958,12 @@ static void trans_ST1_zprz(DisasContext *s, arg_ST1_zprz *a, uint32_t insn)
>      do_mem_zpz(s, a->rd, a->pg, a->rm, a->scale * a->msz,
>                 cpu_reg_sp(s, a->rn), fn);
>  }
> +
> +/*
> + * Prefetches
> + */
> +
> +static void trans_PRF(DisasContext *s, arg_PRF *a, uint32_t insn)
> +{
> +    /* Prefetch is a nop within QEMU.  */
> +}
> diff --git a/target/arm/sve.decode b/target/arm/sve.decode
> index edd9340c02..f0144aa2d0 100644
> --- a/target/arm/sve.decode
> +++ b/target/arm/sve.decode
> @@ -801,6 +801,29 @@ LD1RQ_zprr 1010010 .. 00 ..... 000 ... ..... ..... \
>  LD1RQ_zpri     1010010 .. 00 0.... 001 ... ..... ..... \
>                 @rpri_load_msz nreg=0
>
> +# SVE 32-bit gather prefetch (scalar plus 32-bit scaled offsets)
> +PRF            1000010 00 -1 ----- 0-- --- ----- 0 ----
> +
> +# SVE 32-bit gather prefetch (vector plus immediate)
> +PRF            1000010 -- 00 ----- 111 --- ----- 0 ----
> +
> +# SVE contiguous prefetch (scalar plus immediate)
> +PRF            1000010 11 1- ----- 0-- --- ----- 0 ----
> +
> +# SVE contiguous prefetch (scalar plus scalar)
> +PRF            1000010 -- 00 ----- 110 --- ----- 0 ----

This one needs something slightly more complicated, because
Rm == 11111 has to be UnallocatedEncoding.

I checked the others and they don't have any unallocated cases
lurking in their decode pseudocode.

thanks
-- PMM
