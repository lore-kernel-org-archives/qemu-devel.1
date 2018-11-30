Received: from eggs.gnu.org ([2001:4830:134:3::10]:55009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gShwN-0006oO-O5
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:30:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gShwM-0008UC-DU
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:30:39 -0500
References: <20181129101801.6421-1-vsementsov@virtuozzo.com>
	<20181129101801.6421-3-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2f4c1bec-b5ca-e97f-88f9-75f3d2cb210c@redhat.com>
Date: Fri, 30 Nov 2018 13:30:17 +0100
MIME-Version: 1.0
In-Reply-To: <20181129101801.6421-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="u1JQxXN5pUQkKPDTf13qt95KlBMM9ZmKG"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] iotests: simple mirror test with
 kvm on 1G image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, pbonzini@redhat.com, dplotnikov@virtuozzo.com, den@openvz.org, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u1JQxXN5pUQkKPDTf13qt95KlBMM9ZmKG
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, pbonzini@redhat.com,
 dplotnikov@virtuozzo.com, den@openvz.org, qemu-stable@nongnu.org
Message-ID: <2f4c1bec-b5ca-e97f-88f9-75f3d2cb210c@redhat.com>
Subject: Re: [PATCH v2 2/2] iotests: simple mirror test with kvm on 1G image
References: <20181129101801.6421-1-vsementsov@virtuozzo.com>
 <20181129101801.6421-3-vsementsov@virtuozzo.com>
In-Reply-To: <20181129101801.6421-3-vsementsov@virtuozzo.com>
Content-Type: multipart/mixed;
 boundary="------------1D131B3D02F2F40C6284C2DC"

--------------1D131B3D02F2F40C6284C2DC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.11.18 11:18, Vladimir Sementsov-Ogievskiy wrote:
> This test is broken without previous commit fixing dead-lock in mirror.=

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/235     | 59 ++++++++++++++++++++++++++++++++++++++=

>  tests/qemu-iotests/235.out |  1 +
>  tests/qemu-iotests/group   |  1 +
>  3 files changed, 61 insertions(+)
>  create mode 100755 tests/qemu-iotests/235
>  create mode 100644 tests/qemu-iotests/235.out

I'll get to the first patch in a second, but first a suggestion for this
patch: I think it's not so good to use 2 GB of space for a test (1 GB
for the source, 1 GB for the target).  So I tried my luck and found that
the test works, too, if you just use preallocation=3Dmetadata for the
source (instead of actually writing data) and blockdev-mirror'ing the
data to a throttled null-co device.

(Also, the test as-is passes even without patch 1 on tmpfs, at least for
me.  But with the configuration described above, it fails there, too.)

I've attached a diff.

Max

> diff --git a/tests/qemu-iotests/235 b/tests/qemu-iotests/235
> new file mode 100755
> index 0000000000..e5d1ae6593
> --- /dev/null
> +++ b/tests/qemu-iotests/235
> @@ -0,0 +1,59 @@
> +#!/usr/bin/env python
> +#
> +# Simple mirror test
> +#
> +# Copyright (c) 2018 Virtuozzo International GmbH. All rights reserved=
=2E
> +#
> +# This program is free software; you can redistribute it and/or modify=

> +# it under the terms of the GNU General Public License as published by=

> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>=
=2E
> +#
> +
> +import sys
> +import os
> +import iotests
> +from iotests import qemu_img_create, qemu_io, file_path
> +
> +sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 's=
cripts'))
> +
> +from qemu import QEMUMachine
> +
> +# Note:
> +# This test was added to check that mirror dead-lock was fixed (see pr=
evious
> +# commit before this test addition).
> +# And it didn't reproduce if at least one of the following:
> +# 1. use small image size
> +# 2. use raw format (not qcow2)
> +# 3. drop kvm and use iotests.VM() (maybe, because of qtest) (however,=
 it still
