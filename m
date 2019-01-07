Received: from eggs.gnu.org ([209.51.188.92]:41222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggV0D-000330-AY
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 08:31:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggV0C-0005xN-Iu
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 08:31:37 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39263)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggV08-0005mw-Pf
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 08:31:34 -0500
Received: by mail-oi1-x241.google.com with SMTP id i6so285449oia.6
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 05:31:32 -0800 (PST)
MIME-Version: 1.0
References: <20181214052410.11863-1-richard.henderson@linaro.org>
	<20181214052410.11863-23-richard.henderson@linaro.org>
In-Reply-To: <20181214052410.11863-23-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Jan 2019 13:31:20 +0000
Message-ID: <CAFEAcA-qLZu72eaaahdN8=qK79CRLwmAn3aMgOxCVc6Pq=fXww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 22/27] target/arm: Implement pauth_addpac
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

On Fri, 14 Dec 2018 at 05:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is not really functional yet, because the crypto is not yet
> implemented.  This, however follows the AddPAC pseudo function.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-a64.c | 40 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
> index 87cff7d96a..19486b9677 100644
> --- a/target/arm/helper-a64.c
> +++ b/target/arm/helper-a64.c
> @@ -1066,7 +1066,45 @@ static uint64_t pauth_computepac(uint64_t data, uint64_t modifier,
>  static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
>                               ARMPACKey *key, bool data)
>  {
> -    g_assert_not_reached(); /* FIXME */
> +    ARMMMUIdx mmu_idx = arm_stage1_mmu_idx(env);
> +    ARMVAParameters param = aa64_va_parameters(env, ptr, mmu_idx, data);
> +    uint64_t pac, ext_ptr, ext, test;
> +    int bot_bit, top_bit;
> +
> +    /* If tagged pointers are in use, use ptr<55>, otherwise ptr<63>.  */
> +    if (param.tbi) {
> +        ext = sextract64(ptr, 55, 1);
> +    } else {
> +        ext = sextract64(ptr, 63, 1);
> +    }
> +
> +    /* Build a pointer with known good extension bits.  */
> +    top_bit = 64 - 8 * param.tbi;
> +    bot_bit = 64 - param.tsz;
> +    ext_ptr = deposit64(ptr, bot_bit, top_bit - bot_bit, ext);
> +
> +    pac = pauth_computepac(ext_ptr, modifier, *key);
> +
> +    /* Check if the ptr has good extension bits and corrupt the
> +     * pointer authentication code if not.
> +     */

Newer checkpatch will grumble about this style of block
comment, by the way.

> +    test = sextract64(ptr, bot_bit, top_bit - bot_bit);
> +    if (test != 0 && test != -1) {
> +        pac ^= 1ull << (top_bit - 1);

MAKE_64BIT_MASK(top_bit - 1, 1) might be more consistent with
the code below ?

> +    }
> +
> +    /* Preserve the determination between upper and lower at bit 55,
> +     * and insert pointer authentication code.
> +     */
> +    if (param.tbi) {
> +        ptr &= ~MAKE_64BIT_MASK(bot_bit, 55 - bot_bit + 1);
> +        pac &= MAKE_64BIT_MASK(bot_bit, 54 - bot_bit + 1);
> +    } else {
> +        ptr &= MAKE_64BIT_MASK(0, bot_bit);
> +        pac &= ~(MAKE_64BIT_MASK(55, 1) | MAKE_64BIT_MASK(0, bot_bit));
> +    }
> +    ext &= MAKE_64BIT_MASK(55, 1);

I found this a bit confusing to disentangle and compare with
the pseudocode: the difference between the tbi and
not-tbi cases is only "what are bits 63:56 in the result",
but the implementation of how we put together bits 55:0 is
different in the two code paths here.

> +    return pac | ext | ptr;
>  }
>
>  static uint64_t pauth_original_ptr(uint64_t ptr, ARMVAParameters param)
> --
> 2.17.2

Anyway, the implementation is correct, so:

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
