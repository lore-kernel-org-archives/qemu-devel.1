Received: from eggs.gnu.org ([2001:4830:134:3::10]:35275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dvj7S-0007c3-1T
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 08:01:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dvj7N-0003kQ-1z
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 08:01:14 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:10524 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dvj7M-0003jf-Hx
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 08:01:09 -0400
References: <20170919201910.25656-1-eblake@redhat.com>
	<20170919201910.25656-19-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <adbf43e8-1dda-ad5e-4b98-03d148a4e3a4@virtuozzo.com>
Date: Sat, 23 Sep 2017 15:01:01 +0300
MIME-Version: 1.0
In-Reply-To: <20170919201910.25656-19-eblake@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 18/20] qcow2: Switch store_bitmap_data()
 to byte-based iteration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

19.09.2017 23:19, Eric Blake wrote:
> Now that we have adjusted the majority of the calls this function
> makes to be byte-based, it is easier to read the code if it makes
> passes over the image using bytes rather than sectors.
>
> iotests 165 was rather weak - on a default 64k-cluster image, where
> bitmap granularity also defaults to 64k bytes, a single cluster of
> the bitmap table thus covers (64*1024*8) bits which each cover 64k
> bytes, or 32G of image space.  But the test only uses a 1G image,
> so it cannot trigger any more than one loop of the code in
> store_bitmap_data(); and it was writing to the first cluster.  In
> order to test that we are properly aligning which portions of the
> bitmap are being written to the file, we really want to test a case
> where the first dirty bit returned by bdrv_dirty_iter_next() is not
> aligned to the start of a cluster, which we can do by modifying the
> test to write data that doesn't happen to fall in the first cluster
> of the image.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy<vsementsov@virtuozzo.com>



>
> ---
> v9: update iotests to show why aligning down is needed [Kevin], R-b dropped
> v8: no change
> v7: rebase to earlier change, make rounding of offset obvious (no semantic
> change, so R-b kept) [Kevin]
> v5-v6: no change
> v4: new patch
> ---
>   block/qcow2-bitmap.c   | 31 ++++++++++++++++---------------
>   tests/qemu-iotests/165 |  2 +-
>   2 files changed, 17 insertions(+), 16 deletions(-)
>
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index 692ce0de88..df957c66d5 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -1072,10 +1072,9 @@ static uint64_t *store_bitmap_data(BlockDriverState *bs,
>   {
>       int ret;
>       BDRVQcow2State *s = bs->opaque;
> -    int64_t sector;
> -    uint64_t limit, sbc;
> +    int64_t offset;
> +    uint64_t limit;
>       uint64_t bm_size = bdrv_dirty_bitmap_size(bitmap);
> -    uint64_t bm_sectors = DIV_ROUND_UP(bm_size, BDRV_SECTOR_SIZE);
>       const char *bm_name = bdrv_dirty_bitmap_name(bitmap);
>       uint8_t *buf = NULL;
>       BdrvDirtyBitmapIter *dbi;
> @@ -1100,18 +1099,22 @@ static uint64_t *store_bitmap_data(BlockDriverState *bs,
>       dbi = bdrv_dirty_iter_new(bitmap);
>       buf = g_malloc(s->cluster_size);
>       limit = bytes_covered_by_bitmap_cluster(s, bitmap);
> -    sbc = limit >> BDRV_SECTOR_BITS;
>       assert(DIV_ROUND_UP(bm_size, limit) == tb_size);
>
> -    while ((sector = bdrv_dirty_iter_next(dbi) >> BDRV_SECTOR_BITS) >= 0) {
> -        uint64_t cluster = sector / sbc;
> +    while ((offset = bdrv_dirty_iter_next(dbi)) >= 0) {
> +        uint64_t cluster = offset / limit;
>           uint64_t end, write_size;
>           int64_t off;
>
> -        sector = cluster * sbc;
> -        end = MIN(bm_sectors, sector + sbc);
> -        write_size = bdrv_dirty_bitmap_serialization_size(bitmap,
> -            sector * BDRV_SECTOR_SIZE, (end - sector) * BDRV_SECTOR_SIZE);
> +        /*
> +         * We found the first dirty offset, but want to write out the
> +         * entire cluster of the bitmap that includes that offset,
> +         * including any leading zero bits.
> +         */
> +        offset = QEMU_ALIGN_DOWN(offset, limit);
> +        end = MIN(bm_size, offset + limit);
> +        write_size = bdrv_dirty_bitmap_serialization_size(bitmap, offset,
> +                                                          end - offset);
>           assert(write_size <= s->cluster_size);
>
>           off = qcow2_alloc_clusters(bs, s->cluster_size);
> @@ -1123,9 +1126,7 @@ static uint64_t *store_bitmap_data(BlockDriverState *bs,
>           }
>           tb[cluster] = off;
>
> -        bdrv_dirty_bitmap_serialize_part(bitmap, buf,
> -                                         sector * BDRV_SECTOR_SIZE,
> -                                         (end - sector) * BDRV_SECTOR_SIZE);
> +        bdrv_dirty_bitmap_serialize_part(bitmap, buf, offset, end - offset);
>           if (write_size < s->cluster_size) {
>               memset(buf + write_size, 0, s->cluster_size - write_size);
>           }
> @@ -1143,11 +1144,11 @@ static uint64_t *store_bitmap_data(BlockDriverState *bs,
>               goto fail;
>           }
>
> -        if (end >= bm_sectors) {
> +        if (end >= bm_size) {
>               break;
>           }
>
> -        bdrv_set_dirty_iter(dbi, end * BDRV_SECTOR_SIZE);
> +        bdrv_set_dirty_iter(dbi, end);
>       }
>
>       *bitmap_table_size = tb_size;
> diff --git a/tests/qemu-iotests/165 b/tests/qemu-iotests/165
> index 74d7b79a0b..a3932db3de 100755
> --- a/tests/qemu-iotests/165
> +++ b/tests/qemu-iotests/165
> @@ -27,7 +27,7 @@ disk = os.path.join(iotests.test_dir, 'disk')
>   disk_size = 0x40000000 # 1G
>
>   # regions for qemu_io: (start, count) in bytes
> -regions1 = ((0,        0x100000),
> +regions1 = ((0x0fff00, 0x10000),
>               (0x200000, 0x100000))
>
>   regions2 = ((0x10000000, 0x20000),


-- 
Best regards,
Vladimir
