Received: from eggs.gnu.org ([2001:4830:134:3::10]:58368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbORH-0008Ea-PY
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbORG-0007bK-5L
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36382 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fbORF-0007XW-DU
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D5E2BE9003
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 10:58:08 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  6 Jul 2018 12:57:34 +0200
Message-Id: <20180706105753.26700-9-marcandre.lureau@redhat.com>
In-Reply-To: <20180706105753.26700-1-marcandre.lureau@redhat.com>
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 08/27] qapi: change enum visitor and
 gen_enum* to take QAPISchemaMember
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This will allow to add and access more properties associated with enum
values/members, like the associated 'if' condition. We may want to
have a specialized type QAPISchemaEnumMember, for now this will do.

While at it, also modify gen_enum() and gen_enum_lookup() for the
same reason.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/common.py         | 22 +++++++++++-----------
 scripts/qapi/doc.py            |  2 +-
 scripts/qapi/events.py         |  2 +-
 scripts/qapi/introspect.py     |  5 +++--
 scripts/qapi/types.py          |  6 +++---
 scripts/qapi/visit.py          |  2 +-
 tests/qapi-schema/test-qapi.py |  4 ++--
 7 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 7020b88abc..a353670079 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1063,7 +1063,7 @@ class QAPISchemaVisitor(object):
     def visit_builtin_type(self, name, info, json_type):
         pass
=20
-    def visit_enum_type(self, name, info, ifcond, values, prefix):
+    def visit_enum_type(self, name, info, ifcond, members, prefix):
         pass
=20
     def visit_array_type(self, name, info, ifcond, element_type):
@@ -1193,7 +1193,7 @@ class QAPISchemaEnumType(QAPISchemaType):
=20
     def visit(self, visitor):
         visitor.visit_enum_type(self.name, self.info, self.ifcond,
-                                self.member_names(), self.prefix)
+                                self.members, self.prefix)
=20
=20
 class QAPISchemaArrayType(QAPISchemaType):
@@ -2012,19 +2012,19 @@ def _wrap_ifcond(ifcond, before, after):
     return out
=20
=20
-def gen_enum_lookup(name, values, prefix=3DNone):
+def gen_enum_lookup(name, members, prefix=3DNone):
     ret =3D mcgen('''
=20
 const QEnumLookup %(c_name)s_lookup =3D {
     .array =3D (const char *const[]) {
 ''',
                 c_name=3Dc_name(name))
-    for value in values:
-        index =3D c_enum_const(name, value, prefix)
+    for m in members:
+        index =3D c_enum_const(name, m.name, prefix)
         ret +=3D mcgen('''
-        [%(index)s] =3D "%(value)s",
+        [%(index)s] =3D "%(name)s",
 ''',
-                     index=3Dindex, value=3Dvalue)
+                     index=3Dindex, name=3Dm.name)
=20
     ret +=3D mcgen('''
     },
@@ -2035,9 +2035,9 @@ const QEnumLookup %(c_name)s_lookup =3D {
     return ret
=20
=20
-def gen_enum(name, values, prefix=3DNone):
+def gen_enum(name, members, prefix=3DNone):
     # append automatically generated _MAX value
-    enum_values =3D values + ['_MAX']
+    enum_members =3D members + [QAPISchemaMember('_MAX')]
=20
     ret =3D mcgen('''
=20
@@ -2045,11 +2045,11 @@ typedef enum %(c_name)s {
 ''',
                 c_name=3Dc_name(name))
=20
-    for value in enum_values:
+    for m in enum_members:
         ret +=3D mcgen('''
     %(c_enum)s,
 ''',
-                     c_enum=3Dc_enum_const(name, value, prefix))
+                     c_enum=3Dc_enum_const(name, m.name, prefix))
=20
     ret +=3D mcgen('''
 } %(c_name)s;
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 987fd3c943..76cb186ff9 100755
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -206,7 +206,7 @@ class QAPISchemaGenDocVisitor(qapi.common.QAPISchemaV=
isitor):
     def write(self, output_dir):
         self._gen.write(output_dir, self._prefix + 'qapi-doc.texi')
=20
-    def visit_enum_type(self, name, info, ifcond, values, prefix):
+    def visit_enum_type(self, name, info, ifcond, members, prefix):
         doc =3D self.cur_doc
         self._gen.add(TYPE_FMT(type=3D'Enum',
                                name=3Ddoc.symbol,
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index 764ef177ab..ea4dac6a05 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -189,7 +189,7 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCVis=
itor):
             self._genh.add(gen_event_send_decl(name, arg_type, boxed))
             self._genc.add(gen_event_send(name, arg_type, boxed,
                                           self._enum_name))
-        self._event_names.append(name)
+        self._event_names.append(QAPISchemaMember(name))
=20
=20
 def gen_events(schema, output_dir, prefix):
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 71d4a779ce..3f1ca99f6d 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -160,8 +160,9 @@ const QLitObject %(c_name)s =3D %(c_string)s;
     def visit_builtin_type(self, name, info, json_type):
         self._gen_qlit(name, 'builtin', {'json-type': json_type}, [])
=20
-    def visit_enum_type(self, name, info, ifcond, values, prefix):
-        self._gen_qlit(name, 'enum', {'values': values}, ifcond)
+    def visit_enum_type(self, name, info, ifcond, members, prefix):
+        self._gen_qlit(name, 'enum',
+                       {'values': [m.name for m in members]}, ifcond)
=20
     def visit_array_type(self, name, info, ifcond, element_type):
         element =3D self._use_type(element_type)
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 91f87d0b8f..2d4a70f810 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -213,10 +213,10 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVi=
sitor):
         self._genh.add(gen_type_cleanup_decl(name))
         self._genc.add(gen_type_cleanup(name))
=20
-    def visit_enum_type(self, name, info, ifcond, values, prefix):
+    def visit_enum_type(self, name, info, ifcond, members, prefix):
         with ifcontext(ifcond, self._genh, self._genc):
-            self._genh.preamble_add(gen_enum(name, values, prefix))
-            self._genc.add(gen_enum_lookup(name, values, prefix))
+            self._genh.preamble_add(gen_enum(name, members, prefix))
+            self._genc.add(gen_enum_lookup(name, members, prefix))
=20
     def visit_array_type(self, name, info, ifcond, element_type):
         with ifcontext(ifcond, self._genh, self._genc):
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 460cf12989..24f85a2e85 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -310,7 +310,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCVis=
itor):
 ''',
                                       types=3Dtypes))
=20
-    def visit_enum_type(self, name, info, ifcond, values, prefix):
+    def visit_enum_type(self, name, info, ifcond, members, prefix):
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.add(gen_visit_decl(name, scalar=3DTrue))
             self._genc.add(gen_visit_enum(name))
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index cea21c773a..27f776693e 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -23,8 +23,8 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
     def visit_include(self, name, info):
         print('include %s' % name)
=20
-    def visit_enum_type(self, name, info, ifcond, values, prefix):
-        print('enum %s %s' % (name, values))
+    def visit_enum_type(self, name, info, ifcond, members, prefix):
+        print('enum %s %s' % (name, [m.name for m in members]))
         if prefix:
             print('    prefix %s' % prefix)
         self._print_if(ifcond)
--=20
2.18.0.rc1
