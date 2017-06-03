Received: from eggs.gnu.org ([2001:4830:134:3::10]:35323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dHCiy-00042I-1V
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 13:20:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dHCiu-0007Po-0A
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 13:20:28 -0400
References: <20170602112158.232757-1-vsementsov@virtuozzo.com>
	<20170602112158.232757-11-vsementsov@virtuozzo.com>
	<ccd143a1-e6dd-a08c-5747-cd46bbbf0429@redhat.com>
From: Sementsov-Ogievskiy Vladimir <vsementsov@virtuozzo.com>
Message-ID: <404eb3a5-4700-8e0e-dbe2-99ef4783b766@virtuozzo.com>
Date: Sat, 3 Jun 2017 20:19:52 +0300
MIME-Version: 1.0
In-Reply-To: <ccd143a1-e6dd-a08c-5747-cd46bbbf0429@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v20 10/30] block/dirty-bitmap: add readonly
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



On 03.06.2017 00:02, John Snow wrote:
>
> On 06/02/2017 07:21 AM, Vladimir Sementsov-Ogievskiy wrote:
>> It will be needed in following commits for persistent bitmaps.
>> If bitmap is loaded from read-only storage (and we can't mark it
>> "in use" in this storage) corresponding BdrvDirtyBitmap should be
>> read-only.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/dirty-bitmap.c         | 32 ++++++++++++++++++++++++++++++++
>>   block/io.c                   |  8 ++++++++
>>   blockdev.c                   |  6 ++++++
>>   include/block/dirty-bitmap.h |  4 ++++
>>   4 files changed, 50 insertions(+)
>>
>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>> index f25428868c..1c9ffb292a 100644
>> --- a/block/dirty-bitmap.c
>> +++ b/block/dirty-bitmap.c
>> @@ -45,6 +45,12 @@ struct BdrvDirtyBitmap {
>>       bool disabled;              /* Bitmap is disabled. It skips all writes to
>>                                      the device */
>>       int active_iterators;       /* How many iterators are active */
>> +    bool readonly;              /* Bitmap is read-only and may be changed only
>> +                                   by deserialize* functions. This field blocks
> In what way do the deserialize functions change the bitmaps, again?

Hmm, I mean loading bitmap from file, but actually, bitmap is set 
readonly after loading, so this sentence half can be dropped and asserts 
added to deserialize* functions too (however, deserialize should never 
be applied to the bitmap already loaded, or created from qmp, 
deserialize should be used with newly created bitmap, by the code like 
bitmap-loading or bitmap-incoming-migration, so such asserts may be a 
bit strange)

>
>> +                                   any changing operations on owning image
>> +                                   (writes and discards), if bitmap is readonly
>> +                                   such operations must fail and not change
>> +                                   image or this bitmap */
>>       QLIST_ENTRY(BdrvDirtyBitmap) list;
>>   };
>>   
>> @@ -437,6 +443,7 @@ void bdrv_set_dirty_bitmap(BdrvDirtyBitmap *bitmap,
>>                              int64_t cur_sector, int64_t nr_sectors)
>>   {
>>       assert(bdrv_dirty_bitmap_enabled(bitmap));
>> +    assert(!bdrv_dirty_bitmap_readonly(bitmap));
> I still feel as if bdrv_dirty_bitmap_enabled() can return false if
> bdrv_dirty_bitmap_readonly is true, and you wouldn't have to edit these
> parts, but I don't care enough to press the issue.
>
>>       hbitmap_set(bitmap->bitmap, cur_sector, nr_sectors);
>>   }
>>   
>> @@ -444,12 +451,14 @@ void bdrv_reset_dirty_bitmap(BdrvDirtyBitmap *bitmap,
>>                                int64_t cur_sector, int64_t nr_sectors)
>>   {
>>       assert(bdrv_dirty_bitmap_enabled(bitmap));
>> +    assert(!bdrv_dirty_bitmap_readonly(bitmap));
>>       hbitmap_reset(bitmap->bitmap, cur_sector, nr_sectors);
>>   }
>>   
>>   void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out)
>>   {
>>       assert(bdrv_dirty_bitmap_enabled(bitmap));
>> +    assert(!bdrv_dirty_bitmap_readonly(bitmap));
>>       if (!out) {
>>           hbitmap_reset_all(bitmap->bitmap);
>>       } else {
>> @@ -520,6 +529,7 @@ void bdrv_set_dirty(BlockDriverState *bs, int64_t cur_sector,
>>           if (!bdrv_dirty_bitmap_enabled(bitmap)) {
>>               continue;
>>           }
>> +        assert(!bdrv_dirty_bitmap_readonly(bitmap));
> Highlighting the difference in strictness between "disabled" and "readonly."

this case also show that we cant include !readonly-check into 
bdrv_dirty_bitmap_enabled()

>
>>           hbitmap_set(bitmap->bitmap, cur_sector, nr_sectors);
>>       }
>>   }
>> @@ -541,3 +551,25 @@ int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap)
>>   {
>>       return hbitmap_count(bitmap->meta);
>>   }
>> +
>> +bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap)
>> +{
>> +    return bitmap->readonly;
>> +}
>> +
>> +void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap, bool value)
>> +{
>> +    bitmap->readonly = value;
>> +}
>> +
>> +bool bdrv_has_readonly_bitmaps(BlockDriverState *bs)
>> +{
>> +    BdrvDirtyBitmap *bm;
>> +    QLIST_FOREACH(bm, &bs->dirty_bitmaps, list) {
>> +        if (bm->readonly) {
>> +            return true;
>> +        }
>> +    }
>> +
>> +    return false;
>> +}
>> diff --git a/block/io.c b/block/io.c
>> index fdd7485c22..0e28a1f595 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -1349,6 +1349,10 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
>>       uint64_t bytes_remaining = bytes;
>>       int max_transfer;
>>   
>> +    if (bdrv_has_readonly_bitmaps(bs)) {
>> +        return -EPERM;
>> +    }
>> +
> Should this be a dynamic error, or an assertion? We should probably
> endeavor to never actually hit this circumstance (we should not have
> readonly bitmaps on a RW node.)

