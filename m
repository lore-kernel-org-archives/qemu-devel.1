Received: from eggs.gnu.org ([2001:4830:134:3::10]:41103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cYauc-0000tf-6U
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:04:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cYauX-0004yl-9d
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:04:06 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:24820 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cYauW-0004yb-Og
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:04:01 -0500
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
	<20170123121036.4823-23-vsementsov@virtuozzo.com>
	<b24dd2ce-2472-d170-2d09-dbe2bf85edd8@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <aaf5add3-f612-b504-5589-442ec432366f@virtuozzo.com>
Date: Tue, 31 Jan 2017 19:03:44 +0300
MIME-Version: 1.0
In-Reply-To: <b24dd2ce-2472-d170-2d09-dbe2bf85edd8@redhat.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 22/24] block/dirty-bitmap: deep release
 dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

29.01.2017 19:54, Max Reitz wrote:
> On 23.01.2017 13:10, Vladimir Sementsov-Ogievskiy wrote:
>> Remove persistent bitmap from its storage on bdrv_release_dirty_bitmap.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/dirty-bitmap.c      | 21 ++++++++++++++++++---
>>   include/block/block_int.h |  3 +++
>>   2 files changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>> index 775181c9ab..0977df6309 100644
>> --- a/block/dirty-bitmap.c
>> +++ b/block/dirty-bitmap.c
>> @@ -297,7 +297,8 @@ void bdrv_dirty_bitmap_truncate(BlockDriverState *bs)
>>   
>>   static void bdrv_do_release_matching_dirty_bitmap(BlockDriverState *bs,
>>                                                     BdrvDirtyBitmap *bitmap,
>> -                                                  bool only_named)
>> +                                                  bool only_named,
>> +                                                  bool deep)
> I'd rather call it "remove_persistent" or something, which is bad
> grammar, but it's better at getting the point across.
>
>>   {
>>       BdrvDirtyBitmap *bm, *next;
>>       QLIST_FOREACH_SAFE(bm, &bs->dirty_bitmaps, list, next) {
>> @@ -305,6 +306,19 @@ static void bdrv_do_release_matching_dirty_bitmap(BlockDriverState *bs,
>>               assert(!bm->active_iterators);
>>               assert(!bdrv_dirty_bitmap_frozen(bm));
>>               assert(!bm->meta);
>> +
>> +            if (deep && bm->persistent && bs->drv &&
>> +                bs->drv->bdrv_remove_persistent_dirty_bitmap)
>> +            {
>> +                Error *local_err = NULL;
>> +                bs->drv->bdrv_remove_persistent_dirty_bitmap(bs, bm->name,
>> +                                                             &local_err);
>> +                if (local_err != NULL) {
>> +                    error_report_err(local_err);
> This looks like maybe it's the wrong thing to do... I do agree that
> sometimes it may not be fatal, but sometimes it probably is.
>
>> +                }
>> +            }
>> +
>> +
>>               QLIST_REMOVE(bm, list);
>>               hbitmap_free(bm->bitmap);
>>               g_free(bm->name);
>> @@ -322,16 +336,17 @@ static void bdrv_do_release_matching_dirty_bitmap(BlockDriverState *bs,
>>   
>>   void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap)
>>   {
>> -    bdrv_do_release_matching_dirty_bitmap(bs, bitmap, false);
>> +    bdrv_do_release_matching_dirty_bitmap(bs, bitmap, false, true);
> The @deep parameter (or however you decide to call it) should be
> available to this function's caller, too. I don't believe qcow2's
> load_bitmap() wants to delete the persistent bitmap in the error path;
> and block-dirty-bitmap-remove should probably allow the user to decide
> what to do.
>
> Which brings me to the error thing above: If the user (or management
> tool) decides that block-dirty-bitmap-remove should remove the
> persistent bitmap, I believe that the operation should be aborted if the
> persistent bitmap cannot be removed. It should not just go on and
> release the in-memory bitmap but abort altogether. If the user just
> wants to release that in-memory bitmap then, they can still go on an
> call block-dirty-bitmap-remove with deep=false.

I've started to rewrite it in that way and it seems like deep almost 
always will be false. What about just move call to
bs->drv->bdrv_remove_persistent_dirty_bitmap() directly to 
qmp_block_dirty_bitmap_remove and add parameter
'remove_persistent' (or 'remove_from_storage', to make it maximum 
descriptive) only to this qmp command?

Or even without that parameter, as leaving inconsistent version of 
bitmap in the storage doesn't seem useful.

>
>>   }
>>   
>>   /**
>>    * Release all named dirty bitmaps attached to a BDS (for use in bdrv_close()).
>>    * There must not be any frozen bitmaps attached.
>> + * This function do not remove persistent bitmaps from the storage.
> *does
>
> Max
>
>>    */
>>   void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs)
>>   {
>> -    bdrv_do_release_matching_dirty_bitmap(bs, NULL, true);
>> +    bdrv_do_release_matching_dirty_bitmap(bs, NULL, true, false);
>>   }
>>   
>>   void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index b38b3aa198..3e080d6d68 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -326,6 +326,9 @@ struct BlockDriver {
>>                                                   Error **errp);
>>       bool (*bdrv_can_store_new_dirty_bitmap)(BlockDriverState *bs, const char *name,
>>                                               uint32_t granularity, Error **errp);
>> +    void (*bdrv_remove_persistent_dirty_bitmap)(BlockDriverState *bs,
>> +                                                const char *name,
>> +                                                Error **errp);
>>   
>>       QLIST_ENTRY(BlockDriver) list;
>>   };
>>
>


-- 
Best regards,
Vladimir
