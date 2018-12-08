Received: from eggs.gnu.org ([2001:4830:134:3::10]:59776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gVabw-0004UN-9I
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:17:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gVabu-0003yt-RJ
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:17:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gVabu-0003xx-Iz
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:17:26 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat,  8 Dec 2018 15:15:48 +0400
Message-Id: <20181208111606.8505-10-marcandre.lureau@redhat.com>
In-Reply-To: <20181208111606.8505-1-marcandre.lureau@redhat.com>
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0 v7 09/27] qapi: add 'if' to enum members
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

QAPISchemaMember gains .ifcond for enum members: inherited classes,
such as QAPISchemaObjectTypeMember, will thus have an ifcond member
after this (those different types will also use the .ifcond to store
the condition and generate conditional code in the following patches).

The generated code remains unconditional for now. Later patches
generate the conditionals.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py                         | 10 +++++++---
 docs/devel/qapi-code-gen.txt                   |  9 +++++++++
 tests/Makefile.include                         |  1 +
 tests/qapi-schema/enum-dict-member-unknown.err |  2 +-
 tests/qapi-schema/enum-if-invalid.err          |  1 +
 tests/qapi-schema/enum-if-invalid.exit         |  1 +
 tests/qapi-schema/enum-if-invalid.json         |  3 +++
 tests/qapi-schema/enum-if-invalid.out          |  0
 tests/qapi-schema/qapi-schema-test.json        |  5 +++--
 tests/qapi-schema/qapi-schema-test.out         |  2 ++
 tests/qapi-schema/test-qapi.py                 |  1 +
 11 files changed, 29 insertions(+), 6 deletions(-)
 create mode 100644 tests/qapi-schema/enum-if-invalid.err
 create mode 100644 tests/qapi-schema/enum-if-invalid.exit
 create mode 100644 tests/qapi-schema/enum-if-invalid.json
 create mode 100644 tests/qapi-schema/enum-if-invalid.out

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 610840d2e5..fdc0fd69ef 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -874,7 +874,8 @@ def check_enum(expr, info):
     for member in members:
         if isinstance(member, dict):
             source =3D "dictionary member of enum '%s'" % name
-            check_known_keys(info, source, member, ['name'], [])
+            check_known_keys(info, source, member, ['name'], ['if'])
+            check_if(member, info)
             member =3D member['name']
