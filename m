Received: from eggs.gnu.org ([209.51.188.92]:36637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hH8Y6-0005bH-Dr
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:02:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hH8Y5-0005sF-99
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:02:02 -0400
References: <1555334842-195718-1-git-send-email-imammedo@redhat.com>
	<1555334842-195718-6-git-send-email-imammedo@redhat.com>
	<89ca3a70-066b-e40e-faaf-39a39ec976bf@de.ibm.com>
	<20190418113859.00248d07@redhat.com>
	<93d242cb-dcc4-a65d-a7c7-7232dd16a2f2@redhat.com>
	<20190418140116.19596c6d@redhat.com>
	<55880acf-9a61-9ed7-2ddd-9778b78540ee@redhat.com>
	<20190418165630.5a3cc493@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2675f1b1-fa05-ade3-9e0d-58e65e422251@redhat.com>
Date: Thu, 18 Apr 2019 17:01:55 +0200
MIME-Version: 1.0
In-Reply-To: <20190418165630.5a3cc493@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 5/5] s390: do not call
 memory_region_allocate_system_memory() multiple times
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org

On 18.04.19 16:56, Igor Mammedov wrote:
> On Thu, 18 Apr 2019 14:06:25 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 18.04.19 14:01, Igor Mammedov wrote:
>>> On Thu, 18 Apr 2019 13:24:43 +0200
>>> David Hildenbrand <david@redhat.com> wrote:
>>>   
>>>> On 18.04.19 11:38, Igor Mammedov wrote:  
>>>>> On Tue, 16 Apr 2019 13:09:08 +0200
>>>>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>>>>     
>>>>>> This fails with more than 8TB, e.g.  "-m 9T "
>>>>>>
>>>>>> [pid 231065] ioctl(10, KVM_SET_USER_MEMORY_REGION, {slot=0, flags=0, guest_phys_addr=0, memory_size=0, userspace_addr=0x3ffc8500000}) = 0
>>>>>> [pid 231065] ioctl(10, KVM_SET_USER_MEMORY_REGION, {slot=0, flags=0, guest_phys_addr=0, memory_size=9895604649984, userspace_addr=0x3ffc8500000}) = -1 EINVAL (Invalid argument)
>>>>>>
>>>>>> seems that the 2nd memslot gets the full size (and not 9TB-size of first slot).    
>>>>>
>>>>> it turns out MemoryRegions is rendered correctly in to 2 parts (one per alias),
>>>>> but follow up flatview_simplify() collapses adjacent ranges back
>>>>> into big one.    
>>>>
>>>> That sounds dangerous. Imagine doing that at runtime (e.g. hotplugging a
>>>> DIMM), the kvm memory slot would temporarily be deleted to insert the
>>>> new, bigger one. Guest would crash. This could happen if backing memory
>>>> of two DIMMs would by pure luck be allocated side by side in user space.
>>>>  
>>>
>>> not sure I fully get your concerns, but if you look at can_merge()
>>> it ensures that ranges belong to the same MemoryRegion.
>>>
>>> It's hard for me to say if flatview_simplify() works as designed,
>>> MemoryRegion code is quite complicated so I'd deffer to Paolo's
>>> opinion.
>>>   
>>
>> What I had in mind:
>>
>> We have the Memory Region for memory devices (m->device_memory).
>>
>> Assume The first DIMM is created, allocating memory in the user space
>> process:
>>
>> [0x100000000 .. 0x20000000]. It is placed at offset 0 in m->device_memory.
>>
>> Guests starts to run, a second DIMM is hotplugged. Memory in user space
>> process is allocated (by pure luck) at:
>>
>> [0x200000000 .. 0x30000000]. It is placed at offset 0x100000000 in
>> m->device_memory.
>>
>> Without looking at the code, I could imagine that both might be merged
>> into a single memory slot. That is my concern. Maybe it is not valid.
> it's not. As far as I see ranges are merged only if they belong to
> the same 'mr'. So to dimms will result in 2 memory sections -> 2 KVMSlots.

Okay, so a shared "parent memory region" is not enough to result in a
merge, only aliases.

-- 

Thanks,

David / dhildenb
