Received: from eggs.gnu.org ([2001:4830:134:3::10]:58440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbORQ-0008N2-26
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbORO-00087y-GQ
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49416 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fbORO-00086v-Bp
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DA0A972647
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 10:58:17 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  6 Jul 2018 12:57:39 +0200
Message-Id: <20180706105753.26700-14-marcandre.lureau@redhat.com>
In-Reply-To: <20180706105753.26700-1-marcandre.lureau@redhat.com>
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 13/27] qapi: add 'if' to enum members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

QAPISchemaMember gains .ifcond for enum members: inherited classes,
such as QAPISchemaObjectTypeMember, will thus have an ifcond member
after this (those different types will also use the .ifcond to store
the condition and generate conditional code in the following patches).

Generated code is not changed by this patch, but with "qapi: add #if
conditions to generated code" patch.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/common.py                         | 10 +++++++---
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

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index e9fb736d46..95b7cd74ee 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -877,7 +877,8 @@ def check_enum(expr, info):
=20
     for member in members:
         source =3D "dictionary member of enum '%s'" % name
-        check_known_keys(info, source, member, ['name'], [])
+        check_known_keys(info, source, member, ['name'], ['if'])
+        check_if(member, info)
         check_name(info, "Member of enum '%s'" % name, member['name'],
                    enum_member=3DTrue)
=20
@@ -1357,9 +1358,10 @@ class QAPISchemaObjectType(QAPISchemaType):
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
@@ -1670,9 +1672,11 @@ class QAPISchema(object):
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
index 8e1b122cf2..3ba9097892 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -487,6 +487,7 @@ qapi-schema +=3D enum-bad-name.json
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
index 11aa4c8f8d..35ca94d991 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -202,7 +202,8 @@
 { 'struct': 'TestIfStruct', 'data': { 'foo': 'int' },
   'if': 'defined(TEST_IF_STRUCT)' }
=20
-{ 'enum': 'TestIfEnum', 'data': [ 'foo', 'bar' ],
+{ 'enum': 'TestIfEnum', 'data':
+  [ 'foo', { 'name' : 'bar', 'if': 'defined(TEST_IF_ENUM_BAR)' } ],
   'if': 'defined(TEST_IF_ENUM)' }
=20
 { 'union': 'TestIfUnion', 'data': { 'foo': 'TestStruct' },
@@ -211,7 +212,7 @@
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
index edd22bc306..1fb33f302c 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -270,6 +270,7 @@ object TestIfStruct
 enum TestIfEnum
     member foo
     member bar
+        if ['defined(TEST_IF_ENUM_BAR)']
     if ['defined(TEST_IF_ENUM)']
 object q_obj_TestStruct-wrapper
     member data: TestStruct optional=3DFalse
@@ -288,6 +289,7 @@ alternate TestIfAlternate
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
index 641a18f06d..b2f4ce6134 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -29,6 +29,7 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
             print('    prefix %s' % prefix)
         for m in members:
             print('    member %s' % m.name)
+            self._print_if(m.ifcond, 8)
         self._print_if(ifcond)
=20
     def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
--=20
2.18.0.rc1
