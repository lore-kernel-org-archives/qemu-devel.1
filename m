Received: from eggs.gnu.org ([2001:4830:134:3::10]:46560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fAzn9-0006AH-LZ
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fAzn6-0004AP-CI
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:23:39 -0400
References: <20180420123456.22196-1-david@redhat.com>
	<20180420123456.22196-4-david@redhat.com>
	<20180423141928.7e64b380@redhat.com>
	<908f1079-385f-24d3-99ad-152ecd6b01d2@redhat.com>
	<20180424153154.05e79de7@redhat.com>
	<f195e131-fde4-1ee9-d3d6-704f51137cb1@redhat.com>
	<20180424164417.15347ebb@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <587545cc-6640-3c8b-f441-34c5f17cefee@redhat.com>
Date: Tue, 24 Apr 2018 17:23:31 +0200
MIME-Version: 1.0
In-Reply-To: <20180424164417.15347ebb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/3] pc-dimm: factor out address space
 logic into MemoryDevice code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On 24.04.2018 16:44, Igor Mammedov wrote:
> On Tue, 24 Apr 2018 15:41:23 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 24.04.2018 15:31, Igor Mammedov wrote:
>>> On Mon, 23 Apr 2018 14:52:37 +0200
>>> David Hildenbrand <david@redhat.com> wrote:
>>>   
>>>>>     
>>>>>> +    /* we will need a new memory slot for kvm and vhost */
>>>>>> +    if (kvm_enabled() && !kvm_has_free_slot(machine)) {
>>>>>> +        error_setg(errp, "hypervisor has no free memory slots left");
>>>>>> +        return;
>>>>>> +    }
>>>>>> +    if (!vhost_has_free_slot()) {
>>>>>> +        error_setg(errp, "a used vhost backend has no free memory slots left");
>>>>>> +        return;
>>>>>> +    }    
>>>>> move these checks to pre_plug time
>>>>>     
>>>>>> +
>>>>>> +    memory_region_add_subregion(&hpms->mr, addr - hpms->base, mr);    
>>>>> missing vmstate registration?    
>>>>
>>>> Missed this one: To be called by the caller. Important because e.g. for
>>>> virtio-pmem we don't want this (I assume :) ).  
>>> if pmem isn't on shared storage, then We'd probably want to migrate
>>> it as well, otherwise target would experience data loss.
>>> Anyways, I'd just reat it as normal RAM in migration case  
>>
>> Yes, if we realize that all MemoryDevices need this call, we can move it
>> to that place, too.
>>
>> Wonder if we might want to make this configurable for virtio-pmem later
>> on (via a flag or sth like that).
> I don't see any reason why we wouldn't like it to be migrated,
> it's the same as nvdimm but with another qemu:guest ABI
> and async flush instead of sync one we have with nvdimm.
> 

Didn't you just mention "shared storage" ? :)

Anyhow, I leave such stuff to Pankaj to figure out. I remember him
working on some page cache details. Once clarified, this is easily
refactored later on.

-- 

Thanks,

David / dhildenb
