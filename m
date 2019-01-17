Received: from eggs.gnu.org ([209.51.188.92]:49009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkEFB-0003MR-Mb
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:26:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkEF7-0003Gc-Jm
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:26:29 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkEF3-0003DX-Rb
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:26:25 -0500
Received: by mail-pg1-x541.google.com with SMTP id s198so4946478pgs.2
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 12:26:20 -0800 (PST)
References: <20181211151945.29137-1-aaron@os.amperecomputing.com>
	<20181211151945.29137-15-aaron@os.amperecomputing.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8683c2c4-0111-492c-c6f9-1b2dcc937405@linaro.org>
Date: Fri, 18 Jan 2019 07:26:11 +1100
MIME-Version: 1.0
In-Reply-To: <20181211151945.29137-15-aaron@os.amperecomputing.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v10 14/14] target/arm: Send interrupts on
 PMU counter overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <aaron@os.amperecomputing.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <alindsay@codeaurora.org>

On 12/12/18 2:20 AM, Aaron Lindsay wrote:
> Setup a QEMUTimer to get a callback when we expect counters to next
> overflow and trigger an interrupt at that time.
> 
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
> ---
>  target/arm/cpu.c    |  12 +++++
>  target/arm/cpu.h    |   8 +++
>  target/arm/helper.c | 126 +++++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 140 insertions(+), 6 deletions(-)

Well, this patch is doing several things at once -- adding the timer, adding
the ns_per_count hook, updating irqs.  Not ideal, but I won't insist it be split.

You'll need to re-run against scripts/checkpatch, it would seem.
The goal-posts with respect to comments have been changed since
you started this.


> @@ -1305,7 +1338,19 @@ void pmccntr_op_start(CPUARMState *env)
>              eff_cycles /= 64;
>          }
>  
> -        env->cp15.c15_ccnt = eff_cycles - env->cp15.c15_ccnt_delta;
> +        uint64_t new_pmccntr = eff_cycles - env->cp15.c15_ccnt_delta;
> +
> +        unsigned int overflow_bit = (env->cp15.c9_pmcr & PMCRLC) ? 63 : 31;
> +        uint64_t overflow_mask = (uint64_t)1 << overflow_bit;

Could just as easily be

  uint64_t overflow_mask = env->cp15.c9_pmcr & PMCRLC ? INT64_MIN : INT32_MIN;


> +        if (env->cp15.c15_ccnt & ~new_pmccntr & overflow_mask) {
> +            env->cp15.c9_pmovsr |= (1 << 31);
> +            if (!(env->cp15.c9_pmcr & PMCRLC)) {
> +                new_pmccntr &= 0xffffffff;
> +            }

Why is this truncation buried within the overflow condition?  Simply because
the high bits can't be set without overflow being noticed?  That could use a
comment, because it looks odd.

> @@ -1340,8 +1399,15 @@ static void pmevcntr_op_start(CPUARMState *env, uint8_t counter)
>      }
>  
>      if (pmu_counter_enabled(env, counter)) {
> -        env->cp15.c14_pmevcntr[counter] =
> -            count - env->cp15.c14_pmevcntr_delta[counter];
> +        uint64_t new_pmevcntr = count - env->cp15.c14_pmevcntr_delta[counter];
> +
> +        if (!(new_pmevcntr & PMEVCNTR_OVERFLOW_MASK) &&
> +                (env->cp15.c14_pmevcntr[counter] & PMEVCNTR_OVERFLOW_MASK)) {
> +            env->cp15.c9_pmovsr |= (1 << counter);
> +            new_pmevcntr &= ~PMEVCNTR_OVERFLOW_MASK;

That, surely, does not do what you intend.  I can only imagine that you meant

    new_pmevcntr = (uint32_t)new_pmevcntr;
or
    new_pmevcntr &= PMEVCNTR_OVERFLOW_MASK - 1;

depending on how much you want to depend on the symbol defining the width.
Given that it is architecturally defined to 32-bits, I think you could really
just drop the define and use

    uint32_t new_pmevcntr = ...;
    if (env->cp15.c14_pmevcntr[counter] & ~new_pmevcntr & INT32_MIN)

with equal clarity.  The type of new_pmevcntr means you don't have to clear any
high bits either.

> +            /* Detect if this write causes an overflow since we can't predict
> +             * PMSWINC overflows like we can for other events
> +             */
> +            uint64_t new_pmswinc = env->cp15.c14_pmevcntr[i] + 1;
> +
> +            if (!(new_pmswinc & PMEVCNTR_OVERFLOW_MASK) &&
> +                    (env->cp15.c14_pmevcntr[i] & PMEVCNTR_OVERFLOW_MASK)) {
> +                env->cp15.c9_pmovsr |= (1 << i);
> +                new_pmswinc &= ~PMEVCNTR_OVERFLOW_MASK;

Likewise.


r~
