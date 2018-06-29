Received: from eggs.gnu.org ([2001:4830:134:3::10]:56796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fYw3B-0003Qx-9r
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 12:15:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fYw38-0004M1-36
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 12:15:09 -0400
References: <20180628121417.1980-1-david@redhat.com>
	<20180628121417.1980-3-david@redhat.com>
	<20180629164903.1630ea28@redhat.com>
	<94085ac5-0242-1cb5-065a-7e50183792bd@redhat.com>
	<20180629175641.13a2a747@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c310070c-dc0f-ee31-62c5-c10e6d84cc28@redhat.com>
Date: Fri, 29 Jun 2018 18:14:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180629175641.13a2a747@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/4] util/oslib-win32: indicate
 alignment for qemu_anon_ram_alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>

On 29.06.2018 17:56, Igor Mammedov wrote:
> On Fri, 29 Jun 2018 17:39:10 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 29.06.2018 16:49, Igor Mammedov wrote:
>>> On Thu, 28 Jun 2018 14:14:15 +0200
>>> David Hildenbrand <david@redhat.com> wrote:
>>>   
>>>> Let's set the alignment just like for the posix variant. This will
>>>> implicitly set the alignment of the underlying memory region and
>>>> therefore make memory_region_get_alignment(mr) return something > 0 for
>>>> all memory backends applicable to PCDIMM/NVDIMM.
>>>>
>>>> This will allow us to drop special handling in pc.c for
>>>> memory_region_get_alignment(mr) == 0, as we can then assume that it is
>>>> always set (and AFAICS >= getpagesize()).
>>>>
>>>> For pc in pc_memory_plug(), under Windows TARGET_PAGE_SIZE == getpagesize(),
>>>> therefore alignment of DIMMs will not change, and therefore also not the
>>>> guest physical memory layout.  
>>> why not use QEMU_VMALLOC_ALIGN for consistency (on win => getpagesize())
>>> instead of TARGET_PAGE_SIZE like linux allocator does?  
>>
>> Sure we can do that, I wanted to match here exactly what has been
>> written in the comment.
>>
>>>
>>> Also looking at FIXME comment it notes that VirtualAlloc might have 64K
>>> alignment (though I haven't found it in VirtualAlloc manual).
>>> If that's true then we might need set *align to it to avoid auto-picked
>>> address overlap with previous allocation (not really sure about it).  
>>
>> "To determine the size of a page and the allocation granularity on the
>> host computer, use the GetSystemInfo" [1]
>>
>> "The size of the region, in bytes. If the lpAddress parameter is NULL,
>> this value is rounded up to the next page boundary. " [1]
>>
>> Historically, this seems to be 64k. But it will always be at least 4k
>> (page size). So what we could do is query the actual allocation granularity:
>>
>> int get_allocation_granularity(void) {
>> 	SYSTEM_INFO system_info;
>>
>> 	GetSystemInfo(&system_info);
>> 	return system_info.dwAllocationGranularity
>> }
>>
>>
>> "dwAllocationGranularity: The granularity for the starting address at
>> which virtual memory can be allocated. For more information, see
>> VirtualAlloc." [2]
>>
>> What do you think?
> maybe do following:
> 
>     *align = MAX(get_allocation_granularity(), getpagesize())

That sounds like the best alternative when having to guess what is
actually going on behind the curtains.

-- 

Thanks,

David / dhildenb
