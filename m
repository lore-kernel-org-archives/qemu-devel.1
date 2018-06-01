Received: from eggs.gnu.org ([2001:4830:134:3::10]:45983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <debby83729@gmail.com>) id 1fOdOF-00043w-Q9
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 02:18:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <debby83729@gmail.com>) id 1fOdOD-0007AR-Dh
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 02:18:19 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:50900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <debby83729@gmail.com>)
	id 1fOdOC-00079n-Vp
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 02:18:17 -0400
Received: by mail-wm0-x241.google.com with SMTP id t11-v6so773557wmt.0
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 23:18:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8RJU3bGfASekaUK647my-anu-gOBQiJFACi7+2u=UPOw@mail.gmail.com>
References: <CAG0V3WS2DemUdkP+HpZiYTOsPGRpAFCwZLNJ9CfA-VGv5bgKRQ@mail.gmail.com>
	<CAFEAcA8RJU3bGfASekaUK647my-anu-gOBQiJFACi7+2u=UPOw@mail.gmail.com>
From: Eva Chen <debby83729@gmail.com>
Date: Fri, 1 Jun 2018 14:17:54 +0800
Message-ID: <CAG0V3WRO4EnzKGk88LbVTSo2APdkch-3wm0hLBXkDYXOBuWa0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Questions about the flow of interrupt simulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

=E2=80=8B=E2=80=8B
Thanks deeply for your clear explanation!
Let me try to conclude what I learned from your description.

                    qemu_set_irq()                       qemu_set_irq()

[ device ]   ----------------->  [ GIC ]  ---------------------> [ CPU ]


Detailed:
[device]
=3D>qemu_set_irq()
[GIC]
=3D>gic_set_irq()
=3D>gic_update()
=3D>qemu_set_irq()
[CPU]
=3D> arm_cpu_set_irq()

GIC decides to send an irq to CPU or not depends on the level that device
sends or others reason like interrupt mask.
GIC turns the interrupt into an interrupt type:  ARM_CPU_HARD/FIQ/VIRQ/VFIQ=
.
In arm_cpu_set_irq(), it turns   ARM_CPU_HARD/FIQ/VIRQ/VFIQ into
CPU_INTERRUPT_HARD/FIQ/VIRQ/VFIQ.
cpu_interrupt() sets cpu->interrupt_request.

Then I have some following questions:
1. There are two kinds of interrupt:  edge triggered and level triggered.
I have seen two code segment related to the level: gic_set_irq() and
arm_cpu_set_irq().
In gic_set_irq(), if level =3D=3D GIC_TEST_LEVEL(irq, cm), which means the
level is not changed, will return.
In arm_cpu_set_irq() said that if level =3D=3D1, call cpu_interrupt(). if
level=3D=3D0, call cpu_reset_interrupt(), which will clean up that irq bits=
..
Does that mean all interrupt in arm are level triggered(high level)?
How to know the triggered type of interrupt?

2. interrupt signal will be passed through GIC from device to CPU. There
are four types of interrupt in CPU: CPU_INTERRUPT_HARD/FIQ/VIRQ/VFIQ.
Where exactly define the CPU_INTERRUPT_{type} that device's interrupt
corresponded?

3. I have seen others device's code under qemu/hw directory. Almost all
device will call qemu_set_irq() at the end of device's read/write. Is that
for the purpose of a device to tell CPU that it has done some works?
but the second parameter of qemu_set_irq(), level, will be set to a
different value(not always 1 or 0), which sometimes will cause the
interrupt return at gic_set_irq() instead of passing to CPU.
What does the interrupt at the end of device_read/write(device_update())
mean?

I think I might ask some basic questions of interrupt. If there is any
documents or tutorial about interrupt, please share with me,  I am willing
to study it.

Sincerely,
Eva


2018-05-24 21:40 GMT+08:00 Peter Maydell <peter.maydell@linaro.org>:

