Received: from eggs.gnu.org ([2001:4830:134:3::10]:58929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dal44-0008GX-Cx
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dal41-0006Xv-9E
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:51:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dal40-0006Wz-V9
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:51:01 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 27 Jul 2017 17:41:09 +0200
Message-Id: <20170727154126.11339-10-marcandre.lureau@redhat.com>
In-Reply-To: <20170727154126.11339-1-marcandre.lureau@redhat.com>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 09/26] qapi: add 'if' condition on struct member
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
 scripts/qapi.py                           | 18 ++++++++++++++----
 scripts/qapi-introspect.py                |  2 ++
 scripts/qapi-types.py                     |  2 ++
 scripts/qapi-visit.py                     |  2 ++
 tests/Makefile.include                    |  2 ++
 tests/qapi-schema/qapi-schema-test.json   |  9 ++++++---
 tests/qapi-schema/qapi-schema-test.out    |  4 +++-
 tests/qapi-schema/struct-if-invalid.err   |  1 +
 tests/qapi-schema/struct-if-invalid.exit  |  1 +
 tests/qapi-schema/struct-if-invalid.json  |  3 +++
 tests/qapi-schema/struct-if-invalid.out   |  0
 tests/qapi-schema/struct-member-type.err  |  0
 tests/qapi-schema/struct-member-type.exit |  1 +
 tests/qapi-schema/struct-member-type.json |  1 +
 tests/qapi-schema/struct-member-type.out  |  5 +++++
 tests/qapi-schema/test-qapi.py            |  3 ++-
 16 files changed, 45 insertions(+), 9 deletions(-)
 create mode 100644 tests/qapi-schema/struct-if-invalid.err
 create mode 100644 tests/qapi-schema/struct-if-invalid.exit
 create mode 100644 tests/qapi-schema/struct-if-invalid.json
 create mode 100644 tests/qapi-schema/struct-if-invalid.out
 create mode 100644 tests/qapi-schema/struct-member-type.err
 create mode 100644 tests/qapi-schema/struct-member-type.exit
 create mode 100644 tests/qapi-schema/struct-member-type.json
 create mode 100644 tests/qapi-schema/struct-member-type.out

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 93d07283e6..1eb40590fb 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -678,7 +678,13 @@ def check_type(info, source, value, allow_array=3DFa=
lse,
         return
=20
     if not allow_dict:
-        raise QAPISemError(info, "%s should be a type name" % source)
+        if isinstance(value, dict) and 'type' in value:
+            check_type(info, source, value['type'], allow_array,
+                       allow_dict, allow_optional, allow_metas)
+            check_if(value, info)
+            return
+        else:
+            raise QAPISemError(info, "%s should be a type name" % source=
)
=20
     if not isinstance(value, OrderedDict):
         raise QAPISemError(info,
@@ -1333,8 +1339,8 @@ class QAPISchemaMember(object):
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
@@ -1611,13 +1617,17 @@ class QAPISchema(object):
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
diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index ecfb0f2752..98b320a79e 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -130,6 +130,8 @@ const QLitObject %(c_name)s =3D %(c_string)s;
         ret =3D {'name': member.name, 'type': self._use_type(member.type=
)}
         if member.optional:
             ret['default'] =3D None
+        if member.ifcond:
+            ret =3D (ret, member.ifcond)
         return ret
=20
     def _gen_variants(self, tag_name, variants):
diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index d0d2eb917c..659fb1da86 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi-types.py
@@ -41,6 +41,7 @@ struct %(c_name)s {
 def gen_struct_members(members):
     ret =3D ''
     for memb in members:
+        ret +=3D gen_if(memb.ifcond)
         if memb.optional:
             ret +=3D mcgen('''
     bool has_%(c_name)s;
@@ -50,6 +51,7 @@ def gen_struct_members(members):
     %(c_type)s %(c_name)s;
 ''',
                      c_type=3Dmemb.type.c_type(), c_name=3Dc_name(memb.n=
ame))
+        ret +=3D gen_endif(memb.ifcond)
     return ret
=20
=20
diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index 335407d078..f400cef13c 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -53,6 +53,7 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_name=
)s *obj, Error **errp)
                      c_type=3Dbase.c_name())
=20
     for memb in members:
+        ret +=3D gen_if(memb.ifcond)
         if memb.optional:
             ret +=3D mcgen('''
     if (visit_optional(v, "%(name)s", &obj->has_%(c_name)s)) {
@@ -72,6 +73,7 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_name=
)s *obj, Error **errp)
             ret +=3D mcgen('''
     }
 ''')
+        ret +=3D gen_endif(memb.ifcond)
=20
     if variants:
         ret +=3D mcgen('''
diff --git a/tests/Makefile.include b/tests/Makefile.include
index cb5daf0009..816cc5c5e3 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -489,7 +489,9 @@ qapi-schema +=3D returns-whitelist.json
 qapi-schema +=3D struct-base-clash-deep.json
 qapi-schema +=3D struct-base-clash.json
 qapi-schema +=3D struct-data-invalid.json
+qapi-schema +=3D struct-if-invalid.json
 qapi-schema +=3D struct-member-invalid.json
+qapi-schema +=3D struct-member-type.json
 qapi-schema +=3D trailing-comma-list.json
 qapi-schema +=3D trailing-comma-object.json
 qapi-schema +=3D type-bypass-bad-gen.json
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index ad2b405d83..bb515280d2 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -191,7 +191,8 @@
=20
 # test 'if' condition handling
