Received: from eggs.gnu.org ([2001:4830:134:3::10]:40825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqhNr-0008SR-DF
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqhCs-0000Hg-3F
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:02:39 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:39508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqhCr-0000HQ-V0
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:02:34 -0400
Received: by mail-oi0-x244.google.com with SMTP id d189-v6so14821601oib.6
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 09:02:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180809042206.15726-6-richard.henderson@linaro.org>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
	<20180809042206.15726-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Aug 2018 17:02:12 +0100
Message-ID: <CAFEAcA_X5CM8Dbo8tm1KvbJ+6dWNw1UaPHwyzAC2PVpoj3FzWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 05/20] target/arm: Fix
 arm_cpu_data_is_big_endian for aa64 user-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Desnogues <laurent.desnogues@gmail.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 9 August 2018 at 05:21, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Unlike aa32, endianness cannot be adjusted by userland in aa64.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 9526ed27cb..2d6d7d03aa 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2709,8 +2709,6 @@ static inline bool arm_sctlr_b(CPUARMState *env)
>  /* Return true if the processor is in big-endian mode. */
>  static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
>  {
> -    int cur_el;
> -
>      /* In 32bit endianness is determined by looking at CPSR's E bit */
>      if (!is_a64(env)) {
>          return
> @@ -2729,15 +2727,24 @@ static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
>              arm_sctlr_b(env) ||
>  #endif
>                  ((env->uncached_cpsr & CPSR_E) ? 1 : 0);
> +    } else {
> +#ifdef CONFIG_USER_ONLY
> +        /* AArch64 does not have a SETEND instruction; endianness
> +         * for usermode is fixed at compile-time.
> +         */
> +# ifdef TARGET_WORDS_BIGENDIAN
> +        return true;
> +# else
> +        return false;
> +# endif
> +#else
> +        int cur_el = arm_current_el(env);
> +        if (cur_el == 0) {
> +            return (env->cp15.sctlr_el[1] & SCTLR_E0E) != 0;
> +        }
> +        return (env->cp15.sctlr_el[cur_el] & SCTLR_EE) != 0;
> +#endif
>      }
> -
> -    cur_el = arm_current_el(env);
> -
> -    if (cur_el == 0) {
> -        return (env->cp15.sctlr_el[1] & SCTLR_E0E) != 0;
> -    }
> -
> -    return (env->cp15.sctlr_el[cur_el] & SCTLR_EE) != 0;
>  }
>

When does this make a difference? For user-mode, we've already
dealt with the "aa32" case, so the code here is aa64-only.
In linux-user/aarch64/cpu_loop.c we set sctlr_el[1]'s E0E bit
if TARGET_WORDS_BIGENDIAN is defined, and cur_el is definitely
zero, so we should already be returning true from this function
if TARGET_WORDS_BIGENDIAN and false otherwise.

thanks
-- PMM
