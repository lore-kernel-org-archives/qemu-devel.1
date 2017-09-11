Received: from eggs.gnu.org ([2001:4830:134:3::10]:43279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMZ4-0005wu-Kh
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:07:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMYy-0006kF-DL
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:07:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1drMYy-0006im-5l
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:07:36 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 11 Sep 2017 13:05:59 +0200
Message-Id: <20170911110623.24981-27-marcandre.lureau@redhat.com>
In-Reply-To: <20170911110623.24981-1-marcandre.lureau@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 26/50] qapi: add 'if' on union variants
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py                         | 15 ++++++++++-----
 tests/qapi-schema/qapi-schema-test.json |  7 ++++++-
 tests/qapi-schema/qapi-schema-test.out  |  8 ++++++++
 tests/qapi-schema/test-qapi.py          |  5 ++++-
 4 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 15711f96fa..2f14edfa1f 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1412,8 +1412,8 @@ class QAPISchemaObjectTypeVariants(object):
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
@@ -1674,13 +1674,18 @@ class QAPISchema(object):
         return QAPISchemaObjectTypeVariant(case, typ)
=20
     def _make_simple_variant(self, case, typ, info):
+        ifcond =3D None
+        if isinstance(typ, dict):
+            check_unknown_keys(info, typ, {'type', 'if'})
+            ifcond =3D typ.get('if')
+            typ =3D typ['type']
         if isinstance(typ, list):
             assert len(typ) =3D=3D 1
             typ =3D self._make_array_type(typ[0], info)
         typ =3D self._make_implicit_object_type(
             typ, info, None, self.lookup_type(typ).ifcond,
             'wrapper', [self._make_member('data', typ, info)])
-        return QAPISchemaObjectTypeVariant(case, typ)
+        return QAPISchemaObjectTypeVariant(case, typ, ifcond)
=20
     def _def_union_type(self, expr, info, doc):
         name =3D expr['union']
@@ -1700,8 +1705,8 @@ class QAPISchema(object):
         else:
             variants =3D [self._make_simple_variant(key, value, info)
                         for (key, value) in data.iteritems()]
-            typ =3D self._make_implicit_enum_type(name, info, ifcond,
-                                                [v.name for v in variant=
s])
+            values =3D [{'name': v.name, 'if': v.ifcond} for v in varian=
ts]
+            typ =3D self._make_implicit_enum_type(name, info, ifcond, va=
lues)
             tag_member =3D QAPISchemaObjectTypeMember('type', typ, False=
)
             members =3D [tag_member]
         self._def_entity(
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index 5cfccabb3d..895e80a978 100644
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
index 6df4e49c69..ee009c5626 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -87,9 +87,14 @@ object TestIfUnion
     member type: TestIfUnionKind optional=3DFalse
     tag type
     case foo: q_obj_TestStruct-wrapper
+    case union_bar: q_obj_str-wrapper if=3Ddefined(TEST_IF_UNION_BAR)
     if defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)
+command TestIfUnionCmd q_obj_TestIfUnionCmd-arg -> None
+   gen=3DTrue success_response=3DTrue boxed=3DFalse
+    if defined(TEST_IF_UNION)
 enum TestIfUnionKind
     member foo:
+    member union_bar: if=3Ddefined(TEST_IF_UNION_BAR)
     if defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)
 object TestStruct
     member integer: int optional=3DFalse
@@ -235,6 +240,9 @@ object q_obj_TestIfEvent-arg
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
index a86c3b5ee1..87a8efff78 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -65,7 +65,10 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
         if variants:
             print '    tag %s' % variants.tag_member.name
             for v in variants.variants:
-                print '    case %s: %s' % (v.name, v.type.name)
+                print '    case %s: %s' % (v.name, v.type.name),
+                if v.ifcond:
+                    print 'if=3D%s' % v.ifcond,
+                print
=20
     @staticmethod
     def _print_if(ifcond):
--=20
2.14.1.146.gd35faa819
