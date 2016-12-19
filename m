Received: from eggs.gnu.org ([2001:4830:134:3::10]:46878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cJ0D5-0004iF-Cy
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 10:50:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cJ0D0-0000Dd-W1
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 10:50:43 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:31209 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cJ0D0-0000DQ-Hp
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 10:50:38 -0500
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
	<1479835586-74394-14-git-send-email-vsementsov@virtuozzo.com>
	<919ac9f1-cc7a-8679-c9f4-1da26bc27bf4@redhat.com>
	<6d72606d-7e76-8f53-ed5f-b37838666e1e@virtuozzo.com>
	<a8e92d90-b8d2-a26d-458e-82fd1f1a00dd@redhat.com>
	<f3e9d063-7f2e-8308-38cb-fc61e6e9fcce@virtuozzo.com>
	<de2ebda3-a6db-d9da-9514-e86e3d9afa86@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c6e6aeb3-75ab-670d-cf81-1320274ff62c@virtuozzo.com>
Date: Mon, 19 Dec 2016 18:50:22 +0300
MIME-Version: 1.0
In-Reply-To: <de2ebda3-a6db-d9da-9514-e86e3d9afa86@redhat.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/21] qcow2: add
 .bdrv_store_persistent_dirty_bitmaps()
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

19.12.2016 18:34, Max Reitz wrote:
> On 19.12.2016 16:26, Vladimir Sementsov-Ogievskiy wrote:
>> 19.12.2016 18:14, Max Reitz wrote:
>>> On 17.12.2016 15:58, Vladimir Sementsov-Ogievskiy wrote:
>>>> 09.12.2016 20:05, Max Reitz wrote:
>>>>> On 22.11.2016 18:26, Vladimir Sementsov-Ogievskiy wrote:
>>>>>> Realize block bitmap storing interface, to allow qcow2 images store
>>>>>> persistent bitmaps.
>>>>>>
>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>>>> ---
>>>>>>    block/qcow2-bitmap.c | 451
>>>>>> +++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>    block/qcow2.c        |   1 +
>>>> [...]
>>>>
>>>>>> +
>>>>>> +/* store_bitmap_data()
>>>>>> + * Store bitmap to image, filling bitmap table accordingly.
>>>>>> + */
>>>>>> +static uint64_t *store_bitmap_data(BlockDriverState *bs,
>>>>>> +                                   BdrvDirtyBitmap *bitmap,
>>>>>> +                                   uint32_t *bitmap_table_size,
>>>>>> Error **errp)
>>>>>> +{
>>>>>> +    int ret;
>>>>>> +    BDRVQcow2State *s = bs->opaque;
>>>>>> +    int64_t sector;
>>>>>> +    uint64_t dsc;
>>>>>> +    uint64_t bm_size = bdrv_dirty_bitmap_size(bitmap);
>>>>>> +    const char *bm_name = bdrv_dirty_bitmap_name(bitmap);
>>>>>> +    uint8_t *buf = NULL;
>>>>>> +    BdrvDirtyBitmapIter *dbi;
>>>>>> +    uint64_t *tb;
>>>>>> +    uint64_t tb_size =
>>>>>> +            size_to_clusters(s,
>>>>>> +                bdrv_dirty_bitmap_serialization_size(bitmap, 0,
>>>>>> bm_size));
>>>>>> +
>>>>>> +    if (tb_size > BME_MAX_TABLE_SIZE ||
>>>>>> +            tb_size * s->cluster_size > BME_MAX_PHYS_SIZE) {
>>>>> Alignment to the opening parenthesis, please.
>>>>>
>>>>>> +        error_setg(errp, "Bitmap '%s' is too big", bm_name);
>>>>>> +        return NULL;
>>>>>> +    }
>>>>>> +
>>>>>> +    tb = g_try_new0(uint64_t, tb_size);
>>>>>> +    if (tb == NULL) {
>>>>>> +        error_setg(errp, "No memory");
>>>>>> +        return NULL;
>>>>>> +    }
>>>>>> +
>>>>>> +    dbi = bdrv_dirty_iter_new(bitmap, 0);
>>>>>> +    buf = g_malloc(s->cluster_size);
>>>>>> +    dsc = disk_sectors_in_bitmap_cluster(s, bitmap);
>>>>>> +
>>>>>> +    while ((sector = bdrv_dirty_iter_next(dbi)) != -1) {
>>>>>> +        uint64_t cluster = sector / dsc;
>>>>>> +        uint64_t end, write_size;
>>>>>> +        int64_t off;
>>>>>> +
>>>>>> +        sector = cluster * dsc;
>>>>>> +        end = MIN(bm_size, sector + dsc);
>>>>>> +        write_size =
>>>>>> +            bdrv_dirty_bitmap_serialization_size(bitmap, sector,
>>>>>> end - sector);
>>>>>> +
>>>>>> +        off = qcow2_alloc_clusters(bs, s->cluster_size);
>>>>>> +        if (off < 0) {
>>>>>> +            error_setg_errno(errp, -off,
>>>>>> +                             "Failed to allocate clusters for
>>>>>> bitmap '%s'",
>>>>>> +                             bm_name);
>>>>>> +            goto fail;
>>>>>> +        }
>>>>>> +        tb[cluster] = off;
>>>>> Somehow I would feel better with either an assert(cluster < tb_size);
>>>>> here or an assert(bdrv_nb_sectors(bs) / dsc == tb_size); (plus the
>>>>> error
>>>>> handling for bdrv_nb_sectors()) above the loop.
>>>> assert((bm_size - 1) / dsc == tb_size - 1) seems ok. and no additional
>>>> error handling. Right?
>>> Right, bm_size is already equal to bdrv_nb_sectors(bs), and it's not
>>> necessarily a multiple of dsc. So that should be good. Alternatively, I
>>> think the following would be slightly easier to read:
>>>
>>> assert(DIV_ROUND_UP(bm_size, dsc) == tb_size);
>>>
>>>>>> +
>>>>>> +        bdrv_dirty_bitmap_serialize_part(bitmap, buf, sector, end
>>>>>> - sector);
>>>>>> +        if (write_size < s->cluster_size) {
>>>>>> +            memset(buf + write_size, 0, s->cluster_size -
>>>>>> write_size);
>>>>>> +        }
>>>>> Should we assert that write_size <= s->cluster_size?
>>>> Ok
>>>>
>>>> [...].
>>>>
>>>>>> +        const char *name = bdrv_dirty_bitmap_name(bitmap);
>>>>>> +        uint32_t granularity = bdrv_dirty_bitmap_granularity(bitmap);
>>>>>> +        Qcow2Bitmap *bm;
>>>>>> +
>>>>>> +        if (!bdrv_dirty_bitmap_get_persistance(bitmap)) {
>>>>>> +            continue;
>>>>>> +        }
>>>>>> +
>>>>>> +        if (++new_nb_bitmaps > QCOW2_MAX_BITMAPS) {
>>>>>> +            error_setg(errp, "Too many persistent bitmaps");
>>>>>> +            goto fail;
>>>>>> +        }
>>>>>> +
>>>>>> +        new_dir_size += calc_dir_entry_size(strlen(name), 0);
>>>>>> +        if (new_dir_size > QCOW2_MAX_BITMAP_DIRECTORY_SIZE) {
>>>>>> +            error_setg(errp, "Too large bitmap directory");
>>>>>> +            goto fail;
>>>>>> +        }
>>>>> You only need to increment new_nb_bitmaps and increase new_dir_size if
>>>>> the bitmap does not already exist in the image (i.e. if
>>>>> find_bitmap_by_name() below returns NULL).
>>>> Why? No, I need to check the whole sum and the whole size.
>>> If the bitmap already exists, you don't create a new directory entry but
>>> reuse the existing one. Therefore, the number of bitmaps in the image
>>> and the directory size will not grow then.
>> new_nb_bitmaps is not number of "newly created bitmaps", but just new
>> value of field nb_bitmaps, so, all bitmaps - old and new are calculated
>> into new_nb_bitmaps. Anyway, this misunderstanding shows that variable
>> name is bad..
> Yes. But when you store a bitmap of the same name as an existing one,
> you are replacing it. The number of bitmaps does not grow in that case.

Oh, I'm stupid)) I see now, you are right.

>
> Max
>


-- 
Best regards,
Vladimir
