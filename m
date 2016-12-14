Received: from eggs.gnu.org ([2001:4830:134:3::10]:41805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cHBtl-0007DC-KI
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:55:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cHBti-0003mD-Fx
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:55:17 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:38567 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cHBti-0003lM-1g
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:55:14 -0500
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
	<1479835586-74394-10-git-send-email-vsementsov@virtuozzo.com>
	<2e03e805-9226-fdc7-7069-814c1346edd2@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <81adfcb0-77cf-2370-6aca-0b9bcfe5ca0a@virtuozzo.com>
Date: Wed, 14 Dec 2016 18:54:54 +0300
MIME-Version: 1.0
In-Reply-To: <2e03e805-9226-fdc7-7069-814c1346edd2@redhat.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/21] qcow2: add
 .bdrv_load_autoloading_dirty_bitmaps
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

07.12.2016 23:51, Max Reitz wrote:
> On 22.11.2016 18:26, Vladimir Sementsov-Ogievskiy wrote:
>> Auto loading bitmaps are bitmaps in Qcow2, with the AUTO flag set. They
>> are loaded when the image is opened and become BdrvDirtyBitmaps for the
>> corresponding drive.
>>
>> Extra data in bitmaps is not supported for now.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/Makefile.objs  |   2 +-
>>   block/qcow2-bitmap.c | 663 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   block/qcow2.c        |   2 +
>>   block/qcow2.h        |   3 +
>>   4 files changed, 669 insertions(+), 1 deletion(-)
>>   create mode 100644 block/qcow2-bitmap.c
>>
> [...]
>
>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>> new file mode 100644
>> index 0000000..0f797e6
>> --- /dev/null
>> +++ b/block/qcow2-bitmap.c
>> @@ -0,0 +1,663 @@
> [...]
>
>> +/* Check table entry specification constraints. If cluster_size is 0, offset
>> + * alignment is not checked. */
>> +static int check_table_entry(uint64_t entry, int cluster_size)
>> +{
>> +    uint64_t offset;
>> +
>> +    if (entry & BME_TABLE_ENTRY_RESERVED_MASK) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    offset = entry & BME_TABLE_ENTRY_OFFSET_MASK;
>> +    if (offset != 0) {
>> +        /* if offset specified, bit 0 must is reserved */
> -must
>
>> +        if (entry & 1) {
>> +            return -EINVAL;
>> +        }
>> +
>> +        if ((cluster_size != 0) && (entry % cluster_size != 0)) {
> Why would cluster_size be 0? Also, shouldn't it be offset instead of entry?

the comment says: "If cluster_size is 0, offset alignment is not checked"
yes, should be offset.

>
>> +            return -EINVAL;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
> [...]
>
>> +/* bitmap table entries must satisfy specification constraints */
>> +static int load_bitmap_data(BlockDriverState *bs,
>> +                            const uint64_t *bitmap_table,
>> +                            uint32_t bitmap_table_size,
>> +                            BdrvDirtyBitmap *bitmap)
>> +{
>> +    int ret = 0;
>> +    BDRVQcow2State *s = bs->opaque;
>> +    uint64_t sector, dsc;
>> +    uint64_t bm_size = bdrv_dirty_bitmap_size(bitmap);
>> +    uint8_t *buf = NULL;
>> +    uint64_t i, tab_size =
>> +            size_to_clusters(s,
>> +                bdrv_dirty_bitmap_serialization_size(bitmap, 0, bm_size));
>> +
>> +    if (tab_size != bitmap_table_size ||
>> +            tab_size > BME_MAX_TABLE_SIZE) {
> This line should be aligned to the opening parenthesis.
>
> [...]
>
>> +static int check_dir_entry(BlockDriverState *bs, Qcow2BitmapDirEntry *entry)
>> +{
>> +    BDRVQcow2State *s = bs->opaque;
>> +    uint64_t phys_bitmap_bytes =
>> +            (uint64_t)entry->bitmap_table_size * s->cluster_size;
>> +    uint64_t max_virtual_bits =
>> +            (phys_bitmap_bytes * 8) << entry->granularity_bits;
> I think this shift can overflow, even if bitmap_table_size, cluster_size
> and granularity_bits are all within their respective limits.

Hmm. But it can't, if phys_bitmap_bytes <= MAX_PHYS_SIZE. I can just 
move this calculation down.

>
>> +    int64_t nb_sectors = bdrv_nb_sectors(bs);
> Just using bdrv_getlength() would probably be simpler.
>
>> +
>> +    if (nb_sectors < 0) {
>> +        return nb_sectors;
>> +    }
>> +
>> +    int fail =
> I'd prefer a boolean.

and mixed definition/code)

>
>> +            (entry->bitmap_table_size == 0) ||
>> +            (entry->bitmap_table_offset == 0) ||
>> +            (entry->bitmap_table_offset % s->cluster_size) ||
>> +            (entry->bitmap_table_size > BME_MAX_TABLE_SIZE) ||
>> +            (phys_bitmap_bytes > BME_MAX_PHYS_SIZE) ||
>> +            (entry->bitmap_table_offset != 0 &&

hmm, can be dropped, as checked above

>> +                (nb_sectors << BDRV_SECTOR_BITS) > max_virtual_bits) ||
>> +            (entry->granularity_bits > BME_MAX_GRANULARITY_BITS) ||
>> +            (entry->granularity_bits < BME_MIN_GRANULARITY_BITS) ||
>> +            (entry->flags & BME_RESERVED_FLAGS) ||
>> +            (entry->name_size > BME_MAX_NAME_SIZE) ||
>> +            (entry->type != BT_DIRTY_TRACKING_BITMAP);
>> +
>> +    return fail ? -EINVAL : 0;
>> +}
> [...]
>
>> +/* bitmap_list_load
>> + * Get bitmap list from qcow2 image. Actually reads bitmap directory,
>> + * checks it and convert to bitmap list.
>> + */
>> +static Qcow2BitmapList *bitmap_list_load(BlockDriverState *bs, uint64_t offset,
>> +                                         uint64_t size, Error **errp)
>> +{
> [...]
>
>> +    bm_list = bitmap_list_new();
>> +    for (e = (Qcow2BitmapDirEntry *)dir;
>> +             e < (Qcow2BitmapDirEntry *)dir_end; e = next_dir_entry(e)) {
> This line should be aligned to the opening parenthesis.
>
> [...]
>
>> +
>> +/* bitmap_list_store
>> + * Store bitmap list to qcow2 image as a bitmap directory.
>> + * Everything is checked.
>> + */
>> +static int bitmap_list_store(BlockDriverState *bs, Qcow2BitmapList *bm_list,
>> +                             uint64_t *offset, uint64_t *size, bool in_place)
>> +{
> [...]
>
>> +fail:
>> +    g_free(dir);
>> +
>> +    if (dir_offset > 0) {
>> +        qcow2_free_clusters(bs, dir_offset, dir_size, QCOW2_DISCARD_OTHER);
> I think this should only be freed if in_place is false.

Reasonable.. And this also leads me to the think that we should clear 
autoclear bit in the header before inplace updating of bitmap directory 
and set it after successful update.

>
> Max
>
>> +    }
>> +
>> +    return ret;
>> +}


-- 
Best regards,
Vladimir
