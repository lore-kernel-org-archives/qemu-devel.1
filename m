Received: from eggs.gnu.org ([2001:4830:134:3::10]:40339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dGiSZ-0001YC-3s
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 05:01:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dGiSU-0001rg-KD
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 05:01:31 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:5887 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dGiSU-0001q4-3y
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 05:01:26 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20170530081723.29205-1-vsementsov@virtuozzo.com>
	<20170530081723.29205-10-vsementsov@virtuozzo.com>
	<04df6354-c902-9514-f56f-9063168a6a75@redhat.com>
	<72e09ee4-ef22-ed79-b881-bed1ad255392@virtuozzo.com>
	<c232fd02-524c-29c4-6577-37101a2638e5@redhat.com>
	<d587d556-4807-46ff-3596-4c1c99edbcef@virtuozzo.com>
Message-ID: <b5d84158-b1f9-d497-3231-be76565cb3b3@virtuozzo.com>
Date: Fri, 2 Jun 2017 12:01:07 +0300
MIME-Version: 1.0
In-Reply-To: <d587d556-4807-46ff-3596-4c1c99edbcef@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 09/25] block/dirty-bitmap: add readonly
 field to BdrvDirtyBitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org

02.06.2017 11:56, Vladimir Sementsov-Ogievskiy wrote:
> 02.06.2017 02:25, John Snow wrote:
>>
>> On 06/01/2017 03:30 AM, Sementsov-Ogievskiy Vladimir wrote:
>>> Hi John!
>>>
>>> Look at our discussion about this in v18 thread.
>>>> Shortly: readonly is not the same as disabled. disabled= bitmap just
>>> ignores all writes. readonly= writes are not allowed at all.
>>>
>>> And I think, I'll try to go through way 2: "dirty" field instead of
>>> "readonly" (look at v18 discussion), as it a bit more flexible.
>>>
>> Not sure which I prefer...
>>
>> Method 1 is attractive in that it is fairly simple, and enforces fairly
>> loudly the inability to write to devices with RO bitmaps. It's a natural
>> extension of your current approach.
>
> For now I decided to realize this one, I think I'll publish it today. 
> Also, I'm going to rename s/readonly/in_use - to avoid the confuse 
> with disabled. So let this field just be mirror of IN_USE in the image 
> and just say "persistent storage knows, that bitmap is in use and may 
> be dirty".
>
> Also, optimization with 'dirty' flag may be added later.

