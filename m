Received: from eggs.gnu.org ([2001:4830:134:3::10]:60618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dfTQE-0001jm-PC
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dfTQ8-0006dd-M9
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:01:26 -0400
Date: Wed, 9 Aug 2017 18:01:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170809160105.GJ4213@localhost.localdomain>
References: <20170808175711.12203-1-jsnow@redhat.com>
	<20170808175711.12203-4-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170808175711.12203-4-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] block-backend: shift in-flight counter
 to BB from BDS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, dgilbert@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, pjp@redhat.com

Am 08.08.2017 um 19:57 hat John Snow geschrieben:
> From: Kevin Wolf <kwolf@redhat.com>
> 
> This allows us to detect errors in cache flushing (ENOMEDIUM)
> without choking on a null dereference because we assume that
> blk_bs(bb) is always defined.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block.c               |  2 +-
>  block/block-backend.c | 40 ++++++++++++++++++++++++++++++++++------
>  2 files changed, 35 insertions(+), 7 deletions(-)
> 
> diff --git a/block.c b/block.c
> index ce9cce7..834b836 100644
> --- a/block.c
> +++ b/block.c
> @@ -4476,7 +4476,7 @@ out:
>  
>  AioContext *bdrv_get_aio_context(BlockDriverState *bs)
>  {
> -    return bs->aio_context;
> +    return bs ? bs->aio_context : qemu_get_aio_context();
>  }

This should probably be a separate patch; it's not really related to
moving the in-flight counter, but fixes another NULL dereference in
blk_aio_prwv().

>  void bdrv_coroutine_enter(BlockDriverState *bs, Coroutine *co)
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 968438c..efd7e92 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -68,6 +68,9 @@ struct BlockBackend {
>      NotifierList remove_bs_notifiers, insert_bs_notifiers;
>  
>      int quiesce_counter;
> +
> +    /* Number of in-flight requests. Accessed with atomic ops. */
> +    unsigned int in_flight;
>  };
>  
>  typedef struct BlockBackendAIOCB {
> @@ -1109,6 +1112,16 @@ int blk_make_zero(BlockBackend *blk, BdrvRequestFlags flags)
>      return bdrv_make_zero(blk->root, flags);
>  }
>  
> +static void blk_inc_in_flight(BlockBackend *blk)
> +{
> +    atomic_inc(&blk->in_flight);
> +}
> +
> +static void blk_dec_in_flight(BlockBackend *blk)
> +{
> +    atomic_dec(&blk->in_flight);
> +}
> +
>  static void error_callback_bh(void *opaque)
>  {
>      struct BlockBackendAIOCB *acb = opaque;
> @@ -1147,7 +1160,7 @@ static const AIOCBInfo blk_aio_em_aiocb_info = {
>  static void blk_aio_complete(BlkAioEmAIOCB *acb)
>  {
>      if (acb->has_returned) {
> -        bdrv_dec_in_flight(acb->common.bs);
> +        blk_dec_in_flight(acb->rwco.blk);
>          acb->common.cb(acb->common.opaque, acb->rwco.ret);
>          qemu_aio_unref(acb);
>      }
> @@ -1168,7 +1181,7 @@ static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset, int bytes,
>      BlkAioEmAIOCB *acb;
>      Coroutine *co;
>  
> -    bdrv_inc_in_flight(blk_bs(blk));
> +    blk_inc_in_flight(blk);
>      acb = blk_aio_get(&blk_aio_em_aiocb_info, blk, cb, opaque);
>      acb->rwco = (BlkRwCo) {
>          .blk    = blk,
> @@ -1405,14 +1418,28 @@ int blk_flush(BlockBackend *blk)
>  
>  void blk_drain(BlockBackend *blk)
>  {
> -    if (blk_bs(blk)) {
> -        bdrv_drain(blk_bs(blk));
> +    AioContext *ctx = blk_get_aio_context(blk);
> +
> +    while (atomic_read(&blk->in_flight)) {
> +        aio_context_acquire(ctx);
> +        aio_poll(ctx, false);
> +        aio_context_release(ctx);
> +
> +        if (blk_bs(blk)) {
> +            bdrv_drain(blk_bs(blk));
> +        }
>      }
>  }
>  
>  void blk_drain_all(void)
>  {
> -    bdrv_drain_all();
> +    BlockBackend *blk = NULL;
> +
> +    bdrv_drain_all_begin();
> +    while ((blk = blk_all_next(blk)) != NULL) {
> +        blk_drain(blk);
> +    }
> +    bdrv_drain_all_end();
>  }

We still need to check that everyone who should call blk_drain_all()
rather than bdrv_drain_all() actually does so.

>  void blk_set_on_error(BlockBackend *blk, BlockdevOnError on_read_error,
> @@ -1453,10 +1480,11 @@ static void send_qmp_error_event(BlockBackend *blk,
>                                   bool is_read, int error)
>  {
>      IoOperationType optype;
> +    BlockDriverState *bs = blk_bs(blk);
>  
>      optype = is_read ? IO_OPERATION_TYPE_READ : IO_OPERATION_TYPE_WRITE;
>      qapi_event_send_block_io_error(blk_name(blk),
> -                                   bdrv_get_node_name(blk_bs(blk)), optype,
> +                                   bs ? bdrv_get_node_name(bs) : "", optype,
>                                     action, blk_iostatus_is_enabled(blk),
>                                     error == ENOSPC, strerror(error),
>                                     &error_abort);

And this is another independent NULL dereference fix.

Kevin
