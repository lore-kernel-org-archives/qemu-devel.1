Received: from eggs.gnu.org ([2001:4830:134:3::10]:60737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gVaeq-0000Me-3S
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:20:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gVaei-0005U5-Sa
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:20:26 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34574)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gVaei-0005Tn-N4
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:20:20 -0500
Received: by mail-qt1-f195.google.com with SMTP id r14so7469753qtp.1
	for <qemu-devel@nongnu.org>; Sat, 08 Dec 2018 03:20:20 -0800 (PST)
MIME-Version: 1.0
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
	<20180706105753.26700-20-marcandre.lureau@redhat.com>
	<87efaua9wu.fsf@dusky.pond.sub.org>
In-Reply-To: <87efaua9wu.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 8 Dec 2018 15:20:08 +0400
Message-ID: <CAMxuvazcRTvbL-eF49F_grkyaHwjsta5qCb6i1tKNZT8H5O3bQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 19/27] qapi: add 'if' on union members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Armbruster, Markus" <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

Hi
On Thu, Dec 6, 2018 at 8:37 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> In the subject, s/ on / to /.
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Add 'if' key to union members:
> >
> > { 'union': 'TestIfUnion', 'data':
> >     'mem': { 'type': 'str', 'if': 'COND'} }
> >
> > Generated code is not changed by this patch but with "qapi: add #if
> > conditions to generated code".
>
> My suggestion on PATCH 13's commit message applies.

ok

