Received: from eggs.gnu.org ([2001:4830:134:3::10]:50593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkVc-0006nd-Vp
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:35:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkVa-0002rv-Og
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:35:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkVa-0002qI-Fk
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:35:34 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:19 +0100
Message-Id: <20180111213250.16511-21-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 20/51] tests: modify visit_enum_type() in
 test-qapi to print members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Use a common self._print_members() to print enum members details.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/qapi-schema/comments.out           | 14 +++++++--
 tests/qapi-schema/doc-bad-section.out    | 13 +++++++--
 tests/qapi-schema/doc-good.out           | 17 +++++++++--
 tests/qapi-schema/empty.out              |  9 +++++-
 tests/qapi-schema/event-case.out         |  9 +++++-
 tests/qapi-schema/ident-with-escape.out  |  9 +++++-
 tests/qapi-schema/include-relpath.out    | 14 +++++++--
 tests/qapi-schema/include-repetition.out | 14 +++++++--
 tests/qapi-schema/include-simple.out     | 14 +++++++--
 tests/qapi-schema/indented-expr.out      |  9 +++++-
 tests/qapi-schema/qapi-schema-test.out   | 49 ++++++++++++++++++++++++++=
------
 tests/qapi-schema/test-qapi.py           | 15 +++++++---
 12 files changed, 156 insertions(+), 30 deletions(-)

diff --git a/tests/qapi-schema/comments.out b/tests/qapi-schema/comments.=
out
index 17e652535c..7c243b246b 100644
--- a/tests/qapi-schema/comments.out
+++ b/tests/qapi-schema/comments.out
@@ -1,4 +1,14 @@
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
+enum QType
     prefix QTYPE
-enum Status ['good', 'bad', 'ugly']
+    member none
+    member qnull
+    member qnum
+    member qstring
+    member qdict
+    member qlist
+    member qbool
+enum Status
+    member good
+    member bad
+    member ugly
 object q_empty
diff --git a/tests/qapi-schema/doc-bad-section.out b/tests/qapi-schema/do=
c-bad-section.out
index 089bde1381..77e223ba41 100644
--- a/tests/qapi-schema/doc-bad-section.out
+++ b/tests/qapi-schema/doc-bad-section.out
@@ -1,6 +1,15 @@
-enum Enum ['one', 'two']
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
+enum Enum
+    member one
+    member two
+enum QType
     prefix QTYPE
+    member none
+    member qnull
+    member qnum
+    member qstring
+    member qdict
+    member qlist
+    member qbool
 object q_empty
 doc symbol=3DEnum
     body=3D
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.=
out
index 1d2c250527..e615b04281 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -1,19 +1,30 @@
 object Base
     member base1: Enum optional=3DFalse
-enum Enum ['one', 'two']
+enum Enum
+    member one
+    member two
 object Object
     base Base
     tag base1
     case one: Variant1
     case two: Variant2
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
+enum QType
     prefix QTYPE
+    member none
+    member qnull
+    member qnum
+    member qstring
+    member qdict
+    member qlist
+    member qbool
 object SugaredUnion
     member type: SugaredUnionKind optional=3DFalse
     tag type
     case one: q_obj_Variant1-wrapper
     case two: q_obj_Variant2-wrapper
-enum SugaredUnionKind ['one', 'two']
+enum SugaredUnionKind
+    member one
+    member two
 object Variant1
     member var1: str optional=3DFalse
 object Variant2
diff --git a/tests/qapi-schema/empty.out b/tests/qapi-schema/empty.out
index 40b886ddae..0bd6d1421d 100644
--- a/tests/qapi-schema/empty.out
+++ b/tests/qapi-schema/empty.out
@@ -1,3 +1,10 @@
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
+enum QType
     prefix QTYPE
+    member none
+    member qnull
+    member qnum
+    member qstring
+    member qdict
+    member qlist
+    member qbool
 object q_empty
diff --git a/tests/qapi-schema/event-case.out b/tests/qapi-schema/event-c=
ase.out
index 313c0fe7be..fc64383edb 100644
--- a/tests/qapi-schema/event-case.out
+++ b/tests/qapi-schema/event-case.out
@@ -1,5 +1,12 @@
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
+enum QType
     prefix QTYPE
