Received: from eggs.gnu.org ([2001:4830:134:3::10]:44622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn8lW-00005y-Tu
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:35:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn8lS-0005aI-OD
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:35:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dn8lS-0005ZB-Ej
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:35:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1A1A7356D9
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 19:35:01 +0000 (UTC)
References: <20170830135611.27678-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <baf58715-49f6-6608-d469-062086c4fdd0@redhat.com>
Date: Wed, 30 Aug 2017 14:34:59 -0500
MIME-Version: 1.0
In-Reply-To: <20170830135611.27678-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HbsNbdoi59hmTQJkFSQjaftEdUxUlgMgP"
Subject: Re: [Qemu-devel] [PATCH] io: add new qio_channel_{readv, writev,
 read, write}_all functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HbsNbdoi59hmTQJkFSQjaftEdUxUlgMgP
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>
Message-ID: <baf58715-49f6-6608-d469-062086c4fdd0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] io: add new qio_channel_{readv, writev,
 read, write}_all functions
References: <20170830135611.27678-1-berrange@redhat.com>
In-Reply-To: <20170830135611.27678-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/30/2017 08:56 AM, Daniel P. Berrange wrote:
> These functions wait until they are able to read / write the full
> requested data buffer(s).
>=20

Hmm, sounds like the NBD code would benefit from using this in a
followup patch.

> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>=20
> This patch combines these two previous proposals:
>=20
>  - https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg01536.html
>  - https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg04041.html
>=20
> and switches the test suite over to use the new APIs so we get
> coverage by all the tests/test-io-channel-*  test programs
>=20

>  /**
> + * qio_channel_readv_all:
> + * @ioc: the channel object
> + * @iov: the array of memory regions to read data into
> + * @niov: the length of the @iov array
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Read data from the IO channel, storing it in the
> + * memory regions referenced by @iov. Each element
> + * in the @iov will be fully populated with data
> + * before the next one is used. The @niov parameter
> + * specifies the total number of elements in @iov.
> + *
> + * The function will wait for all requested data
> + * to be read, yielding from the current couroutine

s/couroutine/coroutine/

> + * if required.
> + *
> + * If end-of-file occurrs before all requested data

s/occurrs/occurs/

> + * has been read, an error will be reported.
> + *
> + * Returns: 0 if all bytes were read, or -1 on error
> + */

> +/**
> + * qio_channel_writev_all:
> + * @ioc: the channel object
> + * @iov: the array of memory regions to write data from
> + * @niov: the length of the @iov array
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Write data to the IO channel, reading it from the
> + * memory regions referenced by @iov. Each element
> + * in the @iov will be fully sent, before the next
> + * one is used. The @niov parameter specifies the
> + * total number of elements in @iov.
> + *
> + * The function will wait for all requested data
> + * to be written, yielding from the current couroutine

s/couroutine/coroutine/

> +++ b/io/channel.c

> +int qio_channel_readv_all(QIOChannel *ioc,

> +    while (nlocal_iov > 0) {
> +        ssize_t len;
> +        len =3D qio_channel_readv(ioc, local_iov, nlocal_iov, errp);
> +        if (len =3D=3D QIO_CHANNEL_ERR_BLOCK) {
> +            qio_channel_wait(ioc, G_IO_IN);
> +            continue;
> +        } else if (len < 0) {
> +            error_setg_errno(errp, EIO,
> +                             "Channel was not able to read full iov");=


Should we report -len instead of EIO here?

> +int qio_channel_writev_all(QIOChannel *ioc,

> +    while (nlocal_iov > 0) {
> +        ssize_t len;
> +        len =3D qio_channel_writev(ioc, local_iov, nlocal_iov, errp);
> +        if (len =3D=3D QIO_CHANNEL_ERR_BLOCK) {
> +            qio_channel_wait(ioc, G_IO_OUT);
> +            continue;
> +        }
> +        if (len < 0) {
> +            error_setg_errno(errp, EIO,
> +                             "Channel was not able to write full iov")=
;

and again

With the typos fixed, and either an explanation why EIO is better or
else a fix to preserve errno,

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--HbsNbdoi59hmTQJkFSQjaftEdUxUlgMgP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmnE2MACgkQp6FrSiUn
Q2r7Vgf/clnDxnjGC3QSl3lmd91csgvMB9fL81axolShoK4TIeyOuHyPa154aeG8
CxunQ4SuybUp+sowh53Fu62FhJKkHEc68Bc3J2ZfU9P+WwocuQ/mpbsQiV1xY7uE
KnY1dXFCLriBQMpFd9oNhLNKAncJgBBdihMZ9+lclMNeBnTGzF1NEyBwuQbSkGeT
4GeXE/kBbYOEBVsnVXGrW29XAdStvdZNTV/ChkKjOEnB1Ojm0Ea1OFVVjU1E5Jt0
N8cnfBfBVId7N6xI/YCioSP87gKQhyoIqdPmZaL158N4ho0uZG8toKQbsFJpKWoI
fDPWT/1VGOEWuuXxIe2VV9EikAZnBg==
=IKOy
-----END PGP SIGNATURE-----

--HbsNbdoi59hmTQJkFSQjaftEdUxUlgMgP--
