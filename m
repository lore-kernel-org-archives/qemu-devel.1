Received: from eggs.gnu.org ([2001:4830:134:3::10]:48940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fProF-0005Hu-16
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:54:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fProA-0006do-VA
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:54:15 -0400
References: <20180517081527.14410-1-david@redhat.com>
	<20180517081527.14410-14-david@redhat.com>
	<20180601133121.7123087d@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1ddbf979-150d-7893-51a5-6a6a1028c492@redhat.com>
Date: Mon, 4 Jun 2018 17:54:05 +0200
MIME-Version: 1.0
In-Reply-To: <20180601133121.7123087d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 13/14] memory-device: factor out unplug
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


>>  # hw/mem/pc-dimm.c
>>  mhp_pc_dimm_assigned_slot(int slot) "%d"
>>  mhp_pc_dimm_assigned_address(uint64_t addr) "0x%"PRIx64
>> +# hw/mem/memory-device.c
>> +memory_device_unassign_address(uint64_t addr) "0x%"PRIx64
> maybe split out tracing into a separate patch?

Can do, although I think this is overkill.

> 
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 562712def2..abdd38a6b5 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -3621,6 +3621,11 @@ static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
>>          hotplug_handler_plug(dev->parent_bus->hotplug_handler, dev, &local_err);
>>      }
>>  out:
>> +    if (local_err) {
>> +        if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
>> +            memory_device_unplug(MACHINE(hotplug_dev), MEMORY_DEVICE(dev));
>> +        }
>> +    }
> we shouldn't call unplug here.
> I'd suggest spapr_memory_plug() and/or memory_device_plug() to do
> error handling and rollback on it's own, it shouldn't complicate generic
> machines' hotplug handlers.

Please note that this is the generic way to handle multi stage hotplug
handlers. (see the more detailed comment in reply to patch 4 if I
remember correctly)

>From my point of view, this is the right thing to do.

> 
>>      error_propagate(errp, local_err);
>>  }
>>  
>> @@ -3638,7 +3643,16 @@ static void spapr_machine_device_unplug(HotplugHandler *hotplug_dev,
>>          hotplug_handler_unplug(dev->parent_bus->hotplug_handler, dev,
>>                                 &local_err);
>>      }
>> -    error_propagate(errp, local_err);
>> +
>> +    if (local_err) {
> this check probably not needed, error_propagate()
> bails out of local_err is NULL

With the current code (returning), this is needed.

> 
>> +        error_propagate(errp, local_err);
>> +        return;
>> +    }
>> +
>> +    /* first stage hotplug handler */
> I'd drop this comment, it looks not necessary and even a bit confusing to me.

I'll drop all the comments of this form.

> 
>> +    if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
>> +        memory_device_unplug(MACHINE(hotplug_dev), MEMORY_DEVICE(dev));
>> +    }
>>  }
>>  
>>  static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
>> diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
>> index 3a4e9edc92..b8365959e7 100644
>> --- a/include/hw/mem/memory-device.h
>> +++ b/include/hw/mem/memory-device.h
>> @@ -58,6 +58,6 @@ uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
>>                                       Error **errp);
>>  void memory_device_plug_region(MachineState *ms, MemoryRegion *mr,
>>                                 uint64_t addr);
>> -void memory_device_unplug_region(MachineState *ms, MemoryRegion *mr);
>> +void memory_device_unplug(MachineState *ms, MemoryDeviceState *md);
>>  
>>  #endif
> 


-- 

Thanks,

David / dhildenb
