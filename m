Received: from eggs.gnu.org ([2001:4830:134:3::10]:44533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fYvNR-0006ar-In
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:32:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fYvNP-0007Un-QC
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:32:01 -0400
References: <20180629151524.138542-1-vsementsov@virtuozzo.com>
	<20180629151524.138542-4-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ce1d1003-0011-26ef-7bb0-793f75fde9e5@virtuozzo.com>
Date: Fri, 29 Jun 2018 18:31:48 +0300
MIME-Version: 1.0
In-Reply-To: <20180629151524.138542-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 3/3] qemu-iotests: Image fleecing test
 case 222
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org

29.06.2018 18:15, Vladimir Sementsov-Ogievskiy wrote:
> From: Fam Zheng <famz@redhat.com>
>
> This tests the workflow of creating a lightweight point-in-time snapshot
> with blockdev-backup command, and exporting it with built-in NBD server.
>
> It's tested that any post-snapshot writing to the original device
> doesn't change data seen in NBD target.
>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> [vsementsov: add -f iotests.imgfmt to qemu_io, fix target_img to be
> always qcow2, add -r to qemu_io for nbd, add fleecing-filter layer,
> wrap long lines]
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   tests/qemu-iotests/222     | 112 ++++++++++++++++++++++++++++++++++++++=
+++++++
>   tests/qemu-iotests/222.out |   5 ++
>   tests/qemu-iotests/group   |   1 +
>   3 files changed, 118 insertions(+)
>   create mode 100755 tests/qemu-iotests/222
>   create mode 100644 tests/qemu-iotests/222.out
>
> diff --git a/tests/qemu-iotests/222 b/tests/qemu-iotests/222
> new file mode 100755
> index 0000000000..3bcf9505fd
> --- /dev/null
> +++ b/tests/qemu-iotests/222
> @@ -0,0 +1,112 @@
> +#!/usr/bin/env python
> +#
> +# Tests for image fleecing (point in time snapshot export to NBD)
> +#
> +# Copyright (C) 2014 Red Hat, Inc.
> +#
> +# Based on 055.
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +#
> +
> +import time
> +import os
> +import iotests
> +from iotests import qemu_img, qemu_io
> +
> +test_img =3D os.path.join(iotests.test_dir, 'test.img')
> +target_img =3D os.path.join(iotests.test_dir, 'target.img')
> +nbd_sock =3D os.path.join(iotests.test_dir, 'nbd.sock')
> +
> +class TestImageFleecing(iotests.QMPTestCase):
> +    image_len =3D 64 * 1024 * 1024 # MB
> +
> +    def setUp(self):
> +        # Write data to the image so we can compare later
> +        qemu_img('create', '-f', iotests.imgfmt, test_img,
> +                 str(TestImageFleecing.image_len))
> +        self.patterns =3D [
> +                ("0x5d", "0", "64k"),
> +                ("0xd5", "1M", "64k"),
> +                ("0xdc", "32M", "64k"),
> +                ("0xdc", "67043328", "64k")]
> +
> +        for p in self.patterns:
> +            qemu_io('-f', iotests.imgfmt, '-c', 'write -P%s %s %s' % p,
> +                    test_img)
> +
> +        qemu_img('create', '-f', 'qcow2', target_img,
> +                 str(TestImageFleecing.image_len))
> +
> +        self.vm =3D iotests.VM().add_drive(test_img)
> +        self.vm.launch()
> +
> +        self.overwrite_patterns =3D [
> +                ("0xa0", "0", "64k"),
> +                ("0x0a", "1M", "64k"),
> +                ("0x55", "32M", "64k"),
> +                ("0x56", "67043328", "64k")]
> +
> +        self.nbd_uri =3D "nbd+unix:///drive1?socket=3D%s" % nbd_sock
> +
> +    def tearDown(self):
> +        self.vm.shutdown()
> +        os.remove(test_img)
> +        os.remove(target_img)
> +
> +    def verify_patterns(self):
> +        for p in self.patterns:
> +            self.assertEqual(
> +                    -1,
> +                    qemu_io(self.nbd_uri, '-r', '-c', 'read -P%s %s %s' =
% p)
> +                        .find("verification failed"),
> +                    "Failed to verify pattern: %s %s %s" % p)
> +
> +    def test_image_fleecing(self):
> +        result =3D self.vm.qmp("blockdev-add", **{
> +            "driver": "fleecing-filter",
> +            "node-name": "drive1",
> +            "file": {
> +                "driver": "qcow2",
> +                "file": {
> +                    "driver": "file",
> +                    "filename": target_img,
> +                    },
> +                "backing": "drive0",
> +            }
> +            })
> +        self.assert_qmp(result, 'return', {})
> +
> +        result =3D self.vm.qmp(
> +                "nbd-server-start",
> +                **{"addr": { "type": "unix", "data": { "path": nbd_sock =
} } })
> +        self.assert_qmp(result, 'return', {})
> +        result =3D self.vm.qmp("blockdev-backup", device=3D"drive0",
> +                             target=3D"drive1", sync=3D"none")
> +        self.assert_qmp(result, 'return', {})
> +        result =3D self.vm.qmp("nbd-server-add", device=3D"drive1")
> +        self.assert_qmp(result, 'return', {})
> +
> +        self.verify_patterns()
> +
> +        for p in self.overwrite_patterns:
> +            self.vm.hmp_qemu_io("drive0", "write -P%s %s %s" % p)
> +
> +        self.verify_patterns()
> +
> +        self.cancel_and_wait(resume=3DTrue)
> +        self.assert_no_active_block_jobs()
> +
> +if __name__ =3D=3D '__main__':
> +    iotests.main(supported_fmts=3D['raw', 'qcow2'])
> diff --git a/tests/qemu-iotests/222.out b/tests/qemu-iotests/222.out
> new file mode 100644
> index 0000000000..ae1213e6f8
> --- /dev/null
> +++ b/tests/qemu-iotests/222.out
> @@ -0,0 +1,5 @@
> +.
> +----------------------------------------------------------------------
> +Ran 1 tests
> +
> +OK
> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index eea75819d2..8019a9f721 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -220,3 +220,4 @@
>   218 rw auto quick
>   219 rw auto
>   221 rw auto quick
> +222 rw auto quick

