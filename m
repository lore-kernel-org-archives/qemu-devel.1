Received: from eggs.gnu.org ([2001:4830:134:3::10]:60848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gVaf0-0000W5-1l
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:20:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gVaes-0005Ys-6x
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:20:37 -0500
Received: from mail-qk1-f180.google.com ([209.85.222.180]:45503)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gVaeq-0005Vv-5l
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:20:28 -0500
Received: by mail-qk1-f180.google.com with SMTP id y78so3960690qka.12
	for <qemu-devel@nongnu.org>; Sat, 08 Dec 2018 03:20:25 -0800 (PST)
MIME-Version: 1.0
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
	<20180706105753.26700-17-marcandre.lureau@redhat.com>
	<87ftvad4xl.fsf@dusky.pond.sub.org>
In-Reply-To: <87ftvad4xl.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 8 Dec 2018 15:20:12 +0400
Message-ID: <CAMxuvaxEBwvHTpK1XBzm=VBbXGSgwvCVO57BH8dkC1M5PHgbhg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 16/27] qapi: add a dictionary form with
 'type' key for members
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

On Thu, Dec 6, 2018 at 7:56 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Wherever a struct/union/alternate/command/event member with NAME: TYPE
> > form is accepted, desugar it to a NAME: { 'type': TYPE } form.
> >
> > This will allow to add new member details, such as 'if' in the
> > following patch to introduce conditionals, or 'default' for default
> > values etc.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  scripts/qapi/common.py                        | 56 +++++++++++++------
> >  tests/Makefile.include                        |  3 +
> >  tests/qapi-schema/alternate-invalid-dict.err  |  1 +
> >  tests/qapi-schema/alternate-invalid-dict.exit |  1 +
> >  tests/qapi-schema/alternate-invalid-dict.json |  4 ++
> >  tests/qapi-schema/alternate-invalid-dict.out  |  0
> >  tests/qapi-schema/event-nest-struct.err       |  2 +-
> >  tests/qapi-schema/flat-union-inline.err       |  2 +-
> >  tests/qapi-schema/nested-struct-data.err      |  2 +-
> >  tests/qapi-schema/qapi-schema-test.json       | 10 ++--
> >  .../struct-member-invalid-dict.err            |  1 +
> >  .../struct-member-invalid-dict.exit           |  1 +
> >  .../struct-member-invalid-dict.json           |  3 +
> >  .../struct-member-invalid-dict.out            |  0
> >  .../qapi-schema/union-branch-invalid-dict.err |  1 +
> >  .../union-branch-invalid-dict.exit            |  1 +
> >  .../union-branch-invalid-dict.json            |  4 ++
> >  .../qapi-schema/union-branch-invalid-dict.out |  0
> >  18 files changed, 66 insertions(+), 26 deletions(-)
> >  create mode 100644 tests/qapi-schema/alternate-invalid-dict.err
> >  create mode 100644 tests/qapi-schema/alternate-invalid-dict.exit
> >  create mode 100644 tests/qapi-schema/alternate-invalid-dict.json
> >  create mode 100644 tests/qapi-schema/alternate-invalid-dict.out
> >  create mode 100644 tests/qapi-schema/struct-member-invalid-dict.err
> >  create mode 100644 tests/qapi-schema/struct-member-invalid-dict.exit
> >  create mode 100644 tests/qapi-schema/struct-member-invalid-dict.json
> >  create mode 100644 tests/qapi-schema/struct-member-invalid-dict.out
> >  create mode 100644 tests/qapi-schema/union-branch-invalid-dict.err
> >  create mode 100644 tests/qapi-schema/union-branch-invalid-dict.exit
> >  create mode 100644 tests/qapi-schema/union-branch-invalid-dict.json
> >  create mode 100644 tests/qapi-schema/union-branch-invalid-dict.out
> >
> > diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> > index d83fa1900e..fc68bb472e 100644
> > --- a/scripts/qapi/common.py
> > +++ b/scripts/qapi/common.py
> > @@ -588,11 +588,11 @@ def discriminator_find_enum_define(expr):
> >      if not base_members:
> >          return None
> >
> > -    discriminator_type =3D base_members.get(discriminator)
> > -    if not discriminator_type:
> > +    discriminator_member =3D base_members.get(discriminator)
> > +    if not discriminator_member:
> >          return None
> >
> > -    return enum_types.get(discriminator_type)
> > +    return enum_types.get(discriminator_member['type'])
> >
> >
>
> The name discriminator_member is confusing.  It suggests its value is
> the (desugared) member definition, i.e. something like
>
>      {'enum1': {'type': 'EnumOne'}}
>
> it's actually only the definition's value part, i.e. something like
>
>      {'type': 'EnumOne'}
>
> Naming is hard... discriminator_value?  discriminator_def_rhs?
>
> Same in check_union() below.
>

