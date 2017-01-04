Received: from eggs.gnu.org ([2001:4830:134:3::10]:54238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cOp8s-0006tA-TU
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 12:14:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cOp8p-00069Z-1g
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 12:14:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cOp8o-00068c-PG
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 12:14:22 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D29BA4DB8A
	for <qemu-devel@nongnu.org>; Wed,  4 Jan 2017 17:14:22 +0000 (UTC)
Date: Wed, 4 Jan 2017 17:14:17 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170104171417.GI10541@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20161223182641.2718-1-pbonzini@redhat.com>
	<20161223182641.2718-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161223182641.2718-2-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] io: add methods to set I/O handlers on
 AioContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, Dec 23, 2016 at 07:26:39PM +0100, Paolo Bonzini wrote:
> This is in preparation for making qio_channel_yield work on
> AioContexts other than the main one.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/io/channel.h | 42 ++++++++++++++++++++++++++++++++++++++++++
>  io/channel-socket.c  | 16 +++++++++++-----
>  io/channel-tls.c     | 12 ++++++++++++
>  io/channel-watch.c   |  6 ++++++
>  io/channel.c         | 25 +++++++++++++++++++++++++
>  5 files changed, 96 insertions(+), 5 deletions(-)
> 

>  /**
> + * qio_channel_set_aio_context:
> + * @ioc: the channel object
> + * @ctx: the #AioContext to set the handlers on
> + *
> + * Request that qio_channel_yield() sets I/O handlers on
> + * the given #AioContext.  If @ctx is %NULL, qio_channel_yield()
> + * uses QEMU's main thread event loop.
> + */
> +void qio_channel_set_aio_context(QIOChannel *ioc,
> +                                 AioContext *ctx);
> +
> +/**
>   * qio_channel_yield:
>   * @ioc: the channel object
>   * @condition: the I/O condition to wait for
> @@ -525,4 +548,23 @@ void qio_channel_yield(QIOChannel *ioc,
>  void qio_channel_wait(QIOChannel *ioc,
>                        GIOCondition condition);
>  
> +/**
> + * qio_channel_set_fd_handler:
> + * @ioc: the channel object
> + * @ctx: the AioContext to set the handlers on
> + * @io_read: the read handler
> + * @io_write: the write handler
> + * @opaque: the opaque value passed to the handler
> + *
> + * This is used internally by qio_channel_yield().  It can
> + * be used by channel implementations to forward the handlers
> + * to another channel (e.g. from #QIOChannelTLS to the
> + * underlying socket).
> + */
> +void qio_channel_set_fd_handler(QIOChannel *ioc,
> +                                AioContext *ctx,
> +                                IOHandler *io_read,
> +                                IOHandler *io_write,
> +                                void *opaque);

nitpick - could we call set  '...set_aio_fd_handler' or '..set_aio_handler'

> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index d7e03f6..4d5f180 100644
> --- a/io/channel-socket.c
> +++ b/io/channel-socket.c

> diff --git a/io/channel.c b/io/channel.c
> index 80924c1..9ef683c 100644
> --- a/io/channel.c
> +++ b/io/channel.c

> @@ -244,6 +255,20 @@ static gboolean qio_channel_yield_enter(QIOChannel *ioc,
>  }
>  
>  
> +void qio_channel_set_aio_context(QIOChannel *ioc,
> +                                 AioContext *ctx)
> +{
> +    if (ioc->ctx == ctx) {
> +        return;
> +    }
> +
> +    qio_channel_set_fd_handler(ioc,
> +                               ioc->ctx ? ioc->ctx : iohandler_get_aio_context(),

Max line length exceeded.

> +                               NULL, NULL, NULL);
> +    ioc->ctx = ctx;
> +    qio_channel_set_fd_handlers(ioc);

This method does not exist in this patch - only added by the next
patch.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
