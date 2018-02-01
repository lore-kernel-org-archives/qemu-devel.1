Received: from eggs.gnu.org ([2001:4830:134:3::10]:33294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ehGhz-0004d2-Rj
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 10:23:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ehGhu-0005FI-Sc
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 10:23:27 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<07a984cef4f1c97dcca44e365aa90ba5b6881e09.1516978645.git.berto@igalia.com>
	<c57f7978-d54d-75f8-58f3-32d8fa5284a6@redhat.com>
	<w51r2q46eg2.fsf@maestria.local.igalia.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <d81eae0f-1481-9dd3-0df9-40063c215784@virtuozzo.com>
Date: Thu, 1 Feb 2018 18:23:09 +0300
MIME-Version: 1.0
In-Reply-To: <w51r2q46eg2.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 17/39] qcow2: Update l2_allocate() to
 support L2 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, qemu-block@nongnu.org



On 1/2/2018 4:13 PM, Alberto Garcia wrote:
> On Wed 31 Jan 2018 09:07:48 PM CET, Max Reitz wrote:
>> On 2018-01-26 15:59, Alberto Garcia wrote:
>>> This patch updates l2_allocate() to support the qcow2 cache returning
>>> L2 slices instead of full L2 tables.
>>>
>>> The old code simply gets an L2 table from the cache and initializes it
>>> with zeroes or with the contents of an existing table. With a cache
>>> that returns slices instead of tables the idea remains the same, but
>>> the code must now iterate over all the slices that are contained in an
>>> L2 table.
>>>
>>> Since now we're operating with slices the function can no longer
>>> return the newly-allocated table, so it's up to the caller to retrieve
>>> the appropriate L2 slice after calling l2_allocate() (note that with
>>> this patch the caller is still loading full L2 tables, but we'll deal
>>> with that in a separate patch).
>>>
>>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>>> ---
>>>   block/qcow2-cluster.c | 56 +++++++++++++++++++++++++++++++--------------------
>>>   1 file changed, 34 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
>>> index 57349928a9..2a53c1dc5f 100644
>>> --- a/block/qcow2-cluster.c
>>> +++ b/block/qcow2-cluster.c
>>> @@ -264,11 +264,12 @@ int qcow2_write_l1_entry(BlockDriverState *bs, int l1_index)
>>>    *
>>>    */
>>>   
>>> -static int l2_allocate(BlockDriverState *bs, int l1_index, uint64_t **table)
>>> +static int l2_allocate(BlockDriverState *bs, int l1_index)
>>>   {
>>>       BDRVQcow2State *s = bs->opaque;
>>>       uint64_t old_l2_offset;
>>> -    uint64_t *l2_table = NULL;
>>> +    uint64_t *l2_slice = NULL;
>>> +    unsigned slice, slice_size2, n_slices;
>>
>> I'd personally prefer size_t, but oh well.
> 
> I don't see any reason not to use int / unsigned. The size of a slice is
> always <= cluster_size (an int), and both slice and n_slices are smaller
> than that.
> 
>> However, I'm wondering whether this is the best approach.  The old L2
>> table is probably not going to be used after this function, so we're
>> basically polluting the cache here.  That was bad enough so far, but
>> now that actually means wasting multiple cache entries on it.
>>
>> Sure, the code is simpler this way.  But maybe it would still be
>> better to manually copy the data over from the old offset...  (As long
>> as it's not much more complicated.)
> 
> You mean bypassing the cache altogether?
> 
>      qcow2_cache_flush(bs, s->l2_table_cache);
>      new_table = g_malloc(s->cluster_size);
>      if (old_l2_offset & L1E_OFFSET_MASK) {
>          bdrv_pread(bs->file, old_l2_offset, new_table, s->cluster_size);
>      } else {
>          memset(new_table, 0, s->cluster_size);
>      }
>      bdrv_pwrite(bs->file, new_l2_offset, new_table, s->cluster_size);
>      g_free(new_table);
> 
> ??
> 
> Berto
> 

(I know it's a draft so you probably just skipped that but just in case)
It seems ok to bypass the cache read - perhaps even a flush is
not necessary: old_l2_offset must be read-only and flushed at this
point; I believe new_l2_offset might be cached too, so it
needs to be updated.
