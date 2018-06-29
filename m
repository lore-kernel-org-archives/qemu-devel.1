Received: from eggs.gnu.org ([2001:4830:134:3::10]:58742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYon6-0001b9-JK
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:30:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYon5-0001y9-G9
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:30:04 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:40851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYon5-0001vs-Ae
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:30:03 -0400
Received: by mail-oi0-x241.google.com with SMTP id w126-v6so455660oie.7
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 01:30:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180629001538.11415-2-richard.henderson@linaro.org>
References: <20180629001538.11415-1-richard.henderson@linaro.org>
	<20180629001538.11415-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 09:29:42 +0100
Message-ID: <CAFEAcA8MtK93KV5ZHchUP3H+bx4eANnjndU__xrGSBZDXsXnGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/6] target/arm: Fix SVE signed division vs
 x86 overflow exception
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

On 29 June 2018 at 01:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
> We already check for the same condition within the normal integer
> sdiv and sdiv64 helpers.  Use a slightly different formation that
> does not require deducing the expression type.
>
> Fixes: f97cfd596ed
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/sve_helper.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index 790cbacd14..7d7fc90566 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -369,7 +369,13 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *vg, uint32_t desc) \
>  #define DO_MIN(N, M)  ((N) >= (M) ? (M) : (N))
>  #define DO_ABD(N, M)  ((N) >= (M) ? (N) - (M) : (M) - (N))
>  #define DO_MUL(N, M)  (N * M)
> -#define DO_DIV(N, M)  (M ? N / M : 0)
> +
> +/* The zero divisor case is architectural; the -1 divisor case works
> + * around the x86 INT_MIN / -1 overflow exception without having to
> + * deduce the minimum integer for the type of the expression.
> + */

It works around INT_MIN / -1 being C undefined behaviour: the
need to special-case this is not x86-specific... The required
answer for Arm is just as architectural as the required answer
for division-by-zero (which is also C UB).

> +#define DO_SDIV(N, M) (unlikely(M == 0) ? 0 : unlikely(M == -1) ? -N : N / M)
> +#define DO_UDIV(N, M) (unlikely(M == 0) ? 0 : N / M)
>
>  DO_ZPZZ(sve_and_zpzz_b, uint8_t, H1, DO_AND)
>  DO_ZPZZ(sve_and_zpzz_h, uint16_t, H1_2, DO_AND)
> @@ -477,11 +483,11 @@ DO_ZPZZ(sve_umulh_zpzz_h, uint16_t, H1_2, do_mulh_h)
>  DO_ZPZZ(sve_umulh_zpzz_s, uint32_t, H1_4, do_mulh_s)
>  DO_ZPZZ_D(sve_umulh_zpzz_d, uint64_t, do_umulh_d)
>
> -DO_ZPZZ(sve_sdiv_zpzz_s, int32_t, H1_4, DO_DIV)
> -DO_ZPZZ_D(sve_sdiv_zpzz_d, int64_t, DO_DIV)
> +DO_ZPZZ(sve_sdiv_zpzz_s, int32_t, H1_4, DO_SDIV)
> +DO_ZPZZ_D(sve_sdiv_zpzz_d, int64_t, DO_SDIV)
>
> -DO_ZPZZ(sve_udiv_zpzz_s, uint32_t, H1_4, DO_DIV)
> -DO_ZPZZ_D(sve_udiv_zpzz_d, uint64_t, DO_DIV)
> +DO_ZPZZ(sve_udiv_zpzz_s, uint32_t, H1_4, DO_UDIV)
> +DO_ZPZZ_D(sve_udiv_zpzz_d, uint64_t, DO_UDIV)
>
>  /* Note that all bits of the shift are significant
>     and not modulo the element size.  */

Other than quibbling about the comment,
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
