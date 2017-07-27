Received: from eggs.gnu.org ([2001:4830:134:3::10]:32873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dal4y-0000dQ-7L
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:52:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dal4v-0007Md-Co
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:52:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dal4v-0007Lb-1V
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:51:57 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 27 Jul 2017 17:41:10 +0200
Message-Id: <20170727154126.11339-11-marcandre.lureau@redhat.com>
In-Reply-To: <20170727154126.11339-1-marcandre.lureau@redhat.com>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/26] qapi: add 'if' condition on union variant
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py                         | 14 +++++++++-----
 scripts/qapi-introspect.py              |  3 ++-
 scripts/qapi-types.py                   |  2 ++
 scripts/qapi-visit.py                   |  4 ++++
 tests/qapi-schema/qapi-schema-test.json |  6 +++++-
 tests/qapi-schema/qapi-schema-test.out  |  9 ++++++++-
 tests/qapi-schema/test-qapi.py          |  3 ++-
 7 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 1eb40590fb..333a5c0d1e 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1398,8 +1398,8 @@ class QAPISchemaObjectTypeVariants(object):
 class QAPISchemaObjectTypeVariant(QAPISchemaObjectTypeMember):
     role =3D 'branch'
=20
-    def __init__(self, name, typ):
-        QAPISchemaObjectTypeMember.__init__(self, name, typ, False)
+    def __init__(self, name, typ, ifcond=3DNone):
+        QAPISchemaObjectTypeMember.__init__(self, name, typ, False, ifco=
nd)
=20
=20
 class QAPISchemaAlternateType(QAPISchemaType):
@@ -1646,6 +1646,10 @@ class QAPISchema(object):
         return QAPISchemaObjectTypeVariant(case, typ)
=20
     def _make_simple_variant(self, case, typ, info):
+        ifcond =3D None
+        if isinstance(typ, dict):
+            ifcond =3D typ.get('if')
+            typ =3D typ['type']
         if isinstance(typ, list):
             assert len(typ) =3D=3D 1
             typ =3D self._make_array_type(typ[0], info)
@@ -1653,7 +1657,7 @@ class QAPISchema(object):
         typ =3D self._make_implicit_object_type(
             typ, info, None, 'wrapper',
             [self._make_member('data', typ, info)], type_entity.ifcond)
-        return QAPISchemaObjectTypeVariant(case, typ)
+        return QAPISchemaObjectTypeVariant(case, typ, ifcond)
=20
     def _def_union_type(self, expr, info, doc):
         name =3D expr['union']
@@ -1672,8 +1676,8 @@ class QAPISchema(object):
         else:
             variants =3D [self._make_simple_variant(key, value, info)
                         for (key, value) in data.iteritems()]
-            typ =3D self._make_implicit_enum_type(name, info,
-                                                [v.name for v in variant=
s],
+            values =3D [{'name': v.name, 'if': v.ifcond} for v in varian=
ts]
+            typ =3D self._make_implicit_enum_type(name, info, values,
                                                 expr.get('if'))
             tag_member =3D QAPISchemaObjectTypeMember('type', typ, False=
)
             members =3D [tag_member]
diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index 98b320a79e..a867ea5de1 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -139,7 +139,8 @@ const QLitObject %(c_name)s =3D %(c_string)s;
                 'variants': [self._gen_variant(v) for v in variants]}
=20
     def _gen_variant(self, variant):
-        return {'case': variant.name, 'type': self._use_type(variant.typ=
e)}
+        return ({'case': variant.name, 'type': self._use_type(variant.ty=
pe)},
+                variant.ifcond)
=20
     def visit_builtin_type(self, name, info, json_type):
         self._gen_qlit(name, 'builtin', {'json-type': json_type}, None)
diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index 659fb1da86..d6c8feb55a 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi-types.py
@@ -128,11 +128,13 @@ def gen_variants(variants):
                 c_name=3Dc_name(variants.tag_member.name))
=20
     for var in variants.variants:
+        ret +=3D gen_if(var.ifcond)
         ret +=3D mcgen('''
         %(c_type)s %(c_name)s;
 ''',
                      c_type=3Dvar.type.c_unboxed_type(),
                      c_name=3Dc_name(var.name))
