Received: from eggs.gnu.org ([2001:4830:134:3::10]:37495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fNh4r-00011O-BW
	for qemu-devel@nongnu.org; Tue, 29 May 2018 12:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fNh4l-0007jP-GB
	for qemu-devel@nongnu.org; Tue, 29 May 2018 12:02:25 -0400
References: <20180517081527.14410-1-david@redhat.com>
	<20180517081527.14410-2-david@redhat.com>
	<20180529152714.232f952c@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <cb69838b-e346-503c-f86d-9a0746c6c1e6@redhat.com>
Date: Tue, 29 May 2018 18:02:06 +0200
MIME-Version: 1.0
In-Reply-To: <20180529152714.232f952c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 01/14] memory-device: drop assert
 related to align and start of address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luiz Capitulino <lcapitulino@redhat.com>

On 29.05.2018 15:27, Igor Mammedov wrote:
> On Thu, 17 May 2018 10:15:14 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> The start of the address space does not have to be aligned for the
>> search. Handle this case explicitly when starting the search for a new
>> address.
> That's true,
> but commit message doesn't explain why address_space_start
> should be allowed to be non aligned.
> 
> At least with this assert we would notice early that
> board allocating misaligned address space.
> I'd keep the assert unless there is a good reason to drop it.

That reason might be that I can easily crash QEMU

 ./x86_64-softmmu/qemu-system-x86_64 -m 256M,maxmem=20G,slots=2 -object
memory-backend-file,id=mem0,size=8192M,mem-path=/dev/zero,align=8192M
-device pc-dimm,id=dimm1,memdev=mem0

ERROR:hw/mem/memory-device.c:146:memory_device_get_free_addr: assertion
failed: (QEMU_ALIGN_UP(address_space_start, align) == address_space_start)


> 
> 
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/mem/memory-device.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
>> index 3e04f3954e..361d38bfc5 100644
>> --- a/hw/mem/memory-device.c
>> +++ b/hw/mem/memory-device.c
>> @@ -116,7 +116,6 @@ uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
>>      address_space_start = ms->device_memory->base;
>>      address_space_end = address_space_start +
>>                          memory_region_size(&ms->device_memory->mr);
>> -    g_assert(QEMU_ALIGN_UP(address_space_start, align) == address_space_start);
>>      g_assert(address_space_end >= address_space_start);
>>  
>>      memory_device_check_addable(ms, size, errp);
>> @@ -149,7 +148,7 @@ uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
>>              return 0;
>>          }
>>      } else {
>> -        new_addr = address_space_start;
>> +        new_addr = QEMU_ALIGN_UP(address_space_start, align);
>>      }
>>  
>>      /* find address range that will fit new memory device */
> 


-- 

Thanks,

David / dhildenb
