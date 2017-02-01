Received: from eggs.gnu.org ([2001:4830:134:3::10]:48631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cYvQ3-0000in-9u
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:57:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cYvQ2-0008Iq-8u
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:57:55 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:36003 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cYvQ1-0008Ih-T8
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:57:54 -0500
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
	<20170123121036.4823-24-vsementsov@virtuozzo.com>
	<6ff8e50e-c6d8-d3b6-f900-3700bbe30dee@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <cceeb174-5fae-9012-a430-209d59a0bac7@virtuozzo.com>
Date: Wed, 1 Feb 2017 16:57:39 +0300
MIME-Version: 1.0
In-Reply-To: <6ff8e50e-c6d8-d3b6-f900-3700bbe30dee@redhat.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 23/24] qcow2: add
 .bdrv_remove_persistent_dirty_bitmap
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

01.02.2017 02:20, Max Reitz wrote:
> On 23.01.2017 13:10, Vladimir Sementsov-Ogievskiy wrote:
>> Realize .bdrv_remove_persistent_dirty_bitmap interface.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/qcow2-bitmap.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>   block/qcow2.c        |  1 +
>>   block/qcow2.h        |  3 +++
>>   3 files changed, 44 insertions(+)
>>
>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>> index 2687a3acd5..be026fc80e 100644
>> --- a/block/qcow2-bitmap.c
>> +++ b/block/qcow2-bitmap.c
>> @@ -1064,6 +1064,46 @@ static Qcow2Bitmap *find_bitmap_by_name(Qcow2BitmapList *bm_list,
>>       return NULL;
>>   }
>>   
>> +void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>> +                                          const char *name,
>> +                                          Error **errp)
>> +{
>> +    int ret;
>> +    BDRVQcow2State *s = bs->opaque;
>> +    Qcow2Bitmap *bm;
>> +    Qcow2BitmapList *bm_list;
>> +
>> +    if (s->nb_bitmaps == 0) {
>> +        /* No bitmaps - nothing to do */
> Shouldn't it be an error? I.e. "bitmap not found"?
>
>> +        return;
>> +    }
>> +
>> +    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
>> +                               s->bitmap_directory_size, errp);
>> +    if (bm_list == NULL) {
>> +        return;
>> +    }
>> +
>> +    bm = find_bitmap_by_name(bm_list, name);
>> +    if (bm == NULL) {
>> +        goto fail;
> What about setting errp? Or do you not consider this an error?
>
> I think it should be an error.

Hmm. The following scenery should not be an error:
1. qmp create dirty bitmap with persistent = true (bitmap not exists and 
not created  in the storage, it will be saved only on storage close)
2. qmp remove dirty bitmap. persistent = true, so we will try to remove 
it from storage..

So, I see following variants:
1. as is, just add comment "remove if exists"
2. add return value to this function, return ENOENT if bitmap not found 
and ignore this ENOENT in qmp_remove_bitmap
3. add additional bool field 'exist_in_storage' to BdrvDirtyBitmap.

>
>> +    }
>> +
>> +    QSIMPLEQ_REMOVE(bm_list, bm, Qcow2Bitmap, entry);
> bm->name is leaked here.
>
> Max
>
>> +
>> +    ret = update_ext_header_and_dir(bs, bm_list);
>> +    if (ret < 0) {
>> +        error_setg_errno(errp, -ret, "Failed to update bitmap extension");
>> +        goto fail;
>> +    }
>> +
>> +    free_bitmap_clusters(bs, &bm->table);
>> +
>> +fail:
>> +    bitmap_free(bm);
>> +    bitmap_list_free(bm_list);
>> +}
>> +
>>   void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>>   {
>>       BdrvDirtyBitmap *bitmap;
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 76a6a2ba28..f6bac38e51 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -3544,6 +3544,7 @@ BlockDriver bdrv_qcow2 = {
>>       .bdrv_load_autoloading_dirty_bitmaps = qcow2_load_autoloading_dirty_bitmaps,
>>       .bdrv_store_persistent_dirty_bitmaps = qcow2_store_persistent_dirty_bitmaps,
>>       .bdrv_can_store_new_dirty_bitmap = qcow2_can_store_new_dirty_bitmap,
>> +    .bdrv_remove_persistent_dirty_bitmap = qcow2_remove_persistent_dirty_bitmap,
>>   };
>>   
>>   static void bdrv_qcow2_init(void)
>> diff --git a/block/qcow2.h b/block/qcow2.h
>> index eaad34a527..a009827f60 100644
>> --- a/block/qcow2.h
>> +++ b/block/qcow2.h
>> @@ -627,5 +627,8 @@ bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
>>   int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
>>                                     void **refcount_table,
>>                                     int64_t *refcount_table_size);
>> +void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>> +                                          const char *name,
>> +                                          Error **errp);
>>   
>>   #endif
>>
>


-- 
Best regards,
Vladimir
