Received: from eggs.gnu.org ([2001:4830:134:3::10]:54767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9Hl-0006co-T2
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:32:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9Hk-00064T-7l
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:32:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dk9Hj-00063Q-UC
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:32:00 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:30 +0200
Message-Id: <20170822132255.23945-30-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 29/54] qapi: add 'if' to enum members
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
 scripts/qapi.py                         | 33 +++++++++++++++++++++++++++=
------
 tests/qapi-schema/enum-dict-member.err  |  1 -
 tests/qapi-schema/enum-dict-member.exit |  2 +-
 tests/qapi-schema/enum-dict-member.json |  3 +--
 tests/qapi-schema/enum-dict-member.out  |  4 ++++
 tests/qapi-schema/qapi-schema-test.json |  5 +++--
 tests/qapi-schema/qapi-schema-test.out  |  3 ++-
 tests/qapi-schema/test-qapi.py          |  4 +++-
 8 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 9d075440d3..9c7c01c11d 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -729,6 +729,10 @@ def check_event(expr, info):
                allow_metas=3Dmeta)
=20
=20
+def enum_get_values(expr):
+    return [e if isinstance(e, str) else e['name'] for e in expr['data']=
]
+
+
 def check_union(expr, info):
     name =3D expr['union']
     base =3D expr.get('base')
@@ -788,7 +792,7 @@ def check_union(expr, info):
         # If the discriminator names an enum type, then all members
         # of 'data' must also be members of the enum type.
         if enum_define:
-            if key not in enum_define['data']:
+            if key not in enum_get_values(enum_define):
                 raise QAPISemError(info,
                                    "Discriminator value '%s' is not foun=
d in "
                                    "enum '%s'"
@@ -796,7 +800,7 @@ def check_union(expr, info):
=20
     # If discriminator is user-defined, ensure all values are covered
     if enum_define:
-        for value in enum_define['data']:
+        for value in enum_get_values(enum_define):
             if value not in members.keys():
                 raise QAPISemError(info, "Union '%s' data missing '%s' b=
ranch"
                                    % (name, value))
@@ -827,7 +831,7 @@ def check_alternate(expr, info):
         if qtype =3D=3D 'QTYPE_QSTRING':
             enum_expr =3D enum_types.get(value)
             if enum_expr:
-                for v in enum_expr['data']:
+                for v in enum_get_values(enum_expr):
                     if v in ['on', 'off']:
                         conflicting.add('QTYPE_QBOOL')
                     if re.match(r'[-+0-9.]', v): # lazy, could be tighte=
ned
@@ -857,6 +861,12 @@ def check_enum(expr, info):
         raise QAPISemError(info,
                            "Enum '%s' requires a string for 'prefix'" % =
name)
     for member in members:
+        if isinstance(member, dict):
+            if not 'name' in member:
+                raise QAPISemError(info, "Dictionary member of enum '%s'=
 must "
+                                   "have a 'name' key" % name)
+            check_if(member, info)
+            member =3D member['name']
         check_name(info, "Member of enum '%s'" % name, member,
                    enum_member=3DTrue)
=20
@@ -1145,12 +1155,15 @@ class QAPISchemaEnumType(QAPISchemaType):
     def member_names(self):
         return [v.name for v in self.values]
=20
+    def members(self):
+        return [(v.name, v.ifcond) for v in self.values]
+
     def json_type(self):
         return 'string'
=20
     def visit(self, visitor):
         visitor.visit_enum_type(self.name, self.info,
-                                self.member_names(), self.prefix, self.i=
fcond)
+                                self.members(), self.prefix, self.ifcond=
)
=20
=20
 class QAPISchemaArrayType(QAPISchemaType):
@@ -1274,9 +1287,11 @@ class QAPISchemaObjectType(QAPISchemaType):
 class QAPISchemaMember(object):
     role =3D 'member'
=20
-    def __init__(self, name):
+    def __init__(self, name, ifcond=3DNone):
         assert isinstance(name, str)
+        assert ifcond is None or isinstance(ifcond, str)
         self.name =3D name
+        self.ifcond =3D ifcond
         self.owner =3D None
=20
     def set_owner(self, name):
@@ -1554,7 +1569,9 @@ class QAPISchema(object):
                                             qtype_values, 'QTYPE'))
=20
     def _make_enum_members(self, values):
-        return [QAPISchemaMember(v) for v in values]
+        return [QAPISchemaMember(v['name'], v.get('if')) if isinstance(v=
, dict)
+                else QAPISchemaMember(v)
+                for v in values]
=20
     def _make_implicit_enum_type(self, name, info, values, ifcond):
         # See also QAPISchemaObjectTypeMember._pretty_owner()
