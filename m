Received: from eggs.gnu.org ([2001:4830:134:3::10]:55245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9JQ-00084P-1j
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:33:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9JP-000739-3u
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:33:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dk9JO-00072J-Th
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:33:43 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:26 +0200
Message-Id: <20170822132255.23945-26-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 25/54] qapi-visit: add #if conditions to
 visitors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Wrap generated code with #if/#endif using the ifcond_decorator.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi-visit.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index c29c2d869e..bb18c9edee 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -267,6 +267,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
         self.decl =3D None
         self.defn =3D None
         self._btin =3D None
+        self.if_members =3D ['decl', 'defn', '_btin']
=20
     def visit_begin(self, schema):
         self.decl =3D ''
@@ -282,6 +283,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
         self.decl =3D self._btin + self.decl
         self._btin =3D None
=20
+    @ifcond_decorator
     def visit_enum_type(self, name, info, values, prefix, ifcond):
         # Special case for our lone builtin enum type
         # TODO use something cleaner than existence of info
@@ -293,6 +295,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
             self.decl +=3D gen_visit_decl(name, scalar=3DTrue)
             self.defn +=3D gen_visit_enum(name)
=20
+    @ifcond_decorator
     def visit_array_type(self, name, info, element_type, ifcond):
         decl =3D gen_visit_decl(name)
         defn =3D gen_visit_list(name, element_type)
@@ -304,6 +307,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
             self.decl +=3D decl
             self.defn +=3D defn
=20
+    @ifcond_decorator
     def visit_object_type(self, name, info, base, members, variants, ifc=
ond):
         # Nothing to do for the special empty builtin
         if name =3D=3D 'q_empty':
@@ -317,6 +321,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
             self.decl +=3D gen_visit_decl(name)
             self.defn +=3D gen_visit_object(name, base, members, variant=
s)
=20
+    @ifcond_decorator
     def visit_alternate_type(self, name, info, variants, ifcond):
         self.decl +=3D gen_visit_decl(name)
         self.defn +=3D gen_visit_alternate(name, variants)
--=20
2.14.1.146.gd35faa819
