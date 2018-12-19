Received: from eggs.gnu.org ([2001:4830:134:3::10]:41149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZh2B-0003in-4U
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:57:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZh2A-0002KG-5n
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:57:31 -0500
References: <20181219015230.18652-1-jsnow@redhat.com>
	<20181219015230.18652-2-jsnow@redhat.com>
	<b92a888e-1223-2966-ae83-b0f014171129@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <e7aca710-fb9b-9c32-a37d-8122a4c5d913@redhat.com>
Date: Wed, 19 Dec 2018 13:57:20 -0500
MIME-Version: 1.0
In-Reply-To: <b92a888e-1223-2966-ae83-b0f014171129@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 1/5] iotests: add qmp recursive sorting
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>



On 12/19/18 1:52 PM, Eric Blake wrote:
> On 12/18/18 7:52 PM, John Snow wrote:
>> Python before 3.6 does not sort kwargs by default.
>> If we want to print out pretty-printed QMP objects while
>> preserving the "exec" > "arguments" ordering, we need a custom sort.
>=20
> Naive question - why do we need the sorting? Is it so that the output i=
s
> deterministic?=C2=A0 Surely it can't be because the ordering otherwise =
makes
> a difference to execution.
>=20

Yeah, it's because dicts are unordered and prior to 3.6 they may shuffle
around arbitrarily based on internal hashes.

kwargs in particular are unordered- the order we send over the wire may
or may not reflect the order the test author wrote in their iotest.

Therefore, it's a way to get consistent ordering.

Now, we CAN just rely on sort_keys=3DTrue to be done with it, however,
this puts arguments before execute, and it's less nice to read -- and
I'd have to change a LOT of test output.

This way keeps the order you expect to see while maintaining a strict
order for the arguments. I think that's the nicest compromise until we
can stipulate 3.6+ in the year 2034 where kwargs *are* strictly ordered.

> Here's my review from a non-Python export viewpoint:
>=20
>>
>> We can accomplish this by sorting **kwargs into an OrderedDict,
>> which does preserve addition order.
>> ---
>> =C2=A0 tests/qemu-iotests/iotests.py | 21 +++++++++++++++++----
>> =C2=A0 1 file changed, 17 insertions(+), 4 deletions(-)
>>
>=20
>> @@ -448,8 +460,9 @@ class VM(qtest.QEMUQtestMachine):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return result
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def qmp_log(self, cmd, filters=3D=
[filter_testfiles], **kwargs):
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 logmsg =3D '{"execute": "%=
s", "arguments": %s}' % \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (c=
md, json.dumps(kwargs, sort_keys=3DTrue))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 full_cmd =3D OrderedDict({=
"execute": cmd,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "arguments": ordered_kwargs(kw=
args)})
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 logmsg =3D json.dumps(full=
_cmd)
>=20
> Vladimir knows Python better than me, but once you fix this OrderedDict
> construction up to actually work, the patch looks reasonable to me.
>=20

Yeah, it only worked by accident of implementation details :(
I've patched it up locally.

--js
