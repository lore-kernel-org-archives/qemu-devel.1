Received: from eggs.gnu.org ([2001:4830:134:3::10]:53428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVyB-00066f-F5
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:44:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVy7-0003n5-1J
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:44:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXVy0-0001ic-JZ
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:44:15 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 448FC307EA84
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 18:43:50 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 13 Dec 2018 19:43:32 +0100
Message-Id: <20181213184340.24037-25-armbru@redhat.com>
In-Reply-To: <20181213184340.24037-1-armbru@redhat.com>
References: <20181213184340.24037-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 24/32] qapi: Add 'if' to implicit struct members
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

The generated code is for now *unconditional*.  Later patches generate
the conditionals.

Note that union discriminators may not have 'if' conditionals.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20181213123724.4866-14-marcandre.lureau@redhat.com>
Message-Id: <20181213123724.4866-15-marcandre.lureau@redhat.com>
[Patches squashed, commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt                   | 10 ++++++++++
 scripts/qapi/common.py                         | 18 +++++++++++-------
 tests/Makefile.include                         |  1 +
 .../flat-union-invalid-if-discriminator.err    |  1 +
 .../flat-union-invalid-if-discriminator.exit   |  1 +
 .../flat-union-invalid-if-discriminator.json   | 17 +++++++++++++++++
 .../flat-union-invalid-if-discriminator.out    |  0
 tests/qapi-schema/qapi-schema-test.json        | 12 +++++++++---
 tests/qapi-schema/qapi-schema-test.out         |  5 +++++
 tests/qapi-schema/test-qapi.py                 |  1 +
 10 files changed, 56 insertions(+), 10 deletions(-)
 create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.err
 create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.exit
 create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.json
 create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.out

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 7ba9066eac..3895808b4a 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -752,6 +752,16 @@ gets its generated code guarded like this:
  #endif /* defined(HAVE_BAR) */
  #endif /* defined(CONFIG_FOO) */
=20
+Where a member can be defined with a single string value for its type,
+it is also possible to supply a dictionary instead with both 'type'
+and 'if' keys. (TODO: union and alternate)
+
+Example: a conditional 'bar' member
+
+{ 'struct': 'IfStruct', 'data':
+  { 'foo': 'int',
+    'bar': { 'type': 'int', 'if': 'defined(IFCOND)'} } }
+
 An enum value can be replaced by a dictionary with a 'name' and a 'if'
 key.
=20
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index cdfe2bf2a5..98e9d6f109 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -705,7 +705,7 @@ def check_type(info, source, value, allow_array=3DFal=
se,
         # Todo: allow dictionaries to represent default values of
         # an optional argument.
         check_known_keys(info, "member '%s' of %s" % (key, source),
-                         arg, ['type'], [])
+                         arg, ['type'], ['if'])
         check_type(info, "Member '%s' of %s" % (key, source),
                    arg['type'], allow_array=3DTrue,
                    allow_metas=3D['built-in', 'union', 'alternate', 'str=
uct',
@@ -784,6 +784,10 @@ def check_union(expr, info):
                                "Discriminator '%s' is not a member of ba=
se "
                                "struct '%s'"
                                % (discriminator, base))
+        if discriminator_value.get('if'):
+            raise QAPISemError(info, 'The discriminator %s.%s for union =
%s '
+                               'must not be conditional' %
+                               (base, discriminator, name))
         enum_define =3D enum_types.get(discriminator_value['type'])
         allow_metas =3D ['struct']
         # Do not allow string discriminator
@@ -1412,8 +1416,8 @@ class QAPISchemaMember(object):
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
@@ -1727,7 +1731,7 @@ class QAPISchema(object):
             name, info, doc, ifcond,
             self._make_enum_members(data), prefix))
=20
-    def _make_member(self, name, typ, info):
+    def _make_member(self, name, typ, ifcond, info):
         optional =3D False
         if name.startswith('*'):
             name =3D name[1:]
@@ -1735,10 +1739,10 @@ class QAPISchema(object):
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
@@ -1759,7 +1763,7 @@ class QAPISchema(object):
             typ =3D self._make_array_type(typ[0], info)
         typ =3D self._make_implicit_object_type(
             typ, info, None, self.lookup_type(typ),
-            'wrapper', [self._make_member('data', typ, info)])
+            'wrapper', [self._make_member('data', typ, None, info)])
         return QAPISchemaObjectTypeVariant(case, typ)
=20
     def _def_union_type(self, expr, info, doc):
diff --git a/tests/Makefile.include b/tests/Makefile.include
index ea5d1e8787..3f5a1d0c30 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -409,6 +409,7 @@ qapi-schema +=3D flat-union-inline-invalid-dict.json
 qapi-schema +=3D flat-union-int-branch.json
 qapi-schema +=3D flat-union-invalid-branch-key.json
 qapi-schema +=3D flat-union-invalid-discriminator.json
