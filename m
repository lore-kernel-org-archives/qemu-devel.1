Received: from eggs.gnu.org ([2001:4830:134:3::10]:40154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpXys-0000Bm-PU
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 06:54:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpXyp-0007Y9-L0
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 06:54:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dpXyp-0007Xh-Cw
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 06:54:47 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-26-marcandre.lureau@redhat.com>
Date: Wed, 06 Sep 2017 12:54:41 +0200
In-Reply-To: <20170822132255.23945-26-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 22 Aug 2017
	15:22:26 +0200")
Message-ID: <87efrk85ce.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 25/54] qapi-visit: add #if conditions to
 visitors
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

> Wrap generated code with #if/#endif using the ifcond_decorator.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi-visit.py | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
> index c29c2d869e..bb18c9edee 100644
> --- a/scripts/qapi-visit.py
> +++ b/scripts/qapi-visit.py
> @@ -267,6 +267,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
>          self.decl =3D None
>          self.defn =3D None
>          self._btin =3D None
> +        self.if_members =3D ['decl', 'defn', '_btin']
>=20=20
>      def visit_begin(self, schema):
>          self.decl =3D ''
> @@ -282,6 +283,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
>          self.decl =3D self._btin + self.decl
>          self._btin =3D None
>=20=20
> +    @ifcond_decorator
>      def visit_enum_type(self, name, info, values, prefix, ifcond):
>          # Special case for our lone builtin enum type
>          # TODO use something cleaner than existence of info
> @@ -293,6 +295,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
>              self.decl +=3D gen_visit_decl(name, scalar=3DTrue)
>              self.defn +=3D gen_visit_enum(name)
>=20=20
> +    @ifcond_decorator
>      def visit_array_type(self, name, info, element_type, ifcond):
>          decl =3D gen_visit_decl(name)
>          defn =3D gen_visit_list(name, element_type)
> @@ -304,6 +307,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
>              self.decl +=3D decl
>              self.defn +=3D defn
>=20=20
> +    @ifcond_decorator
>      def visit_object_type(self, name, info, base, members, variants, ifc=
ond):
>          # Nothing to do for the special empty builtin
>          if name =3D=3D 'q_empty':
> @@ -317,6 +321,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
>              self.decl +=3D gen_visit_decl(name)
>              self.defn +=3D gen_visit_object(name, base, members, variant=
s)
>=20=20
> +    @ifcond_decorator
>      def visit_alternate_type(self, name, info, variants, ifcond):
>          self.decl +=3D gen_visit_decl(name)
>          self.defn +=3D gen_visit_alternate(name, variants)

make check fails to compile, first error:

make -C ~/work/qemu/bld-x86/ check
make: Entering directory '/work/armbru/qemu/bld-x86'
[...]
  GEN     tests/test-qapi-types.c
  CC      tests/test-qapi-types.o
tests/test-qapi-types.c: In function =E2=80=98qapi_free_TestIfAlternate=E2=
=80=99:
tests/test-qapi-types.c:190:5: warning: implicit declaration of function =
=E2=80=98visit_type_TestIfAlternate=E2=80=99; did you mean =E2=80=98visit_t=
ype_UserDefAlternate=E2=80=99? [-Wimplicit-function-declaration]
     visit_type_TestIfAlternate(v, NULL, &obj, NULL);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~
     visit_type_UserDefAlternate
tests/test-qapi-types.c:190:5: warning: nested extern declaration of =E2=80=
=98visit_type_TestIfAlternate=E2=80=99 [-Wnested-externs]
tests/test-qapi-types.c: In function =E2=80=98qapi_free_TestIfStruct=E2=80=
=99:
tests/test-qapi-types.c:213:5: warning: implicit declaration of function =
=E2=80=98visit_type_TestIfStruct=E2=80=99; did you mean =E2=80=98visit_type=
_TestStruct=E2=80=99? [-Wimplicit-function-declaration]
     visit_type_TestIfStruct(v, NULL, &obj, NULL);
     ^~~~~~~~~~~~~~~~~~~~~~~
     visit_type_TestStruct
tests/test-qapi-types.c:213:5: warning: nested extern declaration of =E2=80=
=98visit_type_TestIfStruct=E2=80=99 [-Wnested-externs]
tests/test-qapi-types.c: In function =E2=80=98qapi_free_TestIfUnion=E2=80=
=99:
tests/test-qapi-types.c:226:5: warning: implicit declaration of function =
=E2=80=98visit_type_TestIfUnion=E2=80=99; did you mean =E2=80=98visit_type_=
TestStruct=E2=80=99? [-Wimplicit-function-declaration]
     visit_type_TestIfUnion(v, NULL, &obj, NULL);
     ^~~~~~~~~~~~~~~~~~~~~~
     visit_type_TestStruct
tests/test-qapi-types.c:226:5: warning: nested extern declaration of =E2=80=
=98visit_type_TestIfUnion=E2=80=99 [-Wnested-externs]
  GEN     tests/test-qapi-event.c
  CC      tests/test-qapi-event.o
  GEN     tests/test-qmp-introspect.c
  CC      tests/test-qmp-introspect.o
  LINK    tests/test-qobject-output-visitor
tests/test-qapi-types.o: In function `qapi_free_TestIfAlternate':
/work/armbru/qemu/bld-x86/tests/test-qapi-types.c:190: undefined reference =
to `visit_type_TestIfAlternate'
tests/test-qapi-types.o: In function `qapi_free_TestIfStruct':
test-qapi-types.c:(.text+0x361): undefined reference to `visit_type_TestIfS=
truct'
tests/test-qapi-types.o: In function `qapi_free_TestIfUnion':
test-qapi-types.c:(.text+0x3af): undefined reference to `visit_type_TestIfU=
nion'
collect2: error: ld returned 1 exit status
make: *** [/work/armbru/qemu/rules.mak:121: tests/test-qobject-output-visit=
or] Error 1
make: Leaving directory '/work/armbru/qemu/bld-x86'
