Received: from eggs.gnu.org ([209.51.188.92]:52568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1grN3y-0008Lh-Aj
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:16:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1grMxv-0002tg-1R
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:10:11 -0500
References: <20190123195527.29575-1-david@redhat.com>
	<20190123195527.29575-10-david@redhat.com>
	<20190206140145.5f98dff9@Igors-MacBook-Pro.local>
From: David Hildenbrand <david@redhat.com>
Message-ID: <964a0adf-ea69-4057-4283-171b5cdb3640@redhat.com>
Date: Wed, 6 Feb 2019 14:10:04 +0100
MIME-Version: 1.0
In-Reply-To: <20190206140145.5f98dff9@Igors-MacBook-Pro.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFCv2 9/9] pc: Support for virtio-pmem-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Collin Walling <walling@linux.ibm.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

On 06.02.19 14:01, Igor Mammedov wrote:
> On Wed, 23 Jan 2019 20:55:27 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Override the device hotplug handler to properly handle the memory device
>> part via virtio-pmem-pci callbacks from the machine hotplug handler and
>> forward to the actual PCI bus hotplug handler.
>>
>> As PCI hotplug has not been properly factored out into hotplug handlers,
>> most magic is performed in the (un)realize functions. Also some PCI host
>> buses don't have a PCI hotplug handler at all yet, just to be sure that
>> we alway have a hotplug handler on x86, add a simple error check.
>>
>> Unlocking virtio-pmem will unlock virtio-pmem-pci.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  default-configs/i386-softmmu.mak |  1 +
>>  hw/i386/pc.c                     | 70 +++++++++++++++++++++++++++++++-
>>  2 files changed, 70 insertions(+), 1 deletion(-)
>>
>> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
>> index 64c998c4c8..3f63e95a55 100644
>> --- a/default-configs/i386-softmmu.mak
>> +++ b/default-configs/i386-softmmu.mak
>> @@ -52,6 +52,7 @@ CONFIG_APIC=y
>>  CONFIG_IOAPIC=y
>>  CONFIG_PVPANIC=y
>>  CONFIG_MEM_DEVICE=y
>> +CONFIG_VIRTIO_PMEM=y
>>  CONFIG_DIMM=y
>>  CONFIG_NVDIMM=y
>>  CONFIG_ACPI_NVDIMM=y
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index fd0cb29ba9..6a176caeb9 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -75,6 +75,7 @@
>>  #include "hw/usb.h"
>>  #include "hw/i386/intel_iommu.h"
>>  #include "hw/net/ne2000-isa.h"
>> +#include "hw/virtio/virtio-pmem-pci.h"
>>  
>>  /* debug PC/ISA interrupts */
>>  //#define DEBUG_IRQ
>> @@ -2224,6 +2225,64 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>      numa_cpu_pre_plug(cpu_slot, dev, errp);
>>  }
>>  
>> +static void pc_virtio_pmem_pci_pre_plug(HotplugHandler *hotplug_dev,
>> +                                        DeviceState *dev, Error **errp)
>> +{
>> +    HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
>> +    Error *local_err = NULL;
>> +
>> +    if (!hotplug_dev2) {
>> +        /*
>> +         * Without a bus hotplug handler, we cannot control the plug/unplug
>> +         * order. This should never be the case on x86, however better add
>> +         * a safety net.
>> +         */
>> +        error_setg(errp, "virtio-pmem-pci not supported on this bus.");
>> +        return;
>> +    }
>> +    virtio_pmem_pci_pre_plug(VIRTIO_PMEM_PCI(dev), MACHINE(hotplug_dev),
>        ^^^
> doesn't do anything beside being dumb proxy to memory_device_pre_plug()
> I'd just use memory_device_pre_plug() here and avoid so far needles wrappers

Had that initially but considered it cleaner. But I can change that back.

> 
>> +                             &local_err);
>> +    if (!local_err) {
> since logic is not trivial I'd add comment somewhere in this function
> explaining why handlers are called in this particular order.

Good idea, will do that.

Thanks!

-- 

Thanks,

David / dhildenb