>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  scripts/qapi/common.py                  | 17 +++++++++--------
> >  tests/qapi-schema/qapi-schema-test.json |  7 ++++++-
> >  tests/qapi-schema/qapi-schema-test.out  | 10 ++++++++++
> >  tests/qapi-schema/test-qapi.py          |  1 +
> >  4 files changed, 26 insertions(+), 9 deletions(-)
> >
> > diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> > index 13fbb28493..e1bd9a22ba 100644
> > --- a/scripts/qapi/common.py
> > +++ b/scripts/qapi/common.py
> > @@ -813,7 +813,7 @@ def check_union(expr, info):
> >      for (key, value) in members.items():
> >          check_name(info, "Member of union '%s'" % name, key)
> >          source =3D "member '%s' of union '%s'" % (key, name)
> > -        check_known_keys(info, source, value, ['type'], [])
> > +        check_known_keys(info, source, value, ['type'], ['if'])
> >          typ =3D value['type']
> >
> >          # Each value must name a known type
> > @@ -1496,8 +1496,8 @@ class QAPISchemaObjectTypeVariants(object):
> >  class QAPISchemaObjectTypeVariant(QAPISchemaObjectTypeMember):
> >      role =3D 'branch'
> >
> > -    def __init__(self, name, typ):
> > -        QAPISchemaObjectTypeMember.__init__(self, name, typ, False)
> > +    def __init__(self, name, typ, ifcond=3DNone):
> > +        QAPISchemaObjectTypeMember.__init__(self, name, typ, False, if=
cond)
> >
> >
> >  class QAPISchemaAlternateType(QAPISchemaType):
> > @@ -1777,14 +1777,14 @@ class QAPISchema(object):
> >      def _make_variant(self, case, typ):
> >          return QAPISchemaObjectTypeVariant(case, typ)
> >
> > -    def _make_simple_variant(self, case, typ, info):
> > +    def _make_simple_variant(self, case, typ, ifcond, info):
> >          if isinstance(typ, list):
> >              assert len(typ) =3D=3D 1
> >              typ =3D self._make_array_type(typ[0], info)
> >          typ =3D self._make_implicit_object_type(
> >              typ, info, None, self.lookup_type(typ),
> >              'wrapper', [self._make_member('data', typ, None, info)])
> > -        return QAPISchemaObjectTypeVariant(case, typ)
> > +        return QAPISchemaObjectTypeVariant(case, typ, ifcond)
> >
> >      def _def_union_type(self, expr, info, doc):
> >          name =3D expr['union']
> > @@ -1802,10 +1802,11 @@ class QAPISchema(object):
> >                          for (key, value) in data.items()]
> >              members =3D []
> >          else:
> > -            variants =3D [self._make_simple_variant(key, value['type']=
, info)
> > +            variants =3D [self._make_simple_variant(key, value['type']=
,
> > +                                                  value.get('if'), inf=
o)
> >                          for (key, value) in data.items()]
> > -            typ =3D self._make_implicit_enum_type(name, info, ifcond,
> > -                                                [v.name for v in varia=
nts])
> > +            enum =3D [{'name': v.name, 'if': v.ifcond} for v in varian=
ts]
> > +            typ =3D self._make_implicit_enum_type(name, info, ifcond, =
enum)
> >              tag_member =3D QAPISchemaObjectTypeMember('type', typ, Fal=
se)
> >              members =3D [tag_member]
> >          self._def_entity(
> > diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schem=
a/qapi-schema-test.json
> > index 3bf440aab4..6d3c6c0b53 100644
> > --- a/tests/qapi-schema/qapi-schema-test.json
> > +++ b/tests/qapi-schema/qapi-schema-test.json
> > @@ -208,9 +208,14 @@
> >    [ 'foo', { 'name' : 'bar', 'if': 'defined(TEST_IF_ENUM_BAR)' } ],
> >    'if': 'defined(TEST_IF_ENUM)' }
> >
> > -{ 'union': 'TestIfUnion', 'data': { 'foo': 'TestStruct' },
> > +{ 'union': 'TestIfUnion', 'data':
> > +  { 'foo': 'TestStruct',
> > +    'union_bar': { 'type': 'str', 'if': 'defined(TEST_IF_UNION_BAR)'} =
},
>
> "Union Bar" sounds like a cocktail lounge in northeast US :)
>
> Back to serious: this is a simple union.  I'd prefer to test flat
> unions.  Changing TestIfUnion accordingly could be done either before
> this patch, or on top of this series, the latter not necessarily by
> you.  Your choice.

I prefer to defer

>
> >    'if': 'defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)' }
> >
> > +{ 'command': 'TestIfUnionCmd', 'data': { 'union_cmd_arg': 'TestIfUnion=
' },
> > +  'if': 'defined(TEST_IF_UNION)' }
> > +
>
> I'm feeling dense... why does this change belong to this patch?

Hmm, no strong reason, I'll make it a separate commit.
>
> >  { 'alternate': 'TestIfAlternate', 'data': { 'foo': 'int', 'bar': 'Test=
Struct' },
> >    'if': 'defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)' }
> >
> > diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema=
/qapi-schema-test.out
> > index 71b84878c7..ac1069cf1f 100644
> > --- a/tests/qapi-schema/qapi-schema-test.out
> > +++ b/tests/qapi-schema/qapi-schema-test.out
> > @@ -278,12 +278,22 @@ object q_obj_TestStruct-wrapper
> >      member data: TestStruct optional=3DFalse
> >  enum TestIfUnionKind
> >      member foo
> > +    member union_bar
> > +        if ['defined(TEST_IF_UNION_BAR)']
> >      if ['defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)']
> >  object TestIfUnion
> >      member type: TestIfUnionKind optional=3DFalse
> >      tag type
> >      case foo: q_obj_TestStruct-wrapper
> > +    case union_bar: q_obj_str-wrapper
> > +        if ['defined(TEST_IF_UNION_BAR)']
> >      if ['defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)']
> > +object q_obj_TestIfUnionCmd-arg
> > +    member union_cmd_arg: TestIfUnion optional=3DFalse
> > +    if ['defined(TEST_IF_UNION)']
> > +command TestIfUnionCmd q_obj_TestIfUnionCmd-arg -> None
> > +   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse precon=
fig=3DFalse
> > +    if ['defined(TEST_IF_UNION)']
> >  alternate TestIfAlternate
> >      tag type
> >      case foo: int
> > diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qa=
pi.py
> > index 69e40d87d2..d977e936c7 100644
> > --- a/tests/qapi-schema/test-qapi.py
> > +++ b/tests/qapi-schema/test-qapi.py
> > @@ -68,6 +68,7 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
> >              print('    tag %s' % variants.tag_member.name)
> >              for v in variants.variants:
> >                  print('    case %s: %s' % (v.name, v.type.name))
> > +                QAPISchemaTestVisitor._print_if(v.ifcond, 8)
> >
> >      @staticmethod
> >      def _print_if(ifcond, indent=3D4):
