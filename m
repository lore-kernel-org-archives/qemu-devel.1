Received: from eggs.gnu.org ([2001:4830:134:3::10]:40469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fRCRO-0001OO-Q1
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:08:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fRCRJ-0007eF-RW
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:08:10 -0400
References: <20180607165218.9558-1-david@redhat.com>
	<20180607165218.9558-4-david@redhat.com>
	<20180608100528.4bdadf6b@bahia.lan>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0b0bc97f-54be-6cb3-40f3-f8e6a563ee8b@redhat.com>
Date: Fri, 8 Jun 2018 10:07:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180608100528.4bdadf6b@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 3/8] spapr: move all DIMM checks into
 spapr_memory_plug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 08.06.2018 10:05, Greg Kurz wrote:
> On Thu,  7 Jun 2018 18:52:13 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Let's clean the hotplug handler up by moving everything into
>> spapr_memory_plug().
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/ppc/spapr.c | 23 ++++++++++-------------
>>  1 file changed, 10 insertions(+), 13 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index d038f3243e..a12be24ca9 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -3136,14 +3136,22 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
>>  }
>>  
>>  static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>> -                              uint32_t node, Error **errp)
>> +                              Error **errp)
>>  {
>>      Error *local_err = NULL;
>>      sPAPRMachineState *ms = SPAPR_MACHINE(hotplug_dev);
>> +    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(ms);
>>      PCDIMMDevice *dimm = PC_DIMM(dev);
>>      PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
>>      MemoryRegion *mr;
>>      uint64_t align, size, addr;
>> +    uint32_t node;
>> +
>> +    if (!smc->dr_lmb_enabled) {
>> +        error_setg(&local_err, "Memory hotplug not supported for this machine");
>> +        goto out;
>> +    }
> 
> Wouldn't it be more appropriate to move this check to spapr_memory_pre_plug() ?

Think you're right (and as spapr_memory_pre_plug() already exists, it's
easy), other opinions? Thanks.

> 
>> +    node = object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_PROP, NULL);
>>  
>>      mr = ddc->get_memory_region(dimm, &local_err);
>>      if (local_err) {
>> @@ -3568,19 +3576,8 @@ out:
>>  static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
>>                                        DeviceState *dev, Error **errp)
>>  {
>> -    MachineState *ms = MACHINE(hotplug_dev);
>> -    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(ms);
>> -
>>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>> -        int node;
>> -
>> -        if (!smc->dr_lmb_enabled) {
>> -            error_setg(errp, "Memory hotplug not supported for this machine");
>> -            return;
>> -        }
>> -        node = object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_PROP, NULL);
>> -
>> -        spapr_memory_plug(hotplug_dev, dev, node, errp);
>> +        spapr_memory_plug(hotplug_dev, dev, errp);
>>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
>>          spapr_core_plug(hotplug_dev, dev, errp);
>>      }
> 


-- 

Thanks,

David / dhildenb
