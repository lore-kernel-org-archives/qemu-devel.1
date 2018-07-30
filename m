Received: from eggs.gnu.org ([2001:4830:134:3::10]:58677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fkH9o-0006XO-MQ
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 19:00:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fkH9l-0001VV-LF
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 19:00:52 -0400
Date: Tue, 31 Jul 2018 01:00:46 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA_wxAbODS=voCunFYYMZdSG7jOuu7B-8mRhH15snGp6=A@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.1807310055170.24147@zero.eik.bme.hu>
References: <20180730043904.17023-1-mail@sebastianbauer.info>
	<alpine.BSF.2.21.1807301254450.49677@zero.eik.bme.hu>
	<CAFEAcA_wxAbODS=voCunFYYMZdSG7jOuu7B-8mRhH15snGp6=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH] sam460ex: Fix PCI interrupt connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Sebastian Bauer <mail@sebastianbauer.info>, Alexander Graf <agraf@suse.de>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On Mon, 30 Jul 2018, Peter Maydell wrote:
> On 30 July 2018 at 12:06, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> On Mon, 30 Jul 2018, Sebastian Bauer wrote:
>>>
>>> The four interrupts of the PCI bus are connected to the same UIC pin on
>>> the
>>> real Sam460ex. Evidence for this can be found in the UBoot source for the
>>> Sam460ex in the Sam460ex.c file where PCI_INTERRUPT_LINE in written. This
>>> change brings the connection in line with this.
>>>
>>> This fixes the problem that can be observed when adding further PCI cards
>>> that get their interrupt rotated to other interrupts than PCI INT A. In
>>> particular, the bug was observed and verified to be fixed (after this
>>> change) with an additional OHCI PCI card.
>>>
>>> Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>
>>> ---
>>> hw/ppc/sam460ex.c | 4 ++--
>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
>>> index 0999efcc1e..b2b22f280d 100644
>>> --- a/hw/ppc/sam460ex.c
>>> +++ b/hw/ppc/sam460ex.c
>>> @@ -515,9 +515,9 @@ static void sam460ex_init(MachineState *machine)
>>>
>>>     /* PCI bus */
>>>     ppc460ex_pcie_init(env);
>>> -    /* FIXME: is this correct? */
>>> +    /* All PCI ints are connected to the same UIC pin (cf. UBoot source)
>>> */
>>>     dev = sysbus_create_varargs("ppc440-pcix-host", 0xc0ec00000,
>>> -                                uic[1][0], uic[1][20], uic[1][21],
>>> uic[1][22],
>>> +                                uic[1][0], uic[1][0], uic[1][0],
>>> uic[1][0],
>>
>>
>> I don't understand QOM. Does this really work? It will ultimately do
>>
>> qdev_connect_gpio_out_named(dev, SYSBUS_DEVICE_GPIO_IRQ, 0, uic[1][0]);
>> qdev_connect_gpio_out_named(dev, SYSBUS_DEVICE_GPIO_IRQ, 1, uic[1][0]);
>> qdev_connect_gpio_out_named(dev, SYSBUS_DEVICE_GPIO_IRQ, 2, uic[1][0]);
>> qdev_connect_gpio_out_named(dev, SYSBUS_DEVICE_GPIO_IRQ, 3, uic[1][0]);
>
> You are correct; this will not do the intended thing. If you
> want to wire up multiple outputs which are logically ORed
> together into a single input, you need to instantiate an
> OR gate for that (we have the TYPE_OR_IRQ for this).

Thanks for confirming it. However after reading hw/pci/pci.c I still don't 
see where these properties are used at all. It looks like it will just 
call the map_irq and set_irq functions specified in pci_register_root_bus 
passing them the irq array given in opaque and these will change irq lines 
directly. So I think we could just change the map function to map 
everything to the first line and then the other lines don't matter at all. 
We could even get rid of them and change ppc440_pcix to have a single line 
as used in the sam460ex (which is the only board using this model 
currently so we can add more complexity when/if anything else needs it to 
be different). Is there anything why this simple solution would not work 
that justifies adding more complexity now?

Regards,
BALATON Zoltan
