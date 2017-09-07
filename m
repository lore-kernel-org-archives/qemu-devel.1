Received: from eggs.gnu.org ([2001:4830:134:3::10]:54539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpxlQ-0006HR-FG
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:26:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpxlL-0001lP-F3
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:26:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dpxlL-0001kq-6a
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:26:35 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-33-marcandre.lureau@redhat.com>
Date: Thu, 07 Sep 2017 16:26:30 +0200
In-Reply-To: <20170822132255.23945-33-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 22 Aug 2017
	15:22:33 +0200")
Message-ID: <87fuby60vd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 32/54] qapi: add 'if' to struct members
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi.py                         | 18 ++++++++++++++----
>  tests/qapi-schema/qapi-schema-test.json |  9 ++++++---
>  tests/qapi-schema/qapi-schema-test.out  |  4 +++-
>  tests/qapi-schema/test-qapi.py          |  3 ++-
>  4 files changed, 25 insertions(+), 9 deletions(-)
>
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 201e425842..946df83854 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -678,7 +678,13 @@ def check_type(info, source, value, allow_array=3DFa=
lse,
>          return
>=20=20
>      if not allow_dict:
> -        raise QAPISemError(info, "%s should be a type name" % source)
> +        if isinstance(value, dict) and 'type' in value:

"not allow_dict" has become a lie:=20

Not your patch's fault: we sometimes check for dict, and sometimes for
OrderedDict.  If there's a reason, it's not obvious.  If there isn't, we
should be more consistent.

> +            check_type(info, source, value['type'], allow_array,
> +                       allow_dict, allow_optional, allow_metas)
> +            check_if(value, info)

Where are dictionary keys other than 'type' and 'if' rejected?

> +            return
> +        else:
> +            raise QAPISemError(info, "%s should be a type name" % source)
>=20=20
>      if not isinstance(value, OrderedDict):
>          raise QAPISemError(info,

check_type() is used all over the place.  Your commit message claims
that your patch only affects struct members.  That's not obvious, so
down I go the next rabbit hole you present me :)

First: no change unless allow_dict.  Let's review the callers that pass
allow_dict=3DTrue.

* check_command() for arguments when not boxed

* check_event() for arguments when not boxed

* check_union() for a flat union's base

* check_struct() for the struct's members

As far as I can tell, these all accept {'type': TYPE-NAME, 'if': 'COND'}
in addition to TYPE-NAME as values in their dictionaries.  That's not
what the commit message claims.  Which one needs fixing, commit message
or code?

I guess it's the commit message, because we want to support 'if' in all
these places, don't we?

> @@ -1332,8 +1338,8 @@ class QAPISchemaMember(object):
>=20=20
>=20=20
>  class QAPISchemaObjectTypeMember(QAPISchemaMember):
> -    def __init__(self, name, typ, optional):
> -        QAPISchemaMember.__init__(self, name)
> +    def __init__(self, name, typ, optional, ifcond=3DNone):
> +        QAPISchemaMember.__init__(self, name, ifcond)
>          assert isinstance(typ, str)
>          assert isinstance(optional, bool)
>          self._type_name =3D typ
> @@ -1612,13 +1618,17 @@ class QAPISchema(object):
>=20=20
>      def _make_member(self, name, typ, info):
>          optional =3D False
> +        ifcond =3D None
>          if name.startswith('*'):
>              name =3D name[1:]
>              optional =3D True
> +        if isinstance(typ, dict):
> +            ifcond =3D typ.get('if')
> +            typ =3D typ['type']
>          if isinstance(typ, list):
>              assert len(typ) =3D=3D 1
>              typ =3D self._make_array_type(typ[0], info)
> -        return QAPISchemaObjectTypeMember(name, typ, optional)
> +        return QAPISchemaObjectTypeMember(name, typ, optional, ifcond)
>=20=20
>      def _make_members(self, data, info):
>          return [self._make_member(key, value, info)

We call _make_members() for exactly the four things I enumerated above:
command arguments, event arguments, flat union's base, struct members.
Good.

> diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
> index ad2b405d83..b136e4855f 100644
> --- a/tests/qapi-schema/qapi-schema-test.json
> +++ b/tests/qapi-schema/qapi-schema-test.json
> @@ -191,7 +191,8 @@
>=20=20
>  # test 'if' condition handling
>=20=20
> -{ 'struct': 'TestIfStruct', 'data': { 'foo': 'int' },
> +{ 'struct': 'TestIfStruct', 'data':
> +  { 'foo': 'int', 'bar': { 'type': 'int', 'if': 'defined(TEST_IF_STRUCT_=
BAR)'} },

Long line, suggest to break it before 'bar'.

>    'if': 'defined(TEST_IF_STRUCT)' }
>=20=20
>  { 'enum': 'TestIfEnum', 'data':
> @@ -204,8 +205,10 @@
>  { 'alternate': 'TestIfAlternate', 'data': { 'foo': 'int', 'bar': 'TestSt=
ruct' },
>    'if': 'defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)' }
>=20=20
> -{ 'command': 'TestIfCmd', 'data': { 'foo': 'TestIfStruct', 'bar': 'TestI=
fEnum' },
> +{ 'command': 'TestIfCmd', 'data':
> +  { 'foo': 'TestIfStruct', 'bar': { 'type': 'TestIfEnum', 'if': 'defined=
(TEST_IF_CMD_BAR)' } },

Likewise.

>    'if': 'defined(TEST_IF_CMD) && defined(TEST_IF_STRUCT)' }
>=20=20
> -{ 'event': 'TestIfEvent', 'data': { 'foo': 'TestIfStruct' },
> +{ 'event': 'TestIfEvent', 'data':
> +  { 'foo': 'TestIfStruct', 'bar': { 'type': 'TestIfEnum', 'if': 'defined=
(TEST_IF_EVT_BAR)' } },

Likewise.

>    'if': 'defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)' }
> diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
> index 211c367632..5d2f18e4aa 100644
> --- a/tests/qapi-schema/qapi-schema-test.out
> +++ b/tests/qapi-schema/qapi-schema-test.out
> @@ -67,6 +67,7 @@ event TestIfEvent q_obj_TestIfEvent-arg
>      if defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)
>  object TestIfStruct
>      member foo: int optional=3DFalse
> +    member bar: int optional=3DFalse if=3Ddefined(TEST_IF_STRUCT_BAR)
>      if defined(TEST_IF_STRUCT)
>  object TestIfUnion
>      member type: TestIfUnionKind optional=3DFalse
> @@ -197,10 +198,11 @@ object q_obj_EVENT_D-arg
>      member enum3: EnumOne optional=3DTrue
>  object q_obj_TestIfCmd-arg
>      member foo: TestIfStruct optional=3DFalse
> -    member bar: TestIfEnum optional=3DFalse
> +    member bar: TestIfEnum optional=3DFalse if=3Ddefined(TEST_IF_CMD_BAR)
>      if defined(TEST_IF_CMD) && defined(TEST_IF_STRUCT)
>  object q_obj_TestIfEvent-arg
>      member foo: TestIfStruct optional=3DFalse
> +    member bar: TestIfEnum optional=3DFalse if=3Ddefined(TEST_IF_EVT_BAR)
>      if defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)
>  object q_obj_TestStruct-wrapper
>      member data: TestStruct optional=3DFalse
> diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
> index 70054848f0..5d2f67a1d3 100644
> --- a/tests/qapi-schema/test-qapi.py
> +++ b/tests/qapi-schema/test-qapi.py
> @@ -31,7 +31,8 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
>              print '    base %s' % base.name
>          for m in members:
>              print '    member %s: %s optional=3D%s' % \
> -                (m.name, m.type.name, m.optional)
> +                (m.name, m.type.name, m.optional) + \
> +                (' if=3D%s' % m.ifcond if m.ifcond else '')

Let's keep it simple & stupid:

               print '    member %s: %s optional=3D%s if=3D%s' % \
                   (m.name, m.type.name, m.optional, m.ifcond)

>          self._print_variants(variants)
>          self._print_if(ifcond)

Need negative tests, but I guess they're next.
