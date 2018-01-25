Received: from eggs.gnu.org ([2001:4830:134:3::10]:42847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eenMo-0004fm-1w
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 14:39:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eenMj-00077Y-FY
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 14:39:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eenMj-00077I-73
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 14:39:17 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 471597109E
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 19:39:16 +0000 (UTC)
References: <20180125171412.21627-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b0d71def-cf58-d844-a489-67498ec2ad8f@redhat.com>
Date: Thu, 25 Jan 2018 13:39:12 -0600
MIME-Version: 1.0
In-Reply-To: <20180125171412.21627-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="43QZ9Xqo9jW8Uz41ulCNwvir0WZjpjFuO"
Subject: Re: [Qemu-devel] [PATCH v2] sockets: fix parsing of ipv4/ipv6 opts
 in parse_socket_addr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--43QZ9Xqo9jW8Uz41ulCNwvir0WZjpjFuO
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b0d71def-cf58-d844-a489-67498ec2ad8f@redhat.com>
Subject: Re: [PATCH v2] sockets: fix parsing of ipv4/ipv6 opts in
 parse_socket_addr
References: <20180125171412.21627-1-berrange@redhat.com>
In-Reply-To: <20180125171412.21627-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/25/2018 11:14 AM, Daniel P. Berrang=C3=A9 wrote:
> From: "Daniel P. Berrange" <berrange@redhat.com>
>=20
> The inet_parse() function looks for 'ipv4' and 'ipv6' flags, but only
> treats them as bare bool flags. The normal QemuOpts parsing would allow=

> on/off values to be set too.
>=20
> This updates inet_parse() so that its handling of the 'ipv4' and 'ipv6'=

> flags matches that done by QemuOpts.
>=20
> This impacts the NBD block driver parsing the legacy filename syntax an=
d
> the migration code parsing the socket scheme.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  util/qemu-sockets.c | 44 ++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 40 insertions(+), 4 deletions(-)
>=20

> +    if (len =3D=3D 0 || (len =3D=3D 3 && strncmp(optstr, "=3Don", len)=
 =3D=3D 0)) {

Good: no parens around 'len =3D=3D 3'

> +        *val =3D true;
> +    } else if ((len =3D=3D 4) && strncmp(optstr, "=3Doff", len) =3D=3D=
 0) {

Not so good: redundant parens around 'len =3D=3D 4'

Bad: Inconsistency between the two forms.

With those made consistent, this matches the logic in the static
util/qemu-option.c:parse_option_bool(), so it makes sense.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--43QZ9Xqo9jW8Uz41ulCNwvir0WZjpjFuO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpqMmAACgkQp6FrSiUn
Q2qLGwf7BCY/+zELaDlGGvL0TMOw0YzDsV/32QOGCEyy1Q06TsXI4UONpWTveIqU
TNUZ7OGDlUGz89+6gSnITlkoTEmJkqLS7chCIpPYKT1Hp4fYxtV2S2jDYdW91nKu
+hQQDBGmQQQFC/zD0a53WnkZ7jgeVI27mXyJE0YiM3OhA8Z4ijupvV8yf7+ZjIZ0
dz6FsuAC7B1CWeVG70tUWp2bhiZQBXLKQQmn91TokNcDTnscArU278xUYDsOHWoI
GzXLY2PDwqqVSQ3p1i7bgV0ZAe3EqmMvQBPt2uPMTe+fudYZRL7ESMnVbU+BGXpp
sHkOxXe8zdUHbR/Df1e7x1u0556YNw==
=NcRR
-----END PGP SIGNATURE-----

--43QZ9Xqo9jW8Uz41ulCNwvir0WZjpjFuO--
