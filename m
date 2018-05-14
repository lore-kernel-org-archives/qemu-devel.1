Received: from eggs.gnu.org ([2001:4830:134:3::10]:40126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fICNw-0004KM-MF
	for qemu-devel@nongnu.org; Mon, 14 May 2018 08:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fICNq-0001WG-9a
	for qemu-devel@nongnu.org; Mon, 14 May 2018 08:15:24 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20180512012537.22478-1-jsnow@redhat.com>
	<20180512012537.22478-2-jsnow@redhat.com>
	<79bed3c8-e80e-5f51-5dfc-0d71b1ea66ca@virtuozzo.com>
Message-ID: <1550da5e-d919-3a90-ff0f-1b764a32050c@virtuozzo.com>
Date: Mon, 14 May 2018 15:15:10 +0300
MIME-Version: 1.0
In-Reply-To: <79bed3c8-e80e-5f51-5dfc-0d71b1ea66ca@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 01/12] qcow2-bitmap: cache bm_list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

14.05.2018 14:55, Vladimir Sementsov-Ogievskiy wrote:
> 12.05.2018 04:25, John Snow wrote:
>> We don't need to re-read this list every time, exactly. We can keep 
>> it cached
>> and delete our copy when we flush to disk.
>
> Why not simply delete cache only on close (unconditionally)? Why do we 
> need to remove it after flush?
>
> Actually, I think we need to remove it only in qcow2_inactive, after 
> storing persistent bitmaps.
>
>
>>
>> Because we don't try to flush bitmaps on close if there's nothing to 
>> flush,
>> add a new conditional to delete the state anyway for a clean exit.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   block/qcow2-bitmap.c | 74 
>> ++++++++++++++++++++++++++++++++--------------------
>>   block/qcow2.c        |  2 ++
>>   block/qcow2.h        |  2 ++
>>   3 files changed, 50 insertions(+), 28 deletions(-)
>>
>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>> index 6e93ec43e1..fb0a4f3ec4 100644
>> --- a/block/qcow2-bitmap.c
>> +++ b/block/qcow2-bitmap.c
>> @@ -536,8 +536,7 @@ static uint32_t bitmap_list_count(Qcow2BitmapList 
>> *bm_list)
>>    * Get bitmap list from qcow2 image. Actually reads bitmap directory,
>>    * checks it and convert to bitmap list.
>>    */
>> -static Qcow2BitmapList *bitmap_list_load(BlockDriverState *bs, 
>> uint64_t offset,
>> -                                         uint64_t size, Error **errp)
>> +static Qcow2BitmapList *bitmap_list_load(BlockDriverState *bs, Error 
>> **errp)
>>   {
>>       int ret;
>>       BDRVQcow2State *s = bs->opaque;
>> @@ -545,6 +544,8 @@ static Qcow2BitmapList 
>> *bitmap_list_load(BlockDriverState *bs, uint64_t offset,
>>       Qcow2BitmapDirEntry *e;
>>       uint32_t nb_dir_entries = 0;
>>       Qcow2BitmapList *bm_list = NULL;
>> +    uint64_t offset = s->bitmap_directory_offset;
>> +    uint64_t size = s->bitmap_directory_size;
>
> Worth split this change as a refactoring patch (just remove extra 
> parameters)?
>
>>         if (size == 0) {
>>           error_setg(errp, "Requested bitmap directory size is zero");
>> @@ -636,6 +637,30 @@ fail:
>>       return NULL;
>>   }
>>   +static Qcow2BitmapList *get_bitmap_list(BlockDriverState *bs, 
>> Error **errp)
>> +{
>> +    BDRVQcow2State *s = bs->opaque;
>> +    Qcow2BitmapList *bm_list;
>> +
>> +    if (s->bitmap_list) {
>> +        return (Qcow2BitmapList *)s->bitmap_list;
>> +    }
>> +
>> +    bm_list = bitmap_list_load(bs, errp);
>> +    s->bitmap_list = bm_list;
>> +    return bm_list;
>> +}
>> +
>> +static void del_bitmap_list(BlockDriverState *bs)
>> +{
>> +    BDRVQcow2State *s = bs->opaque;
>> +
>> +    if (s->bitmap_list) {
>> +        bitmap_list_free(s->bitmap_list);
>> +        s->bitmap_list = NULL;
>> +    }
>> +}

so, with this functions, we see, that list is always safely loaded 
through the cache. But we need also guarantee, that list is always saved 
through the cache. There are a lot of functions, which stores an 
abstract bitmap list, given as a parameter, but we want always store our 
cache..

>> +
>>   int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, 
>> BdrvCheckResult *res,
>>                                     void **refcount_table,
>>                                     int64_t *refcount_table_size)
>> @@ -656,8 +681,7 @@ int 
>> qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult 
>> *res,
>>           return ret;
>>       }
>>   -    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
>> -                               s->bitmap_directory_size, NULL);
>> +    bm_list = get_bitmap_list(bs, NULL);
>>       if (bm_list == NULL) {
>>           res->corruptions++;
>>           return -EINVAL;
>> @@ -707,8 +731,6 @@ int 
>> qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult 
>> *res,
>>       }
>>     out:
>> -    bitmap_list_free(bm_list);
>> -
>>       return ret;
>>   }
>>   @@ -953,8 +975,7 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState 
>> *bs, Error **errp)
>>           return false;
>>       }
>>   -    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
>> -                               s->bitmap_directory_size, errp);
>> +    bm_list = get_bitmap_list(bs, errp);
>>       if (bm_list == NULL) {
>>           return false;
>>       }
>> @@ -992,14 +1013,12 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState 
>> *bs, Error **errp)
>>       }
>>         g_slist_free(created_dirty_bitmaps);
>> -    bitmap_list_free(bm_list);
>> -
>>       return header_updated;
>>     fail:
>>       g_slist_foreach(created_dirty_bitmaps, 
>> release_dirty_bitmap_helper, bs);
>>       g_slist_free(created_dirty_bitmaps);
>> -    bitmap_list_free(bm_list);
>> +    del_bitmap_list(bs);
>>         return false;
>>   }
>> @@ -1027,8 +1046,7 @@ int 
>> qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_updated,
>>           return -EINVAL;
>>       }
>>   -    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
>> -                               s->bitmap_directory_size, errp);
>> +    bm_list = get_bitmap_list(bs, errp);
>>       if (bm_list == NULL) {
>>           return -EINVAL;
>>       }
>> @@ -1068,7 +1086,6 @@ int 
>> qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_updated,
>>     out:
>>       g_slist_free(ro_dirty_bitmaps);
>> -    bitmap_list_free(bm_list);
>>         return ret;
>>   }
>> @@ -1277,8 +1294,7 @@ void 
>> qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>>           return;
>>       }
>>   -    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
>> -                               s->bitmap_directory_size, errp);
>> +    bm_list = get_bitmap_list(bs, errp);
>>       if (bm_list == NULL) {
>>           return;
>>       }
>> @@ -1300,7 +1316,11 @@ void 
>> qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>>     fail:
>>       bitmap_free(bm);
>> -    bitmap_list_free(bm_list);
>> +}
>> +
>> +void qcow2_persistent_dirty_bitmaps_cache_destroy(BlockDriverState *bs)
>> +{
>> +    del_bitmap_list(bs);
>>   }
>>     void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, 
>> Error **errp)
>> @@ -1317,12 +1337,12 @@ void 
>> qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>>         if (!bdrv_has_changed_persistent_bitmaps(bs)) {
>>           /* nothing to do */
>> -        return;
>> +        goto out;
>>       }
>>         if (!can_write(bs)) {
>>           error_setg(errp, "No write access");
>> -        return;
>> +        goto out;
>>       }
>>         QSIMPLEQ_INIT(&drop_tables);
>> @@ -1330,10 +1350,9 @@ void 
>> qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>>       if (s->nb_bitmaps == 0) {
>>           bm_list = bitmap_list_new();
>>       } else {
>> -        bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
>> -                                   s->bitmap_directory_size, errp);
>> +        bm_list = get_bitmap_list(bs, errp);
>>           if (bm_list == NULL) {
>> -            return;
>> +            goto out;
>>           }
>>       }
>>   @@ -1414,8 +1433,7 @@ void 
>> qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>>           g_free(tb);
>>       }
>>   -    bitmap_list_free(bm_list);
>> -    return;
>> +    goto out;
>>     fail:
>>       QSIMPLEQ_FOREACH(bm, bm_list, entry) {
>> @@ -1430,7 +1448,9 @@ fail:
>>           g_free(tb);
>>       }
>>   -    bitmap_list_free(bm_list);
>> + out:
>> +    del_bitmap_list(bs);
>> +    return;
>>   }
>>     int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp)
>> @@ -1495,14 +1515,12 @@ bool 
>> qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
>>           goto fail;
>>       }
>>   -    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
>> -                               s->bitmap_directory_size, errp);
>> +    bm_list = get_bitmap_list(bs, errp);
>>       if (bm_list == NULL) {
>>           goto fail;
>>       }
>>         found = find_bitmap_by_name(bm_list, name);
>> -    bitmap_list_free(bm_list);
>>       if (found) {
>>           error_setg(errp, "Bitmap with the same name is already 
>> stored");
>>           goto fail;
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 2f36e632f9..7ae9000656 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -2135,6 +2135,8 @@ static void qcow2_close(BlockDriverState *bs)
>>         if (!(s->flags & BDRV_O_INACTIVE)) {
>>           qcow2_inactivate(bs);
>> +    } else {
>> +        qcow2_persistent_dirty_bitmaps_cache_destroy(bs);
>>       }
>>         cache_clean_timer_del(bs);
>> diff --git a/block/qcow2.h b/block/qcow2.h
>> index adf5c3950f..796a8c914b 100644
>> --- a/block/qcow2.h
>> +++ b/block/qcow2.h
>> @@ -299,6 +299,7 @@ typedef struct BDRVQcow2State {
>>       uint64_t bitmap_directory_size;
>>       uint64_t bitmap_directory_offset;
>>       bool dirty_bitmaps_loaded;
>> +    void *bitmap_list;
>>         int flags;
>>       int qcow_version;
>> @@ -675,6 +676,7 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState 
>> *bs, Error **errp);
>>   int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool 
>> *header_updated,
>>                                    Error **errp);
>>   int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
>> +void qcow2_persistent_dirty_bitmaps_cache_destroy(BlockDriverState 
>> *bs);
>>   void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, 
>> Error **errp);
>>   int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
>>   bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
>
>


-- 
Best regards,
Vladimir
