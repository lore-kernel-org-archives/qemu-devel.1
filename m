Received: from eggs.gnu.org ([2001:4830:134:3::10]:37018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1gZHFF-0006tG-SH
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:25:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1gZHFE-0004lX-Fs
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:25:17 -0500
References: <20181002142443.30976-1-damien.hedde@greensocs.com>
	<09e1483c-298e-d41a-f9c9-4f186f530dcb@greensocs.com>
	<CAFEAcA9cNMiB01hSerawnfZsyXbJsrJYs_vFfWMi294XYeV8Zw@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <bb9c73c9-68e8-42f4-1e5f-f476b447db06@greensocs.com>
Date: Tue, 18 Dec 2018 16:24:54 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9cNMiB01hSerawnfZsyXbJsrJYs_vFfWMi294XYeV8Zw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 0/9] Clock framework API.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>, Sai Pavan Boddu <saipava@xilinx.com>, Mark Burton <mark.burton@greensocs.com>, Luc Michel <luc.michel@greensocs.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>



On 10/16/18 5:48 PM, Peter Maydell wrote:
> On 12 October 2018 at 16:26, Damien Hedde <damien.hedde@greensocs.com> wrote:
>> Hi Peter,
>>
>> Sorry to bother you with this, but you said some time ago you would
>> write something about reset.
> 
> Yeah, sorry about that. I haven't found (made) the time to think
> the issues through yet. Let me just dump to email the notes I had.
> This is a very "raw" set of notes, so it's not very organised and
> has a lot of 'todo' bits in it...
> 
> 
> Overall question -- does anybody know of other device modelling
> systems that do a good job of modelling reset, and how they do it?
> If we can borrow a proven design that might be better tha
> thrashing one out ourseles...
> 
> 
> My idea was roughly that we need a multi-phase reset, something like:
> 
>  PHASE 1:
>    Devices reset internal state. No calls out to other devices
>    (ie no setting IRQ line state, etc)
>    Some common bit of code (dev base class?) marks the device
>    reset as being in-progress by setting dev->resetting = true.
> 
>  PHASE 2:
>    Devices update their output lines (calls to irq line setting
>    functions, clock setting, etc)
>    In this phase devices may be the recipients of callbacks for
>    IRQ line level changes, etc, and must cope with this. A
>    callback can tell it's being called for a level change during
>    reset because dev->resetting will be true.
>    (They can update their own outputs in response to input changes.)
> 
>  PHASE 3:
>    Common code (dev base class) sets dev->resetting = false.
>    (Individual devices don't get to do anything here, unless
>    there's some painful case that requires it.)
> 
> The theory is that by decoupling reset into multiple phases
> we can avoid most of the reset order issues, by having the
> two ends do things in the right phase and/or by having
> the destination end be able to identify when a change is
> happening in the middle of reset.

This strategy seems fine to me.

> 
> Compatibility with existing device reset methods:
> essentially the current rules are the same as the "phase 1"
> rules, so we can just say that the current reset code in
> all devices is phase 1 reset. Then we can adjust anything
> that needs a phase 2 (which is probably not all that many
> devices).
> 
> Places where reset order currently matters:
> (this is just a list of things we should make sure our design
> copes with)
>  * wired-high IRQ lines, and device outputs that are asserted
>    as the device comes out of reset
>  * setting PC in the generic-loader device vs CPU reset
>  * image load (rom image reset) vs Arm M-profile reset wanting
>    to read the reset PC/SP from memory
>  * Arm M-profile CPUs should have INITVTOR as a config signal input
>  * x86 CPU vs APIC reset order ??
>  * anything else?
> 
> We should have some sort of "reset domain" object which can
> contain devices and also other reset domains. A reset domain's
> reset is simple: its phase 1 reset is "for each child, do
> phase 1 reset for that child", similarly for phases 2 and 3.
> A reset domain has an overall "reset" method that says
> "do phase 1 for all children, then phase 2, then phase 3".
> This allows things like "this SoC has a reset line which
> resets all its internal devices". (Do we want to give
> reset domains input gpio lines to trigger reset, or is
> being able to call a method on it sufficient?)

Consider the following use case: a platform with a controller that holds
a reset line on another device (starting with reset held).
At the beginning, the main (cold) reset will be triggered to start the
platform. During phase 2, the controller will set the reset line of the
other device (a gpio). Then we have phase 3. How do we handle this ?
Do we need to "delay" the phase 3 of the device until the controller
releases its reset line or do we consider the internal gpio reset line
to be outside of this reset scope ?

If we do that, we have 2 reset "sources": the main reset and the
internal gpio and there is some kind of OR operation to do between these
2 sources.

> 
> At the moment we have reset methods on devices:
>  * each bus handles reset for the things on the bus
>  * the (one and only) sysbus resets all the sysbus devices
>  * devices on no bus don't get reset at all unless something
>    takes special measures! (notably the CPUs are reset in
>    a very ad-hoc way at the moment)
> I guess this should be cleaned up by making each bus be
> a 'reset domain', and having a "system" reset domain which gets
> anything which doesn't have a parent reset domain (and which
> we then use for whole-board power-on reset). Calling the
> system reset domain's overall reset method will then do
> the 3-phase reset for everything>
> How would direct qemu_register_reset() calls fit into this
> scheme? (Some of them are devices that could get QOM reset
> methods instead. Perhaps we could get away with dumping the
> rest into the 'master reset' domain, or leaving them as-is?
> Some are for CPU reset which we definitely should clean up.)
> 
> We need to handle different types of reset somehow, in
> particular "cold/power on reset" versus "warm reset".
> Can we do this just with reset domain objects, or do we
> need/want to pass each device's reset method a "type" argument?

Maybe phase 1 only needs the type, phase 2 and 3 can only depends on the
device state.

Anyway, this reset problem seems outside of the scope of this patch set.
I think I'll do a reroll with the remark I've got so far, but it will
still miss the reset part to be well integrated. I can also propose
something in another rfc about the 3-phase reset to advance on that part.

--
Damien
