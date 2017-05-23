Received: from eggs.gnu.org ([2001:4830:134:3::10]:53933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dDCMt-0003PL-4B
	for qemu-devel@nongnu.org; Tue, 23 May 2017 12:09:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dDCMp-0003bB-Uy
	for qemu-devel@nongnu.org; Tue, 23 May 2017 12:09:07 -0400
References: <20170523111812.13469-1-lvivier@redhat.com>
	<20170523111812.13469-2-lvivier@redhat.com>
	<20170523172842.1fce414e@bahia.ttt.fr.ibm.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <bc9a69f9-eb7b-943a-a9bf-bb4a3b18f525@redhat.com>
Date: Tue, 23 May 2017 18:09:00 +0200
MIME-Version: 1.0
In-Reply-To: <20170523172842.1fce414e@bahia.ttt.fr.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/4] spapr: add pre_plug
 function for memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

On 23/05/2017 17:28, Greg Kurz wrote:
> On Tue, 23 May 2017 13:18:09 +0200
> Laurent Vivier <lvivier@redhat.com> wrote:
> 
>> This allows to manage errors before the memory
>> has started to be hotplugged. We already have
>> the function for the CPU cores.
>>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>>  hw/ppc/spapr.c | 45 ++++++++++++++++++++++++++++++---------------
>>  1 file changed, 30 insertions(+), 15 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 0980d73..0e8d8d1 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -2569,20 +2569,6 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>      uint64_t align = memory_region_get_alignment(mr);
>>      uint64_t size = memory_region_size(mr);
>>      uint64_t addr;
>> -    char *mem_dev;
>> -
>> -    if (size % SPAPR_MEMORY_BLOCK_SIZE) {
>> -        error_setg(&local_err, "Hotplugged memory size must be a multiple of "
>> -                      "%lld MB", SPAPR_MEMORY_BLOCK_SIZE/M_BYTE);
>> -        goto out;
>> -    }
>> -
>> -    mem_dev = object_property_get_str(OBJECT(dimm), PC_DIMM_MEMDEV_PROP, NULL);
>> -    if (mem_dev && !kvmppc_is_mem_backend_page_size_ok(mem_dev)) {
>> -        error_setg(&local_err, "Memory backend has bad page size. "
>> -                   "Use 'memory-backend-file' with correct mem-path.");
>> -        goto out;
>> -    }
>>  
>>      pc_dimm_memory_plug(dev, &ms->hotplug_memory, mr, align, &local_err);
>>      if (local_err) {
>> @@ -2603,6 +2589,33 @@ out:
>>      error_propagate(errp, local_err);
>>  }
>>  
>> +static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>> +                                Error **errp)
> 
> Indentation nit

ok

> 
>> +{
>> +    PCDIMMDevice *dimm = PC_DIMM(dev);
>> +    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
>> +    MemoryRegion *mr = ddc->get_memory_region(dimm);
>> +    uint64_t size = memory_region_size(mr);
>> +    Error *local_err = NULL;
>> +    char *mem_dev;
>> +
>> +    if (size % SPAPR_MEMORY_BLOCK_SIZE) {
>> +        error_setg(&local_err, "Hotplugged memory size must be a multiple of "
>> +                      "%lld MB", SPAPR_MEMORY_BLOCK_SIZE / M_BYTE);
>> +        goto out;
>> +    }
>> +
>> +    mem_dev = object_property_get_str(OBJECT(dimm), PC_DIMM_MEMDEV_PROP, NULL);
>> +    if (mem_dev && !kvmppc_is_mem_backend_page_size_ok(mem_dev)) {
>> +        error_setg(&local_err, "Memory backend has bad page size. "
>> +                   "Use 'memory-backend-file' with correct mem-path.");
>> +        goto out;
>> +    }
>> +
>> +out:
>> +    error_propagate(errp, local_err);
> 
> As recently discussed with Markus Armbruster, it isn't necessary to have a
> local Error * if you don't do anything else with it but propagate it.

Yes, you are right, it's a stupid cut'n'paste.

Thanks,
Laurent
