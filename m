Received: from eggs.gnu.org ([2001:4830:134:3::10]:48722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycJ6-0005lR-HU
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycJ4-0008Ev-5o
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46150 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eycJ4-0008Eb-0f
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8EE45A1BEB
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 11:53:25 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 12:51:49 +0100
Message-Id: <20180321115211.17937-28-marcandre.lureau@redhat.com>
In-Reply-To: <20180321115211.17937-1-marcandre.lureau@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 27/49] qapi: add 'if' on union members
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

Add 'if' key to union members:

{ 'union': 'TestIfUnion', 'data':
    'mem': { 'type': 'str', 'if': 'COND'} }

Generated code is not changed by this patch but with "qapi: add #if
conditions to generated code".

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/common.py                  | 17 +++++++++--------
 tests/qapi-schema/qapi-schema-test.json |  7 ++++++-
 tests/qapi-schema/qapi-schema-test.out  | 10 ++++++++++
 tests/qapi-schema/test-qapi.py          |  1 +
 4 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index d75dfbf97a..224e911085 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -811,7 +811,7 @@ def check_union(expr, info):
     for (key, value) in members.items():
         source =3D "Member of union '%s'" % name
         check_name(info, source, key)
-        check_known_keys(info, source, value, ['type'], [])
+        check_known_keys(info, source, value, ['type'], ['if'])
         typ =3D value['type']
=20
         # Each value must name a known type
@@ -1492,8 +1492,8 @@ class QAPISchemaObjectTypeVariants(object):
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
@@ -1767,14 +1767,14 @@ class QAPISchema(object):
     def _make_variant(self, case, typ):
         return QAPISchemaObjectTypeVariant(case, typ)
=20
-    def _make_simple_variant(self, case, typ, info):
+    def _make_simple_variant(self, case, typ, ifcond, info):
         if isinstance(typ, list):
             assert len(typ) =3D=3D 1
             typ =3D self._make_array_type(typ[0], info)
         typ =3D self._make_implicit_object_type(
             typ, info, None, self.lookup_type(typ),
             'wrapper', [self._make_member('data', typ, None, info)])
-        return QAPISchemaObjectTypeVariant(case, typ)
+        return QAPISchemaObjectTypeVariant(case, typ, ifcond)
=20
     def _def_union_type(self, expr, info, doc):
         name =3D expr['union']
@@ -1792,10 +1792,11 @@ class QAPISchema(object):
                         for (key, value) in data.items()]
             members =3D []
         else:
-            variants =3D [self._make_simple_variant(key, value['type'], =
info)
+            variants =3D [self._make_simple_variant(key, value['type'],
+                                                  value.get('if'), info)
                         for (key, value) in data.items()]
-            typ =3D self._make_implicit_enum_type(name, info, ifcond,
-                                                [v.name for v in variant=
s])
+            enum =3D [{'name': v.name, 'if': v.ifcond} for v in variants=
]
+            typ =3D self._make_implicit_enum_type(name, info, ifcond, en=
um)
             tag_member =3D QAPISchemaObjectTypeMember('type', typ, False=
)
             members =3D [tag_member]
         self._def_entity(
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index e29c9f0769..b4b8a0a2cc 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -200,9 +200,14 @@
   [ 'foo', { 'name' : 'bar', 'if': 'defined(TEST_IF_ENUM_BAR)' } ],
   'if': 'defined(TEST_IF_ENUM)' }
=20
-{ 'union': 'TestIfUnion', 'data': { 'foo': 'TestStruct' },
+{ 'union': 'TestIfUnion', 'data':
+  { 'foo': 'TestStruct',
+    'union_bar': { 'type': 'str', 'if': 'defined(TEST_IF_UNION_BAR)'} },
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
index e1e41acd52..8dbcd6f24b 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -272,12 +272,22 @@ object q_obj_TestStruct-wrapper
     member data: TestStruct optional=3DFalse
 enum TestIfUnionKind
     member foo
+    member union_bar
+        if ['defined(TEST_IF_UNION_BAR)']
     if ['defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)']
 object TestIfUnion
     member type: TestIfUnionKind optional=3DFalse
     tag type
     case foo: q_obj_TestStruct-wrapper
+    case union_bar: q_obj_str-wrapper
+        if ['defined(TEST_IF_UNION_BAR)']
     if ['defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)']
+object q_obj_TestIfUnionCmd-arg
+    member union_cmd_arg: TestIfUnion optional=3DFalse
+    if ['defined(TEST_IF_UNION)']
+command TestIfUnionCmd q_obj_TestIfUnionCmd-arg -> None
+   gen=3DTrue success_response=3DTrue boxed=3DFalse
+    if ['defined(TEST_IF_UNION)']
 alternate TestIfAlternate
     tag type
     case foo: int
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index 9582742f90..4dfa8651c8 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -72,6 +72,7 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
             print('    tag %s' % variants.tag_member.name)
             for v in variants.variants:
                 print('    case %s: %s' % (v.name, v.type.name))
+                QAPISchemaTestVisitor._print_if(v.ifcond, 8)
=20
     @staticmethod
     def _print_if(ifcond, indent=3D4):
--=20
2.16.2.521.g9aa15f885a
