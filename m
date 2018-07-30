Received: from eggs.gnu.org ([2001:4830:134:3::10]:60908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkHOR-0002nx-PD
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 19:16:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkHOQ-0007DS-R0
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 19:15:59 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:41772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fkHOQ-0007D1-H0
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 19:15:58 -0400
Received: by mail-oi0-x241.google.com with SMTP id k12-v6so24478399oiw.8
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 16:15:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1807310055170.24147@zero.eik.bme.hu>
References: <20180730043904.17023-1-mail@sebastianbauer.info>
	<alpine.BSF.2.21.1807301254450.49677@zero.eik.bme.hu>
	<CAFEAcA_wxAbODS=voCunFYYMZdSG7jOuu7B-8mRhH15snGp6=A@mail.gmail.com>
	<alpine.BSF.2.21.1807310055170.24147@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Jul 2018 00:15:37 +0100
Message-ID: <CAFEAcA-tAewpxZZAh5vmB0ZRYGdoLHrBuZ14aW0Qczsp3gQZ7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] sam460ex: Fix PCI interrupt connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Sebastian Bauer <mail@sebastianbauer.info>, Alexander Graf <agraf@suse.de>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On 31 July 2018 at 00:00, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> On Mon, 30 Jul 2018, Peter Maydell wrote:
>>
>> On 30 July 2018 at 12:06, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>> I don't understand QOM. Does this really work? It will ultimately do
>>>
>>> qdev_connect_gpio_out_named(dev, SYSBUS_DEVICE_GPIO_IRQ, 0, uic[1][0]);
>>> qdev_connect_gpio_out_named(dev, SYSBUS_DEVICE_GPIO_IRQ, 1, uic[1][0]);
>>> qdev_connect_gpio_out_named(dev, SYSBUS_DEVICE_GPIO_IRQ, 2, uic[1][0]);
>>> qdev_connect_gpio_out_named(dev, SYSBUS_DEVICE_GPIO_IRQ, 3, uic[1][0]);
>>
>>
>> You are correct; this will not do the intended thing. If you
>> want to wire up multiple outputs which are logically ORed
>> together into a single input, you need to instantiate an
>> OR gate for that (we have the TYPE_OR_IRQ for this).
>
>
> Thanks for confirming it. However after reading hw/pci/pci.c I still don't
> see where these properties are used at all. It looks like it will just call
> the map_irq and set_irq functions specified in pci_register_root_bus passing
> them the irq array given in opaque and these will change irq lines directly.

When ppc4xx_pci_set_irq() calls qemu_set_irq() it passes it a
qemu_irq which is one of the s->irq[] which was initialized
via sysbus_init_irq(). The qdev_connect_gpio_out_named() calls
above are what connect those to the interrupt controller at the
other end of the line. Without them qemu_set_irq() does nothing
(because an initialized-but-never-connected qemu_irq is actually
a NULL pointer, and qemu_set_irq() exits doing nothing for NULL).

On the output end of a device, a qemu_irq connection is a QOM property
which is a link (pointer) property (a qemu_irq is a pointer to an
opaque struct). On the input end of a device, initializing an input
GPIO creates those opaque structs and sets the callback function
which will be invoked for a level change. The various functions for
wiring up gpio connections get a pointer to the input device's struct
and pass it to the output device by setting its QOM property.

> So I think we could just change the map function to map everything to the
> first line and then the other lines don't matter at all. We could even get
> rid of them and change ppc440_pcix to have a single line as used in the
> sam460ex (which is the only board using this model currently so we can add
> more complexity when/if anything else needs it to be different). Is there
> anything why this simple solution would not work that justifies adding more
> complexity now?

It would work. But creating an OR gate is half a dozen lines or so of
code, so it's not much more work than changing the PCI controller.
So we should prefer whichever is closest to what the real hardware
does, assuming we can determine that.

thanks
-- PMM
