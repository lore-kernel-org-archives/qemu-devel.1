Received: from eggs.gnu.org ([2001:4830:134:3::10]:40254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ffPbn-00080D-G5
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:01:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ffPbh-0007aY-Ke
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:01:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39520 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ffPbh-0007aH-Ge
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:01:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2CFE4059FEE
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 13:01:32 +0000 (UTC)
Date: Tue, 17 Jul 2018 14:01:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180717130130.GQ18603@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180717125239.22517-1-marcandre.lureau@redhat.com>
	<20180717125239.22517-4-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180717125239.22517-4-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] char-socket: delay setting fd-pass
 feature until connected
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

On Tue, Jul 17, 2018 at 02:52:39PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Wait for QIO channel connection completion, and check the feature set
> by QIO. This fixes setting fd-pass chardev feature on
> SOCKET_ADDRESS_FD where fd has AF_UNIX.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char-socket.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 6daa8d003a..7387e632d4 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -789,6 +789,9 @@ static int tcp_chr_new_client(Chardev *chr, QIOChan=
nelSocket *sioc)
> =20
>      qio_channel_set_blocking(s->ioc, false, NULL);
> =20
> +    if (qio_channel_has_feature(s->ioc, QIO_CHANNEL_FEATURE_FD_PASS)) =
{
> +        qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_FD_PASS);
> +    }

I really don't like this approach as it has unpleasant async/race prone
semantics or the external users of the chardev.

With the current approach they know that once the chardev is created,
the features have been initialized.

With this approach, the features are only initialized once the client
connection has been completed, or once the server has started listening,
which may or may not be the case once the chardev constructor completes.

>      /* be isn't opened until we get a connection */
>      *be_opened =3D false;
> --=20
> 2.18.0.129.ge3331758f1
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
