Received: from eggs.gnu.org ([2001:4830:134:3::10]:60983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSmO2-0004qd-PJ
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:15:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSmLj-0000J3-N9
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:13:10 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35252)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gSmLj-0000HE-F4
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:13:07 -0500
Received: by mail-pg1-x543.google.com with SMTP id s198so2778524pgs.2
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 09:13:06 -0800 (PST)
References: <20181120212553.8480-1-aaron@os.amperecomputing.com>
	<20181120212553.8480-14-aaron@os.amperecomputing.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d6fde9c7-b72e-ae9d-817b-71c3d6369dbc@linaro.org>
Date: Fri, 30 Nov 2018 09:13:01 -0800
MIME-Version: 1.0
In-Reply-To: <20181120212553.8480-14-aaron@os.amperecomputing.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 13/13] target/arm: Send interrupts on
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <alindsay@codeaurora.org>, SM-Aaron Lindsay <alindsay@os.amperecomputing.com>

On 11/20/18 1:26 PM, Aaron Lindsay wrote:
> Setup a QEMUTimer to get a callback when we expect counters to next
> overflow and trigger an interrupt at that time.
> 
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> Signed-off-by: Aaron Lindsay <alindsay@os.amperecomputing.com>
> ---
>  target/arm/cpu.c    |  12 +++++
>  target/arm/cpu.h    |   7 +++
>  target/arm/helper.c | 126 +++++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 139 insertions(+), 6 deletions(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 208a08e867..7311a48e3c 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -827,6 +827,13 @@ static void arm_cpu_finalizefn(Object *obj)
>          QLIST_REMOVE(hook, node);
>          g_free(hook);
>      }
> +#ifndef CONFIG_USER_ONLY
> +    if (arm_feature(&cpu->env, ARM_FEATURE_PMU) && cpu->pmu_timer) {

No need for two tests here.  Just check cpu->pmu_timer.
(If it's set for any reason it should be freed, surely.)

> @@ -1305,7 +1338,18 @@ void pmccntr_op_start(CPUARMState *env)
>              eff_cycles /= 64;
>          }
>  
> -        env->cp15.c15_ccnt = eff_cycles - env->cp15.c15_ccnt_delta;
> +        uint64_t new_pmccntr = eff_cycles - env->cp15.c15_ccnt_delta;
> +
> +        unsigned int overflow_bit = (env->cp15.c9_pmcr & PMCRLC) ? 63 : 31;
> +        uint64_t overflow_mask = (uint64_t)1 << overflow_bit;
> +        if (!(new_pmccntr & overflow_mask) &&
> +                (env->cp15.c15_ccnt & overflow_mask)) {

Fyi, this expression is

    env->cp15.c15_ccnt & ~new_pmccntr & overflow_mask

> +            env->cp15.c9_pmovsr |= (1 << 31);
> +            new_pmccntr &= ~overflow_mask;

Why this line?  You just checked that overflow_mask was unset in new_pmccntr above.

> @@ -1318,13 +1362,28 @@ void pmccntr_op_start(CPUARMState *env)
>  void pmccntr_op_finish(CPUARMState *env)
>  {
>      if (pmu_counter_enabled(env, 31)) {
> -        uint64_t prev_cycles = env->cp15.c15_ccnt_delta;
> +#ifndef CONFIG_USER_ONLY
> +        uint64_t delta;
> +        if (env->cp15.c9_pmcr & PMCRLC) {
> +            delta = UINT64_MAX - env->cp15.c15_ccnt + 1;
> +        } else {
> +            delta = UINT32_MAX - (uint32_t)env->cp15.c15_ccnt + 1;
> +        }

FWIW, this is the same as

    delta = -env->cp15.c15_ccnt;
    if (!(env->cp15.c9_pmcr & PMCRLC)) {
        delta = (uint32_t)delta;
    }


r~
