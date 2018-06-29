Received: from eggs.gnu.org ([2001:4830:134:3::10]:45517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYhV9-0004IJ-1n
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 20:43:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYhV5-00045f-3R
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 20:43:03 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYhV4-00045E-UI
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 20:42:59 -0400
Received: by mail-qt0-x242.google.com with SMTP id z6-v6so6491583qti.2
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 17:42:58 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180629001538.11415-1-richard.henderson@linaro.org>
	<20180629001538.11415-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f1c13322-f941-937b-f28c-9352a676e494@amsat.org>
Date: Thu, 28 Jun 2018 21:42:54 -0300
MIME-Version: 1.0
In-Reply-To: <20180629001538.11415-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 06/28/2018 09:15 PM, Richard Henderson wrote:
> We already check for the same condition within the normal integer
> sdiv and sdiv64 helpers.  Use a slightly different formation that
> does not require deducing the expression type.
> 
> Fixes: f97cfd596ed
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
> 
