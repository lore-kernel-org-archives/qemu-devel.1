Received: from eggs.gnu.org ([2001:4830:134:3::10]:47816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1er1h5-0005GC-3w
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 08:22:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1er1h1-00056E-4G
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 08:22:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33332 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1er1h0-000561-Vr
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 08:22:47 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 94F8F402290A
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 13:22:46 +0000 (UTC)
Date: Wed, 28 Feb 2018 13:22:37 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180228132237.GK17774@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180228050633.7410-1-peterx@redhat.com>
	<20180228050633.7410-15-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180228050633.7410-15-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 14/14] qio/chardev: specify gcontext for
 TLS handshake
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Feb 28, 2018 at 01:06:33PM +0800, Peter Xu wrote:
> We allow the TLS code to be run with non-default gcontext by providing a
> new qio_channel_tls_handshake_full() API.
> 
> With the new API, we can re-setup the TLS handshake GSource by calling
> it again with the correct gcontext.  Any call to the function will clean
> up existing GSource tasks, and re-setup using the new gcontext.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  chardev/char-socket.c    | 30 +++++++++++++---
>  include/io/channel-tls.h | 22 +++++++++++-
>  io/channel-tls.c         | 91 ++++++++++++++++++++++++++++++++++++++++--------
>  3 files changed, 123 insertions(+), 20 deletions(-)
> 
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 164a64ff34..406d33c04f 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -72,6 +72,9 @@ typedef struct {
>  
>  static gboolean socket_reconnect_timeout(gpointer opaque);
>  static void tcp_chr_telnet_init(Chardev *chr);
> +static void tcp_chr_tls_handshake_setup(Chardev *chr,
> +                                        QIOChannelTLS *tioc,
> +                                        GMainContext *context);
>  
>  static void tcp_chr_reconn_timer_cancel(SocketChardev *s)
>  {
> @@ -570,6 +573,7 @@ static void tcp_chr_telnet_destroy(SocketChardev *s)
>  static void tcp_chr_update_read_handler(Chardev *chr)
>  {
>      SocketChardev *s = SOCKET_CHARDEV(chr);
> +    QIOChannelTLS *tioc;
>  
>      if (s->listener) {
>          /*
> @@ -589,6 +593,17 @@ static void tcp_chr_update_read_handler(Chardev *chr)
>          qio_task_context_set(s->thread_task, chr->gcontext);
>      }
>  
> +    tioc = (QIOChannelTLS *)object_dynamic_cast(OBJECT(s->ioc),
> +                                                TYPE_QIO_CHANNEL_TLS);
> +    if (tioc) {
> +        /*
> +         * TLS session enabled; reconfigure things up.  Note that, if
> +         * there is existing handshake task, it'll be cleaned up first
> +         * in QIO code.
> +         */
> +        tcp_chr_tls_handshake_setup(chr, tioc, chr->gcontext);
> +    }

This is crazy - we should not be looking at specific implementations of
the channel. If the TLS object needs to use a specific GMainContext we
should make sure that is done right from the start and not try to change
the GMainContext on the fly.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
