Received: from eggs.gnu.org ([2001:4830:134:3::10]:34295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dqJK7-0006uI-6X
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:27:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dqJK6-0001kM-8w
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:27:55 -0400
Date: Fri, 8 Sep 2017 15:27:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170908132741.GJ3283@localhost.localdomain>
References: <20170830210542.2153-1-eblake@redhat.com>
	<20170830210542.2153-17-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830210542.2153-17-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 16/18] qcow2: Switch store_bitmap_data()
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

Am 30.08.2017 um 23:05 hat Eric Blake geschrieben:
> Now that we have adjusted the majority of the calls this function
> makes to be byte-based, it is easier to read the code if it makes
> passes over the image using bytes rather than sectors.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> ---
> v5: no change
> v4: new patch
> ---
>  block/qcow2-bitmap.c | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index b807298484..63d845e35f 100644
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
> -    while ((sector = bdrv_dirty_iter_next(dbi) >> BDRV_SECTOR_BITS) != -1) {
> -        uint64_t cluster = sector / sbc;
> +    while ((offset = bdrv_dirty_iter_next(dbi)) != -1) {

Don't you have to multiply both sides of the equation? This would be
offset != -512, which points out that the previous patch to convert
bdrv_dirty_iter_next() to byte-based gave it a really awkward interface.

> +        uint64_t cluster = offset / limit;
>          uint64_t end, write_size;
>          int64_t off;
> 
> -        sector = cluster * sbc;
> -        end = MIN(bm_sectors, sector + sbc);
> -        write_size = bdrv_dirty_bitmap_serialization_size(bitmap,
> -            sector * BDRV_SECTOR_SIZE, (end - sector) * BDRV_SECTOR_SIZE);
> +        offset = cluster * limit;

You just had cluster = offset / limit, so in other words, align down
offset? If so, this is how it should be written.

Kevin
