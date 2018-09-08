Received: from eggs.gnu.org ([2001:4830:134:3::10]:60836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fyYuj-0004Uo-A9
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 04:48:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fyYuf-0007Me-57
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 04:48:21 -0400
References: <20180827110544.12256-1-mark.cave-ayland@ilande.co.uk>
	<alpine.BSF.2.21.1808271903170.61025@zero.eik.bme.hu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <df6be48b-1bff-b48e-d698-da1c6fea7961@ilande.co.uk>
Date: Sat, 8 Sep 2018 09:47:55 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1808271903170.61025@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] 40p: fix PCI interrupt routing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-ppc@nongnu.org, hpoussin@reactos.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On 27/08/18 18:12, BALATON Zoltan wrote:

> On Mon, 27 Aug 2018, Mark Cave-Ayland wrote:
>> According to the PReP specification section 6.1.6 "System Interrupt
>> Assignments", all PCI interrupts are routed via IRQ 15.
>>
>> With this patch applied it is now possible to boot the sandalfoot
>> zImage all the way through to a working userspace when using
>> OpenBIOS.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>> hw/ppc/prep.c | 9 +++++----
>> 1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
>> index 162b27a3b8..e82c1355d9 100644
>> --- a/hw/ppc/prep.c
>> +++ b/hw/ppc/prep.c
>> @@ -668,10 +668,11 @@ static void ibm_40p_init(MachineState *machine)
>>     dev = DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(11, 0), "i82378"));
>>     qdev_connect_gpio_out(dev, 0,
>>                           cpu->env.irq_inputs[PPC6xx_INPUT_INT]);
>> -    sysbus_connect_irq(pcihost, 0, qdev_get_gpio_in(dev, 15));
>> -    sysbus_connect_irq(pcihost, 1, qdev_get_gpio_in(dev, 13));
>> -    sysbus_connect_irq(pcihost, 2, qdev_get_gpio_in(dev, 15));
>> -    sysbus_connect_irq(pcihost, 3, qdev_get_gpio_in(dev, 13));
>> +    /* According to PReP specification section 6.1.6 "System Interrupt
>> +     * Assignments", all PCI interrupts are routed via IRQ 15 */
>> +    for (i = 0; i < PCI_NUM_PINS; i++) {
>> +        sysbus_connect_irq(pcihost, i, qdev_get_gpio_in(dev, 15));
>> +    }
> 
> I'm not sure but this looks similar to what we had with sam460ex:
> 
> http://lists.nongnu.org/archive/html/qemu-ppc/2018-07/msg00359.html
> 
> I think you may not connect multiple interrupts to the same host irq
> line this way but you either need an OR gate or handle it within the
> mapping in the PCI host model (which is what we ended up with for the
> sam460ex). Peter's suggestion was to do whichever matches real hardware
> the most if you can find out that (as noted here also with more
> explanation that could be useful):
> 
> http://lists.nongnu.org/archive/html/qemu-ppc/2018-07/msg00360.html
> 
> But I could be mistaken in this case, haven't checked it in detail.

Thanks for the pointer. I now have a follow-up patchset that implements
this, however it seems the real 40p machine has a routing quirk: the LSI
SCSI device is separately routed to IRQ 13. So while it's not quite a
pure OR of the 4 PCI IRQs, it's fairly close...


ATB,

Mark.
