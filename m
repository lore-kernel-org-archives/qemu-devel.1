Received: from eggs.gnu.org ([2001:4830:134:3::10]:44116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSVA-0000yF-3l
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:06:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSV5-0000N6-Vu
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:06:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33634 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faSV5-0000MS-Ol
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:06:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 474B84075279
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 21:06:15 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 23:06:00 +0200
Message-Id: <20180703210613.25619-2-armbru@redhat.com>
In-Reply-To: <20180703210613.25619-1-armbru@redhat.com>
References: <20180703210613.25619-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/14] qapi: add 'if' to top-level expressions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Accept 'if' key in top-level elements, accepted as string or list of
string type. The following patches will modify the test visitor to
check the value is correctly saved, and generate #if/#endif code (as a
single #if/endif line or a series for a list).

Example of 'if' key:
{ 'struct': 'TestIfStruct', 'data': { 'foo': 'int' },
  'if': 'defined(TEST_IF_STRUCT)' }

The generated code is for now *unconditional*. Later patches generate
the conditionals.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180703155648.11933-2-marcandre.lureau@redhat.com>
[Commit message and Documentation improved]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt             | 29 ++++++++++++++++++++
 scripts/qapi/common.py                   | 35 ++++++++++++++++++++----
 tests/Makefile.include                   |  4 +++
 tests/qapi-schema/bad-if-empty-list.err  |  1 +
 tests/qapi-schema/bad-if-empty-list.exit |  1 +
 tests/qapi-schema/bad-if-empty-list.json |  3 ++
 tests/qapi-schema/bad-if-empty-list.out  |  0
 tests/qapi-schema/bad-if-empty.err       |  1 +
 tests/qapi-schema/bad-if-empty.exit      |  1 +
 tests/qapi-schema/bad-if-empty.json      |  3 ++
 tests/qapi-schema/bad-if-empty.out       |  0
 tests/qapi-schema/bad-if-list.err        |  1 +
 tests/qapi-schema/bad-if-list.exit       |  1 +
 tests/qapi-schema/bad-if-list.json       |  3 ++
 tests/qapi-schema/bad-if-list.out        |  0
 tests/qapi-schema/bad-if.err             |  1 +
 tests/qapi-schema/bad-if.exit            |  1 +
 tests/qapi-schema/bad-if.json            |  3 ++
 tests/qapi-schema/bad-if.out             |  0
 tests/qapi-schema/qapi-schema-test.json  | 26 ++++++++++++++++++
 tests/qapi-schema/qapi-schema-test.out   | 26 ++++++++++++++++++
 tests/test-qmp-cmds.c                    | 12 ++++++++
 22 files changed, 146 insertions(+), 6 deletions(-)
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

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 94a7e8f4d0..d3b0990983 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -744,6 +744,35 @@ Example: Red Hat, Inc. controls redhat.com, and may =
therefore add a
 downstream command __com.redhat_drive-mirror.
=20
=20
+=3D=3D=3D Configuring the schema =3D=3D=3D
+
+The 'struct', 'enum', 'union', 'alternate', 'command' and 'event'
+top-level expressions can take an 'if' key.  Its value must be a string
+or a list of strings.  A string is shorthand for a list containing just
+that string.  The code generated for the top-level expression will then
+be guarded by #if COND for each COND in the list.
+
+Example: a conditional struct
+
+ { 'struct': 'IfStruct', 'data': { 'foo': 'int' },
+   'if': ['defined(CONFIG_FOO)', 'defined(HAVE_BAR)'] }
+
+gets its generated code guarded like this:
+
+ #if defined(CONFIG_FOO)
+ #if defined(HAVE_BAR)
+ ... generated code ...
+ #endif /* defined(HAVE_BAR) */
+ #endif /* defined(CONFIG_FOO) */
+
+Please note that you are responsible to ensure that the C code will
+compile with an arbitrary combination of conditions, since the
+generators are unable to check it at this point.
+
+The presence of 'if' keys in the schema is reflected through to the
+introspection output depending on the build configuration.
+
+
 =3D=3D Client JSON Protocol introspection =3D=3D
