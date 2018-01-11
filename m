Received: from eggs.gnu.org ([2001:4830:134:3::10]:44766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eZkKp-0004j4-G1
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:24:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eZkKn-0001DA-JR
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:24:27 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:35564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eZkKn-0001CW-8s
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:24:25 -0500
Received: by mail-wr0-x244.google.com with SMTP id g38so344934wrd.2
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 13:24:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87r2s5ipgd.fsf@dusky.pond.sub.org>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-20-marcandre.lureau@redhat.com>
	<87r2s5ipgd.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 11 Jan 2018 22:24:22 +0100
Message-ID: <CAJ+F1CLdM92EkdPDw=UL65G476dMMUNMVaLd3hi-66Mk9N99Jg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 19/50] qapi: add 'if' to enum members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi

On Fri, Dec 8, 2017 at 9:38 AM, Markus Armbruster <armbru@redhat.com> wrote=
:
> A bit more detail in the commit message would make this patch easier to
> review.
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  scripts/qapi.py                         | 39 ++++++++++++++++++++++++++=
++-----
>>  tests/Makefile.include                  |  1 -
>>  tests/qapi-schema/enum-dict-member.err  |  1 -
>>  tests/qapi-schema/enum-dict-member.exit |  1 -
>>  tests/qapi-schema/enum-dict-member.json |  2 --
>>  tests/qapi-schema/enum-dict-member.out  |  0
>>  tests/qapi-schema/qapi-schema-test.json |  5 +++--
>>  tests/qapi-schema/qapi-schema-test.out  |  3 ++-
>>  tests/qapi-schema/test-qapi.py          |  2 ++
>>  9 files changed, 41 insertions(+), 13 deletions(-)
>>  delete mode 100644 tests/qapi-schema/enum-dict-member.err
>>  delete mode 100644 tests/qapi-schema/enum-dict-member.exit
>>  delete mode 100644 tests/qapi-schema/enum-dict-member.json
>>  delete mode 100644 tests/qapi-schema/enum-dict-member.out
>>
>> diff --git a/scripts/qapi.py b/scripts/qapi.py
>> index 386a577a59..1535de9ce7 100644
>> --- a/scripts/qapi.py
>> +++ b/scripts/qapi.py
>> @@ -659,6 +659,14 @@ def check_if(expr, info):
>>              info, "'if' condition must be a string or a list of strings=
")
>>
>>
>> +def check_unknown_keys(info, dict, allowed_keys):
>> +    diff =3D set(dict) - allowed_keys
>> +    if not diff:
>> +        return
>> +    raise QAPISemError(info, "Dictionnary has unknown keys: %s (allowed=
: %s)" %
>
> s/Dictionnary/Dictionary/

ok

>
>> +        (', '.join(diff), ', '.join(allowed_keys)))
>
> I'm afraid this duplicates a part of check_keys().  Could it be factored
> out?

done

