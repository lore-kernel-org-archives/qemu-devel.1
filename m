Received: from eggs.gnu.org ([2001:4830:134:3::10]:43133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMYo-0005e2-G9
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMYn-0006Z2-Ay
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:07:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1drMYn-0006YV-2u
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:07:25 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 11 Sep 2017 13:05:56 +0200
Message-Id: <20170911110623.24981-24-marcandre.lureau@redhat.com>
In-Reply-To: <20170911110623.24981-1-marcandre.lureau@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 23/50] qapi: add 'if' to struct members and
 implicit objects members
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

check_type() will now accept a DICT { 'type': TYPENAME, 'if': ... }
instead of a TYPENAME. This is the case in various situations where
implicit object types are allowed such as commands/events arguments
and return type, base and branches of union & alternate.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py                         | 20 ++++++++++++++++----
 tests/qapi-schema/qapi-schema-test.json | 12 +++++++++---
 tests/qapi-schema/qapi-schema-test.out  |  4 +++-
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index df2a304e8f..15711f96fa 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -696,7 +696,15 @@ def check_type(info, source, value, allow_array=3DFa=
lse,
         return
=20
     if not allow_dict:
-        raise QAPISemError(info, "%s should be a type name" % source)
+        if isinstance(value, dict) and 'type' in value:
+            check_type(info, source, value['type'], allow_array,
+                       allow_dict, allow_optional, allow_metas)
+            if 'if' in value:
+                check_if(value, info)
+            check_unknown_keys(info, value, {'type', 'if'})
+            return
+        else:
+            raise QAPISemError(info, "%s should be a type name" % source=
)
=20
     if not isinstance(value, OrderedDict):
         raise QAPISemError(info,
@@ -1345,8 +1353,8 @@ class QAPISchemaMember(object):
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
@@ -1637,13 +1645,17 @@ class QAPISchema(object):
=20
     def _make_member(self, name, typ, info):
         optional =3D False
+        ifcond =3D None
         if name.startswith('*'):
             name =3D name[1:]
             optional =3D True
+        if isinstance(typ, dict):
+            ifcond =3D typ.get('if')
+            typ =3D typ['type']
         if isinstance(typ, list):
             assert len(typ) =3D=3D 1
             typ =3D self._make_array_type(typ[0], info)
-        return QAPISchemaObjectTypeMember(name, typ, optional)
+        return QAPISchemaObjectTypeMember(name, typ, optional, ifcond)
=20
     def _make_members(self, data, info):
         return [self._make_member(key, value, info)
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index ad2b405d83..5cfccabb3d 100644
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
   'if': 'defined(TEST_IF_CMD) && defined(TEST_IF_STRUCT)' }
=20
-{ 'event': 'TestIfEvent', 'data': { 'foo': 'TestIfStruct' },
+{ 'event': 'TestIfEvent', 'data':
+  { 'foo': 'TestIfStruct',
+    'bar': { 'type': 'TestIfEnum', 'if': 'defined(TEST_IF_EVT_BAR)' } },
   'if': 'defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)' }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 8a0cf1a551..6df4e49c69 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -81,6 +81,7 @@ event TestIfEvent q_obj_TestIfEvent-arg
     if defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)
 object TestIfStruct
     member foo: int optional=3DFalse
+    member bar: int optional=3DFalse if=3Ddefined(TEST_IF_STRUCT_BAR)
     if defined(TEST_IF_STRUCT)
 object TestIfUnion
     member type: TestIfUnionKind optional=3DFalse
@@ -228,10 +229,11 @@ object q_obj_EVENT_D-arg
     member enum3: EnumOne optional=3DTrue
 object q_obj_TestIfCmd-arg
     member foo: TestIfStruct optional=3DFalse
-    member bar: TestIfEnum optional=3DFalse
+    member bar: TestIfEnum optional=3DFalse if=3Ddefined(TEST_IF_CMD_BAR=
)
     if defined(TEST_IF_CMD) && defined(TEST_IF_STRUCT)
 object q_obj_TestIfEvent-arg
     member foo: TestIfStruct optional=3DFalse
+    member bar: TestIfEnum optional=3DFalse if=3Ddefined(TEST_IF_EVT_BAR=
)
     if defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)
 object q_obj_TestStruct-wrapper
     member data: TestStruct optional=3DFalse
--=20
2.14.1.146.gd35faa819
