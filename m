Received: from eggs.gnu.org ([2001:4830:134:3::10]:44409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fYbgw-0007lR-OZ
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 14:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fYbgv-00010o-Na
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 14:30:50 -0400
References: <20180628180042.3881-1-jsnow@redhat.com>
	<20180628180042.3881-3-jsnow@redhat.com>
	<8a183b22-b934-13b9-f5ab-2d0c6bfbad77@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <6c50a742-2b98-6b16-3d8b-ab483500ce54@redhat.com>
Date: Thu, 28 Jun 2018 14:30:43 -0400
MIME-Version: 1.0
In-Reply-To: <8a183b22-b934-13b9-f5ab-2d0c6bfbad77@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] iotests: add 222 to test basic
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
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>



On 06/28/2018 02:17 PM, Eric Blake wrote:
> On 06/28/2018 01:00 PM, John Snow wrote:
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>> =C2=A0 tests/qemu-iotests/222=C2=A0=C2=A0=C2=A0=C2=A0 | 149
>> +++++++++++++++++++++++++++++++++++++++++++++
>> =C2=A0 tests/qemu-iotests/222.out |=C2=A0 60 ++++++++++++++++++
>> =C2=A0 tests/qemu-iotests/group=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 3 files changed, 210 insertions(+)
>> =C2=A0 create mode 100644 tests/qemu-iotests/222
>> =C2=A0 create mode 100644 tests/qemu-iotests/222.out
>>
>=20
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
>> +remainder =3D [("0xd5", "0x108000",=C2=A0 "32K"), # Right-end of
>> partial-left [1]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ("0xdc", "32M",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "32k"), # Left-en=
d of
>> partial-right [2]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ("0xcd", "0x3ff0000", "64k")] # patterns[3]
>=20
> What if you also add:
>=20
> zeroes =3D=C2=A0 [("0x00", "0x108000",=C2=A0 "32K"), # Right-end of par=
tial-left [1]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ("0x00", "=
32M",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "32k"), # Left-end of partial-r=
ight [2]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ("0x00", "=
0x3ff0000", "64k")] # patterns[3]
>=20
> then...
>=20
>> +=C2=A0=C2=A0=C2=A0 log('')
>> +=C2=A0=C2=A0=C2=A0 log('--- Sanity Check ---')
>> +=C2=A0=C2=A0=C2=A0 log('')
>> +
>> +=C2=A0=C2=A0=C2=A0 for p in patterns:
>=20
> for p in (patterns + zeroes)
>=20
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
>> +=C2=A0=C2=A0=C2=A0 for p in patterns:
>=20
> for p in (patterns + zeroes)
>=20
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
>> +=C2=A0=C2=A0=C2=A0 #log(vm.hmp_qemu_io(srcNode, 'flush'))
>> +=C2=A0=C2=A0=C2=A0 log(vm.qmp('block-job-cancel', device=3DsrcNode))
>> +=C2=A0=C2=A0=C2=A0 log(vm.qmp('nbd-server-stop'))
>> +=C2=A0=C2=A0=C2=A0 log(vm.qmp('blockdev-del', node_name=3DtgtNode))
>> +=C2=A0=C2=A0=C2=A0 vm.shutdown()
>> +
>> +=C2=A0=C2=A0=C2=A0 log('')
>> +=C2=A0=C2=A0=C2=A0 log('--- Confirming writes ---')
>> +=C2=A0=C2=A0=C2=A0 log('')
>> +
>> +=C2=A0=C2=A0=C2=A0 for p in (overwrite + remainder):
>=20
> so that reads of both the fleeced point in time and of the final image
> cover the same set of byte ranges.
>=20

Sure, why not.

--js
