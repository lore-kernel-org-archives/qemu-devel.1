Received: from eggs.gnu.org ([2001:4830:134:3::10]:54761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1edY5Y-0000il-Du
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 04:08:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1edY5W-0008CF-OS
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 04:08:24 -0500
References: <20180116125427.18540-1-vsementsov@virtuozzo.com>
	<20180116125427.18540-2-vsementsov@virtuozzo.com>
	<eda97ab4-fd56-5dad-82b3-712dc400e39c@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b9c84982-b243-d3d7-d9e4-49a7d62de7d0@virtuozzo.com>
Date: Mon, 22 Jan 2018 12:08:04 +0300
MIME-Version: 1.0
In-Reply-To: <eda97ab4-fd56-5dad-82b3-712dc400e39c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 1/6] block: maintain persistent disabled
 bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mnestratov@virtuozzo.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, den@openvz.org

20.01.2018 02:43, John Snow wrote:
>
> On 01/16/2018 07:54 AM, Vladimir Sementsov-Ogievskiy wrote:
>> To maintain load/store disabled bitmap there is new approach:
>>
>>   - deprecate @autoload flag of block-dirty-bitmap-add, make it ignored
>>   - store enabled bitmaps as "auto" to qcow2
>>   - store disabled bitmaps without "auto" flag to qcow2
>>   - on qcow2 open load "auto" bitmaps as enabled and others
>>     as disabled (except in_use bitmaps)
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   qapi/block-core.json         |  6 +++---
>>   block/qcow2.h                |  2 +-
>>   include/block/dirty-bitmap.h |  1 -
>>   block/dirty-bitmap.c         | 18 ------------------
>>   block/qcow2-bitmap.c         | 12 +++++++-----
>>   block/qcow2.c                |  2 +-
>>   blockdev.c                   | 10 ++--------
>>   7 files changed, 14 insertions(+), 37 deletions(-)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index ab96e348e6..827254db22 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -1593,9 +1593,9 @@
>>   #              Qcow2 disks support persistent bitmaps. Default is false for
>>   #              block-dirty-bitmap-add. (Since: 2.10)
>>   #
>> -# @autoload: the bitmap will be automatically loaded when the image it is stored
>> -#            in is opened. This flag may only be specified for persistent
>> -#            bitmaps. Default is false for block-dirty-bitmap-add. (Since: 2.10)
>> +# @autoload: ignored and deprecated since 2.12.
>> +#            Currently, all dirty tracking bitmaps are loaded from Qcow2 on
>> +#            open.
> Hmm, so we're going to say that *all* persistent bitmaps are loaded into
> memory, but they may-or-may-not-be enabled, is that the approach we're
> taking now?

yes.

