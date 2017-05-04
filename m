Received: from eggs.gnu.org ([2001:4830:134:3::10]:37587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6BEB-0004jq-Bf
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:31:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6BEA-0002vR-6T
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:31:07 -0400
Date: Thu, 4 May 2017 15:30:58 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170504073058.GE19184@lemon.lan>
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-13-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170420120058.28404-13-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 12/17] block: protect tracked_requests and
 flush_queue with reqs_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Thu, 04/20 14:00, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block.c                   |  1 +
>  block/io.c                | 20 +++++++++++++++++---
>  include/block/block_int.h | 12 +++++++-----
>  3 files changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/block.c b/block.c
> index f1aec36..3b2ed29 100644
> --- a/block.c
> +++ b/block.c
> @@ -234,6 +234,7 @@ BlockDriverState *bdrv_new(void)
>          QLIST_INIT(&bs->op_blockers[i]);
>      }
>      notifier_with_return_list_init(&bs->before_write_notifiers);
> +    qemu_co_mutex_init(&bs->reqs_lock);
>      bs->refcnt = 1;
>      bs->aio_context = qemu_get_aio_context();
>  
> diff --git a/block/io.c b/block/io.c
> index d17564b..7af9d47 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -378,8 +378,10 @@ static void tracked_request_end(BdrvTrackedRequest *req)
>          atomic_dec(&req->bs->serialising_in_flight);
>      }
>  
> +    qemu_co_mutex_lock(&req->bs->reqs_lock);
>      QLIST_REMOVE(req, list);
>      qemu_co_queue_restart_all(&req->wait_queue);
> +    qemu_co_mutex_unlock(&req->bs->reqs_lock);
>  }
>  
>  /**
> @@ -404,7 +406,9 @@ static void tracked_request_begin(BdrvTrackedRequest *req,
>  
>      qemu_co_queue_init(&req->wait_queue);
>  
> +    qemu_co_mutex_lock(&bs->reqs_lock);
>      QLIST_INSERT_HEAD(&bs->tracked_requests, req, list);
> +    qemu_co_mutex_unlock(&bs->reqs_lock);
>  }
>  
>  static void mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
> @@ -526,6 +530,7 @@ static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self)
>  
>      do {
>          retry = false;
> +        qemu_co_mutex_lock(&bs->reqs_lock);
>          QLIST_FOREACH(req, &bs->tracked_requests, list) {
>              if (req == self || (!req->serialising && !self->serialising)) {
>                  continue;
> @@ -544,7 +549,7 @@ static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self)
>                   * (instead of producing a deadlock in the former case). */
>                  if (!req->waiting_for) {
>                      self->waiting_for = req;
> -                    qemu_co_queue_wait(&req->wait_queue, NULL);
> +                    qemu_co_queue_wait(&req->wait_queue, &bs->reqs_lock);
>                      self->waiting_for = NULL;
>                      retry = true;
>                      waited = true;
> @@ -552,6 +557,7 @@ static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self)
>                  }
>              }
>          }
> +        qemu_co_mutex_unlock(&bs->reqs_lock);
>      } while (retry);
>  
>      return waited;
> @@ -2302,11 +2308,13 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
>      current_gen = atomic_read(&bs->write_gen);
>  
>      /* Wait until any previous flushes are completed */
> +    qemu_co_mutex_lock(&bs->reqs_lock);
>      while (bs->active_flush_req) {
> -        qemu_co_queue_wait(&bs->flush_queue, NULL);
> +        qemu_co_queue_wait(&bs->flush_queue, &bs->reqs_lock);
>      }
>  
>      bs->active_flush_req = true;
> +    qemu_co_mutex_unlock(&bs->reqs_lock);
>  
>      /* Write back all layers by calling one driver function */
>      if (bs->drv->bdrv_co_flush) {
> @@ -2328,10 +2336,14 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
>          goto flush_parent;
>      }
>  
> -    /* Check if we really need to flush anything */
> +    /* Check if we really need to flush anything
> +     * TODO: use int and atomic access */
> +    qemu_co_mutex_lock(&bs->reqs_lock);
>      if (bs->flushed_gen == current_gen) {

Should the atomic reading of current_gen be moved down here, to avoid TOCTOU?

> +        qemu_co_mutex_unlock(&bs->reqs_lock);
>          goto flush_parent;
>      }
> +    qemu_co_mutex_unlock(&bs->reqs_lock);
>  
>      BLKDBG_EVENT(bs->file, BLKDBG_FLUSH_TO_DISK);
>      if (bs->drv->bdrv_co_flush_to_disk) {
> @@ -2375,12 +2387,14 @@ flush_parent:
>      ret = bs->file ? bdrv_co_flush(bs->file->bs) : 0;
>  out:
>      /* Notify any pending flushes that we have completed */
> +    qemu_co_mutex_lock(&bs->reqs_lock);
>      if (ret == 0) {
>          bs->flushed_gen = current_gen;
>      }
>      bs->active_flush_req = false;
>      /* Return value is ignored - it's ok if wait queue is empty */
>      qemu_co_queue_next(&bs->flush_queue);
> +    qemu_co_mutex_unlock(&bs->reqs_lock);
>  
>  early_exit:
>      bdrv_dec_in_flight(bs);
