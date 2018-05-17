Received: from eggs.gnu.org ([2001:4830:134:3::10]:56325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJLI8-0007n8-32
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:58:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJLI7-0000jc-8E
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:58:08 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:38197)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fJLI7-0000jL-2W
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:58:07 -0400
Received: by mail-oi0-x244.google.com with SMTP id k17-v6so4444103oih.5
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 08:58:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180516223007.10256-27-richard.henderson@linaro.org>
References: <20180516223007.10256-1-richard.henderson@linaro.org>
	<20180516223007.10256-27-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 May 2018 16:57:45 +0100
Message-ID: <CAFEAcA-Erv++skS73s6_ZCWbo=G6xLaE69wukUKyX3-KyuV=oA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3-a 26/27] target/arm: Extend
 vec_reg_offset to larger sizes
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

On 16 May 2018 at 23:30, Richard Henderson <richard.henderson@linaro.org> wrote:
> Rearrange the arithmetic so that we are agnostic about the total size
> of the vector and the size of the element.  This will allow us to index
> up to the 32nd byte and with 16-byte elements.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
> index dd9c09f89b..5a97ae2b59 100644
> --- a/target/arm/translate-a64.h
> +++ b/target/arm/translate-a64.h
> @@ -67,18 +67,18 @@ static inline void assert_fp_access_checked(DisasContext *s)
>  static inline int vec_reg_offset(DisasContext *s, int regno,
>                                   int element, TCGMemOp size)
>  {
> -    int offs = 0;
> +    int element_size = 1 << size;
> +    int offs = element * element_size;
>  #ifdef HOST_WORDS_BIGENDIAN
>      /* This is complicated slightly because vfp.zregs[n].d[0] is
>       * still the low half and vfp.zregs[n].d[1] the high half
>       * of the 128 bit vector, even on big endian systems.
> -     * Calculate the offset assuming a fully bigendian 128 bits,
> -     * then XOR to account for the order of the two 64 bit halves.
> +     * Calculate the offset assuming a fully little-endian 128 bits,
> +     * then XOR to account for the order of the 64 bit units.
>       */
> -    offs += (16 - ((element + 1) * (1 << size)));
> -    offs ^= 8;
> -#else
> -    offs += element * (1 << size);
> +    if (element_size < 8) {
> +        offs ^= 8 - element_size;
> +    }
>  #endif
>      offs += offsetof(CPUARMState, vfp.zregs[regno]);
>      assert_fp_access_checked(s);

This looks right for element sizes up to 8, but I don't understand
how it handles 16 byte elements as the commit message says -- the
d[0] and d[1] are the wrong way round and don't form a single
16-byte big-endian value, so they must need special casing somewhere
else ?

thanks
-- PMM
