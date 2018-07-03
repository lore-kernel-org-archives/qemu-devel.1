Received: from eggs.gnu.org ([2001:4830:134:3::10]:44210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSVD-0000ya-OU
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:06:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSV8-0000PM-05
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:06:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33648 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faSV7-0000Oh-Q9
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:06:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6AC25401CC41
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 21:06:17 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 23:06:01 +0200
Message-Id: <20180703210613.25619-3-armbru@redhat.com>
In-Reply-To: <20180703210613.25619-1-armbru@redhat.com>
References: <20180703210613.25619-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/14] qapi: pass 'if' condition into
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Built-in objects remain unconditional.  Explicitly defined objects use
the condition specified in the schema.  Implicitly defined objects
inherit their condition from their users.  For most of them, there is
exactly one user, so the condition to use is obvious.  The exception
is wrapped types generated for simple union variants, which can be
shared by any number of simple unions.  The tight condition would be
the disjunction of the conditions of these simple unions.  For now,
use the wrapped type's condition instead.  Much simpler and good
enough for now.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180703155648.11933-3-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py | 97 ++++++++++++++++++++++++++++--------------
 1 file changed, 65 insertions(+), 32 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 991045a478..4f4014b387 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1001,8 +1001,16 @@ def check_exprs(exprs):
 # Schema compiler frontend
 #
=20
+def listify_cond(ifcond):
+    if not ifcond:
+        return []
+    if not isinstance(ifcond, list):
+        return [ifcond]
+    return ifcond
+
+
 class QAPISchemaEntity(object):
-    def __init__(self, name, info, doc):
+    def __init__(self, name, info, doc, ifcond=3DNone):
         assert name is None or isinstance(name, str)
         self.name =3D name
         self.module =3D None
@@ -1013,6 +1021,7 @@ class QAPISchemaEntity(object):
         # such place).
         self.info =3D info
         self.doc =3D doc
+        self.ifcond =3D listify_cond(ifcond)
=20
     def c_name(self):
         return c_name(self.name)
@@ -1145,8 +1154,8 @@ class QAPISchemaBuiltinType(QAPISchemaType):
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
@@ -1181,7 +1190,7 @@ class QAPISchemaEnumType(QAPISchemaType):
=20
 class QAPISchemaArrayType(QAPISchemaType):
     def __init__(self, name, info, element_type):
-        QAPISchemaType.__init__(self, name, info, None)
+        QAPISchemaType.__init__(self, name, info, None, None)
         assert isinstance(element_type, str)
         self._element_type_name =3D element_type
         self.element_type =3D None
@@ -1189,6 +1198,7 @@ class QAPISchemaArrayType(QAPISchemaType):
     def check(self, schema):
         self.element_type =3D schema.lookup_type(self._element_type_name=
)
         assert self.element_type
+        self.ifcond =3D self.element_type.ifcond
=20
     def is_implicit(self):
         return True
@@ -1210,11 +1220,12 @@ class QAPISchemaArrayType(QAPISchemaType):
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
@@ -1410,8 +1421,8 @@ class QAPISchemaObjectTypeVariant(QAPISchemaObjectT=
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
@@ -1447,9 +1458,9 @@ class QAPISchemaAlternateType(QAPISchemaType):
=20
=20
 class QAPISchemaCommand(QAPISchemaEntity):
-    def __init__(self, name, info, doc, arg_type, ret_type,
+    def __init__(self, name, info, doc, ifcond, arg_type, ret_type,
                  gen, success_response, boxed, allow_oob, allow_preconfi=
g):
-        QAPISchemaEntity.__init__(self, name, info, doc)
+        QAPISchemaEntity.__init__(self, name, info, doc, ifcond)
         assert not arg_type or isinstance(arg_type, str)
         assert not ret_type or isinstance(ret_type, str)
         self._arg_type_name =3D arg_type
@@ -1490,8 +1501,8 @@ class QAPISchemaCommand(QAPISchemaEntity):
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
@@ -1590,22 +1601,22 @@ class QAPISchema(object):
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
@@ -1614,22 +1625,37 @@ class QAPISchema(object):
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
@@ -1649,7 +1675,8 @@ class QAPISchema(object):
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
@@ -1661,18 +1688,21 @@ class QAPISchema(object):
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
                         for (key, value) in data.items()]
@@ -1680,12 +1710,12 @@ class QAPISchema(object):
         else:
             variants =3D [self._make_simple_variant(key, value, info)
                         for (key, value) in data.items()]
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
@@ -1693,11 +1723,12 @@ class QAPISchema(object):
     def _def_alternate_type(self, expr, info, doc):
         name =3D expr['alternate']
         data =3D expr['data']
+        ifcond =3D expr.get('if')
         variants =3D [self._make_variant(key, value)
                     for (key, value) in data.items()]
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
@@ -1711,13 +1742,14 @@ class QAPISchema(object):
         boxed =3D expr.get('boxed', False)
         allow_oob =3D expr.get('allow-oob', False)
         allow_preconfig =3D expr.get('allow-preconfig', False)
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
                                            gen, success_response,
                                            boxed, allow_oob, allow_preco=
nfig))
=20
@@ -1725,10 +1757,11 @@ class QAPISchema(object):
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
     def _def_exprs(self, exprs):
         for expr_elem in exprs:
--=20
2.17.1