@@ -1950,6 +1967,8 @@ static const char *const %(c_name)s_array[] =3D {
 ''',
                 c_name=3Dc_name(name))
     for value in values:
+        if isinstance(value, tuple):
+            value, ifcond =3D value
         index =3D c_enum_const(name, value, prefix)
         ret +=3D mcgen('''
     [%(index)s] =3D "%(value)s",
@@ -1980,6 +1999,8 @@ typedef enum %(c_name)s {
                 c_name=3Dc_name(name))
=20
     for value in enum_values:
+        if isinstance(value, tuple):
+            value, ifcond =3D value
         ret +=3D mcgen('''
     %(c_enum)s,
 ''',
diff --git a/tests/qapi-schema/enum-dict-member.err b/tests/qapi-schema/e=
num-dict-member.err
index 8ca146ea59..e69de29bb2 100644
--- a/tests/qapi-schema/enum-dict-member.err
+++ b/tests/qapi-schema/enum-dict-member.err
@@ -1 +0,0 @@
-tests/qapi-schema/enum-dict-member.json:2: Member of enum 'MyEnum' requi=
res a string name
diff --git a/tests/qapi-schema/enum-dict-member.exit b/tests/qapi-schema/=
enum-dict-member.exit
index d00491fd7e..573541ac97 100644
--- a/tests/qapi-schema/enum-dict-member.exit
+++ b/tests/qapi-schema/enum-dict-member.exit
@@ -1 +1 @@
-1
+0
diff --git a/tests/qapi-schema/enum-dict-member.json b/tests/qapi-schema/=
enum-dict-member.json
index 79672e0f09..b09a83061c 100644
--- a/tests/qapi-schema/enum-dict-member.json
+++ b/tests/qapi-schema/enum-dict-member.json
@@ -1,2 +1 @@
-# we reject any enum member that is not a string
-{ 'enum': 'MyEnum', 'data': [ { 'value': 'str' } ] }
+{ 'enum': 'TestEnum', 'data': [ { 'name': 'foo' }, { 'name': 'bar' } ]}
diff --git a/tests/qapi-schema/enum-dict-member.out b/tests/qapi-schema/e=
num-dict-member.out
index e69de29bb2..cf8e3cce2b 100644
--- a/tests/qapi-schema/enum-dict-member.out
+++ b/tests/qapi-schema/enum-dict-member.out
@@ -0,0 +1,4 @@
+enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
+    prefix QTYPE
+enum TestEnum ['foo', 'bar']
+object q_empty
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index dc2c444fc1..ad2b405d83 100644
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
   'if': 'defined(TEST_IF_CMD) && defined(TEST_IF_STRUCT)' }
=20
 { 'event': 'TestIfEvent', 'data': { 'foo': 'TestIfStruct' },
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index fc5fd25f1b..211c367632 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -60,7 +60,7 @@ alternate TestIfAlternate
 command TestIfCmd q_obj_TestIfCmd-arg -> None
    gen=3DTrue success_response=3DTrue boxed=3DFalse
     if defined(TEST_IF_CMD) && defined(TEST_IF_STRUCT)
-enum TestIfEnum ['foo', 'bar']
+enum TestIfEnum ['foo', ('bar', 'defined(TEST_IF_ENUM_BAR)')]
     if defined(TEST_IF_ENUM)
 event TestIfEvent q_obj_TestIfEvent-arg
    boxed=3DFalse
@@ -197,6 +197,7 @@ object q_obj_EVENT_D-arg
     member enum3: EnumOne optional=3DTrue
 object q_obj_TestIfCmd-arg
     member foo: TestIfStruct optional=3DFalse
+    member bar: TestIfEnum optional=3DFalse
     if defined(TEST_IF_CMD) && defined(TEST_IF_STRUCT)
 object q_obj_TestIfEvent-arg
     member foo: TestIfStruct optional=3DFalse
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index 17fd975812..70054848f0 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -18,7 +18,9 @@ import sys
=20
 class QAPISchemaTestVisitor(QAPISchemaVisitor):
     def visit_enum_type(self, name, info, values, prefix, ifcond):
-        print 'enum %s %s' % (name, values)
+        values =3D ', '.join(["'%s'" % v[0] if not v[1] else str(v)
+                            for v in values])
+        print 'enum %s [%s]' % (name, values)
         if prefix:
             print '    prefix %s' % prefix
         self._print_if(ifcond)
--=20
2.14.1.146.gd35faa819
