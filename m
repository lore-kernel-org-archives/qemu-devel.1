Received: from eggs.gnu.org ([2001:4830:134:3::10]:46021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZhNI-0002Wl-0R
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:19:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZhNG-0001HB-Cu
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:19:19 -0500
References: <20181219015230.18652-1-jsnow@redhat.com>
	<20181219015230.18652-2-jsnow@redhat.com>
	<b92a888e-1223-2966-ae83-b0f014171129@redhat.com>
	<e7aca710-fb9b-9c32-a37d-8122a4c5d913@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c1742689-f3f0-b464-8b8a-13ad77016e0f@redhat.com>
Date: Wed, 19 Dec 2018 13:19:04 -0600
MIME-Version: 1.0
In-Reply-To: <e7aca710-fb9b-9c32-a37d-8122a4c5d913@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 12/19/18 12:57 PM, John Snow wrote:
>=20
>=20
> On 12/19/18 1:52 PM, Eric Blake wrote:
>> On 12/18/18 7:52 PM, John Snow wrote:
>>> Python before 3.6 does not sort kwargs by default.
>>> If we want to print out pretty-printed QMP objects while
>>> preserving the "exec" > "arguments" ordering, we need a custom sort.
>>
>> Naive question - why do we need the sorting? Is it so that the output =
is
>> deterministic?=C2=A0 Surely it can't be because the ordering otherwise=
 makes
>> a difference to execution.
>>
>=20
> Yeah, it's because dicts are unordered and prior to 3.6 they may shuffl=
e
> around arbitrarily based on internal hashes.
>=20
> kwargs in particular are unordered- the order we send over the wire may
> or may not reflect the order the test author wrote in their iotest.

Which shouldn't matter to what QMP executes, but MIGHT matter in getting=20
reproducible log output.

>=20
> Therefore, it's a way to get consistent ordering.
>=20
> Now, we CAN just rely on sort_keys=3DTrue to be done with it, however,
> this puts arguments before execute, and it's less nice to read -- and
> I'd have to change a LOT of test output.

Okay, I'm finally seeing it; the existing code has:

     def qmp_log(self, cmd, filters=3D[filter_testfiles], **kwargs):
         logmsg =3D '{"execute": "%s", "arguments": %s}' % \
             (cmd, json.dumps(kwargs, sort_keys=3DTrue))

where our log is outputting a message that resembles a dict where=20
"execute": is the first key, and the user's input dict is then sorted=20
(the top-most output of {} is unsorted, but the nested ones are sorted,=20
and possibly in a different order than the user typed them, but at least=20
deterministic). But when you change to the user passing a full QMP=20
command (rather than just a dict for the arguments of the QMP command),=20
using sort_keys=3DTrue will sort everything _including_ putting=20
"arguments" before "execute" (which is deterministic but changes log=20
output); while using sort_keys=3DFalse will not affect output in newer=20
python where kwargs remains ordered, but risks nondeterministic output=20
on older python.

>=20
> This way keeps the order you expect to see while maintaining a strict
> order for the arguments. I think that's the nicest compromise until we
> can stipulate 3.6+ in the year 2034 where kwargs *are* strictly ordered=
.

But kwargs strict ordering is only at the top-level, not recursive,=20
right? That is, even if you can rely on:

foo(b=3D1, a=3D2)

providing kwargs where 'b' always outputs before 'a', I don't see how=20
that would help:

foo(b=3D{'d':3, 'c':4})

not reorder the keys within 'b' without your recursive ordering.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
