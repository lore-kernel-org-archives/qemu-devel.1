Received: from eggs.gnu.org ([2001:4830:134:3::10]:48623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ceq9m-00008c-Nc
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 16:33:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ceq9l-0003Sv-Pe
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 16:33:34 -0500
Date: Fri, 17 Feb 2017 16:33:25 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170217213325.GI19045@localhost.localdomain>
References: <1487349541-10201-1-git-send-email-pl@kamp.de>
	<1487349541-10201-2-git-send-email-pl@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487349541-10201-2-git-send-email-pl@kamp.de>
Subject: Re: [Qemu-devel] [PATCH 1/2] block/nfs: convert to preadv / pwritev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

On Fri, Feb 17, 2017 at 05:39:00PM +0100, Peter Lieven wrote:
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  block/nfs.c | 33 +++++++++++++++------------------
>  1 file changed, 15 insertions(+), 18 deletions(-)
> 
> diff --git a/block/nfs.c b/block/nfs.c
> index 689eaa7..ab5dcc2 100644
> --- a/block/nfs.c
> +++ b/block/nfs.c
> @@ -256,9 +256,9 @@ nfs_co_generic_cb(int ret, struct nfs_context *nfs, void *data,
>                              nfs_co_generic_bh_cb, task);
>  }
>  
> -static int coroutine_fn nfs_co_readv(BlockDriverState *bs,
> -                                     int64_t sector_num, int nb_sectors,
> -                                     QEMUIOVector *iov)
> +static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, uint64_t offset,
> +                                      uint64_t bytes, QEMUIOVector *iov,
> +                                      int flags)
>  {
>      NFSClient *client = bs->opaque;
>      NFSRPC task;
> @@ -267,9 +267,7 @@ static int coroutine_fn nfs_co_readv(BlockDriverState *bs,
>      task.iov = iov;
>  
>      if (nfs_pread_async(client->context, client->fh,
> -                        sector_num * BDRV_SECTOR_SIZE,
> -                        nb_sectors * BDRV_SECTOR_SIZE,
> -                        nfs_co_generic_cb, &task) != 0) {
> +                        offset, bytes, nfs_co_generic_cb, &task) != 0) {
>          return -ENOMEM;
>      }
>  
> @@ -290,9 +288,9 @@ static int coroutine_fn nfs_co_readv(BlockDriverState *bs,
>      return 0;
>  }
>  
> -static int coroutine_fn nfs_co_writev(BlockDriverState *bs,
> -                                        int64_t sector_num, int nb_sectors,
> -                                        QEMUIOVector *iov)
> +static int coroutine_fn nfs_co_pwritev(BlockDriverState *bs, uint64_t offset,
> +                                       uint64_t bytes, QEMUIOVector *iov,
> +                                       int flags)
>  {
>      NFSClient *client = bs->opaque;
>      NFSRPC task;
> @@ -300,17 +298,16 @@ static int coroutine_fn nfs_co_writev(BlockDriverState *bs,
>  
>      nfs_co_init_task(bs, &task);
>  
> -    buf = g_try_malloc(nb_sectors * BDRV_SECTOR_SIZE);
> -    if (nb_sectors && buf == NULL) {
> +    buf = g_try_malloc(bytes);
> +    if (bytes && buf == NULL) {
>          return -ENOMEM;
>      }
>  
> -    qemu_iovec_to_buf(iov, 0, buf, nb_sectors * BDRV_SECTOR_SIZE);
> +    qemu_iovec_to_buf(iov, 0, buf, bytes);
>  
>      if (nfs_pwrite_async(client->context, client->fh,
> -                         sector_num * BDRV_SECTOR_SIZE,
> -                         nb_sectors * BDRV_SECTOR_SIZE,
> -                         buf, nfs_co_generic_cb, &task) != 0) {
> +                         offset, bytes, buf,
> +                         nfs_co_generic_cb, &task) != 0) {
>          g_free(buf);
>          return -ENOMEM;
>      }
> @@ -322,7 +319,7 @@ static int coroutine_fn nfs_co_writev(BlockDriverState *bs,
>  
>      g_free(buf);
>  
> -    if (task.ret != nb_sectors * BDRV_SECTOR_SIZE) {
> +    if (task.ret != bytes) {
>          return task.ret < 0 ? task.ret : -EIO;
>      }
>  
> @@ -856,8 +853,8 @@ static BlockDriver bdrv_nfs = {
>      .bdrv_create                    = nfs_file_create,
>      .bdrv_reopen_prepare            = nfs_reopen_prepare,
>  
> -    .bdrv_co_readv                  = nfs_co_readv,
> -    .bdrv_co_writev                 = nfs_co_writev,
> +    .bdrv_co_preadv                 = nfs_co_preadv,
> +    .bdrv_co_pwritev                = nfs_co_pwritev,
>      .bdrv_co_flush_to_disk          = nfs_co_flush,
>  
>      .bdrv_detach_aio_context        = nfs_detach_aio_context,
> -- 
> 1.9.1
>

Reviewed-by: Jeff Cody <jcody@redhat.com>
