Received: from eggs.gnu.org ([2001:4830:134:3::10]:60404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epGEE-0000dB-6Y
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:29:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epGED-0005rw-2C
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:29:46 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:34773)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epGEC-0005rP-LE
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:29:44 -0500
Received: by mail-pg0-x243.google.com with SMTP id m19so3549102pgn.1
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 08:29:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-37-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-37-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 16:29:22 +0000
Message-ID: <CAFEAcA8mvCXMEBv+dLwVfQcdEeyaqSfK9EX1HzQOKfQi8+Tk2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 36/67] target/arm: Implement SVE Integer
 Compare - Vectors Group
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

> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index 86cd792cdf..ae433861f8 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -46,14 +46,14 @@
>   *
>   * The return value has bit 31 set if N is set, bit 1 set if Z is clear,
>   * and bit 0 set if C is set.
> - *
> - * This is an iterative function, called for each Pd and Pg word
> - * moving forward.
>   */
>
>  /* For no G bits set, NZCV = C.  */
>  #define PREDTEST_INIT  1
>
> +/* This is an iterative function, called for each Pd and Pg word
> + * moving forward.
> + */

Why move this comment?

>  static uint32_t iter_predtest_fwd(uint64_t d, uint64_t g, uint32_t flags)
>  {
>      if (likely(g)) {
> @@ -73,6 +73,28 @@ static uint32_t iter_predtest_fwd(uint64_t d, uint64_t g, uint32_t flags)
>      return flags;
>  }
>
> +/* This is an iterative function, called for each Pd and Pg word
> + * moving backward.
> + */
> +static uint32_t iter_predtest_bwd(uint64_t d, uint64_t g, uint32_t flags)
> +{
> +    if (likely(g)) {
> +        /* Compute C from first (i.e last) !(D & G).
> +           Use bit 2 to signal first G bit seen.  */
> +        if (!(flags & 4)) {
> +            flags += 4 - 1; /* add bit 2, subtract C from PREDTEST_INIT */
> +            flags |= (d & pow2floor(g)) == 0;
> +        }
> +
> +        /* Accumulate Z from each D & G.  */
> +        flags |= ((d & g) != 0) << 1;
> +
> +        /* Compute N from last (i.e first) D & G.  Replace previous.  */
> +        flags = deposit32(flags, 31, 1, (d & (g & -g)) != 0);
> +    }
> +    return flags;
> +}
> +
>  /* The same for a single word predicate.  */
>  uint32_t HELPER(sve_predtest1)(uint64_t d, uint64_t g)
>  {
> @@ -2180,3 +2202,168 @@ void HELPER(sve_sel_zpzz_d)(void *vd, void *vn, void *vm,
>          d[i] = (pg[H1(i)] & 1 ? nn : mm);
>      }
>  }
> +
> +/* Two operand comparison controlled by a predicate.
> + * ??? It is very tempting to want to be able to expand this inline
> + * with x86 instructions, e.g.
> + *
> + *    vcmpeqw    zm, zn, %ymm0
> + *    vpmovmskb  %ymm0, %eax
> + *    and        $0x5555, %eax
> + *    and        pg, %eax
> + *
> + * or even aarch64, e.g.
> + *
> + *    // mask = 4000 1000 0400 0100 0040 0010 0004 0001
> + *    cmeq       v0.8h, zn, zm
> + *    and        v0.8h, v0.8h, mask
> + *    addv       h0, v0.8h
> + *    and        v0.8b, pg
> + *
> + * However, coming up with an abstraction that allows vector inputs and
> + * a scalar output, and also handles the byte-ordering of sub-uint64_t
> + * scalar outputs, is tricky.
> + */
> +#define DO_CMP_PPZZ(NAME, TYPE, OP, H, MASK)                                 \
> +uint32_t HELPER(NAME)(void *vd, void *vn, void *vm, void *vg, uint32_t desc) \
> +{                                                                            \
> +    intptr_t opr_sz = simd_oprsz(desc);                                      \
> +    uint32_t flags = PREDTEST_INIT;                                          \
> +    intptr_t i = opr_sz;                                                     \
> +    do {                                                                     \
> +        uint64_t out = 0, pg;                                                \
> +        do {                                                                 \
> +            i -= sizeof(TYPE), out <<= sizeof(TYPE);                         \
> +            TYPE nn = *(TYPE *)(vn + H(i));                                  \
> +            TYPE mm = *(TYPE *)(vm + H(i));                                  \
> +            out |= nn OP mm;                                                 \
> +        } while (i & 63);                                                    \
> +        pg = *(uint64_t *)(vg + (i >> 3)) & MASK;                            \
> +        out &= pg;                                                           \
> +        *(uint64_t *)(vd + (i >> 3)) = out;                                  \
> +        flags = iter_predtest_bwd(out, pg, flags);                           \
> +    } while (i > 0);                                                         \
> +    return flags;                                                            \
> +}

Why do we iterate backwards through the vector? As far as I can
see the pseudocode iterates forwards, and I don't think it
makes a difference to the result which way we go.


Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
