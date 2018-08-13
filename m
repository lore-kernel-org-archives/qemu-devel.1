Received: from eggs.gnu.org ([2001:4830:134:3::10]:44176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fpBqV-0007t9-54
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 08:21:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fpBqR-0004uC-2x
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 08:21:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55528 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fpBqQ-0004ra-SN
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 08:21:10 -0400
Date: Mon, 13 Aug 2018 13:21:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180813122100.GE14675@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180813102037.12097-1-jusual@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180813102037.12097-1-jusual@mail.ru>
Subject: Re: [Qemu-devel] [PATCH] chardev: Add websocket support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel@nongnu.org, Jim Mussared <jim@groklearning.com>, Steffen =?utf-8?B?R8O2cnR6?= <mail@steffen-goertz.de>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, marcandre.lureau@redhat.com

On Mon, Aug 13, 2018 at 01:20:37PM +0300, Julia Suvorova via Qemu-devel wrote:
> New option "websock" added to allow using websocket protocol for
> chardev socket backend.
> Example:
>     -chardev socket,websock,id=...
> 
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>  chardev/char-socket.c | 75 ++++++++++++++++++++++++++++++++++++-------
>  chardev/char.c        |  3 ++
>  qapi/char.json        |  3 ++
>  3 files changed, 70 insertions(+), 11 deletions(-)
> 


> @@ -699,6 +706,45 @@ cont:
>  }
>  
>  
> +static void tcp_chr_websock_handshake(QIOTask *task, gpointer user_data)
> +{
> +    Chardev *chr = user_data;
> +
> +    if (qio_task_propagate_error(task, NULL)) {
> +        tcp_chr_disconnect(chr);
> +    } else {
> +        tcp_chr_connect(chr);
> +    }
> +}
> +
> +
> +static void tcp_chr_websock_init(Chardev *chr)
> +{
> +    SocketChardev *s = SOCKET_CHARDEV(chr);
> +    QIOChannelWebsock *wioc;
> +    gchar *name;
> +
> +    if (s->is_listen) {
> +        wioc = qio_channel_websock_new_server(s->ioc);
> +    } else {
> +        /* Websocket client is not yet implemented */
> +        return;
> +    }
> +    if (wioc == NULL) {
> +        tcp_chr_disconnect(chr);
> +        return;
> +    }
> +
> +    name = g_strdup_printf("chardev-websock-server-%s", chr->label);
> +    qio_channel_set_name(QIO_CHANNEL(wioc), name);
> +    g_free(name);
> +    object_unref(OBJECT(s->ioc));
> +    s->ioc = QIO_CHANNEL(wioc);
> +
> +    qio_channel_websock_handshake(wioc, tcp_chr_websock_handshake, chr, NULL);
> +}
> +
> +
>  static void tcp_chr_tls_handshake(QIOTask *task,
>                                    gpointer user_data)
>  {
> @@ -710,6 +756,8 @@ static void tcp_chr_tls_handshake(QIOTask *task,
>      } else {
>          if (s->do_telnetopt) {
>              tcp_chr_telnet_init(chr);
> +        } else if (s->is_websock) {
> +            tcp_chr_websock_init(chr);
>          } else {
>              tcp_chr_connect(chr);
>          }
> @@ -799,12 +847,12 @@ static int tcp_chr_new_client(Chardev *chr, QIOChannelSocket *sioc)
>  
>      if (s->tls_creds) {
>          tcp_chr_tls_init(chr);
> +    } else if (s->do_telnetopt) {
> +        tcp_chr_telnet_init(chr);
> +    } else if (s->is_websock) {
> +        tcp_chr_websock_init(chr);
>      } else {
> -        if (s->do_telnetopt) {
> -            tcp_chr_telnet_init(chr);
> -        } else {
> -            tcp_chr_connect(chr);
> -        }
> +        tcp_chr_connect(chr);


I don't think the ordering of init calls is correct when we have multiple options
enabled.

With tls=y & telnet=y we initialize TLS, then initialize telnet.

With tls=y & telnet=y & websock=y, we  initialize TLS, then initialize telnet and
then websock.

This means we're setting up a telnet session, and then running websocket over the top
of it.  This is wrong because there's no telnet client that exists which would be
able to use that.

The purpose of TLS & websock options in combination with telnet is to allow a normal
telnet session to be tunnelled over a TLS+websocket proxy.

So we must initailize TLS, then websock, then telnet


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
