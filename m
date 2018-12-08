Received: from eggs.gnu.org ([2001:4830:134:3::10]:60156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gVacy-0005Q8-Bp
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:18:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gVacw-0004ct-IB
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:18:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gVacw-0004cQ-75
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:18:30 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat,  8 Dec 2018 15:15:58 +0400
Message-Id: <20181208111606.8505-20-marcandre.lureau@redhat.com>
In-Reply-To: <20181208111606.8505-1-marcandre.lureau@redhat.com>
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0 v7 19/27] qapi: add 'if' to alternate
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

Add 'if' key to alternate members:

{ 'alternate': 'TestIfAlternate', 'data':
  { 'alt': { 'type': 'TestStruct', 'if': 'COND' } } }

Generated code is not changed by this patch but with "qapi: add #if
conditions to generated code".

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/common.py                  | 10 +++++-----
 docs/devel/qapi-code-gen.txt            |  2 +-
 tests/qapi-schema/qapi-schema-test.json |  4 +++-
 tests/qapi-schema/qapi-schema-test.out  |  1 +
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 44020779dd..a70d6dec3b 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -857,7 +857,7 @@ def check_alternate(expr, info):
         if isinstance(value, dict):
             check_known_keys(info,
                              "member '%s' of alternate '%s'" % (key, nam=
e),
-                             value, ['type'], [])
+                             value, ['type'], ['if'])
             typ =3D value['type']
         else:
             typ =3D value
@@ -1784,8 +1784,8 @@ class QAPISchema(object):
                                               self._make_members(data, i=
nfo),
                                               None))
=20
-    def _make_variant(self, case, typ):
-        return QAPISchemaObjectTypeVariant(case, typ)
+    def _make_variant(self, case, typ, ifcond):
+        return QAPISchemaObjectTypeVariant(case, typ, ifcond)
=20
     def _make_simple_variant(self, case, typ, ifcond, info):
         if isinstance(typ, list):
@@ -1808,7 +1808,7 @@ class QAPISchema(object):
                 name, info, doc, ifcond,
                 'base', self._make_members(base, info))
         if tag_name:
-            variants =3D [self._make_variant(key, value['type'])
+            variants =3D [self._make_variant(key, value['type'], value.g=
et('if'))
                         for (key, value) in data.items()]
             members =3D []
         else:
@@ -1829,7 +1829,7 @@ class QAPISchema(object):
         name =3D expr['alternate']
         data =3D expr['data']
         ifcond =3D expr.get('if')
-        variants =3D [self._make_variant(key, value['type'])
+        variants =3D [self._make_variant(key, value['type'], value.get('=
if'))
                     for (key, value) in data.items()]
         tag_member =3D QAPISchemaObjectTypeMember('type', 'QType', False=
)
         self._def_entity(
diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 6f2457a2e0..5ea62cb111 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -754,7 +754,7 @@ gets its generated code guarded like this:
=20
 Where a member can be defined with a single string value for its type,
 it is also possible to supply a dictionary instead with both 'type'
-and 'if' keys. (TODO: alternate)
+and 'if' keys.
=20
 Example: a conditional 'bar' member
=20
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index 0d28475f4c..d58cc49028 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -218,7 +218,9 @@
 { 'command': 'TestIfUnionCmd', 'data': { 'union_cmd_arg': 'TestIfUnion' =
},
   'if': 'defined(TEST_IF_UNION)' }
=20
-{ 'alternate': 'TestIfAlternate', 'data': { 'foo': 'int', 'bar': 'TestSt=
ruct' },
+{ 'alternate': 'TestIfAlternate', 'data':
+  { 'foo': 'int',
+    'bar': { 'type': 'TestStruct', 'if': 'defined(TEST_IF_ALT_BAR)'} },
   'if': 'defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)' }
=20
 { 'command': 'TestIfCmd', 'data':
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index aedc668aa4..59d7ed17a1 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -300,6 +300,7 @@ alternate TestIfAlternate
     tag type
     case foo: int
     case bar: TestStruct
+        if ['defined(TEST_IF_ALT_BAR)']
     if ['defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)']
 object q_obj_TestIfCmd-arg
     member foo: TestIfStruct optional=3DFalse
--=20
2.20.0.rc1
