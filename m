Received: from eggs.gnu.org ([2001:4830:134:3::10]:51357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1yLL-0005wv-GZ
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:29:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1yLG-0007JK-Rz
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:29:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59847)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e1yLG-0007J6-I0
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:29:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8F96281E14
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 17:29:17 +0000 (UTC)
References: <20171010154328.8419-1-berrange@redhat.com>
	<20171010154328.8419-6-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cf615144-e243-bde1-c054-0f178dc51a02@redhat.com>
Date: Tue, 10 Oct 2017 12:29:16 -0500
MIME-Version: 1.0
In-Reply-To: <20171010154328.8419-6-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="prWTxB2jDmViPrJcK8tx4iJtVogOsVN8B"
Subject: Re: [Qemu-devel] [PATCH v1 5/7] io: get rid of bounce buffering in
 websock write path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--prWTxB2jDmViPrJcK8tx4iJtVogOsVN8B
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Message-ID: <cf615144-e243-bde1-c054-0f178dc51a02@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 5/7] io: get rid of bounce buffering in
 websock write path
References: <20171010154328.8419-1-berrange@redhat.com>
 <20171010154328.8419-6-berrange@redhat.com>
In-Reply-To: <20171010154328.8419-6-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/10/2017 10:43 AM, Daniel P. Berrange wrote:
> Currently most outbound I/O on the websock channel gets copied into the=

> rawoutput buffer, and then immediately copied again into the encoutput
> buffer, with a header prepended. Now that qio_channel_websock_encode
> accepts a struct iovec, we can trivially remove this bounce buffering
> and write directly to encoutput.
>=20
> In doing so, we also now correctly validate the encoutput size against
> the QIO_CHANNEL_WEBSOCK_MAX_BUFFER limit.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  include/io/channel-websock.h |  1 -
>  io/channel-websock.c         | 64 +++++++++++++++++++-----------------=
--------
>  2 files changed, 28 insertions(+), 37 deletions(-)
>=20

> -    iov.iov_base =3D ioc->rawoutput.buffer;
> -    iov.iov_len =3D ioc->rawoutput.offset;
>      qio_channel_websock_encode(ioc, QIO_CHANNEL_WEBSOCK_OPCODE_CLOSE,
> -                               &iov, 1, iov.iov_len);
> -    buffer_reset(&ioc->rawoutput);
> +                               iov, niov, size);

If 4/7 changes this to compute size from the iov/niov, then this has
knock-on impact.

> @@ -1115,32 +1118,21 @@ static ssize_t qio_channel_websock_writev(QIOCh=
annel *ioc,
>          return -1;

> +    avail =3D wioc->encoutput.offset >=3D QIO_CHANNEL_WEBSOCK_MAX_BUFF=
ER ?
> +        0 : (QIO_CHANNEL_WEBSOCK_MAX_BUFFER - wioc->encoutput.offset);=

> +    if (want > avail) {
> +        want =3D avail;
>      }
> =20
> - done:
> -    if (wioc->rawoutput.offset) {
> -        struct iovec iov =3D { .iov_base =3D wioc->rawoutput.buffer,
> -                             .iov_len =3D wioc->rawoutput.offset };
> +    if (want) {
>          qio_channel_websock_encode(wioc,
>                                     QIO_CHANNEL_WEBSOCK_OPCODE_BINARY_F=
RAME,
> -                                   &iov, 1, iov.iov_len);
> -        buffer_reset(&wioc->rawoutput);
> +                                   iov, niov, want);

then again, I see that you DO support want < iov_size(iov, niov).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--prWTxB2jDmViPrJcK8tx4iJtVogOsVN8B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlndA2wACgkQp6FrSiUn
Q2oepgf/aRYEfW4uJvuIFs2w2Fuz98ULxBZJmSsrM3ALiIdJDmjp2Pcbs9BvpEpP
2VwZ4thckHLiH30wq6tlv9+TOMjwy2pTwBqx8uQ1T8A9qBpX3kfvafuXRyHIq8AT
mcXQvFi5iHZJLbblfio9USuC824c+U1ebeOqnzeA1RlSyJj0vgz+afu6aL81ftxy
/ef7m+KWhr5KrTh13CsiPEU/QAkukkBNTzQ/2w0UmjnqJaMjwKfpr7XpqS7iL2nu
gmG43IO0J772hrjB0r31cOAY/3JcGd0nbLJPEZq+wwFriuuzt2EQKtG5s7qiBILO
R9uTYpEKcKTrXS4oO2WAn10ui5FRzQ==
=RGqK
-----END PGP SIGNATURE-----

--prWTxB2jDmViPrJcK8tx4iJtVogOsVN8B--
