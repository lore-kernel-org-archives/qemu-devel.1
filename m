Received: from eggs.gnu.org ([2001:4830:134:3::10]:60059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fa3l9-0007hi-6x
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fa3l7-0006EW-IU
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:41:11 -0400
References: <20180628212544.21854-1-jsnow@redhat.com>
	<20180628212544.21854-3-jsnow@redhat.com>
	<a8aecf35-467d-6164-61a2-ae6d0187ac18@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <6a40e370-b0ac-470e-74a3-f7d2d1fac87c@redhat.com>
Date: Mon, 2 Jul 2018 14:41:02 -0400
MIME-Version: 1.0
In-Reply-To: <a8aecf35-467d-6164-61a2-ae6d0187ac18@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/2] iotests: add 222 to test basic
 fleecing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>



On 07/02/2018 08:53 AM, Vladimir Sementsov-Ogievskiy wrote:
> 29.06.2018 00:25, John Snow wrote:
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>> =C2=A0 tests/qemu-iotests/222=C2=A0=C2=A0=C2=A0=C2=A0 | 152
>> +++++++++++++++++++++++++++++++++++++++++++++
>> =C2=A0 tests/qemu-iotests/222.out |=C2=A0 66 ++++++++++++++++++++
>> =C2=A0 tests/qemu-iotests/group=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 3 files changed, 219 insertions(+)
>> =C2=A0 create mode 100644 tests/qemu-iotests/222
>> =C2=A0 create mode 100644 tests/qemu-iotests/222.out
>>
>> diff --git a/tests/qemu-iotests/222 b/tests/qemu-iotests/222
>> new file mode 100644
>> index 0000000000..bd84dfa379
>> --- /dev/null
>> +++ b/tests/qemu-iotests/222
>> @@ -0,0 +1,152 @@
>> +#!/usr/bin/env python
>> +#
>> +# This test covers the basic fleecing workflow, which provides a
>> +# point-in-time snapshot of a node that can be queried over NBD.
>> +#
>> +# Copyright (C) 2018 Red Hat, Inc.
>> +# John helped, too.
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
>> +# Creator/Owner: John Snow <jsnow@redhat.com>
>> +
>> +import iotests
>> +from iotests import log, qemu_img, qemu_io, qemu_io_silent
>> +
>> +iotests.verify_platform(['linux'])
>> +
>> +patterns =3D [("0x5d", "0",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 "64k"),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ("=
0xd5", "1M",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "64k"),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ("=
0xdc", "32M",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "64k"),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ("=
0xcd", "0x3ff0000", "64k")]=C2=A0 # 64M - 64K
>> +
>> +overwrite =3D [("0xab", "0",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 "64k"), # Full overwrite
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ("0xad", "0x00f8000", "64k"), # Partial-left (1M-32K)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ("0x1d", "0x2008000", "64k"), # Partial-right (32M+32K)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ("0xea", "0x3fe0000", "64k")] # Adjacent-left (64M - 128K)
>> +
>> +zeroes =3D [("0", "0x00f8000", "32k"), # Left-end of partial-left (1M=
-32K)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ("0", "0x20100=
00", "32k"), # Right-end of partial-right
>> (32M+64K)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ("0", "0x3fe00=
00", "64k")] # overwrite[3]
>> +
>> +remainder =3D [("0xd5", "0x108000",=C2=A0 "32k"), # Right-end of
>> partial-left [1]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ("0xdc", "32M",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "32k"), # Left-en=
d of
>> partial-right [2]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ("0xcd", "0x3ff0000", "64k")] # patterns[3]
>> +
>> +with iotests.FilePath('base.img') as base_img_path, \
>> +=C2=A0=C2=A0=C2=A0=C2=A0 iotests.FilePath('fleece.img') as fleece_img=
_path, \
>> +=C2=A0=C2=A0=C2=A0=C2=A0 iotests.FilePath('nbd.sock') as nbd_sock_pat=
h, \
>> +=C2=A0=C2=A0=C2=A0=C2=A0 iotests.VM() as vm:
>=20
> Didn't you try use file_path instead like in 209 iotest? It allows
> reduce test indentation to zero.
>=20

Matter of taste, I guess. It feels weird to see code at the zero indent.

>> +
>> +=C2=A0=C2=A0=C2=A0 log('--- Setting up images ---')
>> +=C2=A0=C2=A0=C2=A0 log('')
>> +
>> +=C2=A0=C2=A0=C2=A0 assert qemu_img('create', '-f', iotests.imgfmt, ba=
se_img_path,
>> '64M') =3D=3D 0
>> +=C2=A0=C2=A0=C2=A0 assert qemu_img('create', '-f', "qcow2", fleece_im=
g_path, '64M')
>> =3D=3D 0
>> +
>> +=C2=A0=C2=A0=C2=A0 for p in patterns:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_io('-c', 'write -P%s =
%s %s' % p, base_img_path)
>=20
> don't we need -f iotests.imgfmt here?
>=20

Empirically, apparently not. I'll amend it though.

>> +
>> +=C2=A0=C2=A0=C2=A0 log('Done')
>> +
>> +=C2=A0=C2=A0=C2=A0 log('')
>> +=C2=A0=C2=A0=C2=A0 log('--- Launching VM ---')
>> +=C2=A0=C2=A0=C2=A0 log('')
>> +
>> +=C2=A0=C2=A0=C2=A0 vm.add_drive(base_img_path)
>> +=C2=A0=C2=A0=C2=A0 vm.launch()
>> +=C2=A0=C2=A0=C2=A0 log('Done')
>> +
>> +=C2=A0=C2=A0=C2=A0 log('')
>> +=C2=A0=C2=A0=C2=A0 log('--- Setting up Fleecing Graph ---')
>> +=C2=A0=C2=A0=C2=A0 log('')
>> +
>> +=C2=A0=C2=A0=C2=A0 srcNode =3D "drive0"
>> +=C2=A0=C2=A0=C2=A0 tgtNode =3D "fleeceNode"
>=20
> a bit of nit-picking: underscore_style is insisted by PEP8 and even use=
d
> for all other variables here
>=20

I'll change it :(

>> +
>> +=C2=A0=C2=A0=C2=A0 # create tgtNode backed by srcNode
>> +=C2=A0=C2=A0=C2=A0 log(vm.qmp("blockdev-add", **{
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "driver": "qcow2",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "node-name": tgtNode,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "file": {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "d=
river": "file",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "f=
ilename": fleece_img_path,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "backing": srcNode,
>> +=C2=A0=C2=A0=C2=A0 }))
>> +
>> +=C2=A0=C2=A0=C2=A0 # Establish COW from source to fleecing node
>> +=C2=A0=C2=A0=C2=A0 log(vm.qmp("blockdev-backup",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 device=3DsrcNode,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 target=3DtgtNode,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sync=3D"none"))
>> +
>> +=C2=A0=C2=A0=C2=A0 log('')
>> +=C2=A0=C2=A0=C2=A0 log('--- Setting up NBD Export ---')
>> +=C2=A0=C2=A0=C2=A0 log('')
>> +
>> +=C2=A0=C2=A0=C2=A0 nbd_uri =3D 'nbd+unix:///%s?socket=3D%s' % (tgtNod=
e, nbd_sock_path)
>> +=C2=A0=C2=A0=C2=A0 log(vm.qmp("nbd-server-start",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 **{"addr": { "type": "unix",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 "data": { "path": nbd_sock_path } } }))
>> +
>> +=C2=A0=C2=A0=C2=A0 log(vm.qmp("nbd-server-add", device=3DtgtNode))
>> +
>> +=C2=A0=C2=A0=C2=A0 log('')
>> +=C2=A0=C2=A0=C2=A0 log('--- Sanity Check ---')
>> +=C2=A0=C2=A0=C2=A0 log('')
>> +
>> +=C2=A0=C2=A0=C2=A0 for p in (patterns + zeroes):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmd =3D "read -P%s %s %s" =
% p
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log(cmd)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert qemu_io_silent('-r'=
, '-f', 'raw', '-c', cmd, nbd_uri)
>> =3D=3D 0
>> +
>> +=C2=A0=C2=A0=C2=A0 log('')
>> +=C2=A0=C2=A0=C2=A0 log('--- Testing COW ---')
>> +=C2=A0=C2=A0=C2=A0 log('')
>> +
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
>> +=C2=A0=C2=A0=C2=A0 for p in (patterns + zeroes):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmd =3D "read -P%s %s %s" =
% p
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log(cmd)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert qemu_io_silent('-r'=
, '-f', 'raw', '-c', cmd, nbd_uri)
>> =3D=3D 0
>> +
>> +=C2=A0=C2=A0=C2=A0 log('')
>> +=C2=A0=C2=A0=C2=A0 log('--- Cleanup ---')
>> +=C2=A0=C2=A0=C2=A0 log('')
>> +
>> +=C2=A0=C2=A0=C2=A0 log(vm.qmp('block-job-cancel', device=3DsrcNode))
>=20
> I think, we should wait for cancelled, like in original test
>=20

Yes.

>> +=C2=A0=C2=A0=C2=A0 log(vm.qmp('nbd-server-stop'))
>> +=C2=A0=C2=A0=C2=A0 log(vm.qmp('blockdev-del', node_name=3DtgtNode))
>> +=C2=A0=C2=A0=C2=A0 vm.shutdown()
>> +
>> +=C2=A0=C2=A0=C2=A0 log('')
>> +=C2=A0=C2=A0=C2=A0 log('--- Confirming writes ---')
>> +=C2=A0=C2=A0=C2=A0 log('')
>> +
>> +=C2=A0=C2=A0=C2=A0 for p in (overwrite + remainder):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmd =3D "read -P%s %s %s" =
% p
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log(cmd)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert qemu_io_silent(base=
_img_path, '-c', cmd) =3D=3D 0
>> +
>> +=C2=A0=C2=A0=C2=A0 log('')
>> +=C2=A0=C2=A0=C2=A0 log('Done')
>> diff --git a/tests/qemu-iotests/222.out b/tests/qemu-iotests/222.out
>> new file mode 100644
>> index 0000000000..be925601a8
>> --- /dev/null
>> +++ b/tests/qemu-iotests/222.out
>> @@ -0,0 +1,66 @@
>> +--- Setting up images ---
>> +
>> +Done
>> +
>> +--- Launching VM ---
>> +
>> +Done
>> +
>> +--- Setting up Fleecing Graph ---
>> +
>> +{u'return': {}}
>> +{u'return': {}}
>> +
>> +--- Setting up NBD Export ---
>> +
>> +{u'return': {}}
>> +{u'return': {}}
>> +
>> +--- Sanity Check ---
>> +
>> +read -P0x5d 0 64k
>> +read -P0xd5 1M 64k
>> +read -P0xdc 32M 64k
>> +read -P0xcd 0x3ff0000 64k
>> +read -P0 0x00f8000 32k
>> +read -P0 0x2010000 32k
>> +read -P0 0x3fe0000 64k
>> +
>> +--- Testing COW ---
>> +
>> +write -P0xab 0 64k
>> +{u'return': u''}
>> +write -P0xad 0x00f8000 64k
>> +{u'return': u''}
>> +write -P0x1d 0x2008000 64k
>> +{u'return': u''}
>> +write -P0xea 0x3fe0000 64k
>> +{u'return': u''}
>> +
>> +--- Verifying Data ---
>> +
>> +read -P0x5d 0 64k
>> +read -P0xd5 1M 64k
>> +read -P0xdc 32M 64k
>> +read -P0xcd 0x3ff0000 64k
>> +read -P0 0x00f8000 32k
>> +read -P0 0x2010000 32k
>> +read -P0 0x3fe0000 64k
>> +
>> +--- Cleanup ---
>> +
>> +{u'return': {}}
>> +{u'return': {}}
>> +{u'return': {}}
>> +
>> +--- Confirming writes ---
>> +
>> +read -P0xab 0 64k
>> +read -P0xad 0x00f8000 64k
>> +read -P0x1d 0x2008000 64k
>> +read -P0xea 0x3fe0000 64k
>> +read -P0xd5 0x108000 32k
>> +read -P0xdc 32M 32k
>> +read -P0xcd 0x3ff0000 64k
>> +
>> +Done
>> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
>> index eea75819d2..8019a9f721 100644
>> --- a/tests/qemu-iotests/group
>> +++ b/tests/qemu-iotests/group
>> @@ -220,3 +220,4 @@
>> =C2=A0 218 rw auto quick
>> =C2=A0 219 rw auto
>> =C2=A0 221 rw auto quick
>> +222 rw auto quick
>=20
>=20

Thanks for the review ... I'll try to make sure some sort of fleecing
workflow patches go in for 3.0. I was hoping your patches wouldn't be
necessary but I think you're making a good argument that they are :(

--js
