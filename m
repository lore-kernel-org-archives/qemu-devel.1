Received: from eggs.gnu.org ([2001:4830:134:3::10]:49784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkU8-0005Vh-8Q
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:34:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkU5-0001T9-1M
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:34:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkU4-0001SG-NI
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:34:00 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:05 +0100
Message-Id: <20180111213250.16511-7-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 06/51] qapi: pass 'if' condition into
 QAPISchemaEntity objects
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

Built-in objects remain unconditional.  Explicitly defined objects
use the condition specified in the schema.  Implicitly defined
objects inherit their condition from their users.  For most of them,
there is exactly one user, so the condition to use is obvious.  The
exception is the wrapped type's generated for simple union variants,
which can be shared by any number of simple unions.  The tight
condition would be the disjunction of the conditions of these simple
unions.  For now, use wrapped type's condition instead.  Much
simpler and good enough for now.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi.py | 98 ++++++++++++++++++++++++++++++++++++++-------------=
------
 1 file changed, 66 insertions(+), 32 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 27df0fcf48..8f54dead8d 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -991,8 +991,17 @@ def check_exprs(exprs):
 # Schema compiler frontend
 #
=20
+def listify_cond(ifcond):
+    if not ifcond:
+        return []
+    elif not isinstance(ifcond, list):
+        return [ifcond]
+    else:
+        return ifcond
+
+
 class QAPISchemaEntity(object):
-    def __init__(self, name, info, doc):
+    def __init__(self, name, info, doc, ifcond=3DNone):
         assert isinstance(name, str)
         self.name =3D name
         # For explicitly defined entities, info points to the (explicit)
@@ -1002,6 +1011,7 @@ class QAPISchemaEntity(object):
         # such place).
         self.info =3D info
         self.doc =3D doc
+        self.ifcond =3D listify_cond(ifcond)
=20
     def c_name(self):
         return c_name(self.name)
@@ -1118,8 +1128,8 @@ class QAPISchemaBuiltinType(QAPISchemaType):
=20
=20
 class QAPISchemaEnumType(QAPISchemaType):
-    def __init__(self, name, info, doc, values, prefix):
-        QAPISchemaType.__init__(self, name, info, doc)
+    def __init__(self, name, info, doc, ifcond, values, prefix):
+        QAPISchemaType.__init__(self, name, info, doc, ifcond)
         for v in values:
             assert isinstance(v, QAPISchemaMember)
             v.set_owner(name)
@@ -1154,7 +1164,7 @@ class QAPISchemaEnumType(QAPISchemaType):
=20
 class QAPISchemaArrayType(QAPISchemaType):
     def __init__(self, name, info, element_type):
-        QAPISchemaType.__init__(self, name, info, None)
+        QAPISchemaType.__init__(self, name, info, None, None)
         assert isinstance(element_type, str)
         self._element_type_name =3D element_type
         self.element_type =3D None
@@ -1162,6 +1172,7 @@ class QAPISchemaArrayType(QAPISchemaType):
     def check(self, schema):
         self.element_type =3D schema.lookup_type(self._element_type_name=
)
         assert self.element_type
+        self.ifcond =3D self.element_type.ifcond
=20
     def is_implicit(self):
         return True
@@ -1183,11 +1194,12 @@ class QAPISchemaArrayType(QAPISchemaType):
=20
=20
 class QAPISchemaObjectType(QAPISchemaType):
-    def __init__(self, name, info, doc, base, local_members, variants):
+    def __init__(self, name, info, doc, ifcond,
+                 base, local_members, variants):
         # struct has local_members, optional base, and no variants
         # flat union has base, variants, and no local_members
         # simple union has local_members, variants, and no base
-        QAPISchemaType.__init__(self, name, info, doc)
+        QAPISchemaType.__init__(self, name, info, doc, ifcond)
         assert base is None or isinstance(base, str)
         for m in local_members:
             assert isinstance(m, QAPISchemaObjectTypeMember)
@@ -1375,8 +1387,8 @@ class QAPISchemaObjectTypeVariant(QAPISchemaObjectT=
ypeMember):
=20
=20
 class QAPISchemaAlternateType(QAPISchemaType):
