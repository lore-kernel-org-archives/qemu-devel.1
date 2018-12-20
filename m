Received: from eggs.gnu.org ([2001:4830:134:3::10]:33313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZnez-00077X-QW
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 21:02:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZnex-0001rQ-Pw
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 21:02:01 -0500
References: <20181219015230.18652-1-jsnow@redhat.com>
	<20181219015230.18652-6-jsnow@redhat.com>
	<bdcee774-5139-894e-634b-924728accb6f@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <6ed0ffb2-b7b7-10e1-eed4-9f521515bfc8@redhat.com>
Date: Wed, 19 Dec 2018 21:01:46 -0500
MIME-Version: 1.0
In-Reply-To: <bdcee774-5139-894e-634b-924728accb6f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 5/5] iotests: add iotest 236 for testing
 bitmap merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>



On 12/19/18 2:34 PM, Eric Blake wrote:
> On 12/18/18 7:52 PM, John Snow wrote:
>> New interface, new smoke test.
>> ---
>> =C2=A0 tests/qemu-iotests/236=C2=A0=C2=A0=C2=A0=C2=A0 | 131 ++++++++++=
++++++++++++++
>> =C2=A0 tests/qemu-iotests/236.out | 198 ++++++++++++++++++++++++++++++=
+++++++
>> =C2=A0 tests/qemu-iotests/group=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 3 files changed, 330 insertions(+)
>> =C2=A0 create mode 100755 tests/qemu-iotests/236
>> =C2=A0 create mode 100644 tests/qemu-iotests/236.out
>>
>=20
>> +
>> +=C2=A0=C2=A0=C2=A0 log('')
>> +=C2=A0=C2=A0=C2=A0 log('--- Disabling B & Adding C ---\n')
>> +=C2=A0=C2=A0=C2=A0 vm.qmp_log("transaction", indent=3D2, actions=3D[
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "type": "block-dirty-bit=
map-disable",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "data": { "nod=
e": "drive0", "name": "bitmapB" }},
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "type": "block-dirty-bit=
map-add",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "data": { "nod=
e": "drive0", "name": "bitmapC",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "granularity": granularity =
}},
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Purely extraneous, but t=
est that it works:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "type": "block-dirty-bit=
map-disable",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "data": { "nod=
e": "drive0", "name": "bitmapC" }},
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "type": "block-dirty-bit=
map-enable",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "data": { "nod=
e": "drive0", "name": "bitmapC" }},
>> +=C2=A0=C2=A0=C2=A0 ])
>=20
> One other possible addition just before this point:
>=20
> qmp_log("transaction", indent=3D2, actions=3D[
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "type": "block-dirty-bitma=
p-disable",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "data": { "node"=
: "drive0", "name": "bitmapB" }},
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "type": "block-dirty-bitma=
p-add",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "data": { "node"=
: "drive0", "name": "bitmapC",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "granularity": granularity }},
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "type": "block-dirty-bitma=
p-remove",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "data": { "node"=
: "drive0", "name": "bitmapA" }},
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "type": "abort", "data": {=
}}
> =C2=A0 ])
>=20
> to check that we properly undo things on an aborted transaction (B
> should still be enabled, C should not exist, and A should not be damage=
d).
>=20

Good suggestion, but remove is not a transaction item. I'll substitute
for clear, which should showcase the same effects.

>> +=C2=A0=C2=A0=C2=A0 # A and D should be equivalent>> +=C2=A0=C2=A0=C2=A0=
 # Some formats round the size of the disk, so don't print the
>> checksums.
>> +=C2=A0=C2=A0=C2=A0 check_a =3D vm.qmp('x-debug-block-dirty-bitmap-sha=
256',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node=3D"drive0", name=
=3D"bitmapA")['return']['sha256']
>> +=C2=A0=C2=A0=C2=A0 check_b =3D vm.qmp('x-debug-block-dirty-bitmap-sha=
256',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node=3D"drive0", name=
=3D"bitmapD")['return']['sha256']
>> +=C2=A0=C2=A0=C2=A0 assert(check_a =3D=3D check_b)
>=20
> Image agnostic also means that you avoid an 32- vs. 64-bit platform
> discrepancies (we've had issues in the past where the sum is different
> for some image sizes, because the bitmap is always in terms of 'long's,
> but there is one less 'long' in a 32-bit bitmap for the disk size).
> Makes sense.
>=20
> Also, I don't see any tests of block-dirty-bitmap-remove - this would b=
e
> a good point in the test to insert a final cleanup.
>=20

OK, done.

>=20
>> +++ b/tests/qemu-iotests/group
>> @@ -233,3 +233,4 @@
>> =C2=A0 233 auto quick
>> =C2=A0 234 auto quick migration
>> =C2=A0 235 auto quick
>> +236 auto quick
>> \ No newline at end of file
>=20
> Umm - what's that still doing here?
>=20
>=20
:whistles:
