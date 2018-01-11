Received: from eggs.gnu.org ([2001:4830:134:3::10]:51454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkWJ-0007Rn-I8
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkWE-00049L-II
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkWE-00047d-8c
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:14 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:29 +0100
Message-Id: <20180111213250.16511-31-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 30/51] qapi: add 'if' to alternate members
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

Add 'if' key to alternate members:

{ 'alternate': 'TestIfAlternate', 'data':
  { 'alt': { 'type': 'TestStruct', 'if': 'COND' } } }

Generated code is not changed by this patch but with "qapi: add #if
conditions to generated code".

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py                         | 10 +++++-----
 tests/qapi-schema/qapi-schema-test.json |  6 +++++-
 tests/qapi-schema/qapi-schema-test.out  |  9 ++++++++-
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 24d6aef13f..f24cf8bda6 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -840,7 +840,7 @@ def check_alternate(expr, info):
     for (key, value) in members.items():
         check_name(info, "Member of alternate '%s'" % name, key)
         source =3D "Member '%s' of alternate '%s'" % (key, name)
-        check_known_keys(info, source, value, ['type'], [])
+        check_known_keys(info, source, value, ['type'], ['if'])
         typ =3D value['type']
=20
         # Ensure alternates have no type conflicts.
@@ -1719,8 +1719,8 @@ class QAPISchema(object):
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
@@ -1743,7 +1743,7 @@ class QAPISchema(object):
                 name, info, doc, ifcond,
                 'base', self._make_members(base, info))
         if tag_name:
-            variants =3D [self._make_variant(key, value['type'])
+            variants =3D [self._make_variant(key, value['type'], value.g=
et('if'))
                         for (key, value) in data.iteritems()]
             members =3D []
         else:
@@ -1764,7 +1764,7 @@ class QAPISchema(object):
         name =3D expr['alternate']
         data =3D expr['data']
         ifcond =3D expr.get('if')
-        variants =3D [self._make_variant(key, value['type'])
+        variants =3D [self._make_variant(key, value['type'], value.get('=
if'))
                     for (key, value) in data.iteritems()]
         tag_member =3D QAPISchemaObjectTypeMember('type', 'QType', False=
)
         self._def_entity(
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index b4b8a0a2cc..cd33c084cb 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -208,9 +208,13 @@
 { 'command': 'TestIfUnionCmd', 'data': { 'union_cmd_arg': 'TestIfUnion' =
},
   'if': 'defined(TEST_IF_UNION)' }
=20
-{ 'alternate': 'TestIfAlternate', 'data': { 'foo': 'int', 'bar': 'TestSt=
ruct' },
+{ 'alternate': 'TestIfAlternate', 'data':
+  { 'foo': 'int', 'alt_bar': { 'type': 'TestStruct', 'if': 'defined(TEST=
_IF_ALT_BAR)'} },
   'if': 'defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)' }
=20
+{ 'command': 'TestIfAlternateCmd', 'data': { 'alt_cmd_arg': 'TestIfAlter=
nate' },
+  'if': 'defined(TEST_IF_ALT)' }
+
 { 'command': 'TestIfCmd', 'data':
   { 'foo': 'TestIfStruct',
     'bar': { 'type': 'TestIfEnum', 'if': 'defined(TEST_IF_CMD_BAR)' } },
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 001fa143cd..7215aeb4a6 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -67,8 +67,12 @@ enum QType
 alternate TestIfAlternate
     tag type
     case foo: int
-    case bar: TestStruct
+    case alt_bar: TestStruct
+        if ['defined(TEST_IF_ALT_BAR)']
     if ['defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)']
+command TestIfAlternateCmd q_obj_TestIfAlternateCmd-arg -> None
+   gen=3DTrue success_response=3DTrue boxed=3DFalse
+    if ['defined(TEST_IF_ALT)']
 command TestIfCmd q_obj_TestIfCmd-arg -> None
    gen=3DTrue success_response=3DTrue boxed=3DFalse
     if ['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)']
@@ -236,6 +240,9 @@ object q_obj_EVENT_D-arg
     member b: str optional=3DFalse
     member c: str optional=3DTrue
     member enum3: EnumOne optional=3DTrue
+object q_obj_TestIfAlternateCmd-arg
+    member alt_cmd_arg: TestIfAlternate optional=3DFalse
+    if ['defined(TEST_IF_ALT)']
 object q_obj_TestIfCmd-arg
     member foo: TestIfStruct optional=3DFalse
     member bar: TestIfEnum optional=3DFalse
--=20
2.16.0.rc1.1.gef27df75a1
