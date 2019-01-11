Received: from eggs.gnu.org ([209.51.188.92]:34929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <si-wei.liu@oracle.com>) id 1ghqwe-0004FT-P9
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 02:09:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <si-wei.liu@oracle.com>) id 1ghqwX-0003wX-7k
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 02:09:28 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:44636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <si-wei.liu@oracle.com>)
	id 1ghqwR-0003qh-QK
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 02:09:22 -0500
References: <1546900184-27403-1-git-send-email-venu.busireddy@oracle.com>
	<1546900184-27403-3-git-send-email-venu.busireddy@oracle.com>
	<20190109105223-mutt-send-email-mst@kernel.org>
	<e496ce78-462d-7675-9e97-6cbac2038489@oracle.com>
	<20190110220906-mutt-send-email-mst@kernel.org>
From: si-wei liu <si-wei.liu@oracle.com>
Message-ID: <85064076-89af-028d-a614-e20f64830a66@oracle.com>
Date: Thu, 10 Jan 2019 23:09:09 -0800
MIME-Version: 1.0
In-Reply-To: <20190110220906-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v3 2/5] virtio_net: Add
 support for "Data Path Switching" during Live Migration.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Venu Busireddy <venu.busireddy@oracle.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org



On 01/10/2019 07:20 PM, Michael S. Tsirkin wrote:
> On Thu, Jan 10, 2019 at 06:09:23PM -0800, si-wei liu wrote:
>>
>> On 01/09/2019 07:56 AM, Michael S. Tsirkin wrote:
>>> On Mon, Jan 07, 2019 at 05:29:41PM -0500, Venu Busireddy wrote:
>>>> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
>>>> index 80d42e1..2a3ffd3 100644
>>>> --- a/hw/acpi/pcihp.c
>>>> +++ b/hw/acpi/pcihp.c
>>>> @@ -176,6 +176,25 @@ static void acpi_pcihp_eject_slot(AcpiPciHpState *s, unsigned bsel, unsigned slo
>>>>        }
>>>>    }
>>>> +static void acpi_pcihp_cleanup_failover_primary(AcpiPciHpState *s, int bsel)
>>>> +{
>>>> +    BusChild *kid, *next;
>>>> +    PCIBus *bus = acpi_pcihp_find_hotplug_bus(s, bsel);
>>>> +
>>>> +    if (!bus) {
>>>> +        return;
>>>> +    }
>>>> +    QTAILQ_FOREACH_SAFE(kid, &bus->qbus.children, sibling, next) {
>>>> +        DeviceState *qdev = kid->child;
>>>> +        PCIDevice *pdev = PCI_DEVICE(qdev);
>>>> +        int slot = PCI_SLOT(pdev->devfn);
>>>> +
>>>> +        if (pdev->failover_primary) {
>>>> +            s->acpi_pcihp_pci_status[bsel].down |= (1U << slot);
>>>> +        }
>>>> +    }
>>>> +}
>>>> +
>>>>    static void acpi_pcihp_update_hotplug_bus(AcpiPciHpState *s, int bsel)
>>>>    {
>>>>        BusChild *kid, *next;
>>> So the result here will be that device will be deleted completely,
>>> and will not reappear after guest reboot.
>> The management stack will replug the VF until seeing the STANDBY_CHANGED
>> "enabled" event after guest driver finishes feature negotiation and sets
>> driver_ok.
>>
>>> I don't think this is what we wanted.
>>> I think we wanted a special state that will hide device from guest until
>>> guest acks the failover bit.
>> What do we get by hiding? On the next reboot after system reset guest may
>> load an older OS instance without standby advertised. The VF can't be
>> plugged out then?
>>
>> The model we adopt here doesn't pair virtio with VF in the QEMU level. If
>> the VF isn't being used by guest, it would make sense to notify management
>> to release VF anyways.
> Hmm it's different from what I envisioned and more work for management,
> but maybe it's ok ... I will need to think about it.
>
>>>
>>>> @@ -207,6 +226,14 @@ static void acpi_pcihp_update(AcpiPciHpState *s)
>>>>        int i;
>>>>        for (i = 0; i < ACPI_PCIHP_MAX_HOTPLUG_BUS; ++i) {
>>>> +        /*
>>>> +         * Set the acpi_pcihp_pci_status[].down bits of all the
>>>> +         * failover_primary devices so that the devices are ejected
>>>> +         * from the guest. We can't use the qdev_unplug() as well as the
>>>> +         * hotplug_handler to unplug the devices, because the guest may
>>>> +         * not be in a state to cooperate.
>>>> +         */
>>>> +        acpi_pcihp_cleanup_failover_primary(s, i);
>>>>            acpi_pcihp_update_hotplug_bus(s, i);
>>>>        }
>>>>    }
>>> I really don't want acpi to know anything about failover.
>>>
>>> All that needs to happen is sending a device delete request
>>> to guest. Should work with any hotplug removal:
>>> pci standard,acpi, etc.
>>>
>> As the code comments above indicated, there was issue uncovered that the
>> guest may not be in a state to respond to interrupt during reboot.
> If you request removal then hotplug machinery normally will eject
> the device on system reset. You need to request it early enough though.
With asynchronous nature of interrupt injection and guest handling, 
there's no way you can guarantee it's early enough, do you?

Surely that's why I said the event is in a "performance" path that has 
to be handled as fast as possible by management.

> I guess this missing is what happened.
>
>> Actually
>> management stack running fast enough is supposed to do this graceful hot
>> plug removal upon receiving the STANDBY_CHANGED "disabled" event. However,
>> if management stack's unable to do so, the code here makes sure the VF can
>> be deleted and won't be seen by an older kernel after reboot.
>>
>> -Siwei
> I'm sorry I don't understand.  On a system with PCIe native hotplug
> poking at ACPI is just wrong.
Venu, what's your plan to add the SHPC and PCIe native hotplug support? 
People starts to get confusing. I did not see you mentioned it in the 
cover letter.

Thanks,
-Siwei
