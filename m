Received: from eggs.gnu.org ([2001:4830:134:3::10]:38664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqh1R-0004FT-SX
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:18:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqh1Q-00071v-LZ
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:18:29 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:45336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqh1Q-00071g-GR
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:18:28 -0500
Received: by mail-ot0-x244.google.com with SMTP id f11so4058680otj.12
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 07:18:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-60-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-60-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 15:18:07 +0000
Message-ID: <CAFEAcA_q6Ca5JT-850hR43sSmPinvvb6W_s0y8mVyjyaHGeFdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 59/67] target/arm: Implement
 SVE Floating Point Multiply Indexed Group
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
>  target/arm/helper.h        | 14 ++++++++++
>  target/arm/translate-sve.c | 44 +++++++++++++++++++++++++++++++
>  target/arm/vec_helper.c    | 64 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      | 19 ++++++++++++++
>  4 files changed, 141 insertions(+)

> diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
> index ad5c29cdd5..e711a3217d 100644
> --- a/target/arm/vec_helper.c
> +++ b/target/arm/vec_helper.c
> @@ -24,6 +24,22 @@
>  #include "fpu/softfloat.h"
>
>
> +/* Note that vector data is stored in host-endian 64-bit chunks,
> +   so addressing units smaller than that needs a host-endian fixup.  */
> +#ifdef HOST_WORDS_BIGENDIAN
> +#define H1(x)   ((x) ^ 7)
> +#define H1_2(x) ((x) ^ 6)
> +#define H1_4(x) ((x) ^ 4)
> +#define H2(x)   ((x) ^ 3)
> +#define H4(x)   ((x) ^ 1)
> +#else
> +#define H1(x)   (x)
> +#define H1_2(x) (x)
> +#define H1_4(x) (x)
> +#define H2(x)   (x)
> +#define H4(x)   (x)
> +#endif
> +

I wasn't expecting to see these macros here. Don't we have them already?

Anyway
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