Hmm, don't understand why this works, but it should not, without the=20
following squashed (we can't write to fleecing-filter):

diff --git a/tests/qemu-iotests/222 b/tests/qemu-iotests/222
index 3bcf9505fd..77637a8ce2 100755
--- a/tests/qemu-iotests/222
+++ b/tests/qemu-iotests/222
@@ -76,9 +76,10 @@ class TestImageFleecing(iotests.QMPTestCase):
 =C2=A0=C2=A0=C2=A0=C2=A0 def test_image_fleecing(self):
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D self.vm.qmp("b=
lockdev-add", **{
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=
driver": "fleecing-filter",
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "node-n=
ame": "drive1",
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "node-n=
ame": "drive-fleecing-filter",
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=
file": {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "driver": "qcow2",
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 "node-name": "drive-fleecing-image",
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "file": {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "driver": "file",
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "filename": target_img,
@@ -93,9 +94,9 @@ class TestImageFleecing(iotests.QMPTestCase):
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 **{"addr": { "type": "unix", "data": { "path":=20
nbd_sock } } })
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assert_qmp(result, '=
return', {})
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D self.vm.qmp("b=
lockdev-backup", device=3D"drive0",
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 target=3D"drive1", sync=3D"none")
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 target=3D"drive-fleecing-image", sync=3D"none")
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assert_qmp(result, '=
return', {})
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D self.vm.qmp("nbd-ser=
ver-add", device=3D"drive1")
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D self.vm.qmp("nbd-ser=
ver-add",=20
device=3D"drive-fleecing-filter")


--=20
Best regards,
Vladimir
