Received: from eggs.gnu.org ([2001:4830:134:3::10]:34387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqOzH-000866-RX
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 15:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqOzE-0006R9-NV
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 15:03:03 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35000 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eqOzE-0006Q9-IR
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 15:03:00 -0500
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-9-armbru@redhat.com>
	<a095759a-0b4b-125d-a178-3456e3651c42@redhat.com>
	<87eflblj0l.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f8d4c697-4306-a325-d760-6965317794a0@redhat.com>
Date: Mon, 26 Feb 2018 14:02:43 -0600
MIME-Version: 1.0
In-Reply-To: <87eflblj0l.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 08/29] qapi-gen: New common driver for
 code and doc generators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

On 02/23/2018 11:20 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> On 02/11/2018 03:35 AM, Markus Armbruster wrote:
>>> Whenever qapi-schema.json changes, we run six programs eleven times t=
o
>>> update eleven files.  Similar for qga/qapi-schema.json.  This is
>>> silly.  Replace the six programs by a single program that spits out
>>> all eleven files.
>>>
>>> The programs become modules in new Python package qapi, along with th=
e
>>> helper library.  This requires moving them to scripts/qapi/.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> ---

>>> +++ b/docs/devel/qapi-code-gen.txt

>>>    @@ -1302,23 +1296,22 @@ Example:
>>>        }
>>>          const char *const example_QAPIEvent_lookup[] =3D {
>>> -        [EXAMPLE_QAPI_EVENT_MY_EVENT] =3D "MY_EVENT",
>>> +
>>> +[EXAMPLE_QAPI_EVENT_MY_EVENT] =3D "MY_EVENT",
>>>            [EXAMPLE_QAPI_EVENT__MAX] =3D NULL,
>>>        };
>>
>> Looks like our generated code indentation has slightly regressed from
>> what we would write by hand, but it's still okay for generated code
>> (and the commit message in 5/29 did call that out)
>=20
> I'd prefer to have this tidied up.

Actually, we currently output with good indentation, but with different=20
text altogether:

const QEnumLookup example_QAPIEvent_lookup =3D {
     .array =3D (const char *const[]) {
         [EXAMPLE_QAPI_EVENT_MY_EVENT] =3D "MY_EVENT",
     },
     .size =3D EXAMPLE_QAPI_EVENT__MAX
};

I'm fixing that up as part of prepping this series for PULL.


>>> +def gen_commands(schema, output_dir, prefix):
>>> +    blurb =3D ' * Schema-defined QAPI/QMP commands'
>>
>> We discussed whether to make the assignment to blurb be a one-liner in
>> an earlier patch, but I'm also fine with the churn you have over the
>> course of the series.
>=20
> I ran out of time, and decided to leave this one as is.

It wasn't too difficult (although the ripple effects hit 3 other=20
patches), so I did this as well.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