And, also, I don't want to influence this "first write", on which we 
will set "IN_USE" in all bitmaps (for way (2). Reopening rw is less 
performance-demanding place than write.


>
>>
>> Method 2 is attractive in that it seems a little more efficient, and is
>> a little more clever. A dirty flag lets us avoid flushing bitmaps we
>> never even changed (though we still need to clean up the in_use flags.)
>>
>> What I wonder about #2 is what happens when a write sneaks in (due to a
>> bug or a use case we didn't see) on a bitmap attached to a read-only
>> node. We fail later on invalidate? It shouldn't happen in normal
>> circumstances, but I worry that the failure mode is messier.
>
> if bitmap is dirty - all ok, the problems will appear when we'll try 
> to save it, but these problems are not fatal - bitmap should be marked 
> 'in_use' in the image, so it will be lost (the worst case is when 
> in_use not set and bitmap is incorrect - it may lead to data loss for 
> user)
>
> if it is not dirty - we will fail to write 'in_use' before actual 
> write and the whole write will fail.
>
>>
>>
>> Well, either way I will be happy for now I think -- pick whichever
>> option feels easiest or best for you to implement.
>>
>> Thanks!
>>
>>> On 01.06.2017 02:48, John Snow wrote:
>>>> On 05/30/2017 04:17 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>>> It will be needed in following commits for persistent bitmaps.
>>>>> If bitmap is loaded from read-only storage (and we can't mark it
>>>>> "in use" in this storage) corresponding BdrvDirtyBitmap should be
>>>>> read-only.
>>>>>
>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy 
>>>>> <vsementsov@virtuozzo.com>
>>>>> ---
>>>>>    block/dirty-bitmap.c         | 28 ++++++++++++++++++++++++++++
>>>>>    block/io.c                   |  8 ++++++++
>>>>>    blockdev.c                   |  6 ++++++
>>>>>    include/block/dirty-bitmap.h |  4 ++++
>>>>>    4 files changed, 46 insertions(+)
>>>>>
>>>>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>>>>> index 90af37287f..733f19ca5e 100644
>>>>> --- a/block/dirty-bitmap.c
>>>>> +++ b/block/dirty-bitmap.c
>>>>> @@ -44,6 +44,8 @@ struct BdrvDirtyBitmap {
>>>>>        int64_t size;               /* Size of the bitmap (Number of
>>>>> sectors) */
>>>>>        bool disabled;              /* Bitmap is read-only */
>>>>>        int active_iterators;       /* How many iterators are 
>>>>> active */
>>>>> +    bool readonly;              /* Bitmap is read-only and may be
>>>>> changed only
>>>>> +                                   by deserialize* functions */
>>>>>        QLIST_ENTRY(BdrvDirtyBitmap) list;
>>>>>    };
>>>>>    @@ -436,6 +438,7 @@ void bdrv_set_dirty_bitmap(BdrvDirtyBitmap
>>>>> *bitmap,
>>>>>                               int64_t cur_sector, int64_t nr_sectors)
>>>>>    {
>>>>>        assert(bdrv_dirty_bitmap_enabled(bitmap));
>>>>> +    assert(!bdrv_dirty_bitmap_readonly(bitmap));
>>>> Not reasonable to add the condition for !readonly into
>>>> bdrv_dirty_bitmap_enabled?
>>>>
>>>> As is:
>>>>
>>>> If readonly is set to true on a bitmap, bdrv_dirty_bitmap_status is
>>>> going to return ACTIVE for such bitmaps, but DISABLED might be more
>>>> appropriate to indicate the read-only nature.
>>>>
>>>> If you add this condition into _enabled(), you can skip the extra
>>>> assertions you've added here.
>>>>
>>>>> hbitmap_set(bitmap->bitmap, cur_sector, nr_sectors);
>>>>>    }
>>>>>    @@ -443,12 +446,14 @@ void bdrv_reset_dirty_bitmap(BdrvDirtyBitmap
>>>>> *bitmap,
>>>>>                                 int64_t cur_sector, int64_t 
>>>>> nr_sectors)
>>>>>    {
>>>>>        assert(bdrv_dirty_bitmap_enabled(bitmap));
>>>>> +    assert(!bdrv_dirty_bitmap_readonly(bitmap));
>>>>>        hbitmap_reset(bitmap->bitmap, cur_sector, nr_sectors);
>>>>>    }
>>>>>      void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap 
>>>>> **out)
>>>>>    {
>>>>>        assert(bdrv_dirty_bitmap_enabled(bitmap));
>>>>> +    assert(!bdrv_dirty_bitmap_readonly(bitmap));
>>>>>        if (!out) {
>>>>>            hbitmap_reset_all(bitmap->bitmap);
>>>>>        } else {
>>>>> @@ -519,6 +524,7 @@ void bdrv_set_dirty(BlockDriverState *bs, int64_t
>>>>> cur_sector,
>>>>>            if (!bdrv_dirty_bitmap_enabled(bitmap)) {
>>>>>                continue;
>>>>>            }
>>>>> +        assert(!bdrv_dirty_bitmap_readonly(bitmap));
>>>>>            hbitmap_set(bitmap->bitmap, cur_sector, nr_sectors);
>>>>>        }
>>>>>    }
>>>>> @@ -540,3 +546,25 @@ int64_t
>>>>> bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap)
>>>>>    {
>>>>>        return hbitmap_count(bitmap->meta);
>>>>>    }
>>>>> +
>>>>> +bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap)
>>>>> +{
>>>>> +    return bitmap->readonly;
>>>>> +}
>>>>> +
>>>>> +void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap)
>>>>> +{
>>>>> +    bitmap->readonly = true;
>>>>> +}
>>>>> +
>>>>> +bool bdrv_has_readonly_bitmaps(BlockDriverState *bs)
>>>>> +{
>>>>> +    BdrvDirtyBitmap *bm;
>>>>> +    QLIST_FOREACH(bm, &bs->dirty_bitmaps, list) {
>>>>> +        if (bm->readonly) {
>>>>> +            return true;
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +    return false;
>>>>> +}
>>>>> diff --git a/block/io.c b/block/io.c
>>>>> index fdd7485c22..0e28a1f595 100644
>>>>> --- a/block/io.c
>>>>> +++ b/block/io.c
>>>>> @@ -1349,6 +1349,10 @@ static int coroutine_fn
>>>>> bdrv_aligned_pwritev(BdrvChild *child,
>>>>>        uint64_t bytes_remaining = bytes;
>>>>>        int max_transfer;
>>>>>    +    if (bdrv_has_readonly_bitmaps(bs)) {
>>>>> +        return -EPERM;
>>>>> +    }
>>>>> +
>>>> Oh, hardcore. The original design for "disabled" was just that they
>>>> would become invalid after writes; but in this case a read-only bitmap
>>>> literally enforces the concept.
>>>>
>>>> I can envision usages for both.
>>>>
>>>>>        assert(is_power_of_2(align));
>>>>>        assert((offset & (align - 1)) == 0);
>>>>>        assert((bytes & (align - 1)) == 0);
>>>>> @@ -2437,6 +2441,10 @@ int coroutine_fn
>>>>> bdrv_co_pdiscard(BlockDriverState *bs, int64_t offset,
>>>>>            return -ENOMEDIUM;
>>>>>        }
>>>>>    +    if (bdrv_has_readonly_bitmaps(bs)) {
>>>>> +        return -EPERM;
>>>>> +    }
>>>>> +
>>>>>        ret = bdrv_check_byte_request(bs, offset, count);
>>>>>        if (ret < 0) {
>>>>>            return ret;
>>>>> diff --git a/blockdev.c b/blockdev.c
>>>>> index c63f4e82c7..2b397abf66 100644
>>>>> --- a/blockdev.c
>>>>> +++ b/blockdev.c
>>>>> @@ -2033,6 +2033,9 @@ static void
>>>>> block_dirty_bitmap_clear_prepare(BlkActionState *common,
>>>>>        } else if (!bdrv_dirty_bitmap_enabled(state->bitmap)) {
>>>>>            error_setg(errp, "Cannot clear a disabled bitmap");
>>>>>            return;
>>>>> +    } else if (bdrv_dirty_bitmap_readonly(state->bitmap)) {
>>>>> +        error_setg(errp, "Cannot clear a readonly bitmap");
>>>>> +        return;
>>>>>        }
>>>> Oh, I see -- perhaps you wanted a better error message? That makes 
>>>> sense
>>>> to me....
>>>>
>>>>
>>>> ...Though, you know, bdrv_disable_dirty_bitmap accomplishes something
>>>> pretty similar here: we take the bitmap out of active RW state and put
>>>> it into RO mode, it's just done under the name enabled/disabled 
>>>> instead
>>>> of RO.
>>>>
>>>> As of this patch, nothing uses it yet. Is this patch necessary? Would
>>>> setting a bitmap as "disabled" to mean "RO" be sufficient, or are the
>>>> two flags truly semantically necessary?
>>>>
>>>>> bdrv_clear_dirty_bitmap(state->bitmap, &state->backup);
>>>>> @@ -2813,6 +2816,9 @@ void qmp_block_dirty_bitmap_clear(const char
>>>>> *node, const char *name,
>>>>>                       "Bitmap '%s' is currently disabled and 
>>>>> cannot be
>>>>> cleared",
>>>>>                       name);
>>>>>            goto out;
>>>>> +    } else if (bdrv_dirty_bitmap_readonly(bitmap)) {
>>>>> +        error_setg(errp, "Bitmap '%s' is readonly and cannot be
>>>>> cleared", name);
>>>>> +        goto out;
>>>>>        }
>>>>>          bdrv_clear_dirty_bitmap(bitmap, NULL);
>>>>> diff --git a/include/block/dirty-bitmap.h 
>>>>> b/include/block/dirty-bitmap.h
>>>>> index 1e17729ac2..c0c3ce9f85 100644
>>>>> --- a/include/block/dirty-bitmap.h
>>>>> +++ b/include/block/dirty-bitmap.h
>>>>> @@ -75,4 +75,8 @@ void
>>>>> bdrv_dirty_bitmap_deserialize_ones(BdrvDirtyBitmap *bitmap,
>>>>>                                            bool finish);
>>>>>    void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap 
>>>>> *bitmap);
>>>>>    +bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap);
>>>>> +void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap);
>>>>> +bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
>>>>> +
>>>>>    #endif
>>>>>
>>>> I realize I am being very bike-sheddy about this, so I might give 
>>>> an r-b
>>>> with a light justification.
>>>>
>>>> --js
>
>

-- 
Best regards,
Vladimir