+    member none
+    member qnull
+    member qnum
+    member qstring
+    member qdict
+    member qlist
+    member qbool
 event oops None
    boxed=3DFalse
 object q_empty
diff --git a/tests/qapi-schema/ident-with-escape.out b/tests/qapi-schema/=
ident-with-escape.out
index b5637cb2e0..6458ffb28c 100644
--- a/tests/qapi-schema/ident-with-escape.out
+++ b/tests/qapi-schema/ident-with-escape.out
@@ -1,5 +1,12 @@
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
+enum QType
     prefix QTYPE
+    member none
+    member qnull
+    member qnum
+    member qstring
+    member qdict
+    member qlist
+    member qbool
 command fooA q_obj_fooA-arg -> None
    gen=3DTrue success_response=3DTrue boxed=3DFalse
 object q_empty
diff --git a/tests/qapi-schema/include-relpath.out b/tests/qapi-schema/in=
clude-relpath.out
index 17e652535c..7c243b246b 100644
--- a/tests/qapi-schema/include-relpath.out
+++ b/tests/qapi-schema/include-relpath.out
@@ -1,4 +1,14 @@
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
+enum QType
     prefix QTYPE
-enum Status ['good', 'bad', 'ugly']
+    member none
+    member qnull
+    member qnum
+    member qstring
+    member qdict
+    member qlist
+    member qbool
+enum Status
+    member good
+    member bad
+    member ugly
 object q_empty
diff --git a/tests/qapi-schema/include-repetition.out b/tests/qapi-schema=
/include-repetition.out
index 17e652535c..7c243b246b 100644
--- a/tests/qapi-schema/include-repetition.out
+++ b/tests/qapi-schema/include-repetition.out
@@ -1,4 +1,14 @@
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
+enum QType
     prefix QTYPE
-enum Status ['good', 'bad', 'ugly']
+    member none
+    member qnull
+    member qnum
+    member qstring
+    member qdict
+    member qlist
+    member qbool
+enum Status
+    member good
+    member bad
+    member ugly
 object q_empty
diff --git a/tests/qapi-schema/include-simple.out b/tests/qapi-schema/inc=
lude-simple.out
index 17e652535c..7c243b246b 100644
--- a/tests/qapi-schema/include-simple.out
+++ b/tests/qapi-schema/include-simple.out
@@ -1,4 +1,14 @@
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
+enum QType
     prefix QTYPE
-enum Status ['good', 'bad', 'ugly']
+    member none
+    member qnull
+    member qnum
+    member qstring
+    member qdict
+    member qlist
+    member qbool
+enum Status
+    member good
+    member bad
+    member ugly
 object q_empty
diff --git a/tests/qapi-schema/indented-expr.out b/tests/qapi-schema/inde=
nted-expr.out
index 586795f44d..7b066235fa 100644
--- a/tests/qapi-schema/indented-expr.out
+++ b/tests/qapi-schema/indented-expr.out
@@ -1,5 +1,12 @@
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
+enum QType
     prefix QTYPE
+    member none
+    member qnull
+    member qnum
+    member qstring
+    member qdict
+    member qlist
+    member qbool
 command eins None -> None
    gen=3DTrue success_response=3DTrue boxed=3DFalse
 object q_empty
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 0804c3af84..33afa965e8 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -33,7 +33,10 @@ event EVENT_F UserDefAlternate
 object Empty1
 object Empty2
     base Empty1
-enum EnumOne ['value1', 'value2', 'value3']
+enum EnumOne
+    member value1
+    member value2
+    member value3
 object EventStructOne
     member struct1: UserDefOne optional=3DFalse
     member string: str optional=3DFalse
@@ -42,16 +45,25 @@ object ForceArrays
     member unused1: UserDefOneList optional=3DFalse
     member unused2: UserDefTwoList optional=3DFalse
     member unused3: TestStructList optional=3DFalse
-enum MyEnum []
+enum MyEnum
 object NestedEnumsOne
     member enum1: EnumOne optional=3DFalse
     member enum2: EnumOne optional=3DTrue
     member enum3: EnumOne optional=3DFalse
     member enum4: EnumOne optional=3DTrue
