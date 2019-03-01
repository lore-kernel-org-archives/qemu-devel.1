Received: from eggs.gnu.org ([209.51.188.92]:50900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1gzkNQ-0004uY-7F
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:47:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1gzkBT-0006AF-7F
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:34:49 -0500
Received: from greensocs.com ([193.104.36.180]:57314)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1gzkBS-00064y-Ij
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:34:47 -0500
References: <a6548846-c64d-a815-45a5-953ccc4b7ea0@greensocs.com>
	<CAFEAcA8dM_DN9Mrep8O7XVPPis0v2XcSU3fWSHTbz2MJDqjEsg@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <fe389f85-a52d-e469-96de-f34663a3c5a5@greensocs.com>
Date: Fri, 1 Mar 2019 16:34:37 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8dM_DN9Mrep8O7XVPPis0v2XcSU3fWSHTbz2MJDqjEsg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] multi phase reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Mark Burton <mark.burton@greensocs.com>

On 3/1/19 12:43 PM, Peter Maydell wrote:
> On Mon, 25 Feb 2019 at 10:49, Damien Hedde <damien.hedde@greensocs.com> wrote:
>> I had more thought about the reset problem and what we want to achieve
>> (add power gating and clock support).
>> Feel free to comment. I'll start to implement this and send a first
>> version with a reroll of everything when it's ready.
> 
> I generally like this; I have some comments below.
> 
>> # PROPOSAL OVERVIEW
>>
>> I propose to add a Resetable interface and a ResetDomain object.
>>
>> Having an interface simplify things since there is several reset entry
>> points (at least Buses and Devices).
>> Device and Bus objects will implement this interface.
>>
>> The ResetDomain will hold several Resetable objects and implement the
>> interface too. The ResetDomain is needed to have at least a global/main
>> ResetDomain to place buses and devices to replace the current
>> qemu_register_reset system which only allow to register a function.
> 
> How does the ResetDomain fit in for a typical case where
> we have an SoC container object with a handful of devices
> (which are children of the container object)? Does the
> SoC container object just directly implement the Resettable
> interface and handle the propagation as ResetDomain would?
> Does the SoC container create one or more ResetDomains and
> add its child devices to them (if so, with what API)?

By SoC container, I suppose you mean a Machine object.
Both option are doable.
I did not really start to work on the Machine part as it could be done
in a second time when bus/device is done.
Containers, as a general principle (SoC containers or composed Devices),
should reset containees.
We could put a ResetDomain in the the Machine base object to help for
this or let each Machine handle this. Also the global ResetDomain could
be put into the Machine's ResetDomain at machine creation.

Right now, I only have 2 functions reset_domain_[un]register_object to
add/remove an object in a reset domain (which is just a list of Resettable).

