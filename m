Received: from eggs.gnu.org ([2001:4830:134:3::10]:60019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gVace-00059Y-RZ
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:18:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gVacd-0004F6-TR
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:18:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gVacd-0004Ey-Jq
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:18:11 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat,  8 Dec 2018 15:15:55 +0400
Message-Id: <20181208111606.8505-17-marcandre.lureau@redhat.com>
In-Reply-To: <20181208111606.8505-1-marcandre.lureau@redhat.com>
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0 v7 16/27] qapi: add 'if' to union
 members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Add 'if' key to union members:

{ 'union': 'TestIfUnion', 'data':
    'mem': { 'type': 'str', 'if': 'COND'} }

The generated code remains unconditional for now. Later patches
generate the conditionals.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/common.py                  | 17 +++++++++--------
 docs/devel/qapi-code-gen.txt            |  2 +-
 tests/qapi-schema/qapi-schema-test.json |  4 +++-
 tests/qapi-schema/qapi-schema-test.out  |  4 ++++
 tests/qapi-schema/test-qapi.py          |  1 +
 5 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index f79b3fad54..fd622313cb 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -823,7 +823,7 @@ def check_union(expr, info):
         check_name(info, "Member of union '%s'" % name, key)
         if isinstance(value, dict):
             check_known_keys(info, "member '%s' of union '%s'" % (key, n=
ame),
-                             value, ['type'], [])
+                             value, ['type'], ['if'])
             typ =3D value['type']
         else:
             typ =3D value
@@ -1513,8 +1513,8 @@ class QAPISchemaObjectTypeVariants(object):
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
@@ -1796,14 +1796,14 @@ class QAPISchema(object):
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
@@ -1821,10 +1821,11 @@ class QAPISchema(object):
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
diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index e6fff32241..6f2457a2e0 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -754,7 +754,7 @@ gets its generated code guarded like this:
=20
 Where a member can be defined with a single string value for its type,
 it is also possible to supply a dictionary instead with both 'type'
-and 'if' keys. (TODO: union and alternate)
+and 'if' keys. (TODO: alternate)
=20
 Example: a conditional 'bar' member
=20
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index b8565a3913..6e9e4e14d9 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -210,7 +210,9 @@
   [ 'foo', { 'name' : 'bar', 'if': 'defined(TEST_IF_ENUM_BAR)' } ],
   'if': 'defined(TEST_IF_ENUM)' }
=20
-{ 'union': 'TestIfUnion', 'data': { 'foo': 'TestStruct' },
+{ 'union': 'TestIfUnion', 'data':
+  { 'foo': 'TestStruct',
+    'union_bar': { 'type': 'str', 'if': 'defined(TEST_IF_UNION_BAR)'} },
   'if': 'defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)' }
=20
 { 'alternate': 'TestIfAlternate', 'data': { 'foo': 'int', 'bar': 'TestSt=
ruct' },
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 23fb078b85..a342ecfc55 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -280,11 +280,15 @@ object q_obj_TestStruct-wrapper
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
 alternate TestIfAlternate
     tag type
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index 27081cb50c..d592854601 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -68,6 +68,7 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
             print('    tag %s' % variants.tag_member.name)
             for v in variants.variants:
                 print('    case %s: %s' % (v.name, v.type.name))
+                QAPISchemaTestVisitor._print_if(v.ifcond, indent=3D8)
=20
     @staticmethod
     def _print_if(ifcond, indent=3D4):
--=20
2.20.0.rc1
