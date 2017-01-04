Received: from eggs.gnu.org ([2001:4830:134:3::10]:55732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cOpCr-0000FE-48
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 12:18:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cOpCn-0001Bj-Pe
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 12:18:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cOpCn-0001BW-HM
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 12:18:29 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8A9F64D68E
	for <qemu-devel@nongnu.org>; Wed,  4 Jan 2017 17:18:29 +0000 (UTC)
Date: Wed, 4 Jan 2017 17:18:23 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170104171823.GJ10541@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20161223182641.2718-1-pbonzini@redhat.com>
	<20161223182641.2718-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161223182641.2718-3-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] io: make qio_channel_yield aware of
 AioContexts
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

On Fri, Dec 23, 2016 at 07:26:40PM +0100, Paolo Bonzini wrote:
> Support separate coroutines for reading and writing, and
> restart the coroutine on the AioContext where it was suspended on.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/io/channel.h |  7 +++---
>  io/channel-socket.c  | 12 +++++-----
>  io/channel.c         | 62 ++++++++++++++++++++++++++++++++++------------------
>  3 files changed, 50 insertions(+), 31 deletions(-)
> 
> diff --git a/include/io/channel.h b/include/io/channel.h
> index 248bc76..3030fdb 100644
> --- a/include/io/channel.h
> +++ b/include/io/channel.h
> @@ -23,6 +23,7 @@
>  
>  #include "qemu-common.h"
>  #include "qom/object.h"
> +#include "qemu/coroutine.h"
>  #include "block/aio.h"
>  
>  #define TYPE_QIO_CHANNEL "qio-channel"
> @@ -59,8 +60,6 @@ typedef gboolean (*QIOChannelFunc)(QIOChannel *ioc,
>                                     GIOCondition condition,
>                                     gpointer data);
>  
> -typedef struct QIOChannelRestart QIOChannelRestart;
> -
>  /**
>   * QIOChannel:
>   *
> @@ -84,8 +83,8 @@ struct QIOChannel {
>      unsigned int features; /* bitmask of QIOChannelFeatures */
>      char *name;
>      AioContext *ctx;
> -    QIOChannelRestart *read_coroutine;
> -    QIOChannelRestart *write_coroutine;
> +    Coroutine *read_coroutine;
> +    Coroutine *write_coroutine;

Seems this ought to have been squashed into the previous patch

> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index 4d5f180..732ba20 100644
> --- a/io/channel-socket.c
> +++ b/io/channel-socket.c
> @@ -740,14 +740,14 @@ qio_channel_socket_shutdown(QIOChannel *ioc,
>      return 0;
>  }
>  
> -static GSource *qio_channel_socket_set_fd_handler(QIOChannel *ioc,
> -                                                  AioContext *ctx,
> -                                                  IOHandler *io_read,
> -                                                  IOHandler *io_write,
> -                                                  void *opaque)
> +static void qio_channel_socket_set_fd_handler(QIOChannel *ioc,
> +                                              AioContext *ctx,
> +                                              IOHandler *io_read,
> +                                              IOHandler *io_write,
> +                                              void *opaque)
>  {
>      QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
> -    aio_set_fd_handler(ctx, sioc->fd, false, io_read, io_write, opaque);
> +    aio_set_fd_handler(ctx, sioc->fd, false, io_read, io_write, NULL, opaque);
>  }

And this ought to be in previous patch  too.

>  
> diff --git a/io/channel.c b/io/channel.c
> index 9ef683c..d4b3a5a3 100644
> --- a/io/channel.c
> +++ b/io/channel.c
> @@ -21,7 +21,7 @@
>  #include "qemu/osdep.h"
>  #include "io/channel.h"
>  #include "qapi/error.h"
> -#include "qemu/coroutine.h"
> +#include "qemu/main-loop.h"
>  
>  bool qio_channel_has_feature(QIOChannel *ioc,
>                               QIOChannelFeature feature)
> @@ -238,22 +238,43 @@ off_t qio_channel_io_seek(QIOChannel *ioc,
>  }
>  
>  
> -typedef struct QIOChannelYieldData QIOChannelYieldData;
> -struct QIOChannelYieldData {
> -    QIOChannel *ioc;
> -    Coroutine *co;
> -};
> +static void qio_channel_set_fd_handlers(QIOChannel *ioc);
> +
> +static void qio_channel_restart_read(void *opaque)
> +{
> +    QIOChannel *ioc = opaque;
> +    Coroutine *co = ioc->read_coroutine;
>  
> +    ioc->read_coroutine = NULL;
> +    qio_channel_set_fd_handlers(ioc);
> +    aio_co_wake(co);
> +}
>  
> -static gboolean qio_channel_yield_enter(QIOChannel *ioc,
> -                                        GIOCondition condition,
> -                                        gpointer opaque)
> +static void qio_channel_restart_write(void *opaque)
>  {
> -    QIOChannelYieldData *data = opaque;
> -    qemu_coroutine_enter(data->co);
> -    return FALSE;
> +    QIOChannel *ioc = opaque;
> +    Coroutine *co = ioc->write_coroutine;
> +
> +    ioc->write_coroutine = NULL;
> +    qio_channel_set_fd_handlers(ioc);
> +    aio_co_wake(co);
>  }
>  
> +static void qio_channel_set_fd_handlers(QIOChannel *ioc)
> +{
> +    IOHandler *rd_handler = NULL, *wr_handler = NULL;
> +
> +    if (ioc->read_coroutine) {
> +	rd_handler = qio_channel_restart_read;
> +    }
> +    if (ioc->write_coroutine) {
> +	rd_handler = qio_channel_restart_write;
> +    }
> +
> +    qio_channel_set_fd_handler(ioc,
> +                               ioc->ctx ? ioc->ctx : iohandler_get_aio_context(),
> +                               rd_handler, wr_handler, ioc);
> +}

ioc->read_coroutine & ioc->write_coroutine can only be non-NULL during
a qio_channel_yield() caller. So it seems that calling
qio_channel_set_fd_handlers() from the qio_channel_set_aio_context()
method in the previous patch is not required, as those two callback
pointers will always be NULL.

> @@ -272,16 +293,15 @@ void qio_channel_set_aio_context(QIOChannel *ioc,
>  void coroutine_fn qio_channel_yield(QIOChannel *ioc,
>                                      GIOCondition condition)
>  {
> -    QIOChannelYieldData data;
> -
>      assert(qemu_in_coroutine());
> -    data.ioc = ioc;
> -    data.co = qemu_coroutine_self();
> -    qio_channel_add_watch(ioc,
> -                          condition,
> -                          qio_channel_yield_enter,
> -                          &data,
> -                          NULL);
> +    if (condition == G_IO_IN) {
> +        ioc->read_coroutine = qemu_coroutine_self();
> +    } else if (condition == G_IO_OUT) {
> +        ioc->write_coroutine = qemu_coroutine_self();
> +    } else {
> +        abort();
> +    }

Do we really need this to be an either/or/abort ? It looks like
the qio_channel_set_fd_handlers() method is happy top have both
read_coroutine & write_coroutine set.

If it does need to be exclusive though, can you update the API
docs for this method to mention that.

> +    qio_channel_set_fd_handlers(ioc);
>      qemu_coroutine_yield();
>  }

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
