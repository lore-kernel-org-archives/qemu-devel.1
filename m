Received: from eggs.gnu.org ([2001:4830:134:3::10]:35844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aclindsa@gmail.com>) id 1fukFC-00070f-Q7
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 16:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aclindsa@gmail.com>) id 1fukF7-0008Ml-DT
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 16:05:42 -0400
Date: Tue, 28 Aug 2018 16:03:49 -0400
From: Aaron Lindsay <aclindsa@gmail.com>
Message-ID: <20180828200348.GB3671@okra.localdomain>
References: <1529699547-17044-1-git-send-email-alindsay@codeaurora.org>
	<1529699547-17044-2-git-send-email-alindsay@codeaurora.org>
	<CAFEAcA8601LbuOOARb0KoNLjJep3-ND=Kf44OqW6NXdVtnNocw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8601LbuOOARb0KoNLjJep3-ND=Kf44OqW6NXdVtnNocw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v5 01/13] target/arm: Reorganize PMCCNTR
 accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Aaron Lindsay <alindsay@codeaurora.org>, qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On Jun 28 17:40, Peter Maydell wrote:
> On 22 June 2018 at 21:32, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index 8488273..ba2c876 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -467,10 +467,20 @@ typedef struct CPUARMState {
> >          uint64_t oslsr_el1; /* OS Lock Status */
> >          uint64_t mdcr_el2;
> >          uint64_t mdcr_el3;
> > -        /* If the counter is enabled, this stores the last time the counter
> > -         * was reset. Otherwise it stores the counter value
> > +        /* Stores the architectural value of the counter *the last time it was
> > +         * updated* by pmccntr_op_start. Accesses should always be surrounded
> > +         * by pmccntr_op_start/pmccntr_op_finish to guarantee the latest
> > +         * architecturally-corect value is being read/set.
> 
> "correct"

Thanks - fixed for v6.

> >           */
> >          uint64_t c15_ccnt;
> > +        /* Stores the delta between the architectural value and the underlying
> > +         * cycle count during normal operation. It is used to update c15_ccnt
> > +         * to be the correct architectural value before accesses. During
> > +         * accesses, c15_ccnt_delta contains the underlying count being used
> > +         * for the access, after which it reverts to the delta value in
> > +         * pmccntr_op_finish.
> > +         */
> > +        uint64_t c15_ccnt_delta;
> 
> I had a look through the patchset, and I still can't see
> anything here which indicates how we're handling migration.

I'll admit that I had not previously thought through everything
exhaustively, but I think I've convinced myself that *almost* everything
is already handled by calling .readfn/writefn on the registers for
migration... more below.

> If this field is only ever used as a temporary while we're
> between op_start and op_finish, then we can just return it from
> start and take it as an argument to finish, and we're fine
> (migration of the PMCCNTR_EL0 register will be done by calling
> its readfn on the source and its writefn on the destination).
> 
> If there's a reason for having this be a field in the state struct
> (I think you said counter overflow)? then we need to be sure that
> migration is going to do the right thing and that we don't for instance
> lose overflow indications during a migration.

I think we do need additional state for supporting counter overflow
during normal operation (more than just between op_start and op_finish),
but I don't think sending additional state over the wire is necessary
for migration. Let me lay out my reasoning to see if you think it makes
sense:

I observe that we seem to deal mostly with the following values with
respect to PMU counters, and I think it might be easier to discuss this
in terms of values rather than variables:

	AC = current architectural value of PMCCNTR
	AL = architectural value of PMCCNTR when last observed/updated by
	     the OS
	UC = current underlying counter value
	UL = underlying counter value when PMCCNTR last observed/updated by
	     OS
	D = difference between underlying counter value and architectural
	    value

At any given point in time, the following should then be true during
normal execution (i.e. between OS accesses to the counter):
	UL - AL == D == UC - AC

The approach taken previous to my patchset was to store D in
cp15.c15_ccnt most of the time, updating that variable to hold AC when
read (by doing `c15_ccnt = UC - c15_ccnt`... an implementation using `AC
= UC - D`, which is a different way to write `D = UC - AC` from above).
This operation was reversed after a write completes, so that c15_ccnt
again holds a value corresponding to D.

Only storing D works well and minimizes memory usage if you don't care
about detecting overflows. However, without some frame of reference for
what the last observed architectural value was relative to its current
value, we have no way to know if the counter has overflowed in the
intervening time. In other words, we need to know both AC and AL to know
if the counter has overflowed. Assuming we store D and can obtain UC we
can calculate AC, but we need to store at least one additional piece of
information to obtain AL (either AL itself or UL).

In my patchset so far, I'm storing AL in c15_ccnt and D in
c15_ccnt_delta during normal operation and AL/AC in c15_ccnt, UL/UC in
c15_ccnt_delta between op_start and op_finish (note that AL == AC, UL ==
UC, and D == 0 during this time). Also note that UL/UC are only stored
between op_start and op_finish calls to avoid losing time, and are not
needed to maintain architectural state across migrations.

Now for migration - The read/writefn's already marshal/unmarshal both
the counter value and overflow state to their architectural values in
PMCCNTR and PMOVSCLR. I think this would work on its own if we made
two big (and wrong) assumptions:
	1. PMOVSCLR is read after PMCCNTR on save (ensures all overflows
	   which have occurred are recorded in PMOVSCLR) and written before
	   it on load (ensures any overflow bits in PMOVSCLR cause the
	   interrupt line to be raised)
	2. Time (as measured by `qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)`) does
	   not change during the process of saving or loading CP registers
	   (ensures PMCCNTR can't have overflowed between when it was saved
	   and when PMOVSCLR was later saved).

One possible solution for this is to add calls to op_start in both
cpu_pre_load and cpu_pre_save, add calls to op_finish in cpu_post_load
and cpu_post_save, and ensure that all CP registers which would call
op_start/finish on their own have raw_read/writefn's which assume
they're between calls to op_start and op_finish.

Thoughts? (and I apologize for the wall of text)

-Aaron
