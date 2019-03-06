Received: from eggs.gnu.org ([209.51.188.92]:54505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h1YGt-0003Wj-Sf
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 10:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h1YGr-0004QI-T0
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 10:15:51 -0500
References: <20190301191545.8728-1-jsnow@redhat.com>
	<20190301191545.8728-2-jsnow@redhat.com>
	<82ec6790-f366-3912-e85b-4908647d5c8d@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <a2d33717-48f8-2133-021e-48e34b3b0871@redhat.com>
Date: Wed, 6 Mar 2019 10:15:42 -0500
MIME-Version: 1.0
In-Reply-To: <82ec6790-f366-3912-e85b-4908647d5c8d@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/7] block/dirty-bitmaps: add
 inconsistent bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>



On 3/6/19 7:25 AM, Vladimir Sementsov-Ogievskiy wrote:
> 01.03.2019 22:15, John Snow wrote:
>> Add an inconsistent bit to dirty-bitmaps that allows us to report a bitmap as
>> persistent but potentially inconsistent, i.e. if we find bitmaps on a qcow2
>> that have been marked as "in use".
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   qapi/block-core.json         | 13 +++++++++----
>>   include/block/dirty-bitmap.h |  2 ++
>>   block/dirty-bitmap.c         | 19 +++++++++++++++++++
>>   3 files changed, 30 insertions(+), 4 deletions(-)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 6e543594b3..e639ef6d1c 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -467,15 +467,20 @@
>>   #        and cannot be modified via QMP or used by another operation.
>>   #        Replaces `locked` and `frozen` statuses. (since 4.0)
>>   #
>> -# @persistent: true if the bitmap will eventually be flushed to persistent
>> -#              storage (since 4.0)
>> +# @persistent: true if the bitmap was stored on disk, is scheduled to be stored
>> +#              on disk, or both. (since 4.0)
>> +#
>> +# @inconsistent: true if this is a persistent bitmap that was improperly
>> +#                stored. Implies @persistent to be true; @recording and
>> +#                @busy to be false. This bitmap cannot be used. To remove
>> +#                it, use @block-dirty-bitmap-remove. (Since 4.0)
>>   #
>>   # Since: 1.3
>>   ##
>>   { 'struct': 'BlockDirtyInfo',
>>     'data': {'*name': 'str', 'count': 'int', 'granularity': 'uint32',
>> -           'recording': 'bool', 'busy': 'bool',
>> -           'status': 'DirtyBitmapStatus', 'persistent': 'bool' } }
>> +           'recording': 'bool', 'busy': 'bool', 'status': 'DirtyBitmapStatus',
>> +           'persistent': 'bool', '*inconsistent': 'bool' } }
>>   
>>   ##
>>   # @Qcow2BitmapInfoFlags:
>> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
>> index ba8477b73f..bd1b6479df 100644
>> --- a/include/block/dirty-bitmap.h
>> +++ b/include/block/dirty-bitmap.h
>> @@ -68,6 +68,7 @@ void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap);
>>   void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap, bool value);
>>   void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap,
>>                                          bool persistent);
>> +void bdrv_dirty_bitmap_set_inconsistent(BdrvDirtyBitmap *bitmap);
>>   void bdrv_dirty_bitmap_set_busy(BdrvDirtyBitmap *bitmap, bool busy);
>>   void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
>>                                HBitmap **backup, Error **errp);
>> @@ -91,6 +92,7 @@ bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap);
>>   bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
>>   bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap);
>>   bool bdrv_dirty_bitmap_get_persistance(BdrvDirtyBitmap *bitmap);
>> +bool bdrv_dirty_bitmap_inconsistent(const BdrvDirtyBitmap *bitmap);
>>   bool bdrv_dirty_bitmap_busy(BdrvDirtyBitmap *bitmap);
>>   bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs);
>>   BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>> index 980cae4fa3..9e8630e1ac 100644
>> --- a/block/dirty-bitmap.c
>> +++ b/block/dirty-bitmap.c
>> @@ -46,6 +46,9 @@ struct BdrvDirtyBitmap {
>>                                      and this bitmap must remain unchanged while
>>                                      this flag is set. */
>>       bool persistent;            /* bitmap must be saved to owner disk image */
>> +    bool inconsistent;          /* bitmap is persistent, but inconsistent.
>> +                                 * It cannot be used at all in any way, except
>> +                                 * a QMP user can remove it. */
>>       bool migration;             /* Bitmap is selected for migration, it should
>>                                      not be stored on the next inactivation
>>                                      (persistent flag doesn't matter until next
>> @@ -464,6 +467,8 @@ BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs)
>>           info->recording = bdrv_dirty_bitmap_recording(bm);
>>           info->busy = bdrv_dirty_bitmap_busy(bm);
>>           info->persistent = bm->persistent;
>> +        info->has_inconsistent = bm->inconsistent;
>> +        info->inconsistent = bm->inconsistent;
>>           entry->value = info;
>>           *plist = entry;
>>           plist = &entry->next;
>> @@ -711,6 +716,15 @@ void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap, bool persistent)
>>       qemu_mutex_unlock(bitmap->mutex);
>>   }
>>   
>> +/* Called with BQL taken. */
>> +void bdrv_dirty_bitmap_set_inconsistent(BdrvDirtyBitmap *bitmap)
>> +{
>> +    qemu_mutex_lock(bitmap->mutex);
>> +    bitmap->inconsistent = true;
>> +    bitmap->disabled = true;
> 
> Agree, that it worth to assert persistance
> 

OK, I will do so.

>> +    qemu_mutex_unlock(bitmap->mutex);
>> +}
>> +
>>   /* Called with BQL taken. */
>>   void bdrv_dirty_bitmap_set_migration(BdrvDirtyBitmap *bitmap, bool migration)
>>   {
>> @@ -724,6 +738,11 @@ bool bdrv_dirty_bitmap_get_persistance(BdrvDirtyBitmap *bitmap)
>>       return bitmap->persistent && !bitmap->migration;
>>   }
>>   
>> +bool bdrv_dirty_bitmap_inconsistent(const BdrvDirtyBitmap *bitmap)
>> +{
>> +    return bitmap->inconsistent;
>> +}
>> +
>>   bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs)
>>   {
>>       BdrvDirtyBitmap *bm;
>>
> 
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> Sorry for a delay, I'm very busy with our rebase to 2.12 :(
> 

I am very genuinely the last person you would ever have to apologize for
in being late. I'm only waiting for your reviews because you have
contributed so much to this feature and I want to make sure I don't
check in anything that you haven't had a chance to critique.

Thanks for the reviews!
