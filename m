Received: from eggs.gnu.org ([2001:4830:134:3::10]:42507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9c9C-0003Z8-RO
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:29:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9bzK-0000bu-JC
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:18:47 -0400
References: <20181005234023.8104-1-mreitz@redhat.com>
	<20181005234023.8104-8-mreitz@redhat.com>
	<d3f8da86-f071-1ce0-462a-0b378f5214a9@redhat.com>
	<de892465-6f19-defc-c726-6e1bcf2ccbba@redhat.com>
	<54cf31da-009e-c1b7-49f9-7bd5596d2142@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a7362a73-5a24-8152-cf67-6a761f697616@redhat.com>
Date: Mon, 8 Oct 2018 22:18:35 +0200
MIME-Version: 1.0
In-Reply-To: <54cf31da-009e-c1b7-49f9-7bd5596d2142@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="U0HMT7UNkbVdVxz8ulkzUuPLpqqrwbY96"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v11 07/31] iotests.py: Add
 node_info()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--U0HMT7UNkbVdVxz8ulkzUuPLpqqrwbY96
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <a7362a73-5a24-8152-cf67-6a761f697616@redhat.com>
Subject: Re: [Qemu-block] [PATCH v11 07/31] iotests.py: Add node_info()
References: <20181005234023.8104-1-mreitz@redhat.com>
 <20181005234023.8104-8-mreitz@redhat.com>
 <d3f8da86-f071-1ce0-462a-0b378f5214a9@redhat.com>
 <de892465-6f19-defc-c726-6e1bcf2ccbba@redhat.com>
 <54cf31da-009e-c1b7-49f9-7bd5596d2142@redhat.com>
In-Reply-To: <54cf31da-009e-c1b7-49f9-7bd5596d2142@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.10.18 21:59, John Snow wrote:
>=20
>=20
> On 10/08/2018 03:57 PM, Max Reitz wrote:
>> On 08.10.18 21:34, John Snow wrote:
>>>
>>>
>>> On 10/05/2018 07:39 PM, Max Reitz wrote:
>>>> This function queries a node; since we cannot do that right now, it
>>>> executes query-named-block-nodes and returns the matching node's obj=
ect.
>>>>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>>  tests/qemu-iotests/iotests.py | 7 +++++++
>>>>  1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iote=
sts.py
>>>> index 5c45788dac..604f200600 100644
>>>> --- a/tests/qemu-iotests/iotests.py
>>>> +++ b/tests/qemu-iotests/iotests.py
>>>> @@ -465,6 +465,13 @@ class VM(qtest.QEMUQtestMachine):
>>>>                  else:
>>>>                      iotests.log(ev)
>>>> =20
>>>> +    def node_info(self, node_name):
>>>> +        nodes =3D self.qmp('query-named-block-nodes')
>>>> +        for x in nodes['return']:
>>>> +            if x['node-name'] =3D=3D node_name:
>>>> +                return x
>>>> +        return None
>>>> +
>>>> =20
>>>>  index_re =3D re.compile(r'([^\[]+)\[([^\]]+)\]')
>>>> =20
>>>>
>>>
>>> Reviewed-by: John Snow <jsnow@redhat.com>
>>>
>>> Do we ever want to revisit the idea that our API should not do any
>>> pre-filtering and that it's always up to the client to do so?
>>
>> I mean we certainly want to revisit the idea that we should have a
>> proper query API.
>>
>> But what exactly do you mean by pre-filtering?
>>
>> Max
>>
>=20
> i.e. applying selection criteria before responding to the query. e.g.,
> by looking for matches on node-name.
>=20
> (Did I use i.e. and e.g. right?)

So you mean our API should do pre-filtering at the request of the client
and the client shouldn't be fed all nodes and then have to do
post-filtering?

Well, I certainly think we want a query command that doesn't return all
nodes.  I personally would prefer something that only returns a single
node in the graph and its relationships, although I'm not sure whether
that is very efficient.  Maybe something like inverse blockdev-add, were
the user can specify a depth on how deep references should be expanded.

Overall, I'm of the impression we want to have blockdev-reopen first so
that we have a good idea of the type of information we want to report
for a node; that being its node options, first and foremost.  Probably
some stats as well, though.

Max


(The i.e. looks weird because you're not expanding a thought you've just
given, but you're actually responding to my question.  It's like saying
"I want feature A." -- "We can do that, do you have any other remarks?"
-- "And I want B, too."  So I would have started either with "e.g." (if
you think there are other things that could be meant by pre-filtering),
or by e.g. "I thought of".  Probably the latter, since that is how I
interpreted your "i.e.".)

((Did I use the semicolon correctly?))


--U0HMT7UNkbVdVxz8ulkzUuPLpqqrwbY96
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlu7u5sACgkQ9AfbAGHV
z0CU7Qf9H7Yj4JkLSlombkzhr/yYRxuM6D7ZvVh3+L0TKgxzwYqtx85ocHQWpLrt
j6aUJAkG7aJhWtli600IA3aFlMIa23LBPenRAcudjr/EFdwAAyFz9+r3xW9VIkQR
E7tkoz+QFfhSYg5tONfR7ckD80gGx6cRQpp44/ktWVZM3RqufOjOg+9VpjHk+0XG
LNnaStIinRKGOI7Y5UaRYN5dAFS2aoyj1BxrnLhRDmuDa5BxJiQC1wsUUwk+2o5R
hyjZTZpfmqIvxyA2oDNljux8elWHyRJa9CQ8/OkA+VJb5jsVi+wxokCX+lKxqKn6
cIvJ5ExCyuihP8S1bEQA6nm3MYExaw==
=KMFO
-----END PGP SIGNATURE-----

--U0HMT7UNkbVdVxz8ulkzUuPLpqqrwbY96--
