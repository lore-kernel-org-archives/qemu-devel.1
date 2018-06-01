Received: from eggs.gnu.org ([2001:4830:134:3::10]:55281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOgJU-0005H2-5u
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:25:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOgJS-0006Z6-N6
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:25:36 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:37545)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fOgJS-0006YE-1T
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:25:34 -0400
Received: by mail-ot0-x242.google.com with SMTP id 101-v6so6066368oth.4
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 02:25:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAG0V3WRO4EnzKGk88LbVTSo2APdkch-3wm0hLBXkDYXOBuWa0w@mail.gmail.com>
References: <CAG0V3WS2DemUdkP+HpZiYTOsPGRpAFCwZLNJ9CfA-VGv5bgKRQ@mail.gmail.com>
	<CAFEAcA8RJU3bGfASekaUK647my-anu-gOBQiJFACi7+2u=UPOw@mail.gmail.com>
	<CAG0V3WRO4EnzKGk88LbVTSo2APdkch-3wm0hLBXkDYXOBuWa0w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Jun 2018 10:25:12 +0100
Message-ID: <CAFEAcA9nfL6UwiZO6USfLuNH_yg3CMk=ngnrwVXC=DgVnjv9wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Questions about the flow of interrupt simulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eva Chen <debby83729@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 1 June 2018 at 07:17, Eva Chen <debby83729@gmail.com> wrote:
> 1. There are two kinds of interrupt:  edge triggered and level triggered.
> I have seen two code segment related to the level: gic_set_irq() and
> arm_cpu_set_irq().
> In gic_set_irq(), if level == GIC_TEST_LEVEL(irq, cm), which means the
> level is not changed, will return.
> In arm_cpu_set_irq() said that if level ==1, call cpu_interrupt(). if
> level==0, call cpu_reset_interrupt(), which will clean up that irq bits..
> Does that mean all interrupt in arm are level triggered(high level)?
> How to know the triggered type of interrupt?

This is mixing up interrupts in two different places. For the Arm
architecture, IRQ and FIQ are always level-sensitive: the thing
which sets them (the GIC, typically) has to set them and keep them
set until the CPU acknowledges them.

For the GIC, its input interrupts may be either level sensitive or
edge sensitive. This is configurable for each interrupt on GICv2 by
writing to the GICD_ICFGRn registers. The gic_set_irq() code implements
the behaviour that the GIC specification requires, depending on whether
the ICFGRn register says that interrupt should be edge or level
triggered.

Other interrupt controllers that QEMU models may behave differently.
(For instance the ARMv7M NVIC is different again.)

> 2. interrupt signal will be passed through GIC from device to CPU. There
> are four types of interrupt in CPU: CPU_INTERRUPT_HARD/FIQ/VIRQ/VFIQ.
> Where exactly define the CPU_INTERRUPT_{type} that device's interrupt
> corresponded?

Again, this is configurable by the guest by writing to GIC registers.
In the GICv2, the GICD_IGROUPRn registers set the whether the interrupt
should be in "group 0" or "group 1". Group 1 interrupts always
cause an IRQ; group 0 interrupts cause either IRQ or FIQ depending
on the setting of the GICC_CTLR FIQEn bit. (The expected use is that
interrupts configured for use with the TrustZone Secure World will
use FIQ and those configured for use with the NonSecure World will
use IRQ.)

VIRQ and VFIQ are for when the GIC and CPU support the Virtualization
Extension.

The behaviour of all of this is defined by the GIC specification;
QEMU just has to implement what the hardware does.

> 3. I have seen others device's code under qemu/hw directory. Almost all
> device will call qemu_set_irq() at the end of device's read/write. Is that
> for the purpose of a device to tell CPU that it has done some works?
> but the second parameter of qemu_set_irq(), level, will be set to a
> different value(not always 1 or 0), which sometimes will cause the
> interrupt return at gic_set_irq() instead of passing to CPU.
> What does the interrupt at the end of device_read/write(device_update())
> mean?

The best way to think of this is not to try to think about whether
the interrupt line is connected to the CPU or anything else. Just
think about a device model as being an emulation of a particular
bit of hardware. For instance, take the pl011 UART. The specification
for that UART says that when certain conditions inside the device are
true, the UART will assert its outgoing interrupt line. So our model
also must check those conditions and call qemu_set_irq() to raise
and lower the interrupt at the right time. The common way to code
this is to have a function which is called whenever any of the
relevant state has changed, which rechecks the conditions and calls
qemu_set_irq(). The "purpose" of this code is just to behave the
way the hardware behaves.

Commonly, the output IRQ line from a device is connected to an
interrupt controller and thus to a CPU, but it doesn't have to be.
On some boards, the IRQ line might not be connected to anything.
Or it might be connected up to some other device which provides its
value to the guest via a status register. Or perhaps it's ORed together
with lines from other devices and the output of the OR gate goes
to the interrupt controller. If you're designing a board in real
hardware, you are taking various components (UART, interrupt
controller, etc) and connecting them up to implement a useful design.
In QEMU, we also take various components and connect them up, to
produce the same design the hardware has.

qemu_set_irq() is usually just modelling what in the hardware is a
simple wire. The source end calls this function to say "the wire
is at logical 0/1", and on the destination end a function is called
to handle that. It is also possible to pass in a value other than
0 or 1. This happens in two cases:
 (1) a bug, where the source end really ought to be using 0 or 1;
often this doesn't have any visible bad effects because the
destination end is testing 0 vs not-0, rather than 0 vs 1
 (2) we really do want to transfer an integer rather than just
a 0-vs-1 level. This is less common and only happens when both
ends of the "wire" know that that's the convention they want to use.

I think the overall theme of my reply is that fundamentally
QEMU is modelling hardware. If you want to understand why
parts of QEMU are connected the way they are, or why they
behave in a particular way, then looking at what the
specification of the hardware is and how the hardware is
connected, will often help a lot.

thanks
-- PMM
