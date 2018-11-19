Received: from eggs.gnu.org ([2001:4830:134:3::10]:34078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gOr0P-0003od-93
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 16:22:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gOr0L-0002Ji-9v
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 16:22:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gOr0J-0002I6-Bd
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 16:22:49 -0500
References: <20181115140501.7872-1-david@redhat.com>
	<20181115140501.7872-7-david@redhat.com>
	<87muq972p0.fsf@dusky.pond.sub.org>
	<3d186921-e32f-60aa-cfc6-07345f6795c7@redhat.com>
	<87o9akkfqm.fsf@dusky.pond.sub.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ae407712-b64d-d6a4-601f-2d7164af2a61@redhat.com>
Date: Mon, 19 Nov 2018 22:22:43 +0100
MIME-Version: 1.0
In-Reply-To: <87o9akkfqm.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 6/9] qapi: rewrite string-input-visitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 19.11.18 20:51, Markus Armbruster wrote:
> Copying Igor and Eduardo for a hostmem.c bug.  Search for "core dumped".
> 
> David Hildenbrand <david@redhat.com> writes:
> 
>>>>
>>>> Tests have to be fixed up:
>>>> - Two BUGs were hardcoded that are fixed now
>>>> - The string-input-visitor now actually returns a parsed list and not
>>>>   an ordered set.
>>>
>>> I'd expect this to necessitate an update of callers that expect a set, but...
>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>  include/qapi/string-input-visitor.h |   4 +-
>>>>  qapi/string-input-visitor.c         | 410 ++++++++++++++++------------
>>>>  tests/test-string-input-visitor.c   |  18 +-
>>>>  3 files changed, 239 insertions(+), 193 deletions(-)
>>>
>>> ... there's none.
>>>
>>> Let me know if you need help finding them.  I think we tracked them down
>>> during the discussion that led to this series.
>>>
>>
>> Indeed, I missed to document that. So here is the outcome:
>>
>> 1. backends/hostmem.c:host_memory_backend_set_host_nodes()
>>
>> -> calls visit_type_uint16List(via bitmap)
>> -> the code can deal with duplicates/unsorted lists (bitmap_set)
> 
> Yes.
> 
>> Side node: I am not sure if there should be some range checks, but maybe
>> the bitmap is large enough .... hm ...
> 
> Fishy.  MAX_NODES is 128.  Tinker, tinker, ...
> 
>     $ upstream-qemu -nodefaults -object memory-backend-file,id=mem0,mem-path=x,size=4096,host-nodes=12345
>     Segmentation fault (core dumped)
> 
> Igor, Eduardo, this is yours.
> 
> There's another use of visit_type_uint16List() is this file, but it's in
> property getter host_memory_backend_get_host_nodes(), and property
> getters aren't used with the string input visitor.
> 
>> 2. qapi-visit.c::visit_type_Memdev_members()
>>
>> -> calls visit_type_uint16List()
>> -> I think this never used for input, only for output / freeing
> 
> Yes, it's used by query-memdev with the QObject output visitor to build
> the value of @host-nodes.
> 
>> 3. qapi-visit.c::visit_type_NumaNodeOptions_members()
>>
>> -> calls visit_type_uint16List()
>> -> I think this never used for input, only for output / freeing
> 
> It's used for input, but with the opts visitor, see parse_numa().
> 
>> 4. qapi-visit.c::visit_type_RockerOfDpaGroup_members
>>
>> -> calls visit_type_uint32List()
>> -> I think this never used for input, only for output / freeing
> 
> Yes, it's used by query-rocker-of-dpa-groups with the QObject output
> visitor to build the value of @group-ids.
> 
>> 5. qapi-visit.c::visit_type_RxFilterInfo_members()
>>
>> -> calls visit_type_intList()
>> -> I think this never used for input, only for output / freeing
> 
> Yes, it's used by query-rx-filter with the QObject output visitor to
> build the value of @vlan-table.
> 
>> 6. numa.c::query_memdev()
>>
>> -> calls object_property_get_uint16List()
>> --> String parsed via visit_type_uint16List() into list
> 
> QOM, hard to understand.
> 
> The value of struct HostMemoryBackend member @host-nodes (a bitmap) is
> first converted to a list (sorted, no duplicates) with
> host_memory_backend_get_host_nodes() via object_property_get(), then
> converted to a string with the string output visitor.  The resulting
> string is then converted back to a list with the string input visitor.
> 
> Despite the shenanigans going on in the string output visitor, I'd
> expect the resulting list to also be sorted and without duplicates.
> 
>> -> qmp_query_memdev() uses this list
>> --> Not relevant if unique or sorted
> 
> Depends on the contract of QMP command query-memdev.  Here's the
> relevant part.
> 
>     # @host-nodes: host nodes for its memory policy
> 
> Useless.
> 
> "Sorted, no duplicates" might have become de facto ABI.  Not sure.
> However, I believe your patch won't affect it, as per the argument I
> just made.
> 
>> -> hmp_info_memdev() uses this list
>> --> List converted again to a string using string output visitor
>>
>> -> I don't think unique/sorted is relevant here.
> 
> HMP is not a stable interface.
> 
>> Am I missing anything / is any of my statements wrong?
> 
> Searching the QAPI schema for lists of integers coughs up block latency
> histogram stuff, but that's unrelated, as far as I can tell.
> 
> Looks like we're good.  I didn't expect that :)
> 

Haha, me too. Will add a short description to the patch message and
maybe resend tomorrow!


-- 

Thanks,

David / dhildenb
