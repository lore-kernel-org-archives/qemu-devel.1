Received: from eggs.gnu.org ([2001:4830:134:3::10]:44951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dDpAC-0006mv-MC
	for qemu-devel@nongnu.org; Thu, 25 May 2017 05:34:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dDpA9-0007Bm-Gj
	for qemu-devel@nongnu.org; Thu, 25 May 2017 05:34:36 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:48120 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dDpA9-0007Bc-5L
	for qemu-devel@nongnu.org; Thu, 25 May 2017 05:34:33 -0400
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
	<20170503122539.282182-10-vsementsov@virtuozzo.com>
	<4b694da7-4fa8-24dc-6808-a47cbf985d82@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <3b6c6e1d-7b20-b039-9a77-156313e961af@virtuozzo.com>
Date: Thu, 25 May 2017 12:34:08 +0300
MIME-Version: 1.0
In-Reply-To: <4b694da7-4fa8-24dc-6808-a47cbf985d82@redhat.com>
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

20.05.2017 02:02, John Snow wrote:
>
> On 05/03/2017 08:25 AM, Vladimir Sementsov-Ogievskiy wrote:
>> It will be needed in following commits for persistent bitmaps.
>> If bitmap is loaded from read-only storage (and we can't mark it
>> "in use" in this storage) corresponding BdrvDirtyBitmap should be
>> read-only.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/dirty-bitmap.c         | 16 ++++++++++++++++
>>   include/block/dirty-bitmap.h |  3 +++
>>   2 files changed, 19 insertions(+)
>>
>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>> index 90af37287f..ab6a95cf41 100644
>> --- a/block/dirty-bitmap.c
>> +++ b/block/dirty-bitmap.c
>> @@ -44,6 +44,8 @@ struct BdrvDirtyBitmap {
>>       int64_t size;               /* Size of the bitmap (Number of sectors) */
>>       bool disabled;              /* Bitmap is read-only */
>>       int active_iterators;       /* How many iterators are active */
>> +    bool readonly;              /* Bitmap is read-only and may be changed only
>> +                                   by deserialize* functions */
>>       QLIST_ENTRY(BdrvDirtyBitmap) list;
>>   };
>>   
>> @@ -436,6 +438,7 @@ void bdrv_set_dirty_bitmap(BdrvDirtyBitmap *bitmap,
>>                              int64_t cur_sector, int64_t nr_sectors)
>>   {
>>       assert(bdrv_dirty_bitmap_enabled(bitmap));
>> +    assert(!bdrv_dirty_bitmap_readonly(bitmap));
> Doesn't this change the nature of the assertion?
>
> We're going from
>      return !(bitmap->disabled || bitmap->successor);
> to
> 	!bitmap->readonly
>
> That makes me a little nervous to ACK this patch, because the
> correctness depends on how readonly is updated and manipulated in the
> future, which makes it more prone to error.

Sorry for late answer, I was ill.

Hmm, old assert is still here. I just add another one. Readonly means: 
bitmap must not be changed by _get _set and _clear at all - from loading 
up to releasing. It is needed to maintain the case: "bitmap was loaded 
from read-only storage, so that it was not marked as 'in_use' in that 
storge". 'disabled' field is not appropriate because it is managed by user.

>
>>       hbitmap_set(bitmap->bitmap, cur_sector, nr_sectors);
>>   }
>>   
>> @@ -443,12 +446,14 @@ void bdrv_reset_dirty_bitmap(BdrvDirtyBitmap *bitmap,
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
>> @@ -519,6 +524,7 @@ void bdrv_set_dirty(BlockDriverState *bs, int64_t cur_sector,
>>           if (!bdrv_dirty_bitmap_enabled(bitmap)) {
>>               continue;
>>           }
>> +        assert(!bdrv_dirty_bitmap_readonly(bitmap));
>>           hbitmap_set(bitmap->bitmap, cur_sector, nr_sectors);
>>       }
>>   }
>> @@ -540,3 +546,13 @@ int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap)
>>   {
>>       return hbitmap_count(bitmap->meta);
>>   }
>> +
>> +bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap)
>> +{
>> +    return bitmap->readonly;
>> +}
>> +
>> +void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap)
>> +{
>> +    bitmap->readonly = true;
>> +}
>> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
>> index 1e17729ac2..0aab5841f5 100644
>> --- a/include/block/dirty-bitmap.h
>> +++ b/include/block/dirty-bitmap.h
>> @@ -75,4 +75,7 @@ void bdrv_dirty_bitmap_deserialize_ones(BdrvDirtyBitmap *bitmap,
>>                                           bool finish);
>>   void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap);
>>   
>> +bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap);
>> +void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap);
>> +
>>   #endif
>>

-- 
Best regards,
Vladimir
