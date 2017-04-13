Received: from eggs.gnu.org ([2001:4830:134:3::10]:59290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cyTZG-0004cs-5P
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 21:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cyTZF-0007Ea-41
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 21:29:02 -0400
References: <20170412174920.8744-1-eblake@redhat.com>
	<20170412174920.8744-12-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <0ff87f4c-d1be-08ad-291c-c844b9dc53ab@redhat.com>
Date: Wed, 12 Apr 2017 21:28:49 -0400
MIME-Version: 1.0
In-Reply-To: <20170412174920.8744-12-eblake@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/12] dirty-bitmap: Switch
 bdrv_set_dirty() to bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 04/12/2017 01:49 PM, Eric Blake wrote:
> Both callers already had bytes available, but were scaling to
> sectors.  Move the scaling to internal code.  In the case of
> bdrv_aligned_pwritev(), we are now passing the exact offset
> rather than a rounded sector-aligned value, but that's okay
> as long as dirty bitmap widens start/bytes to granularity
> boundaries.

Yes, that shouldn't be a problem. Granularity math will make sure this
comes out in the wash.

> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  include/block/block_int.h | 2 +-
>  block/dirty-bitmap.c      | 8 +++++---
>  block/io.c                | 6 ++----
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 08063c1..0b737fd 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -917,7 +917,7 @@ void blk_dev_eject_request(BlockBackend *blk, bool force);
>  bool blk_dev_is_tray_open(BlockBackend *blk);
>  bool blk_dev_is_medium_locked(BlockBackend *blk);
> 
> -void bdrv_set_dirty(BlockDriverState *bs, int64_t cur_sector, int64_t nr_sect);
> +void bdrv_set_dirty(BlockDriverState *bs, int64_t offset, int64_t bytes);
>  bool bdrv_requests_pending(BlockDriverState *bs);
> 
>  void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out);
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index 8e7822c..ef165eb 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -478,15 +478,17 @@ void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap)
>      hbitmap_deserialize_finish(bitmap->bitmap);
>  }
> 
> -void bdrv_set_dirty(BlockDriverState *bs, int64_t cur_sector,
> -                    int64_t nr_sectors)
> +void bdrv_set_dirty(BlockDriverState *bs, int64_t offset, int64_t bytes)
>  {
>      BdrvDirtyBitmap *bitmap;
> +    int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
> +
>      QLIST_FOREACH(bitmap, &bs->dirty_bitmaps, list) {
>          if (!bdrv_dirty_bitmap_enabled(bitmap)) {
>              continue;
>          }
> -        hbitmap_set(bitmap->bitmap, cur_sector, nr_sectors);
> +        hbitmap_set(bitmap->bitmap, offset >> BDRV_SECTOR_BITS,
> +                    end_sector - (offset >> BDRV_SECTOR_BITS));

Well, that's worse, but luckily you've got more patches. :)

>      }
>  }
> 
> diff --git a/block/io.c b/block/io.c
> index 9218329..d22d35f 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1328,7 +1328,6 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
>      bool waited;
>      int ret;
> 
> -    int64_t start_sector = offset >> BDRV_SECTOR_BITS;
>      int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
>      uint64_t bytes_remaining = bytes;
>      int max_transfer;
> @@ -1407,7 +1406,7 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
>      bdrv_debug_event(bs, BLKDBG_PWRITEV_DONE);
> 
>      ++bs->write_gen;
> -    bdrv_set_dirty(bs, start_sector, end_sector - start_sector);
> +    bdrv_set_dirty(bs, offset, bytes);
> 
>      if (bs->wr_highest_offset < offset + bytes) {
>          bs->wr_highest_offset = offset + bytes;
> @@ -2535,8 +2534,7 @@ int coroutine_fn bdrv_co_pdiscard(BlockDriverState *bs, int64_t offset,
>      ret = 0;
>  out:
>      ++bs->write_gen;
> -    bdrv_set_dirty(bs, req.offset >> BDRV_SECTOR_BITS,
> -                   req.bytes >> BDRV_SECTOR_BITS);
> +    bdrv_set_dirty(bs, req.offset, req.bytes);
>      tracked_request_end(&req);
>      bdrv_dec_in_flight(bs);
>      return ret;
> 

Reviewed-by: John Snow <jsnow@redhat.com>
