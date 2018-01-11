Received: from eggs.gnu.org ([2001:4830:134:3::10]:51568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkWW-0007dZ-U6
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkWR-0004cp-Sx
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkWR-0004ZL-Jm
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:27 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:32 +0100
Message-Id: <20180111213250.16511-34-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 33/51] qapi2texi: add 'If:' section to
 generated documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

The documentation is generated only once, and doesn't know C
pre-conditions. Add 'If:' sections for top-level entities.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi2texi.py            | 23 +++++++++++++----------
 tests/qapi-schema/doc-good.json |  2 +-
 tests/qapi-schema/doc-good.out  |  1 +
 tests/qapi-schema/doc-good.texi |  2 ++
 4 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 755bd2f15d..76c336af34 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -174,7 +174,7 @@ def texi_members(doc, what, base, variants, member_fu=
nc):
     return '\n@b{%s:}\n@table @asis\n%s@end table\n' % (what, items)
=20
=20
-def texi_sections(doc):
+def texi_sections(doc, ifcond):
     """Format additional sections following arguments"""
     body =3D ''
     for section in doc.sections:
@@ -185,14 +185,16 @@ def texi_sections(doc):
             body +=3D texi_example(section.text)
         else:
             body +=3D texi_format(section.text)
+    if ifcond:
+        body +=3D '\n\n@b{If:} @code{%s}' % ", ".join(ifcond)
     return body
=20
=20
-def texi_entity(doc, what, base=3DNone, variants=3DNone,
+def texi_entity(doc, what, ifcond, base=3DNone, variants=3DNone,
                 member_func=3Dtexi_member):
     return (texi_body(doc)
             + texi_members(doc, what, base, variants, member_func)
-            + texi_sections(doc))
+            + texi_sections(doc, ifcond))
=20
=20
 class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor):
@@ -207,7 +209,7 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor)=
:
         doc =3D self.cur_doc
         self.out +=3D TYPE_FMT(type=3D'Enum',
                              name=3Ddoc.symbol,
-                             body=3Dtexi_entity(doc, 'Values',
+                             body=3Dtexi_entity(doc, 'Values', ifcond,
                                               member_func=3Dtexi_enum_va=
lue))
=20
     def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
@@ -216,13 +218,14 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisito=
r):
             base =3D None
         self.out +=3D TYPE_FMT(type=3D'Object',
                              name=3Ddoc.symbol,
-                             body=3Dtexi_entity(doc, 'Members', base, va=
riants))
+                             body=3Dtexi_entity(doc, 'Members', ifcond,
+                                              base, variants))
=20
     def visit_alternate_type(self, name, info, ifcond, variants):
         doc =3D self.cur_doc
         self.out +=3D TYPE_FMT(type=3D'Alternate',
                              name=3Ddoc.symbol,
-                             body=3Dtexi_entity(doc, 'Members'))
+                             body=3Dtexi_entity(doc, 'Members', ifcond))
=20
     def visit_command(self, name, info, ifcond, arg_type, ret_type,
                       gen, success_response, boxed):
@@ -231,9 +234,9 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor)=
:
             body =3D texi_body(doc)
             body +=3D ('\n@b{Arguments:} the members of @code{%s}\n'
                      % arg_type.name)
-            body +=3D texi_sections(doc)
+            body +=3D texi_sections(doc, ifcond)
         else:
-            body =3D texi_entity(doc, 'Arguments')
+            body =3D texi_entity(doc, 'Arguments', ifcond)
         self.out +=3D MSG_FMT(type=3D'Command',
                             name=3Ddoc.symbol,
                             body=3Dbody)
@@ -242,7 +245,7 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor)=
:
         doc =3D self.cur_doc
         self.out +=3D MSG_FMT(type=3D'Event',
                             name=3Ddoc.symbol,
-                            body=3Dtexi_entity(doc, 'Arguments'))
+                            body=3Dtexi_entity(doc, 'Arguments', ifcond)=
)
=20
     def symbol(self, doc, entity):
         if self.out:
@@ -255,7 +258,7 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor)=
:
         assert not doc.args
         if self.out:
             self.out +=3D '\n'
-        self.out +=3D texi_body(doc) + texi_sections(doc)
+        self.out +=3D texi_body(doc) + texi_sections(doc, None)
=20
=20
 def texi_schema(schema):
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good=
.json
index 97ab4625ff..984cd8ed06 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -55,7 +55,7 @@
 #
 # @two is undocumented
 ##
-{ 'enum': 'Enum', 'data': [ 'one', 'two' ] }
+{ 'enum': 'Enum', 'data': [ 'one', 'two' ], 'if': 'defined(IFCOND)' }
=20
 ##
 # @Base:
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.=
out
index e615b04281..8c75da180c 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -3,6 +3,7 @@ object Base
 enum Enum
     member one
     member two
+    if ['defined(IFCOND)']
 object Object
     base Base
     tag base1
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good=
.texi
index 1778312581..cd422f8a8f 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -87,6 +87,8 @@ Not documented
 @end table
 @code{two} is undocumented
=20
+
+@b{If:} @code{defined(IFCOND)}
 @end deftp
=20
=20
--=20
2.16.0.rc1.1.gef27df75a1
