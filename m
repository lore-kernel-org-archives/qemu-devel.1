Received: from eggs.gnu.org ([2001:4830:134:3::10]:54064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1erQN0-0005nv-75
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:43:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1erQMw-0002p5-7l
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:43:46 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47938 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1erQMw-0002op-2Z
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:43:42 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9EC6A402291E
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 15:43:41 +0000 (UTC)
Date: Thu, 1 Mar 2018 15:43:31 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180301154331.GN14643@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180301084438.13594-1-peterx@redhat.com>
	<20180301084438.13594-8-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180301084438.13594-8-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 07/15] qio/chardev: update net listener
 gcontext
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

On Thu, Mar 01, 2018 at 04:44:30PM +0800, Peter Xu wrote:
> TCP chardevs can be using QIO network listeners working in the
> background when in listening mode.  However the network listeners are
> always running in main context.  This can race with chardevs that are
> running in non-main contexts.
> 
> To solve this, we need to re-setup the net listeners in
> tcp_chr_update_read_handler() with the newly cached gcontext.
> 
> Since at it, generalize a tcp_chr_net_listener_setup() helper function
> and clean up the old code a bit.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  chardev/char-socket.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 43a2cc2c1c..5cd20cc932 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -410,6 +410,19 @@ static void update_disconnected_filename(SocketChardev *s)
>                                           s->is_listen, s->is_telnet);
>  }
>  
> +/* Set enable=true to start net listeners, false to stop them. */
> +static void tcp_chr_net_listener_setup(SocketChardev *s, bool enable)
> +{
> +    Chardev *chr = CHARDEV(s);
> +
> +    /* Net listeners' context will follow the Chardev's. */
> +    qio_net_listener_set_client_func_full(s->listener,
> +                                          enable ? tcp_chr_accept : NULL,
> +                                          enable ? chr : NULL,
> +                                          NULL,
> +                                          chr->gcontext);

I don't think this helper method is really a benefit. In fact I think
it makes understanding the code harder, because when you see
tcp_chr_net_listener_setup(s, true), you've no idea what 'true' means
without going to finding the impl of tcp_chr_net_listener_setup().

Just leave the direct calls to qio_net_listener_set_client_func_full
as they are IMHO.

> +}
> +
>  /* NB may be called even if tcp_chr_connect has not been
>   * reached, due to TLS or telnet initialization failure,
>   * so can *not* assume s->connected == true
> @@ -422,8 +435,7 @@ static void tcp_chr_disconnect(Chardev *chr)
>      tcp_chr_free_connection(chr);
>  
>      if (s->listener) {
> -        qio_net_listener_set_client_func(s->listener, tcp_chr_accept,
> -                                         chr, NULL);
> +        tcp_chr_net_listener_setup(s, true);
>      }
>      update_disconnected_filename(s);
>      if (emit_close) {
> @@ -559,6 +571,15 @@ static void tcp_chr_update_read_handler(Chardev *chr)
>  {
>      SocketChardev *s = SOCKET_CHARDEV(chr);
>  
> +    if (s->listener) {
> +        /*
> +         * It's possible that chardev context is changed in
> +         * qemu_chr_be_update_read_handlers().  Reset it for QIO net
> +         * listener if there is.
> +         */
> +        tcp_chr_net_listener_setup(s, true);
> +    }
> +
>      if (!s->connected) {
>          return;
>      }
> @@ -742,7 +763,7 @@ static int tcp_chr_new_client(Chardev *chr, QIOChannelSocket *sioc)
>          qio_channel_set_delay(s->ioc, false);
>      }
>      if (s->listener) {
> -        qio_net_listener_set_client_func(s->listener, NULL, NULL, NULL);
> +        tcp_chr_net_listener_setup(s, false);
>      }
>  
>      if (s->tls_creds) {
> @@ -823,7 +844,7 @@ static void char_socket_finalize(Object *obj)
>      tcp_chr_reconn_timer_cancel(s);
>      qapi_free_SocketAddress(s->addr);
>      if (s->listener) {
> -        qio_net_listener_set_client_func(s->listener, NULL, NULL, NULL);
> +        tcp_chr_net_listener_setup(s, false);
>          object_unref(OBJECT(s->listener));
>      }
>      if (s->tls_creds) {
> @@ -979,8 +1000,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
>                  return;
>              }
>              if (!s->ioc) {
> -                qio_net_listener_set_client_func(s->listener, tcp_chr_accept,
> -                                                 chr, NULL);
> +                tcp_chr_net_listener_setup(s, true);
>              }
>          } else if (qemu_chr_wait_connected(chr, errp) < 0) {
>              goto error;
> -- 
> 2.14.3
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