+qapi-schema +=3D flat-union-invalid-if-discriminator.json
 qapi-schema +=3D flat-union-no-base.json
 qapi-schema +=3D flat-union-optional-discriminator.json
 qapi-schema +=3D flat-union-string-discriminator.json
diff --git a/tests/qapi-schema/flat-union-invalid-if-discriminator.err b/=
tests/qapi-schema/flat-union-invalid-if-discriminator.err
new file mode 100644
index 0000000000..0c94c9860d
--- /dev/null
+++ b/tests/qapi-schema/flat-union-invalid-if-discriminator.err
@@ -0,0 +1 @@
+tests/qapi-schema/flat-union-invalid-if-discriminator.json:13: The discr=
iminator TestBase.enum1 for union TestUnion must not be conditional
diff --git a/tests/qapi-schema/flat-union-invalid-if-discriminator.exit b=
/tests/qapi-schema/flat-union-invalid-if-discriminator.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/flat-union-invalid-if-discriminator.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/flat-union-invalid-if-discriminator.json b=
/tests/qapi-schema/flat-union-invalid-if-discriminator.json
new file mode 100644
index 0000000000..618ec36396
--- /dev/null
+++ b/tests/qapi-schema/flat-union-invalid-if-discriminator.json
@@ -0,0 +1,17 @@
+{ 'enum': 'TestEnum',
+  'data': [ 'value1', 'value2' ] }
+
+{ 'struct': 'TestBase',
+  'data': { 'enum1': { 'type': 'TestEnum', 'if': 'FOO' } } }
+
+{ 'struct': 'TestTypeA',
+  'data': { 'string': 'str' } }
+
+{ 'struct': 'TestTypeB',
+  'data': { 'integer': 'int' } }
+
+{ 'union': 'TestUnion',
+  'base': 'TestBase',
+  'discriminator': 'enum1',
+  'data': { 'value1': 'TestTypeA',
+            'value2': 'TestTypeB' } }
diff --git a/tests/qapi-schema/flat-union-invalid-if-discriminator.out b/=
tests/qapi-schema/flat-union-invalid-if-discriminator.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index 40b162664d..c46f3b5732 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -201,7 +201,9 @@
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
@@ -220,11 +222,15 @@
 { 'command': 'TestIfAlternateCmd', 'data': { 'alt_cmd_arg': 'TestIfAlter=
nate' },
   'if': 'defined(TEST_IF_ALT)' }
=20
-{ 'command': 'TestIfCmd', 'data': { 'foo': 'TestIfStruct', 'bar': 'TestI=
fEnum' },
+{ 'command': 'TestIfCmd', 'data':
+  { 'foo': 'TestIfStruct',
+    'bar': { 'type': 'TestIfEnum', 'if': 'defined(TEST_IF_CMD_BAR)' } },
   'returns': 'UserDefThree',
   'if': ['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)'] }
=20
 { 'command': 'TestCmdReturnDefThree', 'returns': 'UserDefThree' }
=20
-{ 'event': 'TestIfEvent', 'data': { 'foo': 'TestIfStruct' },
+{ 'event': 'TestIfEvent', 'data':
+  { 'foo': 'TestIfStruct',
+    'bar': { 'type': 'TestIfEnum', 'if': 'defined(TEST_IF_EVT_BAR)' } },
   'if': 'defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)' }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index d90d987651..7987b23403 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -268,6 +268,8 @@ command __org.qemu_x-command q_obj___org.qemu_x-comma=
nd-arg -> __org.qemu_x-Unio
    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
 object TestIfStruct
     member foo: int optional=3DFalse
+    member bar: int optional=3DFalse
+        if ['defined(TEST_IF_STRUCT_BAR)']
     if ['defined(TEST_IF_STRUCT)']
 enum TestIfEnum
     member foo
@@ -304,6 +306,7 @@ command TestIfAlternateCmd q_obj_TestIfAlternateCmd-a=
rg -> None
 object q_obj_TestIfCmd-arg
     member foo: TestIfStruct optional=3DFalse
     member bar: TestIfEnum optional=3DFalse
+        if ['defined(TEST_IF_CMD_BAR)']
     if ['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)']
 command TestIfCmd q_obj_TestIfCmd-arg -> UserDefThree
    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
@@ -312,6 +315,8 @@ command TestCmdReturnDefThree None -> UserDefThree
    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
 object q_obj_TestIfEvent-arg
     member foo: TestIfStruct optional=3DFalse
+    member bar: TestIfEnum optional=3DFalse
+        if ['defined(TEST_IF_EVT_BAR)']
     if ['defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)']
 event TestIfEvent q_obj_TestIfEvent-arg
    boxed=3DFalse
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index aadf252d9d..27081cb50c 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -39,6 +39,7 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
         for m in members:
             print('    member %s: %s optional=3D%s'
                   % (m.name, m.type.name, m.optional))
+            self._print_if(m.ifcond, 8)
         self._print_variants(variants)
         self._print_if(ifcond)
=20
--=20
2.17.2