>
>> +
>> +
>>  def check_type(info, source, value, allow_array=3DFalse,
>>                 allow_dict=3DFalse, allow_optional=3DFalse,
>>                 allow_metas=3D[]):
>> @@ -739,6 +747,10 @@ def check_event(expr, info):
>>                 allow_metas=3Dmeta)
>>
>>
>> +def enum_get_values(expr):
>> +    return [e if isinstance(e, str) else e['name'] for e in expr['data'=
]]
>> +
>> +
>>  def check_union(expr, info):
>>      name =3D expr['union']
>>      base =3D expr.get('base')
>> @@ -798,7 +810,7 @@ def check_union(expr, info):
>>          # If the discriminator names an enum type, then all members
>>          # of 'data' must also be members of the enum type.
>>          if enum_define:
>> -            if key not in enum_define['data']:
>> +            if key not in enum_get_values(enum_define):
>>                  raise QAPISemError(info,
>>                                     "Discriminator value '%s' is not fou=
nd in "
>>                                     "enum '%s'"
>> @@ -806,7 +818,7 @@ def check_union(expr, info):
>>
>>      # If discriminator is user-defined, ensure all values are covered
>>      if enum_define:
>> -        for value in enum_define['data']:
>> +        for value in enum_get_values(enum_define):
>>              if value not in members.keys():
>>                  raise QAPISemError(info, "Union '%s' data missing '%s' =
branch"
>>                                     % (name, value))
>> @@ -837,7 +849,7 @@ def check_alternate(expr, info):
>>          if qtype =3D=3D 'QTYPE_QSTRING':
>>              enum_expr =3D enum_types.get(value)
>>              if enum_expr:
>> -                for v in enum_expr['data']:
>> +                for v in enum_get_values(enum_expr):
>>                      if v in ['on', 'off']:
>>                          conflicting.add('QTYPE_QBOOL')
>>                      if re.match(r'[-+0-9.]', v): # lazy, could be tight=
ened
>> @@ -865,6 +877,14 @@ def check_enum(expr, info):
>>          raise QAPISemError(info,
>>                             "Enum '%s' requires a string for 'prefix'" %=
 name)
>>      for member in members:
>> +        if isinstance(member, dict):
>> +            if 'name' not in member:
>> +                raise QAPISemError(info, "Dictionary member of enum '%s=
' must "
>> +                                   "have a 'name' key" % name)
>> +            if 'if' in member:
>> +                check_if(member, info)
>> +            check_unknown_keys(info, member, {'name', 'if'})
>> +            member =3D member['name']
>>          check_name(info, "Member of enum '%s'" % name, member,
>>                     enum_member=3DTrue)
>>
>> @@ -1280,9 +1300,11 @@ class QAPISchemaObjectType(QAPISchemaType):
>>  class QAPISchemaMember(object):
>>      role =3D 'member'
>>
>> -    def __init__(self, name):
>> +    def __init__(self, name, ifcond=3DNone):
>>          assert isinstance(name, str)
>> +        assert ifcond is None or isinstance(ifcond, str)
>>          self.name =3D name
>> +        self.ifcond =3D ifcond
>>          self.owner =3D None
>>
>>      def set_owner(self, name):
>
> QAPISchemaObjectTypeMember inherits .ifcond.  Peeking ahead: looks like
> it'll get used when we add conditions to object type members, PATCH
> 23ff.  Okay.  Mentioning it in the commit message wouldn't hurt, though.

It will *also* get used. Ok, updated commit message.

>
>> @@ -1559,7 +1581,14 @@ class QAPISchema(object):
>>                                              qtype_values, 'QTYPE'))
>>
>>      def _make_enum_members(self, values):
>> -        return [QAPISchemaMember(v) for v in values]
>> +        enum =3D []
>> +        for v in values:
>> +            ifcond =3D None
>> +            if isinstance(v, dict):
>> +                ifcond =3D v.get('if')
>> +                v =3D v['name']
>> +            enum.append(QAPISchemaMember(v, ifcond))
>
>
> I like brevity a lot, but if it's bought by assigning to a loop control
> variable, I pass.  Cleaner:
>
>            for v in values:
>                if isinstance(v, dict):
>                    name =3D v['name']
>                    ifcond =3D v.get('if')
>                else:
>                    name =3D v
>                    ifcond =3D None
>            enum.append(QAPISchemaMember(name, ifcond))
>

sure

>> +        return enum
>>
>>      def _make_implicit_enum_type(self, name, info, ifcond, values):
>>          # See also QAPISchemaObjectTypeMember._pretty_owner()
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 8dac7c9083..a9f0ddbe01 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -443,7 +443,6 @@ qapi-schema +=3D empty.json
>>  qapi-schema +=3D enum-bad-name.json
>>  qapi-schema +=3D enum-bad-prefix.json
>>  qapi-schema +=3D enum-clash-member.json
>> -qapi-schema +=3D enum-dict-member.json
>>  qapi-schema +=3D enum-int-member.json
>>  qapi-schema +=3D enum-member-case.json
>>  qapi-schema +=3D enum-missing-data.json
>> diff --git a/tests/qapi-schema/enum-dict-member.err b/tests/qapi-schema/=
enum-dict-member.err
>> deleted file mode 100644
>> index 8ca146ea59..0000000000
>> --- a/tests/qapi-schema/enum-dict-member.err
>> +++ /dev/null
>> @@ -1 +0,0 @@
>> -tests/qapi-schema/enum-dict-member.json:2: Member of enum 'MyEnum' requ=
ires a string name
>> diff --git a/tests/qapi-schema/enum-dict-member.exit b/tests/qapi-schema=
/enum-dict-member.exit
>> deleted file mode 100644
>> index d00491fd7e..0000000000
>> --- a/tests/qapi-schema/enum-dict-member.exit
>> +++ /dev/null
>> @@ -1 +0,0 @@
>> -1
>> diff --git a/tests/qapi-schema/enum-dict-member.json b/tests/qapi-schema=
/enum-dict-member.json
>> deleted file mode 100644
>> index 79672e0f09..0000000000
>> --- a/tests/qapi-schema/enum-dict-member.json
>> +++ /dev/null
>> @@ -1,2 +0,0 @@
>> -# we reject any enum member that is not a string
>> -{ 'enum': 'MyEnum', 'data': [ { 'value': 'str' } ] }
>> diff --git a/tests/qapi-schema/enum-dict-member.out b/tests/qapi-schema/=
enum-dict-member.out
>> deleted file mode 100644
>> index e69de29bb2..0000000000
>
> Hmm.  The dict instance of "enum value must be of an appropriate JSON
> type" error class goes away in this patch, but the class remains.  Do we
> still cover it?
>
> There's enum-int-member.json, but it's not a good test: it dies in the
> lexer.  I think we should replace the two tests by a single one.
> Perhaps something like 'data': [ [] ] would do.

