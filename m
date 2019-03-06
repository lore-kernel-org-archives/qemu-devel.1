Received: from eggs.gnu.org ([209.51.188.92]:59336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h1YaI-0005si-9P
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 10:35:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h1YaH-00049C-0G
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 10:35:54 -0500
References: <20190305234337.18353-1-jsnow@redhat.com>
	<20190305234337.18353-2-jsnow@redhat.com>
	<533b0898-c7a6-13dc-2dd8-35605eb2877c@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <2e1564af-b4f4-df8a-2185-576125eafc44@redhat.com>
Date: Wed, 6 Mar 2019 10:35:30 -0500
MIME-Version: 1.0
In-Reply-To: <533b0898-c7a6-13dc-2dd8-35605eb2877c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] block/qcow2-bitmap: Skip length check
 in some cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "eblake@redhat.com" <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>



On 3/6/19 10:21 AM, Vladimir Sementsov-Ogievskiy wrote:
> 06.03.2019 2:43, John Snow wrote:
>> If we were to allow resizes, the length check that happens when we load
>> bitmap headers from disk when we read or store bitmaps would begin to
>> fail:
>>
>> Imagine the circumstance where we've resized bitmaps in memory, but they still
>> have the old values on-disk. The lengths will no longer match bdrv_getlength,
>> so we must allow this check to be skipped when flushing bitmaps to disk.
>>
>> Limit this to when we are about to overwrite the headers: we will verify the
>> outgoing headers, but we will skip verifying the known stale headers.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   block/qcow2-bitmap.c | 34 +++++++++++++++++++++-------------
>>   1 file changed, 21 insertions(+), 13 deletions(-)
>>
>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>> index c3b210ede1..d02730004a 100644
>> --- a/block/qcow2-bitmap.c
>> +++ b/block/qcow2-bitmap.c
>> @@ -435,7 +435,8 @@ static inline Qcow2BitmapDirEntry *next_dir_entry(Qcow2BitmapDirEntry *entry)
>>       return (Qcow2BitmapDirEntry *)((uint8_t *)entry + dir_entry_size(entry));
>>   }
>>   
>> -static int check_dir_entry(BlockDriverState *bs, Qcow2BitmapDirEntry *entry)
>> +static int check_dir_entry(BlockDriverState *bs, Qcow2BitmapDirEntry *entry,
>> +                           bool allow_resize)
>>   {
>>       BDRVQcow2State *s = bs->opaque;
>>       uint64_t phys_bitmap_bytes;
>> @@ -462,8 +463,14 @@ static int check_dir_entry(BlockDriverState *bs, Qcow2BitmapDirEntry *entry)
>>           return len;
>>       }
>>   
>> -    fail = (phys_bitmap_bytes > BME_MAX_PHYS_SIZE) ||
>> -           (len > ((phys_bitmap_bytes * 8) << entry->granularity_bits));
>> +    if (phys_bitmap_bytes > BME_MAX_PHYS_SIZE) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (!allow_resize &&
>> +        (len > ((phys_bitmap_bytes * 8) << entry->granularity_bits))) {
>> +        return -EINVAL;
>> +    }
>>   
>>       return fail ? -EINVAL : 0;
>>   }
>> @@ -534,7 +541,8 @@ static uint32_t bitmap_list_count(Qcow2BitmapList *bm_list)
>>    * checks it and convert to bitmap list.
>>    */
>>   static Qcow2BitmapList *bitmap_list_load(BlockDriverState *bs, uint64_t offset,
>> -                                         uint64_t size, Error **errp)
>> +                                         uint64_t size, bool allow_resize,
>> +                                         Error **errp)
>>   {
>>       int ret;
>>       BDRVQcow2State *s = bs->opaque;
>> @@ -593,7 +601,7 @@ static Qcow2BitmapList *bitmap_list_load(BlockDriverState *bs, uint64_t offset,
>>               goto fail;
>>           }
>>   
>> -        ret = check_dir_entry(bs, e);
>> +        ret = check_dir_entry(bs, e, allow_resize);
>>           if (ret < 0) {
>>               error_setg(errp, "Bitmap '%.*s' doesn't satisfy the constraints",
>>                          e->name_size, dir_entry_name_field(e));
>> @@ -654,7 +662,7 @@ int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
>>       }
>>   
>>       bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
>> -                               s->bitmap_directory_size, NULL);
>> +                               s->bitmap_directory_size, false, NULL);
>>       if (bm_list == NULL) {
>>           res->corruptions++;
>>           return -EINVAL;
>> @@ -755,7 +763,7 @@ static int bitmap_list_store(BlockDriverState *bs, Qcow2BitmapList *bm_list,
>>           e->extra_data_size = 0;
>>           memcpy(e + 1, bm->name, e->name_size);
>>   
>> -        if (check_dir_entry(bs, e) < 0) {
>> +        if (check_dir_entry(bs, e, false) < 0) {
>>               ret = -EINVAL;
>>               goto fail;
>>           }
>> @@ -957,7 +965,7 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>>       }
>>   
>>       bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
>> -                               s->bitmap_directory_size, errp);
>> +                               s->bitmap_directory_size, false, errp);
>>       if (bm_list == NULL) {
>>           return false;
>>       }
>> @@ -1066,7 +1074,7 @@ Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(BlockDriverState *bs,
>>       }
>>   
>>       bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
>> -                               s->bitmap_directory_size, errp);
>> +                               s->bitmap_directory_size, false, errp);
>>       if (bm_list == NULL) {
>>           return NULL;
>>       }
>> @@ -1111,7 +1119,7 @@ int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_updated,
>>       }
>>   
>>       bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
>> -                               s->bitmap_directory_size, errp);
>> +                               s->bitmap_directory_size, false, errp);
>>       if (bm_list == NULL) {
>>           return -EINVAL;
>>       }
>> @@ -1359,7 +1367,7 @@ void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>>       }
>>   
>>       bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
>> -                               s->bitmap_directory_size, errp);
>> +                               s->bitmap_directory_size, false, errp);
>>       if (bm_list == NULL) {
>>           return;
>>       }
>> @@ -1412,7 +1420,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>>           bm_list = bitmap_list_new();
>>       } else {
> 
> Worth comment here, that we assume that image may be resized?
> 

You mean below, to explain the 'true' parameter? Yes, I will do so.

>>           bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
>> -                                   s->bitmap_directory_size, errp);
>> +                                   s->bitmap_directory_size, true, errp);
>>           if (bm_list == NULL) {
>>               return;
>>           }
>> @@ -1593,7 +1601,7 @@ bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
>>       }
>>   
>>       bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
>> -                               s->bitmap_directory_size, errp);
>> +                               s->bitmap_directory_size, false, errp);
>>       if (bm_list == NULL) {
>>           goto fail;
>>       }
>>
> 
> With Eric's suggestion:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 

The bad return conditional, I assume? OK, will do.
