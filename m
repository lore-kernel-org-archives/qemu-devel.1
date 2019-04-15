Received: from eggs.gnu.org ([209.51.188.92]:52631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hG49i-0000Tm-2R
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:08:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hG49g-0006P0-G9
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:08:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hG49g-00067f-3k
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:08:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 13A61330260
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 16:08:15 +0000 (UTC)
Date: Mon, 15 Apr 2019 17:08:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190415160809.GP5718@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190415160609.24240-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190415160609.24240-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] socket: allow wait=false for client
 socket
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

On Mon, Apr 15, 2019 at 06:06:09PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Commit 767abe7 ("chardev: forbid 'wait' option with client sockets")
> is a bit too strict. Current libvirt always set wait=3Dfalse, and will
> thus fail to add client chardev.
>=20
> Make the code more permissive, allowing wait=3Dfalse with client socket
> chardevs.
>=20
> Fixes: 767abe7f49e8be14d29da5db3527817b5d696a52
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char-socket.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 3916505d67..ebc1adb83e 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1263,9 +1263,13 @@ static bool qmp_chardev_validate_socket(ChardevS=
ocket *sock,
>              return false;
>          }
>          if (sock->has_wait) {
> -            error_setg(errp, "%s",
> -                       "'wait' option is incompatible with "
> -                       "socket in client connect mode");
> +            warn_report("'wait' option is deprecated with "
> +                        "socket in client connect mode");
> +            if (sock->wait) {
> +                error_setg(errp, "%s",
> +                           "'wait' option is incompatible with "
> +                           "socket in client connect mode");
> +            }
>              return false;
>          }
>      }

NB, it should also update qemu-deprecated.texi


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
