Received: from eggs.gnu.org ([2001:4830:134:3::10]:48645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eZkSC-0003OK-9I
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:32:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eZkSB-0007jL-5Q
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:32:04 -0500
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:45212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eZkSA-0007io-RW
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:32:03 -0500
Received: by mail-wr0-x235.google.com with SMTP id 16so3537370wry.12
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 13:32:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87o9n51rgr.fsf@dusky.pond.sub.org>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-27-marcandre.lureau@redhat.com>
	<87o9n51rgr.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 11 Jan 2018 22:32:01 +0100
Message-ID: <CAJ+F1CLfSa6d=d1iWk6ABuMMnQKwyiJkpO62ZbZU4t_V0DoNUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 26/50] qapi: add 'if' on union variants
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

On Mon, Dec 11, 2017 at 11:36 AM, Markus Armbruster <armbru@redhat.com> wro=
te:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  scripts/qapi.py                         | 15 ++++++++++-----
>>  tests/qapi-schema/qapi-schema-test.json |  7 ++++++-
>>  tests/qapi-schema/qapi-schema-test.out  |  8 ++++++++
>>  tests/qapi-schema/test-qapi.py          |  5 ++++-
>>  4 files changed, 28 insertions(+), 7 deletions(-)
>>
>> diff --git a/scripts/qapi.py b/scripts/qapi.py
>> index 15711f96fa..2f14edfa1f 100644
>> --- a/scripts/qapi.py
>> +++ b/scripts/qapi.py
>> @@ -1412,8 +1412,8 @@ class QAPISchemaObjectTypeVariants(object):
>>  class QAPISchemaObjectTypeVariant(QAPISchemaObjectTypeMember):
>>      role =3D 'branch'
>>
>> -    def __init__(self, name, typ):
>> -        QAPISchemaObjectTypeMember.__init__(self, name, typ, False)
>> +    def __init__(self, name, typ, ifcond=3DNone):
>> +        QAPISchemaObjectTypeMember.__init__(self, name, typ, False, ifc=
ond)
>>
>>
>>  class QAPISchemaAlternateType(QAPISchemaType):
>> @@ -1674,13 +1674,18 @@ class QAPISchema(object):
>>          return QAPISchemaObjectTypeVariant(case, typ)
>>
>>      def _make_simple_variant(self, case, typ, info):
>> +        ifcond =3D None
>> +        if isinstance(typ, dict):
>> +            check_unknown_keys(info, typ, {'type', 'if'})
>> +            ifcond =3D typ.get('if')
>> +            typ =3D typ['type']
>>          if isinstance(typ, list):
>>              assert len(typ) =3D=3D 1
>>              typ =3D self._make_array_type(typ[0], info)
>>          typ =3D self._make_implicit_object_type(
>>              typ, info, None, self.lookup_type(typ).ifcond,
>>              'wrapper', [self._make_member('data', typ, info)])
>> -        return QAPISchemaObjectTypeVariant(case, typ)
>> +        return QAPISchemaObjectTypeVariant(case, typ, ifcond)
>>
>>      def _def_union_type(self, expr, info, doc):
>>          name =3D expr['union']
>> @@ -1700,8 +1705,8 @@ class QAPISchema(object):
>>          else:
>>              variants =3D [self._make_simple_variant(key, value, info)
>>                          for (key, value) in data.iteritems()]
>> -            typ =3D self._make_implicit_enum_type(name, info, ifcond,
>> -                                                [v.name for v in varian=
ts])
>> +            values =3D [{'name': v.name, 'if': v.ifcond} for v in varia=
nts]
>> +            typ =3D self._make_implicit_enum_type(name, info, ifcond, v=
alues)
>>              tag_member =3D QAPISchemaObjectTypeMember('type', typ, Fals=
e)
>>              members =3D [tag_member]
>>          self._def_entity(
>> diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema=
/qapi-schema-test.json
>> index 5cfccabb3d..895e80a978 100644
>> --- a/tests/qapi-schema/qapi-schema-test.json
>> +++ b/tests/qapi-schema/qapi-schema-test.json
>> @@ -200,9 +200,14 @@
>>    [ 'foo', { 'name' : 'bar', 'if': 'defined(TEST_IF_ENUM_BAR)' } ],
>>    'if': 'defined(TEST_IF_ENUM)' }
>>
>> -{ 'union': 'TestIfUnion', 'data': { 'foo': 'TestStruct' },
>> +{ 'union': 'TestIfUnion', 'data':
>> +  { 'foo': 'TestStruct',
>> +    'union_bar': { 'type': 'str', 'if': 'defined(TEST_IF_UNION_BAR)'} }=
,
>>    'if': 'defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)' }
>>
>> +{ 'command': 'TestIfUnionCmd', 'data': { 'union_cmd_arg': 'TestIfUnion'=
 },
>> +  'if': 'defined(TEST_IF_UNION)' }
>> +
>>  { 'alternate': 'TestIfAlternate', 'data': { 'foo': 'int', 'bar': 'TestS=
truct' },
>>    'if': 'defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)' }
>>
>> diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/=
qapi-schema-test.out
>> index 6df4e49c69..ee009c5626 100644
>> --- a/tests/qapi-schema/qapi-schema-test.out
>> +++ b/tests/qapi-schema/qapi-schema-test.out
>> @@ -87,9 +87,14 @@ object TestIfUnion
>>      member type: TestIfUnionKind optional=3DFalse
>>      tag type
>>      case foo: q_obj_TestStruct-wrapper
>> +    case union_bar: q_obj_str-wrapper if=3Ddefined(TEST_IF_UNION_BAR)
>
> PATCH 22, but I only spotted it here.  We say "if=3DCOND" in some places,
> ...
>
>>      if defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)
>> +command TestIfUnionCmd q_obj_TestIfUnionCmd-arg -> None
>> +   gen=3DTrue success_response=3DTrue boxed=3DFalse
>> +    if defined(TEST_IF_UNION)
>
> ... and "if COND" in other places.  I guess the '=3D' is there to match
> existing flag printing like optional=3DBOOL.
>
> I'd prefer less decorated output, i.e. instead of
>
>     enum TestIfEnum
>         member foo:
>         member bar: if=3Ddefined(TEST_IF_ENUM_BAR)
>         if defined(TEST_IF_ENUM)
>
> something like
>
> enum TestIfEnum
>     member foo
>     member bar
>         if defined(TEST_IF_ENUM_BAR)
>     if defined(TEST_IF_ENUM)
>
> Could touch that up on commit.
>

ok, changed

>>  enum TestIfUnionKind
>>      member foo:
>> +    member union_bar: if=3Ddefined(TEST_IF_UNION_BAR)
>>      if defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)
>>  object TestStruct
>>      member integer: int optional=3DFalse
>> @@ -235,6 +240,9 @@ object q_obj_TestIfEvent-arg
>>      member foo: TestIfStruct optional=3DFalse
>>      member bar: TestIfEnum optional=3DFalse if=3Ddefined(TEST_IF_EVT_BA=
R)
>>      if defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)
>> +object q_obj_TestIfUnionCmd-arg
>> +    member union_cmd_arg: TestIfUnion optional=3DFalse
>> +    if defined(TEST_IF_UNION)
>>  object q_obj_TestStruct-wrapper
>>      member data: TestStruct optional=3DFalse
>>  object q_obj_UserDefFlatUnion2-base
>> diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qap=
i.py
>> index a86c3b5ee1..87a8efff78 100644
>> --- a/tests/qapi-schema/test-qapi.py
>> +++ b/tests/qapi-schema/test-qapi.py
>> @@ -65,7 +65,10 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
>>          if variants:
>>              print '    tag %s' % variants.tag_member.name
>>              for v in variants.variants:
>> -                print '    case %s: %s' % (v.name, v.type.name)
>> +                print '    case %s: %s' % (v.name, v.type.name),
>> +                if v.ifcond:
>> +                    print 'if=3D%s' % v.ifcond,
>> +                print
>>
>>      @staticmethod
>>      def _print_if(ifcond):
>



--=20
Marc-Andr=C3=A9 Lureau
