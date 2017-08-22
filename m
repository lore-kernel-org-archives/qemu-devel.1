Received: from eggs.gnu.org ([2001:4830:134:3::10]:54463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9H3-0005xz-74
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9Gz-0005KR-4O
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:31:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63581)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dk9Gy-0005K2-Ru
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:31:13 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:16 +0200
Message-Id: <20170822132255.23945-16-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 15/54] qapi: add 'if' to top-level
 expressions
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

Accept 'if' key in top-level elements, accepted as string or list of
string type. The following patches will modify the test visitor to
check the value is correctly saved, and generate #if/#endif code (as a
single #if/endif line or a series for a list).

Example of 'if' key:
{ 'struct': 'TestIfStruct', 'data': { 'foo': 'int' },                    =
                                                                         =
                                                                  'if': '=
defined(TEST_IF_STRUCT)' }

A following patch for qapi-code-gen.txt will provide more complete
documentation for 'if' usage.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py                         | 13 +++++++++++++
 tests/test-qmp-commands.c               |  6 ++++++
 tests/qapi-schema/qapi-schema-test.json | 20 ++++++++++++++++++++
 tests/qapi-schema/qapi-schema-test.out  | 22 ++++++++++++++++++++++
 4 files changed, 61 insertions(+)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 73adb90379..a94d93ada4 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -639,6 +639,16 @@ def add_name(name, info, meta, implicit=3DFalse):
     all_names[name] =3D meta
=20
=20
+def check_if(expr, info):
+    ifcond =3D expr.get('if')
+    if not ifcond or isinstance(ifcond, str):
+        return
+    if (not isinstance(ifcond, list) or
+            any([not isinstance(elt, str) for elt in ifcond])):
+        raise QAPISemError(info, "'if' condition requires a string or "
+                           "a list of string")
+
+
 def check_type(info, source, value, allow_array=3DFalse,
                allow_dict=3DFalse, allow_optional=3DFalse,
                allow_metas=3D[]):
@@ -865,6 +875,7 @@ def check_keys(expr_elem, meta, required, optional=3D=
[]):
     expr =3D expr_elem['expr']
     info =3D expr_elem['info']
     name =3D expr[meta]
+    optional =3D optional + ['if']  # all top-level elem accept if
     if not isinstance(name, str):
         raise QAPISemError(info, "'%s' key must have a string value" % m=
eta)
     required =3D required + [meta]
@@ -880,6 +891,8 @@ def check_keys(expr_elem, meta, required, optional=3D=
[]):
             raise QAPISemError(info,
                                "'%s' of %s '%s' should only use true val=
ue"
                                % (key, meta, name))
+        if key =3D=3D 'if':
+            check_if(expr, info)
     for key in required:
         if key not in expr:
             raise QAPISemError(info, "Key '%s' is missing from %s '%s'"
diff --git a/tests/test-qmp-commands.c b/tests/test-qmp-commands.c
index 904c89d4d4..9b9a7ffee7 100644
--- a/tests/test-qmp-commands.c
+++ b/tests/test-qmp-commands.c
@@ -10,6 +10,12 @@
=20
 static QmpCommandList qmp_commands;
=20
+/* #if defined(TEST_IF_CMD) */
+void qmp_TestIfCmd(TestIfStruct *foo, Error **errp)
+{
+}
+/* #endif */
+
 void qmp_user_def_cmd(Error **errp)
 {
 }
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index c72dbd8050..dc2c444fc1 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -188,3 +188,23 @@
   'data': { 'a': ['__org.qemu_x-Enum'], 'b': ['__org.qemu_x-Struct'],
             'c': '__org.qemu_x-Union2', 'd': '__org.qemu_x-Alt' },
   'returns': '__org.qemu_x-Union1' }
+
+# test 'if' condition handling
+
+{ 'struct': 'TestIfStruct', 'data': { 'foo': 'int' },
+  'if': 'defined(TEST_IF_STRUCT)' }
+
+{ 'enum': 'TestIfEnum', 'data': [ 'foo', 'bar' ],
+  'if': 'defined(TEST_IF_ENUM)' }
+
+{ 'union': 'TestIfUnion', 'data': { 'foo': 'TestStruct' },
+  'if': 'defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)' }
+
+{ 'alternate': 'TestIfAlternate', 'data': { 'foo': 'int', 'bar': 'TestSt=
ruct' },
+  'if': 'defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)' }
+
+{ 'command': 'TestIfCmd', 'data': { 'foo': 'TestIfStruct' },
+  'if': 'defined(TEST_IF_CMD) && defined(TEST_IF_STRUCT)' }
+
+{ 'event': 'TestIfEvent', 'data': { 'foo': 'TestIfStruct' },
+  'if': 'defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)' }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 3b1e9082d3..7fbaea19bc 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -52,6 +52,22 @@ enum QEnumTwo ['value1', 'value2']
     prefix QENUM_TWO
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
+alternate TestIfAlternate
+    tag type
+    case foo: int
+    case bar: TestStruct
+command TestIfCmd q_obj_TestIfCmd-arg -> None
+   gen=3DTrue success_response=3DTrue boxed=3DFalse
+enum TestIfEnum ['foo', 'bar']
+event TestIfEvent q_obj_TestIfEvent-arg
+   boxed=3DFalse
+object TestIfStruct
+    member foo: int optional=3DFalse
+object TestIfUnion
+    member type: TestIfUnionKind optional=3DFalse
+    tag type
+    case foo: q_obj_TestStruct-wrapper
+enum TestIfUnionKind ['foo']
 object TestStruct
     member integer: int optional=3DFalse
     member boolean: bool optional=3DFalse
@@ -172,6 +188,12 @@ object q_obj_EVENT_D-arg
     member b: str optional=3DFalse
     member c: str optional=3DTrue
     member enum3: EnumOne optional=3DTrue
+object q_obj_TestIfCmd-arg
+    member foo: TestIfStruct optional=3DFalse
+object q_obj_TestIfEvent-arg
+    member foo: TestIfStruct optional=3DFalse
+object q_obj_TestStruct-wrapper
+    member data: TestStruct optional=3DFalse
 object q_obj_UserDefFlatUnion2-base
     member integer: int optional=3DTrue
     member string: str optional=3DFalse
--=20
2.14.1.146.gd35faa819