=20
-{ 'struct': 'TestIfStruct', 'data': { 'foo': 'int' },
+{ 'struct': 'TestIfStruct', 'data':
+  { 'foo': 'int', 'bar': { 'type': 'int', 'if': 'defined(TEST_IF_STRUCT_=
BAR)'} },
   'if': 'defined(TEST_IF_STRUCT)' }
=20
 { 'enum': 'TestIfEnum', 'data':
@@ -204,8 +205,10 @@
 { 'alternate': 'TestIfAlternate', 'data': { 'foo': 'int', 'bar': 'TestSt=
ruct' },
   'if': 'defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)' }
=20
-{ 'command': 'TestIfCmd', 'data': { 'foo': 'TestIfStruct', 'bar': 'TestI=
fEnum' },
+{ 'command': 'TestIfCmd', 'data':
+  { 'foo': 'TestIfStruct', 'bar': { 'type': 'TestIfEnum', 'if': 'TEST_IF=
_CMD_BAR' } },
   'if': 'defined(TEST_IF_CMD) && defined(TEST_IF_STRUCT)' }
=20
-{ 'event': 'TestIfEvent', 'data': { 'foo': 'TestIfStruct' },
+{ 'event': 'TestIfEvent', 'data':
+  { 'foo': 'TestIfStruct', 'bar': { 'type': 'TestIfEnum', 'if': 'TEST_IF=
_EVT_BAR' } },
   'if': 'defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)' }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 211c367632..b17c32a45f 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -67,6 +67,7 @@ event TestIfEvent q_obj_TestIfEvent-arg
     if defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)
 object TestIfStruct
     member foo: int optional=3DFalse
+    member bar: int optional=3DFalse if=3Ddefined(TEST_IF_STRUCT_BAR)
     if defined(TEST_IF_STRUCT)
 object TestIfUnion
     member type: TestIfUnionKind optional=3DFalse
@@ -197,10 +198,11 @@ object q_obj_EVENT_D-arg
     member enum3: EnumOne optional=3DTrue
 object q_obj_TestIfCmd-arg
     member foo: TestIfStruct optional=3DFalse
-    member bar: TestIfEnum optional=3DFalse
+    member bar: TestIfEnum optional=3DFalse if=3DTEST_IF_CMD_BAR
     if defined(TEST_IF_CMD) && defined(TEST_IF_STRUCT)
 object q_obj_TestIfEvent-arg
     member foo: TestIfStruct optional=3DFalse
+    member bar: TestIfEnum optional=3DFalse if=3DTEST_IF_EVT_BAR
     if defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)
 object q_obj_TestStruct-wrapper
     member data: TestStruct optional=3DFalse
diff --git a/tests/qapi-schema/struct-if-invalid.err b/tests/qapi-schema/=
struct-if-invalid.err
new file mode 100644
index 0000000000..42245262a9
--- /dev/null
+++ b/tests/qapi-schema/struct-if-invalid.err
@@ -0,0 +1 @@
+tests/qapi-schema/struct-if-invalid.json:2: Member 'bar' of 'data' for s=
truct 'TestIfStruct' should be a type name
diff --git a/tests/qapi-schema/struct-if-invalid.exit b/tests/qapi-schema=
/struct-if-invalid.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/struct-if-invalid.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/struct-if-invalid.json b/tests/qapi-schema=
/struct-if-invalid.json
new file mode 100644
index 0000000000..466cdb61e1
--- /dev/null
+++ b/tests/qapi-schema/struct-if-invalid.json
@@ -0,0 +1,3 @@
+# check missing 'type'
+{ 'struct': 'TestIfStruct', 'data':
+  { 'foo': 'int', 'bar': { 'if': 'defined(TEST_IF_STRUCT_BAR)' } } }
diff --git a/tests/qapi-schema/struct-if-invalid.out b/tests/qapi-schema/=
struct-if-invalid.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/struct-member-type.err b/tests/qapi-schema=
/struct-member-type.err
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/struct-member-type.exit b/tests/qapi-schem=
a/struct-member-type.exit
new file mode 100644
index 0000000000..573541ac97
--- /dev/null
+++ b/tests/qapi-schema/struct-member-type.exit
@@ -0,0 +1 @@
+0
diff --git a/tests/qapi-schema/struct-member-type.json b/tests/qapi-schem=
a/struct-member-type.json
new file mode 100644
index 0000000000..07de38fa4a
--- /dev/null
+++ b/tests/qapi-schema/struct-member-type.json
@@ -0,0 +1 @@
+{ 'struct': 'foo', 'data': { 'a': { 'type': 'str' } } }
diff --git a/tests/qapi-schema/struct-member-type.out b/tests/qapi-schema=
/struct-member-type.out
new file mode 100644
index 0000000000..2ea68909a9
--- /dev/null
+++ b/tests/qapi-schema/struct-member-type.out
@@ -0,0 +1,5 @@
+enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
+    prefix QTYPE
+object foo
+    member a: str optional=3DFalse
+object q_empty
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index 70054848f0..5d2f67a1d3 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -31,7 +31,8 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
             print '    base %s' % base.name
         for m in members:
             print '    member %s: %s optional=3D%s' % \
-                (m.name, m.type.name, m.optional)
+                (m.name, m.type.name, m.optional) + \
+                (' if=3D%s' % m.ifcond if m.ifcond else '')
         self._print_variants(variants)
         self._print_if(ifcond)
=20
--=20
2.14.0.rc0.1.g40ca67566
