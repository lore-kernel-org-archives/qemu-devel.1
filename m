Received: from eggs.gnu.org ([209.51.188.92]:50810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gjVrB-0001ji-GR
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:02:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gjVr9-0008Tb-7M
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:02:45 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41528)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gjVr0-0008PK-UG
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:02:38 -0500
Received: by mail-qk1-f196.google.com with SMTP id 189so2437379qkj.8
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 13:02:28 -0800 (PST)
MIME-Version: 1.0
References: <20190115145256.9593-1-berrange@redhat.com>
	<20190115145256.9593-9-berrange@redhat.com>
In-Reply-To: <20190115145256.9593-9-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 16 Jan 2019 01:02:16 +0400
Message-ID: <CAMxuvaw2srtr-8F9FVY0ZDDxPos9Q6vVBhLC1oFgXJuiNvP3Uw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/12] chardev: split up
 qmp_chardev_open_socket connection code
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

On Tue, Jan 15, 2019 at 6:53 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> In qmp_chardev_open_socket the code for connecting client chardevs is
> split across two conditionals far apart with some server chardev code in
> the middle. Split up the method so that code for client connection setup
> is separate from code for server connection setup.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  chardev/char-socket.c | 96 +++++++++++++++++++++++++++----------------
>  1 file changed, 60 insertions(+), 36 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 3bd1be7631..385504b021 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1005,6 +1005,61 @@ static gboolean socket_reconnect_timeout(gpointer =
opaque)
>  }
>
>
> +static int qmp_chardev_open_socket_server(Chardev *chr,
> +                                          bool is_telnet,
> +                                          bool is_waitconnect,
> +                                          Error **errp)
> +{
> +    SocketChardev *s =3D SOCKET_CHARDEV(chr);
> +    char *name;
> +    if (is_telnet) {
> +        s->do_telnetopt =3D 1;
> +    }
> +    s->listener =3D qio_net_listener_new();
> +
> +    name =3D g_strdup_printf("chardev-tcp-listener-%s", chr->label);
> +    qio_net_listener_set_name(s->listener, name);
> +    g_free(name);
> +
> +    if (qio_net_listener_open_sync(s->listener, s->addr, errp) < 0) {
> +        object_unref(OBJECT(s->listener));
> +        s->listener =3D NULL;
> +        return -1;
> +    }
> +
> +    qapi_free_SocketAddress(s->addr);
> +    s->addr =3D socket_local_address(s->listener->sioc[0]->fd, errp);
> +    update_disconnected_filename(s);
> +
> +    if (is_waitconnect) {
> +        tcp_chr_accept_server_sync(chr);
> +    } else {
> +        qio_net_listener_set_client_func_full(s->listener,
> +                                              tcp_chr_accept,
> +                                              chr, NULL,
> +                                              chr->gcontext);
> +    }
> +
> +    return 0;
> +}
> +
> +
> +static int qmp_chardev_open_socket_client(Chardev *chr,
> +                                          int64_t reconnect,
> +                                          Error **errp)
> +{
> +    SocketChardev *s =3D SOCKET_CHARDEV(chr);
> +
> +    if (reconnect > 0) {
> +        s->reconnect_time =3D reconnect;
> +        tcp_chr_connect_client_async(chr);
> +        return 0;
> +    } else {
> +        return tcp_chr_connect_client_sync(chr, errp);
> +    }
> +}
> +
> +
>  static bool qmp_chardev_validate_socket(ChardevSocket *sock,
>                                          SocketAddress *addr,
>                                          Error **errp)
> @@ -1147,44 +1202,13 @@ static void qmp_chardev_open_socket(Chardev *chr,
>
>      update_disconnected_filename(s);
>
> -    if (is_listen) {
> -        if (is_telnet || is_tn3270) {
> -            s->do_telnetopt =3D 1;
> +    if (s->is_listen) {
> +        if (qmp_chardev_open_socket_server(chr, is_telnet || is_tn3270,
> +                                           is_waitconnect, errp) < 0) {
> +            return;
>          }
> -    } else if (reconnect > 0) {
> -        s->reconnect_time =3D reconnect;
> -    }
> -
> -    if (s->reconnect_time) {
> -        tcp_chr_connect_client_async(chr);
>      } else {
> -        if (s->is_listen) {
> -            char *name;
> -            s->listener =3D qio_net_listener_new();
> -
> -            name =3D g_strdup_printf("chardev-tcp-listener-%s", chr->lab=
el);
> -            qio_net_listener_set_name(s->listener, name);
> -            g_free(name);
> -
> -            if (qio_net_listener_open_sync(s->listener, s->addr, errp) <=
 0) {
> -                object_unref(OBJECT(s->listener));
> -                s->listener =3D NULL;
> -                return;
> -            }
> -
> -            qapi_free_SocketAddress(s->addr);
> -            s->addr =3D socket_local_address(s->listener->sioc[0]->fd, e=
rrp);
> -            update_disconnected_filename(s);
> -
> -            if (is_waitconnect) {
> -                tcp_chr_accept_server_sync(chr);
> -            } else {
> -                qio_net_listener_set_client_func_full(s->listener,
> -                                                      tcp_chr_accept,
> -                                                      chr, NULL,
> -                                                      chr->gcontext);
> -            }
> -        } else if (tcp_chr_connect_client_sync(chr, errp) < 0) {
> +        if (qmp_chardev_open_socket_client(chr, reconnect, errp) < 0) {
>              return;
>          }
>      }
> --
> 2.20.1
>
