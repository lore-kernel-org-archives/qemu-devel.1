Received: from eggs.gnu.org ([2001:4830:134:3::10]:48453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycIV-0005AK-Fe
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:52:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycIU-0007sQ-J2
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:52:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42054 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eycIU-0007sE-Dy
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:52:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E7647406DE12
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 11:52:49 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 12:51:35 +0100
Message-Id: <20180321115211.17937-14-marcandre.lureau@redhat.com>
In-Reply-To: <20180321115211.17937-1-marcandre.lureau@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 13/49] qapi-types: refactor variants handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Generate variants objects outside gen_object(). This will allow to
easily wrap gen_object() with ifcond_decorator in the following patch.

gen_variants_objects() calls gen_object() for each variants, so it
remains guarded for each generated variant object.

self._gen_type_cleanup(name) is factored out in _gen_object(), helping
generated code to be wrapped by the same condition in the following
patch.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/types.py | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 298a80db62..3d9b0f9a07 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -55,23 +55,27 @@ def gen_struct_members(members):
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
@@ -215,11 +219,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVis=
itor):
         self._genh.add(gen_array(name, element_type))
         self._gen_type_cleanup(name)
=20
-    def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
-        # Nothing to do for the special empty builtin
-        if name =3D=3D 'q_empty':
-            return
-        self._genh.preamble_add(gen_fwd_object_or_array(name))
+    def _gen_object(self, name, info, ifcond, base, members, variants):
         self._genh.add(gen_object(name, base, members, variants))
         if base and not base.is_implicit():
             self._genh.add(gen_upcast(name, base))
@@ -229,11 +229,19 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVi=
sitor):
             # implicit types won't be directly allocated/freed
             self._gen_type_cleanup(name)
=20
+    def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
+        # Nothing to do for the special empty builtin
+        if name =3D=3D 'q_empty':
+            return
+        self._genh.preamble_add(gen_fwd_object_or_array(name))
+        self._genh.add(gen_variants_objects(variants))
+        self._gen_object(name, info, None, base, members, variants)
+
     def visit_alternate_type(self, name, info, ifcond, variants):
         self._genh.preamble_add(gen_fwd_object_or_array(name))
-        self._genh.add(gen_object(name, None,
-                                  [variants.tag_member], variants))
-        self._gen_type_cleanup(name)
+        self._genh.add(gen_variants_objects(variants))
+        self._gen_object(name, info, None, None,
+                         [variants.tag_member], variants)
=20
=20
 def gen_types(schema, output_dir, prefix, opt_builtins):
--=20
2.16.2.521.g9aa15f885a
