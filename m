Received: from eggs.gnu.org ([2001:4830:134:3::10]:46371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d80Ho-00077a-Rd
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:14:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d80Hn-0003Lk-Ty
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:14:24 -0400
Date: Tue, 9 May 2017 16:14:09 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170509081409.GA23466@lemon.lan>
References: <20170504173745.27414-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170504173745.27414-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: Simplify BDRV_BLOCK_RAW recursion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu, 05/04 12:37, Eric Blake wrote:
> Since we are already in coroutine context during the body of
> bdrv_co_get_block_status(), we can shave off a few layers of
> wrappers when recursing to query the protocol when a format driver
> returned BDRV_BLOCK_RAW.
> 
> Note that we are already using the correct recursion later on in
> the same function, when probing whether the protocol layer is sparse
> in order to find out if we can add BDRV_BLOCK_ZERO to an existing
> BDRV_BLOCK_DATA|BDRV_BLOCK_OFFSET_VALID.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/io.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index 40bd94f..fdd7485 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1784,8 +1784,8 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
> 
>      if (ret & BDRV_BLOCK_RAW) {
>          assert(ret & BDRV_BLOCK_OFFSET_VALID);
> -        ret = bdrv_get_block_status(*file, ret >> BDRV_SECTOR_BITS,
> -                                    *pnum, pnum, file);
> +        ret = bdrv_co_get_block_status(*file, ret >> BDRV_SECTOR_BITS,
> +                                       *pnum, pnum, file);
>          goto out;
>      }
> 
> -- 
> 2.9.3
> 
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
