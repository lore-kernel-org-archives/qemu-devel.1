Received: from eggs.gnu.org ([2001:4830:134:3::10]:37832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1f6z7a-0003Za-Cr
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:52:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1f6z7Z-0001ag-CO
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:52:10 -0400
Date: Fri, 13 Apr 2018 09:51:58 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Message-ID: <20180413135157.GM24561@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<1521232280-13089-6-git-send-email-alindsay@codeaurora.org>
	<CAFEAcA9Hd5dsfPM=ggepk2MxFJdxHB1uiJzwpDy5628D7JF5ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9Hd5dsfPM=ggepk2MxFJdxHB1uiJzwpDy5628D7JF5ow@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 05/22] target/arm: Reorganize PMCCNTR
 read, write, sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On Apr 12 17:18, Peter Maydell wrote:
> On 16 March 2018 at 20:31, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> > pmccntr_read and pmccntr_write contained duplicate code that was already
> > being handled by pmccntr_sync. Split pmccntr_sync into pmccntr_op_start
> > and pmccntr_op_finish, passing the clock value between the two, to avoid
> > losing time between the two calls.
> >
> > Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> > ---
> >  target/arm/helper.c | 101 +++++++++++++++++++++++++++++-----------------------
> >  1 file changed, 56 insertions(+), 45 deletions(-)
> >
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index 5634561..6480b80 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> > @@ -1000,28 +1000,58 @@ static inline bool arm_ccnt_enabled(CPUARMState *env)
> >
> >      return true;
> >  }
> > -
> > -void pmccntr_sync(CPUARMState *env)
> 
> If you configure your git to use the 'histogram' diff algorithm
> ("git config --global diff.algorithm histogram", or edit ~/.gitconfig
> equivalently), does it make git format-patch make less of a mess
> of this commit ?

No, it doesn't seem to make much of a difference.

> > +/*
> > + * Ensure c15_ccnt is the guest-visible count so that operations such as
> > + * enabling/disabling the counter or filtering, modifying the count itself,
> > + * etc. can be done logically. This is essentially a no-op if the counter is
> > + * not enabled at the time of the call.
> > + *
> > + * The current cycle count is returned so that it can be passed into the paired
> > + * pmccntr_op_finish() call which must follow each call to pmccntr_op_start().
> > + */
> > +uint64_t pmccntr_op_start(CPUARMState *env)
> >  {
> > -    uint64_t temp_ticks;
> > -
> > -    temp_ticks = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> > +    uint64_t cycles = 0;
> > +#ifndef CONFIG_USER_ONLY
> > +    cycles = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> >                            ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
> > +#endif
> 
> Is this ifdef necessary? You have a do-nothing version of
> pmccntr_op_start() for CONFIG_USER_ONLY later on, so presumably
> this one is already inside a suitable ifndef.

You're right that it is unnecessary as of this patch. A later patch
removes the surrounding `#ifndef CONFIG_USER_ONLY` when it is no longer
necessary at that level. It would be cleaner to add the #ifndef with
smaller scope at the same time - I'll make that change.  

> Otherwise
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Because I've modified how pmccntr_op_start/finish keep track of the
cycles so that they store the counter values differently for v4, I don't
feel comfortable adding your Reviewed-by. I apologize for the churn.

-Aaron

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
