Received: from eggs.gnu.org ([2001:4830:134:3::10]:41673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1duHtN-0007z5-1u
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:44:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1duHtG-00077K-Td
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:44:45 -0400
Date: Tue, 19 Sep 2017 14:44:24 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170919124424.GD3789@localhost.localdomain>
References: <20170918185819.5984-1-eblake@redhat.com>
	<20170918185819.5984-19-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170918185819.5984-19-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 18/20] qcow2: Switch store_bitmap_data()
 to byte-based iteration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 18.09.2017 um 20:58 hat Eric Blake geschrieben:
> Now that we have adjusted the majority of the calls this function
> makes to be byte-based, it is easier to read the code if it makes
> passes over the image using bytes rather than sectors.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> ---
> v7: rebase to earlier change, make rounding of offset obvious (no semantic
> change, so R-b kept) [Kevin]
> v5-v6: no change
> v4: new patch
> ---
>  block/qcow2-bitmap.c | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index 692ce0de88..302fffd6e1 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -1072,10 +1072,9 @@ static uint64_t *store_bitmap_data(BlockDriverState *bs,
>  {
>      int ret;
>      BDRVQcow2State *s = bs->opaque;
> -    int64_t sector;
> -    uint64_t limit, sbc;
> +    int64_t offset;
> +    uint64_t limit;
>      uint64_t bm_size = bdrv_dirty_bitmap_size(bitmap);
> -    uint64_t bm_sectors = DIV_ROUND_UP(bm_size, BDRV_SECTOR_SIZE);
>      const char *bm_name = bdrv_dirty_bitmap_name(bitmap);
>      uint8_t *buf = NULL;
>      BdrvDirtyBitmapIter *dbi;
> @@ -1100,18 +1099,17 @@ static uint64_t *store_bitmap_data(BlockDriverState *bs,
>      dbi = bdrv_dirty_iter_new(bitmap);
>      buf = g_malloc(s->cluster_size);
>      limit = bytes_covered_by_bitmap_cluster(s, bitmap);
> -    sbc = limit >> BDRV_SECTOR_BITS;
>      assert(DIV_ROUND_UP(bm_size, limit) == tb_size);
> 
> -    while ((sector = bdrv_dirty_iter_next(dbi) >> BDRV_SECTOR_BITS) >= 0) {
> -        uint64_t cluster = sector / sbc;
> +    while ((offset = bdrv_dirty_iter_next(dbi)) >= 0) {
> +        uint64_t cluster = offset / limit;
>          uint64_t end, write_size;
>          int64_t off;
> 
> -        sector = cluster * sbc;
> -        end = MIN(bm_sectors, sector + sbc);
> -        write_size = bdrv_dirty_bitmap_serialization_size(bitmap,
> -            sector * BDRV_SECTOR_SIZE, (end - sector) * BDRV_SECTOR_SIZE);
> +        offset = QEMU_ALIGN_DOWN(offset, limit);

With the question that I asked in v6, apart from changing the spelling
to be more explicit, I actually hoped that you would explain why
aligning down is the right thing to do.

It looks plausible to me that we can do this in correct code because we
don't support granularities < 512 bytes (a qemu restriction that is
written down as a note in the qcow2 spec).

The part that I'm missing yet is why we need to do it. The bitmap
granularity is also the granularity of bdrv_dirty_iter_next(), so isn't
offset already aligned and we could even assert that instead of aligning
down? (As long we enforce our restriction, which we seem to do in
bitmap_list_load().)

> +        end = MIN(bm_size, offset + limit);
> +        write_size = bdrv_dirty_bitmap_serialization_size(bitmap, offset,
> +                                                          end - offset);
>          assert(write_size <= s->cluster_size);
> 
>          off = qcow2_alloc_clusters(bs, s->cluster_size);

Kevin
