Received: from eggs.gnu.org ([209.51.188.92]:40340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gpJeP-0004SF-Az
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:13:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gpJeO-0001Iu-Fs
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:13:33 -0500
References: <20190130155733.32742-1-david@redhat.com>
	<20190130155733.32742-7-david@redhat.com>
	<81a84f89-218f-f51b-67cc-37d2c0c05aad@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <76a00e9c-932e-20ce-fbd8-545d145798eb@redhat.com>
Date: Thu, 31 Jan 2019 22:13:28 +0100
MIME-Version: 1.0
In-Reply-To: <81a84f89-218f-f51b-67cc-37d2c0c05aad@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 6/6] s390x/pci: Unplug remaining
 requested devices on pcihost reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 31.01.19 21:26, Collin Walling wrote:
> On 1/30/19 10:57 AM, David Hildenbrand wrote:
>> When resetting the guest we should unplug and remove all devices that
>> are still pending.
>>
>> With this patch, the requested device will be unpluged on reboot
>> (S390_RESET_EXTERNAL and S390_RESET_REIPL, which reset the pcihost bridge
>> via qemu_devices_reset()).
>>
>> This approach is similar to what's done for acpi PCI hotplug in
>> acpi_pcihp_reset() -> acpi_pcihp_update() ->
>> acpi_pcihp_update_hotplug_bus() -> acpi_pcihp_eject_slot().
>>
>> s390_pci_generate_plug_event()'s will still be generated, I guess this
>> is not an issue. The same thing would happen right now when unplugging
>> a device just before starting the guest.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   hw/s390x/s390-pci-bus.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index 867801ccf9..b9b0f44087 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -1092,6 +1092,21 @@ static void s390_pcihost_reset(DeviceState *dev)
>>   {
>>       S390pciState *s = S390_PCI_HOST_BRIDGE(dev);
>>       PCIBus *bus = s->parent_obj.bus;
>> +    S390PCIBusDevice *pbdev, *next;
>> +
>> +    /* Process all pending unplug requests */
>> +    QTAILQ_FOREACH_SAFE(pbdev, &s->zpci_devs, link, next) {
>> +        if (pbdev->unplug_requested) {
>> +            if (pbdev->summary_ind) {
>> +                pci_dereg_irqs(pbdev);
>> +            }
>> +            if (pbdev->iommu->enabled) {
>> +                pci_dereg_ioat(pbdev->iommu);
>> +            }
>> +            pbdev->state = ZPCI_FS_STANDBY;
>> +            s390_pci_perform_unplug(pbdev);
>> +        }
>> +    }
>>   
>>       /*
>>        * When resetting a PCI bridge, the assigned numbers are set to 0. So
>>
> 
> Just "talking out loud" to reaffirm my understanding:
> 
> The ..._unplug_request function will have already generated the
> deconfigure unplug event, and the unplug_requested flag will be set.
> Makes sense -- easy to follow. :)

Yes, that's how it should work :)

> 
> The callback that this code is essentially replacing used to generate a
> CONFIGURED_TO_STBRES plug event, but as I recall from a previous
> conversation regarding PCI states, we can skip this event because we're
> removing the device from the guest during a reset here (there are a few
> reasons why we'd do this, but no sense in listing them here). Also makes
> sense to me.

Yes, it's pretty much to the guest like this device never existed.

Thanks!

> 
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> 


-- 

Thanks,

David / dhildenb
