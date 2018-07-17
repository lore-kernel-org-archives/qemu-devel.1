Received: from eggs.gnu.org ([2001:4830:134:3::10]:44892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ffPuS-0007cn-0K
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ffPuN-0007XS-PA
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:20:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51366 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ffPuN-0007XA-Jk
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:20:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4093F402312B
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 13:20:51 +0000 (UTC)
Date: Tue, 17 Jul 2018 14:20:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180717132046.GT18603@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180717125239.22517-1-marcandre.lureau@redhat.com>
	<20180717125239.22517-3-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180717125239.22517-3-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] char-socket: make 'fd' incompatible
 with 'reconnect'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Jul 17, 2018 at 02:52:38PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> A chardev socket created with the 'fd=3D' argument is not going to
> handle reconnection properly by recycling the same fd (or not in a
> supported way). Let's forbid this case.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char-socket.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 8950f36317..6daa8d003a 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -992,6 +992,10 @@ static void qmp_chardev_open_socket(Chardev *chr,
> =20
>      s->addr =3D addr =3D socket_address_flatten(sock->addr);
> =20
> +    if (sock->has_reconnect && addr->type =3D=3D SOCKET_ADDRESS_TYPE_F=
D) {
> +        error_setg(errp, "'reconnect' option is incompatible with 'fd'=
");
> +        goto error;
> +    }
>      qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_RECONNECTABLE);
>      /* TODO SOCKET_ADDRESS_FD where fd has AF_UNIX */
>      if (addr->type =3D=3D SOCKET_ADDRESS_TYPE_UNIX) {

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
