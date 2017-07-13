Received: from eggs.gnu.org ([2001:4830:134:3::10]:59074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dVhuj-00041l-UJ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 13:28:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dVhue-0001XC-Vs
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 13:28:33 -0400
References: <20170712114700.20008-1-pbutsykin@virtuozzo.com>
	<20170712114700.20008-4-pbutsykin@virtuozzo.com>
	<20170712145251.GE4917@noname.str.redhat.com>
	<ca2e112d-23d7-48c1-07a9-b60ee8ab743f@redhat.com>
	<20170713084126.GA4139@noname.redhat.com>
	<e8199299-6e5b-9dc8-a7d9-12a8d3da19dd@redhat.com>
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <ea6a0441-b07b-4cd1-8964-3ae9234f9ce5@virtuozzo.com>
Date: Thu, 13 Jul 2017 20:28:14 +0300
MIME-Version: 1.0
In-Reply-To: <e8199299-6e5b-9dc8-a7d9-12a8d3da19dd@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 3/4] qcow2: add shrink image support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com, den@openvz.org

On 13.07.2017 17:36, Max Reitz wrote:
> On 2017-07-13 10:41, Kevin Wolf wrote:
>> Am 12.07.2017 um 18:58 hat Max Reitz geschrieben:
>>> On 2017-07-12 16:52, Kevin Wolf wrote:
>>>> Am 12.07.2017 um 13:46 hat Pavel Butsykin geschrieben:
>>>>> This patch add shrinking of the image file for qcow2. As a result, this allows
>>>>> us to reduce the virtual image size and free up space on the disk without
>>>>> copying the image. Image can be fragmented and shrink is done by punching holes
>>>>> in the image file.
>>>>>
>>>>> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
>>>>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>>>> ---
>>>>>   block/qcow2-cluster.c  |  40 ++++++++++++++++++
>>>>>   block/qcow2-refcount.c | 110 +++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>   block/qcow2.c          |  43 +++++++++++++++----
>>>>>   block/qcow2.h          |  14 +++++++
>>>>>   qapi/block-core.json   |   3 +-
>>>>>   5 files changed, 200 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
>>>>> index f06c08f64c..518429c64b 100644
>>>>> --- a/block/qcow2-cluster.c
>>>>> +++ b/block/qcow2-cluster.c
>>>>> @@ -32,6 +32,46 @@
>>>>>   #include "qemu/bswap.h"
>>>>>   #include "trace.h"
>>>>>   
>>>>> +int qcow2_shrink_l1_table(BlockDriverState *bs, uint64_t exact_size)
>>>>> +{
>>>>> +    BDRVQcow2State *s = bs->opaque;
>>>>> +    int new_l1_size, i, ret;
>>>>> +
>>>>> +    if (exact_size >= s->l1_size) {
>>>>> +        return 0;
>>>>> +    }
>>>>> +
>>>>> +    new_l1_size = exact_size;
>>>>> +
>>>>> +#ifdef DEBUG_ALLOC2
>>>>> +    fprintf(stderr, "shrink l1_table from %d to %d\n", s->l1_size, new_l1_size);
>>>>> +#endif
>>>>> +
>>>>> +    BLKDBG_EVENT(bs->file, BLKDBG_L1_SHRINK_WRITE_TABLE);
>>>>> +    ret = bdrv_pwrite_zeroes(bs->file, s->l1_table_offset +
>>>>> +                                       sizeof(uint64_t) * new_l1_size,
>>>>> +                             (s->l1_size - new_l1_size) * sizeof(uint64_t), 0);
>>>>> +    if (ret < 0) {
>>>>> +        return ret;
>>>>> +    }
>>>>> +
>>>>> +    ret = bdrv_flush(bs->file->bs);
>>>>> +    if (ret < 0) {
>>>>> +        return ret;
>>>>> +    }
>>>>
>>>> If we have an error here (or after a partial bdrv_pwrite_zeroes()), we
>>>> have entries zeroed out on disk, but in memory we still have the
>>>> original L1 table.
>>>>
>>>> Should the in-memory L1 table be zeroed first? Then we can't
>>>> accidentally reuse stale entries, but would have to allocate new ones,
>>>> which would get on-disk state and in-memory state back in sync again.
>>>
>>> Yes, I thought of the same.  But this implies that the allocation is
>>> able to modify the L1 table, and I find that unlikely if that
>>> bdrv_flush() failed already...
>>>
>>> So I concluded not to have an opinion on which order is better.
>>
>> Well, let me ask the other way round: Is there any disadvantage in first
>> zeroing the in-memory table and then writing to the image?
> 
> I was informed that the code would be harder to write. :-)
> 
>> If I have a choice between "always safe" and "not completely safe, but I
>> think it's unlikely to happen", especially in image formats, then I will
>> certainly take the "always safe".
>>
>>>>> +    BLKDBG_EVENT(bs->file, BLKDBG_L1_SHRINK_FREE_L2_CLUSTERS);
>>>>> +    for (i = s->l1_size - 1; i > new_l1_size - 1; i--) {
>>>>> +        if ((s->l1_table[i] & L1E_OFFSET_MASK) == 0) {
>>>>> +            continue;
>>>>> +        }
>>>>> +        qcow2_free_clusters(bs, s->l1_table[i] & L1E_OFFSET_MASK,
>>>>> +                            s->cluster_size, QCOW2_DISCARD_ALWAYS);
>>>>> +        s->l1_table[i] = 0;
>>>>> +    }
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>>   int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
>>>>>                           bool exact_size)
>>>>>   {
>>>>
>>>> I haven't checked qcow2_shrink_reftable() for similar kinds of problems,
>>>> I hope Max has.
>>>
>>> Well, it's exactly the same there.
>>
>> Ok, so I'll object to this code without really having looked at it.
> I won't object to your objection. O:-)

Kevin,

Can you help me to reduce the number of patch-set versions? :)
And look at the rest part of the series, thanks!

> Max
> 
