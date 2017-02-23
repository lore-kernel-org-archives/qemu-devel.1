Received: from eggs.gnu.org ([2001:4830:134:3::10]:42870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cgqjO-0007kh-FI
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:34:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cgqjI-0000qt-Of
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:34:38 -0500
Date: Thu, 23 Feb 2017 10:34:25 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170223103425.GA18728@stefanha-x1.localdomain>
References: <20170222180725.28611-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <20170222180725.28611-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] do not use
 aio_context_acquire/release in AIO-based drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, jcody@redhat.com, qemu-block@nongnu.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 22, 2017 at 07:07:22PM +0100, Paolo Bonzini wrote:
> aio_context_acquire/release are only going away as soon as the block layer
> becomes thread-safe, but we can already move away to other finer-grained
> mutex whenever possible.
>=20
> These three drivers don't use coroutines, hence a QemuMutex is a fine
> primitive to use for protecting any per-BDS data in the libraries
> they use.  The QemuMutex must protect any fd handlers or bottom halves,
> and also the BlockDriver callbacks which were implicitly being called
> under aio_context_acquire.
>=20
> Paolo
>=20
> v1->v2: missing unlock in error paths (patch 2, Stefan)
>=20
> Paolo Bonzini (3):
>   curl: do not use aio_context_acquire/release
>   nfs: do not use aio_context_acquire/release
>   iscsi: do not use aio_context_acquire/release
>=20
>  block/curl.c  | 24 ++++++++++-------
>  block/iscsi.c | 83 +++++++++++++++++++++++++++++++++++++++++++++--------=
------
>  block/nfs.c   | 23 ++++++++++++++---
>  3 files changed, 98 insertions(+), 32 deletions(-)
>=20
> --=20
> 2.9.3
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYrrqwAAoJEJykq7OBq3PIYgkIALmWCxwvCUcZPjkOlMjMRRzV
PhMMvYJD8TAlK9M/lQkC3z4h7YkWlt8GCxrYCAX//iCvRVhd1MnnvowQnUe7eXE0
i+6cEjiJoZHTFXwYz4S1s23JQJG2c+b7Wmg5yzzsX+BOlUu629Jdil9kh7zLPAEo
HgMc3ol7lR8+5kNg5qjQ1hclTFFePtteNbHP4cRPnm7U//Ydjy0vVVDuDtdndjkI
c/RG/08hmBaLz49n9Otoz2JS6bkDsapcJjutN2F/o0r2LTT8r41Iy0AQa+bYlObc
YizYZSuU6ltOHBaE4DDzx2ytq2ZoIcQgsJCUZ40jCLAmTelCpWdE7ZQgqv6k3PY=
=3l2g
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
