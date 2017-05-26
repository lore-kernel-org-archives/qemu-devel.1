Received: from eggs.gnu.org ([2001:4830:134:3::10]:53729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dEC1W-000565-NX
	for qemu-devel@nongnu.org; Fri, 26 May 2017 05:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dEC1S-0001Bj-SS
	for qemu-devel@nongnu.org; Fri, 26 May 2017 05:59:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dEC1S-0001Ba-MQ
	for qemu-devel@nongnu.org; Fri, 26 May 2017 05:59:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3D6B6F804C
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 09:59:05 +0000 (UTC)
Date: Fri, 26 May 2017 10:59:01 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170526095901.GB24484@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170526093641.7159-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170526093641.7159-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] io: simplify qio_channel_attach_aio_context
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

On Fri, May 26, 2017 at 11:36:41AM +0200, Paolo Bonzini wrote:
> If properly preceded by qio_channel_detach_aio_context, this function really
> has nothing to do except setting ioc->ctx.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  io/channel.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/io/channel.c b/io/channel.c
> index cdf74540c1..1cfb8b33a2 100644
> --- a/io/channel.c
> +++ b/io/channel.c
> @@ -279,15 +279,9 @@ static void qio_channel_set_aio_fd_handlers(QIOChannel *ioc)
>  void qio_channel_attach_aio_context(QIOChannel *ioc,
>                                      AioContext *ctx)
>  {
> -    AioContext *old_ctx;
> -    if (ioc->ctx == ctx) {
> -        return;
> -    }
> -
> -    old_ctx = ioc->ctx ? ioc->ctx : iohandler_get_aio_context();
> -    qio_channel_set_aio_fd_handler(ioc, old_ctx, NULL, NULL, NULL);
> +    assert(!ioc->read_coroutine);
> +    assert(!ioc->write_coroutine);
>      ioc->ctx = ctx;
> -    qio_channel_set_aio_fd_handlers(ioc);
>  }
>  
>  void qio_channel_detach_aio_context(QIOChannel *ioc)

Thanks, queued

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
