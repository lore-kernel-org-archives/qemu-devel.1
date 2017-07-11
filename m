Received: from eggs.gnu.org ([2001:4830:134:3::10]:49116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dUvMK-0002PV-6q
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:37:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dUvMI-0003ZH-V1
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:37:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dUvMI-0003Yl-JN
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:37:46 -0400
References: <1499413442-5053-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1499413442-5053-4-git-send-email-mark.cave-ayland@ilande.co.uk>
	<f0b5fca6-172d-d75b-7ade-2906601ed6ee@redhat.com>
	<93f86c66-e189-ab1e-b055-27f040d497c6@ilande.co.uk>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <068442cf-957a-a356-3b0d-6662f5eb2af8@redhat.com>
Date: Tue, 11 Jul 2017 16:37:37 +0300
MIME-Version: 1.0
In-Reply-To: <93f86c66-e189-ab1e-b055-27f040d497c6@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] pci: add reserved slot check to
 do_pci_register_device()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, mst@redhat.com, armbru@redhat.com

On 10/07/2017 16:05, Mark Cave-Aland wrote:
> On 10/07/17 08:35, Marcel Apfelbaum wrote:
> 
>> On 07/07/2017 10:44, Mark Cave-Ayland wrote:
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> ---
>>>    hw/pci/pci.c |   21 ++++++++++++++++++---
>>>    1 file changed, 18 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>> index 239161e..9dece2a 100644
>>> --- a/hw/pci/pci.c
>>> +++ b/hw/pci/pci.c
>>> @@ -961,6 +961,15 @@ static bool pci_bus_devfn_available(PCIBus *bus,
>>> int devfn)
>>>        }
>>>    }
>>>   
>>
>> Hi Mark,
>>
>>
>>> +static bool pci_bus_devfn_reserved(PCIBus *bus, int devfn)
>>> +{
>>> +    if (bus->dev_reserved_mask & (1UL << PCI_SLOT(devfn))) {
>>
>> Looking at this code maybe we should rename the field to
>> "slot_mask"? Only a suggestion.
> 
> Interestingly enough, I did start with that initially but then
> discovered that "slot_mask" is ambiguous - does the bit in the mask tell
> you whether the slot is free, or whether the slot is available?
> 
> The use of the "dev" prefix was to match the use of the devfn parameter,
> however if you're happy with just a "slot" prefix then would you be okay
> with "slot_reserved_mask"?

Sounds good, thanks.

> 
>>> +        return true;
>>> +    } else {
>>> +        return false;
>>> +    }
>>> +}
>>> + >   /* -1 for devfn means auto assign */
>>>    static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus
>>> *bus,
>>>                                             const char *name, int devfn,
>>> @@ -984,14 +993,20 @@ static PCIDevice
>>> *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
>>>        if (devfn < 0) {
>>>            for(devfn = bus->devfn_min ; devfn < ARRAY_SIZE(bus->devices);
>>>                devfn += PCI_FUNC_MAX) {
>>> -            if (pci_bus_devfn_available(bus, devfn)) {
>>> +            if (pci_bus_devfn_available(bus, devfn) &&
>>> +                   !pci_bus_devfn_reserved(bus, devfn)) {
>>>                    goto found;
>>>                }
>>>            }
>>> -        error_setg(errp, "PCI: no slot/function available for %s, all
>>> in use",
>>> -                   name);
>>> +        error_setg(errp, "PCI: no slot/function available for %s, all
>>> in use "
>>> +                   "or reserved", name);
>>
>> I wouldn't combine slot available/reserved, maybe check for reserved
>> before "available"?
> 
> I did think about doing separate reserved/available checks, but it
> doesn't seem to make sense in the code above.
> 
> By passing devfn == -1 the caller is asking for the next free slot, if
> there is one available. Whether the slot is reserved or occupied makes
> no difference to the fact that the slot is itself unavailable. All the
> change does here is alter the error message to provide hint that while
> no slot was available, it could be because all slots were in use or
> reserved.

Agreed, sorry for the noise.

Thanks,
Marcel

> When you mention to check for reserved before available, do you mean to
> swap the order of the arguments in the if() statement?
> >>
>>>            return NULL;
>>>        found: ;
>>> +    } else if (pci_bus_devfn_reserved(bus, devfn)) {
>>> +        error_setg(errp, "PCI: slot %d function %d not available for
>>> %s,"
>>> +                   " reserved",
>>> +                   PCI_SLOT(devfn), PCI_FUNC(devfn), name);
>>> +        return NULL;
>>>        } else if (!pci_bus_devfn_available(bus, devfn)) {
>>>            error_setg(errp, "PCI: slot %d function %d not available for
>>> %s,"
>>>                       " in use by %s",
>>>
>>
>> Thanks for the patches!
>> Marcel
> 
> 
> ATB,
> 
> Mark.
> 
