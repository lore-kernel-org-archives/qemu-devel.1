Received: from eggs.gnu.org ([2001:4830:134:3::10]:49533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fIsPS-0006SQ-5F
	for qemu-devel@nongnu.org; Wed, 16 May 2018 05:07:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fIsPR-0007PJ-4X
	for qemu-devel@nongnu.org; Wed, 16 May 2018 05:07:46 -0400
Date: Wed, 16 May 2018 17:07:34 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180516090734.GF6731@lemon.usersys.redhat.com>
References: <1526452784-45308-1-git-send-email-wangjie88@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526452784-45308-1-git-send-email-wangjie88@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v2] iothread: fix epollfd leak in the
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
Cc: stefanha@redhat.com, peterx@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, eric.fangyi@huawei.com, wu.wubin@huawei.com

On Wed, 05/16 14:39, Jie Wang wrote:
> From: w00251574 <wangjie88@huawei.com>
> 
> When we call addIOThread, the epollfd created in aio_context_setup,
> but not close it in the process of delIOThread, so the epollfd will leak.
> 
> Signed-off-by: Jie Wang <wangjie88@huawei.com>
> ---
>  include/block/aio.h | 8 ++++++++
>  util/aio-posix.c    | 7 +++++++
>  util/aio-win32.c    | 4 ++++
>  util/async.c        | 1 +
>  4 files changed, 20 insertions(+)
> 
> diff --git a/include/block/aio.h b/include/block/aio.h
> index a1d6b9e249..ae6f354e6c 100644
> --- a/include/block/aio.h
> +++ b/include/block/aio.h
> @@ -554,6 +554,14 @@ static inline bool in_aio_context_home_thread(AioContext *ctx)
>   */
>  void aio_context_setup(AioContext *ctx);
>  
> +/**
> + * aio_context_destroy:
> + * @ctx: the aio context
> + *
> + * Destroy the aio context.
> + */
> +void aio_context_destroy(AioContext *ctx);
> +
>  /**
>   * aio_context_set_poll_params:
>   * @ctx: the aio context
> diff --git a/util/aio-posix.c b/util/aio-posix.c
> index d8f0cb4af8..bd81455851 100644
> --- a/util/aio-posix.c
> +++ b/util/aio-posix.c
> @@ -713,6 +713,13 @@ void aio_context_setup(AioContext *ctx)
>  #endif
>  }
>  
> +void aio_context_destroy(AioContext *ctx)
> +{
> +#ifdef CONFIG_EPOLL_CREATE1
> +    close(ctx->epollfd);

In aio_context_setup, epoll_create1 could fail. Putting this inside an "if
(ctx->epllfd >= 0)" condition is cleaner, I think. 

> +#endif
> +}
> +
>  void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
>                                   int64_t grow, int64_t shrink, Error **errp)
>  {
> diff --git a/util/aio-win32.c b/util/aio-win32.c
> index a67b00c6ad..e676a8d9b2 100644
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
> index 4dd9d95a9e..03f62787f2 100644
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
> 2.15.0.windows.1
> 
