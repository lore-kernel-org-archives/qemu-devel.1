Received: from eggs.gnu.org ([2001:4830:134:3::10]:53075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cdf9s-0006a5-8C
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 10:36:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cdf9q-00073x-Cv
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 10:36:48 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:16030 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cdf9p-00073B-U8
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 10:36:46 -0500
References: <20170203094018.15493-1-vsementsov@virtuozzo.com>
	<20170203094018.15493-14-vsementsov@virtuozzo.com>
	<f1f35d1a-104b-c606-bed1-dc49bd6b91fa@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <614cbf0e-c9f4-c8c8-79c6-d4d71c70aa84@virtuozzo.com>
Date: Tue, 14 Feb 2017 18:36:31 +0300
MIME-Version: 1.0
In-Reply-To: <f1f35d1a-104b-c606-bed1-dc49bd6b91fa@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/24] qcow2: add
 .bdrv_store_persistent_dirty_bitmaps()
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

14.02.2017 03:38, John Snow wrote:
>
> On 02/03/2017 04:40 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Realize block bitmap storing interface, to allow qcow2 images store
>> persistent bitmaps.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   block/qcow2-bitmap.c | 489 +++++++++++++++++++++++++++++++++++++++++++++++++--
>>   block/qcow2.c        |   1 +
>>   block/qcow2.h        |   1 +
>>   3 files changed, 476 insertions(+), 15 deletions(-)
>>

[...]

>> +
>> +static void clear_bitmap_table(BlockDriverState *bs, uint64_t *bitmap_table,
>> +                               uint32_t bitmap_table_size)
>> +{
>> +    BDRVQcow2State *s = bs->opaque;
>> +    int i;
>> +
>> +    for (i = 0; i < bitmap_table_size; ++i) {
>> +        uint64_t addr = bitmap_table[i] & BME_TABLE_ENTRY_OFFSET_MASK;
>> +        if (!addr) {
>> +            continue;
>> +        }
>> +
>> +        qcow2_free_clusters(bs, addr, s->cluster_size, QCOW2_DISCARD_OTHER);
>> +        bitmap_table[i] = 0;
>> +    }
>> +}
>> +
>> +static int bitmap_table_load(BlockDriverState *bs, Qcow2BitmapTable *tb,
>>                                uint64_t **bitmap_table)
> It would have been nicer to have factored out the size and offset from
> the very beginning to avoid churn within this series, but... oh well.
> Next time you write a 24 patch series, OK? :)

Hmm... What do you mean?

