Received: from eggs.gnu.org ([2001:4830:134:3::10]:42378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fPnxY-0006ta-75
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:47:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fPnxX-000338-8i
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:47:36 -0400
References: <20180517081527.14410-1-david@redhat.com>
	<20180517081527.14410-15-david@redhat.com>
	<20180601133939.550378ce@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <8b38ef58-ecae-54cf-f657-c0112a6e4cb7@redhat.com>
Date: Mon, 4 Jun 2018 13:47:31 +0200
MIME-Version: 1.0
In-Reply-To: <20180601133939.550378ce@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 14/14] memory-device: factor out plug
 into hotplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On 01.06.2018 13:39, Igor Mammedov wrote:
> On Thu, 17 May 2018 10:15:27 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Let's move the plug logic into the applicable hotplug handler for pc and
>> spapr.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/i386/pc.c                   | 35 ++++++++++++++++++++---------------
>>  hw/mem/memory-device.c         | 40 ++++++++++++++++++++++++++++++++++------
>>  hw/mem/pc-dimm.c               | 29 +----------------------------
>>  hw/mem/trace-events            |  2 +-
>>  hw/ppc/spapr.c                 | 15 ++++++++++++---
>>  include/hw/mem/memory-device.h |  7 ++-----
>>  include/hw/mem/pc-dimm.h       |  3 +--
>>  7 files changed, 71 insertions(+), 60 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 426fb534c2..f022eb042e 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -1682,22 +1682,8 @@ static void pc_dimm_plug(HotplugHandler *hotplug_dev,
>>      HotplugHandlerClass *hhc;
>>      Error *local_err = NULL;
>>      PCMachineState *pcms = PC_MACHINE(hotplug_dev);
>> -    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>> -    PCDIMMDevice *dimm = PC_DIMM(dev);
>> -    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
>> -    MemoryRegion *mr;
>> -    uint64_t align = TARGET_PAGE_SIZE;
>>      bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
>>  
>> -    mr = ddc->get_memory_region(dimm, &local_err);
>> -    if (local_err) {
>> -        goto out;
>> -    }
>> -
>> -    if (memory_region_get_alignment(mr) && pcmc->enforce_aligned_dimm) {
>> -        align = memory_region_get_alignment(mr);
>> -    }
>> -
>>      /*
>>       * When -no-acpi is used with Q35 machine type, no ACPI is built,
>>       * but pcms->acpi_dev is still created. Check !acpi_enabled in
>> @@ -1715,7 +1701,7 @@ static void pc_dimm_plug(HotplugHandler *hotplug_dev,
>>          goto out;
>>      }
>>  
>> -    pc_dimm_memory_plug(dev, MACHINE(pcms), align, &local_err);
>> +    pc_dimm_memory_plug(dev, MACHINE(pcms), &local_err);
>>      if (local_err) {
>>          goto out;
>>      }
>> @@ -2036,6 +2022,25 @@ static void pc_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>>  {
>>      Error *local_err = NULL;
>>  
>> +    /* first stage hotplug handler */
>> +    if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
>> +        const PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(hotplug_dev);
>> +        uint64_t align = 0;
>> +
>> +        /* compat handling: force to TARGET_PAGE_SIZE */
>> +        if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
>> +            !pcmc->enforce_aligned_dimm) {
>> +            align = TARGET_PAGE_SIZE;
>> +        }
>> +        memory_device_plug(MACHINE(hotplug_dev), MEMORY_DEVICE(dev),
>> +                           align ? &align : NULL, &local_err);
>> +    }
>> +
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return;
>> +    }
>> +
>>      /* final stage hotplug handler */
>>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>>          pc_dimm_plug(hotplug_dev, dev, &local_err);
>> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
>> index 8f10d613ea..04bdb30f22 100644
>> --- a/hw/mem/memory-device.c
>> +++ b/hw/mem/memory-device.c
>> @@ -69,9 +69,10 @@ static int memory_device_used_region_size(Object *obj, void *opaque)
>>      return 0;
>>  }
>>  
>> -uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
>> -                                     uint64_t align, uint64_t size,
>> -                                     Error **errp)
>> +static uint64_t memory_device_get_free_addr(MachineState *ms,
>> +                                            const uint64_t *hint,
>> +                                            uint64_t align, uint64_t size,
>> +                                            Error **errp)
>>  {
>>      uint64_t address_space_start, address_space_end;
>>      uint64_t used_region_size = 0;
>> @@ -237,11 +238,38 @@ void memory_device_pre_plug(MachineState *ms, const MemoryDeviceState *md,
>>      }
>>  }
>>  
>> -void memory_device_plug_region(MachineState *ms, MemoryRegion *mr,
>> -                               uint64_t addr)
>> +void memory_device_plug(MachineState *ms, MemoryDeviceState *md,
>> +                        uint64_t *enforced_align, Error **errp)
> enforced_align is PC machine specific compat flag
> to keep old machines with unaligned layout work (i.e. don't break CLI/migration)
> it shouldn't go into a generic code.
> By default all new machines should use aligned layout. 
> 

Yes, but there has to be a way for the search to access this property.
So what do you propose in contrast to this?

-- 

Thanks,

David / dhildenb
