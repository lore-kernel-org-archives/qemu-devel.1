Received: from eggs.gnu.org ([2001:4830:134:3::10]:58549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fIuqo-0002nA-7c
	for qemu-devel@nongnu.org; Wed, 16 May 2018 07:44:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fIuqn-0008HZ-9Y
	for qemu-devel@nongnu.org; Wed, 16 May 2018 07:44:10 -0400
Date: Wed, 16 May 2018 19:43:50 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180516114350.GJ9089@xz-mi>
References: <1526459780-35100-1-git-send-email-wangjie88@huawei.com>
	<05498b0c-f729-0a2d-685a-7e81c3550ae4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <05498b0c-f729-0a2d-685a-7e81c3550ae4@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v4] iothread: fix epollfd leak in the
 process of delIOThread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "WangJie (Pluto)" <wangjie88@huawei.com>
Cc: stefanha@redhat.com, famz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, eric.fangyi@huawei.com, wu.wubin@huawei.com

On Wed, May 16, 2018 at 07:14:53PM +0800, WangJie (Pluto) wrote:
> Hi, Peter Xu:
> 	If call aio_epoll_disable() here, aio_epoll_disable() will return before close ctx->epollfd,
>     Because the ctx->epoll_enabled is false in the moment.
> 	In the process of addIOThread, aio_context_setup created epoll without call aio_epoll_try_enable,
>     so ctx->epoll_enabled have no chance to set true.

I see that epoll_available will only be set if epollfd != -1, so it
seems to me to make more sense if we swap the two variables in
aio_epoll_disable(), from current version:

static void aio_epoll_disable(AioContext *ctx)
{
    ctx->epoll_available = false;
    if (!ctx->epoll_enabled) {
        return;
    }
    ctx->epoll_enabled = false;
    close(ctx->epollfd);
}

To:

static void aio_epoll_disable(AioContext *ctx)
{
    ctx->epoll_enabled = false;
    if (!ctx->epoll_available) {
        return;
    }
    ctx->epoll_available = false;
    close(ctx->epollfd);
}

What do you think?  And Fam?

> 
> On 2018/5/16 16:36, Jie Wang wrote:
> > +void aio_context_destroy(AioContext *ctx)
> > +{
> > +#ifdef CONFIG_EPOLL_CREATE1
> > +    if (ctx->epollfd >= 0) {
> > +        close(ctx->epollfd);
> > +    }
> > +#endif
> > +}
> > +
> >  void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
> >                                   int64_t grow, int64_t shrink, Error **errp)
> 

-- 
Peter Xu
