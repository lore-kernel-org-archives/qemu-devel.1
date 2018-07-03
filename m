Received: from eggs.gnu.org ([2001:4830:134:3::10]:44200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSVD-0000yX-OD
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:06:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSV7-0000PE-UD
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:06:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51174 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faSV7-0000Oj-Pl
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:06:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 73B9AEFDF8
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 21:06:17 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 23:06:11 +0200
Message-Id: <20180703210613.25619-13-armbru@redhat.com>
In-Reply-To: <20180703210613.25619-1-armbru@redhat.com>
References: <20180703210613.25619-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/14] qapi: add 'If:' section to generated
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The documentation is generated only once, and doesn't know C
pre-conditions. Add 'If:' sections for top-level entities.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180703155648.11933-13-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/doc.py             | 22 ++++++++++++----------
 tests/qapi-schema/doc-good.json |  2 +-
 tests/qapi-schema/doc-good.out  |  1 +
 tests/qapi-schema/doc-good.texi |  2 ++
 4 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 4db6674dc3..987fd3c943 100755
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
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
 class QAPISchemaGenDocVisitor(qapi.common.QAPISchemaVisitor):
@@ -208,7 +210,7 @@ class QAPISchemaGenDocVisitor(qapi.common.QAPISchemaV=
isitor):
         doc =3D self.cur_doc
         self._gen.add(TYPE_FMT(type=3D'Enum',
                                name=3Ddoc.symbol,
-                               body=3Dtexi_entity(doc, 'Values',
+                               body=3Dtexi_entity(doc, 'Values', ifcond,
                                                 member_func=3Dtexi_enum_=
value)))
=20
     def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
@@ -217,14 +219,14 @@ class QAPISchemaGenDocVisitor(qapi.common.QAPISchem=
aVisitor):
             base =3D None
         self._gen.add(TYPE_FMT(type=3D'Object',
                                name=3Ddoc.symbol,
-                               body=3Dtexi_entity(doc, 'Members',
+                               body=3Dtexi_entity(doc, 'Members', ifcond=
,
                                                 base, variants)))
=20
     def visit_alternate_type(self, name, info, ifcond, variants):
         doc =3D self.cur_doc
         self._gen.add(TYPE_FMT(type=3D'Alternate',
                                name=3Ddoc.symbol,
-                               body=3Dtexi_entity(doc, 'Members')))
+                               body=3Dtexi_entity(doc, 'Members', ifcond=
)))
=20
     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
                       success_response, boxed, allow_oob, allow_preconfi=
g):
@@ -233,9 +235,9 @@ class QAPISchemaGenDocVisitor(qapi.common.QAPISchemaV=
isitor):
             body =3D texi_body(doc)
             body +=3D ('\n@b{Arguments:} the members of @code{%s}\n'
                      % arg_type.name)
-            body +=3D texi_sections(doc)
+            body +=3D texi_sections(doc, ifcond)
         else:
-            body =3D texi_entity(doc, 'Arguments')
+            body =3D texi_entity(doc, 'Arguments', ifcond)
         self._gen.add(MSG_FMT(type=3D'Command',
                               name=3Ddoc.symbol,
                               body=3Dbody))
@@ -244,7 +246,7 @@ class QAPISchemaGenDocVisitor(qapi.common.QAPISchemaV=
isitor):
         doc =3D self.cur_doc
         self._gen.add(MSG_FMT(type=3D'Event',
                               name=3Ddoc.symbol,
-                              body=3Dtexi_entity(doc, 'Arguments')))
+                              body=3Dtexi_entity(doc, 'Arguments', ifcon=
d)))
=20
     def symbol(self, doc, entity):
         if self._gen._body:
@@ -257,7 +259,7 @@ class QAPISchemaGenDocVisitor(qapi.common.QAPISchemaV=
isitor):
         assert not doc.args
         if self._gen._body:
             self._gen.add('\n')
-        self._gen.add(texi_body(doc) + texi_sections(doc))
+        self._gen.add(texi_body(doc) + texi_sections(doc, None))
=20
=20
 def gen_doc(schema, output_dir, prefix):
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
index 9c8a4838e1..35f3f1164c 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -3,6 +3,7 @@ enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', =
'qlist', 'qbool']
     prefix QTYPE
 module doc-good.json
 enum Enum ['one', 'two']
+    if ['defined(IFCOND)']
 object Base
     member base1: Enum optional=3DFalse
 object Variant1
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good=
.texi
index 0aed2300a5..e42eace474 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -89,6 +89,8 @@ Not documented
 @end table
 @code{two} is undocumented
=20
+
+@b{If:} @code{defined(IFCOND)}
 @end deftp
=20
=20
--=20
2.17.1
