Received: from eggs.gnu.org ([2001:4830:134:3::10]:48544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXVgz-0003s7-GF
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:26:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXVgy-00028X-Gu
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:26:37 -0500
References: <20181213015013.15350-1-jsnow@redhat.com>
	<20181213015013.15350-7-jsnow@redhat.com>
	<dda19b8f-1320-7bd5-cc29-c113b0a590e8@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <371f152c-2299-aeb9-9999-de73a3a0d5a7@redhat.com>
Date: Thu, 13 Dec 2018 13:26:27 -0500
MIME-Version: 1.0
In-Reply-To: <dda19b8f-1320-7bd5-cc29-c113b0a590e8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 6/7] iotests: allow pretty-print for
 qmp_log
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



On 12/12/18 9:20 PM, Eric Blake wrote:
> On 12/12/18 7:50 PM, John Snow wrote:
>> If iotests have lines exceeding >998 characters long, git doesn't
>> want to send it plaintext to the list. We can solve this by allowing
>> the iotests to use pretty printed QMP output that we can match against
>> instead.
>>
>> As a bonus, it's much nicer for human eyes, too.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>> =C2=A0 tests/qemu-iotests/iotests.py | 4 ++--
>> =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/iotests.py
>> b/tests/qemu-iotests/iotests.py
>> index 9595429fea..dbbef4bad3 100644
>> --- a/tests/qemu-iotests/iotests.py
>> +++ b/tests/qemu-iotests/iotests.py
>> @@ -447,12 +447,12 @@ class VM(qtest.QEMUQtestMachine):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 result.append(filter_qmp_event(ev))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return result
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 def qmp_log(self, cmd, filters=3D[filter_te=
stfiles], **kwargs):
>> +=C2=A0=C2=A0=C2=A0 def qmp_log(self, cmd, indent=3DNone, filters=3D[f=
ilter_testfiles],
>> **kwargs):
>=20
> Why None instead of False?
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 logmsg =3D '{"e=
xecute": "%s", "arguments": %s}' % \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (cmd, json.dumps(kwargs, sort_keys=3DTrue))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log(logmsg, fil=
ters)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D self=
.qmp(cmd, **kwargs)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log(json.dumps(result, sor=
t_keys=3DTrue), filters)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log(json.dumps(result, ind=
ent=3Dindent, sort_keys=3DTrue), filters)
>=20
> But I'd actually have to read the contract to json.dumps() to learn wha=
t
> is expected.
>=20
> /me goes and does that...
> https://docs.python.org/2/library/json.html
>=20
> If indent is a non-negative integer, then JSON array elements and objec=
t
> members will be pretty-printed with that indent level. An indent level
> of 0, or negative, will only insert newlines. None (the default) select=
s
> the most compact representation.
>=20
> Okay, makes sense.
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

Yeah, it's a bubbling up of API in this case and a little messy, but it
was the quickest route to making the output look pretty.
