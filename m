Received: from eggs.gnu.org ([2001:4830:134:3::10]:35852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fkQ70-0007YS-AS
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:34:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fkQ6x-0007X3-6k
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:34:34 -0400
References: <1532959766-53343-1-git-send-email-borntraeger@de.ibm.com>
	<2a2bedc4-e7c6-4284-51d7-94dae1ec6094@redhat.com>
	<20180730174714.3678f0fa.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <40ec84cc-7426-54ab-871b-909ef6cdc9b7@redhat.com>
Date: Tue, 31 Jul 2018 10:34:21 +0200
MIME-Version: 1.0
In-Reply-To: <20180730174714.3678f0fa.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 1/1] s390x/sclp: fix maxram
 calculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, imbrenda@linux.vnet.ibm.com, Richard Henderson <rth@twiddle.net>

On 30.07.2018 17:47, Cornelia Huck wrote:
> On Mon, 30 Jul 2018 17:43:42 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 30.07.2018 16:09, Christian Borntraeger wrote:
>>> We clamp down ram_size to match the sclp increment size. We do
>>> not do the same for maxram_size, which means for large guests
>>> with some sizes (e.g. -m 50000) maxram_size differs from ram_size.
>>> This can break other code (e.g. CMMA migration) which uses maxram_size
>>> to calculate the number of pages and then throws some errors.
>>>
>>> Fixes: 82fab5c5b90e468f3e9d54c ("s390x/sclp: remove memory hotplug support")
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> CC: qemu-stable@nongnu.org
>>> CC: David Hildenbrand <david@redhat.com>
>>> ---
>>>  hw/s390x/sclp.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>>> index bd2a024..4510a80 100644
>>> --- a/hw/s390x/sclp.c
>>> +++ b/hw/s390x/sclp.c
>>> @@ -320,6 +320,7 @@ static void sclp_memory_init(SCLPDevice *sclp)
>>>      initial_mem = initial_mem >> increment_size << increment_size;
>>>  
>>>      machine->ram_size = initial_mem;
>>> +    machine->maxram_size = initial_mem;
>>>      /* let's propagate the changed ram size into the global variable. */
>>>      ram_size = initial_mem;
>>>  }
>>>   
>>
>> BTW, I handle it in may private patch like this
>>
>>  static inline SCLPDevice *get_sclp_device(void)
>>  {
>> @@ -319,9 +321,12 @@ static void sclp_memory_init(SCLPDevice *sclp)
>>       * down to align with the nearest increment boundary. */
>>      initial_mem = initial_mem >> increment_size << increment_size;
>>
>> -    machine->ram_size = initial_mem;
>> -    /* let's propagate the changed ram size into the global variable. */
>> -    ram_size = initial_mem;
>> +    /* propagate the changed ram size into the different places */
>> +    if (initial_mem != machine->ram_size) {
>> +        machine->maxram_size -= machine->ram_size - initial_mem;
>> +        machine->ram_size = initial_mem;
>> +        ram_size = initial_mem;
>> +    }
>>  }
>>
>> You would right now overwrite any maxmem setting (which might be ok as
>> we don't support it yet).
>>
> 
> So, will you (for whatever value of 'you') submit more patches for 3.1?
> 

Once we have memory device support for s390x that will be needed. But
the person that implemented cmma migration should fix the handling and
only try to migrate memory that is actually there. This was broken
before my patch, just never happened as Linux always onlines all memory
it sees via SCLP (thereby creating the memory regions).

-- 

Thanks,

David / dhildenb
