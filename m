Received: from eggs.gnu.org ([2001:4830:134:3::10]:59715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dPVsd-0002B4-Hj
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 11:24:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dPVsZ-0000IA-Fq
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 11:24:47 -0400
References: <20170613121639.17853-1-pbutsykin@virtuozzo.com>
	<20170613121639.17853-4-pbutsykin@virtuozzo.com>
	<aed64e0e-61ed-12c9-8676-ad55795b6e62@redhat.com>
	<5fb63c73-ddc7-ba42-268f-bda160aebb6e@virtuozzo.com>
	<d3c0c0c2-da7e-bfff-e3c6-2d419c1126b9@redhat.com>
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <3b1b1a7e-ab9f-1376-fc3c-0853fb12987b@virtuozzo.com>
Date: Mon, 26 Jun 2017 18:23:16 +0300
MIME-Version: 1.0
In-Reply-To: <d3c0c0c2-da7e-bfff-e3c6-2d419c1126b9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/4] qcow2: add shrink image support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org

On 23.06.2017 18:46, Max Reitz wrote:
> On 2017-06-22 15:57, Pavel Butsykin wrote:
>>
>> On 22.06.2017 01:55, Max Reitz wrote:
>>> On 2017-06-13 14:16, Pavel Butsykin wrote:
[]
>>>> +        }
>>>> +        qcow2_cache_put(bs, s->refcount_block_cache, &refblock);
>>>> +
>>>> +        reftable_tmp[i] = unused_block ? 0 :
>>>> cpu_to_be64(s->refcount_table[i]);
>>>> +    }
>>>> +
>>>> +    ret = bdrv_pwrite_sync(bs->file, s->refcount_table_offset,
>>>> reftable_tmp,
>>>> +                           sizeof(uint64_t) * s->refcount_table_size);
>>>> +    if (ret < 0) {
>>>> +        goto out;
>>>> +    }
>>>> +
>>>> +    for (i = 0; i < s->refcount_table_size; i++) {
>>>> +        if (s->refcount_table[i] && !reftable_tmp[i]) {
>>>> +            qcow2_free_clusters(bs, s->refcount_table[i] &
>>>> REFT_OFFSET_MASK,
>>>> +                                s->cluster_size, QCOW2_DISCARD_ALWAYS);
>>>
>>> This doesn't feel like a very good idea. The bdrv_pwrite_sync() before
>>> has brought the on-disk refcount structures into a different state than
>>> what we have cached.
>>
>> It is for this inside qcow2_free_clusters()->update_refcount() the cache
>> is discarded by qcow2_cache_discard().
> 
> This doesn't change the fact that the in-memory reftable is different
> from the on-disk reftable and that qcow2_free_clusters() may trip up on
> that; the main issue is the allocate_refcount_block() call before.

before what?

If we are talking about allocate_refcount_block() calls after
bdrv_pwrite_sync(), then... Inside allocate_refcount_block() will always
be called load_refcount_block(), what actually is not so dangerous even
if refcount_block_cache is empty. Because the refblock offset will
always be taken from s->refcount_table.

> So we need a guarantee that update_refcount() won't touch the reftable
> if the refcount is decreased. It will call alloc_refcount_block() and
> that should definitely find the respective refblock to already exist
> because of course it has a refcount already.

We don't touch the refblocks which contain references to other
refblocks, this ensures that update_refcount() will not try to raise
the discarded refblock.

> But here's an issue: It tries to read from s->refcount_table[], and you
> are slowly overwriting it in the same loop here. So it may not actually
> find the refcount (if a refblock is described by an earlier one).
> (After more than an hour of debugging, I realized this is not true: You
> will only zero reftable entries if the refblock describes nothing or
> only themselves. So overwriting one reftable entry cannot have effects
> on other refblocks. Or at least it should not.)

As you've noticed, here uses a simple approach:
We discard only refblocks that contain nothing or own reference. If we
have a refblock that is actually empty, but contains a reference to
another empty refblock, we don't touch this refblock. Maybe it's not the
best solution, but at least it's simple and secure.

There is another approach that can be applied here:

1. decrease the refcounts for all refblocks
2. find all empty refblocks
3. increase the refcounts for all refblocks
4. rewrite the refcount_table on disk (with the empty reftable entries)
5. release all the emptt reblocks in reverse order (start at the end of 
the s->refcount_table)

This will certainly allow us to get rid of all empty reblocks, but the
code will be less welcoming :) Also the case when the refblock contains
a reference to another refblock is quite rare.

> Another potential issue is that you're assuming s->refcount_table_size
> to be constant. I cannot find a way for it not to be, but investigating
> this is painful and I can't claim I know for sure that it is constant.
> If it isn't, you may get overflows when accessing reftable_tmp[].
> 
> (Yes, it may be constant; but the reader of this code has to read
> through qcow2_free_clusters(), allocate_refcount_block() and
> update_refcount() to know (or at least to guess) that's the case.)

Is there any guarantee that in the future this will not change? Because
in this case it can be a potential danger.

I can add a comment... Or add a new variable with the size of
reftable_tmp, and every time count min(s->refcount_table_size, 
reftable_tmp_size)
before accessing to s->refcount_table[]/reftable_tmp[]

> I don't really want to look deeper into this, but here's an image that I
> produced while trying to somehow break all of this. It makes qemu-img
> check pass but fails after qemu-img resize --shrink shrink.qcow2 32M:
> https://xanclic.moe/shrink.qcow2
> 
> (The image has been created with cluster_size=512 and refcount_bits=64;
> then I filled the penultimate two entries of the reftable with pointers
> to 0x1f0000 and 0x1f0200, respectively (so the first of these refblocks
> would describe both), giving me this:
> https://xanclic.moe/shrink-template.qcow2
> I then put some data onto it with qemu-io -c 'write 0 1457K', which gave
> me shrink.qcow2.)
>

Thank you for the samples! The mistake was quite naive :) , I just
messed up the sizes here:
             unused_block = buffer_is_zero(refblock, ->refcount_block_size);

             s->set_refcount(refblock, blk_index, refcount);
         } else {
             unused_block = buffer_is_zero(refblock, 
s->refcount_block_size);

Should be:
buffer_is_zero(refblock, s->cluster_size);

> Max
> 
>>> OTOH, the bdrv_pwrite_sync() has accessed only the reftable and this
>>> should only access refblocks. So I cannot think of any way this might
>>> actually do something bad. But I guess it'll be better for to revisit
>>> this when it's not in the middle of the night (so on Friday).
>>>
>>>> +            s->refcount_table[i] = 0;
>>>> +        }
>>>> +    }
>>>> +
>>>> +out:
>>>> +    g_free(reftable_tmp);
>>>> +    return ret;
>>>> +}
>>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>>> index b3ba5daa93..0ad46d2776 100644
>>>> --- a/block/qcow2.c
>>>> +++ b/block/qcow2.c
>>>> @@ -2545,6 +2545,7 @@ static int qcow2_truncate(BlockDriverState *bs,
>>>> int64_t offset, Error **errp)
>>>>    {
>>>>        BDRVQcow2State *s = bs->opaque;
>>>>        int64_t new_l1_size;
>>>> +    uint64_t total_size;
>>>>        int ret;
>>>>          if (offset & 511) {
>>>> @@ -2558,17 +2559,36 @@ static int qcow2_truncate(BlockDriverState
>>>> *bs, int64_t offset, Error **errp)
>>>>            return -ENOTSUP;
>>>>        }
>>>>    -    /* shrinking is currently not supported */
>>>> -    if (offset < bs->total_sectors * 512) {
>>>> -        error_setg(errp, "qcow2 doesn't support shrinking images yet");
>>>> -        return -ENOTSUP;
>>>> -    }
>>>> -
>>>>        new_l1_size = size_to_l1(s, offset);
>>>> -    ret = qcow2_grow_l1_table(bs, new_l1_size, true);
>>>> -    if (ret < 0) {
>>>> -        error_setg_errno(errp, -ret, "Failed to grow the L1 table");
>>>> -        return ret;
>>>> +    total_size = bs->total_sectors << BDRV_SECTOR_BITS;
>>>> +
>>>> +    if (offset < total_size) {
>>>> +        ret = qcow2_cluster_discard(bs, ROUND_UP(offset,
>>>> s->cluster_size),
>>>> +                                    total_size - ROUND_UP(offset,
>>>> +
>>>> s->cluster_size),
>>>> +                                    QCOW2_DISCARD_ALWAYS, true);
>>>> +        if (ret < 0) {
>>>> +            error_setg_errno(errp, -ret, "Failed to discard reduced
>>>> clasters");
>>>
>>> s/clasters/clusters/
>>>
>>> And maybe "truncated", "stripped", or "cropped" instead of "reduced"?
>>>
>>>> +            return ret;
>>>> +        }
>>>> +
>>>> +        ret = qcow2_shrink_l1_table(bs, new_l1_size);
>>>> +        if (ret < 0) {
>>>> +            error_setg_errno(errp, -ret, "Failed to reduce the L1
>>>> table");
>>>
>>> s/reduce/shrink/ (or "truncate"; or "reduce the L1 table size")
>>>
>>> Also, to be fair, you're actually reducing the number of L2 tables, not
>>> the size of the L1 table. (But that's a nit pick)
>>
>> In the previous patch version, there really was reducing the L1 table
>> size :) I think now it's better to fix the error message.
>>
>>>> +            return ret;
>>>> +        }
>>>> +
>>>> +        ret = qcow2_shrink_reftable(bs);
>>>> +        if (ret < 0) {
>>>> +            error_setg_errno(errp, -ret, "Failed to shrink the
>>>> refcount table");
>>>
>>> And this is not really shrinking the reftable but instead discarding
>>> some refblocks (potentially). (This is a nit pick, too)
>>>
>>> Max
>>>
>>>> +            return ret;
>>>> +        }
>>>> +    } else {
>>>> +        ret = qcow2_grow_l1_table(bs, new_l1_size, true);
>>>> +        if (ret < 0) {
>>>> +            error_setg_errno(errp, -ret, "Failed to grow the L1
>>>> table");
>>>> +            return ret;
>>>> +        }
>>>>        }
>>>>          /* write updated header.size */
>>>> diff --git a/block/qcow2.h b/block/qcow2.h
>>>> index 07faa6dc78..600463bf8e 100644
>>>> --- a/block/qcow2.h
>>>> +++ b/block/qcow2.h
>>>> @@ -531,10 +531,12 @@ int
>>>> qcow2_pre_write_overlap_check(BlockDriverState *bs, int ign, int64_t
>>>> offset,
>>>>    int qcow2_change_refcount_order(BlockDriverState *bs, int
>>>> refcount_order,
>>>>                                    BlockDriverAmendStatusCB *status_cb,
>>>>                                    void *cb_opaque, Error **errp);
>>>> +int qcow2_shrink_reftable(BlockDriverState *bs);
>>>>      /* qcow2-cluster.c functions */
>>>>    int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
>>>>                            bool exact_size);
>>>> +int qcow2_shrink_l1_table(BlockDriverState *bs, uint64_t max_size);
>>>>    int qcow2_write_l1_entry(BlockDriverState *bs, int l1_index);
>>>>    int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t
>>>> cluster_offset);
>>>>    int qcow2_encrypt_sectors(BDRVQcow2State *s, int64_t sector_num,
>>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>>> index f85c2235c7..bcbffa3339 100644
>>>> --- a/qapi/block-core.json
>>>> +++ b/qapi/block-core.json
>>>> @@ -2372,7 +2372,8 @@
>>>>                'cluster_alloc_bytes', 'cluster_free', 'flush_to_os',
>>>>                'flush_to_disk', 'pwritev_rmw_head',
>>>> 'pwritev_rmw_after_head',
>>>>                'pwritev_rmw_tail', 'pwritev_rmw_after_tail', 'pwritev',
>>>> -            'pwritev_zero', 'pwritev_done', 'empty_image_prepare' ] }
>>>> +            'pwritev_zero', 'pwritev_done', 'empty_image_prepare',
>>>> +            'l1_shrink_write_table', 'l1_shrink_free_l2_clusters' ] }
>>>>      ##
>>>>    # @BlkdebugInjectErrorOptions:
>>>>
>>>
>>>
> 
> 
