Received: from eggs.gnu.org ([2001:4830:134:3::10]:47174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQFTh-0000NM-U3
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 13:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQFTg-00035Z-U5
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 13:10:37 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:35197)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQFTg-000355-NW
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 13:10:36 -0400
Received: by mail-ot0-x241.google.com with SMTP id q17-v6so3724319otg.2
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 10:10:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180530180120.13355-14-richard.henderson@linaro.org>
References: <20180530180120.13355-1-richard.henderson@linaro.org>
	<20180530180120.13355-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Jun 2018 18:10:15 +0100
Message-ID: <CAFEAcA-OJhenKFwXtentkb-pgg87a_Lzf8WP6TuoVif-Uaj2tg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3b 13/18] target/arm: Implement SVE
 Partition Break Group
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
>  target/arm/helper-sve.h    |  18 +++
>  target/arm/sve_helper.c    | 247 +++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 106 ++++++++++++++++
>  target/arm/sve.decode      |  19 +++
>  4 files changed, 390 insertions(+)

> +static bool compute_brk(uint64_t *retb, uint64_t n, uint64_t g,
> +                        bool brk, bool after)
> +{
> +    uint64_t b;
> +
> +    if (brk) {
> +        b = 0;
> +    } else if ((g & n) == 0) {
> +        /* For all G, no N are set; break not found.  */
> +        b = g;
> +    } else {
> +        /* Break somewhere in N.  Locate it.  */
> +        b = g & n;            /* guard true, pred true*/

Missing space before '*/'.

> +        b = b & -b;           /* first such */
> +        if (after) {
> +            b = b | (b - 1);  /* break after same */
> +        } else {
> +            b = b - 1;        /* break before same */
> +        }
> +        brk = true;
> +    }
> +
> +    *retb = b;
> +    return brk;
> +}

> +
> +/* Given a computation function, compute a merging BRK.  */
> +static void compute_brk_m(uint64_t *d, uint64_t *n, uint64_t *g,
> +                          intptr_t oprsz, bool after)

Comment suggests function should take a function pointer argument,
but it doesn't ?

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

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
