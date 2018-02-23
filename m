Received: from eggs.gnu.org ([2001:4830:134:3::10]:48974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epFcH-0007ar-T3
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:50:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epFcH-0004NB-5W
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:50:33 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:41073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epFcG-0004MC-Uu
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:50:33 -0500
Received: by mail-pg0-x243.google.com with SMTP id q27so1903358pgn.8
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 07:50:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-34-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-34-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 15:50:11 +0000
Message-ID: <CAFEAcA_RcXrciEx5BG=XoW=ygCQJ-QOVFJ8fNEW=BNCX3PFENQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 33/67] target/arm: Implement
 SVE reverse within elements
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
>  target/arm/helper-sve.h    | 14 ++++++++++++++
>  target/arm/sve_helper.c    | 41 ++++++++++++++++++++++++++++++++++-------
>  target/arm/translate-sve.c | 38 ++++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      |  7 +++++++
>  4 files changed, 93 insertions(+), 7 deletions(-)

> +/* Swap 16-bit words within a 32-bit word.  */
> +static inline uint32_t hswap32(uint32_t h)
> +{
> +    return rol32(h, 16);
> +}
> +
> +/* Swap 16-bit words within a 64-bit word.  */
> +static inline uint64_t hswap64(uint64_t h)
> +{
> +    uint64_t m = 0x0000ffff0000ffffull;
> +    h = rol64(h, 32);
> +    return ((h & m) << 16) | ((h >> 16) & m);
> +}
> +
> +/* Swap 32-bit words within a 64-bit word.  */
> +static inline uint64_t wswap64(uint64_t h)
> +{
> +    return rol64(h, 32);
> +}
> +

Were there cases in earlier patches that could have used these? I forget.
I guess they're not useful enough to be worth putting in bswap.h.

> @@ -1577,13 +1611,6 @@ void HELPER(sve_rev_b)(void *vd, void *vn, uint32_t desc)
>      }
>  }
>
> -static inline uint64_t hswap64(uint64_t h)
> -{
> -    uint64_t m = 0x0000ffff0000ffffull;
> -    h = rol64(h, 32);
> -    return ((h & m) << 16) | ((h >> 16) & m);
> -}
> -

Better to put the function in the right place to start with.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