=20
         check_name(info, "Member of enum '%s'" % name, member,
@@ -1358,9 +1359,10 @@ class QAPISchemaObjectType(QAPISchemaType):
 class QAPISchemaMember(object):
     role =3D 'member'
=20
-    def __init__(self, name):
+    def __init__(self, name, ifcond=3DNone):
         assert isinstance(name, str)
         self.name =3D name
+        self.ifcond =3D listify_cond(ifcond)
         self.owner =3D None
=20
     def set_owner(self, name):
@@ -1672,9 +1674,11 @@ class QAPISchema(object):
         for v in values:
             if isinstance(v, dict):
                 name =3D v['name']
+                ifcond =3D v.get('if')
             else:
                 name =3D v
-            enum.append(QAPISchemaMember(name))
+                ifcond =3D None
+            enum.append(QAPISchemaMember(name, ifcond))
         return enum
=20
     def _make_implicit_enum_type(self, name, info, ifcond, values):
diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 53eaf01f34..08c5ef97ff 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -752,6 +752,15 @@ gets its generated code guarded like this:
  #endif /* defined(HAVE_BAR) */
  #endif /* defined(CONFIG_FOO) */
=20
+An enum value can be replaced by a dictionary with a 'name' and a 'if'
+key.
+
+Example: a conditional 'bar' enum member.
+
+{ 'enum': 'IfEnum', 'data':
+  [ 'foo',
+    { 'name' : 'bar', 'if': 'defined(IFCOND)' } ] }
+
 Please note that you are responsible to ensure that the C code will
 compile with an arbitrary combination of conditions, since the
 generators are unable to check it at this point.
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 2e894c1037..3c9eea27fd 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -384,6 +384,7 @@ qapi-schema +=3D enum-bad-name.json
 qapi-schema +=3D enum-bad-prefix.json
 qapi-schema +=3D enum-clash-member.json
 qapi-schema +=3D enum-dict-member-unknown.json
+qapi-schema +=3D enum-if-invalid.json
 qapi-schema +=3D enum-int-member.json
 qapi-schema +=3D enum-member-case.json
 qapi-schema +=3D enum-missing-data.json
diff --git a/tests/qapi-schema/enum-dict-member-unknown.err b/tests/qapi-=
schema/enum-dict-member-unknown.err
index 76bd0471db..2aae618be0 100644
--- a/tests/qapi-schema/enum-dict-member-unknown.err
+++ b/tests/qapi-schema/enum-dict-member-unknown.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/enum-dict-member-unknown.json:2: Unknown key 'bad-key'=
 in dictionary member of enum 'MyEnum'
-Valid keys are 'name'.
+Valid keys are 'if', 'name'.
diff --git a/tests/qapi-schema/enum-if-invalid.err b/tests/qapi-schema/en=
um-if-invalid.err
new file mode 100644
index 0000000000..54c3cf887b
--- /dev/null
+++ b/tests/qapi-schema/enum-if-invalid.err
@@ -0,0 +1 @@
+tests/qapi-schema/enum-if-invalid.json:2: 'if' condition must be a strin=
g or a list of strings
diff --git a/tests/qapi-schema/enum-if-invalid.exit b/tests/qapi-schema/e=
num-if-invalid.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/enum-if-invalid.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/enum-if-invalid.json b/tests/qapi-schema/e=
num-if-invalid.json
new file mode 100644
index 0000000000..60bd0ef1d7
--- /dev/null
+++ b/tests/qapi-schema/enum-if-invalid.json
@@ -0,0 +1,3 @@
+# check invalid 'if' type
+{ 'enum': 'TestIfEnum', 'data':
+  [ 'foo', { 'name' : 'bar', 'if': { 'val': 'foo' } } ] }
diff --git a/tests/qapi-schema/enum-if-invalid.out b/tests/qapi-schema/en=
um-if-invalid.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index fb03163430..22d9044a89 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -204,7 +204,8 @@
 { 'struct': 'TestIfStruct', 'data': { 'foo': 'int' },
   'if': 'defined(TEST_IF_STRUCT)' }
=20
-{ 'enum': 'TestIfEnum', 'data': [ 'foo', 'bar' ],
+{ 'enum': 'TestIfEnum', 'data':
+  [ 'foo', { 'name' : 'bar', 'if': 'defined(TEST_IF_ENUM_BAR)' } ],
   'if': 'defined(TEST_IF_ENUM)' }
=20
 { 'union': 'TestIfUnion', 'data': { 'foo': 'TestStruct' },
@@ -213,7 +214,7 @@
 { 'alternate': 'TestIfAlternate', 'data': { 'foo': 'int', 'bar': 'TestSt=
ruct' },
   'if': 'defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)' }
=20
-{ 'command': 'TestIfCmd', 'data': { 'foo': 'TestIfStruct' },
+{ 'command': 'TestIfCmd', 'data': { 'foo': 'TestIfStruct', 'bar': 'TestI=
fEnum' },
   'returns': 'UserDefThree',
   'if': ['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)'] }
=20
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 39cd2b0fc3..130199fe8f 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -272,6 +272,7 @@ object TestIfStruct
 enum TestIfEnum
     member foo
     member bar
+        if ['defined(TEST_IF_ENUM_BAR)']
     if ['defined(TEST_IF_ENUM)']
 object q_obj_TestStruct-wrapper
     member data: TestStruct optional=3DFalse
@@ -290,6 +291,7 @@ alternate TestIfAlternate
     if ['defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)']
 object q_obj_TestIfCmd-arg
     member foo: TestIfStruct optional=3DFalse
+    member bar: TestIfEnum optional=3DFalse
     if ['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)']
 command TestIfCmd q_obj_TestIfCmd-arg -> UserDefThree
    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index 641a18f06d..aadf252d9d 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -29,6 +29,7 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
             print('    prefix %s' % prefix)
         for m in members:
             print('    member %s' % m.name)
+            self._print_if(m.ifcond, indent=3D8)
         self._print_if(ifcond)
=20
     def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
--=20
2.20.0.rc1
