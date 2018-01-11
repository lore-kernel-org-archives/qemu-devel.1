Received: from eggs.gnu.org ([2001:4830:134:3::10]:50585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkVb-0006mp-Uj
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:35:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkVX-0002mr-Us
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:35:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkVX-0002mE-MJ
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:35:31 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:17 +0100
Message-Id: <20180111213250.16511-19-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 18/51] qapi: rename
 QAPISchemaEnumType.values to .members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

Rename QAPISchemaEnumType.values and related variables to members.
Makes sense ever since commit 93bda4dd4 changed .values from list of
string to list of QAPISchemaMember. Obvious no-op.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py                | 36 ++++++++++++++++++------------------
 scripts/qapi-introspect.py     |  4 ++--
 scripts/qapi-types.py          | 10 +++++-----
 scripts/qapi-visit.py          |  2 +-
 scripts/qapi2texi.py           |  2 +-
 tests/qapi-schema/test-qapi.py |  4 ++--
 6 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index ee759489cb..c7cd98a890 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1046,7 +1046,7 @@ class QAPISchemaVisitor(object):
     def visit_builtin_type(self, name, info, json_type):
         pass
=20
-    def visit_enum_type(self, name, info, ifcond, values, prefix):
+    def visit_enum_type(self, name, info, ifcond, members, prefix):
         pass
=20
     def visit_array_type(self, name, info, ifcond, element_type):
@@ -1134,22 +1134,22 @@ class QAPISchemaBuiltinType(QAPISchemaType):
=20
=20
 class QAPISchemaEnumType(QAPISchemaType):
-    def __init__(self, name, info, doc, ifcond, values, prefix):
+    def __init__(self, name, info, doc, ifcond, members, prefix):
         QAPISchemaType.__init__(self, name, info, doc, ifcond)
-        for v in values:
-            assert isinstance(v, QAPISchemaMember)
-            v.set_owner(name)
+        for m in members:
+            assert isinstance(m, QAPISchemaMember)
+            m.set_owner(name)
         assert prefix is None or isinstance(prefix, str)
-        self.values =3D values
+        self.members =3D members
         self.prefix =3D prefix
=20
     def check(self, schema):
         QAPISchemaType.check(self, schema)
         seen =3D {}
-        for v in self.values:
-            v.check_clash(self.info, seen)
+        for m in self.members:
+            m.check_clash(self.info, seen)
             if self.doc:
-                self.doc.connect_member(v)
+                self.doc.connect_member(m)
=20
     def is_implicit(self):
         # See QAPISchema._make_implicit_enum_type() and ._def_predefined=
s()
@@ -1159,7 +1159,7 @@ class QAPISchemaEnumType(QAPISchemaType):
         return c_name(self.name)
=20
     def member_names(self):
-        return [v.name for v in self.values]
+        return [m.name for m in self.members]
=20
     def json_type(self):
         return 'string'
@@ -1958,19 +1958,19 @@ def ifcond_decorator(func):
     return func_wrapper
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
+        index =3D c_enum_const(name, m, prefix)
         ret +=3D mcgen('''
         [%(index)s] =3D "%(value)s",
 ''',
-                     index=3Dindex, value=3Dvalue)
+                     index=3Dindex, value=3Dm)
=20
     ret +=3D mcgen('''
     },
@@ -1981,9 +1981,9 @@ const QEnumLookup %(c_name)s_lookup =3D {
     return ret
=20
=20
-def gen_enum(name, values, prefix=3DNone):
+def gen_enum(name, members, prefix=3DNone):
     # append automatically generated _MAX value
-    enum_values =3D values + ['_MAX']
+    enum_members =3D members + ['_MAX']
=20
     ret =3D mcgen('''
=20
@@ -1991,11 +1991,11 @@ typedef enum %(c_name)s {
 ''',
                 c_name=3Dc_name(name))
=20
-    for value in enum_values:
+    for m in enum_members:
         ret +=3D mcgen('''
     %(c_enum)s,
 ''',
-                     c_enum=3Dc_enum_const(name, value, prefix))
+                     c_enum=3Dc_enum_const(name, m, prefix))
=20
     ret +=3D mcgen('''
 } %(c_name)s;
diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index 7d3a5c37fd..9fcb342c91 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -153,8 +153,8 @@ const QLitObject %(c_name)s =3D %(c_string)s;
     def visit_builtin_type(self, name, info, json_type):
         self._gen_qlit(name, 'builtin', {'json-type': json_type}, [])
=20
-    def visit_enum_type(self, name, info, ifcond, values, prefix):
-        self._gen_qlit(name, 'enum', {'values': values}, ifcond)
+    def visit_enum_type(self, name, info, ifcond, members, prefix):
+        self._gen_qlit(name, 'enum', {'values': members}, ifcond)
=20
     def visit_array_type(self, name, info, ifcond, element_type):
         element =3D self._use_type(element_type)
diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index 789e89ff59..75c1823e44 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi-types.py
@@ -203,16 +203,16 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
         self.defn +=3D gen_type_cleanup(name)
=20
     @ifcond_decorator
-    def visit_enum_type(self, name, info, ifcond, values, prefix):
+    def visit_enum_type(self, name, info, ifcond, members, prefix):
         # Special case for our lone builtin enum type
         # TODO use something cleaner than existence of info
         if not info:
-            self._btin +=3D gen_enum(name, values, prefix)
+            self._btin +=3D gen_enum(name, members, prefix)
             if do_builtins:
-                self.defn +=3D gen_enum_lookup(name, values, prefix)
+                self.defn +=3D gen_enum_lookup(name, members, prefix)
         else:
-            self._fwdecl +=3D gen_enum(name, values, prefix)
-            self.defn +=3D gen_enum_lookup(name, values, prefix)
+            self._fwdecl +=3D gen_enum(name, members, prefix)
+            self.defn +=3D gen_enum_lookup(name, members, prefix)
=20
     @ifcond_decorator
     def visit_array_type(self, name, info, ifcond, element_type):
diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index 4b0e005437..7e816ae98e 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -284,7 +284,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
         self._btin =3D None
=20
     @ifcond_decorator
-    def visit_enum_type(self, name, info, ifcond, values, prefix):
+    def visit_enum_type(self, name, info, ifcond, members, prefix):
         # Special case for our lone builtin enum type
         # TODO use something cleaner than existence of info
         if not info:
diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index f24fb89bd5..755bd2f15d 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -203,7 +203,7 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor)=
:
     def visit_begin(self, schema):
         self.out =3D ''
=20
-    def visit_enum_type(self, name, info, ifcond, values, prefix):
+    def visit_enum_type(self, name, info, ifcond, members, prefix):
         doc =3D self.cur_doc
         self.out +=3D TYPE_FMT(type=3D'Enum',
                              name=3Ddoc.symbol,
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index a4b3a00bbd..1c4f9e0dac 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -17,8 +17,8 @@ import sys
=20
=20
 class QAPISchemaTestVisitor(QAPISchemaVisitor):
-    def visit_enum_type(self, name, info, ifcond, values, prefix):
-        print 'enum %s %s' % (name, values)
+    def visit_enum_type(self, name, info, ifcond, members, prefix):
+        print 'enum %s %s' % (name, members)
         if prefix:
             print '    prefix %s' % prefix
         self._print_if(ifcond)
--=20
2.16.0.rc1.1.gef27df75a1
