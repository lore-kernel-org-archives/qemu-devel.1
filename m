Received: from eggs.gnu.org ([2001:4830:134:3::10]:47963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1f8o7o-0000ah-3Z
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:31:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1f8o7l-0005U7-02
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:31:56 -0400
Date: Wed, 18 Apr 2018 10:31:37 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Message-ID: <20180418143137.GR24561@codeaurora.org>
References: <1523997485-1905-1-git-send-email-alindsay@codeaurora.org>
	<1523997485-1905-22-git-send-email-alindsay@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523997485-1905-22-git-send-email-alindsay@codeaurora.org>
Subject: Re: [Qemu-devel] [PATCH v4 21/21] target/arm: Send interrupts on
 PMU counter overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: qemu-devel@nongnu.org, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On Apr 17 16:38, Aaron Lindsay wrote:
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 046e37c..2efdc63 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -973,6 +986,11 @@ static uint64_t cycles_get_count(CPUARMState *env)
>  }
>  
>  #ifndef CONFIG_USER_ONLY
> +static int64_t cycles_ns_per(uint64_t cycles)
> +{
> +    return ARM_CPU_FREQ / NANOSECONDS_PER_SECOND;
> +}

This should be:
    return (ARM_CPU_FREQ / NANOSECONDS_PER_SECOND) * cycles;

This took me a while to catch because it doesn't actually affect
functional correctness, but means QEMU slows down because the timer
callback is called every ns...

> @@ -1215,13 +1259,24 @@ void pmccntr_op_start(CPUARMState *env)
>  void pmccntr_op_finish(CPUARMState *env)
>  {
>      if (pmu_counter_enabled(env, 31)) {
> -        uint64_t prev_cycles = env->cp15.c15_ccnt_delta;
> +#ifndef CONFIG_USER_ONLY
> +        uint64_t delta = ((env->cp15.c9_pmcr & PMCRLC) ?
> +                UINT64_MAX : UINT32_MAX) - (uint32_t)env->cp15.c15_ccnt + 1;

I also shouldn't be casting to a uint32_t if PMCR.LC is set. I've fixed
these locally for the next round.

-Aaron

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
