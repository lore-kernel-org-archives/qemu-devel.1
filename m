Received: from eggs.gnu.org ([2001:4830:134:3::10]:46887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eWoE8-0008GV-Pi
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:57:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eWoE8-0005fB-1b
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:57:24 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:40896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eWoE7-0005eq-QS
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:57:23 -0500
Received: by mail-wr0-x243.google.com with SMTP id p17so2567328wre.7
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 10:57:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171222134527.14467-8-berrange@redhat.com>
References: <20171222134527.14467-1-berrange@redhat.com>
	<20171222134527.14467-8-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 3 Jan 2018 19:57:21 +0100
Message-ID: <CAJ+F1C+Fbc4HFBD13WFw2g7PtPu1Wi9OxOZXHHZXW8VYSajGZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 7/8] char: refactor parsing of socket
 address information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi

On Fri, Dec 22, 2017 at 2:45 PM, Daniel P. Berrange <berrange@redhat.com> w=
rote:
> To prepare for handling more address types, refactor the parsing of
> socket address information to make it more robust and extensible.
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>  chardev/char-socket.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 6013972f72..9113ea0169 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -987,21 +987,25 @@ static void qemu_chr_parse_socket(QemuOpts *opts, C=
hardevBackend *backend,
>      SocketAddressLegacy *addr;
>      ChardevSocket *sock;
>
> +    if ((!!path + !!host) !=3D 1) {
> +        error_setg(errp,
> +                   "Exactly one of 'path' or 'host' required");
> +        return;
> +    }
> +
>      backend->type =3D CHARDEV_BACKEND_KIND_SOCKET;
> -    if (!path) {
> -        if (!host) {
> -            error_setg(errp, "chardev: socket: no host given");
> +    if (path) {
> +        if (tls_creds) {
> +            error_setg(errp, "TLS can only be used over TCP socket");
>              return;
>          }
> +    } else if (host) {
>          if (!port) {
>              error_setg(errp, "chardev: socket: no port given");
>              return;
>          }
>      } else {
> -        if (tls_creds) {
> -            error_setg(errp, "TLS can only be used over TCP socket");
> -            return;
> -        }
> +        g_assert_not_reached();
>      }
>
>      sock =3D backend->u.socket.data =3D g_new0(ChardevSocket, 1);
> @@ -1027,7 +1031,7 @@ static void qemu_chr_parse_socket(QemuOpts *opts, C=
hardevBackend *backend,
>          addr->type =3D SOCKET_ADDRESS_LEGACY_KIND_UNIX;
>          q_unix =3D addr->u.q_unix.data =3D g_new0(UnixSocketAddress, 1);
>          q_unix->path =3D g_strdup(path);
> -    } else {
> +    } else if (host) {
>          addr->type =3D SOCKET_ADDRESS_LEGACY_KIND_INET;
>          addr->u.inet.data =3D g_new(InetSocketAddress, 1);
>          *addr->u.inet.data =3D (InetSocketAddress) {
> @@ -1040,6 +1044,8 @@ static void qemu_chr_parse_socket(QemuOpts *opts, C=
hardevBackend *backend,
>              .has_ipv6 =3D qemu_opt_get(opts, "ipv6"),
>              .ipv6 =3D qemu_opt_get_bool(opts, "ipv6", 0),
>          };
> +    } else {
> +        g_assert_not_reached();
>      }
>      sock->addr =3D addr;
>  }
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
