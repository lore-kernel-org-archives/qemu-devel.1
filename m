Received: from eggs.gnu.org ([2001:4830:134:3::10]:51508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1eREE8-00067h-PA
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 04:30:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1eREDy-0002v4-Gb
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 04:30:20 -0500
Received: from mail-it0-x22b.google.com ([2607:f8b0:4001:c0b::22b]:39233)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1eREDy-0002uG-BX
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 04:30:10 -0500
Received: by mail-it0-x22b.google.com with SMTP id 68so2030727ite.4
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 01:30:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <40662a93-d86d-d814-6086-60c9cb485796@ilande.co.uk>
References: <1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1510926167-23326-12-git-send-email-mark.cave-ayland@ilande.co.uk>
	<CACXAS8D7kJ7sk3Z+72-PaUnWwLUK7Xwb1_zHUjQe0BXBaYoKyA@mail.gmail.com>
	<d1e0a801-f8ce-b726-4ea8-fbb4f11417ea@ilande.co.uk>
	<bc0ce243-e8aa-9f63-7c7c-68197b201209@ilande.co.uk>
	<CACXAS8A1-aEWqw9xoYKY6ebxU3GztBUG2UDVyCrwsVy_kcKWrw@mail.gmail.com>
	<40662a93-d86d-d814-6086-60c9cb485796@ilande.co.uk>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Tue, 19 Dec 2017 10:29:49 +0100
Message-ID: <CACXAS8BX0rHunEUf1ZDsY-EF7gxqXPRkWY3rFOf62GipUGerGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 11/15] apb: split pci_pbm_map_irq() into
 separate functions for bus A and bus B
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Tue, Dec 19, 2017 at 10:27 AM, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> On 19/12/17 07:56, Artyom Tarasenko wrote:
>>
>> On Sun, Dec 17, 2017 at 12:09 PM, Mark Cave-Ayland
>> <mark.cave-ayland@ilande.co.uk> wrote:
>>>
>>> On 19/11/17 11:06, Mark Cave-Ayland wrote:
>>>
>>>> On 17/11/17 14:33, Artyom Tarasenko wrote:
>>>>
>>>>> On Fri, Nov 17, 2017 at 2:42 PM, Mark Cave-Ayland
>>>>> <mark.cave-ayland@ilande.co.uk> wrote:
>>>>>>
>>>>>>
>>>>>> After the previous refactoring it is now possible to use separate
>>>>>> functions
>>>>>> to improve clarity of the interrupt paths. Similarly by checking the
>>>>>> PCI
>>>>>> devnfn to identify busA during apb_pci_bridge_realize() it becomes
>>>>>> possible
>>>>>> to completely remove the busA property from the PBMPCIBridge state.
>>>>>>
>>>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>>>> ---
>>>>>>    hw/pci-host/apb.c         |   54
>>>>>> ++++++++++++++++++---------------------------
>>>>>>    include/hw/pci-host/apb.h |    3 ---
>>>>>>    2 files changed, 21 insertions(+), 36 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
>>>>>> index 6c20285..268100e 100644
>>>>>> --- a/hw/pci-host/apb.c
>>>>>> +++ b/hw/pci-host/apb.c
>>>>>> @@ -517,32 +517,27 @@ static int pci_apb_map_irq(PCIDevice *pci_dev,
>>>>>> int
>>>>>> irq_num)
>>>>>>        return irq_num;
>>>>>>    }
>>>>>>
>>>>>> -static int pci_pbm_map_irq(PCIDevice *pci_dev, int irq_num)
>>>>>> +static int pci_pbmA_map_irq(PCIDevice *pci_dev, int irq_num)
>>>>>>    {
>>>>>> -    PBMPCIBridge *br = PBM_PCI_BRIDGE(pci_bridge_get_device(
>>>>>> -
>>>>>> PCI_BUS(qdev_get_parent_bus(DEVICE(pci_dev)))));
>>>>>> -
>>>>>> -    int bus_offset;
>>>>>> -    if (br->busA) {
>>>>>> -        bus_offset = 0x0;
>>>>>> +    /* The on-board devices have fixed (legacy) OBIO intnos */
>>>>>> +    switch (PCI_SLOT(pci_dev->devfn)) {
>>>>>> +    case 1:
>>>>>> +        /* Onboard NIC */
>>>>>> +        return 0x21;
>>>>>> +    case 3:
>>>>>> +        /* Onboard IDE */
>>>>>> +        return 0x20;
>>>>>> +    default:
>>>>>> +        /* Normal intno, fall through */
>>>>>> +        break;
>>>>>> +    }
>>>>>>
>>>>>> -        /* The on-board devices have fixed (legacy) OBIO intnos */
>>>>>> -        switch (PCI_SLOT(pci_dev->devfn)) {
>>>>>> -        case 1:
>>>>>> -            /* Onboard NIC */
>>>>>> -            return 0x21;
>>>>>> -        case 3:
>>>>>> -            /* Onboard IDE */
>>>>>> -            return 0x20;
>>>>>> +    return ((PCI_SLOT(pci_dev->devfn) << 2) + irq_num) & 0x1f;
>>>>>> +}
>>>>>>
>>>>>> -        default:
>>>>>> -            /* Normal intno, fall through */
>>>>>> -            break;
>>>>>> -        }
>>>>>> -    } else {
>>>>>> -        bus_offset = 0x10;
>>>>>> -    }
>>>>>> -    return (bus_offset + (PCI_SLOT(pci_dev->devfn) << 2) + irq_num) &
>>>>>> 0x1f;
>>>>>> +static int pci_pbmB_map_irq(PCIDevice *pci_dev, int irq_num)
>>>>>> +{
>>>>>> +    return (0x10 + (PCI_SLOT(pci_dev->devfn) << 2) + irq_num) & 0x1f;
>>>>>>    }
>>>>>>
>>>>>>    static void pci_apb_set_irq(void *opaque, int irq_num, int level)
>>>>>> @@ -593,7 +588,7 @@ static void apb_pci_bridge_realize(PCIDevice *dev,
>>>>>> Error **errp)
>>>>>>
>>>>>>        /* If initialising busA, ensure that we allow IO transactions
>>>>>> so
>>>>>> that
>>>>>>           we get the early serial console until OpenBIOS configures
>>>>>> the
>>>>>> bridge */
>>>>>> -    if (br->busA) {
>>>>>> +    if (dev->devfn == PCI_DEVFN(1, 1)) {
>>>>>
>>>>>
>>>>>
>>>>> I think the previous syntax was more explicit here. A comment would be
>>>>> nice.
>>>>
>>>>
>>>>
>>>> Yes it's definitely something that isn't immediately obvious, which is
>>>> why I left the above comment in place explaining what the if() branch is
>>>> doing. Is there something in the comment that isn't particularly clear?
>>>>
>>>> Note one of the reasons for wanting to remove the busA property is that
>>>> where possible I'd like to reduce the code in the IRQ path, and while
>>>> the existing code works I am still unsure of the additional overhead of
>>>> the 2 levels of QOM type checking that the current approach requires for
>>>> each IRQ.
>>>
>>>
>>>
>>> Hi Artyom,
>>>
>>> Thinking about this a bit more during freeze, this is actually doing the
>>> opposite of what we want, as it requires the device realise function to
>>> behave differently depending upon how it is related to the PCI bus.
>>>
>>> How about swapping this out for a qdev bool property for APB named
>>> "enable-early-pci-io-access", setting it just for the PCI_DEVFN(1, 1)
>>> device
>>> containing the ebus and then alter the if() statement above to enable PCI
>>> IO
>>> access if the qdev property is set?
>>
>>
>> This does sound reasonable. I wonder if this has to be a qdev property
>> though.
>> Doesn't the physical bridge have a software visible bit/register for it?
>
>
> Yes, we could enable the PCI IO transaction bit for that particular bridge
> after realize if that is acceptable?

Yes, please. I think it would be pretty close to what the real hw does.

-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu
