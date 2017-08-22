Received: from eggs.gnu.org ([2001:4830:134:3::10]:55214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9JN-00083l-0p
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:33:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9JI-0006xl-5u
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:33:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dk9JH-0006wh-SL
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:33:36 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:18 +0200
Message-Id: <20170822132255.23945-18-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 17/54] qapi: add 'if' condition on entity
 objects
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

Take 'if' from expression, and use it to construct entity objects.
Shared implicit objects must share the same 'if' condition.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py | 81 +++++++++++++++++++++++++++++++++++++--------------=
------
 1 file changed, 53 insertions(+), 28 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index a94d93ada4..dc40d74abb 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -992,7 +992,7 @@ def check_exprs(exprs):
 #
=20
 class QAPISchemaEntity(object):
-    def __init__(self, name, info, doc):
+    def __init__(self, name, info, doc, ifcond=3DNone):
         assert isinstance(name, str)
         self.name =3D name
         # For explicitly defined entities, info points to the (explicit)
@@ -1002,6 +1002,7 @@ class QAPISchemaEntity(object):
         # such place).
         self.info =3D info
         self.doc =3D doc
+        self.ifcond =3D ifcond
=20
     def c_name(self):
         return c_name(self.name)
@@ -1118,8 +1119,8 @@ class QAPISchemaBuiltinType(QAPISchemaType):
=20
=20
 class QAPISchemaEnumType(QAPISchemaType):
-    def __init__(self, name, info, doc, values, prefix):
-        QAPISchemaType.__init__(self, name, info, doc)
+    def __init__(self, name, info, doc, values, prefix, ifcond=3DNone):
+        QAPISchemaType.__init__(self, name, info, doc, ifcond)
         for v in values:
             assert isinstance(v, QAPISchemaMember)
             v.set_owner(name)
@@ -1162,6 +1163,7 @@ class QAPISchemaArrayType(QAPISchemaType):
     def check(self, schema):
         self.element_type =3D schema.lookup_type(self._element_type_name=
)
         assert self.element_type
+        self.ifcond =3D self.element_type.ifcond
=20
     def is_implicit(self):
         return True
@@ -1183,11 +1185,12 @@ class QAPISchemaArrayType(QAPISchemaType):
=20
=20
 class QAPISchemaObjectType(QAPISchemaType):
-    def __init__(self, name, info, doc, base, local_members, variants):
+    def __init__(self, name, info, doc, base, local_members, variants,
+                 ifcond=3DNone):
         # struct has local_members, optional base, and no variants
         # flat union has base, variants, and no local_members
         # simple union has local_members, variants, and no base
-        QAPISchemaType.__init__(self, name, info, doc)
+        QAPISchemaType.__init__(self, name, info, doc, ifcond)
         assert base is None or isinstance(base, str)
         for m in local_members:
             assert isinstance(m, QAPISchemaObjectTypeMember)
@@ -1375,8 +1378,8 @@ class QAPISchemaObjectTypeVariant(QAPISchemaObjectT=
ypeMember):
=20
=20
 class QAPISchemaAlternateType(QAPISchemaType):
-    def __init__(self, name, info, doc, variants):
-        QAPISchemaType.__init__(self, name, info, doc)
+    def __init__(self, name, info, doc, variants, ifcond):
+        QAPISchemaType.__init__(self, name, info, doc, ifcond)
         assert isinstance(variants, QAPISchemaObjectTypeVariants)
         assert variants.tag_member
         variants.set_owner(name)
@@ -1413,8 +1416,8 @@ class QAPISchemaAlternateType(QAPISchemaType):
=20
 class QAPISchemaCommand(QAPISchemaEntity):
     def __init__(self, name, info, doc, arg_type, ret_type,
-                 gen, success_response, boxed):
-        QAPISchemaEntity.__init__(self, name, info, doc)
+                 gen, success_response, boxed, ifcond):
+        QAPISchemaEntity.__init__(self, name, info, doc, ifcond)
         assert not arg_type or isinstance(arg_type, str)
         assert not ret_type or isinstance(ret_type, str)
         self._arg_type_name =3D arg_type
@@ -1451,8 +1454,8 @@ class QAPISchemaCommand(QAPISchemaEntity):
=20
=20
 class QAPISchemaEvent(QAPISchemaEntity):
-    def __init__(self, name, info, doc, arg_type, boxed):
-        QAPISchemaEntity.__init__(self, name, info, doc)
+    def __init__(self, name, info, doc, arg_type, boxed, ifcond):
+        QAPISchemaEntity.__init__(self, name, info, doc, ifcond)
         assert not arg_type or isinstance(arg_type, str)
         self._arg_type_name =3D arg_type
         self.arg_type =3D None
@@ -1547,11 +1550,11 @@ class QAPISchema(object):
     def _make_enum_members(self, values):
         return [QAPISchemaMember(v) for v in values]
=20
-    def _make_implicit_enum_type(self, name, info, values):
+    def _make_implicit_enum_type(self, name, info, values, ifcond):
         # See also QAPISchemaObjectTypeMember._pretty_owner()
         name =3D name + 'Kind'   # Use namespace reserved by add_name()
         self._def_entity(QAPISchemaEnumType(
-            name, info, None, self._make_enum_members(values), None))
+            name, info, None, self._make_enum_members(values), None, ifc=
ond))
         return name
=20
     def _make_array_type(self, element_type, info):
@@ -1560,22 +1563,29 @@ class QAPISchema(object):
             self._def_entity(QAPISchemaArrayType(name, info, element_typ=
e))
         return name
=20
-    def _make_implicit_object_type(self, name, info, doc, role, members)=
:
+    def _make_implicit_object_type(self, name, info, doc, role, members,
+                                   ifcond=3DNone):
         if not members:
             return None
         # See also QAPISchemaObjectTypeMember._pretty_owner()
         name =3D 'q_obj_%s-%s' % (name, role)
