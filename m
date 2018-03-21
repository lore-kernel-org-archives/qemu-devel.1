Received: from eggs.gnu.org ([2001:4830:134:3::10]:48736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycJ7-0005mk-Sq
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycJ6-0008Ge-Ub
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46152 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eycJ6-0008GK-PS
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 54A0AA1BEB
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 11:53:28 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 12:51:50 +0100
Message-Id: <20180321115211.17937-29-marcandre.lureau@redhat.com>
In-Reply-To: <20180321115211.17937-1-marcandre.lureau@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 28/49] qapi: add 'if' to alternate members
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

Add 'if' key to alternate members:

{ 'alternate': 'TestIfAlternate', 'data':
  { 'alt': { 'type': 'TestStruct', 'if': 'COND' } } }

Generated code is not changed by this patch but with "qapi: add #if
conditions to generated code".

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/common.py                  | 10 +++++-----
 tests/qapi-schema/qapi-schema-test.json |  6 +++++-
 tests/qapi-schema/qapi-schema-test.out  |  9 ++++++++-
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 224e911085..c913c18d2d 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -848,7 +848,7 @@ def check_alternate(expr, info):
     for (key, value) in members.items():
         check_name(info, "Member of alternate '%s'" % name, key)
         source =3D "Member '%s' of alternate '%s'" % (key, name)
-        check_known_keys(info, source, value, ['type'], [])
+        check_known_keys(info, source, value, ['type'], ['if'])
         typ =3D value['type']
=20
         # Ensure alternates have no type conflicts.
@@ -1764,8 +1764,8 @@ class QAPISchema(object):
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
@@ -1788,7 +1788,7 @@ class QAPISchema(object):
                 name, info, doc, ifcond,
                 'base', self._make_members(base, info))
         if tag_name:
-            variants =3D [self._make_variant(key, value['type'])
+            variants =3D [self._make_variant(key, value['type'], value.g=
et('if'))
                         for (key, value) in data.items()]
             members =3D []
         else:
@@ -1809,7 +1809,7 @@ class QAPISchema(object):
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
index 8dbcd6f24b..657e487cbf 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -291,8 +291,15 @@ command TestIfUnionCmd q_obj_TestIfUnionCmd-arg -> N=
one
 alternate TestIfAlternate
     tag type
     case foo: int
-    case bar: TestStruct
+    case alt_bar: TestStruct
+        if ['defined(TEST_IF_ALT_BAR)']
     if ['defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)']
+object q_obj_TestIfAlternateCmd-arg
+    member alt_cmd_arg: TestIfAlternate optional=3DFalse
+    if ['defined(TEST_IF_ALT)']
+command TestIfAlternateCmd q_obj_TestIfAlternateCmd-arg -> None
+   gen=3DTrue success_response=3DTrue boxed=3DFalse
+    if ['defined(TEST_IF_ALT)']
 object q_obj_TestIfCmd-arg
     member foo: TestIfStruct optional=3DFalse
     member bar: TestIfEnum optional=3DFalse
--=20
2.16.2.521.g9aa15f885a
