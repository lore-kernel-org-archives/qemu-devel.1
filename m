Received: from eggs.gnu.org ([2001:4830:134:3::10]:50924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fIsTb-0000Zb-9Q
	for qemu-devel@nongnu.org; Wed, 16 May 2018 05:12:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fIsTa-0001NE-7F
	for qemu-devel@nongnu.org; Wed, 16 May 2018 05:12:03 -0400
Date: Wed, 16 May 2018 17:11:46 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180516091146.GH9089@xz-mi>
References: <1526452784-45308-1-git-send-email-wangjie88@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: stefanha@redhat.com, famz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, eric.fangyi@huawei.com, wu.wubin@huawei.com

On Wed, May 16, 2018 at 02:39:44PM +0800, Jie Wang wrote:
> From: w00251574 <wangjie88@huawei.com>

(Maybe you'd prefer to still use "Jie Wang" here? :)

> 
> When we call addIOThread, the epollfd created in aio_context_setup,
> but not close it in the process of delIOThread, so the epollfd will leak.
> 
> Signed-off-by: Jie Wang <wangjie88@huawei.com>

[...]

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

Would it be better to call aio_epoll_disable() here?  Otherwise it
looks good to me.

> +#endif
> +}
> +

Regards,

-- 
Peter Xu
