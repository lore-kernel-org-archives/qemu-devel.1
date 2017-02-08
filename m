Received: from eggs.gnu.org ([2001:4830:134:3::10]:56698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbG4U-0000XW-RK
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 19:25:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbG4T-0003fw-Hj
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 19:25:18 -0500
References: <20170123123056.30383-1-famz@redhat.com>
	<20170123123056.30383-10-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0b51c7b4-92a3-bfd2-f83b-ed5776ad7e25@redhat.com>
Date: Wed, 8 Feb 2017 01:25:07 +0100
MIME-Version: 1.0
In-Reply-To: <20170123123056.30383-10-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1Ovt3iBHqGoT0nglMr06tNTuUDAFJkwLr"
Subject: Re: [Qemu-devel] [PATCH v12 09/16] iotests: 085: Avoid image
 locking conflict
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1Ovt3iBHqGoT0nglMr06tNTuUDAFJkwLr
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org,
 eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com
Message-ID: <0b51c7b4-92a3-bfd2-f83b-ed5776ad7e25@redhat.com>
Subject: Re: [PATCH v12 09/16] iotests: 085: Avoid image locking conflict
References: <20170123123056.30383-1-famz@redhat.com>
 <20170123123056.30383-10-famz@redhat.com>
In-Reply-To: <20170123123056.30383-10-famz@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 23.01.2017 13:30, Fam Zheng wrote:
> In the case where we test the expected error when a blockdev-snapshot
> target already has a backing image, backing chain is opened multiple

*the backing chain

> times. This will be a problem when we use image locking, so use a
> different backing file that is not already open.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/qemu-iotests/085     | 32 +++++++++++++++++++-------------
>  tests/qemu-iotests/085.out |  3 ++-
>  2 files changed, 21 insertions(+), 14 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/085 b/tests/qemu-iotests/085
> index c53e97f..c91d78d 100755
> --- a/tests/qemu-iotests/085
> +++ b/tests/qemu-iotests/085
> @@ -87,24 +87,26 @@ function create_group_snapshot()
>  }
> =20
>  # ${1}: unique identifier for the snapshot filename
> -# ${2}: true: open backing images; false: don't open them (default)
> +# ${2}: extra_params to the blockdev-add command
> +# ${3}: filename
> +function do_blockdev_add()
> +{
> +    cmd=3D"{ 'execute': 'blockdev-add', 'arguments':
> +           { 'driver': 'qcow2', 'node-name': 'snap_${1}', ${2}
> +             'file':
> +             { 'driver': 'file', 'filename': '${3}',
> +               'node-name': 'file_${1}' } } }"
> +    _send_qemu_cmd $h "${cmd}" "return"
> +}
> +
> +# ${1}: unique identifier for the snapshot filename
>  function add_snapshot_image()
>  {
> -    if [ "${2}" =3D "true" ]; then
> -        extra_params=3D""
> -    else
> -        extra_params=3D"'backing': '', "
> -    fi
>      base_image=3D"${TEST_DIR}/$((${1}-1))-${snapshot_virt0}"
>      snapshot_file=3D"${TEST_DIR}/${1}-${snapshot_virt0}"
>      _make_test_img -b "${base_image}" "$size"
>      mv "${TEST_IMG}" "${snapshot_file}"
> -    cmd=3D"{ 'execute': 'blockdev-add', 'arguments':
> -           { 'driver': 'qcow2', 'node-name': 'snap_${1}', ${extra_para=
ms}
> -             'file':
> -             { 'driver': 'file', 'filename': '${snapshot_file}',
> -               'node-name': 'file_${1}' } } }"
> -    _send_qemu_cmd $h "${cmd}" "return"
> +    do_blockdev_add "$1" "'backing': '', " "${snapshot_file}"
>  }
> =20
>  # ${1}: unique identifier for the snapshot filename
> @@ -222,7 +224,11 @@ echo =3D=3D=3D Invalid command - snapshot node has=
 a backing image =3D=3D=3D
>  echo
> =20
>  SNAPSHOTS=3D$((${SNAPSHOTS}+1))
> -add_snapshot_image ${SNAPSHOTS} true
> +
> +_make_test_img "$size"
> +mv "${TEST_IMG}" "${TEST_IMG}.base"
> +_make_test_img -b "${TEST_IMG}.base" "$size"
> +do_blockdev_add ${SNAPSHOTS} "" "${TEST_IMG}"

These files ($TEST_IMG and ${TEST_IMG}.base) are not removed in _cleanup.=


Looks good apart from that.

Max

>  blockdev_snapshot ${SNAPSHOTS} error
> =20
>  echo
> diff --git a/tests/qemu-iotests/085.out b/tests/qemu-iotests/085.out
> index 08e4bb7..7bbf84d 100644
> --- a/tests/qemu-iotests/085.out
> +++ b/tests/qemu-iotests/085.out
> @@ -78,7 +78,8 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1=
34217728 backing_file=3DTEST_DIR/
> =20
>  =3D=3D=3D Invalid command - snapshot node has a backing image =3D=3D=3D=

> =20
> -Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_=
file=3DTEST_DIR/12-snapshot-v0.IMGFMT
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_=
file=3DTEST_DIR/t.IMGFMT.base
>  {"return": {}}
>  {"error": {"class": "GenericError", "desc": "The snapshot already has =
a backing image"}}
> =20
>=20



--1Ovt3iBHqGoT0nglMr06tNTuUDAFJkwLr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliaZWMSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AJC4IAJyYZN1X8nfIRBXcN39vtohZV40vgNIw
A3jLBI6ys1Mgzu+KeqS+jOCLG6ma/VLU/AjtHVNLmFpMthcGsK01muARwR18Uxgj
vQPN6MEzkolvHoHjayDSfuC0kVdBQznEoAD+qHiA72uPHCcMhpoy56ClZOufjs+s
XRquYSVqgna8yT3ht1h6lSYX9n05EoFoi1FFoP/8fmEyuzX8R5VyDEY0Vso0Cluv
oT1g48he76MFhZTrVSvs9n7psqJoApvBwtKHF/SJRrGXJTv2hwmxz1OfFC5CeeqJ
+7yFhhK0wuJL64DQV78zBuyTOML7pSoIubUR88O+SplBFcactCmor9Y=
=WLl2
-----END PGP SIGNATURE-----

--1Ovt3iBHqGoT0nglMr06tNTuUDAFJkwLr--
