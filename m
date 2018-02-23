Received: from eggs.gnu.org ([2001:4830:134:3::10]:38622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1epDUq-0004b5-9C
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1epDUm-0006Rv-BF
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:34:44 -0500
References: <1518441241-32557-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1518441241-32557-2-git-send-email-anton.nefedov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a69e1300-dbb2-ee8e-8b47-386bb431907a@redhat.com>
Date: Fri, 23 Feb 2018 14:34:30 +0100
MIME-Version: 1.0
In-Reply-To: <1518441241-32557-2-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Q5RAvFHvLVCder1MbVekq30m7Cu3awh1x"
Subject: Re: [Qemu-devel] [PATCH v2 1/2] iotest 033: add misaligned
 write-zeroes test via truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, stefanha@redhat.com, famz@redhat.com, berto@igalia.com, eblake@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q5RAvFHvLVCder1MbVekq30m7Cu3awh1x
From: Max Reitz <mreitz@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, stefanha@redhat.com,
 famz@redhat.com, berto@igalia.com, eblake@redhat.com
Message-ID: <a69e1300-dbb2-ee8e-8b47-386bb431907a@redhat.com>
Subject: Re: [PATCH v2 1/2] iotest 033: add misaligned write-zeroes test via
 truncate
References: <1518441241-32557-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1518441241-32557-2-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1518441241-32557-2-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-12 14:14, Anton Nefedov wrote:
> This new test case only makes sense for qcow2 while iotest 033 is gener=
ic;
> however it matches the test purpose perfectly and also 033 contains tho=
se
> do_test() tricks to pass the alignment, which won't look nice being
> duplicated in other tests or moved to the common code.
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  tests/qemu-iotests/033     | 28 ++++++++++++++++++++++++++++
>  tests/qemu-iotests/033.out | 13 +++++++++++++
>  2 files changed, 41 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/033 b/tests/qemu-iotests/033
> index 2cdfd13..5fa3983 100755
> --- a/tests/qemu-iotests/033
> +++ b/tests/qemu-iotests/033
> @@ -64,6 +64,9 @@ do_test()
>  	} | $QEMU_IO $IO_EXTRA_ARGS
>  }
> =20
> +echo
> +echo "=3D=3D=3D Test aligned and misaligned write zeroes operations =3D=
=3D=3D"
> +
>  for write_zero_cmd in "write -z" "aio_write -z"; do
>  for align in 512 4k; do
>  	echo
> @@ -102,7 +105,32 @@ for align in 512 4k; do
>  done
>  done
> =20
> +
> +# Trigger truncate that would shrink qcow2 L1 table, which is done by
> +#   clearing one entry (8 bytes) with bdrv_co_pwrite_zeroes()
> +
> +echo
> +echo "=3D=3D=3D Test misaligned write zeroes via truncate =3D=3D=3D"
> +echo
> +
> +CLUSTER_SIZE=3D$((64 * 1024))
> +L2_COVERAGE=3D$(($CLUSTER_SIZE * $CLUSTER_SIZE / 8))
> +_make_test_img $(($L2_COVERAGE * 2))

There should be a _cleanup_test_img before this or this test will fail
with nbd.

Max


--Q5RAvFHvLVCder1MbVekq30m7Cu3awh1x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqQGGYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A+PQH/A9/Opgv+kmNEcxH8Jb2ndneVZ9iEWeO
xlOX3QOM+ChYErKTDlaHitPSeNP/kEj1PwLgEv80pwPAHdz1/ZVFUi6HsSF03ug4
OFfzb6PvoPEePwi1S3P3eZIOCrh0KiwSQt0FqPkuRXFpSf+YmWWgmZhL/td+92qW
ylmToYT1xj1GOvEvx2a+EbezzDfkAcDLEoTQ6bKSGcCcOvUI4UFLkV5NBjYsyqUH
1fP7j5hvqn5PoFgFRChU8xW8fkGmQTjTPoGT7qu4m+erFZULiIVOnGiwh3s6exDx
UbMhn1HrqqSWXGfkAQOZKXnQd8dIzUSQyj3ntTgJtlyolkx8kcBYf9k=
=vRw8
-----END PGP SIGNATURE-----

--Q5RAvFHvLVCder1MbVekq30m7Cu3awh1x--
