Received: from eggs.gnu.org ([2001:4830:134:3::10]:40938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPsn8-0006bN-Da
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 12:57:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPsn7-0000wt-JS
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 12:57:10 -0400
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:40684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fPsn7-0000wY-DX
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 12:57:09 -0400
Received: by mail-ot0-x234.google.com with SMTP id n1-v6so38505347otf.7
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 09:57:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180530180120.13355-9-richard.henderson@linaro.org>
References: <20180530180120.13355-1-richard.henderson@linaro.org>
	<20180530180120.13355-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Jun 2018 17:56:48 +0100
Message-ID: <CAFEAcA8=aALvwnD1DP4cL6CQpcji3=DJ8qDcmNbSFMbJ2kRVBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3b 08/18] target/arm: Implement SVE
 reverse within elements
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
>  target/arm/helper-sve.h    | 14 +++++++++++++
>  target/arm/sve_helper.c    | 41 +++++++++++++++++++++++++++++++-------
>  target/arm/translate-sve.c | 38 +++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      |  7 +++++++
>  4 files changed, 93 insertions(+), 7 deletions(-)

> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index 941a098234..f8579a25e3 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -238,6 +238,26 @@ static inline uint64_t expand_pred_s(uint8_t byte)
>      return word[byte & 0x11];
>  }
>
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
>  #define LOGICAL_PPPP(NAME, FUNC) \
>  void HELPER(NAME)(void *vd, void *vn, void *vm, void *vg, uint32_t desc)  \
>  {                                                                         \
> @@ -616,6 +636,20 @@ DO_ZPZ(sve_neg_h, uint16_t, H1_2, DO_NEG)
>  DO_ZPZ(sve_neg_s, uint32_t, H1_4, DO_NEG)
>  DO_ZPZ_D(sve_neg_d, uint64_t, DO_NEG)
>
> +DO_ZPZ(sve_revb_h, uint16_t, H1_2, bswap16)
> +DO_ZPZ(sve_revb_s, uint32_t, H1_4, bswap32)
> +DO_ZPZ_D(sve_revb_d, uint64_t, bswap64)
> +
> +DO_ZPZ(sve_revh_s, uint32_t, H1_4, hswap32)
> +DO_ZPZ_D(sve_revh_d, uint64_t, hswap64)
> +
> +DO_ZPZ_D(sve_revw_d, uint64_t, wswap64)
> +
> +DO_ZPZ(sve_rbit_b, uint8_t, H1, revbit8)
> +DO_ZPZ(sve_rbit_h, uint16_t, H1_2, revbit16)
> +DO_ZPZ(sve_rbit_s, uint32_t, H1_4, revbit32)
> +DO_ZPZ_D(sve_rbit_d, uint64_t, revbit64)
> +
>  /* Three-operand expander, unpredicated, in which the third operand is "wide".
>   */
>  #define DO_ZZW(NAME, TYPE, TYPEW, H, OP)                       \
> @@ -1587,13 +1621,6 @@ void HELPER(sve_rev_b)(void *vd, void *vn, uint32_t desc)
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

You added this in patch 2, I think -- you could avoid the code
motion here by putting it in the right place to start with.

>  void HELPER(sve_rev_h)(void *vd, void *vn, uint32_t desc)
>  {
>      intptr_t i, j, opr_sz = simd_oprsz(desc);

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
