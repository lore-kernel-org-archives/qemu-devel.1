Received: from eggs.gnu.org ([2001:4830:134:3::10]:50172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXVAL-00084W-E1
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXVAK-0001rZ-Ep
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:20:37 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:34317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXVAK-0001qs-9B
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:20:36 -0400
Received: by mail-oi0-x244.google.com with SMTP id c2-v6so1571801oic.1
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 10:20:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621015359.12018-17-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-17-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Jun 2018 18:20:15 +0100
Message-ID: <CAFEAcA_-cZ6gqRf+dz1EXQthXo7bgKHzYxvVGh1HxmUVEaCRhg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 16/35] target/arm: Implement SVE
 floating-point compare vectors
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

On 21 June 2018 at 02:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    | 49 ++++++++++++++++++++++++++++++
>  target/arm/sve_helper.c    | 62 ++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 40 ++++++++++++++++++++++++
>  target/arm/sve.decode      | 11 +++++++
>  4 files changed, 162 insertions(+)


> +#define DO_FCMGE(TYPE, X, Y, ST)  TYPE##_compare(Y, X, ST) <= 0

I was expecting the RHS of this to be TYPE##_le(Y, X, ST).
This prompted me to notice that softfloat has as well as
the generic 'compare' routines also specialized _le/lt/unordered
etc functions for float64 and float32 but not float16, which is
a bit inconsistent...

> +#define DO_FCMGT(TYPE, X, Y, ST)  TYPE##_compare(Y, X, ST) < 0
> +#define DO_FCMEQ(TYPE, X, Y, ST)  TYPE##_compare_quiet(X, Y, ST) == 0
> +#define DO_FCMNE(TYPE, X, Y, ST)  TYPE##_compare_quiet(X, Y, ST) != 0
> +#define DO_FCMUO(TYPE, X, Y, ST)  \
> +    TYPE##_compare_quiet(X, Y, ST) == float_relation_unordered
> +#define DO_FACGE(TYPE, X, Y, ST)  \
> +    TYPE##_compare(TYPE##_abs(Y), TYPE##_abs(X), ST) <= 0
> +#define DO_FACGT(TYPE, X, Y, ST)  \
> +    TYPE##_compare(TYPE##_abs(Y), TYPE##_abs(X), ST) < 0

Anyway,
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
