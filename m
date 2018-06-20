Received: from eggs.gnu.org ([2001:4830:134:3::10]:35181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVdXh-0006ts-Jp
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVdXe-0007u0-GF
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:53:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60634 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fVdXe-0007tI-Aa
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:52:58 -0400
Date: Wed, 20 Jun 2018 14:52:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180620135254.GA19979@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180521161733.GA16751@rnd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180521161733.GA16751@rnd>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] Delete AF_UNIX socket after close
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Balaev <mail@void.so>
Cc: qemu-devel@nongnu.org

On Mon, May 21, 2018 at 07:17:35PM +0300, Pavel Balaev wrote:
> This is a second attempt at sending this patch:
>=20
> http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg04697.html
>=20
> Signed-off-by: Pavel Balaev <mail@void.so>
> ---
>  io/channel-socket.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index 57cfb4d3a6..b50e63a053 100644
> --- a/io/channel-socket.c
> +++ b/io/channel-socket.c
> @@ -685,8 +685,10 @@ qio_channel_socket_close(QIOChannel *ioc,
>                           Error **errp)
>  {
>      QIOChannelSocket *sioc =3D QIO_CHANNEL_SOCKET(ioc);
> +    int rc =3D 0;
> =20
>      if (sioc->fd !=3D -1) {
> +        SocketAddress *addr =3D socket_local_address(sioc->fd, errp);
>  #ifdef WIN32
>          WSAEventSelect(sioc->fd, NULL, 0);
>  #endif
> @@ -697,8 +699,22 @@ qio_channel_socket_close(QIOChannel *ioc,
>              return -1;
>          }
>          sioc->fd =3D -1;
> +
> +        if (addr && addr->type =3D=3D SOCKET_ADDRESS_TYPE_UNIX
> +            && addr->u.q_unix.path) {
> +            if (unlink(addr->u.q_unix.path) < 0 && errno !=3D ENOENT) =
{
> +                error_setg_errno(errp, errno,
> +                                 "Failed to unlink socket %s",
> +                                 addr->u.q_unix.path);
> +                rc =3D -1;
> +            }
> +        }
> +
> +        if (addr) {
> +            qapi_free_SocketAddress(addr);
> +        }
>      }
> -    return 0;
> +    return rc;
>  }
> =20
>  static int

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

I've queued this now, thanks.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
