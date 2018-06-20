Received: from eggs.gnu.org ([2001:4830:134:3::10]:52660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVcui-00006F-PB
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:12:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVcuc-0007nx-2p
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:12:44 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20180613020613.1343-1-jsnow@redhat.com>
	<20180613020613.1343-4-jsnow@redhat.com>
	<f3332ec8-5370-fecc-b0ae-4834d0eb28b7@virtuozzo.com>
Message-ID: <185311b4-20c8-236c-d5df-a0a669a99a65@virtuozzo.com>
Date: Wed, 20 Jun 2018 16:12:24 +0300
MIME-Version: 1.0
In-Reply-To: <f3332ec8-5370-fecc-b0ae-4834d0eb28b7@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 03/10] qcow2/bitmap: cache bm_list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>

20.06.2018 16:04, Vladimir Sementsov-Ogievskiy wrote:
> 13.06.2018 05:06, John Snow wrote:
>> We don't need to re-read this list every time, exactly. We can keep it cached
>> and delete our copy when we flush to disk.
>>
>> Because we don't try to flush bitmaps on close if there's nothing to flush,
>> add a new conditional to delete the state anyway for a clean exit.
>>
>> Signed-off-by: John Snow<jsnow@redhat.com>
>> ---
>>   block/qcow2-bitmap.c | 74 ++++++++++++++++++++++++++++++++++------------------
>>   block/qcow2.c        |  2 ++
>>   block/qcow2.h        |  2 ++
>>   3 files changed, 52 insertions(+), 26 deletions(-)
>>
>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>> index 85c1b5afe3..5ae9b17928 100644
>> --- a/block/qcow2-bitmap.c
>> +++ b/block/qcow2-bitmap.c
>> @@ -636,6 +636,34 @@ fail:
>>       return NULL;
>>   }
>>   
>> +static Qcow2BitmapList *get_bitmap_list(BlockDriverState *bs, Error **errp)
>> +{
>> +    BDRVQcow2State *s = bs->opaque;
>> +    Qcow2BitmapList *bm_list;
>> +
>> +    if (s->bitmap_list) {
>> +        return (Qcow2BitmapList *)s->bitmap_list;
>> +    }
>> +
>> +    if (s->nb_bitmaps) {
>> +        bm_list = bitmap_list_load(bs, errp);
>> +    } else {
>> +        bm_list = bitmap_list_new();
>> +    }
>> +    s->bitmap_list = bm_list;
>
> may be, we shouldn't cache it in inactive mode. However, I think we'll 
> finally will not load bitmaps in inactive mode and drop the on 
> inactivate, so it would not matter..

really, now it would be a problem: we can start in inactive mode, load 
nothing, and then we can't reload bitmaps; my fix in
https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg03254.html
will not work after this patch.

>
> Hm, I've understood the following problem: cache becomes incorrect 
> after failed update_ext_header_and_dir or 
> update_ext_header_and_dir_in_place operations. (after failed 
> qcow2_remove_persistent_dirty_bitmap or qcow2_reopen_bitmaps_rw_hint)
>
> And this comes from incomplete architecture after the patch:
> On the one hand, we work with one singleton bitmap_list, and loading 
> part is refactored to do it safely. On the other hand, storing 
> functions still have old behavior, they work with bitmap list like 
> with their own local variable.
>
> So, we have safe mechanism to read list through the cache. We need 
> also safe mechanism to update list both in cache and in file.
>
> There are two possible variants:
>
> 1. drop cache after failed store
> 2. rollback cache after failed store
>
> 1 looks simpler..
>
> Also, we should drop cache on inactivate (we do this) and should not 
> create cache in inactive mode, because the other process may change 
> the image.
>
> Hm. may be, it is better to work with s->bitmap_list directly? In this 
> case it will be more obvious that it is the cache, not local variable. 
> And we will work with it like with other "parts of extension cache" 
> s->nb_bitmaps, s->bitmap_directory_offset ...
>
> After the patch, functions update_ext_header_and_dir* becomes strange:
>
> 1. before the patch, they take external parameter - bm_list, and by 
> this parameter they updated the file and cached s->nb_bitmaps, 
> s->bitmap_*, ..
> 2. after the patch, they take parameter (actually s->bitmap_list) of 
> same nature like s->nb_bitmap, and update s->nb_bitmap from it.
>
> Sorry for being late and for disordered stream of thoughts. Is this 
> patch really needed for the whole series?
>
>> +    return bm_list;
>> +}
>> +
>> +static void del_bitmap_list(BlockDriverState *bs)
>> +{
>> +    BDRVQcow2State *s = bs->opaque;
>> +
>> +    if (s->bitmap_list) {
>> +        bitmap_list_free(s->bitmap_list);
>> +        s->bitmap_list = NULL;
>> +    }
>> +}
>> +
>>   int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
>>                                     void **refcount_table,
>>                                     int64_t *refcount_table_size)
>> @@ -656,7 +684,7 @@ int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
>>           return ret;
>>       }
>>   
>> -    bm_list = bitmap_list_load(bs, NULL);
>> +    bm_list = get_bitmap_list(bs, NULL);
>>       if (bm_list == NULL) {
>>           res->corruptions++;
>>           return -EINVAL;
>> @@ -706,8 +734,6 @@ int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
>>       }
>>   
>>   out:
>> -    bitmap_list_free(bm_list);
>> -
>>       return ret;
>>   }
>>   
>> @@ -944,7 +970,7 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>>           return false;
>>       }
>>   
>> -    bm_list = bitmap_list_load(bs, errp);
>> +    bm_list = get_bitmap_list(bs, errp);
>>       if (bm_list == NULL) {
>>           return false;
>>       }
>> @@ -978,8 +1004,6 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>>           }
>>       }
>>   
>> -    bitmap_list_free(bm_list);
>> -
>>       return needs_update;
>>   
>>   fail:
>> @@ -988,8 +1012,7 @@ fail:
>>               bdrv_release_dirty_bitmap(bs, bm->dirty_bitmap);
>>           }
>>       }
>> -    bitmap_list_free(bm_list);
>> -
>> +    del_bitmap_list(bs);
>>       return false;
>>   }
>>   
>> @@ -1016,7 +1039,7 @@ int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_updated,
>>           return -EINVAL;
>>       }
>>   
>> -    bm_list = bitmap_list_load(bs, errp);
>> +    bm_list = get_bitmap_list(bs, errp);
>>       if (bm_list == NULL) {
>>           return -EINVAL;
>>       }
>> @@ -1056,7 +1079,6 @@ int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_updated,
>>   
>>   out:
>>       g_slist_free(ro_dirty_bitmaps);
>> -    bitmap_list_free(bm_list);
>>   
>>       return ret;
>>   }
>> @@ -1265,7 +1287,7 @@ void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>>           return;
>>       }
>>   
>> -    bm_list = bitmap_list_load(bs, errp);
>> +    bm_list = get_bitmap_list(bs, errp);
>>       if (bm_list == NULL) {
>>           return;
>>       }
>> @@ -1287,7 +1309,11 @@ void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>>   
>>   fail:
>>       bitmap_free(bm);
>> -    bitmap_list_free(bm_list);
>> +}
>> +
>> +void qcow2_persistent_dirty_bitmaps_cache_destroy(BlockDriverState *bs)
>> +{
>> +    del_bitmap_list(bs);
>>   }
>>   
>>   void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>> @@ -1304,23 +1330,19 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>>   
>>       if (!bdrv_has_changed_persistent_bitmaps(bs)) {
>>           /* nothing to do */
>> -        return;
>> +        goto out;
>>       }
>>   
>>       if (!can_write(bs)) {
>>           error_setg(errp, "No write access");
>> -        return;
>> +        goto out;
>>       }
>>   
>>       QSIMPLEQ_INIT(&drop_tables);
>>   
>> -    if (s->nb_bitmaps == 0) {
>> -        bm_list = bitmap_list_new();
>> -    } else {
>> -        bm_list = bitmap_list_load(bs, errp);
>> -        if (bm_list == NULL) {
>> -            return;
>> -        }
>> +    bm_list = get_bitmap_list(bs, errp);
>> +    if (bm_list == NULL) {
>> +        goto out;
>>       }
>>   
>>       /* check constraints and names */
>> @@ -1400,8 +1422,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>>           g_free(tb);
>>       }
>>   
>> -    bitmap_list_free(bm_list);
>> -    return;
>> +    goto out;
>>   
>>   fail:
>>       QSIMPLEQ_FOREACH(bm, bm_list, entry) {
>> @@ -1416,7 +1437,9 @@ fail:
>>           g_free(tb);
>>       }
>>   
>> -    bitmap_list_free(bm_list);
>> + out:
>> +    del_bitmap_list(bs);
>> +    return;
>>   }
>>   
>>   int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp)
>> @@ -1481,13 +1504,12 @@ bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
>>           goto fail;
>>       }
>>   
>> -    bm_list = bitmap_list_load(bs, errp);
>> +    bm_list = get_bitmap_list(bs, errp);
>>       if (bm_list == NULL) {
>>           goto fail;
>>       }
>>   
>>       found = find_bitmap_by_name(bm_list, name);
>> -    bitmap_list_free(bm_list);
>>       if (found) {
>>           error_setg(errp, "Bitmap with the same name is already stored");
>>           goto fail;
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 6fa5e1d71a..dbd334b150 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -2148,6 +2148,8 @@ static void qcow2_close(BlockDriverState *bs)
>>   
>>       if (!(s->flags & BDRV_O_INACTIVE)) {
>>           qcow2_inactivate(bs);
>> +    } else {
>> +        qcow2_persistent_dirty_bitmaps_cache_destroy(bs);
>>       }
>>   
>>       cache_clean_timer_del(bs);
>> diff --git a/block/qcow2.h b/block/qcow2.h
>> index 01b5250415..29b637a0ee 100644
>> --- a/block/qcow2.h
>> +++ b/block/qcow2.h
>> @@ -295,6 +295,7 @@ typedef struct BDRVQcow2State {
>>       uint64_t bitmap_directory_size;
>>       uint64_t bitmap_directory_offset;
>>       bool dirty_bitmaps_loaded;
>> +    void *bitmap_list;
>>   
>>       int flags;
>>       int qcow_version;
>> @@ -671,6 +672,7 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp);
>>   int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_updated,
>>                                    Error **errp);
>>   int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
>> +void qcow2_persistent_dirty_bitmaps_cache_destroy(BlockDriverState *bs);
>>   void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
>>   int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
>>   bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
>
>
> -- 
> Best regards,
> Vladimir


-- 
Best regards,
Vladimir
