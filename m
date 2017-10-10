Received: from eggs.gnu.org ([2001:4830:134:3::10]:55751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1rdl-00012z-LC
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:19:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1rdg-0005k0-MO
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:19:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e1rdg-0005jD-Cu
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:19:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 800EA7F7B9
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 10:19:51 +0000 (UTC)
References: <20171005155057.7664-1-berrange@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0794df8a-e56c-c77f-e269-e9b7d226dd67@redhat.com>
Date: Tue, 10 Oct 2017 12:19:43 +0200
MIME-Version: 1.0
In-Reply-To: <20171005155057.7664-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 05/10/2017 17:50, Daniel P. Berrange wrote:
> The tcp_chr_free_connection & tcp_chr_disconnect methods both
> skip all of their cleanup work unless the 's->connected' flag
> is set.  This flag is set when the incoming client connection
> is ready to use. Crucially this is *after* the TLS handshake
> has been completed. So if the TLS handshake fails and we try
> to cleanup the failed client, all the cleanup is skipped as
> 's->connected' is still false.
>=20
> The only important thing that should be skipped in this case
> is sending of the CHR_EVENT_CLOSED, because we never got as
> far as sending the corresponding CHR_EVENT_OPENED. Every other
> bit of cleanup can be robust against being called even when
> s->connected is false.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>=20
> Changed in v2:
>=20
>  - Remove conditional checks for NULL (Marc-Andr=C3=A9)
>  - Don't use camelCase variable name (Marc-Andr=C3=A9)
>=20
>  chardev/char-socket.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>=20
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index e65148fe97..53eda8ef00 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -332,10 +332,6 @@ static void tcp_chr_free_connection(Chardev *chr)
>      SocketChardev *s =3D SOCKET_CHARDEV(chr);
>      int i;
> =20
> -    if (!s->connected) {
> -        return;
> -    }
> -
>      if (s->read_msgfds_num) {
>          for (i =3D 0; i < s->read_msgfds_num; i++) {
>              close(s->read_msgfds[i]);
> @@ -394,22 +390,25 @@ static void update_disconnected_filename(SocketCh=
ardev *s)
>                                           s->is_listen, s->is_telnet);
>  }
> =20
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
> =20
>      tcp_chr_free_connection(chr);
> =20
> -    if (s->listen_ioc) {
> +    if (s->listen_ioc && s->listen_tag =3D=3D 0) {
>          s->listen_tag =3D qio_channel_add_watch(
>              QIO_CHANNEL(s->listen_ioc), G_IO_IN, tcp_chr_accept, chr, =
NULL);
>      }
>      update_disconnected_filename(s);
> -    qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
> +    if (emit_close) {
> +        qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
> +    }
>      if (s->reconnect_time) {
>          qemu_chr_socket_restart_timer(chr);
>      }
>=20

Queued, thanks.

Paolo
