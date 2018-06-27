Received: from eggs.gnu.org ([2001:4830:134:3::10]:60147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fY3N8-0001H1-Ui
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 01:52:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fY3N7-0003Mi-UZ
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 01:52:07 -0400
References: <20180626222226.27620-1-jsnow@redhat.com>
	<20180626222226.27620-3-jsnow@redhat.com>
	<841140e6-0ea5-6ca0-f9e4-1f9224b313f5@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d77341f6-cb36-3317-e748-64a205e668c1@redhat.com>
Date: Wed, 27 Jun 2018 01:51:59 -0400
MIME-Version: 1.0
In-Reply-To: <841140e6-0ea5-6ca0-f9e4-1f9224b313f5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 2/2] iotests: add 222 to test basic
 fleecing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>



On 06/26/2018 09:49 PM, Eric Blake wrote:
> On 06/26/2018 05:22 PM, John Snow wrote:
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>> =C2=A0 tests/qemu-iotests/222=C2=A0=C2=A0 | 121

Probably would have helped to include 222.out, though.

>> +++++++++++++++++++++++++++++++++++++++++++++++
>> =C2=A0 tests/qemu-iotests/group |=C2=A0=C2=A0 1 +
>> =C2=A0 2 files changed, 122 insertions(+)
>> =C2=A0 create mode 100644 tests/qemu-iotests/222
>>
>> diff --git a/tests/qemu-iotests/222 b/tests/qemu-iotests/222
>> new file mode 100644
>> index 0000000000..133d10c351
>> --- /dev/null
>> +++ b/tests/qemu-iotests/222
>> @@ -0,0 +1,121 @@
>> +#!/usr/bin/env python
>> +#
>> +# This test covers the basic fleecing workflow.
>> +#
>> +# Copyright (C) 2018 Red Hat, Inc.
>> +# John helped, too.
>=20
> LOL.
>=20
>> +
>> +patterns =3D [("0x5d", "0", "64k"),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ("=
0xd5", "1M", "64k"),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ("=
0xdc", "32M", "64k"),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ("=
0xcd", "67043328", "64k")]=C2=A0 # 64M - 64K
>> +
>> +overwrite =3D [("0xab", "0",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "64k"), # Full overwrite
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ("0xad", "1015808",=C2=A0 "64k"), # Partial-left (1M-32K)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ("0x1d", "33587200", "64k"), # Partial-right (32M+32K)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ("0xea", "64M", "64k")]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Adjacent-righ=
t (64M)
>> +
>> +with iotests.FilePath('base.img') as base_img_path, \
>> +=C2=A0=C2=A0=C2=A0=C2=A0 iotests.FilePath('fleece.img') as fleece_img=
_path, \
>> +=C2=A0=C2=A0=C2=A0=C2=A0 iotests.FilePath('nbd.sock') as nbd_sock_pat=
h, \
>> +=C2=A0=C2=A0=C2=A0=C2=A0 iotests.VM() as vm:
>=20
> Does python require \ even after ','?
>=20

Dunno. Cargo cult from 216.

> The test looks valid - you are definitely reading data over NBD from th=
e
> point in time that you started the blockdev-backup job, even while the
> source image continues to be modified.
>=20
>> +=C2=A0=C2=A0=C2=A0 for p in overwrite:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmd =3D "write -P%s %s %s"=
 % p
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log(cmd)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log(vm.hmp_qemu_io(srcNode=
, cmd))
>> +
>> +=C2=A0=C2=A0=C2=A0 log('')
>> +=C2=A0=C2=A0=C2=A0 log('--- Verifying Data ---')
>> +=C2=A0=C2=A0=C2=A0 log('')
>> +
>> +=C2=A0=C2=A0=C2=A0 for p in patterns:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmd =3D "read -P%s %s %s" =
% p
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log(cmd)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert qemu_io_silent('-r'=
, '-f', 'raw', '-c', cmd, nbd_uri)
>> =3D=3D 0
>=20
> Perhaps additional steps would be to then stop the NBD export, stop the
> block job, delete the tgtNode fleecing file, then stop qemu, and finall=
y
> check that the overwritten patterns correctly show up in the source
> image (that is, also prove that we can tear down a job, and that the
> overwrites worked).=C2=A0 And we may want to enhance this test (or use =
it as
> a starting point to copy into a new test) to play with persistent dirty
> bitmaps thrown into the mix as well.=C2=A0 But what you have is already=
 a
> great start to prevent regressions, so:
>=20

Good suggestions. I'm working toward throwing bitmaps in now, but
actually cleaning up the VM properly and stopping the NBD server and
testing some of the latter-half paths would be nice. This was just a bit
of an RFC to get the bits out there sooner rather than later.

> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

Too many changes I need to pepper in for v2, but thanks for the vote of
confidence :)