> +#    reproduces, if just drop kvm, but gdb failed to produce full back=
traces
> +#    for me)
> +# 4. add iothread
> +
> +size =3D '1G'
> +
> +iotests.verify_image_format(supported_fmts=3D['raw', 'qcow2'])
> +
> +disk, target =3D file_path('disk', 'target')
> +
> +# prepare source image
> +qemu_img_create('-f', iotests.imgfmt, disk, size)
> +qemu_io('-f', iotests.imgfmt, '-c', 'write 0 ' + size, disk)
> +
> +vm =3D QEMUMachine(iotests.qemu_prog)
> +vm.add_args('-machine', 'pc,accel=3Dkvm')
> +vm.add_args('-drive', 'id=3Dsrc,file=3D' + disk)
> +vm.launch()
> +
> +print(vm.qmp('drive-mirror', device=3D'src', target=3Dtarget, sync=3D'=
full'))
> +vm.event_wait('BLOCK_JOB_READY')
> +
> +vm.shutdown()
> diff --git a/tests/qemu-iotests/235.out b/tests/qemu-iotests/235.out
> new file mode 100644
> index 0000000000..d6ccbad8fa
> --- /dev/null
> +++ b/tests/qemu-iotests/235.out
> @@ -0,0 +1 @@
> +{u'return': {}}
> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index 8c56a0ad11..61a6d98ebd 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -232,3 +232,4 @@
>  232 auto quick
>  233 auto quick
>  234 auto quick migration
> +235 auto quick
>=20


--------------1D131B3D02F2F40C6284C2DC
Content-Type: text/x-patch;
 name="235.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="235.diff"

diff --git a/tests/qemu-iotests/235 b/tests/qemu-iotests/235
index e5d1ae6593..c5264972b9 100755
--- a/tests/qemu-iotests/235
+++ b/tests/qemu-iotests/235
@@ -21,7 +21,7 @@
 import sys
 import os
 import iotests
-from iotests import qemu_img_create, qemu_io, file_path
+from iotests import qemu_img_create, qemu_io, file_path, log
=20
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'scr=
ipts'))
=20
@@ -38,22 +38,34 @@ from qemu import QEMUMachine
 #    for me)
 # 4. add iothread
=20
-size =3D '1G'
+size =3D 1 * 1024 * 1024 * 1024
=20
 iotests.verify_image_format(supported_fmts=3D['raw', 'qcow2'])
=20
-disk, target =3D file_path('disk', 'target')
+disk =3D file_path('disk')
=20
 # prepare source image
-qemu_img_create('-f', iotests.imgfmt, disk, size)
-qemu_io('-f', iotests.imgfmt, '-c', 'write 0 ' + size, disk)
+qemu_img_create('-f', iotests.imgfmt, '-o', 'preallocation=3Dmetadata', =
disk,
+                str(size))
=20
 vm =3D QEMUMachine(iotests.qemu_prog)
 vm.add_args('-machine', 'pc,accel=3Dkvm')
 vm.add_args('-drive', 'id=3Dsrc,file=3D' + disk)
 vm.launch()
=20
-print(vm.qmp('drive-mirror', device=3D'src', target=3Dtarget, sync=3D'fu=
ll'))
+log(vm.qmp('object-add', qom_type=3D'throttle-group', id=3D'tg0',
+           props=3D{ 'x-bps-total': 64 * 1048576 }))
+
+log(vm.qmp('blockdev-add',
+           **{ 'node-name': 'target',
+               'driver': 'throttle',
+               'throttle-group': 'tg0',
+               'file': {
+                   'driver': 'null-co',
+                   'size': size
+                } }))
+
+log(vm.qmp('blockdev-mirror', device=3D'src', target=3D'target', sync=3D=
'full'))
 vm.event_wait('BLOCK_JOB_READY')
=20
 vm.shutdown()
diff --git a/tests/qemu-iotests/235.out b/tests/qemu-iotests/235.out
index d6ccbad8fa..39db621e04 100644
--- a/tests/qemu-iotests/235.out
+++ b/tests/qemu-iotests/235.out
@@ -1 +1,3 @@
-{u'return': {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}

--------------1D131B3D02F2F40C6284C2DC--

--u1JQxXN5pUQkKPDTf13qt95KlBMM9ZmKG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlwBLVoACgkQ9AfbAGHV
z0CthAgAwQLLD7SRfd/XzDfitVFSi50L5VRnsls4mDcdq+XNjTUx3q1akGgS9JTB
oN37Vnj4ZBkYVm2hL1X3sj1/YYyvtSulFINj1tWh74lYDpuRskKjy+C2ri1wxiYd
Gmb2GvFatvSHahM2qavd8d+KZWf4Dgbbn7dGORcqhhqsvoIrTDFsTubPd+xGfGDw
rvEBdlCn569XtllcjLokn7iCJLydQuxiedA6/r2VWdr7gKWVGbJPtW6O4aicRB7/
+cj6GY93/f9tuxIRSvpL0UoFRcnzGO/qtauEHRdmfbCrqFUTA6eqF9X7CxTeN4Pl
NZWWf5EH1OpJvrcgnlxnlGY+DpGASA==
=WWkp
-----END PGP SIGNATURE-----

--u1JQxXN5pUQkKPDTf13qt95KlBMM9ZmKG--
