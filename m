Received: from eggs.gnu.org ([2001:4830:134:3::10]:42821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fWL70-0000v1-SQ
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fWL6z-00026m-4p
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:24:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45150 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fWL6y-00026X-UD
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:24:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 91C637CBBA
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 12:24:20 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
	<20180321115211.17937-17-marcandre.lureau@redhat.com>
Date: Fri, 22 Jun 2018 14:24:17 +0200
In-Reply-To: <20180321115211.17937-17-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 21 Mar 2018
	12:51:38 +0100")
Message-ID: <87602bc8lq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 16/49] qapi: rename
 QAPISchemaEnumType.values to .members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Rename QAPISchemaEnumType.values and related variables to members.
> Makes sense ever since commit 93bda4dd4 changed .values from list of
> string to list of QAPISchemaMember. Obvious no-op.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

I agree with renaming @values to @members where it's a list of
QAPISchemaMembers.

> ---
>  scripts/qapi/common.py         | 36 +++++++++++++++++-----------------
>  scripts/qapi/doc.py            |  2 +-
>  scripts/qapi/introspect.py     |  4 ++--
>  scripts/qapi/types.py          |  6 +++---
>  scripts/qapi/visit.py          |  2 +-
>  tests/qapi-schema/test-qapi.py |  4 ++--
>  6 files changed, 27 insertions(+), 27 deletions(-)
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index 68a567f53f..ea5cdfe3be 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -1068,7 +1068,7 @@ class QAPISchemaVisitor(object):
>      def visit_builtin_type(self, name, info, json_type):
>          pass
>=20=20
> -    def visit_enum_type(self, name, info, ifcond, values, prefix):
> +    def visit_enum_type(self, name, info, ifcond, members, prefix):

This one is still a list of strings.  The next patch changes it to list
of QAPISchemaMembers, and that's when it should be renamed.

>          pass
>=20=20
>      def visit_array_type(self, name, info, ifcond, element_type):
> @@ -1166,22 +1166,22 @@ class QAPISchemaBuiltinType(QAPISchemaType):
>=20=20
>=20=20
>  class QAPISchemaEnumType(QAPISchemaType):
> -    def __init__(self, name, info, doc, ifcond, values, prefix):
> +    def __init__(self, name, info, doc, ifcond, members, prefix):
>          QAPISchemaType.__init__(self, name, info, doc, ifcond)
> -        for v in values:
> -            assert isinstance(v, QAPISchemaMember)
> -            v.set_owner(name)
> +        for m in members:
> +            assert isinstance(m, QAPISchemaMember)
> +            m.set_owner(name)
>          assert prefix is None or isinstance(prefix, str)
> -        self.values =3D values
> +        self.members =3D members
>          self.prefix =3D prefix
>=20=20
>      def check(self, schema):
>          QAPISchemaType.check(self, schema)
>          seen =3D {}
> -        for v in self.values:
> -            v.check_clash(self.info, seen)
> +        for m in self.members:
> +            m.check_clash(self.info, seen)
>              if self.doc:
> -                self.doc.connect_member(v)
> +                self.doc.connect_member(m)
>=20=20
>      def is_implicit(self):
>          # See QAPISchema._make_implicit_enum_type() and ._def_predefined=
s()
> @@ -1191,7 +1191,7 @@ class QAPISchemaEnumType(QAPISchemaType):
>          return c_name(self.name)
>=20=20
>      def member_names(self):
> -        return [v.name for v in self.values]
> +        return [m.name for m in self.members]
>=20=20
>      def json_type(self):
>          return 'string'
> @@ -1999,19 +1999,19 @@ def wrap_ifcond(ifcond, before, after):
>      return out
>=20=20
>=20=20
> -def gen_enum_lookup(name, values, prefix=3DNone):
> +def gen_enum_lookup(name, members, prefix=3DNone):

Likewise.

