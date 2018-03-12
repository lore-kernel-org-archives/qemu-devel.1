Received: from eggs.gnu.org ([2001:4830:134:3::10]:37167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evOLO-000543-7Y
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:22:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evOLL-0000gM-2A
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:22:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53968 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1evOLK-0000ee-TL
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:22:26 -0400
References: <20180222121351.26191-1-berrange@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2600fe23-944e-dd04-2546-32df099a807c@redhat.com>
Date: Mon, 12 Mar 2018 15:22:20 +0100
MIME-Version: 1.0
In-Reply-To: <20180222121351.26191-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] chardev: fix handling of EAGAIN for TCP
 chardev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Aleksey Kuleshov <rndfax@yandex.ru>

On 22/02/2018 13:13, Daniel P. Berrang=C3=A9 wrote:
> When this commit was applied
>=20
>   commit 9894dc0cdcc397ee5b26370bc53da6d360a363c2
>   Author: Daniel P. Berrange <berrange@redhat.com>
>   Date:   Tue Jan 19 11:14:29 2016 +0000
>=20
>     char: convert from GIOChannel to QIOChannel
>=20
> The tcp_chr_recv() function was changed to return QIO_CHANNEL_ERR_BLOCK
> which corresonds to -2. As such the handling for EAGAIN was able to be
> removed from tcp_chr_read(). Unfortunately in a later commit:
>=20
>   commit b6572b4f97a7b126c7b24e165893ed9fe3d72e1f
>   Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>   Date:   Fri Mar 11 18:55:24 2016 +0100
>=20
>     char: translate from QIOChannel error to errno
>=20
> The tcp_chr_recv() function was changed back to return -1, with errno
> set to EAGAIN, without also re-addding support for this to tcp_chr_read=
()
>=20
> Reported-by: Aleksey Kuleshov <rndfax@yandex.ru>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  chardev/char-socket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index bdd6cff5f6..b15682c362 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -449,7 +449,7 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOC=
ondition cond, void *opaque)
>          len =3D s->max_size;
>      }
>      size =3D tcp_chr_recv(chr, (void *)buf, len);
> -    if (size =3D=3D 0 || size =3D=3D -1) {
> +    if (size =3D=3D 0 || (size =3D=3D -1 && errno !=3D EAGAIN)) {
>          /* connection closed */
>          tcp_chr_disconnect(chr);
>      } else if (size > 0) {
>=20

Queued, thanks.

Paolo
