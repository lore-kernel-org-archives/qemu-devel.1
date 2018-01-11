Received: from eggs.gnu.org ([2001:4830:134:3::10]:50455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkVJ-0006Vm-R9
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:35:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkVI-0002ZU-NO
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:35:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkVI-0002Yw-F3
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:35:16 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:15 +0100
Message-Id: <20180111213250.16511-17-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 16/51] qapi-types: add #if conditions to
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
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Types & visitors are coupled and must be handled together to avoid
temporary build regression.

Wrap generated types/visitor code with #if/#endif using the
ifcond_decorator & helpers.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi-types.py | 18 ++++++++++++++----
 scripts/qapi-visit.py |  5 +++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index 2b3588267b..789e89ff59 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi-types.py
@@ -59,8 +59,10 @@ def gen_variants_objects(variants):
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
@@ -175,6 +177,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
         self.defn =3D None
         self._fwdecl =3D None
         self._btin =3D None
+        self.if_members =3D ['decl', 'defn', '_fwdecl', '_btin']
=20
     def visit_begin(self, schema):
         # gen_object() is recursive, ensure it doesn't visit the empty t=
ype
@@ -199,6 +202,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
         self.decl +=3D gen_type_cleanup_decl(name)
         self.defn +=3D gen_type_cleanup(name)
=20
+    @ifcond_decorator
     def visit_enum_type(self, name, info, ifcond, values, prefix):
         # Special case for our lone builtin enum type
         # TODO use something cleaner than existence of info
@@ -210,6 +214,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
             self._fwdecl +=3D gen_enum(name, values, prefix)
             self.defn +=3D gen_enum_lookup(name, values, prefix)
=20
+    @ifcond_decorator
     def visit_array_type(self, name, info, ifcond, element_type):
         if isinstance(element_type, QAPISchemaBuiltinType):
             self._btin +=3D gen_fwd_object_or_array(name)
@@ -222,6 +227,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
             self.decl +=3D gen_array(name, element_type)
             self._gen_type_cleanup(name)
=20
+    @ifcond_decorator
     def _gen_object(self, name, info, ifcond, base, members, variants):
         self.decl +=3D gen_object(name, base, members, variants)
         if base and not base.is_implicit():
@@ -232,18 +238,22 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
             # implicit types won't be directly allocated/freed
             self._gen_type_cleanup(name)
=20
+    @ifcond_decorator
+    def _gen_fwd_object_or_array(self, name, ifcond):
+        self._fwdecl +=3D gen_fwd_object_or_array(name)
+
     def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
         # Nothing to do for the special empty builtin
         if name =3D=3D 'q_empty':
             return
-        self._fwdecl +=3D gen_fwd_object_or_array(name)
+        self._gen_fwd_object_or_array(name, ifcond)
         self.decl +=3D gen_variants_objects(variants)
-        self._gen_object(name, info, None, base, members, variants)
+        self._gen_object(name, info, ifcond, base, members, variants)
=20
     def visit_alternate_type(self, name, info, ifcond, variants):
-        self._fwdecl +=3D gen_fwd_object_or_array(name)
+        self._gen_fwd_object_or_array(name, ifcond)
         self.decl +=3D gen_variants_objects(variants)
-        self._gen_object(name, info, None, None,
+        self._gen_object(name, info, ifcond, None,
                          [variants.tag_member], variants)
=20
 # If you link code generated from multiple schemata, you want only one
diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index aceea2a9f9..4b0e005437 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -267,6 +267,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
         self.decl =3D None
         self.defn =3D None
         self._btin =3D None
+        self.if_members =3D ['decl', 'defn', '_btin']
=20
     def visit_begin(self, schema):
         self.decl =3D ''
@@ -282,6 +283,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
         self.decl =3D self._btin + self.decl
         self._btin =3D None
=20
+    @ifcond_decorator
     def visit_enum_type(self, name, info, ifcond, values, prefix):
         # Special case for our lone builtin enum type
         # TODO use something cleaner than existence of info
@@ -293,6 +295,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
             self.decl +=3D gen_visit_decl(name, scalar=3DTrue)
             self.defn +=3D gen_visit_enum(name)
=20
+    @ifcond_decorator
     def visit_array_type(self, name, info, ifcond, element_type):
         decl =3D gen_visit_decl(name)
         defn =3D gen_visit_list(name, element_type)
@@ -304,6 +307,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
             self.decl +=3D decl
             self.defn +=3D defn
=20
+    @ifcond_decorator
     def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
         # Nothing to do for the special empty builtin
         if name =3D=3D 'q_empty':
@@ -317,6 +321,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
             self.decl +=3D gen_visit_decl(name)
             self.defn +=3D gen_visit_object(name, base, members, variant=
s)
=20
+    @ifcond_decorator
     def visit_alternate_type(self, name, info, ifcond, variants):
         self.decl +=3D gen_visit_decl(name)
         self.defn +=3D gen_visit_alternate(name, variants)
--=20
2.16.0.rc1.1.gef27df75a1
