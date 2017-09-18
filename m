Received: from eggs.gnu.org ([2001:4830:134:3::10]:59361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtzJF-0003vC-0g
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:54:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtzJD-0000Kk-J3
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:54:13 -0400
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170913181910.29688-19-mreitz@redhat.com>
	<20170918064515.GF15551@lemon.lan>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ea1f7b60-4b95-f40a-2dc9-e368a74b3de5@redhat.com>
Date: Mon, 18 Sep 2017 18:53:51 +0200
MIME-Version: 1.0
In-Reply-To: <20170918064515.GF15551@lemon.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ec0Eb59FBegLR1hsCuIHq0tOgDkigexvW"
Subject: Re: [Qemu-devel] [PATCH 18/18] iotests: Add test for active
 mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ec0Eb59FBegLR1hsCuIHq0tOgDkigexvW
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <ea1f7b60-4b95-f40a-2dc9-e368a74b3de5@redhat.com>
Subject: Re: [PATCH 18/18] iotests: Add test for active mirroring
References: <20170913181910.29688-1-mreitz@redhat.com>
 <20170913181910.29688-19-mreitz@redhat.com>
 <20170918064515.GF15551@lemon.lan>
In-Reply-To: <20170918064515.GF15551@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-18 08:45, Fam Zheng wrote:
> On Wed, 09/13 20:19, Max Reitz wrote:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/151     | 111 ++++++++++++++++++++++++++++++++++++=
+++++++++
>>  tests/qemu-iotests/151.out |   5 ++
>>  tests/qemu-iotests/group   |   1 +
>>  3 files changed, 117 insertions(+)
>>  create mode 100755 tests/qemu-iotests/151
>>  create mode 100644 tests/qemu-iotests/151.out
>>
>> diff --git a/tests/qemu-iotests/151 b/tests/qemu-iotests/151
>> new file mode 100755
>> index 0000000000..49a60773f9
>> --- /dev/null
>> +++ b/tests/qemu-iotests/151
>> @@ -0,0 +1,111 @@
>> +#!/usr/bin/env python
>> +#
>> +# Tests for active mirroring
>> +#
>> +# Copyright (C) 2017 Red Hat, Inc.
>> +#
>> +# This program is free software; you can redistribute it and/or modif=
y
>> +# it under the terms of the GNU General Public License as published b=
y
>> +# the Free Software Foundation; either version 2 of the License, or
>> +# (at your option) any later version.
>> +#
>> +# This program is distributed in the hope that it will be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program.  If not, see <http://www.gnu.org/licenses/=
>.
>> +#
>> +
>> +import os
>> +import iotests
>> +from iotests import qemu_img
>> +
>> +source_img =3D os.path.join(iotests.test_dir, 'source.' + iotests.img=
fmt)
>> +target_img =3D os.path.join(iotests.test_dir, 'target.' + iotests.img=
fmt)
>> +
>> +class TestActiveMirror(iotests.QMPTestCase):
>> +    image_len =3D 128 * 1024 * 1024 # MB
>> +    potential_writes_in_flight =3D True
>> +
>> +    def setUp(self):
>> +        qemu_img('create', '-f', iotests.imgfmt, source_img, '128M')
>> +        qemu_img('create', '-f', iotests.imgfmt, target_img, '128M')
>> +
>> +        blk_source =3D {'node-name': 'source',
>> +                      'driver': iotests.imgfmt,
>> +                      'file': {'driver': 'file',
>> +                               'filename': source_img}}
>> +
>> +        blk_target =3D {'node-name': 'target',
>> +                      'driver': iotests.imgfmt,
>> +                      'file': {'driver': 'file',
>> +                               'filename': target_img}}
>> +
>> +        self.vm =3D iotests.VM()
>> +        self.vm.add_blockdev(self.qmp_to_opts(blk_source))
>> +        self.vm.add_blockdev(self.qmp_to_opts(blk_target))
>> +        self.vm.launch()
>> +
>> +    def tearDown(self):
>> +        self.vm.shutdown()
>> +
>> +        if not self.potential_writes_in_flight:
>> +            self.assertTrue(iotests.compare_images(source_img, target=
_img),
>> +                            'mirror target does not match source')
>> +
>> +        os.remove(source_img)
>> +        os.remove(target_img)
>> +
>> +    def doActiveIO(self, sync_source_and_target):
>> +        # Fill the source image
>> +        self.vm.hmp_qemu_io('source',
>> +                            'write -P 1 0 %i' % self.image_len);
>> +
>> +        # Start some background requests
>> +        for offset in range(0, self.image_len, 1024 * 1024):
>> +            self.vm.hmp_qemu_io('source', 'write -B -P 2 %i 1M' % off=
set)
>> +
>> +        # Start the block job
>> +        result =3D self.vm.qmp('blockdev-mirror',
>> +                             job_id=3D'mirror',
>> +                             filter_node_name=3D'mirror-node',
>> +                             device=3D'source',
>> +                             target=3D'target',
>> +                             sync=3D'full',
>> +                             copy_mode=3D'active-write')
>> +        self.assert_qmp(result, 'return', {})
>> +
>> +        # Start some more requests
>> +        for offset in range(0, self.image_len, 1024 * 1024):
>> +            self.vm.hmp_qemu_io('mirror-node', 'write -B -P 3 %i 1M' =
% offset)
>> +
>> +        # Wait for the READY event
>> +        self.wait_ready(drive=3D'mirror')
>> +
>> +        # Now start some final requests; all of these (which land on
>> +        # the source) should be settled using the active mechanism.
>> +        # The mirror code itself asserts that the source BDS's dirty
>> +        # bitmap will stay clean between READY and COMPLETED.
>> +        for offset in range(0, self.image_len, 1024 * 1024):
>> +            self.vm.hmp_qemu_io('mirror-node', 'write -B -P 4 %i 1M' =
% offset)
>> +
>> +        if sync_source_and_target:
>> +            # If source and target should be in sync after the mirror=
,
>> +            # we have to flush before completion
>=20
> Not sure I understand this requirements, does it apply to libvirt and u=
ser too?
> I.e. it's a part of the interface ? Why cannot mirror_complete do it
> automatically?

Well, it seems to pass without this flush, but the original intention
was this: When mirror is completed, the source node is replaced by the
target.  All further writes are then only executed on the (former)
target node.  So what might happen (or at least I think it could) is
that qemu-io submits some writes, but before they are actually
performed, the mirror block job is completed and the source is replaced
by the target.  Then, the write operations are performed on the target
but no longer on the source, so source and target are then out of sync.

For the mirror block job, that is fine -- at the point of completion,
source and target were in sync.  The job doesn't care that they get out
of sync after completion.  But here, we have to care or we can't compare
source and target.

The reason for why it always seems to pass without a flush is that every
submitted write is actually sent to the mirror node before it yields for
the first time.  But I wouldn't bet on that, so I think it's better to
keep the flush before completing the block job.

Max

>=20
> Fam
>=20
>> +            self.vm.hmp_qemu_io('mirror-node', 'flush')
>> +            self.potential_writes_in_flight =3D False
>> +
>> +        self.complete_and_wait(drive=3D'mirror', wait_ready=3DFalse)
>> +
>> +    def testActiveIO(self):
>> +        self.doActiveIO(False)
>> +
>> +    def testActiveIOFlushed(self):
>> +        self.doActiveIO(True)
>> +
>> +
>> +
>> +if __name__ =3D=3D '__main__':
>> +    iotests.main(supported_fmts=3D['qcow2', 'raw'])
>> diff --git a/tests/qemu-iotests/151.out b/tests/qemu-iotests/151.out
>> new file mode 100644
>> index 0000000000..fbc63e62f8
>> --- /dev/null
>> +++ b/tests/qemu-iotests/151.out
>> @@ -0,0 +1,5 @@
>> +..
>> +---------------------------------------------------------------------=
-
>> +Ran 2 tests
>> +
>> +OK
>> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
>> index 94e764865a..c64adbe5bf 100644
>> --- a/tests/qemu-iotests/group
>> +++ b/tests/qemu-iotests/group
>> @@ -156,6 +156,7 @@
>>  148 rw auto quick
>>  149 rw auto sudo
>>  150 rw auto quick
>> +151 rw auto
>>  152 rw auto quick
>>  153 rw auto quick
>>  154 rw auto backing quick
>> --=20
>> 2.13.5
>>



--ec0Eb59FBegLR1hsCuIHq0tOgDkigexvW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlm/+h8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AwH0IALKJ7yuyOccv3lAq0fzevCWCyZVI1jg2
W8hQFRJe4p9KCiHNYeIDVmjYaQ0oC5+pSXthHkzXc+AG8WqxbvAVT+eOaP7DhjO+
HtbZT07KJzsrd+d1U5diMRu3lRN/if+KeHD39HxfSC9bByyorXxJ+s/vnSybFYQM
IYV4cQGg5ObUccXXOc1AcKFq2XxYv2DCBU61zpQ17NErWfo3lBr6PHIwq7m5ojAx
ZOz6ZKG/F9oQ9rFWTX92M9SmC++svxGcUUEi8OpuGVLr9zK7+WuAIo2EHSy5k+eP
IJFDJWdcdW1OhagDtDyhsmzkET+ryQAeuKAw6GqOaJNRtnz8Adkc4Is=
=sZs9
-----END PGP SIGNATURE-----

--ec0Eb59FBegLR1hsCuIHq0tOgDkigexvW--
