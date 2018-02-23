Received: from eggs.gnu.org ([2001:4830:134:3::10]:41057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epGQ8-0007II-HL
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:42:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epGQ7-0002Zv-KC
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:42:04 -0500
Received: from mail-pf0-x229.google.com ([2607:f8b0:400e:c00::229]:41550)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epGQ7-0002Xy-CT
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:42:03 -0500
Received: by mail-pf0-x229.google.com with SMTP id a17so3724916pff.8
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 08:42:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-39-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-39-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 16:41:31 +0000
Message-ID: <CAFEAcA8pcZL=zkjQBZjswznKdU6z4L7h5-So3Wwkwfpg++jPAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 38/67] target/arm: Implement
 SVE Partition Break Group
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
>  target/arm/helper-sve.h    |  18 ++++
>  target/arm/sve_helper.c    | 247 +++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c |  96 ++++++++++++++++++
>  target/arm/sve.decode      |  19 ++++
>  4 files changed, 380 insertions(+)


> +        b = g & n;            /* guard true, pred true*/

missing space before */

> +/* Given a computation function, compute a merging BRK.  */
> +static void compute_brk_m(uint64_t *d, uint64_t *n, uint64_t *g,
> +                          intptr_t oprsz, bool after)

Comment says "given a computation function" but the prototype
doesn't take a function as parameter ?

> +{
> +    bool brk = false;
> +    intptr_t i;
> +
> +    for (i = 0; i < DIV_ROUND_UP(oprsz, 8); ++i) {
> +        uint64_t this_b, this_g = g[i];
> +
> +        brk = compute_brk(&this_b, n[i], this_g, brk, after);
> +        d[i] = (this_b & this_g) | (d[i] & ~this_g);
> +    }
> +}
> +

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
