Received: from eggs.gnu.org ([2001:4830:134:3::10]:40204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e4Rsx-0000QA-JT
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:26:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e4Rst-0007pF-BW
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:26:19 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:53455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e4Rst-0007oo-20
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:26:15 -0400
Received: by mail-wr0-x22b.google.com with SMTP id y44so1670295wry.10
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 06:26:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506737310-21880-4-git-send-email-alindsay@codeaurora.org>
References: <1506737310-21880-1-git-send-email-alindsay@codeaurora.org>
	<1506737310-21880-4-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Oct 2017 14:25:53 +0100
Message-ID: <CAFEAcA-0_dD0aXM5kmDbhKC5zX2woeX4G_BJemr8EgbhGBbdFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 03/13] target/arm: Reorganize PMCCNTR read,
 write, sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, Wei Huang <wei@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On 30 September 2017 at 03:08, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> pmccntr_read and pmccntr_write contained duplicate code that was already
> being handled by pmccntr_sync. This also moves the calls to get the
> clock inside the 'if' statement so they are not executed if not needed.

It is duplicate code, yes, but I also find it a bit confusing,
because it's the same code doing two different operations:

(1) if (as is usual when the counter is running) c15_ccnt
contains a delta between the clock ticks and the register
value, pmccntr_sync() sets c15_ccnt to the current
guest-visible register value

(2) if c15_ccnt contains a guest-visible register value
and the clock is running, pmccntr_sync() sets c15_ccnt
to the ticks-to-value delta

and we use this in a couple of places like:
   pmccntr_sync();
   do stuff that operates on the guest register values,
     or maybe turns off the counter, etc;
   pmccntr_sync();

But that's wrong really -- we'll slightly lose time because
the nanosecond clock advances between the two calls
to qemu_clock_get_ns(). (It only works at all because
it happens that f(x) = C - x  is a self-inverse function.)
It's also a confusing API because it looks like something
you only need to call once but actually in most cases
you need to call it twice, before and after whatever it
is you're doing with the counter.

So I think we should refactor this so that we have a
pair of functions, something like:
    uint64_t clocknow = pmccntr_op_start(env);
    /* Now c15_ccnt is the guest visible value, and
     * we can do things like change PMCRD, enable bits, etc
     */
    [...]
    /* convert c15_ccnt back to the clock-to-value delta,
     * passing it the tick count we used when we did the
     * delta-to-value conversion earlier.
     */
    pmccntr_op_finish(env, clocknow);

(clocknow here should be the output of the muldiv64(),
not the divided-by-64 version.)

Some more specific review comments below, though the
suggested refactoring above might render some of them moot.


> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> ---
>  target/arm/helper.c | 55 ++++++++++++++++-------------------------------------
>  1 file changed, 16 insertions(+), 39 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 40c9273..ecf8c55 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -973,17 +973,18 @@ static inline bool arm_ccnt_enabled(CPUARMState *env)
>
>  void pmccntr_sync(CPUARMState *env)
>  {
> -    uint64_t temp_ticks;
> +    if (arm_ccnt_enabled(env) &&
> +          !pmu_counter_filtered(env, env->cp15.pmccfiltr_el0)) {

This seems to be adding an extra condition that the commit
message doesn't mention.

> +        uint64_t temp_ticks;
>
> -    temp_ticks = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> -                          ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
> +        temp_ticks = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> +                              ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
>
> -    if (env->cp15.c9_pmcr & PMCRD) {
> -        /* Increment once every 64 processor clock cycles */
> -        temp_ticks /= 64;
> -    }
> +        if (env->cp15.c9_pmcr & PMCRD) {
> +            /* Increment once every 64 processor clock cycles */
> +            temp_ticks /= 64;
> +        }
>
> -    if (arm_ccnt_enabled(env)) {
>          env->cp15.c15_ccnt = temp_ticks - env->cp15.c15_ccnt;
>      }
>  }
> @@ -1007,21 +1008,11 @@ static void pmcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>
>  static uint64_t pmccntr_read(CPUARMState *env, const ARMCPRegInfo *ri)
>  {
> -    uint64_t total_ticks;
> -
> -    if (!arm_ccnt_enabled(env)) {
> -        /* Counter is disabled, do not change value */
> -        return env->cp15.c15_ccnt;
> -    }
> -
> -    total_ticks = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> -                           ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
> -
> -    if (env->cp15.c9_pmcr & PMCRD) {
> -        /* Increment once every 64 processor clock cycles */
> -        total_ticks /= 64;
> -    }
> -    return total_ticks - env->cp15.c15_ccnt;
> +    uint64_t ret;
> +    pmccntr_sync(env);
> +    ret = env->cp15.c15_ccnt;
> +    pmccntr_sync(env);
> +    return ret;

This change means that as a result of this refactoring we
now do the 'sync' operations (muldiv etc) twice, whereas
previously we did them only once.

>  }
>
>  static void pmselr_write(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -1038,22 +1029,8 @@ static void pmselr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  static void pmccntr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                          uint64_t value)
>  {
> -    uint64_t total_ticks;
> -
> -    if (!arm_ccnt_enabled(env)) {
> -        /* Counter is disabled, set the absolute value */
> -        env->cp15.c15_ccnt = value;
> -        return;
> -    }
> -
> -    total_ticks = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> -                           ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
> -
> -    if (env->cp15.c9_pmcr & PMCRD) {
> -        /* Increment once every 64 processor clock cycles */
> -        total_ticks /= 64;
> -    }
> -    env->cp15.c15_ccnt = total_ticks - value;
> +    env->cp15.c15_ccnt = value;
> +    pmccntr_sync(env);
>  }

thanks
-- PMM
