Received: from eggs.gnu.org ([2001:4830:134:3::10]:35573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6HeD-0007Fa-SA
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:22:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6HeC-0000QU-PN
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:22:25 -0400
References: <f4a22cdebdd0bca6a13a43a2a6deead7f2ec4bb3.1493906281.git.pkrempa@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <06e4b745-cd76-9eba-0c3c-c210d92b1d9b@redhat.com>
Date: Thu, 4 May 2017 09:22:19 -0500
MIME-Version: 1.0
In-Reply-To: <f4a22cdebdd0bca6a13a43a2a6deead7f2ec4bb3.1493906281.git.pkrempa@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lGeMnUeMiWopaAMQXQhiDarvlD0LU3LnU"
Subject: Re: [Qemu-devel] [PATCH] block: curl: Allow passing cookies via
 QCryptoSecret
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lGeMnUeMiWopaAMQXQhiDarvlD0LU3LnU
From: Eric Blake <eblake@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <06e4b745-cd76-9eba-0c3c-c210d92b1d9b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: curl: Allow passing cookies via
 QCryptoSecret
References: <f4a22cdebdd0bca6a13a43a2a6deead7f2ec4bb3.1493906281.git.pkrempa@redhat.com>
In-Reply-To: <f4a22cdebdd0bca6a13a43a2a6deead7f2ec4bb3.1493906281.git.pkrempa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/04/2017 09:00 AM, Peter Krempa wrote:
> Since cookies can contain sensitive data (session ID, etc ...) it is
> desired to hide them from the prying eyes of users. Add a possibility t=
o
> pass them via the secret infrastructure.
>=20
> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=3D1447413
>=20
> Signed-off-by: Peter Krempa <pkrempa@redhat.com>
> ---
>  block/curl.c         | 24 +++++++++++++++++++++++-
>  qapi/block-core.json | 12 ++++++++++--
>  2 files changed, 33 insertions(+), 3 deletions(-)
>=20

> +    if (cookie_secret) {
> +        s->cookie =3D qcrypto_secret_lookup_as_utf8(cookie_secret, err=
p);
> +        if (!s->cookie) {
> +            goto out_noclean;
> +        }

Can s->cookie ever be exposed back to the user (such as via a
query-block command)?  If so, we should rather store cookie_secret for
display to the user, rather than the decoded version.

But I couldn't see where we would expose it, so I think you are safe.
I'd wait for another review, probably from Dan since he is the
secret-object expert, but I'm comfortable if you add:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lGeMnUeMiWopaAMQXQhiDarvlD0LU3LnU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZCzkbAAoJEKeha0olJ0NqAqcIAKccBSZp/YjemvDVlNOfrfFA
zbc3EuGIWSBVDgvyISaHflgVtCEdCY2iPhWyAvHGprfiVPzaitdJRfDXTV4+iBs1
CeZLZFzlnytaj+Ehvc5uLcWXjJTAdqyulYSKYkujINi0ZiDpqTUcdCj5u8jEbkOW
K/BsKmeuqjpOSOon4S0PuocTn7m8ZdP1yBxf2wSKw2oxtGGZ5BwJpDEPWCWJ2r27
7jhYMWsPVJ4LHiP9SZrxs6t/jBVkdkPuevGzBqN8/coJgNTah1DV7GdeXId8EDOr
0gfB5dS9GlNYb/7ZIzMlYDYOYHbzfqSeh+oRhuM2UkHVQD2ruyDwZqE8Pgp/bUw=
=HBgw
-----END PGP SIGNATURE-----

--lGeMnUeMiWopaAMQXQhiDarvlD0LU3LnU--
