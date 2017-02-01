Received: from eggs.gnu.org ([2001:4830:134:3::10]:54487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZ2Zt-00062B-4H
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 16:36:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZ2Zs-0007AM-8B
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 16:36:33 -0500
References: <cover.1485878688.git.berto@igalia.com>
	<79f66648c685929a144396bda24d13a207131dcf.1485878688.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <24208ca5-8964-a99f-d80f-b196d508d47f@redhat.com>
Date: Wed, 1 Feb 2017 22:36:20 +0100
MIME-Version: 1.0
In-Reply-To: <79f66648c685929a144396bda24d13a207131dcf.1485878688.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="scupRp0q2SBEdM4rNJlPENsoAieh8ktj3"
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-io: don't allow I/O operations
 larger than INT_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--scupRp0q2SBEdM4rNJlPENsoAieh8ktj3
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <24208ca5-8964-a99f-d80f-b196d508d47f@redhat.com>
Subject: Re: [PATCH 1/2] qemu-io: don't allow I/O operations larger than
 INT_MAX
References: <cover.1485878688.git.berto@igalia.com>
 <79f66648c685929a144396bda24d13a207131dcf.1485878688.git.berto@igalia.com>
In-Reply-To: <79f66648c685929a144396bda24d13a207131dcf.1485878688.git.berto@igalia.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 31.01.2017 17:09, Alberto Garcia wrote:
> Passing a request size larger than INT_MAX to any of the I/O commands
> results in an error. While 'read' and 'write' handle the error
> correctly, 'aio_read' and 'aio_write' hit an assertion:
>=20
> blk_aio_read_entry: Assertion `rwco->qiov->size =3D=3D acb->bytes' fail=
ed.
>=20
> The reason is that the QEMU I/O code cannot handle request sizes
> larger than INT_MAX, so this patch makes qemu-io check that all values
> are within range.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  qemu-io-cmds.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>=20
> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
> index 95bcde1d88..d806a83076 100644
> --- a/qemu-io-cmds.c
> +++ b/qemu-io-cmds.c
> @@ -388,9 +388,14 @@ create_iovec(BlockBackend *blk, QEMUIOVector *qiov=
, char **argv, int nr_iov,
>              goto fail;
>          }
> =20
> -        if (len > SIZE_MAX) {
> -            printf("Argument '%s' exceeds maximum size %llu\n", arg,
> -                   (unsigned long long)SIZE_MAX);
> +        if (len > INT_MAX) {
> +            printf("Argument '%s' exceeds maximum size %d\n", arg, INT=
_MAX);
> +            goto fail;
> +        }
> +
> +        if (count > INT_MAX - len) {

How about using BDRV_REQUEST_MAX_BYTES instead?

(not yet in master, just in my block branch)

Max

> +            printf("The total number of bytes exceed the maximum size =
%d\n",
> +                   INT_MAX);
>              goto fail;
>          }
> =20
> @@ -682,9 +687,8 @@ static int read_f(BlockBackend *blk, int argc, char=
 **argv)
>      if (count < 0) {
>          print_cvtnum_err(count, argv[optind]);
>          return 0;
> -    } else if (count > SIZE_MAX) {
> -        printf("length cannot exceed %" PRIu64 ", given %s\n",
> -               (uint64_t) SIZE_MAX, argv[optind]);
> +    } else if (count > INT_MAX) {
> +        printf("length cannot exceed %d, given %s\n", INT_MAX, argv[op=
tind]);
>          return 0;
>      }
> =20
> @@ -1004,9 +1008,8 @@ static int write_f(BlockBackend *blk, int argc, c=
har **argv)
>      if (count < 0) {
>          print_cvtnum_err(count, argv[optind]);
>          return 0;
> -    } else if (count > SIZE_MAX) {
> -        printf("length cannot exceed %" PRIu64 ", given %s\n",
> -               (uint64_t) SIZE_MAX, argv[optind]);
> +    } else if (count > INT_MAX) {
> +        printf("length cannot exceed %d, given %s\n", INT_MAX, argv[op=
tind]);
>          return 0;
>      }
> =20
>=20



--scupRp0q2SBEdM4rNJlPENsoAieh8ktj3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliSVNQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ACsQIAILfWh2nl8VUbReqt2tuBiDl3iS6PliL
EykLSd4jN4nLSfExSt+gsfTgkh5e5u0KqQq12p62Hb3xm3nQNjmHVjZ1chDkEqIH
5y7+NFMmxkgaWJUVB2n9k8QCdfeweVaHITIeDk7NBwN9Ci6cIN6HDVRNEiGiKI4s
Fz/O8Ghv/I7xxSiVycgRKQ5p9SX5k87zDpvBM4GBa52FCCs4FuxsCLVSYlZSXLl7
FYUjSJP/11Wgh224iwdzFYVXVH6sJX424DHeRq4POSEgCVAZ3lXPQH/E6NGz2Hsh
ONeLlUlAdobjbjOa71zHFfOlGk1u1SnGRHLiATs6oIJscoQ4QUTIXYU=
=f2DR
-----END PGP SIGNATURE-----

--scupRp0q2SBEdM4rNJlPENsoAieh8ktj3--
