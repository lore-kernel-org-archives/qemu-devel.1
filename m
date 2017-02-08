Received: from eggs.gnu.org ([2001:4830:134:3::10]:59260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbGMK-0004rz-Rc
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 19:43:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbGMJ-0004aq-GV
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 19:43:44 -0500
References: <20170123123056.30383-1-famz@redhat.com>
	<20170123123056.30383-12-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <34c5d39e-6a1e-304d-f0ea-4e4b6b3ee764@redhat.com>
Date: Wed, 8 Feb 2017 01:43:33 +0100
MIME-Version: 1.0
In-Reply-To: <20170123123056.30383-12-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OkFuLDTkgjIPkumaeriNGHkXuaFl6f0Dh"
Subject: Re: [Qemu-devel] [PATCH v12 11/16] iotests: 172: Use separate
 images for multiple devices
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
--OkFuLDTkgjIPkumaeriNGHkXuaFl6f0Dh
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org,
 eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com
Message-ID: <34c5d39e-6a1e-304d-f0ea-4e4b6b3ee764@redhat.com>
Subject: Re: [PATCH v12 11/16] iotests: 172: Use separate images for multiple
 devices
References: <20170123123056.30383-1-famz@redhat.com>
 <20170123123056.30383-12-famz@redhat.com>
In-Reply-To: <20170123123056.30383-12-famz@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 23.01.2017 13:30, Fam Zheng wrote:
> To avoid image lock failures.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/qemu-iotests/172     | 53 ++++++++++++++++++++++++--------------=
--------
>  tests/qemu-iotests/172.out | 50 ++++++++++++++++++++++----------------=
-----
>  2 files changed, 54 insertions(+), 49 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/172 b/tests/qemu-iotests/172
> index 1b7d3a1..f9d4cff 100755
> --- a/tests/qemu-iotests/172
> +++ b/tests/qemu-iotests/172
> @@ -86,6 +86,9 @@ size=3D720k
> =20
>  _make_test_img $size
> =20
> +TEST_IMG=3D"$TEST_IMG.2" _make_test_img $size
> +TEST_IMG=3D"$TEST_IMG.3" _make_test_img $size

These images should be removed in _cleanup.

Alternatively, you could use the good old driver=3Dnull-co,size=3D$size.

(btw, I'm amazed that size=3D720k works. Not sure if that is intended, bu=
t
I won't complain. It even works in JSON (with 'size': '720k').)

> +
>  # Default drive semantics:
>  #
>  # By default you get a single empty floppy drive. You can override it =
with
> @@ -105,7 +108,7 @@ echo =3D=3D=3D Using -fda/-fdb options =3D=3D=3D
> =20
>  check_floppy_qtree -fda "$TEST_IMG"
>  check_floppy_qtree -fdb "$TEST_IMG"
> -check_floppy_qtree -fda "$TEST_IMG" -fdb "$TEST_IMG"
> +check_floppy_qtree -fda "$TEST_IMG" -fdb "$TEST_IMG.2"
> =20
> =20
>  echo
> @@ -114,7 +117,7 @@ echo =3D=3D=3D Using -drive options =3D=3D=3D
> =20
>  check_floppy_qtree -drive if=3Dfloppy,file=3D"$TEST_IMG"
>  check_floppy_qtree -drive if=3Dfloppy,file=3D"$TEST_IMG",index=3D1
> -check_floppy_qtree -drive if=3Dfloppy,file=3D"$TEST_IMG" -drive if=3Df=
loppy,file=3D"$TEST_IMG",index=3D1
> +check_floppy_qtree -drive if=3Dfloppy,file=3D"$TEST_IMG" -drive if=3Df=
loppy,file=3D"$TEST_IMG.2",index=3D1
> =20
>  echo
>  echo
> @@ -122,7 +125,7 @@ echo =3D=3D=3D Using -drive if=3Dnone and -global =3D=
=3D=3D
> =20
>  check_floppy_qtree -drive if=3Dnone,file=3D"$TEST_IMG" -global isa-fdc=
=2EdriveA=3Dnone0
>  check_floppy_qtree -drive if=3Dnone,file=3D"$TEST_IMG" -global isa-fdc=
=2EdriveB=3Dnone0
> -check_floppy_qtree -drive if=3Dnone,file=3D"$TEST_IMG" -drive if=3Dnon=
e,file=3D"$TEST_IMG" \
> +check_floppy_qtree -drive if=3Dnone,file=3D"$TEST_IMG" -drive if=3Dnon=
e,file=3D"$TEST_IMG.2" \
>                     -global isa-fdc.driveA=3Dnone0 -global isa-fdc.driv=
eB=3Dnone1
> =20
>  echo
> @@ -131,7 +134,7 @@ echo =3D=3D=3D Using -drive if=3Dnone and -device =3D=
=3D=3D
> =20
>  check_floppy_qtree -drive if=3Dnone,file=3D"$TEST_IMG" -device floppy,=
drive=3Dnone0
>  check_floppy_qtree -drive if=3Dnone,file=3D"$TEST_IMG" -device floppy,=
drive=3Dnone0,unit=3D1
> -check_floppy_qtree -drive if=3Dnone,file=3D"$TEST_IMG" -drive if=3Dnon=
e,file=3D"$TEST_IMG" \
> +check_floppy_qtree -drive if=3Dnone,file=3D"$TEST_IMG",file.disable-lo=
ck=3Don -drive if=3Dnone,file=3D"$TEST_IMG.2" \

disable-lock is not yet available, and also I don't know why you are
using it here. Is it just an artifact from an earlier version, perhaps?

Rest looks good.

Max

>                     -device floppy,drive=3Dnone0 -device floppy,drive=3D=
none1,unit=3D1
> =20
>  echo

[...]



--OkFuLDTkgjIPkumaeriNGHkXuaFl6f0Dh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliaabUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ai1oIAJEWgig14QKzQN8sCba15F0nzE34ZMTw
VxSh9FxQ0J57S2Sa2mlFgXnR9oRBnPQVImNWq0TQ+x0+HKaf5geIjog60y/guW6k
rdjpIumsvtzG67PtoyZiKBFNSmOxu/Yl+miATCqJI5mRgsf/SdoiOOBrxykVRiSJ
1KiQrqfYK+ijUzPAhZf0Gjvp6AzpHD0eABaUn3pN+JPz2rdXB7lv+CKZ+CtpiZf0
7ZBsOU+8z/A5meiik3JKlz2niNgyLbx3IiB8dRT2o+qnqeXfsLWt9pDVU1Jna6OB
59iJRa2NbN8D/Oky7+aN0/haz4h/RQDC9kd7UcNHQ5H5/cUjnof8hOE=
=WMn4
-----END PGP SIGNATURE-----

--OkFuLDTkgjIPkumaeriNGHkXuaFl6f0Dh--
