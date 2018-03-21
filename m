Received: from eggs.gnu.org ([2001:4830:134:3::10]:48471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycIZ-0005Dg-Th
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:52:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycIY-0007uP-Ku
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:52:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34918 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eycIY-0007uB-FO
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:52:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F251A76FB9
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 11:52:53 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 12:51:36 +0100
Message-Id: <20180321115211.17937-15-marcandre.lureau@redhat.com>
In-Reply-To: <20180321115211.17937-1-marcandre.lureau@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 14/49] qapi-types: add #if conditions to
 types & visitors
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

Types & visitors are coupled and must be handled together to avoid
temporary build regression.

Wrap generated types/visitor code with #if/#endif using the context
helpers.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/types.py | 46 ++++++++++++++++++++++++++-----------------
 scripts/qapi/visit.py | 33 ++++++++++++++++++-------------
 2 files changed, 47 insertions(+), 32 deletions(-)

diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 3d9b0f9a07..ce4c91206c 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -61,8 +61,10 @@ def gen_variants_objects(variants):
         for v in variants.variants:
             if isinstance(v.type, QAPISchemaObjectType):
                 ret +=3D gen_variants_objects(v.type.variants)
+                ret +=3D gen_if(v.type.ifcond)
                 ret +=3D gen_object(v.type.name, v.type.base,
                                   v.type.local_members, v.type.variants)
+                ret +=3D gen_endif(v.type.ifcond)
     return ret
=20
=20
@@ -206,41 +208,49 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVi=
sitor):
         # gen_object() is recursive, ensure it doesn't visit the empty t=
ype
         objects_seen.add(schema.the_empty_object_type.name)
=20
-    def _gen_type_cleanup(self, name):
-        self._genh.add(gen_type_cleanup_decl(name))
-        self._genc.add(gen_type_cleanup(name))
+    def _gen_type_cleanup(self, name, ifcond):
+        with ifcontext(ifcond, self._genh, self._genc):
+            self._genh.add(gen_type_cleanup_decl(name))
+            self._genc.add(gen_type_cleanup(name))
=20
     def visit_enum_type(self, name, info, ifcond, values, prefix):
-        self._genh.preamble_add(gen_enum(name, values, prefix))
-        self._genc.add(gen_enum_lookup(name, values, prefix))
+        with ifcontext(ifcond, self._genh, self._genc):
+            self._genh.preamble_add(gen_enum(name, values, prefix))
+            self._genc.add(gen_enum_lookup(name, values, prefix))
=20
     def visit_array_type(self, name, info, ifcond, element_type):
-        self._genh.preamble_add(gen_fwd_object_or_array(name))
-        self._genh.add(gen_array(name, element_type))
-        self._gen_type_cleanup(name)
+        with ifcontext(ifcond, self._genh):
+            self._genh.preamble_add(gen_fwd_object_or_array(name))
+            self._genh.add(gen_array(name, element_type))
+        self._gen_type_cleanup(name, ifcond)
=20
     def _gen_object(self, name, info, ifcond, base, members, variants):
-        self._genh.add(gen_object(name, base, members, variants))
-        if base and not base.is_implicit():
-            self._genh.add(gen_upcast(name, base))
-        # TODO Worth changing the visitor signature, so we could
-        # directly use rather than repeat type.is_implicit()?
+        with ifcontext(ifcond, self._genh):
+            self._genh.add(gen_object(name, base, members, variants))
+            if base and not base.is_implicit():
+                self._genh.add(gen_upcast(name, base))
+            # TODO Worth changing the visitor signature, so we could
+            # directly use rather than repeat type.is_implicit()?
         if not name.startswith('q_'):
             # implicit types won't be directly allocated/freed
-            self._gen_type_cleanup(name)
+            self._gen_type_cleanup(name, ifcond)
+
+    def _gen_fwd_object_or_array(self, name, ifcond):
+        with ifcontext(ifcond, self._genh):
+            self._genh.preamble_add(gen_fwd_object_or_array(name))
=20
     def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
         # Nothing to do for the special empty builtin
         if name =3D=3D 'q_empty':
             return
-        self._genh.preamble_add(gen_fwd_object_or_array(name))
+        self._gen_fwd_object_or_array(name, ifcond)
         self._genh.add(gen_variants_objects(variants))
-        self._gen_object(name, info, None, base, members, variants)
+        self._gen_object(name, info, ifcond, base, members, variants)
=20
     def visit_alternate_type(self, name, info, ifcond, variants):
-        self._genh.preamble_add(gen_fwd_object_or_array(name))
+        self._gen_fwd_object_or_array(name, ifcond)
         self._genh.add(gen_variants_objects(variants))
-        self._gen_object(name, info, None, None,
+        self._gen_object(name, info, ifcond, None,
                          [variants.tag_member], variants)
=20
=20
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 9ea2e04f81..e4a62ce030 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -302,29 +302,34 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCV=
isitor):
                                       types=3Dtypes))
=20
     def visit_enum_type(self, name, info, ifcond, values, prefix):
-        self._genh.add(gen_visit_decl(name, scalar=3DTrue))
-        self._genc.add(gen_visit_enum(name))
+        with ifcontext(ifcond, self._genh, self._genc):
+            self._genh.add(gen_visit_decl(name, scalar=3DTrue))
+            self._genc.add(gen_visit_enum(name))
=20
     def visit_array_type(self, name, info, ifcond, element_type):
-        self._genh.add(gen_visit_decl(name))
-        self._genc.add(gen_visit_list(name, element_type))
+        with ifcontext(ifcond, self._genh, self._genc):
+            self._genh.add(gen_visit_decl(name))
+            self._genc.add(gen_visit_list(name, element_type))
=20
     def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
         # Nothing to do for the special empty builtin
         if name =3D=3D 'q_empty':
             return
-        self._genh.add(gen_visit_members_decl(name))
-        self._genc.add(gen_visit_object_members(name, base, members, var=
iants))
-        # TODO Worth changing the visitor signature, so we could
-        # directly use rather than repeat type.is_implicit()?
-        if not name.startswith('q_'):
-            # only explicit types need an allocating visit
-            self._genh.add(gen_visit_decl(name))
-            self._genc.add(gen_visit_object(name, base, members, variant=
s))
+        with ifcontext(ifcond, self._genh, self._genc):
+            self._genh.add(gen_visit_members_decl(name))
+            self._genc.add(gen_visit_object_members(name, base,
+                                                    members, variants))
+            # TODO Worth changing the visitor signature, so we could
+            # directly use rather than repeat type.is_implicit()?
+            if not name.startswith('q_'):
+                # only explicit types need an allocating visit
+                self._genh.add(gen_visit_decl(name))
+                self._genc.add(gen_visit_object(name, base, members, var=
iants))
=20
     def visit_alternate_type(self, name, info, ifcond, variants):
-        self._genh.add(gen_visit_decl(name))
-        self._genc.add(gen_visit_alternate(name, variants))
+        with ifcontext(ifcond, self._genh, self._genc):
+            self._genh.add(gen_visit_decl(name))
+            self._genc.add(gen_visit_alternate(name, variants))
=20
=20
 def gen_visit(schema, output_dir, prefix, opt_builtins):
--=20
2.16.2.521.g9aa15f885a
