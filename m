Received: from eggs.gnu.org ([2001:4830:134:3::10]:58636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cT6sC-0002IQ-Em
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:58:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cT6s9-0007kV-Bu
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:58:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cT6s9-0007k6-2k
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:58:53 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 291FA4E4D9
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 12:58:53 +0000 (UTC)
Date: Mon, 16 Jan 2017 12:58:47 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170116125847.GI13096@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170113131731.1246-6-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/16] io: make qio_channel_yield aware of
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
Cc: qemu-devel@nongnu.org, famz@redhat.com, stefanha@redhat.com

On Fri, Jan 13, 2017 at 02:17:20PM +0100, Paolo Bonzini wrote:
> Support separate coroutines for reading and writing, and place the
> read/write handlers on the AioContext that the QIOChannel is registered
> with.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/io/channel.h   | 37 ++++++++++++++++++----
>  io/channel.c           | 86 ++++++++++++++++++++++++++++++++++++++------------
>  tests/Makefile.include |  2 +-
>  3 files changed, 96 insertions(+), 29 deletions(-)
> 
> diff --git a/include/io/channel.h b/include/io/channel.h
> index 665edd7..d7bad94 100644
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

Need to squash in part of previous patch here.

>  #ifdef _WIN32
>      HANDLE event; /* For use with GSource on Win32 */
>  #endif
> @@ -508,13 +507,37 @@ guint qio_channel_add_watch(QIOChannel *ioc,
>  
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

Can you note that it is explicitly permitted to call this while
inside a qio_channel_yield().

> +void qio_channel_set_aio_context(QIOChannel *ioc,
> +                                 AioContext *ctx);
> +
> +/**
> + * qio_channel_detach_aio_context:
> + * @ioc: the channel object
> + *
> + * Disable any I/O handlers set by qio_channel_yield().  With the
> + * help of aio_co_schedule(), this allows moving a coroutine that was
> + * paused by qio_channel_yield() to another context.
> + */
> +void qio_channel_detach_aio_context(QIOChannel *ioc);

> diff --git a/io/channel.c b/io/channel.c
> index ce470d7..1e043bf 100644
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
> @@ -238,36 +238,80 @@ off_t qio_channel_io_seek(QIOChannel *ioc,
>  }
>  
>  
> -typedef struct QIOChannelYieldData QIOChannelYieldData;
> -struct QIOChannelYieldData {
> -    QIOChannel *ioc;
> -    Coroutine *co;
> -};
> +static void qio_channel_set_aio_fd_handlers(QIOChannel *ioc);
> +
> +static void qio_channel_restart_read(void *opaque)
> +{
> +    QIOChannel *ioc = opaque;
> +    Coroutine *co = ioc->read_coroutine;
>  
> +    ioc->read_coroutine = NULL;
> +    qio_channel_set_aio_fd_handlers(ioc);
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
> +    qio_channel_set_aio_fd_handlers(ioc);
> +    aio_co_wake(co);
>  }
>  
> +static void qio_channel_set_aio_fd_handlers(QIOChannel *ioc)
> +{
> +    IOHandler *rd_handler = NULL, *wr_handler = NULL;
> +    AioContext *ctx;
> +
> +    if (ioc->read_coroutine) {
> +	rd_handler = qio_channel_restart_read;
> +    }
> +    if (ioc->write_coroutine) {
> +	rd_handler = qio_channel_restart_write;
> +    }

Tab damage.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