-    def __init__(self, name, info, doc, variants):
-        QAPISchemaType.__init__(self, name, info, doc)
+    def __init__(self, name, info, doc, ifcond, variants):
+        QAPISchemaType.__init__(self, name, info, doc, ifcond)
         assert isinstance(variants, QAPISchemaObjectTypeVariants)
         assert variants.tag_member
         variants.set_owner(name)
@@ -1412,9 +1424,9 @@ class QAPISchemaAlternateType(QAPISchemaType):
=20
=20
 class QAPISchemaCommand(QAPISchemaEntity):
-    def __init__(self, name, info, doc, arg_type, ret_type,
+    def __init__(self, name, info, doc, ifcond, arg_type, ret_type,
                  gen, success_response, boxed):
-        QAPISchemaEntity.__init__(self, name, info, doc)
+        QAPISchemaEntity.__init__(self, name, info, doc, ifcond)
         assert not arg_type or isinstance(arg_type, str)
         assert not ret_type or isinstance(ret_type, str)
         self._arg_type_name =3D arg_type
@@ -1451,8 +1463,8 @@ class QAPISchemaCommand(QAPISchemaEntity):
=20
=20
 class QAPISchemaEvent(QAPISchemaEntity):
-    def __init__(self, name, info, doc, arg_type, boxed):
-        QAPISchemaEntity.__init__(self, name, info, doc)
+    def __init__(self, name, info, doc, ifcond, arg_type, boxed):
+        QAPISchemaEntity.__init__(self, name, info, doc, ifcond)
         assert not arg_type or isinstance(arg_type, str)
         self._arg_type_name =3D arg_type
         self.arg_type =3D None
@@ -1536,22 +1548,22 @@ class QAPISchema(object):
                   ('null',   'null',    'QNull' + pointer_suffix)]:
             self._def_builtin_type(*t)
         self.the_empty_object_type =3D QAPISchemaObjectType(
-            'q_empty', None, None, None, [], None)
+            'q_empty', None, None, None, None, [], None)
         self._def_entity(self.the_empty_object_type)
         qtype_values =3D self._make_enum_members(['none', 'qnull', 'qnum=
',
                                                 'qstring', 'qdict', 'qli=
st',
                                                 'qbool'])
-        self._def_entity(QAPISchemaEnumType('QType', None, None,
+        self._def_entity(QAPISchemaEnumType('QType', None, None, None,
                                             qtype_values, 'QTYPE'))
=20
     def _make_enum_members(self, values):
         return [QAPISchemaMember(v) for v in values]
=20
-    def _make_implicit_enum_type(self, name, info, values):
+    def _make_implicit_enum_type(self, name, info, ifcond, values):
         # See also QAPISchemaObjectTypeMember._pretty_owner()
         name =3D name + 'Kind'   # Use namespace reserved by add_name()
         self._def_entity(QAPISchemaEnumType(
-            name, info, None, self._make_enum_members(values), None))
+            name, info, None, ifcond, self._make_enum_members(values), N=
one))
         return name
=20
     def _make_array_type(self, element_type, info):
@@ -1560,22 +1572,37 @@ class QAPISchema(object):
             self._def_entity(QAPISchemaArrayType(name, info, element_typ=
e))
         return name
=20
-    def _make_implicit_object_type(self, name, info, doc, role, members)=
:
+    def _make_implicit_object_type(self, name, info, doc, ifcond,
+                                   role, members):
         if not members:
             return None
         # See also QAPISchemaObjectTypeMember._pretty_owner()
         name =3D 'q_obj_%s-%s' % (name, role)
-        if not self.lookup_entity(name, QAPISchemaObjectType):
-            self._def_entity(QAPISchemaObjectType(name, info, doc, None,
-                                                  members, None))
+        typ =3D self.lookup_entity(name, QAPISchemaObjectType)
+        if typ:
+            # The implicit object type has multiple users.  This can
+            # happen only for simple unions' implicit wrapper types.
+            # Its ifcond should be the disjunction of its user's
+            # ifconds.  Not implemented.  Instead, we always pass the
+            # wrapped type's ifcond, which is trivially the same for all
+            # users.  It's also necessary for the wrapper to compile.
+            # But it's not tight: the disjunction need not imply it.  We
+            # may end up compiling useless wrapper types.
+            # TODO kill simple unions or implement the disjunction
+            assert ifcond =3D=3D typ.ifcond
+        else:
+            self._def_entity(QAPISchemaObjectType(name, info, doc, ifcon=
d,
+                                                  None, members, None))
         return name
