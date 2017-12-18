Received: from eggs.gnu.org ([2001:4830:134:3::10]:38967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eQuns-00013I-L3
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 07:45:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eQunr-0000sC-2J
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 07:45:56 -0500
References: <1513385953-5466-1-git-send-email-deepa.srinivasan@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <79fc13e1-244a-42b5-aa46-42f046a866eb@redhat.com>
Date: Mon, 18 Dec 2017 13:45:40 +0100
MIME-Version: 1.0
In-Reply-To: <1513385953-5466-1-git-send-email-deepa.srinivasan@oracle.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] block: Fix qemu crash when using
 scsi-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Deepa Srinivasan <deepa.srinivasan@oracle.com>, kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mark.kanda@oracle.com
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

On 16/12/2017 01:59, Deepa Srinivasan wrote:
> Starting qemu with the following arguments causes qemu to segfault:
> ... -device lsi,id=lsi0 -drive file=iscsi:<...>,format=raw,if=none,node-name=
> iscsi1 -device scsi-block,bus=lsi0.0,id=<...>,drive=iscsi1
> 
> This patch fixes blk_aio_ioctl() so it does not pass stack addresses to
> blk_aio_ioctl_entry() which may be invoked after blk_aio_ioctl() returns. More
> details about the bug follow.
> 
> blk_aio_ioctl() invokes blk_aio_prwv() with blk_aio_ioctl_entry as the
> coroutine parameter. blk_aio_prwv() ultimately calls aio_co_enter().
> 
> When blk_aio_ioctl() is executed from within a coroutine context (e.g.
> iscsi_bh_cb()), aio_co_enter() adds the coroutine (blk_aio_ioctl_entry) to
> the current coroutine's wakeup queue. blk_aio_ioctl() then returns.
> 
> When blk_aio_ioctl_entry() executes later, it accesses an invalid pointer:
> ....
>     BlkRwCo *rwco = &acb->rwco;
> 
>     rwco->ret = blk_co_ioctl(rwco->blk, rwco->offset,
>                              rwco->qiov->iov[0].iov_base);  <--- qiov is
>                                                                  invalid here
> ...
> 
> In the case when blk_aio_ioctl() is called from a non-coroutine context,
> blk_aio_ioctl_entry() executes immediately. But if bdrv_co_ioctl() calls
> qemu_coroutine_yield(), blk_aio_ioctl() will return. When the coroutine
> execution is complete, control returns to blk_aio_ioctl_entry() after the call
> to blk_co_ioctl(). There is no invalid reference after this point, but the
> function is still holding on to invalid pointers.
> 
> The fix is to change blk_aio_prwv() to accept a void pointer for the IO buffer
> rather than a QEMUIOVector. blk_aio_prwv() passes this through in BlkRwCo and the
> coroutine function casts it to QEMUIOVector or uses the void pointer directly.
> 
> Signed-off-by: Deepa Srinivasan <deepa.srinivasan@oracle.com>
> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
> ---
>  block/block-backend.c | 51 +++++++++++++++++++++++++--------------------------
>  1 file changed, 25 insertions(+), 26 deletions(-)
> 
> diff --git a/block/block-backend.c b/block/block-backend.c
> index baef8e7..2d0d9b6 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -1140,7 +1140,7 @@ int coroutine_fn blk_co_pwritev(BlockBackend *blk, int64_t offset,
>  typedef struct BlkRwCo {
>      BlockBackend *blk;
>      int64_t offset;
> -    QEMUIOVector *qiov;
> +    void *iobuf;
>      int ret;
>      BdrvRequestFlags flags;
>  } BlkRwCo;
> @@ -1148,17 +1148,19 @@ typedef struct BlkRwCo {
>  static void blk_read_entry(void *opaque)
>  {
>      BlkRwCo *rwco = opaque;
> +    QEMUIOVector *qiov = rwco->iobuf;
>  
> -    rwco->ret = blk_co_preadv(rwco->blk, rwco->offset, rwco->qiov->size,
> -                              rwco->qiov, rwco->flags);
> +    rwco->ret = blk_co_preadv(rwco->blk, rwco->offset, qiov->size,
> +                              qiov, rwco->flags);
>  }
>  
>  static void blk_write_entry(void *opaque)
>  {
>      BlkRwCo *rwco = opaque;
> +    QEMUIOVector *qiov = rwco->iobuf;
>  
> -    rwco->ret = blk_co_pwritev(rwco->blk, rwco->offset, rwco->qiov->size,
> -                               rwco->qiov, rwco->flags);
> +    rwco->ret = blk_co_pwritev(rwco->blk, rwco->offset, qiov->size,
> +                               qiov, rwco->flags);
>  }
>  
>  static int blk_prw(BlockBackend *blk, int64_t offset, uint8_t *buf,
> @@ -1178,7 +1180,7 @@ static int blk_prw(BlockBackend *blk, int64_t offset, uint8_t *buf,
>      rwco = (BlkRwCo) {
>          .blk    = blk,
>          .offset = offset,
> -        .qiov   = &qiov,
> +        .iobuf  = &qiov,
>          .flags  = flags,
>          .ret    = NOT_DONE,
>      };
> @@ -1275,7 +1277,7 @@ static void blk_aio_complete_bh(void *opaque)
>  }
>  
>  static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset, int bytes,
> -                                QEMUIOVector *qiov, CoroutineEntry co_entry,
> +                                void *iobuf, CoroutineEntry co_entry,
>                                  BdrvRequestFlags flags,
>                                  BlockCompletionFunc *cb, void *opaque)
>  {
> @@ -1287,7 +1289,7 @@ static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset, int bytes,
>      acb->rwco = (BlkRwCo) {
>          .blk    = blk,
>          .offset = offset,
> -        .qiov   = qiov,
> +        .iobuf  = iobuf,
>          .flags  = flags,
>          .ret    = NOT_DONE,
>      };
> @@ -1310,10 +1312,11 @@ static void blk_aio_read_entry(void *opaque)
>  {
>      BlkAioEmAIOCB *acb = opaque;
>      BlkRwCo *rwco = &acb->rwco;
> +    QEMUIOVector *qiov = rwco->iobuf;
>  
> -    assert(rwco->qiov->size == acb->bytes);
> +    assert(qiov->size == acb->bytes);
>      rwco->ret = blk_co_preadv(rwco->blk, rwco->offset, acb->bytes,
> -                              rwco->qiov, rwco->flags);
> +                              qiov, rwco->flags);
>      blk_aio_complete(acb);
>  }
>  
> @@ -1321,10 +1324,11 @@ static void blk_aio_write_entry(void *opaque)
>  {
>      BlkAioEmAIOCB *acb = opaque;
>      BlkRwCo *rwco = &acb->rwco;
> +    QEMUIOVector *qiov = rwco->iobuf;
>  
> -    assert(!rwco->qiov || rwco->qiov->size == acb->bytes);
> +    assert(!qiov || qiov->size == acb->bytes);
>      rwco->ret = blk_co_pwritev(rwco->blk, rwco->offset, acb->bytes,
> -                               rwco->qiov, rwco->flags);
> +                               qiov, rwco->flags);
>      blk_aio_complete(acb);
>  }
>  
> @@ -1453,8 +1457,10 @@ int blk_co_ioctl(BlockBackend *blk, unsigned long int req, void *buf)
>  static void blk_ioctl_entry(void *opaque)
>  {
>      BlkRwCo *rwco = opaque;
> +    QEMUIOVector *qiov = rwco->iobuf;
> +
>      rwco->ret = blk_co_ioctl(rwco->blk, rwco->offset,
> -                             rwco->qiov->iov[0].iov_base);
> +                             qiov->iov[0].iov_base);
>  }
>  
>  int blk_ioctl(BlockBackend *blk, unsigned long int req, void *buf)
> @@ -1467,24 +1473,15 @@ static void blk_aio_ioctl_entry(void *opaque)
>      BlkAioEmAIOCB *acb = opaque;
>      BlkRwCo *rwco = &acb->rwco;
>  
> -    rwco->ret = blk_co_ioctl(rwco->blk, rwco->offset,
> -                             rwco->qiov->iov[0].iov_base);
> +    rwco->ret = blk_co_ioctl(rwco->blk, rwco->offset, rwco->iobuf);
> +
>      blk_aio_complete(acb);
>  }
>  
>  BlockAIOCB *blk_aio_ioctl(BlockBackend *blk, unsigned long int req, void *buf,
>                            BlockCompletionFunc *cb, void *opaque)
>  {
> -    QEMUIOVector qiov;
> -    struct iovec iov;
> -
> -    iov = (struct iovec) {
> -        .iov_base = buf,
> -        .iov_len = 0,
> -    };
> -    qemu_iovec_init_external(&qiov, &iov, 1);
> -
> -    return blk_aio_prwv(blk, req, 0, &qiov, blk_aio_ioctl_entry, 0, cb, opaque);
> +    return blk_aio_prwv(blk, req, 0, buf, blk_aio_ioctl_entry, 0, cb, opaque);
>  }
>  
>  int blk_co_pdiscard(BlockBackend *blk, int64_t offset, int bytes)
> @@ -1900,7 +1897,9 @@ int blk_truncate(BlockBackend *blk, int64_t offset, PreallocMode prealloc,
>  static void blk_pdiscard_entry(void *opaque)
>  {
>      BlkRwCo *rwco = opaque;
> -    rwco->ret = blk_co_pdiscard(rwco->blk, rwco->offset, rwco->qiov->size);
> +    QEMUIOVector *qiov = rwco->iobuf;
> +
> +    rwco->ret = blk_co_pdiscard(rwco->blk, rwco->offset, qiov->size);
>  }
>  
>  int blk_pdiscard(BlockBackend *blk, int64_t offset, int bytes)
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
