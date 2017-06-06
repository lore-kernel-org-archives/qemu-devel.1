Received: from eggs.gnu.org ([2001:4830:134:3::10]:53993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dI4ZB-0002e5-4u
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:49:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dI4ZA-0002NX-3S
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:49:57 -0400
Date: Tue, 6 Jun 2017 10:49:46 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170606024946.GA29860@lemon.lan>
References: <20170605203845.24351-1-eblake@redhat.com>
	<20170605203845.24351-4-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170605203845.24351-4-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 3/4] block: Simplify use of
 BDRV_BLOCK_RAW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, jsnow@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On Mon, 06/05 15:38, Eric Blake wrote:
> The lone caller that cares about a return of BDRV_BLOCK_RAW
> (namely, io.c:bdrv_co_get_block_status) completely replaces the
> return value, so there is no point in passing BDRV_BLOCK_DATA.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v3: further document BDRV_BLOCK_RAW
> v2: fix subject, tweak commit message
> ---
>  include/block/block.h | 6 +++---
>  block/commit.c        | 2 +-
>  block/mirror.c        | 2 +-
>  block/raw-format.c    | 2 +-
>  block/vpc.c           | 2 +-
>  5 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/block/block.h b/include/block/block.h
> index 9b355e9..0a60444 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -131,9 +131,9 @@ typedef struct HDGeometry {
>   *                       layer (short for DATA || ZERO), set by block layer
>   *
>   * Internal flag:
> - * BDRV_BLOCK_RAW: used internally to indicate that the request was
> - *                 answered by a passthrough driver such as raw and that the
> - *                 block layer should recompute the answer from bs->file.
> + * BDRV_BLOCK_RAW: for use by passthrough drivers, such as raw, to request
> + *                 that the block layer recompute the answer from the returned
> + *                 BDS; must be accompanied by just BDRV_BLOCK_OFFSET_VALID.
>   *
>   * If BDRV_BLOCK_OFFSET_VALID is set, bits 9-62 (BDRV_BLOCK_OFFSET_MASK)
>   * represent the offset in the returned BDS that is allocated for the
> diff --git a/block/commit.c b/block/commit.c
> index a3028b2..f56745b 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -239,7 +239,7 @@ static int64_t coroutine_fn bdrv_commit_top_get_block_status(
>  {
>      *pnum = nb_sectors;
>      *file = bs->backing->bs;
> -    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID | BDRV_BLOCK_DATA |
> +    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
>             (sector_num << BDRV_SECTOR_BITS);
>  }
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index a2a9703..892d53a 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -1052,7 +1052,7 @@ static int64_t coroutine_fn bdrv_mirror_top_get_block_status(
>  {
>      *pnum = nb_sectors;
>      *file = bs->backing->bs;
> -    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID | BDRV_BLOCK_DATA |
> +    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
>             (sector_num << BDRV_SECTOR_BITS);
>  }
> 
> diff --git a/block/raw-format.c b/block/raw-format.c
> index 36e6503..1136eba 100644
> --- a/block/raw-format.c
> +++ b/block/raw-format.c
> @@ -259,7 +259,7 @@ static int64_t coroutine_fn raw_co_get_block_status(BlockDriverState *bs,
>      *pnum = nb_sectors;
>      *file = bs->file->bs;
>      sector_num += s->offset / BDRV_SECTOR_SIZE;
> -    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID | BDRV_BLOCK_DATA |
> +    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
>             (sector_num << BDRV_SECTOR_BITS);
>  }
> 
> diff --git a/block/vpc.c b/block/vpc.c
> index 4240ba9..b313c68 100644
> --- a/block/vpc.c
> +++ b/block/vpc.c
> @@ -701,7 +701,7 @@ static int64_t coroutine_fn vpc_co_get_block_status(BlockDriverState *bs,
>      if (be32_to_cpu(footer->type) == VHD_FIXED) {
>          *pnum = nb_sectors;
>          *file = bs->file->bs;
> -        return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID | BDRV_BLOCK_DATA |
> +        return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
>                 (sector_num << BDRV_SECTOR_BITS);
>      }
> 
> -- 
> 2.9.4
> 
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