if on reopening rw write of 'in_use=1' flag failed, we are stay with 
readonly bitmaps in rw image. So this is possible.

two notes:
1. we can't fail bdrv_reopen_commit if we failed writing 'in_use=1' flag 
into image
2. may be this is not bad: user can remove bitmaps to unblock write, or 
he can retry operation leading to reopening rw which should lead to 
retrying of writing 'in_use=1' into the image.

>
>>       assert(is_power_of_2(align));
>>       assert((offset & (align - 1)) == 0);
>>       assert((bytes & (align - 1)) == 0);
>> @@ -2437,6 +2441,10 @@ int coroutine_fn bdrv_co_pdiscard(BlockDriverState *bs, int64_t offset,
>>           return -ENOMEDIUM;
>>       }
>>   
>> +    if (bdrv_has_readonly_bitmaps(bs)) {
>> +        return -EPERM;
>> +    }
>> +
>>       ret = bdrv_check_byte_request(bs, offset, count);
>>       if (ret < 0) {
>>           return ret;
>> diff --git a/blockdev.c b/blockdev.c
>> index c63f4e82c7..2b397abf66 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -2033,6 +2033,9 @@ static void block_dirty_bitmap_clear_prepare(BlkActionState *common,
>>       } else if (!bdrv_dirty_bitmap_enabled(state->bitmap)) {
>>           error_setg(errp, "Cannot clear a disabled bitmap");
>>           return;
>> +    } else if (bdrv_dirty_bitmap_readonly(state->bitmap)) {
>> +        error_setg(errp, "Cannot clear a readonly bitmap");
>> +        return;
>>       }
> Probably getting close to easier to specify what state we DO allow
> bitmaps to be cleared in (enabled/active, not frozen, disabled or readonly.)

and should we add "readonly" state to qapi? (see my comment on v19)

>
>>   
>>       bdrv_clear_dirty_bitmap(state->bitmap, &state->backup);
>> @@ -2813,6 +2816,9 @@ void qmp_block_dirty_bitmap_clear(const char *node, const char *name,
>>                      "Bitmap '%s' is currently disabled and cannot be cleared",
>>                      name);
>>           goto out;
>> +    } else if (bdrv_dirty_bitmap_readonly(bitmap)) {
>> +        error_setg(errp, "Bitmap '%s' is readonly and cannot be cleared", name);
>> +        goto out;
>>       }
> Random thought, maybe qmp_block_dirty_bitmap_clear should utilize the
> transactional action core to perform this action instead of
> reimplementing it. This has nothing to do with you, though.
>
>>   
>>       bdrv_clear_dirty_bitmap(bitmap, NULL);
>> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
>> index 1e17729ac2..aa6d47ee00 100644
>> --- a/include/block/dirty-bitmap.h
>> +++ b/include/block/dirty-bitmap.h
>> @@ -75,4 +75,8 @@ void bdrv_dirty_bitmap_deserialize_ones(BdrvDirtyBitmap *bitmap,
>>                                           bool finish);
>>   void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap);
>>   
>> +bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap);
>> +void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap, bool value);
>> +bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
>> +
>>   #endif
>>
> Reviewed-by: John Snow <jsnow@redhat.com>

-- 
Best regards,
Vladimir.
