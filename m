Received: from eggs.gnu.org ([2001:4830:134:3::10]:38797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dO2cw-0005qY-MH
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 09:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dO2cr-0006Wh-O2
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 09:58:30 -0400
References: <20170613121639.17853-1-pbutsykin@virtuozzo.com>
	<20170613121639.17853-4-pbutsykin@virtuozzo.com>
	<aed64e0e-61ed-12c9-8676-ad55795b6e62@redhat.com>
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <5fb63c73-ddc7-ba42-268f-bda160aebb6e@virtuozzo.com>
Date: Thu, 22 Jun 2017 16:57:07 +0300
MIME-Version: 1.0
In-Reply-To: <aed64e0e-61ed-12c9-8676-ad55795b6e62@redhat.com>
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


On 22.06.2017 01:55, Max Reitz wrote:
> On 2017-06-13 14:16, Pavel Butsykin wrote:
>> This patch add shrinking of the image file for qcow2. As a result, this allows
>> us to reduce the virtual image size and free up space on the disk without
>> copying the image. Image can be fragmented and shrink is done by punching holes
>> in the image file.
>>
>> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
>> ---
>>   block/qcow2-cluster.c  | 42 ++++++++++++++++++++++++++++++++
>>   block/qcow2-refcount.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>   block/qcow2.c          | 40 +++++++++++++++++++++++--------
>>   block/qcow2.h          |  2 ++
>>   qapi/block-core.json   |  3 ++-
>>   5 files changed, 141 insertions(+), 11 deletions(-)
>>
>> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
>> index d779ea19cf..a84b7e607e 100644
>> --- a/block/qcow2-cluster.c
>> +++ b/block/qcow2-cluster.c
>> @@ -32,6 +32,48 @@
>>   #include "qemu/bswap.h"
>>   #include "trace.h"
>>   
>> +int qcow2_shrink_l1_table(BlockDriverState *bs, uint64_t max_size)
> 
> It's not really a max_size but always an exact size. You don't want it
> to be any smaller than this.
> 
>> +{
>> +    BDRVQcow2State *s = bs->opaque;
>> +    int new_l1_size, i, ret;
>> +
>> +    if (max_size >= s->l1_size) {
>> +        return 0;
>> +    }
>> +
>> +    new_l1_size = max_size;
>> +
>> +#ifdef DEBUG_ALLOC2
>> +    fprintf(stderr, "shrink l1_table from %d to %" PRId64 "\n",
>> +            s->l1_size, new_l1_size);
> 
> new_l1_size is of type int, not int64_t.
> 
>> +#endif
>> +
>> +    BLKDBG_EVENT(bs->file, BLKDBG_L1_SHRINK_WRITE_TABLE);
>> +    ret = bdrv_pwrite_zeroes(bs->file, s->l1_table_offset +
>> +                                       sizeof(uint64_t) * new_l1_size,
>> +                             (s->l1_size - new_l1_size) * sizeof(uint64_t), 0);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    ret = bdrv_flush(bs->file->bs);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    BLKDBG_EVENT(bs->file, BLKDBG_L1_SHRINK_FREE_L2_CLUSTERS);
>> +    for (i = s->l1_size - 1; i > new_l1_size - 1; i--) {
>> +        if ((s->l1_table[i] & L1E_OFFSET_MASK) == 0) {
>> +            continue;
>> +        }
>> +        qcow2_free_clusters(bs, s->l1_table[i] & L1E_OFFSET_MASK,
>> +                            s->l2_size * sizeof(uint64_t),
> 
> I'm more of a fan of s->cluster_size instead of s->l2_size *
> sizeof(uint64_t) but it's not like it matters...
> 
>> +                            QCOW2_DISCARD_ALWAYS);
>> +        s->l1_table[i] = 0;
> 
> I'd probably clear the overhanging s->l1_table entries before
> bdrv_flush() (before you shouldn't really use them after
> bdrv_pwrite_zeroes() has returned, even if bdrv_flush() has failed), but
> it's not absolutely necessary. As long as they still have a refcount of
> at least one, writing to them will just be useless but not destroy any data.
>

You're right, but If it's not necessary, I would prefer to leave as is..
Just because overhanging s->l1_table entries used to release clusters :)

>> +    }
>> +    return 0;
>> +}
>> +
>>   int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
>>                           bool exact_size)
>>   {
>> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
>> index 576ab551d6..e98306acd8 100644
>> --- a/block/qcow2-refcount.c
>> +++ b/block/qcow2-refcount.c
>> @@ -29,6 +29,7 @@
>>   #include "block/qcow2.h"
>>   #include "qemu/range.h"
>>   #include "qemu/bswap.h"
>> +#include "qemu/cutils.h"
>>   
>>   static int64_t alloc_clusters_noref(BlockDriverState *bs, uint64_t size);
>>   static int QEMU_WARN_UNUSED_RESULT update_refcount(BlockDriverState *bs,
>> @@ -2936,3 +2937,67 @@ done:
>>       qemu_vfree(new_refblock);
>>       return ret;
>>   }
>> +
>> +int qcow2_shrink_reftable(BlockDriverState *bs)
>> +{
>> +    BDRVQcow2State *s = bs->opaque;
>> +    uint64_t *reftable_tmp =
>> +        g_try_malloc(sizeof(uint64_t) * s->refcount_table_size);
>> +    int i, ret;
>> +
>> +    if (s->refcount_table_size && reftable_tmp == NULL) {
>> +        return -ENOMEM;
>> +    }
>> +
>> +    for (i = 0; i < s->refcount_table_size; i++) {
>> +        int64_t refblock_offs = s->refcount_table[i] & REFT_OFFSET_MASK;
>> +        void *refblock;
>> +        bool unused_block;
>> +
>> +        if (refblock_offs == 0) {
>> +            reftable_tmp[i] = 0;
>> +            continue;
>> +        }
>> +        ret = qcow2_cache_get(bs, s->refcount_block_cache, refblock_offs,
>> +                              &refblock);
>> +        if (ret < 0) {
>> +            goto out;
>> +        }
>> +
>> +        /* the refblock has own reference */
>> +        if (i == refblock_offs >> (s->refcount_block_bits + s->cluster_bits)) {
>> +            uint64_t blk_index = (refblock_offs >> s->cluster_bits) &
>> +                                 (s->refcount_block_size - 1);
>> +            uint64_t refcount = s->get_refcount(refblock, blk_index);
>> +
>> +            s->set_refcount(refblock, blk_index, 0);
>> +
>> +            unused_block = buffer_is_zero(refblock, s->refcount_block_size);
> 
> s/refcount_block_size/cluster_size/
> 
>> +
>> +            s->set_refcount(refblock, blk_index, refcount);
>> +        } else {
>> +            unused_block = buffer_is_zero(refblock, s->refcount_block_size);
> 
> Same here.
> 
>> +        }
>> +        qcow2_cache_put(bs, s->refcount_block_cache, &refblock);
>> +
>> +        reftable_tmp[i] = unused_block ? 0 : cpu_to_be64(s->refcount_table[i]);
>> +    }
>> +
>> +    ret = bdrv_pwrite_sync(bs->file, s->refcount_table_offset, reftable_tmp,
>> +                           sizeof(uint64_t) * s->refcount_table_size);
>> +    if (ret < 0) {
>> +        goto out;
>> +    }
>> +
>> +    for (i = 0; i < s->refcount_table_size; i++) {
>> +        if (s->refcount_table[i] && !reftable_tmp[i]) {
>> +            qcow2_free_clusters(bs, s->refcount_table[i] & REFT_OFFSET_MASK,
>> +                                s->cluster_size, QCOW2_DISCARD_ALWAYS);
> 
> This doesn't feel like a very good idea. The bdrv_pwrite_sync() before
> has brought the on-disk refcount structures into a different state than
> what we have cached.

It is for this inside qcow2_free_clusters()->update_refcount() the cache
is discarded by qcow2_cache_discard().

> OTOH, the bdrv_pwrite_sync() has accessed only the reftable and this
> should only access refblocks. So I cannot think of any way this might
> actually do something bad. But I guess it'll be better for to revisit
> this when it's not in the middle of the night (so on Friday).
> 
>> +            s->refcount_table[i] = 0;
>> +        }
>> +    }
>> +
>> +out:
>> +    g_free(reftable_tmp);
>> +    return ret;
>> +}
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index b3ba5daa93..0ad46d2776 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -2545,6 +2545,7 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
>>   {
>>       BDRVQcow2State *s = bs->opaque;
>>       int64_t new_l1_size;
>> +    uint64_t total_size;
>>       int ret;
>>   
>>       if (offset & 511) {
>> @@ -2558,17 +2559,36 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
>>           return -ENOTSUP;
>>       }
>>   
>> -    /* shrinking is currently not supported */
>> -    if (offset < bs->total_sectors * 512) {
>> -        error_setg(errp, "qcow2 doesn't support shrinking images yet");
>> -        return -ENOTSUP;
>> -    }
>> -
>>       new_l1_size = size_to_l1(s, offset);
>> -    ret = qcow2_grow_l1_table(bs, new_l1_size, true);
>> -    if (ret < 0) {
>> -        error_setg_errno(errp, -ret, "Failed to grow the L1 table");
>> -        return ret;
>> +    total_size = bs->total_sectors << BDRV_SECTOR_BITS;
>> +
>> +    if (offset < total_size) {
>> +        ret = qcow2_cluster_discard(bs, ROUND_UP(offset, s->cluster_size),
>> +                                    total_size - ROUND_UP(offset,
>> +                                                          s->cluster_size),
>> +                                    QCOW2_DISCARD_ALWAYS, true);
>> +        if (ret < 0) {
>> +            error_setg_errno(errp, -ret, "Failed to discard reduced clasters");
> 
> s/clasters/clusters/
> 
> And maybe "truncated", "stripped", or "cropped" instead of "reduced"?
> 
>> +            return ret;
>> +        }
>> +
>> +        ret = qcow2_shrink_l1_table(bs, new_l1_size);
>> +        if (ret < 0) {
>> +            error_setg_errno(errp, -ret, "Failed to reduce the L1 table");
> 
> s/reduce/shrink/ (or "truncate"; or "reduce the L1 table size")
> 
> Also, to be fair, you're actually reducing the number of L2 tables, not
> the size of the L1 table. (But that's a nit pick)

In the previous patch version, there really was reducing the L1 table
size :) I think now it's better to fix the error message.

>> +            return ret;
>> +        }
>> +
>> +        ret = qcow2_shrink_reftable(bs);
>> +        if (ret < 0) {
>> +            error_setg_errno(errp, -ret, "Failed to shrink the refcount table");
> 
> And this is not really shrinking the reftable but instead discarding
> some refblocks (potentially). (This is a nit pick, too)
> 
> Max
> 
>> +            return ret;
>> +        }
>> +    } else {
>> +        ret = qcow2_grow_l1_table(bs, new_l1_size, true);
>> +        if (ret < 0) {
>> +            error_setg_errno(errp, -ret, "Failed to grow the L1 table");
>> +            return ret;
>> +        }
>>       }
>>   
>>       /* write updated header.size */
>> diff --git a/block/qcow2.h b/block/qcow2.h
>> index 07faa6dc78..600463bf8e 100644
>> --- a/block/qcow2.h
>> +++ b/block/qcow2.h
>> @@ -531,10 +531,12 @@ int qcow2_pre_write_overlap_check(BlockDriverState *bs, int ign, int64_t offset,
>>   int qcow2_change_refcount_order(BlockDriverState *bs, int refcount_order,
>>                                   BlockDriverAmendStatusCB *status_cb,
>>                                   void *cb_opaque, Error **errp);
>> +int qcow2_shrink_reftable(BlockDriverState *bs);
>>   
>>   /* qcow2-cluster.c functions */
>>   int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
>>                           bool exact_size);
>> +int qcow2_shrink_l1_table(BlockDriverState *bs, uint64_t max_size);
>>   int qcow2_write_l1_entry(BlockDriverState *bs, int l1_index);
>>   int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset);
>>   int qcow2_encrypt_sectors(BDRVQcow2State *s, int64_t sector_num,
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index f85c2235c7..bcbffa3339 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -2372,7 +2372,8 @@
>>               'cluster_alloc_bytes', 'cluster_free', 'flush_to_os',
>>               'flush_to_disk', 'pwritev_rmw_head', 'pwritev_rmw_after_head',
>>               'pwritev_rmw_tail', 'pwritev_rmw_after_tail', 'pwritev',
>> -            'pwritev_zero', 'pwritev_done', 'empty_image_prepare' ] }
>> +            'pwritev_zero', 'pwritev_done', 'empty_image_prepare',
>> +            'l1_shrink_write_table', 'l1_shrink_free_l2_clusters' ] }
>>   
>>   ##
>>   # @BlkdebugInjectErrorOptions:
>>
> 
> 
