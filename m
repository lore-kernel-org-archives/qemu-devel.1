Received: from eggs.gnu.org ([2001:4830:134:3::10]:56061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1erQRt-0000pC-5F
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:48:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1erQRs-0005uI-A6
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:48:49 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55244 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1erQRs-0005tY-4O
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:48:48 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A7E3DEAEB3
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 15:48:47 +0000 (UTC)
Date: Thu, 1 Mar 2018 15:48:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180301154844.GQ14643@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180301084438.13594-1-peterx@redhat.com>
	<20180301084438.13594-11-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180301084438.13594-11-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 10/15] qio: non-default context for
 async conn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Mar 01, 2018 at 04:44:33PM +0800, Peter Xu wrote:
> We have worked on qio_task_run_in_thread() already.  Further, let
> qio_channel_socket_connect_async() pass that context to it.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  chardev/char-socket.c          | 4 ++--
>  include/io/channel-socket.h    | 4 +++-
>  io/channel-socket.c            | 5 +++--
>  migration/socket.c             | 3 ++-
>  tests/test-io-channel-socket.c | 2 +-
>  5 files changed, 11 insertions(+), 7 deletions(-)

> diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
> index 53801f6042..90f7227397 100644
> --- a/include/io/channel-socket.h
> +++ b/include/io/channel-socket.h
> @@ -101,6 +101,7 @@ int qio_channel_socket_connect_sync(QIOChannelSocket *ioc,
>   * @callback: the function to invoke on completion
>   * @opaque: user data to pass to @callback
>   * @destroy: the function to free @opaque
> + * @context: the context to run the async task
>   *
>   * Attempt to connect to the address @addr. This method
>   * will run in the background so the caller will regain
> @@ -113,7 +114,8 @@ void qio_channel_socket_connect_async(QIOChannelSocket *ioc,
>                                        SocketAddress *addr,
>                                        QIOTaskFunc callback,
>                                        gpointer opaque,
> -                                      GDestroyNotify destroy);
> +                                      GDestroyNotify destroy,
> +                                      GMainContext *context);

If you're going to add a GMainContext() to connect_async, then please
also do it for listen_async and dgram_async at the same time, so we
remain consistent in API design.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
