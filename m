Received: from eggs.gnu.org ([2001:4830:134:3::10]:51605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1e4Tlx-00006W-Pv
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:27:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1e4Tlu-0000IW-Ex
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:27:13 -0400
Date: Tue, 17 Oct 2017 11:26:55 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Message-ID: <20171017152654.GE3676@codeaurora.org>
References: <1506737310-21880-1-git-send-email-alindsay@codeaurora.org>
	<1506737310-21880-4-git-send-email-alindsay@codeaurora.org>
	<CAFEAcA-0_dD0aXM5kmDbhKC5zX2woeX4G_BJemr8EgbhGBbdFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-0_dD0aXM5kmDbhKC5zX2woeX4G_BJemr8EgbhGBbdFA@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, Wei Huang <wei@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On Oct 17 14:25, Peter Maydell wrote:
> On 30 September 2017 at 03:08, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> > pmccntr_read and pmccntr_write contained duplicate code that was already
> > being handled by pmccntr_sync. This also moves the calls to get the
> > clock inside the 'if' statement so they are not executed if not needed.
> 
> It is duplicate code, yes, but I also find it a bit confusing,
> because it's the same code doing two different operations:
> 
> (1) if (as is usual when the counter is running) c15_ccnt
> contains a delta between the clock ticks and the register
> value, pmccntr_sync() sets c15_ccnt to the current
> guest-visible register value
> 
> (2) if c15_ccnt contains a guest-visible register value
> and the clock is running, pmccntr_sync() sets c15_ccnt
> to the ticks-to-value delta
> 
> and we use this in a couple of places like:
>    pmccntr_sync();
>    do stuff that operates on the guest register values,
>      or maybe turns off the counter, etc;
>    pmccntr_sync();
> 
> But that's wrong really -- we'll slightly lose time because
> the nanosecond clock advances between the two calls
> to qemu_clock_get_ns(). (It only works at all because
> it happens that f(x) = C - x  is a self-inverse function.)
> It's also a confusing API because it looks like something
> you only need to call once but actually in most cases
> you need to call it twice, before and after whatever it
> is you're doing with the counter.

Interesting, I hadn't thought about the loss of time issue.

> So I think we should refactor this so that we have a
> pair of functions, something like:
>     uint64_t clocknow = pmccntr_op_start(env);
>     /* Now c15_ccnt is the guest visible value, and
>      * we can do things like change PMCRD, enable bits, etc
>      */
>     [...]
>     /* convert c15_ccnt back to the clock-to-value delta,
>      * passing it the tick count we used when we did the
>      * delta-to-value conversion earlier.
>      */
>     pmccntr_op_finish(env, clocknow);
> 
> (clocknow here should be the output of the muldiv64(),
> not the divided-by-64 version.)
> 
> Some more specific review comments below, though the
> suggested refactoring above might render some of them moot.

I agree that what you describe would be cleaner. I'll work towards that
in v3.

> > Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> > ---
> >  target/arm/helper.c | 55 ++++++++++++++++-------------------------------------
> >  1 file changed, 16 insertions(+), 39 deletions(-)
> >
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index 40c9273..ecf8c55 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> > @@ -973,17 +973,18 @@ static inline bool arm_ccnt_enabled(CPUARMState *env)
> >
> >  void pmccntr_sync(CPUARMState *env)
> >  {
> > -    uint64_t temp_ticks;
> > +    if (arm_ccnt_enabled(env) &&
> > +          !pmu_counter_filtered(env, env->cp15.pmccfiltr_el0)) {
> 
> This seems to be adding an extra condition that the commit
> message doesn't mention.

Eek. This slipped the cracks through during a rebase and belongs in
'target/arm: Filter cycle counter based on PMCCFILTR_EL0'.

> > +        uint64_t temp_ticks;
> >
> > -    temp_ticks = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> > -                          ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
> > +        temp_ticks = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> > +                              ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
> >
> > -    if (env->cp15.c9_pmcr & PMCRD) {
> > -        /* Increment once every 64 processor clock cycles */
> > -        temp_ticks /= 64;
> > -    }
> > +        if (env->cp15.c9_pmcr & PMCRD) {
> > +            /* Increment once every 64 processor clock cycles */
> > +            temp_ticks /= 64;
> > +        }
> >
> > -    if (arm_ccnt_enabled(env)) {
> >          env->cp15.c15_ccnt = temp_ticks - env->cp15.c15_ccnt;
> >      }
> >  }
> > @@ -1007,21 +1008,11 @@ static void pmcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
> >
> >  static uint64_t pmccntr_read(CPUARMState *env, const ARMCPRegInfo *ri)
> >  {
> > -    uint64_t total_ticks;
> > -
> > -    if (!arm_ccnt_enabled(env)) {
> > -        /* Counter is disabled, do not change value */
> > -        return env->cp15.c15_ccnt;
> > -    }
> > -
> > -    total_ticks = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> > -                           ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
> > -
> > -    if (env->cp15.c9_pmcr & PMCRD) {
> > -        /* Increment once every 64 processor clock cycles */
> > -        total_ticks /= 64;
> > -    }
> > -    return total_ticks - env->cp15.c15_ccnt;
> > +    uint64_t ret;
> > +    pmccntr_sync(env);
> > +    ret = env->cp15.c15_ccnt;
> > +    pmccntr_sync(env);
> > +    return ret;
> 
> This change means that as a result of this refactoring we
> now do the 'sync' operations (muldiv etc) twice, whereas
> previously we did them only once.
> 
> >  }
> >
> >  static void pmselr_write(CPUARMState *env, const ARMCPRegInfo *ri,
> > @@ -1038,22 +1029,8 @@ static void pmselr_write(CPUARMState *env, const ARMCPRegInfo *ri,
> >  static void pmccntr_write(CPUARMState *env, const ARMCPRegInfo *ri,
> >                          uint64_t value)
> >  {
> > -    uint64_t total_ticks;
> > -
> > -    if (!arm_ccnt_enabled(env)) {
> > -        /* Counter is disabled, set the absolute value */
> > -        env->cp15.c15_ccnt = value;
> > -        return;
> > -    }
> > -
> > -    total_ticks = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> > -                           ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
> > -
> > -    if (env->cp15.c9_pmcr & PMCRD) {
> > -        /* Increment once every 64 processor clock cycles */
> > -        total_ticks /= 64;
> > -    }
> > -    env->cp15.c15_ccnt = total_ticks - value;
> > +    env->cp15.c15_ccnt = value;
> > +    pmccntr_sync(env);
> >  }
> 
> thanks
> -- PMM

-Aaron

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