-enum QEnumTwo ['value1', 'value2']
+enum QEnumTwo
     prefix QENUM_TWO
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
+    member value1
+    member value2
+enum QType
     prefix QTYPE
+    member none
+    member qnull
+    member qnum
+    member qstring
+    member qdict
+    member qlist
+    member qbool
 alternate TestIfAlternate
     tag type
     case foo: int
@@ -60,7 +72,9 @@ alternate TestIfAlternate
 command TestIfCmd q_obj_TestIfCmd-arg -> None
    gen=3DTrue success_response=3DTrue boxed=3DFalse
     if ['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)']
-enum TestIfEnum ['foo', 'bar']
+enum TestIfEnum
+    member foo
+    member bar
     if ['defined(TEST_IF_ENUM)']
 event TestIfEvent q_obj_TestIfEvent-arg
    boxed=3DFalse
@@ -73,7 +87,8 @@ object TestIfUnion
     tag type
     case foo: q_obj_TestStruct-wrapper
     if ['defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)']
-enum TestIfUnionKind ['foo']
+enum TestIfUnionKind
+    member foo
     if ['defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)']
 object TestStruct
     member integer: int optional=3DFalse
@@ -122,7 +137,21 @@ object UserDefNativeListUnion
     case string: q_obj_strList-wrapper
     case sizes: q_obj_sizeList-wrapper
     case any: q_obj_anyList-wrapper
-enum UserDefNativeListUnionKind ['integer', 's8', 's16', 's32', 's64', '=
u8', 'u16', 'u32', 'u64', 'number', 'boolean', 'string', 'sizes', 'any']
+enum UserDefNativeListUnionKind
+    member integer
+    member s8
+    member s16
+    member s32
+    member s64
+    member u8
+    member u16
+    member u32
+    member u64
+    member number
+    member boolean
+    member string
+    member sizes
+    member any
 object UserDefOne
     base UserDefZero
     member string: str optional=3DFalse
@@ -159,7 +188,8 @@ alternate __org.qemu_x-Alt
     case b: __org.qemu_x-Base
 object __org.qemu_x-Base
     member __org.qemu_x-member1: __org.qemu_x-Enum optional=3DFalse
-enum __org.qemu_x-Enum ['__org.qemu_x-value']
+enum __org.qemu_x-Enum
+    member __org.qemu_x-value
 object __org.qemu_x-Struct
     base __org.qemu_x-Base
     member __org.qemu_x-member2: str optional=3DFalse
@@ -170,7 +200,8 @@ object __org.qemu_x-Union1
     member type: __org.qemu_x-Union1Kind optional=3DFalse
     tag type
     case __org.qemu_x-branch: q_obj_str-wrapper
-enum __org.qemu_x-Union1Kind ['__org.qemu_x-branch']
+enum __org.qemu_x-Union1Kind
+    member __org.qemu_x-branch
 object __org.qemu_x-Union2
     base __org.qemu_x-Base
     tag __org.qemu_x-member1
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index 2ab79230c2..aadc8452b4 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -18,18 +18,17 @@ import sys
=20
 class QAPISchemaTestVisitor(QAPISchemaVisitor):
     def visit_enum_type(self, name, info, ifcond, members, prefix):
-        print 'enum %s %s' % (name, [m.name for m in members])
+        print 'enum %s' % name
         if prefix:
             print '    prefix %s' % prefix
+        self._print_members(members)
         self._print_if(ifcond)
=20
     def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
         print 'object %s' % name
         if base:
             print '    base %s' % base.name
-        for m in members:
-            print '    member %s: %s optional=3D%s' % \
-                (m.name, m.type.name, m.optional)
+        self._print_members(members)
         self._print_variants(variants)
         self._print_if(ifcond)
=20
@@ -51,6 +50,14 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
         print '   boxed=3D%s' % boxed
         self._print_if(ifcond)
=20
+    @staticmethod
+    def _print_members(members):
+        for m in members:
+            print '    member %s%s' % (
+                m.name,
+                ': %s optional=3D%s' % (m.type.name, m.optional)
+                if isinstance(m, QAPISchemaObjectTypeMember) else '')
+
     @staticmethod
     def _print_variants(variants):
         if variants:
--=20
2.16.0.rc1.1.gef27df75a1
