Received: from eggs.gnu.org ([2001:4830:134:3::10]:38980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dx3fu-0002wj-1a
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 00:10:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dx3fq-0004tF-Lp
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 00:10:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dx3fq-0004sk-93
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 00:10:14 -0400
Date: Wed, 27 Sep 2017 12:09:59 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170927040959.GA25011@pxdev.xzpeter.org>
References: <20170926054439.GB25267@pxdev.xzpeter.org>
	<20170926084337.GB16834@stefanha-x1.localdomain>
	<20170926091150.GC3828@pxdev.xzpeter.org>
	<20170926111343.GE31924@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170926111343.GE31924@lemon.lan>
Subject: Re: [Qemu-devel] A glib warning encountered with internal iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, QEMU Devel Mailing List <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, Sep 26, 2017 at 07:13:43PM +0800, Fam Zheng wrote:
> On Tue, 09/26 17:11, Peter Xu wrote:
> > If glib unset the flag after calling the destructor, it'll be fine.
> > But it's not doing it that way.  And with above implementation of
> > glib, I don't see a good way to solve this problem via ordering of
> > glib calls... :(
> 
> Does this work?
> 
> ---
> 
> diff --git a/include/block/aio.h b/include/block/aio.h
> index e9aeeaec94..3237d2be7c 100644
> --- a/include/block/aio.h
> +++ b/include/block/aio.h
> @@ -147,6 +147,9 @@ struct AioContext {
>      int epollfd;
>      bool epoll_enabled;
>      bool epoll_available;
> +
> +    /* Protected by BQL */

Would atomic ops work here?

It can be used possibly in any destructor of AioContext.  And, IIUC we
are trying to get rid of BQL when possible (at least, I think the
whole bunch of thing I did in past weeks is a fight with BQL somehow).

> +    int refcnt;
>  };
>  
>  /**
> diff --git a/util/async.c b/util/async.c
> index 355af73ee7..c5464611e3 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -293,7 +293,6 @@ aio_ctx_finalize(GSource     *source)
>      }
>      qemu_lockcnt_unlock(&ctx->list_lock);
>  
> -    aio_set_event_notifier(ctx, &ctx->notifier, false, NULL, NULL);
>      event_notifier_cleanup(&ctx->notifier);
>      qemu_rec_mutex_destroy(&ctx->lock);
>      qemu_lockcnt_destroy(&ctx->list_lock);
> @@ -429,6 +428,8 @@ AioContext *aio_context_new(Error **errp)
>      ctx->poll_grow = 0;
>      ctx->poll_shrink = 0;
>  
> +    ctx->refcnt = 1;
> +
>      return ctx;
>  fail:
>      g_source_destroy(&ctx->source);
> @@ -476,11 +477,17 @@ void aio_co_enter(AioContext *ctx, struct Coroutine *co)
>  
>  void aio_context_ref(AioContext *ctx)
>  {
> +    assert(ctx->refcnt > 0);
> +    ctx->refcnt++;
>      g_source_ref(&ctx->source);
>  }
>  
>  void aio_context_unref(AioContext *ctx)
>  {
> +    assert(ctx->refcnt > 0);
> +    if (--ctx->refcnt == 0) {
> +        aio_set_event_notifier(ctx, &ctx->notifier, false, NULL, NULL);
> +    }
>      g_source_unref(&ctx->source);
>  }
>  

Thanks for the patch, this one with Stefan's suggestion does solve the
problem.  I am just not sure whether this is good - then we will have
two refcounts for one AioContext object.

Paolo, Stefan, could you help ack on this?  If you think it's ok, I
can repost the iothread series, fixing patch 4 as Stefan suggested,
and add Fam's patch (though the atomic usage to be discussed).

Thanks,

-- 
Peter Xu
