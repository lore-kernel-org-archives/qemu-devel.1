Received: from eggs.gnu.org ([2001:4830:134:3::10]:48823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1cyqJZ-0005l7-O4
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 21:46:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1cyqJW-0000OJ-KY
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 21:46:21 -0400
Received: from mail-he1eur01on0109.outbound.protection.outlook.com
	([104.47.0.109]:57504
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1cyqJV-0000Nk-Tk
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 21:46:18 -0400
Date: Fri, 14 Apr 2017 00:10:54 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20170413211049.GA3682@rkaganip.lan>
References: <20170411205813.GA4006@rkaganip.lan>
	<87inm91wo4.fsf@dusky.pond.sub.org>
	<20170412200720.GA27126@thinpad.lan.raisama.net>
	<20170413151533.GD14312@rkaganb.sw.ru>
	<20170413164457.GX32646@thinpad.lan.raisama.net>
	<CAFEAcA_VQGDXmMmcTdzwb-UA4sVF1jeXfnXyUBNnZU2E4jdUPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_VQGDXmMmcTdzwb-UA4sVF1jeXfnXyUBNnZU2E4jdUPw@mail.gmail.com>
Subject: Re: [Qemu-devel] vmbus bridge: machine property or device?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, Alexander
	Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>

On Thu, Apr 13, 2017 at 05:58:51PM +0100, Peter Maydell wrote:
> On 13 April 2017 at 17:44, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > On Thu, Apr 13, 2017 at 06:15:34PM +0300, Roman Kagan wrote:
> >> Can you (or anybody else) please help me decide if I need
> >> TYPE_SYS_BUS_DEVICE?  Logically the VMBus bridge is "attached directly
> >> to the main system bus" as written at the top of include/hw/sysbus.h.
> >
> > I think that documentation was written before we supported
> > bus-less devices.
> 
> The major question to ask to determine whether you need to be
> a sysbus device is how does the guest interact with this thing?
> In particular, does it have memory mapped registers (and is it
> not part of some other more specific interface like a PCI device) ?

The interaction happens through a set of dedicated MSRs, shared pages,
hypercalls, and "synthetic" interrupts (non-ioapic).  No pio, mmio,
gpio/irq.

VMBus annonces its presence by a device entry in ACPI with two IRQs;
we've seen no need to wire those IRQs so far, and the guests don't seem
to use them.  That's it; everything else is VMBus-specific.

> > I'm not sure about the consequences of simply connecting IRQs
> > inside ->realize() without using the sysbus *_irq helpers. I hope
> > others can clarify this.
> 
> Connecting what IRQs to what? If your device has an IRQ
> then it isn't the device's job to connect it up -- it is
> the job of the machine model, because only the machine
> model knows what the IRQ controller is, whether the IRQ
> needs to be advertised via ACPI or device tree, and so on.
> You can do that without sysbus though, by using the core
> DeviceState's qdev_init_gpio_* APIs. (NB that if you do
> this then you're by necessity not a device creatable
> with -device, since the board code has to wire you up.)
> 
> If you're not using sysbus then watch out for reset:
> all sysbus devices get automatically reset on QEMU
> system reset; if you're directly using the DeviceState
> baseclass then you have to arrange reset for yourself
> somehow.

Thanks!
Roman.
