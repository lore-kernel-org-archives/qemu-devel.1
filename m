Received: from eggs.gnu.org ([2001:4830:134:3::10]:33218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eFFxz-0002jq-JX
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 03:56:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eFFxw-0007E9-HC
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 03:56:11 -0500
References: <20171030163309.75770-1-vsementsov@virtuozzo.com>
	<20171030163309.75770-3-vsementsov@virtuozzo.com>
	<5027d8bb-fdec-a6ce-8150-96730d3a5ce4@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <6299c687-9c73-f498-524c-e70709ca8a3b@virtuozzo.com>
Date: Thu, 16 Nov 2017 11:56:01 +0300
MIME-Version: 1.0
In-Reply-To: <5027d8bb-fdec-a6ce-8150-96730d3a5ce4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v8 02/14] block/dirty-bitmap: add locked
 version of bdrv_release_dirty_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, famz@redhat.com, lirans@il.ibm.com, quintela@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, amit.shah@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com

11.11.2017 01:52, John Snow wrote:
>
> On 10/30/2017 12:32 PM, Vladimir Sementsov-Ogievskiy wrote:
>> It is needed to realize bdrv_dirty_bitmap_release_successor in
>> the following patch.
>>
> OK, but...
>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/dirty-bitmap.c | 25 ++++++++++++++++++++-----
>>   1 file changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>> index 81adbeb6d4..981f99d362 100644
>> --- a/block/dirty-bitmap.c
>> +++ b/block/dirty-bitmap.c
>> @@ -326,13 +326,13 @@ static bool bdrv_dirty_bitmap_has_name(BdrvDirtyBitmap *bitmap)
>>       return !!bdrv_dirty_bitmap_name(bitmap);
>>   }
>>   
>> -/* Called with BQL taken.  */
>> -static void bdrv_do_release_matching_dirty_bitmap(
>> +/* Called within bdrv_dirty_bitmap_lock..unlock */
> ...Add this so it will compile:
>
> __attribute__((__unused__))

ok

>> +static void bdrv_do_release_matching_dirty_bitmap_locked(
>>       BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
>>       bool (*cond)(BdrvDirtyBitmap *bitmap))
>>   {
>>       BdrvDirtyBitmap *bm, *next;
>> -    bdrv_dirty_bitmaps_lock(bs);
>> +
>>       QLIST_FOREACH_SAFE(bm, &bs->dirty_bitmaps, list, next) {
>>           if ((!bitmap || bm == bitmap) && (!cond || cond(bm))) {
>>               assert(!bm->active_iterators);
>> @@ -344,18 +344,33 @@ static void bdrv_do_release_matching_dirty_bitmap(
>>               g_free(bm);
>>   
>>               if (bitmap) {
>> -                goto out;
>> +                return;
>>               }
>>           }
>>       }
>> +
>>       if (bitmap) {
>>           abort();
>>       }
> Do we have any style guide rules on using abort() instead of assert()?
> The rest of this function uses assert, and it'd be less lines to simply
> write:
>
> assert(!bitmap);
>
> which I think might also carry better semantic information for coverity
> beyond an actual runtime conditional branch.
>
> (I think. Please correct me if I am wrong, I'm a little hazy on this.)

agree, but it is a preexisting code, so I'll fix it with an additional 
patch.

>
>> +}
>>   
>> -out:
>> +/* Called with BQL taken.  */
>> +static void bdrv_do_release_matching_dirty_bitmap(
>> +    BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
>> +    bool (*cond)(BdrvDirtyBitmap *bitmap))
>> +{
>> +    bdrv_dirty_bitmaps_lock(bs);
>> +    bdrv_do_release_matching_dirty_bitmap_locked(bs, bitmap, cond);
>>       bdrv_dirty_bitmaps_unlock(bs);
>>   }
>>   
>> +/* Called within bdrv_dirty_bitmap_lock..unlock */
>> +static void bdrv_release_dirty_bitmap_locked(BlockDriverState *bs,
>> +                                             BdrvDirtyBitmap *bitmap)
>> +{
>> +    bdrv_do_release_matching_dirty_bitmap_locked(bs, bitmap, NULL);
>> +}
>> +
>>   /* Called with BQL taken.  */
>>   void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap)
>>   {
>>
> If you agree with those two changes, you may add:

ok

>
> Reviewed-by: John Snow <jsnow@redhat.com>


-- 
Best regards,
Vladimir