=20
 Clients of a Client JSON Protocol commonly need to figure out what
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 8b6708dbf1..991045a478 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -638,6 +638,27 @@ def add_name(name, info, meta, implicit=3DFalse):
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
+    if isinstance(ifcond, list):
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
@@ -871,6 +892,8 @@ def check_keys(expr_elem, meta, required, optional=3D=
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
@@ -899,28 +922,28 @@ def check_exprs(exprs):
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
                        ['data', 'returns', 'gen', 'success-response',
-                        'boxed', 'allow-oob', 'allow-preconfig'])
+                        'boxed', 'allow-oob', 'allow-preconfig', 'if'])
         elif 'event' in expr:
             meta =3D 'event'
-            check_keys(expr_elem, 'event', [], ['data', 'boxed'])
+            check_keys(expr_elem, 'event', [], ['data', 'boxed', 'if'])
         else:
             raise QAPISemError(expr_elem['info'],
                                "Expression is missing metatype")
diff --git a/tests/Makefile.include b/tests/Makefile.include
index e8bb2d8f66..9faefd7cd2 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -442,6 +442,10 @@ qapi-schema +=3D args-unknown.json
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
index 7b59817f04..16209b57b3 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -56,6 +56,9 @@
   'data': { 'string0': 'str',
             'dict1': 'UserDefTwoDict' } }
=20
+{ 'struct': 'UserDefThree',
+  'data': { 'string0': 'str' } }
+
 # dummy struct to force generation of array types not otherwise mentione=
d
 { 'struct': 'ForceArrays',
   'data': { 'unused1':['UserDefOne'], 'unused2':['UserDefTwo'],
@@ -193,3 +196,26 @@
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
+  'returns': 'UserDefThree',
+  'if': ['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)'] }
+
+{ 'command': 'TestCmdReturnDefThree', 'returns': 'UserDefThree' }
+
+{ 'event': 'TestIfEvent', 'data': { 'foo': 'TestIfStruct' },
+  'if': 'defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)' }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 0dbcdafa3c..ed25e5b60c 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -36,6 +36,8 @@ object UserDefTwoDict
 object UserDefTwo
     member string0: str optional=3DFalse
     member dict1: UserDefTwoDict optional=3DFalse
+object UserDefThree
+    member string0: str optional=3DFalse
 object ForceArrays
     member unused1: UserDefOneList optional=3DFalse
     member unused2: UserDefTwoList optional=3DFalse
@@ -233,3 +235,27 @@ object q_obj___org.qemu_x-command-arg
     member d: __org.qemu_x-Alt optional=3DFalse
 command __org.qemu_x-command q_obj___org.qemu_x-command-arg -> __org.qem=
u_x-Union1
    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
+object TestIfStruct
+    member foo: int optional=3DFalse
+enum TestIfEnum ['foo', 'bar']
+object q_obj_TestStruct-wrapper
+    member data: TestStruct optional=3DFalse
+enum TestIfUnionKind ['foo']
+object TestIfUnion
+    member type: TestIfUnionKind optional=3DFalse
+    tag type
+    case foo: q_obj_TestStruct-wrapper
+alternate TestIfAlternate
+    tag type
+    case foo: int
+    case bar: TestStruct
+object q_obj_TestIfCmd-arg
+    member foo: TestIfStruct optional=3DFalse
+command TestIfCmd q_obj_TestIfCmd-arg -> UserDefThree
+   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
+command TestCmdReturnDefThree None -> UserDefThree
+   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
+object q_obj_TestIfEvent-arg
+    member foo: TestIfStruct optional=3DFalse
+event TestIfEvent q_obj_TestIfEvent-arg
+   boxed=3DFalse
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 491b0c4a44..840530b84c 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -12,6 +12,18 @@
=20
 static QmpCommandList qmp_commands;
=20
+/* #if defined(TEST_IF_STRUCT) && defined(TEST_IF_CMD) */
+UserDefThree *qmp_TestIfCmd(TestIfStruct *foo, Error **errp)
+{
+    return NULL;
+}
+/* #endif */
+
+UserDefThree *qmp_TestCmdReturnDefThree(Error **errp)
+{
+    return NULL;
+}
+
 void qmp_user_def_cmd(Error **errp)
 {
 }
--=20
2.17.1
