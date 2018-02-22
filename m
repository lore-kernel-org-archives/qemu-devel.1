Received: from eggs.gnu.org ([2001:4830:134:3::10]:52094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eoq5z-0002t0-Rb
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:35:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eoq5y-0004id-Eg
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:35:31 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:44117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eoq5y-0004hN-73
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:35:30 -0500
Received: by mail-wr0-x241.google.com with SMTP id v65so10374686wrc.11
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 04:35:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180222121351.26191-1-berrange@redhat.com>
References: <20180222121351.26191-1-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 22 Feb 2018 13:35:28 +0100
Message-ID: <CAJ+F1C+TnFeqWK11fTgC68s107++5jPhbb0thuU0b-kGTXVeug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Aleksey Kuleshov <rndfax@yandex.ru>

On Thu, Feb 22, 2018 at 1:13 PM, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
> When this commit was applied
>
>   commit 9894dc0cdcc397ee5b26370bc53da6d360a363c2
>   Author: Daniel P. Berrange <berrange@redhat.com>
>   Date:   Tue Jan 19 11:14:29 2016 +0000
>
>     char: convert from GIOChannel to QIOChannel
>
> The tcp_chr_recv() function was changed to return QIO_CHANNEL_ERR_BLOCK
> which corresonds to -2. As such the handling for EAGAIN was able to be
> removed from tcp_chr_read(). Unfortunately in a later commit:
>
>   commit b6572b4f97a7b126c7b24e165893ed9fe3d72e1f
>   Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>   Date:   Fri Mar 11 18:55:24 2016 +0100
>
>     char: translate from QIOChannel error to errno
>
> The tcp_chr_recv() function was changed back to return -1, with errno
> set to EAGAIN, without also re-addding support for this to tcp_chr_read()
>
> Reported-by: Aleksey Kuleshov <rndfax@yandex.ru>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  chardev/char-socket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index bdd6cff5f6..b15682c362 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -449,7 +449,7 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOCon=
dition cond, void *opaque)
>          len =3D s->max_size;
>      }
>      size =3D tcp_chr_recv(chr, (void *)buf, len);
> -    if (size =3D=3D 0 || size =3D=3D -1) {
> +    if (size =3D=3D 0 || (size =3D=3D -1 && errno !=3D EAGAIN)) {
>          /* connection closed */
>          tcp_chr_disconnect(chr);
>      } else if (size > 0) {
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
