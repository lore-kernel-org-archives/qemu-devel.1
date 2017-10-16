Received: from eggs.gnu.org ([2001:4830:134:3::10]:49009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e41YA-0005QW-7D
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:19:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e41Y9-0005kc-16
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:19:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1e41Y8-0005jh-OF
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:19:04 -0400
References: <20170911174933.20789-1-david@redhat.com>
	<20170911174933.20789-6-david@redhat.com>
	<7bf188b3-3c35-97ef-f67d-7ffabe45c4a1@redhat.com>
	<f6eb7866-3df7-e420-5b84-6d3caf052413@redhat.com>
	<bffd31bf-a3a1-8ecf-1ca0-afd3d891fd24@redhat.com>
	<986d3c41-1b0e-6b0b-3096-916c90208b46@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <578fbf47-9106-0922-a185-a7f0da3760bd@redhat.com>
Date: Mon, 16 Oct 2017 11:19:01 +0200
MIME-Version: 1.0
In-Reply-To: <986d3c41-1b0e-6b0b-3096-916c90208b46@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 5/6] kvm: kvm_log_start/stop are only
 called with known sections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 16.10.2017 10:52, Thomas Huth wrote:
> On 16.10.2017 09:16, David Hildenbrand wrote:
>> On 10.10.2017 15:29, Paolo Bonzini wrote:
>>> On 10/10/2017 11:06, Thomas Huth wrote:
>>>> On 11.09.2017 19:49, David Hildenbrand wrote:
>>>>> Let's properly align the sections first and bail out if we would ever
>>>>> get called with a memory section we don't know yet.
>>>>>
>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>> ---
>>>>>  accel/kvm/kvm-all.c | 18 ++++++++++++------
>>>>>  1 file changed, 12 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>>>>> index b677d1b13e..2ae459453d 100644
>>>>> --- a/accel/kvm/kvm-all.c
>>>>> +++ b/accel/kvm/kvm-all.c
>>>>> @@ -411,15 +411,21 @@ static int kvm_slot_update_flags(KVMMemoryListener *kml, KVMSlot *mem,
>>>>>  static int kvm_section_update_flags(KVMMemoryListener *kml,
>>>>>                                      MemoryRegionSection *section)
>>>>>  {
>>>>> -    hwaddr phys_addr = section->offset_within_address_space;
>>>>> -    ram_addr_t size = int128_get64(section->size);
>>>>> -    KVMSlot *mem = kvm_lookup_matching_slot(kml, phys_addr, size);
>>>>> +    hwaddr start_addr, size;
>>>>> +    KVMSlot *mem;
>>>>>  
>>>>> -    if (mem == NULL)  {
>>>>> +    size = kvm_align_section(section, &start_addr);
>>>>> +    if (!size) {
>>>>>          return 0;
>>>>> -    } else {
>>>>> -        return kvm_slot_update_flags(kml, mem, section->mr);
>>>>>      }
>>>>> +
>>>>> +    mem = kvm_lookup_matching_slot(kml, start_addr, size);
>>>>> +    if (!mem) {
>>>>> +        fprintf(stderr, "%s: error finding slot\n", __func__);
>>>>> +        abort();
>>>>> +    }
>>>>
>>>> FYI, this abort now triggers with the "isa-vga" device:
>>>>
>>>> $ x86_64-softmmu/qemu-system-x86_64 -S -accel kvm -device isa-vga
>>>> kvm_section_update_flags: error finding slot
>>>> Aborted (core dumped)
>>>>
>>>> Any ideas how to fix this?
>>>
>>> Reverting, unless David has some time to look into it.
>>>
>>> Paolo
>>>
>>
>> Just returned from vacation, I'll have a look this week.
>>
>> Thanks for that nice reproducer Thomas, that should help a lot!
> 
> FWIW, I've found the problem with the scripts/device-crash-test script,
> so you might want to run that, too, before submitting a new version.
> 
>  Thomas
> 

This one was easy to fix, there was just one place where the asssumption
"only called with known sections" was wrong.

See "memory: call log_start after region_add"

-- 

Thanks,

David
