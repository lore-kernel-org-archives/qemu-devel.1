Received: from eggs.gnu.org ([2001:4830:134:3::10]:55494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9Jt-00006N-2W
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9Jp-0007N1-59
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:34:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dk9Jo-0007MB-Ra
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:34:09 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:28 +0200
Message-Id: <20170822132255.23945-28-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 27/54] qapi-types: add #if conditions to
 types
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
 scripts/qapi-types.py | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index 05b0eee482..c1316312ac 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi-types.py
@@ -175,6 +175,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
         self.defn =3D None
         self._fwdecl =3D None
         self._btin =3D None
+        self.if_members =3D ['decl', 'defn', '_fwdecl', '_btin']
=20
     def visit_begin(self, schema):
         # gen_object() is recursive, ensure it doesn't visit the empty t=
ype
@@ -201,10 +202,12 @@ typedef struct QEnumLookup {
         self.decl =3D self._btin + self.decl
         self._btin =3D None
=20
-    def _gen_type_cleanup(self, name):
+    @ifcond_decorator
+    def _gen_type_cleanup(self, name, ifcond):
         self.decl +=3D gen_type_cleanup_decl(name)
         self.defn +=3D gen_type_cleanup(name)
=20
+    @ifcond_decorator
     def visit_enum_type(self, name, info, values, prefix, ifcond):
         # Special case for our lone builtin enum type
         # TODO use something cleaner than existence of info
@@ -216,6 +219,7 @@ typedef struct QEnumLookup {
             self._fwdecl +=3D gen_enum(name, values, prefix)
             self.defn +=3D gen_enum_lookup(name, values, prefix)
=20
+    @ifcond_decorator
     def visit_array_type(self, name, info, element_type, ifcond):
         if isinstance(element_type, QAPISchemaBuiltinType):
             self._btin +=3D gen_fwd_object_or_array(name)
@@ -226,9 +230,10 @@ typedef struct QEnumLookup {
         else:
             self._fwdecl +=3D gen_fwd_object_or_array(name)
             self.decl +=3D gen_array(name, element_type)
-            self._gen_type_cleanup(name)
+            self._gen_type_cleanup(name, ifcond)
=20
-    def _gen_object(self, name, info, base, members, variants):
+    @ifcond_decorator
+    def _gen_object(self, name, info, base, members, variants, ifcond):
         self.decl +=3D gen_object(name, base, members, variants)
         if base and not base.is_implicit():
             self.decl +=3D gen_upcast(name, base)
@@ -236,7 +241,7 @@ typedef struct QEnumLookup {
         # directly use rather than repeat type.is_implicit()?
         if not name.startswith('q_'):
             # implicit types won't be directly allocated/freed
-            self._gen_type_cleanup(name)
+            self._gen_type_cleanup(name, ifcond)
=20
     def visit_object_type(self, name, info, base, members, variants, ifc=
ond):
         # Nothing to do for the special empty builtin
@@ -244,12 +249,13 @@ typedef struct QEnumLookup {
             return
         self._fwdecl +=3D gen_fwd_object_or_array(name)
         self.decl +=3D gen_variants_objects(variants)
-        self._gen_object(name, info, base, members, variants)
+        self._gen_object(name, info, base, members, variants, ifcond)
=20
     def visit_alternate_type(self, name, info, variants, ifcond):
         self._fwdecl +=3D gen_fwd_object_or_array(name)
         self.decl +=3D gen_variants_objects(variants)
-        self._gen_object(name, info, None, [variants.tag_member], varian=
ts)
+        self._gen_object(name, info, None, [variants.tag_member],
+                         variants, ifcond)
=20
 # If you link code generated from multiple schemata, you want only one
 # instance of the code for built-in types.  Generate it only when
--=20
2.14.1.146.gd35faa819
