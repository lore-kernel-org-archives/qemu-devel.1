Received: from eggs.gnu.org ([209.51.188.92]:55935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2Py4-0005Dl-RX
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 19:36:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2Py3-0006Ek-Er
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 19:36:00 -0500
References: <20190305234337.18353-1-jsnow@redhat.com>
	<20190305234337.18353-5-jsnow@redhat.com>
	<6c9c5b9b-8093-e993-1027-db692d20e2e1@virtuozzo.com>
	<737eb62f-47f4-1824-909d-8578584b8794@redhat.com>
	<bc1be082-1838-72ab-e0ae-4146ddbfbdb8@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <3f97a41b-4baf-7d49-4faa-81649b6f669f@redhat.com>
Date: Fri, 8 Mar 2019 19:35:53 -0500
MIME-Version: 1.0
In-Reply-To: <bc1be082-1838-72ab-e0ae-4146ddbfbdb8@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] block/qcow2-bitmap: Allow resizes with
 persistent bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "eblake@redhat.com" <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>



On 3/6/19 10:52 AM, Vladimir Sementsov-Ogievskiy wrote:
> 06.03.2019 18:41, John Snow wrote:
>>
>>
>> On 3/6/19 10:33 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> 06.03.2019 2:43, John Snow wrote:
>>>> Since we now load all bitmaps into memory anyway, we can just truncate them
>>>> in-memory and then flush them back to disk. Just in case, we will still check
>>>> and enforce that this shortcut is valid -- i.e. that any bitmap described
>>>> on-disk is indeed in-memory and can be modified.
>>>>
>>>> If there are any inconsistent bitmaps, we refuse to allow the truncate as
>>>> we do not actually load these bitmaps into memory, and it isn't safe or
>>>> reasonable to attempt to truncate corrupted data.
>>>>
>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>> ---
>>>>    block/qcow2.h        |  1 +
>>>>    block/qcow2-bitmap.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>>>>    block/qcow2.c        | 27 ++++++++++++++++++++-------
>>>>    3 files changed, 63 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/block/qcow2.h b/block/qcow2.h
>>>> index 4c1fdfcbec..b9227a72cc 100644
>>>> --- a/block/qcow2.h
>>>> +++ b/block/qcow2.h
>>>> @@ -689,6 +689,7 @@ Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(BlockDriverState *bs,
>>>>    int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_updated,
>>>>                                     Error **errp);
>>>>    int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
>>>> +int qcow2_truncate_bitmaps_check(BlockDriverState *bs, Error **errp);
>>>>    void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
>>>>    void qcow2_flush_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
>>>>    int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
>>>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>>>> index 9373055d3b..24f280bccc 100644
>>>> --- a/block/qcow2-bitmap.c
>>>> +++ b/block/qcow2-bitmap.c
>>>> @@ -1167,6 +1167,48 @@ int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp)
>>>>        return qcow2_reopen_bitmaps_rw_hint(bs, NULL, errp);
>>>>    }
>>>>    
>>>> +/* Checks to see if it's safe to resize bitmaps */
>>>> +int qcow2_truncate_bitmaps_check(BlockDriverState *bs, Error **errp)
>>>> +{
>>>> +    BDRVQcow2State *s = bs->opaque;
>>>> +    Qcow2BitmapList *bm_list;
>>>> +    Qcow2Bitmap *bm;
>>>> +    int ret = 0;
>>>> +
>>>> +    if (s->nb_bitmaps == 0) {
>>>> +        return 0;
>>>> +    }
>>>> +
>>>> +    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
>>>> +                               s->bitmap_directory_size, false, errp);
>>>> +    if (bm_list == NULL) {
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
>>>> +        BdrvDirtyBitmap *bitmap = bdrv_find_dirty_bitmap(bs, bm->name);
>>>> +        if (bitmap == NULL) {
>>>> +            /* We rely on all bitmaps being in-memory to be able to resize them,
>>>> +             * Otherwise, we'd need to resize them on disk explicitly */
>>>> +            error_setg(errp, "Cannot resize qcow2 with persistent bitmaps that "
>>>> +                       "were not loaded into memory");
>>>> +            ret = -ENOTSUP;
>>>> +            goto out;
>>>> +        }
>>>> +
>>>> +        /* The checks against readonly and busy are redundant, but certainly
>>>> +         * do no harm. checks against inconsistent are crucial: */
>>>> +        if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_DEFAULT, errp)) {
>>>> +            ret = -ENOTSUP;
>>>> +            goto out;
>>>> +        }
>>>> +    }
>>>> +
>>>> +out:
>>>> +    bitmap_list_free(bm_list);
>>>> +    return ret;
>>>> +}
>>>> +
>>>>    /* store_bitmap_data()
>>>>     * Store bitmap to image, filling bitmap table accordingly.
>>>>     */
>>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>>> index 7fb2730f09..6fd9252494 100644
>>>> --- a/block/qcow2.c
>>>> +++ b/block/qcow2.c
>>>> @@ -3472,7 +3472,7 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
>>>>    {
>>>>        BDRVQcow2State *s = bs->opaque;
>>>>        uint64_t old_length;
>>>> -    int64_t new_l1_size;
>>>> +    int64_t new_l1_size, offset_be;
>>>>        int ret;
>>>>        QDict *options;
>>>>    
>>>> @@ -3498,10 +3498,8 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
>>>>            goto fail;
>>>>        }
>>>>    
>>>> -    /* cannot proceed if image has bitmaps */
>>>> -    if (s->nb_bitmaps) {
>>>> -        /* TODO: resize bitmaps in the image */
>>>> -        error_setg(errp, "Can't resize an image which has bitmaps");
>>>> +    /* Only certain persistent bitmaps can be resized: */
>>>> +    if (qcow2_truncate_bitmaps_check(bs, errp)) {
>>>>            ret = -ENOTSUP;
>>>>            goto fail;
>>>>        }
>>>> @@ -3702,9 +3700,9 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
>>>>        bs->total_sectors = offset / BDRV_SECTOR_SIZE;
>>>>    
>>>>        /* write updated header.size */
>>>> -    offset = cpu_to_be64(offset);
>>>> +    offset_be = cpu_to_be64(offset);
>>>>        ret = bdrv_pwrite_sync(bs->file, offsetof(QCowHeader, size),
>>>> -                           &offset, sizeof(uint64_t));
>>>> +                           &offset_be, sizeof(uint64_t));
>>>>        if (ret < 0) {
>>>>            error_setg_errno(errp, -ret, "Failed to update the image size");
>>>>            goto fail;
>>>> @@ -3719,6 +3717,21 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
>>>>        if (ret < 0) {
>>>>            goto fail;
>>>>        }
>>>> +
>>>> +    /* Flush bitmaps */
>>>> +    if (s->nb_bitmaps) {
>>>> +        Error *local_err = NULL;
>>>> +
>>>> +        /* Usually, bitmaps get resized after this call.
>>>> +         * Force it earlier so we can make the metadata consistent. */
>>>> +        bdrv_dirty_bitmap_truncate(bs, offset);
>>>> +        qcow2_flush_persistent_dirty_bitmaps(bs, &local_err);
>>>> +        if (local_err) {
>>>> +            ret = -EINVAL;
>>>> +            goto fail;
>>>> +        }
>>>> +    }
>>>
>>> Why to flush after resize? Bitmaps will be IN_USE in the image anyway...
>>>
>>> Could we implement resize without flush first,  it would be one patch + test? And then consider
>>> flushing in separate?
>>>
>>
>> If you don't flush it to disk, all calls to retrieve the bm_list begin
>> failing because of inconsistent metadata.
>>
>> Future calls to add bitmaps, remove bitmaps, etc will start failing. It
>> seemed safest and easiest to just flush the whole suite to disk. I am
>> trying to avoid premature optimizations at this stage, as I believe
>> resizes will be very infrequent events.
> 
> Hmmm, understand.
> 
> But I think, if we are going to allow resizes, it definitely means that IN_USE flag covers not
> only bitmap data, but size field too. And we must write it to specification. And it is right
> even if you flush here, as resize may fail after your flush, and actual disk size will remain
> unchanged when bitmaps are flushed with new size.
> 
> And if size is covered by IN_USE, we should ignore it for IN_USE bitmaps (for IN_USE by us too).
> And it means, that we need check it only on qcow2_open. And not on other cases.
> 

Hm, so your proposal here is:

- Check metadata constraints (like size) only when not marked IN_USE,
(i.e. on first open)

- It's fine to skip the size constraint for inconsistent bitmaps which
are not loaded, because we do not load their data anyway.

- subsequent bm_list loads do not need to check these constraints
because the bitmaps are already in memory and we will not be using the
size-related metadata.

I think you are correct, but it feels a little "clever" or "tricky" and
it warrants good documentation. I'll audit the codepaths to make sure
this is a safe approach.

(Though, even given that, I *still* want to flush bitmaps to disk on
resize, just to avoid having out of date metadata on the disk -- even if
we're not clearing the IN_USE bit on flush, it still seems "less wrong"
to have correct headers.)


To the point about resize failures:

I think we do have a problem, because no matter what order we choose, we
have a race condition:

- flush bitmaps before resize: If we crash after the flush but before
the resize, the image may be unopenable
- resize before flush (this patch): If we crash before the flush, the
image may be unopenable

So I'll have to address that: we might not be able to avoid losing the
bitmaps during resize (because of a rare failure event) but we need to
make sure the image remains openable.

We may want to amend bitmap loading so that it never FAILS because of
bad constraints, but merely marks the image as corrupt/inconsistent.
Some size issues may be recoverable but others may be "fatal" in the
sense of needing to lose the bitmap.

I'll respin, but I believe this patch series is absolutely crucial for
4.0... We've got until Tuesday!

--js
