Received: from eggs.gnu.org ([2001:4830:134:3::10]:48652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycIz-0005c4-2S
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycIx-0008Ay-RY
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51844 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eycIx-0008AY-MB
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3792440267D7
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 11:53:19 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 12:51:47 +0100
Message-Id: <20180321115211.17937-26-marcandre.lureau@redhat.com>
In-Reply-To: <20180321115211.17937-1-marcandre.lureau@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 25/49] qapi: add 'if' to implicit struct
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
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Generated code is not changed by this patch, but with "qapi: add #if
conditions to generated code" patch.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/common.py                  | 14 +++++++-------
 tests/qapi-schema/qapi-schema-test.json | 12 +++++++++---
 tests/qapi-schema/qapi-schema-test.out  |  5 +++++
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 3f46ed5530..bbcb417a47 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -713,7 +713,7 @@ def check_type(info, source, value, allow_array=3DFal=
se,
         # Todo: allow dictionaries to represent default values of
         # an optional argument.
         member_source =3D "Member '%s' of %s" % (key, source)
-        check_known_keys(info, member_source, arg, ['type'], [])
+        check_known_keys(info, member_source, arg, ['type'], ['if'])
         check_type(info, member_source, arg['type'], allow_array=3DTrue,
                    allow_metas=3D['built-in', 'union', 'alternate', 'str=
uct',
                                 'enum'])
@@ -1426,8 +1426,8 @@ class QAPISchemaMember(object):
=20
=20
 class QAPISchemaObjectTypeMember(QAPISchemaMember):
-    def __init__(self, name, typ, optional):
-        QAPISchemaMember.__init__(self, name)
+    def __init__(self, name, typ, optional, ifcond=3DNone):
+        QAPISchemaMember.__init__(self, name, ifcond)
         assert isinstance(typ, str)
         assert isinstance(optional, bool)
         self._type_name =3D typ
@@ -1734,7 +1734,7 @@ class QAPISchema(object):
             name, info, doc, ifcond,
             self._make_enum_members(data), prefix))
=20
-    def _make_member(self, name, typ, info):
+    def _make_member(self, name, typ, ifcond, info):
         optional =3D False
         if name.startswith('*'):
             name =3D name[1:]
@@ -1742,10 +1742,10 @@ class QAPISchema(object):
         if isinstance(typ, list):
             assert len(typ) =3D=3D 1
             typ =3D self._make_array_type(typ[0], info)
-        return QAPISchemaObjectTypeMember(name, typ, optional)
+        return QAPISchemaObjectTypeMember(name, typ, optional, ifcond)
=20
     def _make_members(self, data, info):
-        return [self._make_member(key, value['type'], info)
+        return [self._make_member(key, value['type'], value.get('if'), i=
nfo)
                 for (key, value) in data.items()]
=20
     def _def_struct_type(self, expr, info, doc):
@@ -1766,7 +1766,7 @@ class QAPISchema(object):
             typ =3D self._make_array_type(typ[0], info)
         typ =3D self._make_implicit_object_type(
             typ, info, None, self.lookup_type(typ),
-            'wrapper', [self._make_member('data', typ, info)])
+            'wrapper', [self._make_member('data', typ, None, info)])
         return QAPISchemaObjectTypeVariant(case, typ)
=20
     def _def_union_type(self, expr, info, doc):
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index 71023fb277..e29c9f0769 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -191,7 +191,9 @@
=20
 # test 'if' condition handling
=20
-{ 'struct': 'TestIfStruct', 'data': { 'foo': 'int' },
+{ 'struct': 'TestIfStruct', 'data':
+  { 'foo': 'int',
+    'bar': { 'type': 'int', 'if': 'defined(TEST_IF_STRUCT_BAR)'} },
   'if': 'defined(TEST_IF_STRUCT)' }
=20
 { 'enum': 'TestIfEnum', 'data':
@@ -204,8 +206,12 @@
 { 'alternate': 'TestIfAlternate', 'data': { 'foo': 'int', 'bar': 'TestSt=
ruct' },
   'if': 'defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)' }
=20
-{ 'command': 'TestIfCmd', 'data': { 'foo': 'TestIfStruct', 'bar': 'TestI=
fEnum' },
+{ 'command': 'TestIfCmd', 'data':
+  { 'foo': 'TestIfStruct',
+    'bar': { 'type': 'TestIfEnum', 'if': 'defined(TEST_IF_CMD_BAR)' } },
   'if': ['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)'] }
=20
-{ 'event': 'TestIfEvent', 'data': { 'foo': 'TestIfStruct' },
+{ 'event': 'TestIfEvent', 'data':
+  { 'foo': 'TestIfStruct',
+    'bar': { 'type': 'TestIfEnum', 'if': 'defined(TEST_IF_EVT_BAR)' } },
   'if': 'defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)' }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index bcef80efeb..e1e41acd52 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -260,6 +260,8 @@ command __org.qemu_x-command q_obj___org.qemu_x-comma=
nd-arg -> __org.qemu_x-Unio
    gen=3DTrue success_response=3DTrue boxed=3DFalse
 object TestIfStruct
     member foo: int optional=3DFalse
+    member bar: int optional=3DFalse
+        if ['defined(TEST_IF_STRUCT_BAR)']
     if ['defined(TEST_IF_STRUCT)']
 enum TestIfEnum
     member foo
@@ -284,12 +286,15 @@ alternate TestIfAlternate
 object q_obj_TestIfCmd-arg
     member foo: TestIfStruct optional=3DFalse
     member bar: TestIfEnum optional=3DFalse
+        if ['defined(TEST_IF_CMD_BAR)']
     if ['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)']
 command TestIfCmd q_obj_TestIfCmd-arg -> None
    gen=3DTrue success_response=3DTrue boxed=3DFalse
     if ['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)']
 object q_obj_TestIfEvent-arg
     member foo: TestIfStruct optional=3DFalse
+    member bar: TestIfEnum optional=3DFalse
+        if ['defined(TEST_IF_EVT_BAR)']
     if ['defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)']
 event TestIfEvent q_obj_TestIfEvent-arg
    boxed=3DFalse
--=20
2.16.2.521.g9aa15f885a