>      ret =3D mcgen('''
>=20=20
>  const QEnumLookup %(c_name)s_lookup =3D {
>      .array =3D (const char *const[]) {
>  ''',
>                  c_name=3Dc_name(name))
> -    for value in values:
> -        index =3D c_enum_const(name, value, prefix)
> +    for m in members:
> +        index =3D c_enum_const(name, m, prefix)
>          ret +=3D mcgen('''
>          [%(index)s] =3D "%(value)s",
>  ''',
> -                     index=3Dindex, value=3Dvalue)
> +                     index=3Dindex, value=3Dm)
>=20=20
>      ret +=3D mcgen('''
>      },
> @@ -2022,9 +2022,9 @@ const QEnumLookup %(c_name)s_lookup =3D {
>      return ret
>=20=20
>=20=20
> -def gen_enum(name, values, prefix=3DNone):
> +def gen_enum(name, members, prefix=3DNone):

Likewise.

>      # append automatically generated _MAX value
> -    enum_values =3D values + ['_MAX']
> +    enum_members =3D members + ['_MAX']
>=20=20
>      ret =3D mcgen('''
>=20=20
> @@ -2032,11 +2032,11 @@ typedef enum %(c_name)s {
>  ''',
>                  c_name=3Dc_name(name))
>=20=20
> -    for value in enum_values:
> +    for m in enum_members:
>          ret +=3D mcgen('''
>      %(c_enum)s,
>  ''',
> -                     c_enum=3Dc_enum_const(name, value, prefix))
> +                     c_enum=3Dc_enum_const(name, m, prefix))
>=20=20
>      ret +=3D mcgen('''
>  } %(c_name)s;
> diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
> index d5cfd2336b..6c2bf98e1d 100755
> --- a/scripts/qapi/doc.py
> +++ b/scripts/qapi/doc.py
> @@ -204,7 +204,7 @@ class QAPISchemaGenDocVisitor(qapi.common.QAPISchemaV=
isitor):
>      def write(self, output_dir):
>          self._gen.write(output_dir, self._prefix + 'qapi-doc.texi')
>=20=20
> -    def visit_enum_type(self, name, info, ifcond, values, prefix):
> +    def visit_enum_type(self, name, info, ifcond, members, prefix):
>          doc =3D self.cur_doc
>          self._gen.add(TYPE_FMT(type=3D'Enum',
>                                 name=3Ddoc.symbol,

Likewise.  More of the same below.

> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> index cb4825f134..66f7fd00a9 100644
> --- a/scripts/qapi/introspect.py
> +++ b/scripts/qapi/introspect.py
> @@ -163,8 +163,8 @@ const QLitObject %(c_name)s =3D %(c_string)s;
>      def visit_builtin_type(self, name, info, json_type):
>          self._gen_qlit(name, 'builtin', {'json-type': json_type}, [])
>=20=20
> -    def visit_enum_type(self, name, info, ifcond, values, prefix):
> -        self._gen_qlit(name, 'enum', {'values': values}, ifcond)
> +    def visit_enum_type(self, name, info, ifcond, members, prefix):
> +        self._gen_qlit(name, 'enum', {'values': members}, ifcond)
>=20=20
>      def visit_array_type(self, name, info, ifcond, element_type):
>          element =3D self._use_type(element_type)
> diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
> index ce4c91206c..5b790cb41d 100644
> --- a/scripts/qapi/types.py
> +++ b/scripts/qapi/types.py
> @@ -213,10 +213,10 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVi=
sitor):
>              self._genh.add(gen_type_cleanup_decl(name))
>              self._genc.add(gen_type_cleanup(name))
>=20=20
> -    def visit_enum_type(self, name, info, ifcond, values, prefix):
> +    def visit_enum_type(self, name, info, ifcond, members, prefix):
>          with ifcontext(ifcond, self._genh, self._genc):
> -            self._genh.preamble_add(gen_enum(name, values, prefix))
> -            self._genc.add(gen_enum_lookup(name, values, prefix))
> +            self._genh.preamble_add(gen_enum(name, members, prefix))
> +            self._genc.add(gen_enum_lookup(name, members, prefix))
>=20=20
>      def visit_array_type(self, name, info, ifcond, element_type):
>          with ifcontext(ifcond, self._genh):
> diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
> index e4a62ce030..ee776386ae 100644
> --- a/scripts/qapi/visit.py
> +++ b/scripts/qapi/visit.py
> @@ -301,7 +301,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCVis=
itor):
>  ''',
>                                        types=3Dtypes))
>=20=20
> -    def visit_enum_type(self, name, info, ifcond, values, prefix):
> +    def visit_enum_type(self, name, info, ifcond, members, prefix):
>          with ifcontext(ifcond, self._genh, self._genc):
>              self._genh.add(gen_visit_decl(name, scalar=3DTrue))
>              self._genc.add(gen_visit_enum(name))
> diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
> index 6d25a37dda..f4b8feb9bc 100644
> --- a/tests/qapi-schema/test-qapi.py
> +++ b/tests/qapi-schema/test-qapi.py
> @@ -23,8 +23,8 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
>      def visit_include(self, name, info):
>          print('include %s' % name)
>=20=20
> -    def visit_enum_type(self, name, info, ifcond, values, prefix):
> -        print('enum %s %s' % (name, values))
> +    def visit_enum_type(self, name, info, ifcond, members, prefix):
> +        print('enum %s %s' % (name, members))
>          if prefix:
>              print('    prefix %s' % prefix)
>          self._print_if(ifcond)