> On 23 May 2018 at 11:45, Eva Chen <debby83729@gmail.com> wrote:
> > Hi,
> >
> > I have added a new virtual device under qemu/hw, and a device driver in
> the
> > source code of guest OS (I use arm linux).
> > Since I want to add an interrupt to the virtual device, I am tracing th=
e
> > flow of interrupt simulation of QEMU.
> > However, I have some questions about the flow of interrupt, and wonderi=
ng
> > if I could ask here for some help.
> >
> > I use $qemu-system-aarch64 -machine virt.
> > Take the flow of interrupt that generated from the UART pl011 device as
> > example.
> > First an interrupt, CPU_INTERRUPT_HARD, will be sent from device to GIC
> for
> > telling CPU that this device finished some job, then this interrupt wii=
l
> be
> > transformed into EXCP_IRQ in aarch64_cpu_do_interrupt() and interrupt
> > handled by CPU.
>
> This isn't quite the way it works.
>
> What happens is more like:
>  * pl011 device calls qemu_set_irq() on its outbound IRQ line
>  * the board model has connected that line up to one of the GIC's
>    input lines
>  * the GIC function on the other end of the qemu_irq is called
>    and does the necessary processing of the input line state change.
>    (For the gicv2 this is the gic_set_irq() function.)
>  * if the GIC state is such that it should now signal an IRQ to
>    the CPU it will do that. (This is not necessarily going to happen:
>    for instance the interrupt might be disabled in the GIC, or
>    another higher priority interrupt might already be being signaled.)
>    The GIC does this by calling qemu_set_irq() on its outbound
>    IRQ or FIQ line.
>  * the CPU object on the other end of that IRQ or FIQ line will have
>    its arm_cpu_set_irq() function called. All this function does is
>    make a note so that we stop executing code and start doing
>    something else; we do that by calling cpu_interrupt(). We use
>    CPU_INTERRUPT_HARD/FIQ/VIRQ/VFIQ here to distinguish which of our
>    4 interrupt lines this is; nothing outside the CPU cares about
>    those names.
>  * cpu_interrupt() itself doesn't do anything, it just sets a flag
>    which the thread executing guest cpu code will check.
>  * in the guest-cpu-execution code path you have traced the relevant
>    flow here:
>    > 2. CPU handling : cpu_exec() =3D> arm_cpu_exec_interrupt() =3D>
>    > aarch64_cpu_do_interrupt()
>    > Guest CPU's pc (env->pc) will be changed to the address of interrupt
>    > service routine in aarch64_cpu_do_interrupt().
>
> Some notes:
>  (1) I've assumed GICv2 in the above; the GICv3 is a bit more complex
> but the basic idea is similar
>  (2) The GIC is a device model that is not "special" just because
> it happens to be an interrupt controller. It's just a model of a
> bit of hardware that has some input lines and some output lines,
> and sets the output lines as needed depending on what the input lines do.
> It happens that for an interrupt controller the input lines are
> interrupt lines from devices and the outputs are IRQ and FIQ to the CPU.
>  (3) qemu_irq is a generic facility that roughly models a signal or
> 'wire' between two QEMU devices. On the sending side, you call
> qemu_set_irq() to set the level. On the receiving side, a function
> which you registered is called whenever the level changes. In the
> board model code, you have to connect the two ends together.
>
> > The question is:
> > Will CPU execute the ISR that env->pc assigned?
>
> Yes. The emulated CPU here behaves exactly like hardware. When
> an interrupt is taken, the PC is set to the exception vector for
> it. (The exact address depends on whether the exception is a
> synchronous exception, SError, IRQ or FIQ; which exception level
> we are taking the exception to; and the value in the VBAR register.)
>
> It is up to the guest to have put some useful code at that address.
> If it has not, then we will start executing whatever garbage was
> at that address. (if that garbage is all-zeroes, then we'll take
> an immediate exception because that's not a valid A64 instruction,
> and likely go into an infinite loop of taking exceptions. This is
> the same as what the hardware does in that situation.)
>
> If your guest OS is Linux then it will have installed handlers
> for these exceptions.
>
> > The reason that I have this question is that I look into the cpu_exec()=
,
> > find that tb_find() will be executed after handling an interrupt. At th=
is
> > time, the ISR address in env->pc should be replaced by the TB that is
> going
> > to be executed. However, I don't know how to check my thought since I
> can't
> > debug of execution in the TB so I ask for some help here.
>
> This is correct, but you shouldn't usually need to look into QEMU's
> internals at this low a level. You can debug either using QEMU's
> gdb debugstub, or by using the -d options to enable tracing of
> events like execution, interrupts and so on.
>
> thanks
> -- PMM
>
