Received: from eggs.gnu.org ([2001:4830:134:3::10]:33960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evjWr-0003iw-5g
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evjWq-0002Lg-ES
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:59:45 -0400
References: <20180313115814.23774-1-famz@redhat.com>
	<20180313115814.23774-3-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a6d85bee-ff03-68f7-b0a3-8c8c1f5b7c79@redhat.com>
Date: Tue, 13 Mar 2018 13:59:26 +0100
MIME-Version: 1.0
In-Reply-To: <20180313115814.23774-3-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3R0KqKsBw2WhpZR01cZRdMjJUYM64q8hP"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] iotests: Add regression test for
 commit base locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3R0KqKsBw2WhpZR01cZRdMjJUYM64q8hP
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <a6d85bee-ff03-68f7-b0a3-8c8c1f5b7c79@redhat.com>
Subject: Re: [PATCH v2 2/2] iotests: Add regression test for commit base
 locking
References: <20180313115814.23774-1-famz@redhat.com>
 <20180313115814.23774-3-famz@redhat.com>
In-Reply-To: <20180313115814.23774-3-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-13 12:58, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/qemu-iotests/153     | 8 ++++++++
>  tests/qemu-iotests/153.out | 4 ++++
>  2 files changed, 12 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
> index adfd02695b..a7875e6899 100755
> --- a/tests/qemu-iotests/153
> +++ b/tests/qemu-iotests/153
> @@ -178,6 +178,14 @@ rm -f "${TEST_IMG}.lnk" &>/dev/null
>  ln -s ${TEST_IMG} "${TEST_IMG}.lnk" || echo "Failed to create link"
>  _run_qemu_with_images "${TEST_IMG}.lnk" "${TEST_IMG}"
> =20
> +echo
> +echo "=3D=3D Active commit to intermediate layer should work when base=
 in use =3D=3D"
> +_launch_qemu -drive format=3D$IMGFMT,file=3D"${TEST_IMG}.a",id=3Ddrive=
0 \
> +             -device virtio-blk,drive=3Ddrive0
> +_run_cmd $QEMU_IMG commit -b "${TEST_IMG}.b" "${TEST_IMG}.c"
> +
> +_cleanup_qemu
> +
>  _launch_qemu
> =20
>  _send_qemu_cmd $QEMU_HANDLE \
> diff --git a/tests/qemu-iotests/153.out b/tests/qemu-iotests/153.out
> index 34309cfb20..28f8250dd2 100644
> --- a/tests/qemu-iotests/153.out
> +++ b/tests/qemu-iotests/153.out
> @@ -372,6 +372,10 @@ Is another process using the image?
>  =3D=3D Symbolic link =3D=3D
>  QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2: Failed to get "wr=
ite" lock
>  Is another process using the image?
> +
> +=3D=3D Active commit to intermediate layer should work when base in us=
e =3D=3D
> +
> +_qemu_img_wrapper commit -b TEST_DIR/t.qcow2.b TEST_DIR/t.qcow2.c
>  {"return": {}}
>  Adding drive

Hmmm...  I don't know, but this just passes on my machine without your
previous patch.

[Two minutes later]

Now I do know why, qemu simply isn't properly started at the time
$QEMU_IMG commit runs (see also 6bfc907deed83af7).  Therefore, no error
here.

So if I just add a

_send_qemu_cmd $QEMU_HANDLE \
    "{ 'execute': 'qmp_capabilities' }" \
    'return'

after the _launch_qemu, this is what I get:

QEMU_PROG: -device virtio-blk,drive=3Ddrive0: Drive 'drive0' is already i=
n
use because it has been automatically connected to another device (did
you need 'if=3Dnone' in the drive options?)

With if=3Dnone (or just -blockdev instead of -drive), I get the error
message I was hoping for.

Max


--3R0KqKsBw2WhpZR01cZRdMjJUYM64q8hP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqnyy4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AJlYIALKF4F814EXF7Q3KGDrLUWYXonxAn9lb
3aYLY96UDn5QHDCbpGvXJQIfRcH8IVWKEivGoF8kbnZoBXx/WXmq/AnMQWvcDPfo
FESkx0y4lkN4EVHqUjel8gWjjGq3FnyD7S3+DxC2TI5NeqtUxms2BKUwHWpG8yAV
7BBAkFFrUWsaC5ljF+HfI6oEwo+Be+O2Y8mwe9C3SY09wzS/0uoGaasy5v0HqBTv
vmghJhtRTE9dwp54YNaZ3rlSN4dwItlrRk+8tewUe+XAwP17dojHfFasC36qqXI7
eX6n6gaf7Vd1XNreo1RfSu0I30em8FCah46zwUtmQ2lKriSBcHdUWPI=
=CgMZ
-----END PGP SIGNATURE-----

--3R0KqKsBw2WhpZR01cZRdMjJUYM64q8hP--
