Received: from eggs.gnu.org ([2001:4830:134:3::10]:42498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cV11M-0007OG-2D
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 14:08:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cV11H-0006Ph-3F
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 14:08:16 -0500
References: <20170103182801.9638-1-berrange@redhat.com>
	<20170103182801.9638-12-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <318a09df-58a2-4eb0-46ea-65d93be9ab4a@redhat.com>
Date: Sat, 21 Jan 2017 20:07:57 +0100
MIME-Version: 1.0
In-Reply-To: <20170103182801.9638-12-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ksnb0FNarFoJ48BonxOJNu7vDeK7oLm6g"
Subject: Re: [Qemu-devel] [PATCH v1 11/15] qcow2: convert QCow2 to use
 QCryptoBlock for encryption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ksnb0FNarFoJ48BonxOJNu7vDeK7oLm6g
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <318a09df-58a2-4eb0-46ea-65d93be9ab4a@redhat.com>
Subject: Re: [PATCH v1 11/15] qcow2: convert QCow2 to use QCryptoBlock for
 encryption
References: <20170103182801.9638-1-berrange@redhat.com>
 <20170103182801.9638-12-berrange@redhat.com>
In-Reply-To: <20170103182801.9638-12-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 03.01.2017 19:27, Daniel P. Berrange wrote:
> This converts the qcow2 driver to make use of the QCryptoBlock
> APIs for encrypting image content, using the legacyy QCow2 AES
> scheme.
>=20
> With this change it is now required to use the QCryptoSecret
> object for providing passwords, instead of the current block
> password APIs / interactive prompting.
>=20
>   $QEMU \
>     -object secret,id=3Dsec0,filename=3D/home/berrange/encrypted.pw \
>     -drive file=3D/home/berrange/encrypted.qcow2,aes-key-secret=3Dsec0
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/qcow2-cluster.c      |  47 +----------
>  block/qcow2.c              | 190 +++++++++++++++++++++++++++++--------=
--------
>  block/qcow2.h              |   5 +-
>  qapi/block-core.json       |   7 +-
>  tests/qemu-iotests/049     |   2 +-
>  tests/qemu-iotests/049.out |   4 +-
>  tests/qemu-iotests/082.out |  27 +++++++
>  tests/qemu-iotests/087     |  28 ++++++-
>  tests/qemu-iotests/087.out |   6 +-
>  tests/qemu-iotests/134     |  18 +++--
>  tests/qemu-iotests/134.out |  10 +--
>  tests/qemu-iotests/158     |  19 +++--
>  tests/qemu-iotests/158.out |  14 +---
>  13 files changed, 219 insertions(+), 158 deletions(-)

[...]

> diff --git a/tests/qemu-iotests/134 b/tests/qemu-iotests/134
> index af618b8..c2458d8 100755
> --- a/tests/qemu-iotests/134
> +++ b/tests/qemu-iotests/134
> @@ -43,23 +43,31 @@ _supported_os Linux
> =20
> =20
>  size=3D128M
> -IMGOPTS=3D"encryption=3Don" _make_test_img $size
> +
> +SECRET=3D"secret,id=3Dsec0,data=3Dastrochicken"
> +SECRETALT=3D"secret,id=3Dsec0,data=3Dplatypus"
> +
> +_make_test_img --object $SECRET -o "encryption=3Don,qcow-key-secret=3D=
sec0" $size
> +
> +IMGSPEC=3D"driver=3D$IMGFMT,file.filename=3D$TEST_IMG,qcow-key-secret=3D=
sec0"
> +
> +QEMU_IO_OPTIONS=3D$QEMU_IO_OPTIONS_NO_FMT

While I agree that it makes sense to have this variable, we
unfortunately do not have it. Yet. ;-)

It should be defined somewhere and it should probably actually contain
all non-format options (such as the cache mode).

Max


--Ksnb0FNarFoJ48BonxOJNu7vDeK7oLm6g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliDsY0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ALNcIAIgSP0U8uRJxyG+SQ611EalHc3KPvYfd
5JZgosJLRrfj+Drze9YdjDYRTUvLJZWQ9KJharM7IGxP+HAAv1It4VnTc7Ryj3Iz
WAZ5d3HwOE8O8P4il8iHNjYXsFsnb2cH7SAPOQvLUeAPSMejDEAP3YdVLUeziImI
CkKsuA2MEt6h2mQR3RLH3G87/ZT0zLLk2O5CwPGSNdorw3x6wPztLrrMO7omF5AJ
QU7qVMp+C14NdnfRw66szCJ3jxq3TUArnJd2R4EJ6GjTto2vVIIPyJTQgCqSHXxg
9S/7Ziu/z8hUnTUyiIPjuBjrtTIZpabbRr+3Noa7d59UyYRqeqq+HP8=
=yvUr
-----END PGP SIGNATURE-----

--Ksnb0FNarFoJ48BonxOJNu7vDeK7oLm6g--