>
>>   {
>>       int ret;
>> @@ -152,20 +218,20 @@ static int bitmap_table_load(BlockDriverState *bs, Qcow2Bitmap *bm,
>>       uint32_t i;
>>       uint64_t *table;
>>   
>> -    assert(bm->table_size != 0);
>> -    table = g_try_new(uint64_t, bm->table_size);
>> +    assert(tb->size != 0);
>> +    table = g_try_new(uint64_t, tb->size);
>>       if (table == NULL) {
>>           return -ENOMEM;
>>       }
>>   
>> -    assert(bm->table_size <= BME_MAX_TABLE_SIZE);
>> -    ret = bdrv_pread(bs->file, bm->table_offset,
>> -                     table, bm->table_size * sizeof(uint64_t));
>> +    assert(tb->size <= BME_MAX_TABLE_SIZE);
>> +    ret = bdrv_pread(bs->file, tb->offset,
>> +                     table, tb->size * sizeof(uint64_t));
>>       if (ret < 0) {
>>           goto fail;
>>       }
>>   
>> -    for (i = 0; i < bm->table_size; ++i) {
>> +    for (i = 0; i < tb->size; ++i) {
>>           be64_to_cpus(&table[i]);
>>           ret = check_table_entry(table[i], s->cluster_size);
>>           if (ret < 0) {
>> @@ -182,6 +248,28 @@ fail:
>>       return ret;
>>   }
>>   

[...]

>> +
>> +void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>> +{
>> +    BdrvDirtyBitmap *bitmap;
>> +    BDRVQcow2State *s = bs->opaque;
>> +    uint32_t new_nb_bitmaps = s->nb_bitmaps;
>> +    uint64_t new_dir_size = s->bitmap_directory_size;
>> +    int ret;
>> +    Qcow2BitmapList *bm_list;
>> +    Qcow2Bitmap *bm;
>> +    Qcow2BitmapTableList drop_tables;
>> +    Qcow2BitmapTable *tb, *tb_next;
>> +
>> +    QSIMPLEQ_INIT(&drop_tables);
>> +
>> +    if (!can_write(bs)) {
>> +        error_setg(errp, "No write access");
>> +        return;
>> +    }
>> +
>> +    if (!bdrv_has_persistent_bitmaps(bs)) {
>> +        /* nothing to do */
>> +        return;
>> +    }
>> +
>> +    if (s->nb_bitmaps == 0) {
>> +        bm_list = bitmap_list_new();
>> +    } else {
>> +        bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
>> +                                   s->bitmap_directory_size, errp);
> Oh, this isn't cached from the autoload mechanism? We have to re-create
> this list every time we save?
>
> I suppose it's safest that way, but it's something we can likely improve on.

There is a patch fixing  in v11 series - [PATCH 24/24] qcow2-bitmap: 
cache bitmap list in BDRVQcow2State
We decided to apply it later.


>
>> +        if (bm_list == NULL) {
>> +            /* errp is already set */
> Usually implicit when checking the return code from a function that
> takes an errp parameter.
>
>> +            return;
>> +        }
>> +    }
>> +
>> +    /* check constraints and names */
>> +    for (bitmap = bdrv_dirty_bitmap_next(bs, NULL); bitmap != NULL;
>> +         bitmap = bdrv_dirty_bitmap_next(bs, bitmap))
>> +    {
> It occurs to me at this point that the framework you have established is
> very dirty-bitmap heavy, even though we support other types of bitmaps.
>
> Not really a big problem, as when we go to support OTHER types of
> bitmaps, we can just change the names of things as we need to.
>
> Just a comment.
>
>> +        const char *name = bdrv_dirty_bitmap_name(bitmap);
>> +        uint32_t granularity = bdrv_dirty_bitmap_granularity(bitmap);
>> +        Qcow2Bitmap *bm;
>> +
>> +        if (!bdrv_dirty_bitmap_get_persistance(bitmap)) {
>> +            continue;
>> +        }
>> +
>> +        if (check_constraints_on_bitmap(bs, name, granularity) < 0) {
>> +            error_setg(errp, "Bitmap '%s' doesn't satisfy the constraints",
>> +                       name);
>> +            goto fail;
>> +        }
> At this point I really do begin to become concerned that it will be very
> easy for people to accidentally back themselves into a case where they
> cannot save their bitmaps to disk, but will have no idea why that is
> true because the error message is vague.
>
> I am not fully clear on how easy it would be to create a bitmap that
> QEMU will accept but refuse to flush to disk for size reasons, but I
> think it's fairly easy to create a name that will overcome the string
> limit we've imposed.

Actually unsupported bitmap should be caught on qmp-bitmap-add if 
persistent=true. So, user can't create it. The other source of bitmaps - 
autoloading bitmaps, but they should be ok and they are checked on load.
Considered check is a paranoic one. But I think it should not be 
replaced with an assert.

>
> Can we make the error message here more descriptive for starters? (We
> should make sure we can change the names of bitmaps too, so we can allow
> people to fix their bitmaps.

Ok, I'll add errp parameter to check_constraints_on_bitmap as a new patch.

>
> (Can we begin imposing warnings or errors for people who make bitmaps
> with names that are too big? 1023 should be enough for all current uses
> of this feature, I'd hope.)
>
> CC eblake, QMP lawyer ...
>
>> +
>> +        bm = find_bitmap_by_name(bm_list, name);
>> +        if (bm == NULL) {
>> +            if (++new_nb_bitmaps > QCOW2_MAX_BITMAPS) {
>> +                error_setg(errp, "Too many persistent bitmaps");
>> +                goto fail;
>> +            }
>> +
>> +            new_dir_size += calc_dir_entry_size(strlen(name), 0);
>> +            if (new_dir_size > QCOW2_MAX_BITMAP_DIRECTORY_SIZE) {
>> +                error_setg(errp, "Too large bitmap directory");
>> +                goto fail;
>> +            }
>> +
> Suggest "Bitmap directory is too large" instead.
>
>> +            bm = g_new0(Qcow2Bitmap, 1);
>> +            bm->name = g_strdup(name);
>> +            QSIMPLEQ_INSERT_TAIL(bm_list, bm, entry);
>> +        } else {
>> +            if (!(bm->flags & BME_FLAG_IN_USE)) {
>> +                error_setg(errp, "Bitmap '%s' already exists in the image",
>> +                           name);
>> +                goto fail;
>> +            }
>> +            tb = g_memdup(&bm->table, sizeof(bm->table));
>> +            bm->table.offset = 0;
>> +            bm->table.size = 0;
> I guess this is so that updating the tables is 'safe'.
>
>> +            QSIMPLEQ_INSERT_TAIL(&drop_tables, tb, entry);
>> +        }
>> +        bm->flags = bdrv_dirty_bitmap_get_autoload(bitmap) ? BME_FLAG_AUTO : 0;
>> +        bm->granularity_bits = ctz32(bdrv_dirty_bitmap_granularity(bitmap));
>> +        bm->dirty_bitmap = bitmap;
>> +    }
>> +
>> +    /* allocate clusters and store bitmaps */
>> +    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
>> +        if (bm->dirty_bitmap == NULL) {
>> +            continue;
>> +        }
>> +
>> +        ret = store_bitmap(bs, bm, errp);
>> +        if (ret < 0) {
>> +            goto fail;
>> +        }
>> +    }
>> +
>> +    ret = update_ext_header_and_dir(bs, bm_list);
>> +    if (ret < 0) {
>> +        error_setg_errno(errp, -ret, "Failed to update bitmap extension");
>> +        goto fail;
>> +    }
>> +
>> +    /* Bitmap directory was successfully updated, so, old data can be dropped.
>> +     * TODO it is better to reuse these clusters */
>> +    QSIMPLEQ_FOREACH_SAFE(tb, &drop_tables, entry, tb_next) {
>> +        free_bitmap_clusters(bs, tb);
>> +        g_free(tb);
>> +    }
>> +
>> +    bitmap_list_free(bm_list);
>> +    return;
>> +
>> +fail:
>> +    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
>> +        if (bm->dirty_bitmap == NULL || bm->table.offset == 0) {
>> +            continue;
>> +        }
>> +
>> +        free_bitmap_clusters(bs, &bm->table);
>> +    }
>> +
>> +    QSIMPLEQ_FOREACH_SAFE(tb, &drop_tables, entry, tb_next) {
>> +        g_free(tb);
>> +    }
>> +
>> +    bitmap_list_free(bm_list);
>> +}
> Looks good otherwise, but some clarification on the error messages and
> that errant free explained will garner you the R-B.
>
> Thanks,
> --js


-- 
Best regards,
Vladimir
