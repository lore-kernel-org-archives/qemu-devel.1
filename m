Received: from eggs.gnu.org ([2001:4830:134:3::10]:49804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eMgiZ-00061k-7D
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:55:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eMgiX-0008KB-UN
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:54:59 -0500
References: <20171128071409.21887-1-vsementsov@virtuozzo.com>
	<20171128071409.21887-5-vsementsov@virtuozzo.com>
	<2ecd455b-4e33-e35b-6b17-9fe4ac47002b@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <017dec88-9f05-eacf-e261-d01ff10de47e@redhat.com>
Date: Wed, 6 Dec 2017 15:54:48 -0500
MIME-Version: 1.0
In-Reply-To: <2ecd455b-4e33-e35b-6b17-9fe4ac47002b@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 4/4] iotests: add dirty bitmap
 migration test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, mreitz@redhat.com, ehabkost@redhat.com, crosa@redhat.com



On 12/06/2017 04:51 AM, Vladimir Sementsov-Ogievskiy wrote:
> 28.11.2017 10:14, Vladimir Sementsov-Ogievskiy wrote:
>> The test creates two vms (vm_a, vm_b), create dirty bitmap in
>> the first one, do several writes to corresponding device and
>> then migrate vm_a to vm_b with dirty bitmaps.
>>
>> For now, only migration through shared storage for persistent
>> bitmaps is available, so it is tested here. Only offline variant
>> is tested for now (a kind of suspend-resume), as it is needed
>> to test that this case is successfully fixed by recent patch.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =C2=A0 tests/qemu-iotests/169=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 82
>> +++++++++++++++++++++++++++++++++++++++++++
>> =C2=A0 tests/qemu-iotests/169.out=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++
>> =C2=A0 tests/qemu-iotests/group=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
1 +
>> =C2=A0 tests/qemu-iotests/iotests.py |=C2=A0 7 +++-
>> =C2=A0 4 files changed, 94 insertions(+), 1 deletion(-)
>> =C2=A0 create mode 100755 tests/qemu-iotests/169
>> =C2=A0 create mode 100644 tests/qemu-iotests/169.out
>>
>> diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
>> new file mode 100755
>> index 0000000000..a0f213b274
>> --- /dev/null
>> +++ b/tests/qemu-iotests/169
>> @@ -0,0 +1,82 @@
>> +#!/usr/bin/env python
>> +#
>> +# Tests for dirty bitmaps migration.
>> +#
>> +# Copyright (c) 2016-2017 Parallels International GmbH
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
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program.=C2=A0 If not, see <http://www.gnu.org/lice=
nses/>.
>> +#
>> +
>> +import os
>> +import iotests
>> +import time
>> +from iotests import qemu_img
>> +
>> +disk =3D os.path.join(iotests.test_dir, 'disk')
>> +migfile =3D os.path.join(iotests.test_dir, 'migfile')
>> +
>> +class TestPersistentDirtyBitmapSuspendResume(iotests.QMPTestCase):
>> +
>> +=C2=A0=C2=A0=C2=A0 def tearDown(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm_a.shutdown()
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm_b.shutdown()
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 os.remove(disk)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 os.remove(migfile)
>> +
>> +=C2=A0=C2=A0=C2=A0 def setUp(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_img('create', '-f', i=
otests.imgfmt, disk, '1M')
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm_a =3D iotests.VM(p=
ath_suffix=3D'a').add_drive(disk)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm_a.launch()
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm_b =3D iotests.VM(p=
ath_suffix=3D'b').add_drive(disk)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm_b.add_incoming("ex=
ec: cat '" + migfile + "'")
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_migration_persistent_shared_offline(self)=
:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """ A kind of suspend-resu=
me """
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 granularity =3D 512
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regions =3D [
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { =
'start': 0,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '=
count': 0x10000 },
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { =
'start': 0xf0000,=C2=A0=C2=A0=C2=A0=C2=A0 'count': 0x10000 },
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { =
'start': 0xa0201,=C2=A0=C2=A0=C2=A0=C2=A0 'count': 0x1000=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ]
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D self.vm_a.qmp('=
block-dirty-bitmap-add', node=3D'drive0',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name=3D'bitmap0', granularity=3Dgran=
ularity,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 persistent=3DTrue, autoload=3DTrue)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assert_qmp(result, 'r=
eturn', {});
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for r in regions:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 se=
lf.vm_a.hmp_qemu_io('drive0',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'write %d %d' % (r=
['start'],
>> r['count']))
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D self.vm_a.qmp('=
x-debug-block-dirty-bitmap-sha256',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node=3D'drive0', name=3D'bitmap0')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sha256 =3D result['return'=
]['sha256']
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D self.vm_a.qmp('=
migrate', uri=3D'exec:cat>' + migfile)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assert_qmp(result, 'r=
eturn', {});
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertNotEqual(self.v=
m_a.event_wait("STOP"), None)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm_a.shutdown()
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm_b.launch()
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm_b.event_wait("RESU=
ME", timeout=3D10)
>=20
> with previous patch dropped, please fix it to be 10.0

Oh, I see, it gets confused over integral values? We should probably fix
that but it can be separate for now.

Everything looks good to me in that case, thanks
