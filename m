Received: from eggs.gnu.org ([2001:4830:134:3::10]:51176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkW3-0007DY-Eq
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkW2-0003mb-5r
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkW1-0003kP-Cf
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:02 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:26 +0100
Message-Id: <20180111213250.16511-28-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 27/51] qapi: add 'if' to implicit struct
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
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

Generated code is not changed by this patch, but with "qapi: add #if
conditions to generated code" patch.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py                         | 14 +++++++-------
 tests/qapi-schema/qapi-schema-test.json | 12 +++++++++---
 tests/qapi-schema/qapi-schema-test.out  |  5 +++++
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 49fdf6bacf..c4a2623864 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -705,7 +705,7 @@ def check_type(info, source, value, allow_array=3DFal=
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
@@ -1394,8 +1394,8 @@ class QAPISchemaMember(object):
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
@@ -1689,7 +1689,7 @@ class QAPISchema(object):
             name, info, doc, ifcond,
             self._make_enum_members(data), prefix))
=20
-    def _make_member(self, name, typ, info):
+    def _make_member(self, name, typ, ifcond, info):
         optional =3D False
         if name.startswith('*'):
             name =3D name[1:]
@@ -1697,10 +1697,10 @@ class QAPISchema(object):
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
                 for (key, value) in data.iteritems()]
=20
     def _def_struct_type(self, expr, info, doc):
@@ -1721,7 +1721,7 @@ class QAPISchema(object):
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
index b5fff8d538..734d3f53aa 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -82,6 +82,8 @@ event TestIfEvent q_obj_TestIfEvent-arg
     if ['defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)']
 object TestIfStruct
     member foo: int optional=3DFalse
+    member bar: int optional=3DFalse
+        if ['defined(TEST_IF_STRUCT_BAR)']
     if ['defined(TEST_IF_STRUCT)']
 object TestIfUnion
     member type: TestIfUnionKind optional=3DFalse
@@ -230,9 +232,12 @@ object q_obj_EVENT_D-arg
 object q_obj_TestIfCmd-arg
     member foo: TestIfStruct optional=3DFalse
     member bar: TestIfEnum optional=3DFalse
+        if ['defined(TEST_IF_CMD_BAR)']
     if ['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)']
 object q_obj_TestIfEvent-arg
     member foo: TestIfStruct optional=3DFalse
+    member bar: TestIfEnum optional=3DFalse
+        if ['defined(TEST_IF_EVT_BAR)']
     if ['defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)']
 object q_obj_TestStruct-wrapper
     member data: TestStruct optional=3DFalse
--=20
2.16.0.rc1.1.gef27df75a1
