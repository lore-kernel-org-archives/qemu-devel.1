Received: from eggs.gnu.org ([2001:4830:134:3::10]:55305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fkGnU-0000gI-C7
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 18:37:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fkGnQ-0008Sl-Df
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 18:37:48 -0400
Date: Tue, 31 Jul 2018 00:37:34 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <fbaa741e42e50457a0ba9c7654e1d03d@sebastianbauer.info>
Message-ID: <alpine.BSF.2.21.1807310009440.24147@zero.eik.bme.hu>
References: <20180730043904.17023-1-mail@sebastianbauer.info>
	<alpine.BSF.2.21.1807301254450.49677@zero.eik.bme.hu>
	<fbaa741e42e50457a0ba9c7654e1d03d@sebastianbauer.info>
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
To: Sebastian Bauer <mail@sebastianbauer.info>
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, agraf@suse.de, qemu-ppc@nongnu.org

On Mon, 30 Jul 2018, Sebastian Bauer wrote:
> Am 2018-07-30 13:06, schrieb BALATON Zoltan:
>> On Mon, 30 Jul 2018, Sebastian Bauer wrote:
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
>> I don't understand QOM. Does this really work? It will ultimately do
>> 
>> qdev_connect_gpio_out_named(dev, SYSBUS_DEVICE_GPIO_IRQ, 0, uic[1][0]);
>> qdev_connect_gpio_out_named(dev, SYSBUS_DEVICE_GPIO_IRQ, 1, uic[1][0]);
>> qdev_connect_gpio_out_named(dev, SYSBUS_DEVICE_GPIO_IRQ, 2, uic[1][0]);
>> qdev_connect_gpio_out_named(dev, SYSBUS_DEVICE_GPIO_IRQ, 3, uic[1][0]);
>> 
>> which will call for each of these
>> 
>> object_property_set_link(dev, uic[1][0], "some name", &errp);
>
> I don't know QOM myself, but my research was that "some name" is different on 
> each invocation. So you associate the same value to the same object (dev) 
> under a property different name. What was not obvious to me was who is the 
> owner of the value. But according to the doc QOM has the notation of strong 
> references, but it is not created like that in qdev_connect_gpio_out_named(). 
> So I assume that it is weak reference and the parent is not the owner.

Yes, you are right, different name is generated for each irq line. But all 
this does not seem to matter because at the end irqs are raised/lowered 
directly in the irq array through functions passed when calling 
pci_register_root_bus so I'm not sure what these properties are used for 
if they are used at all so their value probably don't matter.

>> Would this correctly add all device interrupts to the uic[1][0] irq or
>> will this replace it so only the last line will be connected instead
>> of the first after this patch? Could someone with more understanding
>> about QOM confirm this?
>
> I don't know how this affects QOM, but as I see it the PCI bus has four 
> interrupts and so you need to specify all of them (and specifying wrong ones 
> seems to be not ideal either). The code assumes this throughout, e.g., see 
> ppc440_pcix_initfn().

I think the number of irq lines could be set, the functions have an nirq 
or num_irq parameters so the 4 lines is only assumed because PCI defines 
that and this is what's modelled but we could use different value here. 
Sam460ex seems to connect all four PCI irq lines to a single irq but I'm 
not sure what's the best way to model this (implementing 1 line in 
ppc440_pcix model or trying to merge these at some higher level). Using 
wrong irq lines is definitely wrong and was only left there because I had 
no clue about this when I've written that so your patch is definitely 
closer to what the board does.

> As I have written in the commit log, I tested this change. I used two cards, 
> the (default) SATA and the OHCI controller and everything was working nicely 
> (contrary to the previous state where only the SATA card worked because this 
> was put into slot 1). Did you have a chance to test it yourself?

I could not test it yet, I was trying to understand the code instead to 
make sure it works than just verifying it fixes one particular problem 
which I believe you've done.

>> If this does not work this way would mapping all PCI interrupts to
>> first line in ppc440_pcix_map_irq at hw/ppc/ppc440_pcix.c:417 and
>> assign only that to uic[1][0] be a better fix?
>
> I thought about this, but then it needs to passed that we are dealing with a 
> SAM board, which seems to be more complicated than this solution. You also 
> would need to adjust that ppc440_pcix_initfn() and I'm not sure if it is 
> possible to register a root PCI bus with only one interrupt and how the 
> remaining code deals with that. Overall, this solution seem to be much 
> simpler. Of course, if it doesn't work the way I proposed it must be changed 
> again.

The ppc440_pcix model is only used on the sam460ex so I think we can 
change it to model that and care about other cases when/if another SoC is 
added that has this part with different irqs just to keep things simple.

> But thinking more about it, what it is indeed not so clear to me is how the 
> interrupt states are logical combined. The hardware most likely would do an 
> "or" (but it is difficult to verify this without schematics), not sure what 
> QEMU does. It may just forward the level change which would be not the right 
> thing of course. I'll investigate it. The behaviour would still be better 
> than the previous state as usually both interrupt handlers are invoked, so no 
> interrupt will be missed.

I was trying to read hw/pci/pci.c to find out what would specifying the 
same irq multiple times do but I'm still not sure I could undestand it 
completely. AFAIU it will call the map_irq and set_irq functions specified 
in pci_register_root_bus. When we have the same irq in multiple lines 
theoretically it may happen that one slot is raising the interrupt and 
another is lowering another line which would change the same line here but 
I'm not sure how this is synchronised and if this could cause any problem.

Probably we can just change the map function in ppc440_pcix.c to always 
return the first line then what's specified for other lines should not 
matter and the above problem is avoided. We could even get rid of those 
additional irqs by changing ppc440_pcix.c to only model a single line but 
I'd need someone with better understanding of this to confirm that I got 
this right.

David, who should we ask to get advice on this?

Regards,
BALATON Zoltan
