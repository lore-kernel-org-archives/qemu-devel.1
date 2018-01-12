Received: from eggs.gnu.org ([2001:4830:134:3::10]:43310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ea4E1-0002hG-Eg
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:38:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ea4E0-0000u6-DR
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:38:45 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:34853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ea4E0-0000tT-8m
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:38:44 -0500
Received: by mail-ot0-x241.google.com with SMTP id 53so5828760otj.2
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 10:38:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171218173022.18418-8-richard.henderson@linaro.org>
References: <20171218173022.18418-1-richard.henderson@linaro.org>
	<20171218173022.18418-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2018 18:38:23 +0000
Message-ID: <CAFEAcA-kbZRaGoERUG7iZGsO3hswC=ityDWf4n2fwXsSwO7jCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 7/9] target/arm: Expand vector registers
 for SVE
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

On 18 December 2017 at 17:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Change vfp.regs as a uint64_t to vfp.zregs as an ARMVectorReg.
> The previous patches have made the change in representation
> relatively painless.
>
> Add vfp.pregs as an ARMPredicateReg.  Let FFR be P16 to make
> it easier to treat it as for any other predicate.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h           | 64 ++++++++++++++++++++++++++++++++--------------
>  target/arm/machine.c       | 37 ++++++++++++++++++++++++++-
>  target/arm/translate-a64.c |  8 +++---
>  target/arm/translate.c     | 12 ++++-----
>  4 files changed, 90 insertions(+), 31 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index e1a8e2880d..150b0d9d84 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -153,6 +153,47 @@ typedef struct {
>      uint32_t base_mask;
>  } TCR;
>
> +/* Define a maximum sized vector register.
> + * For 32-bit, this is a 128-bit NEON/AdvSIMD register.
> + * For 64-bit, this is a 2048-bit SVE register.
> + *
> + * Note that the mapping between S, D, and Q views of the register bank
> + * differs between AArch64 and AArch32.
> + * In AArch32:
> + *  Qn = regs[n].d[1]:regs[n].d[0]
> + *  Dn = regs[n / 2].d[n & 1]
> + *  Sn = regs[n / 4].d[n % 4 / 2],
> + *       bits 31..0 for even n, and bits 63..32 for odd n
> + *       (and regs[16] to regs[31] are inaccessible)
> + * In AArch64:
> + *  Zn = regs[n].d[*]
> + *  Qn = regs[n].d[1]:regs[n].d[0]
> + *  Dn = regs[n].d[0]
> + *  Sn = regs[n].d[0] bits 31..0
> + *
> + * This corresponds to the architecturally defined mapping between
> + * the two execution states, and means we do not need to explicitly
> + * map these registers when changing states.
> + */

The transformations on the data structures (ie the meat of this patch
looks good).

> +
> +#ifdef TARGET_AARCH64
> +# define ARM_MAX_VQ    16
> +#else
> +# define ARM_MAX_VQ    1
> +#endif
> +
> +typedef struct ARMVectorReg {
> +    uint64_t d[2 * ARM_MAX_VQ] QEMU_ALIGNED(16);
> +} ARMVectorReg;
> +
> +typedef struct ARMPredicateReg {
> +#ifdef TARGET_AARCH64
> +    uint64_t p[2 * ARM_MAX_VQ / 8] QEMU_ALIGNED(16);
> +#else
> +    uint64_t p[0];
> +#endif
> +} ARMPredicateReg;

I think introducing the predicate registers should go in a separate
patch.

> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -1513,19 +1513,17 @@ static inline void gen_vfp_st(DisasContext *s, int dp, TCGv_i32 addr)
>      }
>  }
>
> -static inline long
> -vfp_reg_offset (int dp, int reg)
> +static inline long vfp_reg_offset(bool dp, unsigned reg)
>  {
>      if (dp) {
> -        return offsetof(CPUARMState, vfp.regs[reg]);
> +        return offsetof(CPUARMState, vfp.zregs[reg >> 1].d[reg & 1]);
>      } else {
> -        long ofs = offsetof(CPUARMState, vfp.regs[reg >> 1]);
> +        long r = offsetof(CPUARMState, vfp.zregs[reg >> 2].d[(reg >> 1) & 1]);
>          if (reg & 1) {
> -            ofs += offsetof(CPU_DoubleU, l.upper);
> +            return r + offsetof(CPU_DoubleU, l.upper);
>          } else {
> -            ofs += offsetof(CPU_DoubleU, l.lower);
> +            return r + offsetof(CPU_DoubleU, l.lower);
>          }
> -        return ofs;

...I see we're tweaking the logic on this code again. I was
expecting that the changes in the previous patch would have turned
out to be in support of just having to do a one-line change in this
one, but apparently not ?

>      }
>  }

thanks
-- PMM