-        if not self.lookup_entity(name, QAPISchemaObjectType):
+        typ =3D self.lookup_entity(name, QAPISchemaObjectType)
+        if typ:
+            # FIXME: generating the disjunction of all conditions
+            assert ifcond =3D=3D typ.ifcond
+        else:
             self._def_entity(QAPISchemaObjectType(name, info, doc, None,
-                                                  members, None))
+                                                  members, None, ifcond)=
)
         return name
=20
     def _def_enum_type(self, expr, info, doc):
         name =3D expr['enum']
         data =3D expr['data']
         prefix =3D expr.get('prefix')
+        ifcond =3D expr.get('if')
         self._def_entity(QAPISchemaEnumType(
-            name, info, doc, self._make_enum_members(data), prefix))
+            name, info, doc, self._make_enum_members(data), prefix,
+            ifcond))
=20
     def _make_member(self, name, typ, info):
         optional =3D False
@@ -1595,9 +1605,10 @@ class QAPISchema(object):
         name =3D expr['struct']
         base =3D expr.get('base')
         data =3D expr['data']
+        ifcond =3D expr.get('if')
         self._def_entity(QAPISchemaObjectType(name, info, doc, base,
                                               self._make_members(data, i=
nfo),
-                                              None))
+                                              None, ifcond))
=20
     def _make_variant(self, case, typ):
         return QAPISchemaObjectTypeVariant(case, typ)
@@ -1606,19 +1617,23 @@ class QAPISchema(object):
         if isinstance(typ, list):
             assert len(typ) =3D=3D 1
             typ =3D self._make_array_type(typ[0], info)
+        type_entity =3D self.lookup_type(typ)
         typ =3D self._make_implicit_object_type(
-            typ, info, None, 'wrapper', [self._make_member('data', typ, =
info)])
+            typ, info, None, 'wrapper',
+            [self._make_member('data', typ, info)], type_entity.ifcond)
         return QAPISchemaObjectTypeVariant(case, typ)
=20
     def _def_union_type(self, expr, info, doc):
         name =3D expr['union']
         data =3D expr['data']
         base =3D expr.get('base')
+        ifcond =3D expr.get('if')
         tag_name =3D expr.get('discriminator')
         tag_member =3D None
         if isinstance(base, dict):
-            base =3D (self._make_implicit_object_type(
-                name, info, doc, 'base', self._make_members(base, info))=
)
+            base =3D self._make_implicit_object_type(
+                name, info, doc, 'base', self._make_members(base, info),
+                ifcond)
         if tag_name:
             variants =3D [self._make_variant(key, value)
                         for (key, value) in data.iteritems()]
@@ -1627,18 +1642,21 @@ class QAPISchema(object):
             variants =3D [self._make_simple_variant(key, value, info)
                         for (key, value) in data.iteritems()]
             typ =3D self._make_implicit_enum_type(name, info,
-                                                [v.name for v in variant=
s])
+                                                [v.name for v in variant=
s],
+                                                ifcond)
             tag_member =3D QAPISchemaObjectTypeMember('type', typ, False=
)
             members =3D [tag_member]
         self._def_entity(
             QAPISchemaObjectType(name, info, doc, base, members,
                                  QAPISchemaObjectTypeVariants(tag_name,
                                                               tag_member=
,
-                                                              variants))=
)
+                                                              variants),
+                                 ifcond))
=20
     def _def_alternate_type(self, expr, info, doc):
         name =3D expr['alternate']
         data =3D expr['data']
+        ifcond =3D expr.get('if')
         variants =3D [self._make_variant(key, value)
                     for (key, value) in data.iteritems()]
         tag_member =3D QAPISchemaObjectTypeMember('type', 'QType', False=
)
@@ -1646,7 +1664,8 @@ class QAPISchema(object):
             QAPISchemaAlternateType(name, info, doc,
                                     QAPISchemaObjectTypeVariants(None,
                                                                  tag_mem=
ber,
-                                                                 variant=
s)))
+                                                                 variant=
s),
+                                    ifcond))
=20
     def _def_command(self, expr, info, doc):
         name =3D expr['command']
@@ -1655,23 +1674,29 @@ class QAPISchema(object):
         gen =3D expr.get('gen', True)
         success_response =3D expr.get('success-response', True)
         boxed =3D expr.get('boxed', False)
+        ifcond =3D expr.get('if')
         if isinstance(data, OrderedDict):
             data =3D self._make_implicit_object_type(
-                name, info, doc, 'arg', self._make_members(data, info))
+                name, info, doc, 'arg', self._make_members(data, info),
+                ifcond)
         if isinstance(rets, list):
             assert len(rets) =3D=3D 1
             rets =3D self._make_array_type(rets[0], info)
         self._def_entity(QAPISchemaCommand(name, info, doc, data, rets,
-                                           gen, success_response, boxed)=
)
+                                           gen, success_response, boxed,
+                                           ifcond))
=20
     def _def_event(self, expr, info, doc):
         name =3D expr['event']
         data =3D expr.get('data')
         boxed =3D expr.get('boxed', False)
+        ifcond =3D expr.get('if')
         if isinstance(data, OrderedDict):
             data =3D self._make_implicit_object_type(
-                name, info, doc, 'arg', self._make_members(data, info))
-        self._def_entity(QAPISchemaEvent(name, info, doc, data, boxed))
+                name, info, doc, 'arg', self._make_members(data, info),
+                ifcond)
+        self._def_entity(QAPISchemaEvent(name, info, doc, data, boxed,
+                                         ifcond))
=20
     def _def_exprs(self):
         for expr_elem in self.exprs:
--=20
2.14.1.146.gd35faa819