=20
     def _def_enum_type(self, expr, info, doc):
         name =3D expr['enum']
         data =3D expr['data']
         prefix =3D expr.get('prefix')
+        ifcond =3D expr.get('if')
         self._def_entity(QAPISchemaEnumType(
-            name, info, doc, self._make_enum_members(data), prefix))
+            name, info, doc, ifcond,
+            self._make_enum_members(data), prefix))
=20
     def _make_member(self, name, typ, info):
         optional =3D False
@@ -1595,7 +1622,8 @@ class QAPISchema(object):
         name =3D expr['struct']
         base =3D expr.get('base')
         data =3D expr['data']
-        self._def_entity(QAPISchemaObjectType(name, info, doc, base,
+        ifcond =3D expr.get('if')
+        self._def_entity(QAPISchemaObjectType(name, info, doc, ifcond, b=
ase,
                                               self._make_members(data, i=
nfo),
                                               None))
=20
@@ -1607,18 +1635,21 @@ class QAPISchema(object):
             assert len(typ) =3D=3D 1
             typ =3D self._make_array_type(typ[0], info)
         typ =3D self._make_implicit_object_type(
-            typ, info, None, 'wrapper', [self._make_member('data', typ, =
info)])
+            typ, info, None, self.lookup_type(typ).ifcond,
+            'wrapper', [self._make_member('data', typ, info)])
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
+                name, info, doc, ifcond,
+                'base', self._make_members(base, info))
         if tag_name:
             variants =3D [self._make_variant(key, value)
                         for (key, value) in data.iteritems()]
@@ -1626,12 +1657,12 @@ class QAPISchema(object):
         else:
             variants =3D [self._make_simple_variant(key, value, info)
                         for (key, value) in data.iteritems()]
-            typ =3D self._make_implicit_enum_type(name, info,
+            typ =3D self._make_implicit_enum_type(name, info, ifcond,
                                                 [v.name for v in variant=
s])
             tag_member =3D QAPISchemaObjectTypeMember('type', typ, False=
)
             members =3D [tag_member]
         self._def_entity(
-            QAPISchemaObjectType(name, info, doc, base, members,
+            QAPISchemaObjectType(name, info, doc, ifcond, base, members,
                                  QAPISchemaObjectTypeVariants(tag_name,
                                                               tag_member=
,
                                                               variants))=
)
@@ -1639,11 +1670,12 @@ class QAPISchema(object):
     def _def_alternate_type(self, expr, info, doc):
         name =3D expr['alternate']
         data =3D expr['data']
+        ifcond =3D expr.get('if')
         variants =3D [self._make_variant(key, value)
                     for (key, value) in data.iteritems()]
         tag_member =3D QAPISchemaObjectTypeMember('type', 'QType', False=
)
         self._def_entity(
-            QAPISchemaAlternateType(name, info, doc,
+            QAPISchemaAlternateType(name, info, doc, ifcond,
                                     QAPISchemaObjectTypeVariants(None,
                                                                  tag_mem=
ber,
                                                                  variant=
s)))
@@ -1655,23 +1687,25 @@ class QAPISchema(object):
         gen =3D expr.get('gen', True)
         success_response =3D expr.get('success-response', True)
         boxed =3D expr.get('boxed', False)
+        ifcond =3D expr.get('if')
         if isinstance(data, OrderedDict):
             data =3D self._make_implicit_object_type(
-                name, info, doc, 'arg', self._make_members(data, info))
+                name, info, doc, ifcond, 'arg', self._make_members(data,=
 info))
         if isinstance(rets, list):
             assert len(rets) =3D=3D 1
             rets =3D self._make_array_type(rets[0], info)
-        self._def_entity(QAPISchemaCommand(name, info, doc, data, rets,
+        self._def_entity(QAPISchemaCommand(name, info, doc, ifcond, data=
, rets,
                                            gen, success_response, boxed)=
)
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
+                name, info, doc, ifcond, 'arg', self._make_members(data,=
 info))
+        self._def_entity(QAPISchemaEvent(name, info, doc, ifcond, data, =
boxed))
=20
     def _def_exprs(self):
         for expr_elem in self.exprs:
--=20
2.16.0.rc1.1.gef27df75a1
