Received: from eggs.gnu.org ([2001:4830:134:3::10]:49680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkTr-0005Cv-8B
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:33:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkTo-0000zw-1A
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:33:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkTn-0000yt-P1
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:33:43 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:04 +0100
Message-Id: <20180111213250.16511-6-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 05/51] qapi: add 'if' to top-level
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
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

Accept 'if' key in top-level elements, accepted as string or list of
string type. The following patches will modify the test visitor to
check the value is correctly saved, and generate #if/#endif code (as a
single #if/endif line or a series for a list).

Example of 'if' key:
{ 'struct': 'TestIfStruct', 'data': { 'foo': 'int' },
  'if': 'defined(TEST_IF_STRUCT)' }

The generated code is for now *unconditional*. Later patches generate
the conditionals.

A following patch for qapi-code-gen.txt will provide more complete
documentation for 'if' usage.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi.py                          | 36 ++++++++++++++++++++++++++=
------
 tests/test-qmp-commands.c                |  6 ++++++
 tests/Makefile.include                   |  4 ++++
 tests/qapi-schema/bad-if-empty-list.err  |  1 +
 tests/qapi-schema/bad-if-empty-list.exit |  1 +
 tests/qapi-schema/bad-if-empty-list.json |  3 +++
 tests/qapi-schema/bad-if-empty-list.out  |  0
 tests/qapi-schema/bad-if-empty.err       |  1 +
 tests/qapi-schema/bad-if-empty.exit      |  1 +
 tests/qapi-schema/bad-if-empty.json      |  3 +++
 tests/qapi-schema/bad-if-empty.out       |  0
 tests/qapi-schema/bad-if-list.err        |  1 +
 tests/qapi-schema/bad-if-list.exit       |  1 +
 tests/qapi-schema/bad-if-list.json       |  3 +++
 tests/qapi-schema/bad-if-list.out        |  0
 tests/qapi-schema/bad-if.err             |  1 +
 tests/qapi-schema/bad-if.exit            |  1 +
 tests/qapi-schema/bad-if.json            |  3 +++
 tests/qapi-schema/bad-if.out             |  0
 tests/qapi-schema/qapi-schema-test.json  | 20 ++++++++++++++++++
 tests/qapi-schema/qapi-schema-test.out   | 22 +++++++++++++++++++
 21 files changed, 102 insertions(+), 6 deletions(-)
 create mode 100644 tests/qapi-schema/bad-if-empty-list.err
 create mode 100644 tests/qapi-schema/bad-if-empty-list.exit
 create mode 100644 tests/qapi-schema/bad-if-empty-list.json
 create mode 100644 tests/qapi-schema/bad-if-empty-list.out
 create mode 100644 tests/qapi-schema/bad-if-empty.err
 create mode 100644 tests/qapi-schema/bad-if-empty.exit
 create mode 100644 tests/qapi-schema/bad-if-empty.json
 create mode 100644 tests/qapi-schema/bad-if-empty.out
 create mode 100644 tests/qapi-schema/bad-if-list.err
 create mode 100644 tests/qapi-schema/bad-if-list.exit
 create mode 100644 tests/qapi-schema/bad-if-list.json
 create mode 100644 tests/qapi-schema/bad-if-list.out
 create mode 100644 tests/qapi-schema/bad-if.err
 create mode 100644 tests/qapi-schema/bad-if.exit
 create mode 100644 tests/qapi-schema/bad-if.json
 create mode 100644 tests/qapi-schema/bad-if.out

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 43a54bf40f..27df0fcf48 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -630,6 +630,27 @@ def add_name(name, info, meta, implicit=3DFalse):
     all_names[name] =3D meta
