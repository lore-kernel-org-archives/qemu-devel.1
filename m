Received: from eggs.gnu.org ([2001:4830:134:3::10]:60692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gVaei-0000H3-SF
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:20:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gVaed-0005Ls-AJ
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:20:20 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gVaed-0005Li-4y
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:20:15 -0500
Received: by mail-qt1-f196.google.com with SMTP id d19so7418059qtq.9
	for <qemu-devel@nongnu.org>; Sat, 08 Dec 2018 03:20:15 -0800 (PST)
MIME-Version: 1.0
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
	<20180706105753.26700-21-marcandre.lureau@redhat.com>
	<87woom8v6i.fsf@dusky.pond.sub.org>
In-Reply-To: <87woom8v6i.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 8 Dec 2018 15:20:03 +0400
Message-ID: <CAMxuvazmSM7ir=-BW2=828T2LNJdw7QXCva+oOifx6QgxGnqhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 20/27] qapi: add 'if' to alternate
 members
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
On Thu, Dec 6, 2018 at 8:41 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Add 'if' key to alternate members:
> >
> > { 'alternate': 'TestIfAlternate', 'data':
> >   { 'alt': { 'type': 'TestStruct', 'if': 'COND' } } }
> >
> > Generated code is not changed by this patch but with "qapi: add #if
> > conditions to generated code".
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  scripts/qapi/common.py                  | 10 +++++-----
> >  tests/qapi-schema/qapi-schema-test.json |  6 +++++-
> >  tests/qapi-schema/qapi-schema-test.out  |  9 ++++++++-
> >  3 files changed, 18 insertions(+), 7 deletions(-)
> >
> > diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> > index e1bd9a22ba..b3b64a60bf 100644
> > --- a/scripts/qapi/common.py
> > +++ b/scripts/qapi/common.py
> > @@ -843,7 +843,7 @@ def check_alternate(expr, info):
> >      for (key, value) in members.items():
> >          check_name(info, "Member of alternate '%s'" % name, key)
> >          source =3D "member '%s' of alternate '%s'" % (key, name)
> > -        check_known_keys(info, source, value, ['type'], [])
> > +        check_known_keys(info, source, value, ['type'], ['if'])
> >          typ =3D value['type']
> >
> >          # Ensure alternates have no type conflicts.
> > @@ -1774,8 +1774,8 @@ class QAPISchema(object):
> >                                                self._make_members(data,=
 info),
> >                                                None))
> >
> > -    def _make_variant(self, case, typ):
> > -        return QAPISchemaObjectTypeVariant(case, typ)
> > +    def _make_variant(self, case, typ, ifcond):
> > +        return QAPISchemaObjectTypeVariant(case, typ, ifcond)
> >
> >      def _make_simple_variant(self, case, typ, ifcond, info):
> >          if isinstance(typ, list):
> > @@ -1798,7 +1798,7 @@ class QAPISchema(object):
> >                  name, info, doc, ifcond,
> >                  'base', self._make_members(base, info))
> >          if tag_name:
> > -            variants =3D [self._make_variant(key, value['type'])
> > +            variants =3D [self._make_variant(key, value['type'], value=
.get('if'))
> >                          for (key, value) in data.items()]
> >              members =3D []
> >          else:
> > @@ -1819,7 +1819,7 @@ class QAPISchema(object):
> >          name =3D expr['alternate']
> >          data =3D expr['data']
> >          ifcond =3D expr.get('if')
> > -        variants =3D [self._make_variant(key, value['type'])
> > +        variants =3D [self._make_variant(key, value['type'], value.get=
('if'))
> >                      for (key, value) in data.items()]
> >          tag_member =3D QAPISchemaObjectTypeMember('type', 'QType', Fal=
se)
> >          self._def_entity(
> > diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schem=
a/qapi-schema-test.json
> > index 6d3c6c0b53..df3edf9d89 100644
> > --- a/tests/qapi-schema/qapi-schema-test.json
> > +++ b/tests/qapi-schema/qapi-schema-test.json
> > @@ -216,9 +216,13 @@
> >  { 'command': 'TestIfUnionCmd', 'data': { 'union_cmd_arg': 'TestIfUnion=
' },
> >    'if': 'defined(TEST_IF_UNION)' }
> >
> > -{ 'alternate': 'TestIfAlternate', 'data': { 'foo': 'int', 'bar': 'Test=
Struct' },
> > +{ 'alternate': 'TestIfAlternate', 'data':
> > +  { 'foo': 'int', 'alt_bar': { 'type': 'TestStruct', 'if': 'defined(TE=
ST_IF_ALT_BAR)'} },
>
> Let's break the long line betwen the members.

ok

>
> Why rename member 'bar' to 'alt_bar'?

no reason I remember, dropped

>
> >    'if': 'defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)' }
> >
> > +{ 'command': 'TestIfAlternateCmd', 'data': { 'alt_cmd_arg': 'TestIfAlt=
ernate' },
>
> Another long line.  And I'm feeling dense again: why does this change
> belong to this patch?

No reason I remember, let's split it

>
> > +  'if': 'defined(TEST_IF_ALT)' }
> > +
> >  { 'command': 'TestIfCmd', 'data':
> >    { 'foo': 'TestIfStruct',
> >      'bar': { 'type': 'TestIfEnum', 'if': 'defined(TEST_IF_CMD_BAR)' } =
},
> > diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema=
/qapi-schema-test.out
> > index ac1069cf1f..cdbd5b87cc 100644
> > --- a/tests/qapi-schema/qapi-schema-test.out
> > +++ b/tests/qapi-schema/qapi-schema-test.out
> > @@ -297,8 +297,15 @@ command TestIfUnionCmd q_obj_TestIfUnionCmd-arg ->=
 None
> >  alternate TestIfAlternate
> >      tag type
> >      case foo: int
> > -    case bar: TestStruct
> > +    case alt_bar: TestStruct
> > +        if ['defined(TEST_IF_ALT_BAR)']
> >      if ['defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)']
> > +object q_obj_TestIfAlternateCmd-arg
> > +    member alt_cmd_arg: TestIfAlternate optional=3DFalse
> > +    if ['defined(TEST_IF_ALT)']
> > +command TestIfAlternateCmd q_obj_TestIfAlternateCmd-arg -> None
> > +   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse precon=
fig=3DFalse
> > +    if ['defined(TEST_IF_ALT)']
> >  object q_obj_TestIfCmd-arg
> >      member foo: TestIfStruct optional=3DFalse
> >      member bar: TestIfEnum optional=3DFalse
