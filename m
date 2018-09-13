Received: from eggs.gnu.org ([2001:4830:134:3::10]:45662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1g0LYX-0006sq-Hd
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 02:56:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1g0LYW-0000Kd-Jq
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 02:56:49 -0400
Date: Thu, 13 Sep 2018 14:56:39 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180913065639.GL2526@lemon.usersys.redhat.com>
References: <20180912171040.1732-1-pbonzini@redhat.com>
	<20180912171040.1732-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912171040.1732-2-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] aio-posix: fix concurrent access to
 poll_disable_cnt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, stefanha@redhat.com

On Wed, 09/12 19:10, Paolo Bonzini wrote:
> It is valid for an aio_set_fd_handler to happen concurrently with
> aio_poll.  In that case, poll_disable_cnt can change under the heels
> of aio_poll, and the assertion on poll_disable_cnt can fail in
> run_poll_handlers.
> 
> Therefore, this patch simply checks the counter on every polling
> iteration.  There are no particular needs for ordering, since the
> polling loop is terminated anyway by aio_notify at the end of
> aio_set_fd_handler.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  util/aio-posix.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/util/aio-posix.c b/util/aio-posix.c
> index 131ba6b4a8..5c29380575 100644
> --- a/util/aio-posix.c
> +++ b/util/aio-posix.c
> @@ -211,6 +211,7 @@ void aio_set_fd_handler(AioContext *ctx,
>      AioHandler *node;
>      bool is_new = false;
>      bool deleted = false;
> +    int poll_disable_change;
>  
>      qemu_lockcnt_lock(&ctx->list_lock);
>  
> @@ -244,11 +245,9 @@ void aio_set_fd_handler(AioContext *ctx,
>              QLIST_REMOVE(node, node);
>              deleted = true;
>          }
> -
> -        if (!node->io_poll) {
> -            ctx->poll_disable_cnt--;
> -        }
> +        poll_disable_change = -!node->io_poll;
>      } else {
> +        poll_disable_change = !io_poll - (node && !node->io_poll);
>          if (node == NULL) {
>              /* Alloc and insert if it's not already there */
>              node = g_new0(AioHandler, 1);
> @@ -257,10 +256,6 @@ void aio_set_fd_handler(AioContext *ctx,
>  
>              g_source_add_poll(&ctx->source, &node->pfd);
>              is_new = true;
> -
> -            ctx->poll_disable_cnt += !io_poll;
> -        } else {
> -            ctx->poll_disable_cnt += !io_poll - !node->io_poll;
>          }
>  
>          /* Update handler with latest information */
> @@ -274,6 +269,15 @@ void aio_set_fd_handler(AioContext *ctx,
>          node->pfd.events |= (io_write ? G_IO_OUT | G_IO_ERR : 0);
>      }
>  
> +    /* No need to order poll_disable_cnt writes against other updates;
> +     * the counter is only used to avoid wasting time and latency on
> +     * iterated polling when the system call will be ultimately necessary.
> +     * Changing handlers is a rare event, and a little wasted polling until
> +     * the aio_notify below is not an issue.
> +     */
> +    atomic_set(&ctx->poll_disable_cnt,
> +               atomic_read(&ctx->poll_disable_cnt) + poll_disable_change);

Why not atomic_add?

> +
>      aio_epoll_update(ctx, node, is_new);
>      qemu_lockcnt_unlock(&ctx->list_lock);
>      aio_notify(ctx);
> @@ -525,7 +529,6 @@ static bool run_poll_handlers(AioContext *ctx, int64_t max_ns)
>  
>      assert(ctx->notify_me);
>      assert(qemu_lockcnt_count(&ctx->list_lock) > 0);
> -    assert(ctx->poll_disable_cnt == 0);
>  
>      trace_run_poll_handlers_begin(ctx, max_ns);
>  
> @@ -533,7 +536,8 @@ static bool run_poll_handlers(AioContext *ctx, int64_t max_ns)
>  
>      do {
>          progress = run_poll_handlers_once(ctx);
> -    } while (!progress && qemu_clock_get_ns(QEMU_CLOCK_REALTIME) < end_time);
> +    } while (!progress && qemu_clock_get_ns(QEMU_CLOCK_REALTIME) < end_time
> +             && !atomic_read(&ctx->poll_disable_cnt));
>  
>      trace_run_poll_handlers_end(ctx, progress);
>  
> @@ -552,7 +556,7 @@ static bool run_poll_handlers(AioContext *ctx, int64_t max_ns)
>   */
>  static bool try_poll_mode(AioContext *ctx, bool blocking)
>  {
> -    if (blocking && ctx->poll_max_ns && ctx->poll_disable_cnt == 0) {
> +    if (blocking && ctx->poll_max_ns && !atomic_read(&ctx->poll_disable_cnt)) {
>          /* See qemu_soonest_timeout() uint64_t hack */
>          int64_t max_ns = MIN((uint64_t)aio_compute_timeout(ctx),
>                               (uint64_t)ctx->poll_ns);
> -- 
> 2.17.1
> 
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
