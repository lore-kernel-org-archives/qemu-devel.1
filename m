Received: from eggs.gnu.org ([2001:4830:134:3::10]:43876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g9S2N-0004Iw-6g
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 05:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g9S2J-0006Wj-IJ
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 05:41:14 -0400
References: <20180823154655.40188-1-vsementsov@virtuozzo.com>
	<20180823154655.40188-2-vsementsov@virtuozzo.com>
	<2a8dda25-67e8-b710-7de3-00f5db68015e@redhat.com>
	<9479fc3b-124a-9998-267b-b2f96b1643c3@virtuozzo.com>
	<5b09b36c-c94f-371a-70fc-92bf60cf2a60@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <7a2d4246-b205-c68a-7aeb-77390865fb64@virtuozzo.com>
Date: Mon, 8 Oct 2018 12:40:55 +0300
MIME-Version: 1.0
In-Reply-To: <5b09b36c-c94f-371a-70fc-92bf60cf2a60@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 1/3] qapi: add x-debug-query-block-graph
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: crosa@redhat.com, ehabkost@redhat.com, eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, famz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com

05.10.2018 22:34, Max Reitz wrote:
> On 02.10.18 15:01, Vladimir Sementsov-Ogievskiy wrote:
>> 28.09.2018 19:31, Max Reitz wrote:
>>> On 23.08.18 17:46, Vladimir Sementsov-Ogievskiy wrote:
>>>> Add a new command, returning block nodes (and their users) graph.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>>    qapi/block-core.json           |  91 +++++++++++++++++++++++
>>>>    include/block/block.h          |   1 +
>>>>    include/sysemu/block-backend.h |   2 +
>>>>    block.c                        | 129 +++++++++++++++++++++++++++++++++
>>>>    block/block-backend.c          |   5 ++
>>>>    blockdev.c                     |   5 ++
>>>>    6 files changed, 233 insertions(+)
>>> The design looks better (that is to say, good) to me, so I mostly have
>>> technical remarks.  (Only a bit of bike-shedding this time.)
>>>
>>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>>> index 4c7a37afdc..34cdc595d7 100644
>>>> --- a/qapi/block-core.json
>>>> +++ b/qapi/block-core.json
>>>> @@ -1629,6 +1629,97 @@
>>>>    ##
>>>>    { 'command': 'query-named-block-nodes', 'returns': [
>>>> 'BlockDeviceInfo' ] }
>>>>    +##
>>>> +# @BlockGraphNodeType:
>>>> +#
>>>> +# Since: 3.1
>>>> +##
>>>> +{ 'enum': 'BlockGraphNodeType',
>>>> +  'data': [ 'blk', 'job', 'bds' ] }
>>> I wouldn't use abbreviations here, but the full names.  At least they
>>> should be described.
>> Hmm do you have a suggestion? Do you mean something like
>>    block-backend
>>    block-job
>>    block-driver-state
>> ?
> That's what I meant, yes; though I'm not sure I was right.
>
> "block-backend" sounds good; "job" is up to you since it isn't
> necessarily an abbreviation.
>
> About BDSs...  I guess I'll leave it up to you, too.  block-driver-state
> doesn't tell people more than just "bds", so it isn't much more useful.
>   Usually I'd call it "node" because that's what we like to call it in
> docs.  Unfortunately, that won't quite work here, because in this case,
> all of these things are nodes.
>
> "block-node" would be the best I can come up with.  But I'm not sure
> whether it's any better than "bds", so I'll just leave it up to you.
>
> Documentation would still be nice, but I don't even know how you'd
> describe @bds.  "BlockDriverState"?  Technically it'd be "Node of the
> block graph", but, er, well.  That's a bad description for an element of
> the "BlockGraphNodeType" enum.
>
> So what I'm saying is "block-backend" would be nice, the rest is up to you.
>
>>> (Though with x-debug-, it doesn't matter too much.)
>>>
>>>> +
>>>> +##
>>>> +# @BlockGraphNode:
>>>> +#
>>> I think a description on at least what the name means for each type
>>> would be useful; and that @id is generated just for this request and not
>>> some significant value in the block layer.
>> let me compose here, before sending next version:
>>
>> @id: Block graph node identifier. This @id is generated only for
>> x-debug-query-block-graph and don't relate to any other identifiers in
> s/don't/does not/
>
>> Qemu.
>> @type: Type of graph node. Can be one of block-backend, block-job or
>> block-driver-state.
>> @name: Human readable name of the node. Corresponds to node-name for
>> block-driver-state nodes, and not guaranteed to be unique in the whole
> I'd prefer s/, and/; is/ (or s/, and/. Is/)
>
>> graph (with block-jobs and block-backends)
> Sounds good to me overall.
>
> [...]
>
>>>> +}
>>>> +
>>>> +static uint64_t graph_node_num(BlockGraphConstructor *gr, void *node)
>>>> +{
>>>> +    uint64_t ret = (uint64_t)g_hash_table_lookup(gr->hash, node);
>>> I'd prefer a cast to uintptr_t.  Otherwise the compiler may warn that
>>> you cast a pointer to an integer of different size (with -m32).
>>>
>>> Storing it in a uint64_t (with an implicit cast then) is OK, though.
>>> But maybe you do want to store it in a uintptr_t.  The only reason not
>>> to is because it's a uint64_t in the QAPI schema, but I think it'd be a
>>> bit cleaner to work with uintptr_t internally and then emit it as
>>> uint64_t (because that's definitely safe).  It's just a bit more honest
>>> because this way it's clear that with -m32, we cannot even represent IDs
>>> larger than 32 bit (which doesn't matter).
>> ok. then, why not use just "void *" ?
> Because you want to store integer IDs and not pointers.

Ah, didn't know what is uintptr_t, ashamed)

>
>>>> +
>>>> +    if (ret > 0) {
>>> Just for style I'd prefer != over >.  That makes it more clear that this
>>> is a NULL check and not a check for errors (represented as negative
>>> integers, even though @ret is unsigned).
>> hm and it will be more clear with pointer type...
>>
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    ret = g_hash_table_size(gr->hash) + 1;
>>> Maybe add a comment that you add 1 because 0 (NULL) is reserved for
>>> non-entries?  (Yes, it's clear, or I wouldn't have figured it out, but
>>> I'd still find it nice.)
>> hmm, I don't remember why is it reserved, looks like it doesn't matter..
>> But it may be more native to count graph nodes from 1, not from 0.
> Because you only have a single function for adding entries to and
> querying entries from gr->hash.  So it needs to distinguish whether a
> node already has an ID or not.  If it does not, g_hash_table_lookup()
> will return NULL, so you cannot add entries with index 0, because they
> will look like the entry does not exist yet.  (So the first call to
> graph_node_num() will return 0, and the second call for the same node
> will overwrite that value with something else.  Presumably you'll then
> have a BlockBackend with ID 0 but not edge using the ID 0.)
>
> You can use ID 0 if instead of checking whether "ret != 0" you'd use
> g_hash_table_contains() or g_hash_table_lookup_extended() instead.

Hm, looks correct. It's a bit strange to thank for explanation of my own 
code, nevertheless thank you!

>
> Max
>


-- 
Best regards,
Vladimir
