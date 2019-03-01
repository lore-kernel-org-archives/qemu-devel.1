Received: from eggs.gnu.org ([209.51.188.92]:40190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzlPM-0006IC-T0
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:53:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzlPL-00033R-Gw
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:53:12 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:33339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzlPL-0002z6-8v
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:53:11 -0500
Received: by mail-ot1-x32c.google.com with SMTP id q24so21573946otk.0
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 08:53:10 -0800 (PST)
MIME-Version: 1.0
References: <a6548846-c64d-a815-45a5-953ccc4b7ea0@greensocs.com>
	<CAFEAcA8dM_DN9Mrep8O7XVPPis0v2XcSU3fWSHTbz2MJDqjEsg@mail.gmail.com>
	<fe389f85-a52d-e469-96de-f34663a3c5a5@greensocs.com>
In-Reply-To: <fe389f85-a52d-e469-96de-f34663a3c5a5@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Mar 2019 16:52:58 +0000
Message-ID: <CAFEAcA_OrJ-1SzE5UpT4eHbzi-KS_GqX13KZdHzEzovXnsnsUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC] multi phase reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Damien Hedde <damien.hedde@greensocs.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Mark Burton <mark.burton@greensocs.com>

On Fri, 1 Mar 2019 at 15:34, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> On 3/1/19 12:43 PM, Peter Maydell wrote:
> > On Mon, 25 Feb 2019 at 10:49, Damien Hedde <damien.hedde@greensocs.com> wrote:
> >> I had more thought about the reset problem and what we want to achieve
> >> (add power gating and clock support).
> >> Feel free to comment. I'll start to implement this and send a first
> >> version with a reroll of everything when it's ready.
> >
> > I generally like this; I have some comments below.
> >
> >> # PROPOSAL OVERVIEW
> >>
> >> I propose to add a Resetable interface and a ResetDomain object.
> >>
> >> Having an interface simplify things since there is several reset entry
> >> points (at least Buses and Devices).
> >> Device and Bus objects will implement this interface.
> >>
> >> The ResetDomain will hold several Resetable objects and implement the
> >> interface too. The ResetDomain is needed to have at least a global/main
> >> ResetDomain to place buses and devices to replace the current
> >> qemu_register_reset system which only allow to register a function.
> >
> > How does the ResetDomain fit in for a typical case where
> > we have an SoC container object with a handful of devices
> > (which are children of the container object)? Does the
> > SoC container object just directly implement the Resettable
> > interface and handle the propagation as ResetDomain would?
> > Does the SoC container create one or more ResetDomains and
> > add its child devices to them (if so, with what API)?
>
> By SoC container, I suppose you mean a Machine object.

No, I mean something like the TYPE_NRF51_SOC device.
This isn't a machine, it's a device that represents an SoC,
and which is pretty much just a container that wires up
all the devices that an SoC has. The Machine represents
an entire board, and usually will create an SoC, some memory
and perhaps a few other devices.

> Right now, I only have 2 functions reset_domain_[un]register_object to
> add/remove an object in a reset domain (which is just a list of Resettable).

OK, so whether devices are in a reset domain object
is distinct from what object they are QOM children of ?

> > In my design the only thing that I thought would happen in phase 3
> > was the "clear the resetting flag", but you've moved that to RELEASE.
> > What's left ? Do you have a concrete example where we'd need this?
>
> I hesitated to remove this phase (would be easy to add it after if it is
> really needed). I see 2 cases where it might be useful.
>
> To stay in my use case for clocks, here how it can be used: For an uart,
> during release phase, the clock will propagate and only after every
> release phases has been executed we will have the final/valid input
> frequency.
> So we can either recompute the uart baudrate every time the clock change
> due to propagation or wait till post phase to do it once for all (and
> initialize the backend parameters). But it is probably no big deal for
> this case if we don't have post phase.

I think I'd rather have the model be simpler rather than
complicate it for the sake of optimisation. It's not like
we reset very frequently...

> Another place where it may be needed is cases like the pc's machine
> reset case (hw/i386/p.c) that reset everything then reset interrupt
> controllers.
> static void pc_machine_reset(void)
> {
>     CPUState *cs;
>     X86CPU *cpu;
>     qemu_devices_reset();
>
>     /* Reset APIC after devices have been reset to cancel
>      * any changes that qemu_devices_reset() might have done.
>      */
>     CPU_FOREACH(cs) {
>         cpu = X86_CPU(cs);
>
>         if (cpu->apic_state) {
>             device_reset(cpu->apic_state);
>         }
>     }
> }

I think this is just working around the fact that we don't
have a multiphase reset, so the APIC doesn't know whether it
got an inbound asserted interrupt while it is being
reset or not. We should be able to get rid of this code once
we have converted things, I hope.

> >> Obviously to correctly support this assert/de-assert a device must have
> >> special support in order to handle migration in "resetting" state. There
> >> is no migration problem while we only use trigger because there is no
> >> point during the reset were migration could occur.
> >
> > What would need to be different? Just needing to migrate the state
> > of the 'resetting' flag ? (I think we could handle that in the
> > device base class.)
>
> That's it. It would be nice to handle this in the base class but I don't
> know how I can do that. vmsd field has no inheritance mechanism. Should
> we add some base/background migration to every device ?

I'm not sure exactly. (What I was thinking we ought to end up
with is a migration subsection which is used only if the flag
happens to be true; but I'm not sure how to add subsections
from the base class.) I suggest you do the first version
with a TODO note about handling migration of the resetting
flag and we'll look at how to do it cleanly then.

> > (perhaps what we want is for new-system-aware devices to implement
> > Resettable directly, and also for DeviceClass to implement
> > Resettable with some methods that call old-school DeviceClass::reset,
> > for back-compatibility ? This feels like it's going to end up
> > with our "preferred" API being more boilerplatey than the
> > "deprecated" old API, though :-( )
>
> What I started to do is make Deviceclass implements Resettable and add
> additional methods in DeviceClass corresponding to the "local" version
> of the Resettable methods.
>
> So in DeviceClass I have 4 news methods
>    cold_reset (this forms reset_init with existing reset, we could name
>                it reset_init and see how to replace existing reset)
>    reset_release
>    reset_hold
>    reset_post
> These methods are empty by default and should be implemented by
> specialization classes to do local reset operations.
>
> And there is the 4 methods of the resettable interface:
>    reset_init
>    reset_release
>    reset_hold
>    reset_post
> These methods are implemented by default to:
> + call the local version
> + call the sub-buses methods

OK, but I'd definitely prefer to have the names match up here.

thanks
-- PMM
