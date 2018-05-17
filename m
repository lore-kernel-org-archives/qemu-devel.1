Received: from eggs.gnu.org ([2001:4830:134:3::10]:60341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJ9E1-0006Iu-25
	for qemu-devel@nongnu.org; Wed, 16 May 2018 23:05:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJ9E0-0000Is-3W
	for qemu-devel@nongnu.org; Wed, 16 May 2018 23:05:05 -0400
Date: Thu, 17 May 2018 11:04:53 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180517030453.GN9089@xz-mi>
References: <1526517763-11108-1-git-send-email-wangjie88@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1526517763-11108-1-git-send-email-wangjie88@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v5] iothread: fix epollfd leak in the
 process of delIOThread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jie Wang <wangjie88@huawei.com>
Cc: stefanha@redhat.com, famz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, eric.fangyi@huawei.com, wu.wubin@huawei.com

On Thu, May 17, 2018 at 08:42:43AM +0800, Jie Wang wrote:
> When we call addIOThread, the epollfd created in aio_context_setup,
> but not close it in the process of delIOThread, so the epollfd will leak.

(maybe also mention about the aio_epoll_disable change, or split into
 two patches?)

> 
> Signed-off-by: Jie Wang <wangjie88@huawei.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

> ---
>  include/block/aio.h |  8 ++++++++
>  util/aio-posix.c    | 13 ++++++++++---
>  util/aio-win32.c    |  4 ++++
>  util/async.c        |  1 +
>  4 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/include/block/aio.h b/include/block/aio.h
> index a1d6b9e..ae6f354 100644
> --- a/include/block/aio.h
> +++ b/include/block/aio.h
> @@ -555,6 +555,14 @@ static inline bool in_aio_context_home_thread(AioContext *ctx)
>  void aio_context_setup(AioContext *ctx);
>  
>  /**
> + * aio_context_destroy:
> + * @ctx: the aio context
> + *
> + * Destroy the aio context.
> + */
> +void aio_context_destroy(AioContext *ctx);
> +
> +/**
>   * aio_context_set_poll_params:
>   * @ctx: the aio context
>   * @max_ns: how long to busy poll for, in nanoseconds
> diff --git a/util/aio-posix.c b/util/aio-posix.c
> index d8f0cb4..118bf57 100644
> --- a/util/aio-posix.c
> +++ b/util/aio-posix.c
> @@ -45,11 +45,11 @@ struct AioHandler
>  
>  static void aio_epoll_disable(AioContext *ctx)
>  {
> -    ctx->epoll_available = false;
> -    if (!ctx->epoll_enabled) {
> +    ctx->epoll_enabled = false;
> +    if (!ctx->epoll_available) {
>          return;
>      }
> -    ctx->epoll_enabled = false;
> +    ctx->epoll_available = false;
>      close(ctx->epollfd);
>  }
>  
> @@ -713,6 +713,13 @@ void aio_context_setup(AioContext *ctx)
>  #endif
>  }
>  
> +void aio_context_destroy(AioContext *ctx)
> +{
> +#ifdef CONFIG_EPOLL_CREATE1
> +    aio_epoll_disable(ctx);
> +#endif
> +}
> +
>  void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
>                                   int64_t grow, int64_t shrink, Error **errp)
>  {
> diff --git a/util/aio-win32.c b/util/aio-win32.c
> index a67b00c..e676a8d 100644
> --- a/util/aio-win32.c
> +++ b/util/aio-win32.c
> @@ -407,6 +407,10 @@ void aio_context_setup(AioContext *ctx)
>  {
>  }
>  
> +void aio_context_destroy(AioContext *ctx)
> +{
> +}
> +
>  void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
>                                   int64_t grow, int64_t shrink, Error **errp)
>  {
> diff --git a/util/async.c b/util/async.c
> index 4dd9d95..03f6278 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -298,6 +298,7 @@ aio_ctx_finalize(GSource     *source)
>      qemu_rec_mutex_destroy(&ctx->lock);
>      qemu_lockcnt_destroy(&ctx->list_lock);
>      timerlistgroup_deinit(&ctx->tlg);
> +    aio_context_destroy(ctx);
>  }
>  
>  static GSourceFuncs aio_source_funcs = {
> -- 
> 1.8.3.1
> 

-- 
Peter Xu
