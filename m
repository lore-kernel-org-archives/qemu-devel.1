Received: from eggs.gnu.org ([2001:4830:134:3::10]:48121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eopmW-0004Up-59
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:15:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eopmU-0006Z6-W9
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:15:24 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43804 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eopmU-0006Xe-NE
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:15:22 -0500
Date: Thu, 22 Feb 2018 12:15:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180222121519.GK9323@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <52841519299484@web28j.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <52841519299484@web28j.yandex.ru>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Patch 9894dc0cdcc broke something
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksey Kuleshov <rndfax@yandex.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Feb 22, 2018 at 02:38:04PM +0300, Aleksey Kuleshov wrote:
> Hello!
>=20
> I hit unexpected disconnections because of this patch:
>=20
> commit 9894dc0cdcc397ee5b26370bc53da6d360a363c2
> Author: Daniel P. Berrange <berrange@redhat.com>
> Date:   Tue Jan 19 11:14:29 2016 +0000
>=20
>     char: convert from GIOChannel to QIOChannel
>    =20
>     In preparation for introducing TLS support to the TCP chardev
>     backend, convert existing chardev code from using GIOChannel
>     to QIOChannel. This simplifies the chardev code by removing
>     most of the OS platform conditional code for dealing with
>     file descriptor passing.
>    =20
>     Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>     Message-Id: <1453202071-10289-3-git-send-email-berrange@redhat.com>
>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>=20
> breaks tcp_chr_read:
>=20
> -static gboolean tcp_chr_read(GIOChannel *chan, GIOCondition cond, void=
 *opaque)
> +static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void=
 *opaque)
>  {
>      CharDriverState *chr =3D opaque;
>      TCPCharDriver *s =3D chr->opaque;
> @@ -2938,9 +2801,7 @@ static gboolean tcp_chr_read(GIOChannel *chan, GI=
OCondition cond, void *opaque)
>      if (len > s->max_size)
>          len =3D s->max_size;
>      size =3D tcp_chr_recv(chr, (void *)buf, len);
> -    if (size =3D=3D 0 ||
> -        (size < 0 &&
> -         socket_error() !=3D EAGAIN && socket_error() !=3D EWOULDBLOCK=
)) {
> +    if (size =3D=3D 0 || size =3D=3D -1) {
>          /* connection closed */
>          tcp_chr_disconnect(chr);
>      } else if (size > 0) {
>=20
> since tcp_chr_recv returns -1 on blocking:

Actually it did not do that in this patch - tcp_chr_recv returns -2
on blocking when that patch was written.

>=20
> static ssize_t tcp_chr_recv(Chardev *chr, char *buf, size_t len)
> {
> ...
>     if (ret =3D=3D QIO_CHANNEL_ERR_BLOCK) {
>         errno =3D EAGAIN;
>         ret =3D -1;
>     } else if (ret =3D=3D -1) {
>         errno =3D EIO;
>     }

This was caused by by a later change

  commit b6572b4f97a7b126c7b24e165893ed9fe3d72e1f
  Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
  Date:   Fri Mar 11 18:55:24 2016 +0100

    char: translate from QIOChannel error to errno
   =20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
