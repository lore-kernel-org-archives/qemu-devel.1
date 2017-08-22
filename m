Received: from eggs.gnu.org ([2001:4830:134:3::10]:54461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9H3-0005xj-0i
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9Gz-0005KM-49
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:31:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dk9Gy-0005K4-S5
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:31:13 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:27 +0200
Message-Id: <20170822132255.23945-27-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 26/54] qapi-types: refactor variants handling
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

Generate variants objects outside gen_object(). This will allow to
easily wrap gen_object() with ifcond_decorator in the following patch.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi-types.py | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index 6f06720adc..05b0eee482 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi-types.py
@@ -53,19 +53,23 @@ def gen_struct_members(members):
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
@@ -224,11 +228,7 @@ typedef struct QEnumLookup {
             self.decl +=3D gen_array(name, element_type)
             self._gen_type_cleanup(name)
=20
-    def visit_object_type(self, name, info, base, members, variants, ifc=
ond):
-        # Nothing to do for the special empty builtin
-        if name =3D=3D 'q_empty':
-            return
-        self._fwdecl +=3D gen_fwd_object_or_array(name)
+    def _gen_object(self, name, info, base, members, variants):
         self.decl +=3D gen_object(name, base, members, variants)
         if base and not base.is_implicit():
             self.decl +=3D gen_upcast(name, base)
@@ -238,10 +238,18 @@ typedef struct QEnumLookup {
             # implicit types won't be directly allocated/freed
             self._gen_type_cleanup(name)
=20
+    def visit_object_type(self, name, info, base, members, variants, ifc=
ond):
+        # Nothing to do for the special empty builtin
+        if name =3D=3D 'q_empty':
+            return
+        self._fwdecl +=3D gen_fwd_object_or_array(name)
+        self.decl +=3D gen_variants_objects(variants)
+        self._gen_object(name, info, base, members, variants)
+
     def visit_alternate_type(self, name, info, variants, ifcond):
         self._fwdecl +=3D gen_fwd_object_or_array(name)
-        self.decl +=3D gen_object(name, None, [variants.tag_member], var=
iants)
-        self._gen_type_cleanup(name)
+        self.decl +=3D gen_variants_objects(variants)
+        self._gen_object(name, info, None, [variants.tag_member], varian=
ts)
=20
 # If you link code generated from multiple schemata, you want only one
 # instance of the code for built-in types.  Generate it only when
--=20
2.14.1.146.gd35faa819
