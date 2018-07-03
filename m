Received: from eggs.gnu.org ([2001:4830:134:3::10]:39581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1faNfy-0002Ek-Et
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:57:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1faNfx-0003Yp-87
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:57:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36436 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1faNfx-0003YW-3F
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:57:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 98453401D79C
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 15:57:08 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  3 Jul 2018 17:56:45 +0200
Message-Id: <20180703155648.11933-12-marcandre.lureau@redhat.com>
In-Reply-To: <20180703155648.11933-1-marcandre.lureau@redhat.com>
References: <20180703155648.11933-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 11/14] qapi-types: add #if conditions to
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
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Markus Armbruster <armbru@redhat.com>

Types & visitors are coupled and must be handled together to avoid
temporary build regression.

Wrap generated types/visitor code with #if/#endif using the context
helpers. Derived from a patch by Marc-Andr=C3=A9.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/types.py | 48 ++++++++++++++++++++++++++-----------------
 scripts/qapi/visit.py | 33 ++++++++++++++++-------------
 2 files changed, 48 insertions(+), 33 deletions(-)

diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 659075f884..fd7808103c 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -55,7 +55,7 @@ def gen_struct_members(members):
     return ret
=20
=20
-def gen_object(name, base, members, variants):
+def gen_object(name, ifcond, base, members, variants):
     if name in objects_seen:
         return ''
     objects_seen.add(name)
@@ -64,11 +64,14 @@ def gen_object(name, base, members, variants):
     if variants:
         for v in variants.variants:
             if isinstance(v.type, QAPISchemaObjectType):
-                ret +=3D gen_object(v.type.name, v.type.base,
+                ret +=3D gen_object(v.type.name, v.type.ifcond, v.type.b=
ase,
                                   v.type.local_members, v.type.variants)
=20
     ret +=3D mcgen('''
=20
+''')
+    ret +=3D gen_if(ifcond)
+    ret +=3D mcgen('''
 struct %(c_name)s {
 ''',
                  c_name=3Dc_name(name))
@@ -101,6 +104,7 @@ struct %(c_name)s {
     ret +=3D mcgen('''
 };
 ''')
+    ret +=3D gen_endif(ifcond)
=20
     return ret
=20
@@ -209,33 +213,39 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVi=
sitor):
         self._genc.add(gen_type_cleanup(name))
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
+        with ifcontext(ifcond, self._genh, self._genc):
+            self._genh.preamble_add(gen_fwd_object_or_array(name))
+            self._genh.add(gen_array(name, element_type))
+            self._gen_type_cleanup(name)
=20
     def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
         # Nothing to do for the special empty builtin
         if name =3D=3D 'q_empty':
             return
-        self._genh.preamble_add(gen_fwd_object_or_array(name))
-        self._genh.add(gen_object(name, base, members, variants))
-        if base and not base.is_implicit():
-            self._genh.add(gen_upcast(name, base))
-        # TODO Worth changing the visitor signature, so we could
-        # directly use rather than repeat type.is_implicit()?
-        if not name.startswith('q_'):
-            # implicit types won't be directly allocated/freed
-            self._gen_type_cleanup(name)
+        with ifcontext(ifcond, self._genh):
+            self._genh.preamble_add(gen_fwd_object_or_array(name))
+        self._genh.add(gen_object(name, ifcond, base, members, variants)=
)
+        with ifcontext(ifcond, self._genh, self._genc):
+            if base and not base.is_implicit():
+                self._genh.add(gen_upcast(name, base))
+            # TODO Worth changing the visitor signature, so we could
+            # directly use rather than repeat type.is_implicit()?
+            if not name.startswith('q_'):
+                # implicit types won't be directly allocated/freed
+                self._gen_type_cleanup(name)
=20
     def visit_alternate_type(self, name, info, ifcond, variants):
-        self._genh.preamble_add(gen_fwd_object_or_array(name))
-        self._genh.add(gen_object(name, None,
+        with ifcontext(ifcond, self._genh):
+            self._genh.preamble_add(gen_fwd_object_or_array(name))
+        self._genh.add(gen_object(name, ifcond, None,
                                   [variants.tag_member], variants))
-        self._gen_type_cleanup(name)
+        with ifcontext(ifcond, self._genh, self._genc):
+            self._gen_type_cleanup(name)
=20
=20
 def gen_types(schema, output_dir, prefix, opt_builtins):
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 34fe1ef5eb..dd5034a66a 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -311,29 +311,34 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCV=
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
2.18.0.rc1
