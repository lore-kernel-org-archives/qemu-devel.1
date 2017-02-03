Received: from eggs.gnu.org ([2001:4830:134:3::10]:58094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZjBp-0003tS-OB
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 14:06:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZjBo-00010n-9V
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 14:06:33 -0500
References: <1479837270-79005-1-git-send-email-vsementsov@virtuozzo.com>
	<1479837270-79005-17-git-send-email-vsementsov@virtuozzo.com>
	<59237595-78d7-5aa2-c38a-d986564b5ed0@redhat.com>
	<e25c6fb7-0d1f-a91a-9680-e206f6db2cd8@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <08110a70-355b-acb6-8a65-fd13528d4989@redhat.com>
Date: Fri, 3 Feb 2017 20:06:15 +0100
MIME-Version: 1.0
In-Reply-To: <e25c6fb7-0d1f-a91a-9680-e206f6db2cd8@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pnOlAeVqDeFefKvju2UlxFFNtPopPCOO4"
Subject: Re: [Qemu-devel] [PATCH 16/17] iotests: add dirty bitmap migration
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pnOlAeVqDeFefKvju2UlxFFNtPopPCOO4
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com,
 famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com,
 quintela@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org,
 dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com
Message-ID: <08110a70-355b-acb6-8a65-fd13528d4989@redhat.com>
Subject: Re: [PATCH 16/17] iotests: add dirty bitmap migration test
References: <1479837270-79005-1-git-send-email-vsementsov@virtuozzo.com>
 <1479837270-79005-17-git-send-email-vsementsov@virtuozzo.com>
 <59237595-78d7-5aa2-c38a-d986564b5ed0@redhat.com>
 <e25c6fb7-0d1f-a91a-9680-e206f6db2cd8@virtuozzo.com>
In-Reply-To: <e25c6fb7-0d1f-a91a-9680-e206f6db2cd8@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 03.02.2017 11:10, Vladimir Sementsov-Ogievskiy wrote:
> 02.02.2017 02:12, Max Reitz wrote:
>> On 22.11.2016 18:54, Vladimir Sementsov-Ogievskiy wrote:
>>> The test starts two vms (vm_a, vm_b), create dirty bitmap in
>>> the first one, do several writes to corresponding device and
>>> then migrate vm_a to vm_b with dirty bitmaps.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>>   tests/qemu-iotests/169     | 86
>>> ++++++++++++++++++++++++++++++++++++++++++++++
>>>   tests/qemu-iotests/169.out |  5 +++
>>>   tests/qemu-iotests/group   |  1 +
>>>   3 files changed, 92 insertions(+)
>>>   create mode 100755 tests/qemu-iotests/169
>>>   create mode 100644 tests/qemu-iotests/169.out
>>>
>>> diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
>>> new file mode 100755
>>> index 0000000..58b1ab1
>>> --- /dev/null
>>> +++ b/tests/qemu-iotests/169
>>> @@ -0,0 +1,86 @@
>>> +#!/usr/bin/env python
>>> +#
>>> +# Tests for dirty bitmaps migration.
>>> +#
>>> +# Copyright (C) Vladimir Sementsov-Ogievskiy 2015-2016
>>> +#
>>> +# This program is free software; you can redistribute it and/or modi=
fy
>>> +# it under the terms of the GNU General Public License as published =
by
>>> +# the Free Software Foundation; either version 2 of the License, or
>>> +# (at your option) any later version.
>>> +#
>>> +# This program is distributed in the hope that it will be useful,
>>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> +# GNU General Public License for more details.
>>> +#
>>> +# You should have received a copy of the GNU General Public License
>>> +# along with this program.  If not, see <http://www.gnu.org/licenses=
/>.
>>> +#
>>> +
>>> +import os
>>> +import iotests
>>> +import time
>>> +from iotests import qemu_img
>>> +
>>> +disk_a =3D os.path.join(iotests.test_dir, 'disk_a')
>>> +disk_b =3D os.path.join(iotests.test_dir, 'disk_b')
>>> +fifo =3D os.path.join(iotests.test_dir, 'mig_fifo')
>>> +
>>> +class TestDirtyBitmapMigration(iotests.QMPTestCase):
>>> +
>>> +    def setUp(self):
>>> +        size =3D 0x400000000 # 1G
>> I can already see someone on macOS complaining that this test eats the=
ir
>> hard drive when running it for raw images... But we can still amend it=

>> once somebody complains. O:-)
>>
>> I think 1 GB is not overly large, but it's reasonable to use such a
>> rather large value for this test.
>>
>>> +        os.mkfifo(fifo)
>>> +        qemu_img('create', '-f', iotests.imgfmt, disk_a, str(size))
>>> +        qemu_img('create', '-f', iotests.imgfmt, disk_b, str(size))
>>> +        self.vm_a =3D iotests.VM(path_suffix=3D'a').add_drive(disk_a=
)
>>> +        self.vm_b =3D iotests.VM(path_suffix=3D'b').add_drive(disk_b=
)
>>> +        self.vm_b.add_incoming_migration("exec: cat " + fifo)
>> I guess this will break if the path contains white space. Is there
>> something we can do about that?
>>
>> (You don't need to protect against quotes or something, just white
>> space.)
>>
>>> +        self.vm_a.launch()
>>> +        self.vm_b.launch()
>>> +
>>> +    def tearDown(self):
>>> +        self.vm_a.shutdown()
>>> +        self.vm_b.shutdown()
>>> +        os.remove(disk_a)
>>> +        os.remove(disk_b)
>>> +        os.remove(fifo)
>>> +
>>> +    def test_migration(self):
>>> +        granularity =3D 512
>>> +        regions =3D [
>>> +            { 'start': 0,           'count': 0x100000 },
>>> +            { 'start': 0x100000000, 'count': 0x200000  },
>>> +            { 'start': 0x399900000, 'count': 0x100000  }
>>> +            ]
>>> +
>>> +        result =3D self.vm_a.qmp('block-dirty-bitmap-add', node=3D'd=
rive0',
>>> +                               name=3D'bitmap', granularity=3Dgranul=
arity)
>>> +        self.assert_qmp(result, 'return', {});
>>> +
>>> +        for r in regions:
>>> +          self.vm_a.hmp_qemu_io('drive0',
>> This line isn't aligned to four spaces.
>>
>> With that fixed, and if you deem fixing the white space issue too
>> complicated:
>=20
> may be, just add quotes, like
>=20
> self.vm_b.add_incoming_migration("exec: cat '" + fifo + "'")

Yep, that would be fine with me.

Max

>=20
>=20
> ?
>=20
>>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>
>>> +                                'write %d %d' % (r['start'],
>>> r['count']))
>>> +
>>> +        result =3D self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256'=
,
>>> +                               node=3D'drive0', name=3D'bitmap')
>>> +        sha256 =3D result['return']['sha256']
>>> +
>>> +        result =3D self.vm_a.qmp('migrate-set-capabilities',
>>> +                               capabilities=3D[{'capability':
>>> 'dirty-bitmaps',
>>> +                                              'state': True}])
>>> +        self.assert_qmp(result, 'return', {})
>>> +
>>> +        result =3D self.vm_a.qmp('migrate', uri=3D'exec:cat>' + fifo=
)
>>> +        self.assertNotEqual(self.vm_a.event_wait("STOP"), None)
>>> +        self.assertNotEqual(self.vm_b.event_wait("RESUME"), None)
>>> +        time.sleep(2)
>>> +
>>> +        result =3D self.vm_b.qmp('x-debug-block-dirty-bitmap-sha256'=
,
>>> +                               node=3D'drive0', name=3D'bitmap')
>>> +        self.assert_qmp(result, 'return/sha256', sha256);
>>> +
>>> +
>>> +if __name__ =3D=3D '__main__':
>>> +    iotests.main()
>>> diff --git a/tests/qemu-iotests/169.out b/tests/qemu-iotests/169.out
>>> new file mode 100644
>>> index 0000000..ae1213e
>>> --- /dev/null
>>> +++ b/tests/qemu-iotests/169.out
>>> @@ -0,0 +1,5 @@
>>> +.
>>> +--------------------------------------------------------------------=
--
>>> +Ran 1 tests
>>> +
>>> +OK
>>> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
>>> index 866c1a0..5dc75ef 100644
>>> --- a/tests/qemu-iotests/group
>>> +++ b/tests/qemu-iotests/group
>>> @@ -162,6 +162,7 @@
>>>   159 rw auto quick
>>>   160 rw auto quick
>>>   162 auto quick
>>> +169 rw auto quick
>>>   170 rw auto quick
>>>   171 rw auto quick
>>>   172 auto
>>>
>>
>=20
>=20



--pnOlAeVqDeFefKvju2UlxFFNtPopPCOO4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliU1KcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AHAwH/3Ep2iqINa45uROzUvYAdrJFb2szNqNc
wQHR43Yko1TK0tczlk7GPt8ofhHlM+sVGi/WKo4P7QKvA4D1x1JePMpnBQiC3k1C
MAYDIpiTpxO1/zHIigQ7eqzfUymOsQPgXfiM2Hx0pjtoO+Omb+9oU8g8+6PL1Y0y
udiNW3PXCpbISOui5waUDFnCC1QbHyS3SHVEBXOUxV9XsRdUu+/LmeDbq/OX34Td
8poDRSRqDD9wFY/GziPw0f9qlXNee2Ubn9IBVp3JBFMAps+4A2GXHOx6viozbRkA
hNIKGZp6DxC5VGGcPcrV3DjDHKNIqhsiFBIlFS2YDcBdfMQYW+fVYA4=
=WIR/
-----END PGP SIGNATURE-----

--pnOlAeVqDeFefKvju2UlxFFNtPopPCOO4--