+        ret +=3D gen_endif(var.ifcond)
=20
     ret +=3D mcgen('''
     } u;
diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index f400cef13c..0f5cae33e4 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -82,6 +82,7 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_name=
)s *obj, Error **errp)
                      c_name=3Dc_name(variants.tag_member.name))
=20
         for var in variants.variants:
+            ret +=3D gen_if(var.ifcond)
             ret +=3D mcgen('''
     case %(case)s:
         visit_type_%(c_type)s_members(v, &obj->u.%(c_name)s, &err);
@@ -92,6 +93,7 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_name=
)s *obj, Error **errp)
                                            variants.tag_member.type.pref=
ix),
                          c_type=3Dvar.type.c_name(), c_name=3Dc_name(var=
.name))
=20
+            ret +=3D gen_endif(var.ifcond)
         ret +=3D mcgen('''
     default:
         abort();
@@ -182,6 +184,7 @@ void visit_type_%(c_name)s(Visitor *v, const char *na=
me, %(c_name)s **obj, Error
                  c_name=3Dc_name(name))
=20
     for var in variants.variants:
+        ret +=3D gen_if(var.ifcond)
         ret +=3D mcgen('''
     case %(case)s:
 ''',
@@ -209,6 +212,7 @@ void visit_type_%(c_name)s(Visitor *v, const char *na=
me, %(c_name)s **obj, Error
         ret +=3D mcgen('''
         break;
 ''')
+        ret +=3D gen_endif(var.ifcond)
=20
     ret +=3D mcgen('''
     case QTYPE_NONE:
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index bb515280d2..01f7db58dc 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -199,9 +199,13 @@
   [ 'foo', { 'name' : 'bar', 'if': 'defined(TEST_IF_ENUM_BAR)' } ],
   'if': 'defined(TEST_IF_ENUM)' }
=20
-{ 'union': 'TestIfUnion', 'data': { 'foo': 'TestStruct' },
+{ 'union': 'TestIfUnion', 'data':
+  { 'foo': 'TestStruct', 'union_bar': { 'type': 'str', 'if': 'defined(TE=
ST_IF_UNION_BAR)'} },
   'if': 'defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)' }
=20
+{ 'command': 'TestIfUnionCmd', 'data': { 'union_cmd_arg': 'TestIfUnion' =
},
+  'if': 'defined(TEST_IF_UNION)' }
+
 { 'alternate': 'TestIfAlternate', 'data': { 'foo': 'int', 'bar': 'TestSt=
ruct' },
   'if': 'defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)' }
=20
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index b17c32a45f..7908eed6fc 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -73,8 +73,12 @@ object TestIfUnion
     member type: TestIfUnionKind optional=3DFalse
     tag type
     case foo: q_obj_TestStruct-wrapper
+    case union_bar: q_obj_str-wrapper if=3Ddefined(TEST_IF_UNION_BAR)
     if defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)
-enum TestIfUnionKind ['foo']
+command TestIfUnionCmd q_obj_TestIfUnionCmd-arg -> None
+   gen=3DTrue success_response=3DTrue boxed=3DFalse
+    if defined(TEST_IF_UNION)
+enum TestIfUnionKind ['foo', ('union_bar', 'defined(TEST_IF_UNION_BAR)')=
]
     if defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)
 object TestStruct
     member integer: int optional=3DFalse
@@ -204,6 +208,9 @@ object q_obj_TestIfEvent-arg
     member foo: TestIfStruct optional=3DFalse
     member bar: TestIfEnum optional=3DFalse if=3DTEST_IF_EVT_BAR
     if defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)
+object q_obj_TestIfUnionCmd-arg
+    member union_cmd_arg: TestIfUnion optional=3DFalse
+    if defined(TEST_IF_UNION)
 object q_obj_TestStruct-wrapper
     member data: TestStruct optional=3DFalse
 object q_obj_UserDefFlatUnion2-base
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index 5d2f67a1d3..b360d44df1 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -59,7 +59,8 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
         if variants:
             print '    tag %s' % variants.tag_member.name
             for v in variants.variants:
-                print '    case %s: %s' % (v.name, v.type.name)
+                print '    case %s: %s' % (v.name, v.type.name) + \
+                    (' if=3D%s' % v.ifcond if v.ifcond else '')
=20
     @staticmethod
     def _print_if(ifcond):
--=20
2.14.0.rc0.1.g40ca67566
