Received: from eggs.gnu.org ([2001:4830:134:3::10]:51188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNef0-0007nF-8Q
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:27:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNeez-0001RR-Ar
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:27:34 -0400
References: <20180525163327.23097-1-kwolf@redhat.com>
	<20180525163327.23097-14-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <274aac5e-04e0-675f-0c3d-c72a63858e5d@redhat.com>
Date: Tue, 29 May 2018 15:27:24 +0200
MIME-Version: 1.0
In-Reply-To: <20180525163327.23097-14-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HSXbNSfE04pklgQEhgsyOds3J4g8gxsVy"
Subject: Re: [Qemu-devel] [PATCH 13/14] qemu-iotests: Rewrite 213 for
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
--HSXbNSfE04pklgQEhgsyOds3J4g8gxsVy
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <274aac5e-04e0-675f-0c3d-c72a63858e5d@redhat.com>
Subject: Re: [PATCH 13/14] qemu-iotests: Rewrite 213 for blockdev-create job
References: <20180525163327.23097-1-kwolf@redhat.com>
 <20180525163327.23097-14-kwolf@redhat.com>
In-Reply-To: <20180525163327.23097-14-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-25 18:33, Kevin Wolf wrote:
> This rewrites the test case 213 to work with the new x-blockdev-create
> job rather than the old synchronous version of the command.
>=20
> All of the test cases stay the same as before, but in order to be able
> to implement proper job handling, the test case is rewritten in Python.=

>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/213     | 520 +++++++++++++++++--------------------=
--------
>  tests/qemu-iotests/213.out | 198 ++++++++++-------
>  tests/qemu-iotests/group   |   4 +-
>  3 files changed, 314 insertions(+), 408 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/213 b/tests/qemu-iotests/213
> index 3a00a0f6d6..fe4017edc7 100755
> --- a/tests/qemu-iotests/213
> +++ b/tests/qemu-iotests/213

[...]

> +import iotests
> +from iotests import imgfmt
> +
> +iotests.verify_image_format(supported_fmts=3D['vhdx'])
> +iotests.verify_protocol(supported=3D['file'])
> +
> +def blockdev_create(vm, options):
> +    result =3D vm.qmp_log('x-blockdev-create', job_id=3D'job0', option=
s=3Doptions)
> +
> +    if 'return' in result:
> +        assert result['return'] =3D=3D {}
> +        vm.run_job('job0')
> +    iotests.log("")
> +
> +with iotests.FilePath('t.vdi') as disk_path, \

Now you've just given up? :-)

Again, with that fixed:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--HSXbNSfE04pklgQEhgsyOds3J4g8gxsVy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsNVTwACgkQ9AfbAGHV
z0BXrgf/RQ9zx2jGh263z86d7iLY+c/zFXfRpefbA/oB1g5sKSWM5hFmCVHTT+95
WoSRqlnq7TtlNWCzJZ4unv94ZD/NUEuck1dkznbA4l8MA9drprNpqUnG2bh4tw2p
jFahQk7AnMXO/J4krMPQtdqUECHn+XDOjHujf9JkVWHy3R1p02seggi14heC+HAJ
wpZj/3eDWhfTovh9UfAM8duBQBKqMkETpTTArIYPQwbzE0qtzI/ZO/HE7twPSjAE
3z3Eb6472D7pw9uPbMVYMElCHRULY287tv0YhuvTW6y63dIGkztmh64E0AH4jo2M
qkzK9Z5D8LSxpn1mhIy3XyW2YgEbBA==
=vEMs
-----END PGP SIGNATURE-----

--HSXbNSfE04pklgQEhgsyOds3J4g8gxsVy--
