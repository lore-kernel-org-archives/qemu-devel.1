Received: from eggs.gnu.org ([2001:4830:134:3::10]:48125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8NJ6-0005q8-SX
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 05:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8NJ5-0002qW-3g
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 05:53:48 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:37805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f8NJ4-0002jt-Pr
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 05:53:46 -0400
Received: by mail-oi0-x242.google.com with SMTP id f63-v6so17356148oic.4
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 02:53:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180417025328.25431-3-richard.henderson@linaro.org>
References: <20180417025328.25431-1-richard.henderson@linaro.org>
	<20180417025328.25431-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Apr 2018 10:53:25 +0100
Message-ID: <CAFEAcA_0FFbh-jCc4wMGvVdYxNS+a-K6fnn4VozughY5OJj=RQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/2] fpu: Bound increment for scalbn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 17 April 2018 at 03:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Without bounding the increment, we can overflow exp either here
> in scalbn_decomposed or when adding the bias in round_canonical.
> This can result in e.g. underflowing to 0 instead of overflowing
> to infinity.
>
> The old softfloat code did bound the increment.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  fpu/softfloat.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index ba6e654050..a589f328c9 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -1883,6 +1883,12 @@ static FloatParts scalbn_decomposed(FloatParts a, int n, float_status *s)
>          return return_nan(a, s);
>      }
>      if (a.cls == float_class_normal) {
> +        /* The largest float type (even though not supported by FloatParts)
> +         * is float128, which has a 15 bit exponent.  Bounding N to 16 bits
> +         * still allows rounding to infinity, without allowing overflow
> +         * within the int32_t that backs FloatParts.exp.
> +         */
> +        n = MIN(MAX(n, -0x10000), 0x10000);
>          a.exp += n;
>      }
>      return a;
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
