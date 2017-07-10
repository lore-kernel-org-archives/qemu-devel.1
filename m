Received: from eggs.gnu.org ([2001:4830:134:3::10]:45183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dUWw1-0002yp-9n
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 07:33:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dUWw0-0001F3-Db
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 07:33:01 -0400
Date: Mon, 10 Jul 2017 19:32:47 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170710113247.GC19707@lemon.lan>
References: <20170629132749.997-1-pbonzini@redhat.com>
	<20170629132749.997-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170629132749.997-5-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/11] vpc: make it thread-safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com

On Thu, 06/29 15:27, Paolo Bonzini wrote:
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/vpc.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/block/vpc.c b/block/vpc.c
> index 4240ba9d1c..0ff686540a 100644
> --- a/block/vpc.c
> +++ b/block/vpc.c
> @@ -496,12 +496,6 @@ static inline int64_t get_image_offset(BlockDriverState *bs, uint64_t offset,
>      return block_offset;
>  }
>  
> -static inline int64_t get_sector_offset(BlockDriverState *bs,
> -                                        int64_t sector_num, bool write)
> -{
> -    return get_image_offset(bs, sector_num * BDRV_SECTOR_SIZE, write);
> -}
> -
>  /*
>   * Writes the footer to the end of the image file. This is needed when the
>   * file grows as it overwrites the old footer
> @@ -696,6 +690,7 @@ static int64_t coroutine_fn vpc_co_get_block_status(BlockDriverState *bs,
>      VHDFooter *footer = (VHDFooter*) s->footer_buf;
>      int64_t start, offset;
>      bool allocated;
> +    int64_t ret;
>      int n;
>  
>      if (be32_to_cpu(footer->type) == VHD_FIXED) {
> @@ -705,10 +700,13 @@ static int64_t coroutine_fn vpc_co_get_block_status(BlockDriverState *bs,
>                 (sector_num << BDRV_SECTOR_BITS);
>      }
>  
> -    offset = get_sector_offset(bs, sector_num, 0);
> +    qemu_co_mutex_lock(&s->lock);
> +
> +    offset = get_image_offset(bs, sector_num << BDRV_SECTOR_BITS, 0);

You used false instead of 0 in v1 which was better, so this is a regression. :)

Can be fixed when applying.

>      start = offset;
>      allocated = (offset != -1);
>      *pnum = 0;
> +    ret = 0;
>  
>      do {
>          /* All sectors in a block are contiguous (without using the bitmap) */
> @@ -723,15 +721,17 @@ static int64_t coroutine_fn vpc_co_get_block_status(BlockDriverState *bs,
>           * sectors since there is always a bitmap in between. */
>          if (allocated) {
>              *file = bs->file->bs;
> -            return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID | start;
> +            ret = BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID | start;
> +            break;
>          }
>          if (nb_sectors == 0) {
>              break;
>          }
> -        offset = get_sector_offset(bs, sector_num, 0);
> +        offset = get_image_offset(bs, sector_num << BDRV_SECTOR_BITS, 0);

Ditto.

>      } while (offset == -1);
>  
> -    return 0;
> +    qemu_co_mutex_unlock(&s->lock);
> +    return ret;
>  }
>  
>  /*
> -- 
> 2.13.0
> 
> 
> 

Fam
