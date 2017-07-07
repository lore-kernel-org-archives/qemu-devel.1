Received: from eggs.gnu.org ([2001:4830:134:3::10]:42662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dTQwm-0000o7-NJ
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dTQwj-0007Cu-MC
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:57:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dTQwj-0007Cg-GL
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:57:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 21896285B1
	for <qemu-devel@nongnu.org>; Fri,  7 Jul 2017 10:57:12 +0000 (UTC)
References: <20170706170353.32601-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4d8fd388-267d-5c64-81a2-3662dc83686d@redhat.com>
Date: Fri, 7 Jul 2017 12:57:08 +0200
MIME-Version: 1.0
In-Reply-To: <20170706170353.32601-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] chardev: block during sync read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org



On 06/07/2017 19:03, Marc-Andr=C3=A9 Lureau wrote:
> A sync read should block until all requested data is
> available (instead of retrying in qemu_chr_fe_read_all). Change the
> channel to blocking during sync_read.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char-socket.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index ccc499cfa1..7e6648b03a 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -454,7 +454,9 @@ static int tcp_chr_sync_read(Chardev *chr, const ui=
nt8_t *buf, int len)
>          return 0;
>      }
> =20
> +    qio_channel_set_blocking(s->ioc, true, NULL);
>      size =3D tcp_chr_recv(chr, (void *) buf, len);
> +    qio_channel_set_blocking(s->ioc, false, NULL);
>      if (size =3D=3D 0) {
>          /* connection closed */
>          tcp_chr_disconnect(chr);
>=20

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
