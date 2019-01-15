Received: from eggs.gnu.org ([209.51.188.92]:38940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gjUdp-0005rv-BD
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:44:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gjUdm-0004ZP-PX
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:44:52 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41233)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gjUdm-0004YU-Hu
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:44:50 -0500
Received: by mail-qt1-f196.google.com with SMTP id l12so4372652qtf.8
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 11:44:50 -0800 (PST)
MIME-Version: 1.0
References: <20190115145256.9593-1-berrange@redhat.com>
	<20190115145256.9593-8-berrange@redhat.com>
In-Reply-To: <20190115145256.9593-8-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 15 Jan 2019 23:44:37 +0400
Message-ID: <CAMxuvaw7jvuQdC1CNwXn6Cm0CUm8fYFHRiVBac-=bPpudXru+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/12] chardev: split
 tcp_chr_wait_connected into two methods
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Yongji Xie <elohimes@gmail.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi

On Tue, Jan 15, 2019 at 6:53 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> The tcp_chr_wait_connected method can deal with either server or client
> chardevs, but some callers only care about one of these possibilities.
> The tcp_chr_wait_connected method will also need some refactoring to
> reliably deal with its primary goal of allowing a device frontend to
> wait for an established connection, which will interfere with other
> callers.
>
> Split it into two methods, one responsible for server initiated
> connections, the other responsible for client initiated connections.
> In doing this split the tcp_char_connect_async() method is renamed
> to become consistent with naming of the new methods.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  chardev/char-socket.c | 59 +++++++++++++++++++++++++++----------------
>  1 file changed, 37 insertions(+), 22 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 3b6ff6619b..3bd1be7631 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -886,30 +886,47 @@ static void tcp_chr_accept(QIONetListener *listener=
,
>      tcp_chr_new_client(chr, cioc);
>  }
>
> -static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
> +
> +static int tcp_chr_connect_client_sync(Chardev *chr, Error **errp)
> +{
> +    SocketChardev *s =3D SOCKET_CHARDEV(chr);
> +    QIOChannelSocket *sioc =3D qio_channel_socket_new();
> +    tcp_chr_set_client_ioc_name(chr, sioc);
> +    if (qio_channel_socket_connect_sync(sioc, s->addr, errp) < 0) {
> +        object_unref(OBJECT(sioc));
> +        return -1;
> +    }
> +    tcp_chr_new_client(chr, sioc);
> +    object_unref(OBJECT(sioc));
> +    return 0;
> +}
> +
> +
> +static void tcp_chr_accept_server_sync(Chardev *chr)
>  {
>      SocketChardev *s =3D SOCKET_CHARDEV(chr);
>      QIOChannelSocket *sioc;
> +    info_report("QEMU waiting for connection on: %s",
> +                chr->filename);
> +    sioc =3D qio_net_listener_wait_client(s->listener);
> +    tcp_chr_set_client_ioc_name(chr, sioc);
> +    tcp_chr_new_client(chr, sioc);
> +    object_unref(OBJECT(sioc));
> +}
> +
>
> +static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
> +{
> +    SocketChardev *s =3D SOCKET_CHARDEV(chr);
>      /* It can't wait on s->connected, since it is set asynchronously
>       * in TLS and telnet cases, only wait for an accepted socket */
>      while (!s->ioc) {
>          if (s->is_listen) {
> -            info_report("QEMU waiting for connection on: %s",
> -                        chr->filename);
> -            sioc =3D qio_net_listener_wait_client(s->listener);
> -            tcp_chr_set_client_ioc_name(chr, sioc);
> -            tcp_chr_new_client(chr, sioc);
> -            object_unref(OBJECT(sioc));
> +            tcp_chr_accept_server_sync(chr);
>          } else {
> -            sioc =3D qio_channel_socket_new();
> -            tcp_chr_set_client_ioc_name(chr, sioc);
> -            if (qio_channel_socket_connect_sync(sioc, s->addr, errp) < 0=
) {
> -                object_unref(OBJECT(sioc));
> +            if (tcp_chr_connect_client_sync(chr, errp) < 0) {
>                  return -1;
>              }
> -            tcp_chr_new_client(chr, sioc);
> -            object_unref(OBJECT(sioc));
>          }
>      }
>
> @@ -958,7 +975,7 @@ cleanup:
>      object_unref(OBJECT(sioc));
>  }
>
> -static void tcp_chr_connect_async(Chardev *chr)
> +static void tcp_chr_connect_client_async(Chardev *chr)
>  {
>      SocketChardev *s =3D SOCKET_CHARDEV(chr);
>      QIOChannelSocket *sioc;
> @@ -982,7 +999,7 @@ static gboolean socket_reconnect_timeout(gpointer opa=
que)
>          return false;
>      }
>
> -    tcp_chr_connect_async(chr);
> +    tcp_chr_connect_client_async(chr);
>
>      return false;
>  }
> @@ -1139,7 +1156,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
>      }
>
>      if (s->reconnect_time) {
> -        tcp_chr_connect_async(chr);
> +        tcp_chr_connect_client_async(chr);
>      } else {
>          if (s->is_listen) {
>              char *name;
> @@ -1159,17 +1176,15 @@ static void qmp_chardev_open_socket(Chardev *chr,
>              s->addr =3D socket_local_address(s->listener->sioc[0]->fd, e=
rrp);
>              update_disconnected_filename(s);
>
> -            if (is_waitconnect &&
> -                qemu_chr_wait_connected(chr, errp) < 0) {
> -                return;
> -            }
> -            if (!s->ioc) {
> +            if (is_waitconnect) {
> +                tcp_chr_accept_server_sync(chr);

Is the wait_connected() loop really unnecessary there? looks like it
is. And there is no error path either. ok

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> +            } else {
>                  qio_net_listener_set_client_func_full(s->listener,
>                                                        tcp_chr_accept,
>                                                        chr, NULL,
>                                                        chr->gcontext);
>              }
> -        } else if (qemu_chr_wait_connected(chr, errp) < 0) {
> +        } else if (tcp_chr_connect_client_sync(chr, errp) < 0) {
>              return;
>          }
>      }
> --
> 2.20.1
>