=20
=20
+def check_if(expr, info):
+
+    def check_if_str(ifcond, info):
+        if not isinstance(ifcond, str):
+            raise QAPISemError(
+                info, "'if' condition must be a string or a list of stri=
ngs")
+        if ifcond =3D=3D '':
+            raise QAPISemError(info, "'if' condition '' makes no sense")
+
+    ifcond =3D expr.get('if')
+    if ifcond is None:
+        return
+    elif isinstance(ifcond, list):
+        if ifcond =3D=3D []:
+            raise QAPISemError(info, "'if' condition [] is useless")
+        for elt in ifcond:
+            check_if_str(elt, info)
+    else:
+        check_if_str(ifcond, info)
+
+
 def check_type(info, source, value, allow_array=3DFalse,
                allow_dict=3DFalse, allow_optional=3DFalse,
                allow_metas=3D[]):
@@ -869,6 +890,8 @@ def check_keys(expr_elem, meta, required, optional=3D=
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
@@ -894,27 +917,28 @@ def check_exprs(exprs):
=20
         if 'enum' in expr:
             meta =3D 'enum'
-            check_keys(expr_elem, 'enum', ['data'], ['prefix'])
+            check_keys(expr_elem, 'enum', ['data'], ['if', 'prefix'])
             enum_types[expr[meta]] =3D expr
         elif 'union' in expr:
             meta =3D 'union'
             check_keys(expr_elem, 'union', ['data'],
-                       ['base', 'discriminator'])
+                       ['base', 'discriminator', 'if'])
             union_types[expr[meta]] =3D expr
         elif 'alternate' in expr:
             meta =3D 'alternate'
-            check_keys(expr_elem, 'alternate', ['data'])
+            check_keys(expr_elem, 'alternate', ['data'], ['if'])
         elif 'struct' in expr:
             meta =3D 'struct'
-            check_keys(expr_elem, 'struct', ['data'], ['base'])
+            check_keys(expr_elem, 'struct', ['data'], ['base', 'if'])
             struct_types[expr[meta]] =3D expr
         elif 'command' in expr:
             meta =3D 'command'
             check_keys(expr_elem, 'command', [],
-                       ['data', 'returns', 'gen', 'success-response', 'b=
oxed'])
+                       ['data', 'returns', 'gen', 'success-response', 'b=
oxed',
+                        'if'])
         elif 'event' in expr:
             meta =3D 'event'
-            check_keys(expr_elem, 'event', [], ['data', 'boxed'])
+            check_keys(expr_elem, 'event', [], ['data', 'boxed', 'if'])
         else:
             raise QAPISemError(expr_elem['info'],
                                "Expression is missing metatype")
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
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 39a4b5359d..501a5713b5 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -410,6 +410,10 @@ qapi-schema +=3D args-unknown.json
 qapi-schema +=3D bad-base.json
 qapi-schema +=3D bad-data.json
 qapi-schema +=3D bad-ident.json
+qapi-schema +=3D bad-if.json
+qapi-schema +=3D bad-if-empty.json
+qapi-schema +=3D bad-if-empty-list.json
+qapi-schema +=3D bad-if-list.json
 qapi-schema +=3D bad-type-bool.json
 qapi-schema +=3D bad-type-dict.json
 qapi-schema +=3D bad-type-int.json
diff --git a/tests/qapi-schema/bad-if-empty-list.err b/tests/qapi-schema/=
bad-if-empty-list.err
new file mode 100644
index 0000000000..75fe6497bc
--- /dev/null
+++ b/tests/qapi-schema/bad-if-empty-list.err
@@ -0,0 +1 @@
+tests/qapi-schema/bad-if-empty-list.json:2: 'if' condition [] is useless
diff --git a/tests/qapi-schema/bad-if-empty-list.exit b/tests/qapi-schema=
/bad-if-empty-list.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/bad-if-empty-list.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/bad-if-empty-list.json b/tests/qapi-schema=
/bad-if-empty-list.json
new file mode 100644
index 0000000000..94f2eb8670
--- /dev/null
+++ b/tests/qapi-schema/bad-if-empty-list.json
@@ -0,0 +1,3 @@
+# check empty 'if' list
+{ 'struct': 'TestIfStruct', 'data': { 'foo': 'int' },
+  'if': [] }
diff --git a/tests/qapi-schema/bad-if-empty-list.out b/tests/qapi-schema/=
bad-if-empty-list.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/bad-if-empty.err b/tests/qapi-schema/bad-i=
f-empty.err
new file mode 100644
index 0000000000..358bdc3e51
--- /dev/null
+++ b/tests/qapi-schema/bad-if-empty.err
@@ -0,0 +1 @@
+tests/qapi-schema/bad-if-empty.json:2: 'if' condition '' makes no sense
diff --git a/tests/qapi-schema/bad-if-empty.exit b/tests/qapi-schema/bad-=
if-empty.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/bad-if-empty.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/bad-if-empty.json b/tests/qapi-schema/bad-=
if-empty.json
new file mode 100644
index 0000000000..fe1dd4eca6
--- /dev/null
+++ b/tests/qapi-schema/bad-if-empty.json
@@ -0,0 +1,3 @@
+# check empty 'if'
+{ 'struct': 'TestIfStruct', 'data': { 'foo': 'int' },
+  'if': '' }
diff --git a/tests/qapi-schema/bad-if-empty.out b/tests/qapi-schema/bad-i=
f-empty.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/bad-if-list.err b/tests/qapi-schema/bad-if=
-list.err
new file mode 100644
index 0000000000..0af6316f78
--- /dev/null
+++ b/tests/qapi-schema/bad-if-list.err
@@ -0,0 +1 @@
+tests/qapi-schema/bad-if-list.json:2: 'if' condition '' makes no sense
diff --git a/tests/qapi-schema/bad-if-list.exit b/tests/qapi-schema/bad-i=
f-list.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/bad-if-list.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/bad-if-list.json b/tests/qapi-schema/bad-i=
f-list.json
new file mode 100644
index 0000000000..49ced9b9ca
--- /dev/null
+++ b/tests/qapi-schema/bad-if-list.json
@@ -0,0 +1,3 @@
+# check invalid 'if' content
+{ 'struct': 'TestIfStruct', 'data': { 'foo': 'int' },
+  'if': ['foo', ''] }
diff --git a/tests/qapi-schema/bad-if-list.out b/tests/qapi-schema/bad-if=
-list.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/bad-if.err b/tests/qapi-schema/bad-if.err
new file mode 100644
index 0000000000..c2e3f5f44c
--- /dev/null
+++ b/tests/qapi-schema/bad-if.err
@@ -0,0 +1 @@
+tests/qapi-schema/bad-if.json:2: 'if' condition must be a string or a li=
st of strings
diff --git a/tests/qapi-schema/bad-if.exit b/tests/qapi-schema/bad-if.exi=
t
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/bad-if.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/bad-if.json b/tests/qapi-schema/bad-if.jso=
n
new file mode 100644
index 0000000000..3edd1a0bf2
--- /dev/null
+++ b/tests/qapi-schema/bad-if.json
@@ -0,0 +1,3 @@
+# check invalid 'if' type
+{ 'struct': 'TestIfStruct', 'data': { 'foo': 'int' },
+  'if': { 'value': 'defined(TEST_IF_STRUCT)' } }
diff --git a/tests/qapi-schema/bad-if.out b/tests/qapi-schema/bad-if.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index c72dbd8050..b997b2d43d 100644
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
+  'if': ['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)'] }
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
2.16.0.rc1.1.gef27df75a1