> 
>> I also propose to handle the warm/cold reset distinction. This point is
>> explained below.
>>
>> # RESETABLE INTERFACE
>>
>> This Resetable interface describes the methods corresponding to a multi-
>> phase reset system. This is based on Peter's proposal (see
>> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg03302.html).
>>
>> Here's the phases (I've tried to find adequate names):
> 
> I think this naming definitely works better than my 1/2/3 numbering...
> 
>>
>> INIT PHASE: (Peter's phase 1)
>>     Reset the object internal state, put a resetting flag and do the
>>     same for the reset subtree. No side effect on other devices to
>>     guarantee that, in a reset domain, everything get initialized first.
>>     This corresponds mostly to what is currently done in the device/bus
>>     reset method.
>>
>> HOLD PHASE: (This phase was not in Peter's proposal)
>>     This phase allows to control a reset with a IO. When a IO control
>>     reset procedure based on the IO level (not edge), we may need to
>>     assert the reset, wait some time, and finally de-assert the reset.
>>     The consequence is that such a device can stay in a "resetting
>>     state" and may need to show this state to other devices through
>>     its outputs. For example, a clock controller will typically shutdown
>>     its clocks when it is in resetting state.
>>
>> RELEASE PHASE: (Peter's phase 2, modified)
>>     This phase sets outputs to state after reset. For a clock controller
>>     it starts the clocks. It also clears the "resetting" flag (this is
>>     where is differs from Peter's phase 2). A device should not react to
>>     inputs until this flag has been cleared. During this phase, outputs
>>     are propagated in the reset domain (and outside the reset domain).
>>
>> POST PHASE: (Peter's phase 3)
>>     This phase is kind of post-reset phase to do things that need the
>>     guarantee to be after the propagation of outputs inside the reset
>>     domain.
> 
> In my design the only thing that I thought would happen in phase 3
> was the "clear the resetting flag", but you've moved that to RELEASE.
> What's left ? Do you have a concrete example where we'd need this?

I hesitated to remove this phase (would be easy to add it after if it is
really needed). I see 2 cases where it might be useful.

To stay in my use case for clocks, here how it can be used: For an uart,
during release phase, the clock will propagate and only after every
release phases has been executed we will have the final/valid input
frequency.
So we can either recompute the uart baudrate every time the clock change
due to propagation or wait till post phase to do it once for all (and
initialize the backend parameters). But it is probably no big deal for
this case if we don't have post phase.

Another place where it may be needed is cases like the pc's machine
reset case (hw/i386/p.c) that reset everything then reset interrupt
controllers.
static void pc_machine_reset(void)
{
    CPUState *cs;
    X86CPU *cpu;
    qemu_devices_reset();

    /* Reset APIC after devices have been reset to cancel
     * any changes that qemu_devices_reset() might have done.
     */
    CPU_FOREACH(cs) {
        cpu = X86_CPU(cs);

        if (cpu->apic_state) {
            device_reset(cpu->apic_state);
        }
    }
}

> 
>> The interface contains a method per phase:
>>  void (*reset_init)(Resetable *rst, bool cold);
>>  void (*reset_hold)(Resetable *rst);
>>  void (*reset_release)(Resetable *rst);
>>  void (*reset_post)(Resetable *rst);
>>
>> # WARM/COLD RESET
>>
>> Warm/Cold reset differences may exists in devices. We want a cold reset
>> to handle power gating. (IMO powering off a device is identical to
>> putting it in a cold reset state).
>>
>> To handle the difference between warm and cold reset, I propose to have
>> a parameter to the init phase of Resetable interface.
>> Other phases do not need the parameter since init phase should
>> put warm/cold difference in the device state.
>>
>> # How to do a reset on a Resetable object
>>
>> There is 3 entry points. The first one is when we do a reset event. I
>> call it `void resetable_trigger_reset(Resetable *rst, bool cold)`. This
>> the one used for example at machine startup to initialize everything.
>> this should do the init, release and postphases in a row. I don't think
>> hold phase must be done here since release will do the opposite just after.
>>
>> The 2 other entry points are dedicated to io control.
>> void resetable_assert_reset(Resetable *rst, bool cold);
>> void resetable_deassert_reset(Resetable *rst);
>> assert will do init and hold phases while deassert will release and post
>> phase.
> 
> Could we avoid having these two flavours of reset (init->release->post
> vs init->hold->release->post) by just saying that if you only care
> about triggering reset you just call assert then deassert ?

Yes. In the end, results of both must be the same (without maybe more
intermediate glitches for the init->hold->release->post).

> 
>> Obviously to correctly support this assert/de-assert a device must have
>> special support in order to handle migration in "resetting" state. There
>> is no migration problem while we only use trigger because there is no
>> point during the reset were migration could occur.
> 
> What would need to be different? Just needing to migrate the state
> of the 'resetting' flag ? (I think we could handle that in the
> device base class.)

That's it. It would be nice to handle this in the base class but I don't
know how I can do that. vmsd field has no inheritance mechanism. Should
we add some base/background migration to every device ?

> 
>> # DeviceClass impact
>>
>> 4 new methods are added in Device:
>> + 3 corresponding to the hold/release/post phases.
>> + 1 to handle the cold reset init phase.
>>
>> The existing `reset` method is now the warm reset init phase. To handle
>> the cold reset, a new `cold_reset` is added. The default behavior of
>> this method is to call `reset` so that without any specific support cold
>> and warm reset are the same.
> 
> I think it would be nicer if devices just implemented the Resettable
> interface, so that we don't have two similar but not identical APIs
> for handling the various phases.
> 
>> Instead of adding a cold reset method, we could add a parameter to the
>> current reset. But there is a lot of places that would need some changes
>> and I am really not sure we can do it automatically.
> 
> Coccinelle is very good for making wide-scale automatic changes.
> I would prefer that we design (and work out a path for transitioning
> to) the right API, rather than producing a weird API because we're
> trying to retain some legacy method names and fit them into the
> scheme.
> 
> If I'm a device that's aware of the new reset scheme, what
> do I need to implement? Do I declare that I implement Resettable,
> and provide the various methods for the phases? Or do I rely
> on DeviceClass to implement Resettable, and provide DeviceClass
> methods ?

It can rely on DeviceClass to implement Resettable and have to provide
DeviceClass methods.

> 
> (perhaps what we want is for new-system-aware devices to implement
> Resettable directly, and also for DeviceClass to implement
> Resettable with some methods that call old-school DeviceClass::reset,
> for back-compatibility ? This feels like it's going to end up
> with our "preferred" API being more boilerplatey than the
> "deprecated" old API, though :-( )

What I started to do is make Deviceclass implements Resettable and add
additional methods in DeviceClass corresponding to the "local" version
of the Resettable methods.

So in DeviceClass I have 4 news methods
   cold_reset (this forms reset_init with existing reset, we could name
               it reset_init and see how to replace existing reset)
   reset_release
   reset_hold
   reset_post
These methods are empty by default and should be implemented by
specialization classes to do local reset operations.

And there is the 4 methods of the resettable interface:
   reset_init
   reset_release
   reset_hold
   reset_post
These methods are implemented by default to:
+ call the local version
+ call the sub-buses methods

We can choose to keep only the interface methods and let specialization
overrides them to do local stuff and call the DeviceClass's version to
also do sub-buses reset.

This approach simplify specialization because all the dirty things (like
handling "resetting flag") are done by the interface methods which do
not need to be overriden in normal use cases (only if we do not want to
call sub-buses reset for some reason).

The reason I initially "duplicate" the methods is because of
"device_reset" which currently only do local reset (in opposite to
qdev_reset_all) and is used at several places. I'm not sure at which
point we could drop this and have a single reset for devices: maybe such
devices such devices don't have sub-buses and therefore the distinction
is meaningless.

> 
>> # BusClass impact
>>
>> I don't think we need to add any new method to the bus. Since a bus has
>> no gpio, there is no propagation so phase hold/release/term are probably
>> meaningless here. Maybe a cold reset method is useful here ?
> 
> I suspect buses in general should also be using the same APIs. For
> instance a PCI controller can do a bus reset which should reset
> all the devices on the bus. We don't model the individual
> GPIO lines in a PCI bus connection but that doesn't mean there
> isn't a logical equivalent there. Our support for bus resets
> (mainly as you say SCSI and PCI) is basically a half-baked
> implementation of a reset domain.

I was not clear enough. BusClass also implements the Resettable
interface and has the 4 phase methods like DeviceClass that call reset
on sub-devices on the bus. But I don't think we need local version of
all these methods because there is no `bus_reset` function (like
device_reset) and hold/release/post phases will probably never need to
be overriden to do local stuff.

> 
>> # Impact on existing code
>>
>> There is not much impact. Basically the global qemu_reset should be
>> changed to handle Resetable objects with a global ResetDomain. Also the
>> 2 occurrences of qemu_register_reset(qbus_reset_all, ...) must be
>> replaced to add the buses in the global ResetDomain.
>>
>> qdev/qbus_reset_all/device_reset behavior will be changed to trigger
>> phase reset (instead of doing one dev/bus walk, there will be a walk per
>> reset phase). We can add the cold/warm parameter (and modify the places
>> were the functions are called) or choose a default (anyway until support
>> is added to devices, both are identical).
> 

Thanks,
Damien
