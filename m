Received: from eggs.gnu.org ([2001:4830:134:3::10]:53981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZhos-00079E-4c
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:47:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZhor-0006jg-23
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:47:50 -0500
References: <20181219015230.18652-1-jsnow@redhat.com>
	<20181219015230.18652-2-jsnow@redhat.com>
	<b92a888e-1223-2966-ae83-b0f014171129@redhat.com>
	<e7aca710-fb9b-9c32-a37d-8122a4c5d913@redhat.com>
	<c1742689-f3f0-b464-8b8a-13ad77016e0f@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <4f58832c-ef2b-9fca-656d-65ca9c2a49bc@redhat.com>
Date: Wed, 19 Dec 2018 14:47:40 -0500
MIME-Version: 1.0
In-Reply-To: <c1742689-f3f0-b464-8b8a-13ad77016e0f@redhat.com>
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



On 12/19/18 2:19 PM, Eric Blake wrote:
> On 12/19/18 12:57 PM, John Snow wrote:
>>
>>
>> On 12/19/18 1:52 PM, Eric Blake wrote:
>>> On 12/18/18 7:52 PM, John Snow wrote:
>>>> Python before 3.6 does not sort kwargs by default.
>>>> If we want to print out pretty-printed QMP objects while
>>>> preserving the "exec" > "arguments" ordering, we need a custom sort.
>>>
>>> Naive question - why do we need the sorting? Is it so that the output=
 is
>>> deterministic?=C2=A0 Surely it can't be because the ordering otherwis=
e makes
>>> a difference to execution.
>>>
>>
>> Yeah, it's because dicts are unordered and prior to 3.6 they may shuff=
le
>> around arbitrarily based on internal hashes.
>>
>> kwargs in particular are unordered- the order we send over the wire ma=
y
>> or may not reflect the order the test author wrote in their iotest.
>=20
> Which shouldn't matter to what QMP executes, but MIGHT matter in gettin=
g
> reproducible log output.
>=20
>>
>> Therefore, it's a way to get consistent ordering.
>>
>> Now, we CAN just rely on sort_keys=3DTrue to be done with it, however,
>> this puts arguments before execute, and it's less nice to read -- and
>> I'd have to change a LOT of test output.
>=20
> Okay, I'm finally seeing it; the existing code has:
>=20
> =C2=A0=C2=A0=C2=A0 def qmp_log(self, cmd, filters=3D[filter_testfiles],=
 **kwargs):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 logmsg =3D '{"execute": "%s"=
, "arguments": %s}' % \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (cmd=
, json.dumps(kwargs, sort_keys=3DTrue))
>=20
> where our log is outputting a message that resembles a dict where
> "execute": is the first key, and the user's input dict is then sorted
> (the top-most output of {} is unsorted, but the nested ones are sorted,
> and possibly in a different order than the user typed them, but at leas=
t
> deterministic). But when you change to the user passing a full QMP
> command (rather than just a dict for the arguments of the QMP command),
> using sort_keys=3DTrue will sort everything _including_ putting
> "arguments" before "execute" (which is deterministic but changes log
> output); while using sort_keys=3DFalse will not affect output in newer
> python where kwargs remains ordered, but risks nondeterministic output
> on older python.
>=20

Yes, and pretty-printing requires the full object, otherwise it's too
hard to manually re-indent the buffered subdict, and you have to indent
the outer dict, and...

...

It's easier to just build the full dictionary and then pretty-print it.

The motivation here is that pretty-printing a call to qmp_log should
indent both outgoing and incoming because that's semantically the most
obvious and right thing to do. Principle of least surprise.

>>
>> This way keeps the order you expect to see while maintaining a strict
>> order for the arguments. I think that's the nicest compromise until we
>> can stipulate 3.6+ in the year 2034 where kwargs *are* strictly ordere=
d.
>=20
> But kwargs strict ordering is only at the top-level, not recursive,
> right? That is, even if you can rely on:
>=20
> foo(b=3D1, a=3D2)
>=20
> providing kwargs where 'b' always outputs before 'a', I don't see how
> that would help:
>=20
> foo(b=3D{'d':3, 'c':4})
>=20
> not reorder the keys within 'b' without your recursive ordering.
>=20

Well, kwargs *are* dictionaries, and both become sorted in 3.6. You can
rely on the ordering at any level, but only in 3.6 and after.

We cannot rely on that behavior, though, so in our current reality:

(1) kwargs can be arbitrarily reordered
(2) subdictionaries in kwargs can also be arbitrarily reordered

And so my ordered_kwargs() function recursively orders any dictionaries
it finds, assuming a typical JSON structure -- which will suffice for
QMP objects.

In practice, it appears to correctly re-implement the behavior of
json.dumps(..., sort_keys=3DTrue).

--js
