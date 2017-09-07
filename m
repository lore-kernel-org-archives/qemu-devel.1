Received: from eggs.gnu.org ([2001:4830:134:3::10]:48854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpxX4-0006d3-Ga
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:11:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpxWz-00011B-IK
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:11:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dpxWz-0000yc-9g
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:11:45 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-30-marcandre.lureau@redhat.com>
	<8737807zgu.fsf@dusky.pond.sub.org>
Date: Thu, 07 Sep 2017 16:11:39 +0200
In-Reply-To: <8737807zgu.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Wed, 06 Sep 2017 15:01:37 +0200")
Message-ID: <87mv6661k4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 29/54] qapi: add 'if' to enum members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

One more thing...

Markus Armbruster <armbru@redhat.com> writes:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  scripts/qapi.py                         | 33 ++++++++++++++++++++++++++=
+------
>>  tests/qapi-schema/enum-dict-member.err  |  1 -
>>  tests/qapi-schema/enum-dict-member.exit |  2 +-
>>  tests/qapi-schema/enum-dict-member.json |  3 +--
>>  tests/qapi-schema/enum-dict-member.out  |  4 ++++
>>  tests/qapi-schema/qapi-schema-test.json |  5 +++--
>>  tests/qapi-schema/qapi-schema-test.out  |  3 ++-
>>  tests/qapi-schema/test-qapi.py          |  4 +++-
>>  8 files changed, 41 insertions(+), 14 deletions(-)
>>
>> diff --git a/scripts/qapi.py b/scripts/qapi.py
>> index 9d075440d3..9c7c01c11d 100644
>> --- a/scripts/qapi.py
>> +++ b/scripts/qapi.py
>> @@ -729,6 +729,10 @@ def check_event(expr, info):
>>                 allow_metas=3Dmeta)
>>=20=20
>>=20=20
>> +def enum_get_values(expr):
>> +    return [e if isinstance(e, str) else e['name'] for e in expr['data'=
]]
>> +
>> +
>
> An iterator would be more efficient, but this will do.
>
>>  def check_union(expr, info):
>>      name =3D expr['union']
>>      base =3D expr.get('base')
>> @@ -788,7 +792,7 @@ def check_union(expr, info):
>>          # If the discriminator names an enum type, then all members
>>          # of 'data' must also be members of the enum type.
>>          if enum_define:
>> -            if key not in enum_define['data']:
>> +            if key not in enum_get_values(enum_define):
>>                  raise QAPISemError(info,
>>                                     "Discriminator value '%s' is not fou=
nd in "
>>                                     "enum '%s'"
>> @@ -796,7 +800,7 @@ def check_union(expr, info):
>>=20=20
>>      # If discriminator is user-defined, ensure all values are covered
>>      if enum_define:
>> -        for value in enum_define['data']:
>> +        for value in enum_get_values(enum_define):
>>              if value not in members.keys():
>>                  raise QAPISemError(info, "Union '%s' data missing '%s' =
branch"
>>                                     % (name, value))
>> @@ -827,7 +831,7 @@ def check_alternate(expr, info):
>>          if qtype =3D=3D 'QTYPE_QSTRING':
>>              enum_expr =3D enum_types.get(value)
>>              if enum_expr:
>> -                for v in enum_expr['data']:
>> +                for v in enum_get_values(enum_expr):
>>                      if v in ['on', 'off']:
>>                          conflicting.add('QTYPE_QBOOL')
>>                      if re.match(r'[-+0-9.]', v): # lazy, could be tight=
ened
>> @@ -857,6 +861,12 @@ def check_enum(expr, info):
>>          raise QAPISemError(info,
>>                             "Enum '%s' requires a string for 'prefix'" %=
 name)
>>      for member in members:
>> +        if isinstance(member, dict):
>> +            if not 'name' in member:
>> +                raise QAPISemError(info, "Dictionary member of enum '%s=
' must "
>> +                                   "have a 'name' key" % name)
>> +            check_if(member, info)

Where are dictionary keys other than 'name' and 'if' rejected?

>> +            member =3D member['name']
>>          check_name(info, "Member of enum '%s'" % name, member,
>>                     enum_member=3DTrue)
>>=20=20
>
> Looks like you got all uses of enum's 'data' in the old semantic
> checker.
>
> Aside: work like this is why I dislike how the old semantic checker
> works directly on the parse trees represented as OrderedDict.
> Everything is a dictionary, and almost everything's key is 'data'.
>
[...]