I replaced enum-dict-member by enum-bad-member. I left the int-member
test, because it has also the purpose to check the lexer.

>
>> diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema=
/qapi-schema-test.json
>> index dc2c444fc1..ad2b405d83 100644
>> --- a/tests/qapi-schema/qapi-schema-test.json
>> +++ b/tests/qapi-schema/qapi-schema-test.json
>> @@ -194,7 +194,8 @@
>>  { 'struct': 'TestIfStruct', 'data': { 'foo': 'int' },
>>    'if': 'defined(TEST_IF_STRUCT)' }
>>
>> -{ 'enum': 'TestIfEnum', 'data': [ 'foo', 'bar' ],
>> +{ 'enum': 'TestIfEnum', 'data':
>> +  [ 'foo', { 'name' : 'bar', 'if': 'defined(TEST_IF_ENUM_BAR)' } ],
>>    'if': 'defined(TEST_IF_ENUM)' }
>>
>>  { 'union': 'TestIfUnion', 'data': { 'foo': 'TestStruct' },
>> @@ -203,7 +204,7 @@
>>  { 'alternate': 'TestIfAlternate', 'data': { 'foo': 'int', 'bar': 'TestS=
truct' },
>>    'if': 'defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)' }
>>
>> -{ 'command': 'TestIfCmd', 'data': { 'foo': 'TestIfStruct' },
>> +{ 'command': 'TestIfCmd', 'data': { 'foo': 'TestIfStruct', 'bar': 'Test=
IfEnum' },
>>    'if': 'defined(TEST_IF_CMD) && defined(TEST_IF_STRUCT)' }
>>
>>  { 'event': 'TestIfEvent', 'data': { 'foo': 'TestIfStruct' },
>
> Should this hunk be in PATCH 04?

It could, but it is not necessary until conditionals are added to
verify introspection generation.

>
>> diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/=
qapi-schema-test.out
>> index 9a7cafc269..8a0cf1a551 100644
>> --- a/tests/qapi-schema/qapi-schema-test.out
>> +++ b/tests/qapi-schema/qapi-schema-test.out
>> @@ -74,7 +74,7 @@ command TestIfCmd q_obj_TestIfCmd-arg -> None
>>      if defined(TEST_IF_CMD) && defined(TEST_IF_STRUCT)
>>  enum TestIfEnum
>>      member foo:
>> -    member bar:
>> +    member bar: if=3Ddefined(TEST_IF_ENUM_BAR)
>>      if defined(TEST_IF_ENUM)
>>  event TestIfEvent q_obj_TestIfEvent-arg
>>     boxed=3DFalse
>> @@ -228,6 +228,7 @@ object q_obj_EVENT_D-arg
>>      member enum3: EnumOne optional=3DTrue
>>  object q_obj_TestIfCmd-arg
>>      member foo: TestIfStruct optional=3DFalse
>> +    member bar: TestIfEnum optional=3DFalse
>>      if defined(TEST_IF_CMD) && defined(TEST_IF_STRUCT)
>>  object q_obj_TestIfEvent-arg
>>      member foo: TestIfStruct optional=3DFalse
>> diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qap=
i.py
>> index 67c6c1ecef..a86c3b5ee1 100644
>> --- a/tests/qapi-schema/test-qapi.py
>> +++ b/tests/qapi-schema/test-qapi.py
>> @@ -56,6 +56,8 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
>>              print '    member %s:' % m.name,
>>              if isinstance(m, QAPISchemaObjectTypeMember):
>>                  print '%s optional=3D%s' % (m.type.name, m.optional),
>> +            if m.ifcond:
>> +                print 'if=3D%s' % m.ifcond,
>>              print
>>
>>      @staticmethod
>



--=20
Marc-Andr=C3=A9 Lureau
