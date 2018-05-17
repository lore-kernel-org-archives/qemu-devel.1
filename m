Received: from eggs.gnu.org ([2001:4830:134:3::10]:55343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJCJo-0007NC-EV
	for qemu-devel@nongnu.org; Thu, 17 May 2018 02:23:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJCJn-0005sl-JV
	for qemu-devel@nongnu.org; Thu, 17 May 2018 02:23:16 -0400
Date: Thu, 17 May 2018 14:22:58 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180517062258.GP9089@xz-mi>
References: <1526523977-73930-1-git-send-email-wangjie88@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1526523977-73930-1-git-send-email-wangjie88@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v6 2/2] iothread: let aio_epoll_disable fit
 to aio_context_destroy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jie Wang <wangjie88@huawei.com>
Cc: famz@redhat.com, stefanha@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, eric.fangyi@huawei.com, wu.wubin@huawei.com

On Thu, May 17, 2018 at 10:26:17AM +0800, Jie Wang wrote:
> epoll_available will only be set if epollfd != -1, os we
> can swap the two variables in aio_epoll_disable, and
> aio_context_destroy can call aio_epoll_disable directly.
> 
> Signed-off-by: Jie Wang <wangjie88@huawei.com>
> ---
>  util/aio-posix.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/util/aio-posix.c b/util/aio-posix.c
> index 0ade2c7..118bf57 100644
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
> @@ -716,9 +716,7 @@ void aio_context_setup(AioContext *ctx)
>  void aio_context_destroy(AioContext *ctx)
>  {
>  #ifdef CONFIG_EPOLL_CREATE1
> -    if (ctx->epollfd >= 0) {
> -        close(ctx->epollfd);
> -    }
> +    aio_epoll_disable(ctx);

Hmm... I think this patch should be the first if to split.

Anyway, IMHO version 5 is already good enough and has got r-bs, no
need to bother reposting a version 7.  Maintainer could possibly touch
up the commit message if necessary.

Thanks,

>  #endif
>  }
>  
> -- 
> 1.8.3.1
> 

-- 
Peter Xu
