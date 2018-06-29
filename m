Received: from eggs.gnu.org ([2001:4830:134:3::10]:48740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fYvbI-0000qj-17
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:46:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fYvbE-0001Uq-Tx
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:46:20 -0400
References: <20180628121417.1980-1-david@redhat.com>
	<20180628121417.1980-5-david@redhat.com>
	<20180629170832.5389dcc6@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ccfba01d-32b5-407c-f459-332a5ef890aa@redhat.com>
Date: Fri, 29 Jun 2018 17:46:13 +0200
MIME-Version: 1.0
In-Reply-To: <20180629170832.5389dcc6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/4] pc-dimm: assign and verify the
 "addr" property during pre_plug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Weil <sw@weilnetz.de>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On 29.06.2018 17:08, Igor Mammedov wrote:
> On Thu, 28 Jun 2018 14:14:17 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> We can assign and verify the slot before realizing and trying to plug.
>> reading/writing the address property should never fail, so let's reduce
>> error handling a bit by using &error_abort. Getting access to the memory
>> region now might however fail. So forward errors from
>> get_memory_region() properly.
>>
>> Keep tracing the assigned address for now in the plug code, as that's the
>> point we are sure plugging succeeded and the address willa ctually be
>                                                        ^^^^^^^^^^^^^   
>> used.
> I'd move tracing to pre_plug as well, so even if pre_plug fails we could
> see in trace what addr was during the failure

I can do that.

> 
>> As all memory devices should use the alignment of the underlying memory
>> region for guest physical address asignment, do detection of the
>> alignment in pc_dimm_pre_plug(), but allow pc.c to overwrite the
>> alignment for compatibility handling.
> 
> patch look ok,
> see some nits below
> 
>  
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/i386/pc.c             | 16 ++++--------
>>  hw/mem/pc-dimm.c         | 53 +++++++++++++++++++++++-----------------
>>  hw/ppc/spapr.c           |  7 +++---
>>  include/hw/mem/pc-dimm.h |  6 ++---
>>  4 files changed, 41 insertions(+), 41 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 934b7155b1..16e4b5baff 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -1678,7 +1678,9 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>                                 Error **errp)
>>  {
>>      const PCMachineState *pcms = PC_MACHINE(hotplug_dev);
>> +    const PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>>      const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
>> +    const uint64_t compat_align = TARGET_PAGE_SIZE;
> s/compat_align/legacy_align/

agreed.

> 
>>  
>>      /*
>>       * When -no-acpi is used with Q35 machine type, no ACPI is built,
>> @@ -1696,7 +1698,8 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>          return;
>>      }
>>  
>> -    pc_dimm_pre_plug(dev, MACHINE(hotplug_dev), errp);
>> +    pc_dimm_pre_plug(dev, MACHINE(hotplug_dev),
>> +                     pcmc->enforce_aligned_dimm ? NULL : &compat_align, errp);
>>  }
>>  
>>  static void pc_memory_plug(HotplugHandler *hotplug_dev,
>> @@ -1705,18 +1708,9 @@ static void pc_memory_plug(HotplugHandler *hotplug_dev,
>>      HotplugHandlerClass *hhc;
>>      Error *local_err = NULL;
>>      PCMachineState *pcms = PC_MACHINE(hotplug_dev);
>> -    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>> -    PCDIMMDevice *dimm = PC_DIMM(dev);
>> -    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
>> -    MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
>> -    uint64_t align = TARGET_PAGE_SIZE;
>>      bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
>>  
>> -    if (pcmc->enforce_aligned_dimm) {
>> -        align = memory_region_get_alignment(mr);
>> -    }
>> -
>> -    pc_dimm_plug(dev, MACHINE(pcms), align, &local_err);
>> +    pc_dimm_plug(dev, MACHINE(pcms), &local_err);
>>      if (local_err) {
>>          goto out;
>>      }
>> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
>> index e56c4daef2..8e2e8549dc 100644
>> --- a/hw/mem/pc-dimm.c
>> +++ b/hw/mem/pc-dimm.c
>> @@ -29,9 +29,14 @@
>>  
>>  static int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp);
>>  
>> -void pc_dimm_pre_plug(DeviceState *dev, MachineState *machine, Error **errp)
>> +void pc_dimm_pre_plug(DeviceState *dev, MachineState *machine,
>> +                      const uint64_t *compat_align, Error **errp)
>>  {
>> +    PCDIMMDevice *dimm = PC_DIMM(dev);
>> +    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
>>      Error *local_err = NULL;
>> +    MemoryRegion *mr;
>> +    uint64_t addr, align;
>>      int slot;
>>  
>>      slot = object_property_get_int(OBJECT(dev), PC_DIMM_SLOT_PROP,
>> @@ -43,44 +48,46 @@ void pc_dimm_pre_plug(DeviceState *dev, MachineState *machine, Error **errp)
>>      }
>>      object_property_set_int(OBJECT(dev), slot, PC_DIMM_SLOT_PROP, &error_abort);
>>      trace_mhp_pc_dimm_assigned_slot(slot);
>> +
>> +    mr = ddc->get_memory_region(dimm, &local_err);
>> +    if (local_err) {
>> +        goto out;
>> +    }
>> +
>> +    if (compat_align) {
>> +        align = *compat_align;
>> +    } else {
>> +        align = memory_region_get_alignment(mr);
>> +    }
> might be:
> 
>        align =  compat_align ? *compat_align : memory_region_get_alignment(mr);

Will do if it fits into a single line (it seems it does)

> 
>> +
>> +    addr = object_property_get_uint(OBJECT(dev), PC_DIMM_ADDR_PROP,
>> +                                    &error_abort);
>> +    addr = memory_device_get_free_addr(machine, !addr ? NULL : &addr, align,
>> +                                       memory_region_size(mr), &local_err);
>> +    if (local_err) {
>> +        goto out;
>> +    }
>> +    object_property_set_uint(OBJECT(dev), addr, PC_DIMM_ADDR_PROP,
>> +                             &error_abort);
> if one considers memory device as separate black box, then set might fail
> (there is no guaranties that later on set could return a error)
> 
> So I'd keep local_err & co for set actions through out all *_plug handlers

In this part we are still in the pc_dimm specific code. I agree that
this should be done when moving this code to the memory device specific
code. For now I think this is fine.

-- 

Thanks,

David / dhildenb
