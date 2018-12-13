Received: from eggs.gnu.org ([2001:4830:134:3::10]:49088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXVjS-00051r-VC
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:29:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXVjS-00050c-4m
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:29:10 -0500
References: <20181213015013.15350-1-jsnow@redhat.com>
	<20181213015013.15350-8-jsnow@redhat.com>
	<9c7b8bbe-6f63-ed65-61c4-dbbae5f07d07@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <59792dbe-cc5f-f351-6074-153c4e0f3feb@redhat.com>
Date: Thu, 13 Dec 2018 13:28:56 -0500
MIME-Version: 1.0
In-Reply-To: <9c7b8bbe-6f63-ed65-61c4-dbbae5f07d07@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 7/7] iotests: add iotest 236 for testing
 bitmap merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>



On 12/12/18 9:27 PM, Eric Blake wrote:
> On 12/12/18 7:50 PM, John Snow wrote:
>> New interface, new smoke test.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>> =C2=A0 tests/qemu-iotests/236=C2=A0=C2=A0=C2=A0=C2=A0 | 123 ++++++++++=
+++++++
>> =C2=A0 tests/qemu-iotests/236.out | 265 ++++++++++++++++++++++++++++++=
+++++++
>> =C2=A0 tests/qemu-iotests/group=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 3 files changed, 389 insertions(+)
>> =C2=A0 create mode 100755 tests/qemu-iotests/236
>> =C2=A0 create mode 100644 tests/qemu-iotests/236.out
>>
>> diff --git a/tests/qemu-iotests/236 b/tests/qemu-iotests/236
>=20
>> +=C2=A0=C2=A0=C2=A0 log('')
>> +=C2=A0=C2=A0=C2=A0 log('--- Disabling B & Adding C ---\n')
>> +=C2=A0=C2=A0=C2=A0 vm.qmp_log("transaction", actions=3D[
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "type": "block-dirty-bit=
map-disable",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "data": { "nod=
e": "drive0", "name": "bitmapB" }},
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "type": "block-dirty-bit=
map-add",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "data": { "nod=
e": "drive0", "name": "bitmapC" }}
>> +=C2=A0=C2=A0=C2=A0 ])
>=20
> Just for grins, what happens if we extend that transaction to
> additionally call:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "type": "block-dirty-bitmap-disa=
ble",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "data": { "node": "dri=
ve0", "name": "bitmapC" }},
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "type": "block-dirty-bitmap-enab=
le",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "data": { "node": "dri=
ve0", "name": "bitmapC" }}
>=20
> Yes, we have a redundancy where plain '-add' coupled with '-disable' in
> a transaction does the same as '-add' with 'enabled':false.=C2=A0 And I=
'd
> rather keep 'enabled':false as part of '-add', as it's handy to do that
> without having to code up a transaction.=C2=A0 But the specific act of
> toggling the enabled bit twice on a brand new bitmap as part of the sam=
e
> transaction, while unlikely to be done by libvirt, may still prove to b=
e
> a useful validation of our transaction semantics.
>=20
>> +++ b/tests/qemu-iotests/group
>> @@ -233,3 +233,4 @@
>> =C2=A0 233 auto quick
>> =C2=A0 234 auto quick migration
>> =C2=A0 235 auto quick
>> +236 auto quick
>> \ No newline at end of file
>=20
> You'll want to fix that.
>=20

Now that you've pointed it out, I have to. :)

> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

OK. I want more tests, too; mostly around malformed requests (bad
target, single bad source, multiple bad sources, mixed bad sources).
your suggestion to merge self into self,
and maybe anything else I've forgotten by now.

--js
