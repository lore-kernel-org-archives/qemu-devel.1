Received: from eggs.gnu.org ([209.51.188.92]:38105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gtVNp-00020L-8f
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 05:33:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gtVNn-0007Fu-C2
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 05:33:45 -0500
Date: Tue, 12 Feb 2019 10:33:16 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190212103316.GG9386@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190211125601.86533-1-vsementsov@virtuozzo.com>
	<20190211125601.86533-2-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190211125601.86533-2-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] io/channel: add
 qio_channel_get_attached_aio_context()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, den@openvz.org

On Mon, Feb 11, 2019 at 03:55:58PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Expose attached aio context. It will be used in nbd code, to
> understand, in which aio context negotiation should be done.

I'm not especially objecting to the idea of adding the API to the
QIOChannel class, but I'm surprised that NBD needs this. Surely it
already knows what AIO context it assigned to the channel in the
first place. IOW, it feels like this is papering over a limitation
in NBD not keeping track of what AIO context it should be using.

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/io/channel.h | 9 +++++++++
>  io/channel.c         | 5 +++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/include/io/channel.h b/include/io/channel.h
> index da2f138200..1a1e4a01b0 100644
> --- a/include/io/channel.h
> +++ b/include/io/channel.h
> @@ -718,6 +718,15 @@ GSource *qio_channel_add_watch_source(QIOChannel *ioc,
>  void qio_channel_attach_aio_context(QIOChannel *ioc,
>                                      AioContext *ctx);
>  
> +/*
> + * qio_channel_get_aio_context
> + * @ioc: the channel object
> + *
> + * Returns channel AioContext if any attached by
> + * qio_channel_attach_aio_context(), otherwise NULL.
> + */
> +AioContext *qio_channel_get_attached_aio_context(QIOChannel *ioc);
> +
>  /**
>   * qio_channel_detach_aio_context:
>   * @ioc: the channel object
> diff --git a/io/channel.c b/io/channel.c
> index 8dd0684f5d..a1b937bb6b 100644
> --- a/io/channel.c
> +++ b/io/channel.c
> @@ -454,6 +454,11 @@ void qio_channel_detach_aio_context(QIOChannel *ioc)
>      ioc->ctx = NULL;
>  }
>  
> +AioContext *qio_channel_get_attached_aio_context(QIOChannel *ioc)
> +{
> +    return ioc->ctx;
> +}
> +
>  void coroutine_fn qio_channel_yield(QIOChannel *ioc,
>                                      GIOCondition condition)
>  {
> -- 
> 2.18.0
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
