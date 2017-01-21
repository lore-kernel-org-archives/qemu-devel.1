Received: from eggs.gnu.org ([2001:4830:134:3::10]:43044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cV15I-0000eU-Dd
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 14:12:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cV15D-000862-E9
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 14:12:20 -0500
References: <20170103182801.9638-1-berrange@redhat.com>
	<20170103182801.9638-14-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e7b57595-0ec4-61e3-dcd3-c114f295f313@redhat.com>
Date: Sat, 21 Jan 2017 20:12:05 +0100
MIME-Version: 1.0
In-Reply-To: <20170103182801.9638-14-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="d5T7KBDbt84hVBooRcCQwjc1hIMCaoqQA"
Subject: Re: [Qemu-devel] [PATCH v1 13/15] iotests: enable tests 134 and 158
 to work with qcow (v1)
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
--d5T7KBDbt84hVBooRcCQwjc1hIMCaoqQA
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <e7b57595-0ec4-61e3-dcd3-c114f295f313@redhat.com>
Subject: Re: [PATCH v1 13/15] iotests: enable tests 134 and 158 to work with
 qcow (v1)
References: <20170103182801.9638-1-berrange@redhat.com>
 <20170103182801.9638-14-berrange@redhat.com>
In-Reply-To: <20170103182801.9638-14-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 03.01.2017 19:27, Daniel P. Berrange wrote:
> The 138 and 158 iotests exercise the legacy qcow2 aes encryption
> code path. With a few simple tweaks they can exercise the same
> feature in qcow (v1).
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  tests/qemu-iotests/134 | 10 +++++-----
>  tests/qemu-iotests/158 |  2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/134 b/tests/qemu-iotests/134
> index dd080a2..23b7834 100755
> --- a/tests/qemu-iotests/134
> +++ b/tests/qemu-iotests/134
> @@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  . ./common.rc
>  . ./common.filter
> =20
> -_supported_fmt qcow2
> +_supported_fmt qcow qcow2
>  _supported_proto generic
>  _supported_os Linux
> =20
> @@ -55,19 +55,19 @@ QEMU_IO_OPTIONS=3D$QEMU_IO_OPTIONS_NO_FMT
> =20
>  echo
>  echo "=3D=3D reading whole image =3D=3D"
> -$QEMU_IO --object $SECRET -c "read 0 $size" --image-opts $IMGSPEC | _f=
ilter_qemu_io | _filter_testdir
> +$QEMU_IO --object $SECRET -c "read 0 $size" --image-opts $IMGSPEC | _f=
ilter_qemu_io | _filter_testdir | _filter_imgfmt
> =20
>  echo
>  echo "=3D=3D rewriting whole image =3D=3D"
> -$QEMU_IO --object $SECRET -c "write -P 0xa 0 $size" --image-opts $IMGS=
PEC | _filter_qemu_io | _filter_testdir
> +$QEMU_IO --object $SECRET -c "write -P 0xa 0 $size" --image-opts $IMGS=
PEC | _filter_qemu_io | _filter_testdir | _filter_imgfmt
> =20
>  echo
>  echo "=3D=3D verify pattern =3D=3D"
> -$QEMU_IO --object $SECRET -c "read -P 0xa 0 $size"  --image-opts $IMGS=
PEC | _filter_qemu_io | _filter_testdir
> +$QEMU_IO --object $SECRET -c "read -P 0xa 0 $size"  --image-opts $IMGS=
PEC | _filter_qemu_io | _filter_testdir | _filter_imgfmt
> =20
>  echo
>  echo "=3D=3D verify pattern failure with wrong password =3D=3D"
> -$QEMU_IO --object $SECRETALT -c "read -P 0xa 0 $size" --image-opts $IM=
GSPEC | _filter_qemu_io | _filter_testdir
> +$QEMU_IO --object $SECRETALT -c "read -P 0xa 0 $size" --image-opts $IM=
GSPEC | _filter_qemu_io | _filter_testdir | _filter_imgfmt

What is this necessary for? The qemu-io output does not contain the
image format, as far as I can see.

Under the premise of "can't hurt", though:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> =20
> =20
>  # success, all done
> diff --git a/tests/qemu-iotests/158 b/tests/qemu-iotests/158
> index 7a1eb5c..2b53d9f 100755
> --- a/tests/qemu-iotests/158
> +++ b/tests/qemu-iotests/158
> @@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  . ./common.rc
>  . ./common.filter
> =20
> -_supported_fmt qcow2
> +_supported_fmt qcow qcow2
>  _supported_proto generic
>  _supported_os Linux
> =20
>=20



--d5T7KBDbt84hVBooRcCQwjc1hIMCaoqQA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliDsoUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AGacH/2UKHZyzL01/pweqGVhcxdcxzYmQTu/v
GWRKCnAPMvgnnxAAHnBpFlzjReK6AOHiMx3l1mpLwQ28v0qdSFo6fXxMoZ1FbLIS
7ptU1BWeYNwlROvvVhcr0aLLS3LEOmeEVJVZfcUdGm1WI4CWSUlVDL5SXwnKAatc
DAWPVXB4Y/U7vGZ8zQfGz8tuvvONg95pjZYRIMp+SLpcMBfPgfXCP7YB9VLJpDGG
jDhSkg4GK0/FEyc0XsIeM+hjP8C4ICCiivuxdUJ3XSnrodM0tdp07SnK9FJiS+66
wFkmNHI18fe7o2tNsnA7UktePR8ALDbXneBDWQlIdOISPrzPXIffwzo=
=jUYr
-----END PGP SIGNATURE-----

--d5T7KBDbt84hVBooRcCQwjc1hIMCaoqQA--