discriminator_value, ok

> >  # Names must be letters, numbers, -, and _.  They must start with lett=
er,
> > @@ -660,6 +660,15 @@ def check_if(expr, info):
> >          check_if_str(ifcond, info)
> >
> >
> > +def normalize_members(expr, field):
> > +    members =3D expr.get(field)
> > +    if isinstance(members, OrderedDict):
> > +        for key, arg in members.items():
> > +            if isinstance(arg, dict):
> > +                continue
> > +            members[key] =3D {'type': arg}
> > +
> > +
>
> PATCH 12's normalize_enum() conflates normalization and checking.  This
> one doesn't.  Better.

I fixed patch 12

>
> >  def check_type(info, source, value, allow_array=3DFalse,
> >                 allow_implicit=3DFalse, allow_optional=3DFalse,
> >                 allow_metas=3D[]):
> > @@ -704,8 +713,10 @@ def check_type(info, source, value, allow_array=3D=
False,
> >                                 % (source, key))
> >          # Todo: allow dictionaries to represent default values of
> >          # an optional argument.
> > -        check_type(info, "Member '%s' of %s" % (key, source), arg,
> > -                   allow_array=3DTrue,
> > +        check_known_keys(info, "member '%s' of %s" % (key, source),
> > +                         arg, ['type'], [])
> > +        check_type(info, "Member '%s' of %s" % (key, source),
> > +                   arg['type'], allow_array=3DTrue,
> >                     allow_metas=3D['built-in', 'union', 'alternate', 's=
truct',
> >                                  'enum'])
> >
> > @@ -776,13 +787,13 @@ def check_union(expr, info):
> >          # member of the base struct.
> >          check_name(info, "Discriminator of flat union '%s'" % name,
> >                     discriminator)
> > -        discriminator_type =3D base_members.get(discriminator)
> > -        if not discriminator_type:
> > +        discriminator_member =3D base_members.get(discriminator)
> > +        if not discriminator_member:
> >              raise QAPISemError(info,
> >                                 "Discriminator '%s' is not a member of =
base "
> >                                 "struct '%s'"
> >                                 % (discriminator, base))
> > -        enum_define =3D enum_types.get(discriminator_type)
> > +        enum_define =3D enum_types.get(discriminator_member['type'])
> >          allow_metas =3D ['struct']
> >          # Do not allow string discriminator
> >          if not enum_define:
> > @@ -795,10 +806,13 @@ def check_union(expr, info):
> >          raise QAPISemError(info, "Union '%s' cannot have empty 'data'"=
 % name)
> >      for (key, value) in members.items():
> >          check_name(info, "Member of union '%s'" % name, key)
> > +        source =3D "member '%s' of union '%s'" % (key, name)
> > +        check_known_keys(info, source, value, ['type'], [])
>
> Elsewhere, you do it like
>
>            check_known_keys(info, "member '%s' of union '%s'" % (key, nam=
e),
>                             value, ['type'], [])
>
> Let's stick to that.

ok

>
> > +        typ =3D value['type']
> >
> >          # Each value must name a known type
> >          check_type(info, "Member '%s' of union '%s'" % (key, name),
> > -                   value, allow_array=3Dnot base, allow_metas=3Dallow_=
metas)
> > +                   typ, allow_array=3Dnot base, allow_metas=3Dallow_me=
tas)
> >
> >          # If the discriminator names an enum type, then all members
> >          # of 'data' must also be members of the enum type.
> > @@ -822,18 +836,20 @@ def check_alternate(expr, info):
> >                             "in 'data'" % name)
> >      for (key, value) in members.items():
> >          check_name(info, "Member of alternate '%s'" % name, key)
> > +        source =3D "member '%s' of alternate '%s'" % (key, name)
> > +        check_known_keys(info, source, value, ['type'], [])
>
> Likewise.
>
> > +        typ =3D value['type']
> >
> >          # Ensure alternates have no type conflicts.
> > -        check_type(info, "Member '%s' of alternate '%s'" % (key, name)=
,
> > -                   value,
> > +        check_type(info, "Member '%s' of alternate '%s'" % (key, name)=
, typ,
> >                     allow_metas=3D['built-in', 'union', 'struct', 'enum=
'])
> > -        qtype =3D find_alternate_member_qtype(value)
> > +        qtype =3D find_alternate_member_qtype(typ)
> >          if not qtype:
> >              raise QAPISemError(info, "Alternate '%s' member '%s' canno=
t use "
> > -                               "type '%s'" % (name, key, value))
> > +                               "type '%s'" % (name, key, typ))
> >          conflicting =3D set([qtype])
> >          if qtype =3D=3D 'QTYPE_QSTRING':
> > -            enum_expr =3D enum_types.get(value)
> > +            enum_expr =3D enum_types.get(typ)
> >              if enum_expr:
> >                  for v in enum_get_names(enum_expr):
> >                      if v in ['on', 'off']:
> > @@ -947,6 +963,10 @@ def check_exprs(exprs):
> >          info =3D expr_elem['info']
> >          if 'enum' in expr:
> >              normalize_enum(expr, info)
> > +        elif 'union' in expr:
> > +            normalize_members(expr, 'base')
> > +        if {'union', 'alternate', 'struct', 'command', 'event'} & set(=
expr):
> > +            normalize_members(expr, 'data')
> >
> >      # Learn the types and check for valid expression keys
> >      for expr_elem in exprs:
>
> PATCH 12 had an issue in this loop, and the obvious fix was to fold it
> into the next loop.  I think this can be done here too.

moved to end-of-check

>
> > @@ -1735,7 +1755,7 @@ class QAPISchema(object):
> >          return QAPISchemaObjectTypeMember(name, typ, optional)
> >
> >      def _make_members(self, data, info):
> > -        return [self._make_member(key, value, info)
> > +        return [self._make_member(key, value['type'], info)
> >                  for (key, value) in data.items()]
> >
> >      def _def_struct_type(self, expr, info, doc):
> > @@ -1771,11 +1791,11 @@ class QAPISchema(object):
> >                  name, info, doc, ifcond,
> >                  'base', self._make_members(base, info))
> >          if tag_name:
> > -            variants =3D [self._make_variant(key, value)
> > +            variants =3D [self._make_variant(key, value['type'])
> >                          for (key, value) in data.items()]
> >              members =3D []
> >          else:
> > -            variants =3D [self._make_simple_variant(key, value, info)
> > +            variants =3D [self._make_simple_variant(key, value['type']=
, info)
> >                          for (key, value) in data.items()]
> >              typ =3D self._make_implicit_enum_type(name, info, ifcond,
> >                                                  [v.name for v in varia=
nts])
> > @@ -1791,7 +1811,7 @@ class QAPISchema(object):
> >          name =3D expr['alternate']
> >          data =3D expr['data']
> >          ifcond =3D expr.get('if')
> > -        variants =3D [self._make_variant(key, value)
> > +        variants =3D [self._make_variant(key, value['type'])
> >                      for (key, value) in data.items()]
> >          tag_member =3D QAPISchemaObjectTypeMember('type', 'QType', Fal=
se)
> >          self._def_entity(
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index 3ba9097892..43e100a6cd 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -421,6 +421,7 @@ qapi-schema +=3D alternate-conflict-string.json
> >  qapi-schema +=3D alternate-conflict-bool-string.json
> >  qapi-schema +=3D alternate-conflict-num-string.json
> >  qapi-schema +=3D alternate-empty.json
> > +qapi-schema +=3D alternate-invalid-dict.json
> >  qapi-schema +=3D alternate-nested.json
> >  qapi-schema +=3D alternate-unknown.json
> >  qapi-schema +=3D args-alternate.json
> > @@ -563,6 +564,7 @@ qapi-schema +=3D returns-whitelist.json
> >  qapi-schema +=3D struct-base-clash-deep.json
> >  qapi-schema +=3D struct-base-clash.json
> >  qapi-schema +=3D struct-data-invalid.json
> > +qapi-schema +=3D struct-member-invalid-dict.json
> >  qapi-schema +=3D struct-member-invalid.json
> >  qapi-schema +=3D trailing-comma-list.json
> >  qapi-schema +=3D trailing-comma-object.json
> > @@ -574,6 +576,7 @@ qapi-schema +=3D unicode-str.json
> >  qapi-schema +=3D union-base-empty.json
> >  qapi-schema +=3D union-base-no-discriminator.json
> >  qapi-schema +=3D union-branch-case.json
> > +qapi-schema +=3D union-branch-invalid-dict.json
> >  qapi-schema +=3D union-clash-branches.json
> >  qapi-schema +=3D union-empty.json
> >  qapi-schema +=3D union-invalid-base.json
> > diff --git a/tests/qapi-schema/alternate-invalid-dict.err b/tests/qapi-=
schema/alternate-invalid-dict.err
> > new file mode 100644
> > index 0000000000..631d46628e
> > --- /dev/null
> > +++ b/tests/qapi-schema/alternate-invalid-dict.err
> > @@ -0,0 +1 @@
> > +tests/qapi-schema/alternate-invalid-dict.json:2: Key 'type' is missing=
 from member 'two' of alternate 'Alt'
> > diff --git a/tests/qapi-schema/alternate-invalid-dict.exit b/tests/qapi=
-schema/alternate-invalid-dict.exit
> > new file mode 100644
> > index 0000000000..d00491fd7e
> > --- /dev/null
> > +++ b/tests/qapi-schema/alternate-invalid-dict.exit
> > @@ -0,0 +1 @@
> > +1
> > diff --git a/tests/qapi-schema/alternate-invalid-dict.json b/tests/qapi=
-schema/alternate-invalid-dict.json
> > new file mode 100644
> > index 0000000000..45f2c8ebef
> > --- /dev/null
> > +++ b/tests/qapi-schema/alternate-invalid-dict.json
> > @@ -0,0 +1,4 @@
> > +# invalid field dictionnary, missing type
>
> dictionary

argh..

>
> Suggest a grep over the whole series.
>
> Even better, reuse struct-member-invalid-dict.json's comment here.

ok

>
> > +{ 'alternate': 'Alt',
> > +  'data': { 'one': 'str',
> > +            'two': { 'if': 'foo' } } }
> > diff --git a/tests/qapi-schema/alternate-invalid-dict.out b/tests/qapi-=
schema/alternate-invalid-dict.out
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/qapi-schema/event-nest-struct.err b/tests/qapi-schem=
a/event-nest-struct.err
> > index 5a42701b8f..ea1be65d89 100644
> > --- a/tests/qapi-schema/event-nest-struct.err
> > +++ b/tests/qapi-schema/event-nest-struct.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/event-nest-struct.json:1: Member 'a' of 'data' for e=
vent 'EVENT_A' should be a type name
> > +tests/qapi-schema/event-nest-struct.json:1: Key 'type' is missing from=
 member 'a' of 'data' for event 'EVENT_A'
>
> We lose the test of the "should be a type name" error.  Let's copy this
> test to event-member-invalid-dict.json to cover "Key 'type' is missing",
> and update the original to keep covering "should be a type name".
>

ok

>
> > diff --git a/tests/qapi-schema/flat-union-inline.err b/tests/qapi-schem=
a/flat-union-inline.err
> > index 2333358d28..3d29433bfb 100644
> > --- a/tests/qapi-schema/flat-union-inline.err
> > +++ b/tests/qapi-schema/flat-union-inline.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/flat-union-inline.json:7: Member 'value1' of union '=
TestUnion' should be a type name
> > +tests/qapi-schema/flat-union-inline.json:7: Key 'type' is missing from=
 member 'value1' of union 'TestUnion'
>
> Likewise.
>
> > diff --git a/tests/qapi-schema/nested-struct-data.err b/tests/qapi-sche=
ma/nested-struct-data.err
> > index da767bade2..48355adcbe 100644
> > --- a/tests/qapi-schema/nested-struct-data.err
> > +++ b/tests/qapi-schema/nested-struct-data.err
> > @@ -1 +1 @@
> > -tests/qapi-schema/nested-struct-data.json:2: Member 'a' of 'data' for =
command 'foo' should be a type name
> > +tests/qapi-schema/nested-struct-data.json:2: Key 'type' is missing fro=
m member 'a' of 'data' for command 'foo'
>
> Likewise.
>
> > diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schem=
a/qapi-schema-test.json
> > index 35ca94d991..30f635d484 100644
> > --- a/tests/qapi-schema/qapi-schema-test.json
> > +++ b/tests/qapi-schema/qapi-schema-test.json
>
> Positive tests for ...
>
> > @@ -11,7 +11,7 @@
> >          'guest-sync' ] } }
> >
> >  { 'struct': 'TestStruct',
> > -  'data': { 'integer': 'int', 'boolean': 'bool', 'string': 'str' } }
> > +  'data': { 'integer': {'type': 'int'}, 'boolean': 'bool', 'string': '=
str' } }
>
> ... struct member, ...
>
> >
> >  # for testing enums
> >  { 'struct': 'NestedEnumsOne',
> > @@ -77,7 +77,7 @@
> >  { 'union': 'UserDefFlatUnion',
> >    'base': 'UserDefUnionBase',   # intentional forward reference
> >    'discriminator': 'enum1',
> > -  'data': { 'value1' : 'UserDefA',
> > +  'data': { 'value1' : {'type': 'UserDefA'},
> >              'value2' : 'UserDefB',
> >              'value3' : 'UserDefB'
> >              # 'value4' defaults to empty
>
> ... flat union member, ...
>
> > @@ -98,7 +98,7 @@
> >  { 'struct': 'WrapAlternate',
> >    'data': { 'alt': 'UserDefAlternate' } }
> >  { 'alternate': 'UserDefAlternate',
> > -  'data': { 'udfu': 'UserDefFlatUnion', 'e': 'EnumOne', 'i': 'int',
> > +  'data': { 'udfu': {'type': 'UserDefFlatUnion'}, 'e': 'EnumOne', 'i':=
 'int',
> >              'n': 'null' } }
> >
>
> ... alternate member, ...
>
> >  { 'struct': 'UserDefC',
> > @@ -134,7 +134,7 @@
> >  { 'command': 'user_def_cmd', 'data': {} }
> >  { 'command': 'user_def_cmd1', 'data': {'ud1a': 'UserDefOne'} }
> >  { 'command': 'user_def_cmd2',
> > -  'data': {'ud1a': 'UserDefOne', '*ud1b': 'UserDefOne'},
> > +  'data': {'ud1a': {'type': 'UserDefOne'}, '*ud1b': 'UserDefOne'},
> >    'returns': 'UserDefTwo' }
> >
>
> ... command argument, ...
>
> >  # Returning a non-dictionary requires a name from the whitelist
> > @@ -164,7 +164,7 @@
> >
> >  # testing event
> >  { 'struct': 'EventStructOne',
> > -  'data': { 'struct1': 'UserDefOne', 'string': 'str', '*enum2': 'EnumO=
ne' } }
> > +  'data': { 'struct1': {'type': 'UserDefOne'}, 'string': 'str', '*enum=
2': 'EnumOne' } }
> >
> >  { 'event': 'EVENT_A' }
> >  { 'event': 'EVENT_B',
>
> ... and event argument.
>
> Missing: simple union.  Okay because the desugaring is oblivious of the
> difference between flat and simple unions.
>
> > diff --git a/tests/qapi-schema/struct-member-invalid-dict.err b/tests/q=
api-schema/struct-member-invalid-dict.err
> > new file mode 100644
> > index 0000000000..6a765bc668
> > --- /dev/null
> > +++ b/tests/qapi-schema/struct-member-invalid-dict.err
> > @@ -0,0 +1 @@
> > +tests/qapi-schema/struct-member-invalid-dict.json:2: Key 'type' is mis=
sing from member '*a' of 'data' for struct 'foo'
> > diff --git a/tests/qapi-schema/struct-member-invalid-dict.exit b/tests/=
qapi-schema/struct-member-invalid-dict.exit
> > new file mode 100644
> > index 0000000000..d00491fd7e
> > --- /dev/null
> > +++ b/tests/qapi-schema/struct-member-invalid-dict.exit
> > @@ -0,0 +1 @@
> > +1
> > diff --git a/tests/qapi-schema/struct-member-invalid-dict.json b/tests/=
qapi-schema/struct-member-invalid-dict.json
> > new file mode 100644
> > index 0000000000..ebd9733b49
> > --- /dev/null
> > +++ b/tests/qapi-schema/struct-member-invalid-dict.json
> > @@ -0,0 +1,3 @@
> > +# exploded member form must have a 'type'
>
> Suggest
>
>    # Long form of member must have a value member 'type'
>

ok

> or simply
>
>    # Missing type
>
> > +{ 'struct': 'foo',
> > +  'data': { '*a': { 'case': 'foo' } } }
> > diff --git a/tests/qapi-schema/struct-member-invalid-dict.out b/tests/q=
api-schema/struct-member-invalid-dict.out
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/qapi-schema/union-branch-invalid-dict.err b/tests/qa=
pi-schema/union-branch-invalid-dict.err
> > new file mode 100644
> > index 0000000000..89f9b36791
> > --- /dev/null
> > +++ b/tests/qapi-schema/union-branch-invalid-dict.err
> > @@ -0,0 +1 @@
> > +tests/qapi-schema/union-branch-invalid-dict.json:2: Key 'type' is miss=
ing from member 'integer' of union 'UnionInvalidBranch'
> > diff --git a/tests/qapi-schema/union-branch-invalid-dict.exit b/tests/q=
api-schema/union-branch-invalid-dict.exit
> > new file mode 100644
> > index 0000000000..d00491fd7e
> > --- /dev/null
> > +++ b/tests/qapi-schema/union-branch-invalid-dict.exit
> > @@ -0,0 +1 @@
> > +1
> > diff --git a/tests/qapi-schema/union-branch-invalid-dict.json b/tests/q=
api-schema/union-branch-invalid-dict.json
> > new file mode 100644
> > index 0000000000..19c5d9cacd
> > --- /dev/null
> > +++ b/tests/qapi-schema/union-branch-invalid-dict.json
> > @@ -0,0 +1,4 @@
> > +# exploded member form must have a 'type'
>
> Likewise.
>
> > +{ 'union': 'UnionInvalidBranch',
> > +  'data': { 'integer': { 'if': 'foo'},
> > +            's8': 'int8' } }
>
> I avoid simple unions like the plague.  That said, having one here is
> tolerable; we'll just have to replace it when we abolish simple unions.
>
> > diff --git a/tests/qapi-schema/union-branch-invalid-dict.out b/tests/qa=
pi-schema/union-branch-invalid-dict.out
> > new file mode 100644
> > index 0000000000..e69de29bb2
