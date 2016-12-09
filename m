Received: from eggs.gnu.org ([2001:4830:134:3::10]:45811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cFPWC-0002Qu-GQ
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 13:03:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cFPW8-0005LG-Gi
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 13:03:36 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:8229 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cFPW8-0005KI-6j
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 13:03:32 -0500
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
	<1479835586-74394-16-git-send-email-vsementsov@virtuozzo.com>
	<f3b2be4f-3ea6-0af9-00f6-e28d5b502974@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <8d6d6ad4-ab85-e45d-7d53-d03c595ff3f3@virtuozzo.com>
Date: Fri, 9 Dec 2016 21:03:15 +0300
MIME-Version: 1.0
In-Reply-To: <f3b2be4f-3ea6-0af9-00f6-e28d5b502974@redhat.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 15/21] qcow2: add
 .bdrv_can_store_dirty_bitmap
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

09.12.2016 20:28, Max Reitz wrote:
> On 22.11.2016 18:26, Vladimir Sementsov-Ogievskiy wrote:
>> Realize .bdrv_can_store_dirty_bitmap interface.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/qcow2-bitmap.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>   block/qcow2.c        |  1 +
>>   block/qcow2.h        |  4 ++++
>>   3 files changed, 45 insertions(+)
>>
>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>> index a975388..55b1112 100644
>> --- a/block/qcow2-bitmap.c
>> +++ b/block/qcow2-bitmap.c
>> @@ -1115,3 +1115,43 @@ fail:
>>   
>>       bitmap_list_free(bm_list);
>>   }
>> +
>> +bool qcow2_can_store_dirty_bitmap(BlockDriverState *bs,
>> +                                  const char *name,
>> +                                  uint32_t granularity,
>> +                                  Error **errp)
>> +{
>> +    BDRVQcow2State *s = bs->opaque;
>> +    const char *reason = NULL;
>> +    bool found;
>> +    Qcow2BitmapList *bm_list;
>> +
>> +    if (check_constraints_on_bitmap(bs, name, granularity) != 0) {
>> +        reason = "it doesn't satisfy the constraints";
>> +        goto common_errp;
>> +    }
>> +
>> +    if (s->nb_bitmaps == 0) {
>> +        return true;
>> +    }
>> +
>> +    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
>> +                               s->bitmap_directory_size, errp);
> Maybe it would make sense to keep the bitmap list in memory...
>
>> +    if (bm_list == NULL) {
>> +        return false;
>> +    }
>> +
>> +    found = !!find_bitmap_by_name(bm_list, name);
> You can omit the !!, storing it in a bool will do that for you.
>
>> +    bitmap_list_free(bm_list);
>> +    if (found) {
>> +        reason = "bitmap with the same name is already stored";
>> +        goto common_errp;
>> +    }
>> +
>> +    return true;
>> +
>> +common_errp:
>> +    error_setg(errp, "Can't make bitmap '%s' persistent in '%s', as %s.",
>> +               name, bdrv_get_device_or_node_name(bs), reason);
> Hm, so this function isn't for checking whether a bitmap can be stored,
> but whether it can be made persistent. That's a difference; you can
> store a bitmap of the same name in the file if you want to overwrite it
> (i.e. it's an auto-load bitmap), but you cannot create a new bitmap with
> the same name.
>
> Maybe rename it from bdrv_can_store_dirty_bitmap to
> bdrv_can_store_new_dirty_bitmap?

Yes, I'll rename it.

>
> Max
>
>> +    return false;
>> +}
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 66c7f74..cb9c2a2 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -3516,6 +3516,7 @@ BlockDriver bdrv_qcow2 = {
>>   
>>       .bdrv_load_autoloading_dirty_bitmaps = qcow2_load_autoloading_dirty_bitmaps,
>>       .bdrv_store_persistent_dirty_bitmaps = qcow2_store_persistent_dirty_bitmaps,
>> +    .bdrv_can_store_dirty_bitmap = qcow2_can_store_dirty_bitmap,
>>   };
>>   
>>   static void bdrv_qcow2_init(void)
>> diff --git a/block/qcow2.h b/block/qcow2.h
>> index d9a7643..e7a44a1 100644
>> --- a/block/qcow2.h
>> +++ b/block/qcow2.h
>> @@ -616,5 +616,9 @@ void qcow2_cache_put(BlockDriverState *bs, Qcow2Cache *c, void **table);
>>   /* qcow2-bitmap.c functions */
>>   void qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp);
>>   void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
>> +bool qcow2_can_store_dirty_bitmap(BlockDriverState *bs,
>> +                                  const char *name,
>> +                                  uint32_t granularity,
>> +                                  Error **errp);
>>   
>>   #endif
>>
>


-- 
Best regards,
Vladimir
