Received: from eggs.gnu.org ([2001:4830:134:3::10]:57942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dpbDw-0004U6-HD
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:22:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dpbDs-0002bc-V9
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:22:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dpbDs-0002ab-N9
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:22:32 -0400
Date: Wed, 6 Sep 2017 10:22:31 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <548852672.9319673.1504707751479.JavaMail.zimbra@redhat.com>
In-Reply-To: <87efrk85ce.fsf@dusky.pond.sub.org>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-26-marcandre.lureau@redhat.com>
	<87efrk85ce.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>



----- Original Message -----
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>=20
> > Wrap generated code with #if/#endif using the ifcond_decorator.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  scripts/qapi-visit.py | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
> > index c29c2d869e..bb18c9edee 100644
> > --- a/scripts/qapi-visit.py
> > +++ b/scripts/qapi-visit.py
> > @@ -267,6 +267,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
> >          self.decl =3D None
> >          self.defn =3D None
> >          self._btin =3D None
> > +        self.if_members =3D ['decl', 'defn', '_btin']
> > =20
> >      def visit_begin(self, schema):
> >          self.decl =3D ''
> > @@ -282,6 +283,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
> >          self.decl =3D self._btin + self.decl
> >          self._btin =3D None
> > =20
> > +    @ifcond_decorator
> >      def visit_enum_type(self, name, info, values, prefix, ifcond):
> >          # Special case for our lone builtin enum type
> >          # TODO use something cleaner than existence of info
> > @@ -293,6 +295,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
> >              self.decl +=3D gen_visit_decl(name, scalar=3DTrue)
> >              self.defn +=3D gen_visit_enum(name)
> > =20
> > +    @ifcond_decorator
> >      def visit_array_type(self, name, info, element_type, ifcond):
> >          decl =3D gen_visit_decl(name)
> >          defn =3D gen_visit_list(name, element_type)
> > @@ -304,6 +307,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
> >              self.decl +=3D decl
> >              self.defn +=3D defn
> > =20
> > +    @ifcond_decorator
> >      def visit_object_type(self, name, info, base, members, variants,
> >      ifcond):
> >          # Nothing to do for the special empty builtin
> >          if name =3D=3D 'q_empty':
> > @@ -317,6 +321,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
> >              self.decl +=3D gen_visit_decl(name)
> >              self.defn +=3D gen_visit_object(name, base, members, varia=
nts)
> > =20
> > +    @ifcond_decorator
> >      def visit_alternate_type(self, name, info, variants, ifcond):
> >          self.decl +=3D gen_visit_decl(name)
> >          self.defn +=3D gen_visit_alternate(name, variants)
>=20
> make check fails to compile, first error:
>=20

I'll merge back qapi-types & qapi-visited #if addition (regression from the=
 split).=20

> make -C ~/work/qemu/bld-x86/ check
> make: Entering directory '/work/armbru/qemu/bld-x86'
> [...]
>   GEN     tests/test-qapi-types.c
>   CC      tests/test-qapi-types.o
> tests/test-qapi-types.c: In function =E2=80=98qapi_free_TestIfAlternate=
=E2=80=99:
> tests/test-qapi-types.c:190:5: warning: implicit declaration of function
> =E2=80=98visit_type_TestIfAlternate=E2=80=99; did you mean =E2=80=98visit=
_type_UserDefAlternate=E2=80=99?
> [-Wimplicit-function-declaration]
>      visit_type_TestIfAlternate(v, NULL, &obj, NULL);
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~
>      visit_type_UserDefAlternate
> tests/test-qapi-types.c:190:5: warning: nested extern declaration of
> =E2=80=98visit_type_TestIfAlternate=E2=80=99 [-Wnested-externs]
> tests/test-qapi-types.c: In function =E2=80=98qapi_free_TestIfStruct=E2=
=80=99:
> tests/test-qapi-types.c:213:5: warning: implicit declaration of function
> =E2=80=98visit_type_TestIfStruct=E2=80=99; did you mean =E2=80=98visit_ty=
pe_TestStruct=E2=80=99?
> [-Wimplicit-function-declaration]
>      visit_type_TestIfStruct(v, NULL, &obj, NULL);
>      ^~~~~~~~~~~~~~~~~~~~~~~
>      visit_type_TestStruct
> tests/test-qapi-types.c:213:5: warning: nested extern declaration of
> =E2=80=98visit_type_TestIfStruct=E2=80=99 [-Wnested-externs]
> tests/test-qapi-types.c: In function =E2=80=98qapi_free_TestIfUnion=E2=80=
=99:
> tests/test-qapi-types.c:226:5: warning: implicit declaration of function
> =E2=80=98visit_type_TestIfUnion=E2=80=99; did you mean =E2=80=98visit_typ=
e_TestStruct=E2=80=99?
> [-Wimplicit-function-declaration]
>      visit_type_TestIfUnion(v, NULL, &obj, NULL);
>      ^~~~~~~~~~~~~~~~~~~~~~
>      visit_type_TestStruct
> tests/test-qapi-types.c:226:5: warning: nested extern declaration of
> =E2=80=98visit_type_TestIfUnion=E2=80=99 [-Wnested-externs]
>   GEN     tests/test-qapi-event.c
>   CC      tests/test-qapi-event.o
>   GEN     tests/test-qmp-introspect.c
>   CC      tests/test-qmp-introspect.o
>   LINK    tests/test-qobject-output-visitor
> tests/test-qapi-types.o: In function `qapi_free_TestIfAlternate':
> /work/armbru/qemu/bld-x86/tests/test-qapi-types.c:190: undefined referenc=
e to
> `visit_type_TestIfAlternate'
> tests/test-qapi-types.o: In function `qapi_free_TestIfStruct':
> test-qapi-types.c:(.text+0x361): undefined reference to
> `visit_type_TestIfStruct'
> tests/test-qapi-types.o: In function `qapi_free_TestIfUnion':
> test-qapi-types.c:(.text+0x3af): undefined reference to
> `visit_type_TestIfUnion'
> collect2: error: ld returned 1 exit status
> make: *** [/work/armbru/qemu/rules.mak:121:
> tests/test-qobject-output-visitor] Error 1
> make: Leaving directory '/work/armbru/qemu/bld-x86'
>=20
