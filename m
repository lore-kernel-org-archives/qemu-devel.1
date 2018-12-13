Received: from eggs.gnu.org ([2001:4830:134:3::10]:53392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVy7-00062H-1g
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:44:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVxx-00036U-9K
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:44:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXVxr-0001oq-N3
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:44:05 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 63B253002511
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 18:43:51 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 13 Dec 2018 19:43:24 +0100
Message-Id: <20181213184340.24037-17-armbru@redhat.com>
In-Reply-To: <20181213184340.24037-1-armbru@redhat.com>
References: <20181213184340.24037-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/32] qapi: change enum visitor and gen_enum*
 to take QAPISchemaMember
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

This will allow to add and access more properties associated with enum
values/members, like the associated 'if' condition. We may want to
have a specialized type QAPISchemaEnumMember, for now this will do.

Modify gen_enum() and gen_enum_lookup() for the same reason.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20181213123724.4866-3-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py         | 22 +++++++++++-----------
 scripts/qapi/doc.py            |  2 +-
 scripts/qapi/events.py         | 13 +++++++------
 scripts/qapi/introspect.py     |  5 +++--
 scripts/qapi/types.py          |  6 +++---
 scripts/qapi/visit.py          |  2 +-
 tests/qapi-schema/test-qapi.py |  4 ++--
 7 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 55c914ec44..1fa2f79990 100644
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
index 2ed7902424..f1b88d8786 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -143,8 +143,8 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCVis=
itor):
         QAPISchemaModularCVisitor.__init__(
             self, prefix, 'qapi-events',
             ' * Schema-defined QAPI/QMP events', __doc__)
-        self._enum_name =3D c_name(prefix + 'QAPIEvent', protect=3DFalse=
)
-        self._event_names =3D []
+        self._event_enum_name =3D c_name(prefix + 'QAPIEvent', protect=3D=
False)
+        self._event_enum_members =3D []
=20
     def _begin_module(self, name):
         types =3D self._module_basename('qapi-types', name)
@@ -170,15 +170,16 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCV=
isitor):
=20
     def visit_end(self):
         (genc, genh) =3D self._module[self._main_module]
-        genh.add(gen_enum(self._enum_name, self._event_names))
-        genc.add(gen_enum_lookup(self._enum_name, self._event_names))
+        genh.add(gen_enum(self._event_enum_name, self._event_enum_member=
s))
+        genc.add(gen_enum_lookup(self._event_enum_name,
+                                 self._event_enum_members))
=20
     def visit_event(self, name, info, ifcond, arg_type, boxed):
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.add(gen_event_send_decl(name, arg_type, boxed))
             self._genc.add(gen_event_send(name, arg_type, boxed,
-                                          self._enum_name))
-        self._event_names.append(name)
+                                          self._event_enum_name))
+        self._event_enum_members.append(QAPISchemaMember(name))
=20
=20
 def gen_events(schema, output_dir, prefix):
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 67d6106f77..417625d54b 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -174,8 +174,9 @@ const QLitObject %(c_name)s =3D %(c_string)s;
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
index fd7808103c..e8d22c5081 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -212,10 +212,10 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVi=
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
2.17.2
