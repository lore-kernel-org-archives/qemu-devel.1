Received: from eggs.gnu.org ([2001:4830:134:3::10]:38154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fImr3-0007mY-Ez
	for qemu-devel@nongnu.org; Tue, 15 May 2018 23:11:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fImr2-0001RK-Fx
	for qemu-devel@nongnu.org; Tue, 15 May 2018 23:11:53 -0400
Date: Wed, 16 May 2018 11:11:37 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180516031137.GE9089@xz-mi>
References: <1526385643-69675-1-git-send-email-wangjie88@huawei.com>
	<20180516013831.GC6731@lemon.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180516013831.GC6731@lemon.usersys.redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iothread: fix epollfd leak in the process
 of delIOThread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Jie Wang <wangjie88@huawei.com>, stefanha@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, eric.fangyi@huawei.com, wu.wubin@huawei.com

On Wed, May 16, 2018 at 09:38:31AM +0800, Fam Zheng wrote:
> On Tue, 05/15 20:00, Jie Wang wrote:
> > When we call addIOThread, the epollfd created in aio_context_setup,
> > but not close it in the process of delIOThread, so the epollfd will leak.
> > 
> > Signed-off-by: Jie Wang <wangjie88@huawei.com>
> > ---
> >  iothread.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/iothread.c b/iothread.c
> > index aff1281..23ac0a8 100644
> > --- a/iothread.c
> > +++ b/iothread.c
> > @@ -128,6 +128,7 @@ static void iothread_instance_finalize(Object *obj)
> >       * GSources first before destroying any GMainContext.
> >       */
> >      if (iothread->ctx) {
> > +        close(iothread->ctx->epollfd);
> >          aio_context_unref(iothread->ctx);
> >          iothread->ctx = NULL;
> >      }
> > -- 
> > 1.8.3.1
> > 
> 
> Please add an aio_context_destroy() function in aio-posix.c and call it from
> aio_context_finalize(). IOThread code should not touch AioContext internals.

I believe Fam means aio_ctx_finalize().

> Also please remember to wrap the close() code in CONFIG_EPOLL_CREATE1.  An empty
> function may need to be added to aio-win32.c, too.

Agreed.

-- 
Peter Xu
