Received: from eggs.gnu.org ([2001:4830:134:3::10]:48600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cySZx-0003pi-VN
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 20:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cySZw-0006A1-8z
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 20:25:41 -0400
References: <20170412174920.8744-1-eblake@redhat.com>
	<20170412174920.8744-9-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <3eaa3c7a-1581-8d2d-a385-3400d434b3fe@redhat.com>
Date: Wed, 12 Apr 2017 20:25:27 -0400
MIME-Version: 1.0
In-Reply-To: <20170412174920.8744-9-eblake@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/12] dirty-bitmap: Change
 bdrv_get_dirty() to take bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, Jeff Cody <jcody@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 04/12/2017 01:49 PM, Eric Blake wrote:
> Half the callers were already scaling bytes to sectors; the other
> half can eventually be simplified to use byte iteration.  Both
> callers were already using the result as a bool, so make that
> explicit.  Making the change also makes it easier for a future
> dirty-bitmap patch to offload scaling over to the internal hbitmap.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  include/block/dirty-bitmap.h | 4 ++--
>  block/dirty-bitmap.c         | 8 ++++----
>  block/mirror.c               | 3 +--
>  migration/block.c            | 3 +--
>  4 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
> index efcec60..b8434e5 100644
> --- a/include/block/dirty-bitmap.h
> +++ b/include/block/dirty-bitmap.h
> @@ -34,8 +34,8 @@ bool bdrv_dirty_bitmap_enabled(BdrvDirtyBitmap *bitmap);
>  bool bdrv_dirty_bitmap_frozen(BdrvDirtyBitmap *bitmap);
>  const char *bdrv_dirty_bitmap_name(const BdrvDirtyBitmap *bitmap);
>  DirtyBitmapStatus bdrv_dirty_bitmap_status(BdrvDirtyBitmap *bitmap);
> -int bdrv_get_dirty(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
> -                   int64_t sector);
> +bool bdrv_get_dirty(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
> +                    int64_t offset);
>  void bdrv_set_dirty_bitmap(BdrvDirtyBitmap *bitmap,
>                             int64_t cur_sector, int64_t nr_sectors);
>  void bdrv_reset_dirty_bitmap(BdrvDirtyBitmap *bitmap,
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index e3c2e34..c8100d2 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -332,13 +332,13 @@ BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs)
>      return list;
>  }
> 
> -int bdrv_get_dirty(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
> -                   int64_t sector)
> +bool bdrv_get_dirty(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
> +                    int64_t offset)
>  {
>      if (bitmap) {
> -        return hbitmap_get(bitmap->bitmap, sector);
> +        return hbitmap_get(bitmap->bitmap, offset >> BDRV_SECTOR_BITS);
>      } else {
> -        return 0;
> +        return false;
>      }
>  }
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index 1b98a77..1e2e655 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -359,8 +359,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
>          int64_t next_offset = offset + nb_chunks * s->granularity;
>          int64_t next_chunk = next_offset / s->granularity;
>          if (next_offset >= s->bdev_length ||
> -            !bdrv_get_dirty(source, s->dirty_bitmap,
> -                            next_offset >> BDRV_SECTOR_BITS)) {
> +            !bdrv_get_dirty(source, s->dirty_bitmap, next_offset)) {
>              break;
>          }
>          if (test_bit(next_chunk, s->in_flight_bitmap)) {
> diff --git a/migration/block.c b/migration/block.c
> index 3daa5c7..9e21aeb 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -537,8 +537,7 @@ static int mig_save_device_dirty(QEMUFile *f, BlkMigDevState *bmds,
>          } else {
>              blk_mig_unlock();
>          }
> -        if (bdrv_get_dirty(bs, bmds->dirty_bitmap, sector)) {
> -
> +        if (bdrv_get_dirty(bs, bmds->dirty_bitmap, sector * BDRV_SECTOR_SIZE)) {

This one is a little weirder now though, isn't it? We're asking for the
dirty status of a single byte, technically. In practice, the scaling
factor will always cover the entire sector, but it reads a lot jankier now.

>              if (total_sectors - sector < BDRV_SECTORS_PER_DIRTY_CHUNK) {
>                  nr_sectors = total_sectors - sector;
>              } else {
> 

Oh well, it was always janky...

Reviewed-by: John Snow <jsnow@redhat.com>
