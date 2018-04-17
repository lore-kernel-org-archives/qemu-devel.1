Received: from eggs.gnu.org ([2001:4830:134:3::10]:32799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1f8WpX-0005Rp-D3
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:03:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1f8WpW-0007M1-9i
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:03:55 -0400
Date: Tue, 17 Apr 2018 16:03:45 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Message-ID: <20180417200344.GQ24561@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<1521232280-13089-13-git-send-email-alindsay@codeaurora.org>
	<CAFEAcA_UP-DgPZPL8-sMAs9TFHiUrfya8LAxAnO2U_WJAMH6yg@mail.gmail.com>
	<20180412173625.GK24561@codeaurora.org>
	<20180417152101.GP24561@codeaurora.org>
	<CAFEAcA_QdPChiMPtZt7t_aqQTUcSDweGVG0anchKYH6KtEgEYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_QdPChiMPtZt7t_aqQTUcSDweGVG0anchKYH6KtEgEYw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 12/22] target/arm: Filter cycle counter
 based on PMCCFILTR_EL0
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

On Apr 17 16:37, Peter Maydell wrote:
> On 17 April 2018 at 16:21, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> > On Apr 12 13:36, Aaron Lindsay wrote:
> >> On Apr 12 18:15, Peter Maydell wrote:
> >> > On 16 March 2018 at 20:31, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> >> > > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> >> > > index b0ef727..9c3b5ef 100644
> >> > > --- a/target/arm/cpu.h
> >> > > +++ b/target/arm/cpu.h
> >> > > @@ -458,6 +458,11 @@ typedef struct CPUARMState {
> >> > >           * was reset. Otherwise it stores the counter value
> >> > >           */
> >> > >          uint64_t c15_ccnt;
> >> > > +        /* ccnt_cached_cycles is used to hold the last cycle count when
> >> > > +         * c15_ccnt holds the guest-visible count instead of the delta during
> >> > > +         * PMU operations which require this.
> >> > > +         */
> >> > > +        uint64_t ccnt_cached_cycles;
> >> >
> >> > Can this ever hold valid state at a point when we need to do VM
> >> > migration, or is it purely temporary ?
> >>
> >> I believe that as of this version of the patch it is temporary and will
> >> not need to be migrated. However, I believe it's going to be necessary
> >> to have two variables to represent the state of each counter in order to
> >> implement interrupt on overflow.
> >
> > Coming back around to this, I don't see a way around using two variables
> > to hold PMCCNTR's full state to make interrupt on overflow work. I
> > haven't been able to find other examples or documentation covering state
> > needing to be updated in more than one location for a given CP register
> > - do you know of any I've missed or have recommendations about how to
> > approach this?
> 
> Can you explain the problem in more detail? In general it's a bit of
> a red flag if you think you need more state storage space than the
> hardware has, and I don't think there's any "hidden" state in the h/w here.

The critical difference between hardware and QEMU's PMU implementation
is that hardware detects overflow when the overflow actually happens,
which would be inefficient to do in software. Because QEMU stores a
delta from the 'real' count (i.e. the clock/icount) and only updates the
architectural counter values when necessary (when they're read/written),
checking for overflow is less straightforward than checking if
incrementing an individual counter by one flips the high-order bit from
1 to 0 as it happens. If the only information you have is the current
counter value, and don't know how many events have occurred since you
last checked or what the counter value was at that time, you can't tell
whether or not it overflowed.

I haven't come up with a way to correctly and reliably detect overflow
without storing additional information. I'll go ahead and post v4 with
my first-pass implementation of the overflow code and see if you see
something I'm missing or can think of a trick we can play to keep this
inside of one register value.

-Aaron

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
