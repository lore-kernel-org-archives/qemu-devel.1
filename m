Received: from eggs.gnu.org ([2001:4830:134:3::10]:50929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkVq-00071j-WB
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:35:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkVp-0003N5-91
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:35:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkVp-0003Kx-0s
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:35:49 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:22 +0100
Message-Id: <20180111213250.16511-24-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 23/51] qapi: add 'if' to enum members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

QAPISchemaMember gains .ifcond for enum members: inherited classes,
such as QAPISchemaObjectTypeMember, will thus have an ifcond member
after this (those different types will also use the .ifcond to store
the condition and generate conditional code in the following patches).

Generated code is not changed by this patch, but with "qapi: add #if
conditions to generated code" patch.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py                                | 10 +++++++---
 tests/Makefile.include                         |  1 +
 tests/qapi-schema/enum-dict-member-unknown.err |  2 +-
 tests/qapi-schema/enum-if-invalid.err          |  1 +
 tests/qapi-schema/enum-if-invalid.exit         |  1 +
 tests/qapi-schema/enum-if-invalid.json         |  3 +++
 tests/qapi-schema/enum-if-invalid.out          |  0
 tests/qapi-schema/qapi-schema-test.json        |  5 +++--
 tests/qapi-schema/qapi-schema-test.out         |  2 ++
 tests/qapi-schema/test-qapi.py                 |  1 +
 10 files changed, 20 insertions(+), 6 deletions(-)
 create mode 100644 tests/qapi-schema/enum-if-invalid.err
 create mode 100644 tests/qapi-schema/enum-if-invalid.exit
 create mode 100644 tests/qapi-schema/enum-if-invalid.json
 create mode 100644 tests/qapi-schema/enum-if-invalid.out

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 1338be4efe..e203734254 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -875,7 +875,8 @@ def check_enum(expr, info):
=20
     for member in members:
         source =3D "Dictionary member of enum '%s'" % name
-        check_known_keys(info, source, member, ['name'], [])
+        check_known_keys(info, source, member, ['name'], ['if'])
+        check_if(member, info)
         check_name(info, "Member of enum '%s'" % name, member['name'],
                    enum_member=3DTrue)
=20
@@ -1330,9 +1331,10 @@ class QAPISchemaObjectType(QAPISchemaType):
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
@@ -1616,9 +1618,11 @@ class QAPISchema(object):
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
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3634e8f67c..aa5a572403 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -455,6 +455,7 @@ qapi-schema +=3D enum-bad-name.json
 qapi-schema +=3D enum-bad-prefix.json
 qapi-schema +=3D enum-clash-member.json
 qapi-schema +=3D enum-dict-member-unknown.json
+qapi-schema +=3D enum-if-invalid.json
 qapi-schema +=3D enum-int-member.json
 qapi-schema +=3D enum-member-case.json
 qapi-schema +=3D enum-missing-data.json
diff --git a/tests/qapi-schema/enum-dict-member-unknown.err b/tests/qapi-=
schema/enum-dict-member-unknown.err
index 7ed48beb2e..94e02ecd25 100644
--- a/tests/qapi-schema/enum-dict-member-unknown.err
+++ b/tests/qapi-schema/enum-dict-member-unknown.err
@@ -1 +1 @@
-tests/qapi-schema/enum-dict-member-unknown.json:2: Dictionary member of =
enum 'MyEnum' has unknown key 'bad-key' (allowed: 'name')
+tests/qapi-schema/enum-dict-member-unknown.json:2: Dictionary member of =
enum 'MyEnum' has unknown key 'bad-key' (allowed: 'name', 'if')
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
index b997b2d43d..6a1d3b6337 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -194,7 +194,8 @@
 { 'struct': 'TestIfStruct', 'data': { 'foo': 'int' },
   'if': 'defined(TEST_IF_STRUCT)' }
=20
-{ 'enum': 'TestIfEnum', 'data': [ 'foo', 'bar' ],
+{ 'enum': 'TestIfEnum', 'data':
+  [ 'foo', { 'name' : 'bar', 'if': 'defined(TEST_IF_ENUM_BAR)' } ],
   'if': 'defined(TEST_IF_ENUM)' }
=20
 { 'union': 'TestIfUnion', 'data': { 'foo': 'TestStruct' },
@@ -203,7 +204,7 @@
 { 'alternate': 'TestIfAlternate', 'data': { 'foo': 'int', 'bar': 'TestSt=
ruct' },
   'if': 'defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)' }
=20
-{ 'command': 'TestIfCmd', 'data': { 'foo': 'TestIfStruct' },
+{ 'command': 'TestIfCmd', 'data': { 'foo': 'TestIfStruct', 'bar': 'TestI=
fEnum' },
   'if': ['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)'] }
=20
 { 'event': 'TestIfEvent', 'data': { 'foo': 'TestIfStruct' },
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 33afa965e8..b5fff8d538 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -75,6 +75,7 @@ command TestIfCmd q_obj_TestIfCmd-arg -> None
 enum TestIfEnum
     member foo
     member bar
+        if ['defined(TEST_IF_ENUM_BAR)']
     if ['defined(TEST_IF_ENUM)']
 event TestIfEvent q_obj_TestIfEvent-arg
    boxed=3DFalse
@@ -228,6 +229,7 @@ object q_obj_EVENT_D-arg
     member enum3: EnumOne optional=3DTrue
 object q_obj_TestIfCmd-arg
     member foo: TestIfStruct optional=3DFalse
+    member bar: TestIfEnum optional=3DFalse
     if ['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)']
 object q_obj_TestIfEvent-arg
     member foo: TestIfStruct optional=3DFalse
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index aadc8452b4..1269b8fbc5 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -57,6 +57,7 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
                 m.name,
                 ': %s optional=3D%s' % (m.type.name, m.optional)
                 if isinstance(m, QAPISchemaObjectTypeMember) else '')
+            QAPISchemaTestVisitor._print_if(m.ifcond, 8)
=20
     @staticmethod
     def _print_variants(variants):
--=20
2.16.0.rc1.1.gef27df75a1
