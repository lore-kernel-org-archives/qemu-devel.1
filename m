Received: from eggs.gnu.org ([2001:4830:134:3::10]:52109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWO3p-0001o3-QQ
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:05:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWO3l-0004cp-QZ
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:05:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gWO3f-0004Xa-1x
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:05:27 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
	<20181208111606.8505-9-marcandre.lureau@redhat.com>
	<87h8flfktf.fsf@dusky.pond.sub.org>
Date: Mon, 10 Dec 2018 17:05:10 +0100
In-Reply-To: <87h8flfktf.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Mon, 10 Dec 2018 16:44:28 +0100")
Message-ID: <87woohxt8p.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v7 08/27] qapi: add a dictionary
 form with 'name' key for enum members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

One more thing...

Markus Armbruster <armbru@redhat.com> writes:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> Desugar the enum NAME form to { 'name': NAME }. This will allow to add
>> new enum members, such as 'if' in the following patch.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  scripts/qapi/common.py                        | 49 ++++++++++++++++---
>>  tests/Makefile.include                        |  3 +-
>>  tests/qapi-schema/enum-bad-member.err         |  1 +
>>  ...-dict-member.exit =3D> enum-bad-member.exit} |  0
>>  tests/qapi-schema/enum-bad-member.json        |  2 +
>>  ...um-dict-member.out =3D> enum-bad-member.out} |  0
>>  .../qapi-schema/enum-dict-member-unknown.err  |  2 +
>>  .../qapi-schema/enum-dict-member-unknown.exit |  1 +
>>  .../qapi-schema/enum-dict-member-unknown.json |  2 +
>>  .../qapi-schema/enum-dict-member-unknown.out  |  0
>>  tests/qapi-schema/enum-dict-member.err        |  1 -
>>  tests/qapi-schema/enum-dict-member.json       |  2 -
>>  12 files changed, 52 insertions(+), 11 deletions(-)
>>  create mode 100644 tests/qapi-schema/enum-bad-member.err
>>  rename tests/qapi-schema/{enum-dict-member.exit =3D> enum-bad-member.ex=
it} (100%)
>>  create mode 100644 tests/qapi-schema/enum-bad-member.json
>>  rename tests/qapi-schema/{enum-dict-member.out =3D> enum-bad-member.out=
} (100%)
>>  create mode 100644 tests/qapi-schema/enum-dict-member-unknown.err
>>  create mode 100644 tests/qapi-schema/enum-dict-member-unknown.exit
>>  create mode 100644 tests/qapi-schema/enum-dict-member-unknown.json
>>  create mode 100644 tests/qapi-schema/enum-dict-member-unknown.out
>>  delete mode 100644 tests/qapi-schema/enum-dict-member.err
>>  delete mode 100644 tests/qapi-schema/enum-dict-member.json
>>
>> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
[...]
>> @@ -847,18 +851,32 @@ def check_alternate(expr, info):
>>              types_seen[qt] =3D key
>>=20=20
>>=20=20
>> +def normalize_enum(expr):
>> +    members =3D expr['data']
>> +
>> +    # translate short member form to dict form
>> +    expr['data'] =3D [m if isinstance(m, dict) else {'name': m} for m i=
n members]
>> +
>> +
>>  def check_enum(expr, info):
>>      name =3D expr['enum']
>> -    members =3D expr.get('data')
>> +    members =3D expr['data']
>>      prefix =3D expr.get('prefix')
>>=20=20
>> -    if not isinstance(members, list):
>> -        raise QAPISemError(info,
>> -                           "Enum '%s' requires an array for 'data'" % n=
ame)
>>      if prefix is not None and not isinstance(prefix, str):
>>          raise QAPISemError(info,
>>                             "Enum '%s' requires a string for 'prefix'" %=
 name)
>> +
>> +    if not isinstance(members, list):
>> +        raise QAPISemError(info,
>> +                           "Enum '%s' requires an array for 'data'" % n=
ame)
>> +
>
> Did you move this check down intentionally?
>
>>      for member in members:
>> +        if isinstance(member, dict):
>> +            source =3D "dictionary member of enum '%s'" % name
>> +            check_known_keys(info, source, member, ['name'], [])
>> +            member =3D member['name']
>> +
>>          check_name(info, "Member of enum '%s'" % name, member,
>>                     enum_member=3DTrue)
>
> Again, slightly more complicated than v6 because it now runs before
> normalization.  We'll revisit this at [*] below.

If we keep it this way, then let's at least avoid assigning to the loop
control variable:

                member_name =3D member['name']
            else:
                member_name =3D member
            check_name(info, "Member of enum '%s'" % name, member_name,
                       enum_member=3DTrue)

[...]
