Received: from eggs.gnu.org ([2001:4830:134:3::10]:50420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkVE-0006Ph-53
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:35:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkVB-0002Sl-0A
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:35:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:25566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkVA-0002Rm-Na
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:35:08 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:14 +0100
Message-Id: <20180111213250.16511-16-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 15/51] qapi-types: refactor variants handling
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

Generate variants objects outside gen_object(). This will allow to
easily wrap gen_object() with ifcond_decorator in the following patch.

gen_variants_objects() calls gen_object() for each variants, so it
remains guarded for each generated variant object.

self._gen_type_cleanup(name) is factored out in _gen_object(), helping
generated code to be wrapped by the same condition in the following
patch.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi-types.py | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index 915786c463..2b3588267b 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi-types.py
@@ -53,23 +53,27 @@ def gen_struct_members(members):
     return ret
=20
=20
-def gen_object(name, base, members, variants):
-    if name in objects_seen:
-        return ''
-    objects_seen.add(name)
-
+def gen_variants_objects(variants):
     ret =3D ''
     if variants:
         for v in variants.variants:
             if isinstance(v.type, QAPISchemaObjectType):
+                ret +=3D gen_variants_objects(v.type.variants)
                 ret +=3D gen_object(v.type.name, v.type.base,
                                   v.type.local_members, v.type.variants)
+    return ret
=20
-    ret +=3D mcgen('''
+
+def gen_object(name, base, members, variants):
+    if name in objects_seen:
+        return ''
+    objects_seen.add(name)
+
+    ret =3D mcgen('''
=20
 struct %(c_name)s {
 ''',
-                 c_name=3Dc_name(name))
+                c_name=3Dc_name(name))
=20
     if base:
         if not base.is_implicit():
@@ -218,11 +222,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
             self.decl +=3D gen_array(name, element_type)
             self._gen_type_cleanup(name)
=20
-    def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
-        # Nothing to do for the special empty builtin
-        if name =3D=3D 'q_empty':
-            return
-        self._fwdecl +=3D gen_fwd_object_or_array(name)
+    def _gen_object(self, name, info, ifcond, base, members, variants):
         self.decl +=3D gen_object(name, base, members, variants)
         if base and not base.is_implicit():
             self.decl +=3D gen_upcast(name, base)
@@ -232,10 +232,19 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
             # implicit types won't be directly allocated/freed
             self._gen_type_cleanup(name)
=20
+    def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
+        # Nothing to do for the special empty builtin
+        if name =3D=3D 'q_empty':
+            return
+        self._fwdecl +=3D gen_fwd_object_or_array(name)
+        self.decl +=3D gen_variants_objects(variants)
+        self._gen_object(name, info, None, base, members, variants)
+
     def visit_alternate_type(self, name, info, ifcond, variants):
         self._fwdecl +=3D gen_fwd_object_or_array(name)
-        self.decl +=3D gen_object(name, None, [variants.tag_member], var=
iants)
-        self._gen_type_cleanup(name)
+        self.decl +=3D gen_variants_objects(variants)
+        self._gen_object(name, info, None, None,
+                         [variants.tag_member], variants)
=20
 # If you link code generated from multiple schemata, you want only one
 # instance of the code for built-in types.  Generate it only when
--=20
2.16.0.rc1.1.gef27df75a1
