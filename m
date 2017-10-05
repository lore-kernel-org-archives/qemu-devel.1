Received: from eggs.gnu.org ([2001:4830:134:3::10]:37244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1e08Zf-0008Ez-TB
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:00:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1e08ZW-00069i-HX
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:00:35 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:32889)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1e08ZW-00068x-Aq
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:00:26 -0400
Received: by mail-oi0-x244.google.com with SMTP id n129so8829710oia.0
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 09:00:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171005155057.7664-1-berrange@redhat.com>
References: <20171005155057.7664-1-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 5 Oct 2017 18:00:24 +0200
Message-ID: <CAJ+F1CJ0P_xo+E4W2owjL6PyjiDXkpTXJe8A4ASmL9bL9V1kSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] char: don't skip client cleanup if
 'connected' flag is unset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Thu, Oct 5, 2017 at 5:50 PM, Daniel P. Berrange <berrange@redhat.com> wr=
ote:
> The tcp_chr_free_connection & tcp_chr_disconnect methods both
> skip all of their cleanup work unless the 's->connected' flag
> is set.  This flag is set when the incoming client connection
> is ready to use. Crucially this is *after* the TLS handshake
> has been completed. So if the TLS handshake fails and we try
> to cleanup the failed client, all the cleanup is skipped as
> 's->connected' is still false.
>
> The only important thing that should be skipped in this case
> is sending of the CHR_EVENT_CLOSED, because we never got as
> far as sending the corresponding CHR_EVENT_OPENED. Every other
> bit of cleanup can be robust against being called even when
> s->connected is false.
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>
> Changed in v2:
>
>  - Remove conditional checks for NULL (Marc-Andr=C3=A9)
>  - Don't use camelCase variable name (Marc-Andr=C3=A9)
>
>  chardev/char-socket.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index e65148fe97..53eda8ef00 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -332,10 +332,6 @@ static void tcp_chr_free_connection(Chardev *chr)
>      SocketChardev *s =3D SOCKET_CHARDEV(chr);
>      int i;
>
> -    if (!s->connected) {
> -        return;
> -    }
> -
>      if (s->read_msgfds_num) {
>          for (i =3D 0; i < s->read_msgfds_num; i++) {
>              close(s->read_msgfds[i]);
> @@ -394,22 +390,25 @@ static void update_disconnected_filename(SocketChar=
dev *s)
>                                           s->is_listen, s->is_telnet);
>  }
>
> +/* NB may be called even if tcp_chr_connect has not been
> + * reached, due to TLS or telnet initialization failure,
> + * so can *not* assume s->connected =3D=3D true
> + */
>  static void tcp_chr_disconnect(Chardev *chr)
>  {
>      SocketChardev *s =3D SOCKET_CHARDEV(chr);
> -
> -    if (!s->connected) {
> -        return;
> -    }
> +    bool emit_close =3D s->connected;
>
>      tcp_chr_free_connection(chr);
>
> -    if (s->listen_ioc) {
> +    if (s->listen_ioc && s->listen_tag =3D=3D 0) {
>          s->listen_tag =3D qio_channel_add_watch(
>              QIO_CHANNEL(s->listen_ioc), G_IO_IN, tcp_chr_accept, chr, NU=
LL);
>      }
>      update_disconnected_filename(s);
> -    qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
> +    if (emit_close) {
> +        qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
> +    }
>      if (s->reconnect_time) {
>          qemu_chr_socket_restart_timer(chr);
>      }
> --
> 2.13.5
>
>



--=20
Marc-Andr=C3=A9 Lureau
