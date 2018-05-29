Received: from eggs.gnu.org ([2001:4830:134:3::10]:44785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNeHa-0005aN-UW
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:03:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNeHV-0007ba-CF
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:03:22 -0400
References: <20180525163327.23097-1-kwolf@redhat.com>
	<20180525163327.23097-11-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2b8a13e2-eb82-6e29-0cc5-04f1fac33327@redhat.com>
Date: Tue, 29 May 2018 15:02:47 +0200
MIME-Version: 1.0
In-Reply-To: <20180525163327.23097-11-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XUe733BUcxsycw8rF6phiUpFXJZpnVz88"
Subject: Re: [Qemu-devel] [PATCH 10/14] qemu-iotests: Rewrite 210 for
 blockdev-create job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XUe733BUcxsycw8rF6phiUpFXJZpnVz88
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <2b8a13e2-eb82-6e29-0cc5-04f1fac33327@redhat.com>
Subject: Re: [PATCH 10/14] qemu-iotests: Rewrite 210 for blockdev-create job
References: <20180525163327.23097-1-kwolf@redhat.com>
 <20180525163327.23097-11-kwolf@redhat.com>
In-Reply-To: <20180525163327.23097-11-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-25 18:33, Kevin Wolf wrote:
> This rewrites the test case 210 to work with the new x-blockdev-create
> job rather than the old synchronous version of the command.
>=20
> All of the test cases stay the same as before, but in order to be able
> to implement proper job handling, the test case is rewritten in Python.=

>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/210        | 393 ++++++++++++++++++----------------=
--------
>  tests/qemu-iotests/210.out    | 189 ++++++++++++++------
>  tests/qemu-iotests/group      |   2 +-
>  tests/qemu-iotests/iotests.py |  12 +-
>  4 files changed, 310 insertions(+), 286 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

> diff --git a/tests/qemu-iotests/210 b/tests/qemu-iotests/210
> index e607c0d296..ff4fddea56 100755
> --- a/tests/qemu-iotests/210
> +++ b/tests/qemu-iotests/210

[...]

> +    #
> +    # Invalid sizes
> +    #
> +
> +    # TODO Negative image sizes aren't handled correctly, but this is =
a problem
> +    # with QAPI's implementation of the 'size' type and affects other =
commands as
> +    # well. Once this is fixed, we may want to add a test case here.
> +
> +    # 1. 2^64 - 512
> +    # 2. 2^63 =3D 8 EB (qemu-img enforces image sizes less than this)
> +    # 3. 2^63 - 512 (generally valid, but with the crypto header the f=
ile will
> +    #                exceed 63 bits)
> +    iotests.log("=3D=3D=3D Invalid sizes =3D=3D=3D")
> +    iotests.log("")
> +
> +    vm.launch()
> +    for size in [ 18446744073709551104, 9223372036854775808, 922337203=
6854775296 ]:

Maybe this would be nice in patch 8 as well.

Max

> +        blockdev_create(vm, { 'driver': imgfmt,
> +                              'file': 'node0',
> +                              'key-secret': 'keysec0',
> +                              'size': size })
> +    vm.shutdown(


--XUe733BUcxsycw8rF6phiUpFXJZpnVz88
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsNT3cACgkQ9AfbAGHV
z0DVHAf+K6HbrgkMeK5mi7cAsNk4/obPLsE9FCWPs9IkKpRTcJ0/jxAZg2fkiymg
VfqfaPJusShPzrVdFMnRa6LFBqE0K+5UxrVnmkLkFYROHrsaMQNe9wTSKh5XF5cE
BFwDg9sRn2VozukYPNb48hDBGkyn3qdJFcHAWuAiX0ypzfuckOUxD2z1qpw5Fap8
xXaQ/nJI/VS5IlT5kMbUDUNhT2sflTUTEhiZTW8or0pMau8WM+7JiDe+ySIodjHn
SBxwdwV0yuqZLJIoWMgqNGJKeK3d886gqgtlc49CbHcYAR0km0u7VCIpKmyAohom
RwFfuSjPKW3QMhPe1FqAkYn6fjaODQ==
=t+9u
-----END PGP SIGNATURE-----

--XUe733BUcxsycw8rF6phiUpFXJZpnVz88--
