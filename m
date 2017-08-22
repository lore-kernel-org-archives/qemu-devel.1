Received: from eggs.gnu.org ([2001:4830:134:3::10]:55181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9JL-000821-B3
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:33:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9JI-0006xX-53
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:33:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dk9JH-0006wi-Sk
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:33:36 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:36 +0200
Message-Id: <20170822132255.23945-36-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 35/54] qapi: add 'if' on union variants
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
 tests/qapi-schema/qapi-schema-test.json |  6 +++++-
 tests/qapi-schema/qapi-schema-test.out  |  9 ++++++++-
 tests/qapi-schema/test-qapi.py          |  3 ++-
 4 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 946df83854..cd5d151809 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1397,8 +1397,8 @@ class QAPISchemaObjectTypeVariants(object):
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
@@ -1647,6 +1647,10 @@ class QAPISchema(object):
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
@@ -1654,7 +1658,7 @@ class QAPISchema(object):
         typ =3D self._make_implicit_object_type(
             typ, info, None, 'wrapper',
             [self._make_member('data', typ, info)], type_entity.ifcond)
-        return QAPISchemaObjectTypeVariant(case, typ)
+        return QAPISchemaObjectTypeVariant(case, typ, ifcond)
=20
     def _def_union_type(self, expr, info, doc):
         name =3D expr['union']
@@ -1674,8 +1678,8 @@ class QAPISchema(object):
         else:
             variants =3D [self._make_simple_variant(key, value, info)
                         for (key, value) in data.iteritems()]
-            typ =3D self._make_implicit_enum_type(name, info,
-                                                [v.name for v in variant=
s],
+            values =3D [{'name': v.name, 'if': v.ifcond} for v in varian=
ts]
+            typ =3D self._make_implicit_enum_type(name, info, values,
                                                 ifcond)
             tag_member =3D QAPISchemaObjectTypeMember('type', typ, False=
)
             members =3D [tag_member]
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index b136e4855f..23dae79f92 100644
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
index 5d2f18e4aa..12fc5a4425 100644
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
     member bar: TestIfEnum optional=3DFalse if=3Ddefined(TEST_IF_EVT_BAR=
)
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
2.14.1.146.gd35faa819