>
>>   #
>>   # Since: 2.4
>>   ##
>> diff --git a/block/qcow2.h b/block/qcow2.h
>> index 782a206ecb..a3e29276fc 100644
>> --- a/block/qcow2.h
>> +++ b/block/qcow2.h
>> @@ -672,7 +672,7 @@ void qcow2_cache_discard(BlockDriverState *bs, Qcow2Cache *c, void *table);
>>   int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
>>                                     void **refcount_table,
>>                                     int64_t *refcount_table_size);
>> -bool qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp);
>> +bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp);
>>   int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
>>   void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
>>   int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
>> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
>> index 3579a7597c..144e77a879 100644
>> --- a/include/block/dirty-bitmap.h
>> +++ b/include/block/dirty-bitmap.h
>> @@ -65,7 +65,6 @@ void bdrv_dirty_bitmap_deserialize_ones(BdrvDirtyBitmap *bitmap,
>>   void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap);
>>   
>>   void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap, bool value);
>> -void bdrv_dirty_bitmap_set_autoload(BdrvDirtyBitmap *bitmap, bool autoload);
>>   void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap,
>>                                          bool persistent);
>>   
>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>> index bd04e991b1..3777be1985 100644
>> --- a/block/dirty-bitmap.c
>> +++ b/block/dirty-bitmap.c
>> @@ -52,8 +52,6 @@ struct BdrvDirtyBitmap {
>>                                      Such operations must fail and both the image
>>                                      and this bitmap must remain unchanged while
>>                                      this flag is set. */
>> -    bool autoload;              /* For persistent bitmaps: bitmap must be
>> -                                   autoloaded on image opening */
>>       bool persistent;            /* bitmap must be saved to owner disk image */
>>       QLIST_ENTRY(BdrvDirtyBitmap) list;
>>   };
>> @@ -104,7 +102,6 @@ void bdrv_dirty_bitmap_make_anon(BdrvDirtyBitmap *bitmap)
>>       g_free(bitmap->name);
>>       bitmap->name = NULL;
>>       bitmap->persistent = false;
>> -    bitmap->autoload = false;
>>   }
>>   
>>   /* Called with BQL taken.  */
>> @@ -261,8 +258,6 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
>>       bitmap->successor = NULL;
>>       successor->persistent = bitmap->persistent;
>>       bitmap->persistent = false;
>> -    successor->autoload = bitmap->autoload;
>> -    bitmap->autoload = false;
>>       bdrv_release_dirty_bitmap(bs, bitmap);
>>   
>>       return successor;
>> @@ -667,19 +662,6 @@ bool bdrv_has_readonly_bitmaps(BlockDriverState *bs)
>>   }
>>   
>>   /* Called with BQL taken. */
>> -void bdrv_dirty_bitmap_set_autoload(BdrvDirtyBitmap *bitmap, bool autoload)
>> -{
>> -    qemu_mutex_lock(bitmap->mutex);
>> -    bitmap->autoload = autoload;
>> -    qemu_mutex_unlock(bitmap->mutex);
>> -}
>> -
>> -bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap)
>> -{
>> -    return bitmap->autoload;
>> -}
>> -
>> -/* Called with BQL taken. */
>>   void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap, bool persistent)
>>   {
>>       qemu_mutex_lock(bitmap->mutex);
>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>> index f45e46cfbd..ae14464de6 100644
>> --- a/block/qcow2-bitmap.c
>> +++ b/block/qcow2-bitmap.c
>> @@ -933,14 +933,14 @@ static void set_readonly_helper(gpointer bitmap, gpointer value)
>>       bdrv_dirty_bitmap_set_readonly(bitmap, (bool)value);
>>   }
>>   
>> -/* qcow2_load_autoloading_dirty_bitmaps()
>> +/* qcow2_load_dirty_bitmaps()
>>    * Return value is a hint for caller: true means that the Qcow2 header was
>>    * updated. (false doesn't mean that the header should be updated by the
>>    * caller, it just means that updating was not needed or the image cannot be
>>    * written to).
>>    * On failure the function returns false.
>>    */
>> -bool qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>> +bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>>   {
>>       BDRVQcow2State *s = bs->opaque;
>>       Qcow2BitmapList *bm_list;
>> @@ -960,14 +960,16 @@ bool qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>>       }
>>   
>>       QSIMPLEQ_FOREACH(bm, bm_list, entry) {
>> -        if ((bm->flags & BME_FLAG_AUTO) && !(bm->flags & BME_FLAG_IN_USE)) {
>> +        if (!(bm->flags & BME_FLAG_IN_USE)) {
>>               BdrvDirtyBitmap *bitmap = load_bitmap(bs, bm, errp);
>>               if (bitmap == NULL) {
>>                   goto fail;
>>               }
>>   
>> +            if (!(bm->flags & BME_FLAG_AUTO)) {
>> +                bdrv_disable_dirty_bitmap(bitmap);
>> +            }
> So we're re-using this as the enabled flag, basically.
>
>>               bdrv_dirty_bitmap_set_persistance(bitmap, true);
>> -            bdrv_dirty_bitmap_set_autoload(bitmap, true);
>>               bm->flags |= BME_FLAG_IN_USE;
>>               created_dirty_bitmaps =
>>                       g_slist_append(created_dirty_bitmaps, bitmap);
>> @@ -1369,7 +1371,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>>               bm->table.size = 0;
>>               QSIMPLEQ_INSERT_TAIL(&drop_tables, tb, entry);
>>           }
>> -        bm->flags = bdrv_dirty_bitmap_get_autoload(bitmap) ? BME_FLAG_AUTO : 0;
>> +        bm->flags = bdrv_dirty_bitmap_enabled(bitmap) ? BME_FLAG_AUTO : 0;
>>           bm->granularity_bits = ctz32(bdrv_dirty_bitmap_granularity(bitmap));
>>           bm->dirty_bitmap = bitmap;
>>       }
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 92cb9f9bfa..93c3a97cfe 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -1441,7 +1441,7 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
>>           s->autoclear_features &= QCOW2_AUTOCLEAR_MASK;
>>       }
>>   
>> -    if (qcow2_load_autoloading_dirty_bitmaps(bs, &local_err)) {
>> +    if (qcow2_load_dirty_bitmaps(bs, &local_err)) {
>>           update_header = false;
>>       }
>>       if (local_err != NULL) {
>> diff --git a/blockdev.c b/blockdev.c
>> index 56a6b24a0b..8068cbd606 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -2738,14 +2738,9 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
>>       if (!has_persistent) {
>>           persistent = false;
>>       }
>> -    if (!has_autoload) {
>> -        autoload = false;
>> -    }
>>   
>> -    if (has_autoload && !persistent) {
>> -        error_setg(errp, "Autoload flag must be used only for persistent "
>> -                         "bitmaps");
>> -        return;
>> +    if (has_autoload) {
>> +        warn_report("Autoload option is deprected and its value is ignored");
> "deprecated"
>
>>       }
>>   
>>       if (persistent &&
>> @@ -2760,7 +2755,6 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
>>       }
>>   
>>       bdrv_dirty_bitmap_set_persistance(bitmap, persistent);
>> -    bdrv_dirty_bitmap_set_autoload(bitmap, autoload);
>>   }
>>   
>>   void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
>>
> Checks out mechanically; I'm not sure yet if we ought to re-use
> BME_FLAG_AUTO as the enabled flag. I'll get back to that :)
>
> With spelling error fixed:
>
> Reviewed-by: John Snow <jsnow@redhat.com>


-- 
Best regards,
Vladimir
