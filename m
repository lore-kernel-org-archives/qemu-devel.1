Received: from eggs.gnu.org ([2001:4830:134:3::10]:32846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dal4x-0000cu-Ke
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:52:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dal4u-0007Ll-Ek
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:51:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dal4u-0007KM-4y
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:51:56 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 27 Jul 2017 17:41:11 +0200
Message-Id: <20170727154126.11339-12-marcandre.lureau@redhat.com>
In-Reply-To: <20170727154126.11339-1-marcandre.lureau@redhat.com>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 11/26] qapi: add 'if' condition on alternate
 variant
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py                               | 8 +++++++-
 scripts/qapi-introspect.py                    | 2 +-
 tests/Makefile.include                        | 1 +
 tests/qapi-schema/alternate-dict-invalid.err  | 1 +
 tests/qapi-schema/alternate-dict-invalid.exit | 1 +
 tests/qapi-schema/alternate-dict-invalid.json | 4 ++++
 tests/qapi-schema/alternate-dict-invalid.out  | 0
 tests/qapi-schema/qapi-schema-test.json       | 6 +++++-
 tests/qapi-schema/qapi-schema-test.out        | 8 +++++++-
 9 files changed, 27 insertions(+), 4 deletions(-)
 create mode 100644 tests/qapi-schema/alternate-dict-invalid.err
 create mode 100644 tests/qapi-schema/alternate-dict-invalid.exit
 create mode 100644 tests/qapi-schema/alternate-dict-invalid.json
 create mode 100644 tests/qapi-schema/alternate-dict-invalid.out

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 333a5c0d1e..7f0d56fb01 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -829,6 +829,8 @@ def check_alternate(expr, info):
         check_type(info, "Member '%s' of alternate '%s'" % (key, name),
                    value,
                    allow_metas=3D['built-in', 'union', 'struct', 'enum']=
)
+        if isinstance(value, dict):
+            value =3D value['type']
         qtype =3D find_alternate_member_qtype(value)
         if not qtype:
             raise QAPISemError(info, "Alternate '%s' member '%s' cannot =
use "
@@ -1643,7 +1645,11 @@ class QAPISchema(object):
                          expr.get('if'))
=20
     def _make_variant(self, case, typ):
-        return QAPISchemaObjectTypeVariant(case, typ)
+        ifcond =3D None
+        if isinstance(typ, dict):
+            ifcond =3D typ.get('if')
+            typ =3D typ['type']
+        return QAPISchemaObjectTypeVariant(case, typ, ifcond)
=20
     def _make_simple_variant(self, case, typ, info):
         ifcond =3D None
diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index a867ea5de1..cac5a6a392 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -162,7 +162,7 @@ const QLitObject %(c_name)s =3D %(c_string)s;
=20
     def visit_alternate_type(self, name, info, variants, ifcond):
         self._gen_qlit(name, 'alternate',
-                       {'members': [{'type': self._use_type(m.type)}
+                       {'members': [({'type': self._use_type(m.type)}, m=
.ifcond)
                                     for m in variants.variants]}, ifcond=
)
=20
     def visit_command(self, name, info, arg_type, ret_type,
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 816cc5c5e3..9462deb02b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -351,6 +351,7 @@ qapi-schema +=3D alternate-conflict-dict.json
 qapi-schema +=3D alternate-conflict-enum-bool.json
 qapi-schema +=3D alternate-conflict-enum-int.json
 qapi-schema +=3D alternate-conflict-string.json
+qapi-schema +=3D alternate-dict-invalid.json
 qapi-schema +=3D alternate-empty.json
 qapi-schema +=3D alternate-nested.json
 qapi-schema +=3D alternate-unknown.json
diff --git a/tests/qapi-schema/alternate-dict-invalid.err b/tests/qapi-sc=
hema/alternate-dict-invalid.err
new file mode 100644
index 0000000000..707c40f0f6
--- /dev/null
+++ b/tests/qapi-schema/alternate-dict-invalid.err
@@ -0,0 +1 @@
+tests/qapi-schema/alternate-dict-invalid.json:2: Member 'two' of alterna=
te 'Alt' should be a type name
diff --git a/tests/qapi-schema/alternate-dict-invalid.exit b/tests/qapi-s=
chema/alternate-dict-invalid.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/alternate-dict-invalid.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/alternate-dict-invalid.json b/tests/qapi-s=
chema/alternate-dict-invalid.json
new file mode 100644
index 0000000000..45f2c8ebef
--- /dev/null
+++ b/tests/qapi-schema/alternate-dict-invalid.json
@@ -0,0 +1,4 @@
+# invalid field dictionnary, missing type
+{ 'alternate': 'Alt',
+  'data': { 'one': 'str',
+            'two': { 'if': 'foo' } } }
diff --git a/tests/qapi-schema/alternate-dict-invalid.out b/tests/qapi-sc=
hema/alternate-dict-invalid.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index 01f7db58dc..46a4d1c3e5 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -206,9 +206,13 @@
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
   { 'foo': 'TestIfStruct', 'bar': { 'type': 'TestIfEnum', 'if': 'TEST_IF=
_CMD_BAR' } },
   'if': 'defined(TEST_IF_CMD) && defined(TEST_IF_STRUCT)' }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 7908eed6fc..a51c6ac15c 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -55,8 +55,11 @@ enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict=
', 'qlist', 'qbool']
 alternate TestIfAlternate
     tag type
     case foo: int
-    case bar: TestStruct
+    case alt_bar: TestStruct if=3Ddefined(TEST_IF_ALT_BAR)
     if defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)
+command TestIfAlternateCmd q_obj_TestIfAlternateCmd-arg -> None
+   gen=3DTrue success_response=3DTrue boxed=3DFalse
+    if defined(TEST_IF_ALT)
 command TestIfCmd q_obj_TestIfCmd-arg -> None
    gen=3DTrue success_response=3DTrue boxed=3DFalse
     if defined(TEST_IF_CMD) && defined(TEST_IF_STRUCT)
@@ -200,6 +203,9 @@ object q_obj_EVENT_D-arg
     member b: str optional=3DFalse
     member c: str optional=3DTrue
     member enum3: EnumOne optional=3DTrue
+object q_obj_TestIfAlternateCmd-arg
+    member alt_cmd_arg: TestIfAlternate optional=3DFalse
+    if defined(TEST_IF_ALT)
 object q_obj_TestIfCmd-arg
     member foo: TestIfStruct optional=3DFalse
     member bar: TestIfEnum optional=3DFalse if=3DTEST_IF_CMD_BAR
--=20
2.14.0.rc0.1.g40ca67566
