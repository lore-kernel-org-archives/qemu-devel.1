Received: from eggs.gnu.org ([2001:4830:134:3::10]:34605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNLBZ-00062L-DK
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNLBY-0005Eu-BG
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:35:21 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:35253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dNLBY-0005Co-3A
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:35:20 -0400
Received: by mail-wr0-x236.google.com with SMTP id y25so56578823wrd.2
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 08:35:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170425180609.11004-1-krzk@kernel.org>
References: <20170425180609.11004-1-krzk@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2017 16:34:57 +0100
Message-ID: <CAFEAcA8PjjUk6QrAE6ppgyYsYAyh+0uqd=_EgH-g4K=--utdoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] hw/misc: Add Exynos4210 Pseudo Random
 Number Generator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 25 April 2017 at 19:06, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Add emulation for Exynos4210 Pseudo Random Number Generator which could
> work on fixed seeds or with seeds provided by True Random Number
> Generator block inside the SoC.
>
> Implement only the fixed seeds part of it in polling mode (no
> interrupts).
>
> Emulation tested with two independent Linux kernel exynos-rng drivers:
> 1. New kcapi-rng interface (targeting Linux v4.12),
> 2. Old hwrng inteface
>    # echo "exynos" > /sys/class/misc/hw_random/rng_current
>    # dd if=/dev/hwrng of=/dev/null bs=1 count=16
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Changes since v2:
> 1. Drop GRand in favor of qcrypto_random_bytes() after discussion with
>    Peter Maydell.
> 2. Because of above, ignore the seed value but mark if each one of five
>    seed registers were seeded.
> 3. Fix memset of s->randr_value (copy paste error, also shorter sizeof
>    can be used).
>
> Changes since v1:
> 1. Use GRand-like functions to fix build on MingW32 (this adds also
>    finalize).
> 2. Add DPRINTF macro.
> 3. Use HWADDR_PRIx and family for printing values.
> ---

> +#define EXYNOS4210_RNG_STATUS_WRITE_MASK        (EXYNOS4210_RNG_STATUS_PRNG_DONE \
> +                                                    | EXYNOS4210_RNG_STATUS_MSG_DONE \
> +                                                    | EXYNOS4210_RNG_STATUS_PARTIAL_DONE)
> +
> +#define EXYNOS4210_RNG_CONTROL_1                  0x0
> +#define EXYNOS4210_RNG_STATUS                    0x10
> +#define EXYNOS4210_RNG_SEED_IN                  0x140
> +#define EXYNOS4210_RNG_SEED_IN_OFFSET(n)        (EXYNOS4210_RNG_SEED_IN + (n * 0x4))
> +#define EXYNOS4210_RNG_PRNG                     0x160
> +#define EXYNOS4210_RNG_PRNG_OFFSET(n)           (EXYNOS4210_RNG_PRNG + (n * 0x4))

Some of these lines are slightly overlong.

> +
> +#define EXYNOS4210_RNG_PRNG_NUM                 5
> +
> +#define EXYNOS4210_RNG_REGS_MEM_SIZE            0x200
> +
> +typedef struct Exynos4210RngState {
> +    SysBusDevice parent_obj;
> +    MemoryRegion iomem;
> +
> +    int32_t randr_value[EXYNOS4210_RNG_PRNG_NUM];
> +    /* bits from 0 to EXYNOS4210_RNG_PRNG_NUM if given seed register was set */
> +    uint32_t seed_set;
> +
> +    /* Register values */
> +    uint32_t reg_control;
> +    uint32_t reg_status;
> +} Exynos4210RngState;
> +
> +static bool exynos4210_rng_seed_ready(const Exynos4210RngState *s)
> +{
> +    unsigned int i;
> +
> +    for (i = 0; i < EXYNOS4210_RNG_PRNG_NUM; i++) {
> +        if ((s->seed_set & BIT(i)) == 0) {
> +            return false;
> +        }
> +    }
> +
> +    return true;

This can be more efficiently written as:

    uint32_t mask = MAKE_64BIT_MASK(0, EXYNOS4210_RNG_PRNG_NUM);

    /* Return true if all the seed-set bits are set. */
    return (s->seed_set & mask) == mask;


Unless you object, I propose to make those minor tweaks
locally and commit to target-arm.next, rather than making
you spin another version of this.

thanks
-- PMM
