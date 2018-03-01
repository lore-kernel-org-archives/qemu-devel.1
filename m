Received: from eggs.gnu.org ([2001:4830:134:3::10]:40632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU6w-0000wD-Rg
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU6t-0007gf-Rq
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1erU6t-0007fp-HE
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:23 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu,  1 Mar 2018 13:42:31 -0600
Message-Id: <20180301194245.29854-17-eblake@redhat.com>
In-Reply-To: <20180301194245.29854-1-eblake@redhat.com>
References: <20180301194245.29854-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/30] qapi: Generate in source order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

From: Markus Armbruster <armbru@redhat.com>

The generators' conversion to visitors (merge commit 9e72681d16)
changed the processing order of entities from source order to
alphabetical order.  The next commit needs source order, so change it
back.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180211093607.27351-17-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi/common.py                   |   6 +-
 tests/qapi-schema/comments.out           |   2 +-
 tests/qapi-schema/doc-bad-section.out    |   4 +-
 tests/qapi-schema/doc-good.out           |  32 ++--
 tests/qapi-schema/empty.out              |   2 +-
 tests/qapi-schema/event-case.out         |   2 +-
 tests/qapi-schema/ident-with-escape.out  |   6 +-
 tests/qapi-schema/include-relpath.out    |   2 +-
 tests/qapi-schema/include-repetition.out |   2 +-
 tests/qapi-schema/include-simple.out     |   2 +-
 tests/qapi-schema/indented-expr.out      |   2 +-
 tests/qapi-schema/qapi-schema-test.out   | 320 +++++++++++++++----------=
------
 12 files changed, 192 insertions(+), 190 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 961331a210c..1aa1cd3b9bd 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1474,6 +1474,7 @@ class QAPISchema(object):
         parser =3D QAPISchemaParser(open(fname, 'r'))
         exprs =3D check_exprs(parser.exprs)
         self.docs =3D parser.docs
+        self._entity_list =3D []
         self._entity_dict =3D {}
         self._predefining =3D True
         self._def_predefineds()
@@ -1485,6 +1486,7 @@ class QAPISchema(object):
         # Only the predefined types are allowed to not have info
         assert ent.info or self._predefining
         assert ent.name not in self._entity_dict
+        self._entity_list.append(ent)
         self._entity_dict[ent.name] =3D ent

     def lookup_entity(self, name, typ=3DNone):
@@ -1683,12 +1685,12 @@ class QAPISchema(object):
                 assert False

     def check(self):
-        for (name, ent) in sorted(self._entity_dict.items()):
+        for ent in self._entity_list:
             ent.check(self)

     def visit(self, visitor):
         visitor.visit_begin(self)
-        for (name, entity) in sorted(self._entity_dict.items()):
+        for entity in self._entity_list:
             if visitor.visit_needed(entity):
                 entity.visit(visitor)
         visitor.visit_end()
diff --git a/tests/qapi-schema/comments.out b/tests/qapi-schema/comments.=
out
index 17e652535c0..0261ddf202c 100644
--- a/tests/qapi-schema/comments.out
+++ b/tests/qapi-schema/comments.out
@@ -1,4 +1,4 @@
+object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
 enum Status ['good', 'bad', 'ugly']
-object q_empty
diff --git a/tests/qapi-schema/doc-bad-section.out b/tests/qapi-schema/do=
c-bad-section.out
index 089bde13818..23bf8c71aba 100644
--- a/tests/qapi-schema/doc-bad-section.out
+++ b/tests/qapi-schema/doc-bad-section.out
@@ -1,7 +1,7 @@
-enum Enum ['one', 'two']
+object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
-object q_empty
+enum Enum ['one', 'two']
 doc symbol=3DEnum
     body=3D
 =3D=3D Produces *invalid* texinfo
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.=
out
index 1d2c250527f..0c07301f07a 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -1,35 +1,35 @@
+object q_empty
+enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
+    prefix QTYPE
+enum Enum ['one', 'two']
 object Base
     member base1: Enum optional=3DFalse
-enum Enum ['one', 'two']
+object Variant1
+    member var1: str optional=3DFalse
+object Variant2
 object Object
     base Base
     tag base1
     case one: Variant1
     case two: Variant2
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
-    prefix QTYPE
+object q_obj_Variant1-wrapper
+    member data: Variant1 optional=3DFalse
+object q_obj_Variant2-wrapper
+    member data: Variant2 optional=3DFalse
+enum SugaredUnionKind ['one', 'two']
 object SugaredUnion
     member type: SugaredUnionKind optional=3DFalse
     tag type
     case one: q_obj_Variant1-wrapper
     case two: q_obj_Variant2-wrapper
-enum SugaredUnionKind ['one', 'two']
-object Variant1
-    member var1: str optional=3DFalse
-object Variant2
-command cmd q_obj_cmd-arg -> Object
-   gen=3DTrue success_response=3DTrue boxed=3DFalse
-command cmd-boxed Object -> None
-   gen=3DTrue success_response=3DTrue boxed=3DTrue
-object q_empty
-object q_obj_Variant1-wrapper
-    member data: Variant1 optional=3DFalse
-object q_obj_Variant2-wrapper
-    member data: Variant2 optional=3DFalse
 object q_obj_cmd-arg
     member arg1: int optional=3DFalse
     member arg2: str optional=3DTrue
     member arg3: bool optional=3DFalse
+command cmd q_obj_cmd-arg -> Object
+   gen=3DTrue success_response=3DTrue boxed=3DFalse
+command cmd-boxed Object -> None
+   gen=3DTrue success_response=3DTrue boxed=3DTrue
 doc freeform
     body=3D
 =3D Section
diff --git a/tests/qapi-schema/empty.out b/tests/qapi-schema/empty.out
index 40b886ddae1..0ec234eec4d 100644
--- a/tests/qapi-schema/empty.out
+++ b/tests/qapi-schema/empty.out
@@ -1,3 +1,3 @@
+object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
-object q_empty
diff --git a/tests/qapi-schema/event-case.out b/tests/qapi-schema/event-c=
ase.out
index 313c0fe7be8..110571b793c 100644
--- a/tests/qapi-schema/event-case.out
+++ b/tests/qapi-schema/event-case.out
@@ -1,5 +1,5 @@
+object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
 event oops None
    boxed=3DFalse
-object q_empty
diff --git a/tests/qapi-schema/ident-with-escape.out b/tests/qapi-schema/=
ident-with-escape.out
index b5637cb2e0d..8336aa7629d 100644
--- a/tests/qapi-schema/ident-with-escape.out
+++ b/tests/qapi-schema/ident-with-escape.out
@@ -1,7 +1,7 @@
+object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
-command fooA q_obj_fooA-arg -> None
-   gen=3DTrue success_response=3DTrue boxed=3DFalse
-object q_empty
 object q_obj_fooA-arg
     member bar1: str optional=3DFalse
+command fooA q_obj_fooA-arg -> None
+   gen=3DTrue success_response=3DTrue boxed=3DFalse
diff --git a/tests/qapi-schema/include-relpath.out b/tests/qapi-schema/in=
clude-relpath.out
index 17e652535c0..0261ddf202c 100644
--- a/tests/qapi-schema/include-relpath.out
+++ b/tests/qapi-schema/include-relpath.out
@@ -1,4 +1,4 @@
+object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
 enum Status ['good', 'bad', 'ugly']
-object q_empty
diff --git a/tests/qapi-schema/include-repetition.out b/tests/qapi-schema=
/include-repetition.out
index 17e652535c0..0261ddf202c 100644
--- a/tests/qapi-schema/include-repetition.out
+++ b/tests/qapi-schema/include-repetition.out
@@ -1,4 +1,4 @@
+object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
 enum Status ['good', 'bad', 'ugly']
-object q_empty
diff --git a/tests/qapi-schema/include-simple.out b/tests/qapi-schema/inc=
lude-simple.out
index 17e652535c0..0261ddf202c 100644
--- a/tests/qapi-schema/include-simple.out
+++ b/tests/qapi-schema/include-simple.out
@@ -1,4 +1,4 @@
+object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
 enum Status ['good', 'bad', 'ugly']
-object q_empty
diff --git a/tests/qapi-schema/indented-expr.out b/tests/qapi-schema/inde=
nted-expr.out
index 586795f44d3..34de8be4262 100644
--- a/tests/qapi-schema/indented-expr.out
+++ b/tests/qapi-schema/indented-expr.out
@@ -1,7 +1,7 @@
+object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
 command eins None -> None
    gen=3DTrue success_response=3DTrue boxed=3DFalse
-object q_empty
 command zwei None -> None
    gen=3DTrue success_response=3DTrue boxed=3DFalse
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 3b1e9082d36..50706b01369 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -1,87 +1,129 @@
-alternate AltEnumBool
-    tag type
-    case e: EnumOne
-    case b: bool
-alternate AltEnumInt
-    tag type
-    case e: EnumOne
-    case i: int
-alternate AltEnumNum
-    tag type
-    case e: EnumOne
-    case n: number
-alternate AltNumEnum
-    tag type
-    case n: number
-    case e: EnumOne
-alternate AltStrObj
-    tag type
-    case s: str
-    case o: TestStruct
-event EVENT_A None
-   boxed=3DFalse
-event EVENT_B None
-   boxed=3DFalse
-event EVENT_C q_obj_EVENT_C-arg
-   boxed=3DFalse
-event EVENT_D q_obj_EVENT_D-arg
-   boxed=3DFalse
-event EVENT_E UserDefZero
-   boxed=3DTrue
-event EVENT_F UserDefAlternate
-   boxed=3DTrue
+object q_empty
+enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
+    prefix QTYPE
+object TestStruct
+    member integer: int optional=3DFalse
+    member boolean: bool optional=3DFalse
+    member string: str optional=3DFalse
+object NestedEnumsOne
+    member enum1: EnumOne optional=3DFalse
+    member enum2: EnumOne optional=3DTrue
+    member enum3: EnumOne optional=3DFalse
+    member enum4: EnumOne optional=3DTrue
+enum MyEnum []
 object Empty1
 object Empty2
     base Empty1
+command user_def_cmd0 Empty2 -> Empty2
+   gen=3DTrue success_response=3DTrue boxed=3DFalse
+enum QEnumTwo ['value1', 'value2']
+    prefix QENUM_TWO
+object UserDefOne
+    base UserDefZero
+    member string: str optional=3DFalse
+    member enum1: EnumOne optional=3DTrue
 enum EnumOne ['value1', 'value2', 'value3']
-object EventStructOne
-    member struct1: UserDefOne optional=3DFalse
+object UserDefZero
+    member integer: int optional=3DFalse
+object UserDefTwoDictDict
+    member userdef: UserDefOne optional=3DFalse
     member string: str optional=3DFalse
-    member enum2: EnumOne optional=3DTrue
+object UserDefTwoDict
+    member string1: str optional=3DFalse
+    member dict2: UserDefTwoDictDict optional=3DFalse
+    member dict3: UserDefTwoDictDict optional=3DTrue
+object UserDefTwo
+    member string0: str optional=3DFalse
+    member dict1: UserDefTwoDict optional=3DFalse
 object ForceArrays
     member unused1: UserDefOneList optional=3DFalse
     member unused2: UserDefTwoList optional=3DFalse
     member unused3: TestStructList optional=3DFalse
-enum MyEnum []
-object NestedEnumsOne
-    member enum1: EnumOne optional=3DFalse
-    member enum2: EnumOne optional=3DTrue
-    member enum3: EnumOne optional=3DFalse
-    member enum4: EnumOne optional=3DTrue
-enum QEnumTwo ['value1', 'value2']
-    prefix QENUM_TWO
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
-    prefix QTYPE
-object TestStruct
-    member integer: int optional=3DFalse
-    member boolean: bool optional=3DFalse
-    member string: str optional=3DFalse
 object UserDefA
     member boolean: bool optional=3DFalse
     member a_b: int optional=3DTrue
-alternate UserDefAlternate
-    tag type
-    case udfu: UserDefFlatUnion
-    case e: EnumOne
-    case i: int
-    case n: null
 object UserDefB
     member intb: int optional=3DFalse
     member a-b: bool optional=3DTrue
-object UserDefC
-    member string1: str optional=3DFalse
-    member string2: str optional=3DFalse
 object UserDefFlatUnion
     base UserDefUnionBase
     tag enum1
     case value1: UserDefA
     case value2: UserDefB
     case value3: UserDefB
+object UserDefUnionBase
+    base UserDefZero
+    member string: str optional=3DFalse
+    member enum1: EnumOne optional=3DFalse
+object q_obj_UserDefFlatUnion2-base
+    member integer: int optional=3DTrue
+    member string: str optional=3DFalse
+    member enum1: QEnumTwo optional=3DFalse
 object UserDefFlatUnion2
     base q_obj_UserDefFlatUnion2-base
     tag enum1
     case value1: UserDefC
     case value2: UserDefB
+object WrapAlternate
+    member alt: UserDefAlternate optional=3DFalse
+alternate UserDefAlternate
+    tag type
+    case udfu: UserDefFlatUnion
+    case e: EnumOne
+    case i: int
+    case n: null
+object UserDefC
+    member string1: str optional=3DFalse
+    member string2: str optional=3DFalse
+alternate AltEnumBool
+    tag type
+    case e: EnumOne
+    case b: bool
+alternate AltEnumNum
+    tag type
+    case e: EnumOne
+    case n: number
+alternate AltNumEnum
+    tag type
+    case n: number
+    case e: EnumOne
+alternate AltEnumInt
+    tag type
+    case e: EnumOne
+    case i: int
+alternate AltStrObj
+    tag type
+    case s: str
+    case o: TestStruct
+object q_obj_intList-wrapper
+    member data: intList optional=3DFalse
+object q_obj_int8List-wrapper
+    member data: int8List optional=3DFalse
+object q_obj_int16List-wrapper
+    member data: int16List optional=3DFalse
+object q_obj_int32List-wrapper
+    member data: int32List optional=3DFalse
+object q_obj_int64List-wrapper
+    member data: int64List optional=3DFalse
+object q_obj_uint8List-wrapper
+    member data: uint8List optional=3DFalse
+object q_obj_uint16List-wrapper
+    member data: uint16List optional=3DFalse
+object q_obj_uint32List-wrapper
+    member data: uint32List optional=3DFalse
+object q_obj_uint64List-wrapper
+    member data: uint64List optional=3DFalse
+object q_obj_numberList-wrapper
+    member data: numberList optional=3DFalse
+object q_obj_boolList-wrapper
+    member data: boolList optional=3DFalse
+object q_obj_strList-wrapper
+    member data: strList optional=3DFalse
+object q_obj_sizeList-wrapper
+    member data: sizeList optional=3DFalse
+object q_obj_anyList-wrapper
+    member data: anyList optional=3DFalse
+enum UserDefNativeListUnionKind ['integer', 's8', 's16', 's32', 's64', '=
u8', 'u16', 'u32', 'u64', 'number', 'boolean', 'string', 'sizes', 'any']
 object UserDefNativeListUnion
     member type: UserDefNativeListUnionKind optional=3DFalse
     tag type
@@ -99,133 +141,91 @@ object UserDefNativeListUnion
     case string: q_obj_strList-wrapper
     case sizes: q_obj_sizeList-wrapper
     case any: q_obj_anyList-wrapper
-enum UserDefNativeListUnionKind ['integer', 's8', 's16', 's32', 's64', '=
u8', 'u16', 'u32', 'u64', 'number', 'boolean', 'string', 'sizes', 'any']
-object UserDefOne
-    base UserDefZero
-    member string: str optional=3DFalse
-    member enum1: EnumOne optional=3DTrue
+command user_def_cmd None -> None
+   gen=3DTrue success_response=3DTrue boxed=3DFalse
+object q_obj_user_def_cmd1-arg
+    member ud1a: UserDefOne optional=3DFalse
+command user_def_cmd1 q_obj_user_def_cmd1-arg -> None
+   gen=3DTrue success_response=3DTrue boxed=3DFalse
+object q_obj_user_def_cmd2-arg
+    member ud1a: UserDefOne optional=3DFalse
+    member ud1b: UserDefOne optional=3DTrue
+command user_def_cmd2 q_obj_user_def_cmd2-arg -> UserDefTwo
+   gen=3DTrue success_response=3DTrue boxed=3DFalse
+object q_obj_guest-get-time-arg
+    member a: int optional=3DFalse
+    member b: int optional=3DTrue
+command guest-get-time q_obj_guest-get-time-arg -> int
+   gen=3DTrue success_response=3DTrue boxed=3DFalse
+object q_obj_guest-sync-arg
+    member arg: any optional=3DFalse
+command guest-sync q_obj_guest-sync-arg -> any
+   gen=3DTrue success_response=3DTrue boxed=3DFalse
+command boxed-struct UserDefZero -> None
+   gen=3DTrue success_response=3DTrue boxed=3DTrue
+command boxed-union UserDefNativeListUnion -> None
+   gen=3DTrue success_response=3DTrue boxed=3DTrue
 object UserDefOptions
     member i64: intList optional=3DTrue
     member u64: uint64List optional=3DTrue
     member u16: uint16List optional=3DTrue
     member i64x: int optional=3DTrue
     member u64x: uint64 optional=3DTrue
-object UserDefTwo
-    member string0: str optional=3DFalse
-    member dict1: UserDefTwoDict optional=3DFalse
-object UserDefTwoDict
-    member string1: str optional=3DFalse
-    member dict2: UserDefTwoDictDict optional=3DFalse
-    member dict3: UserDefTwoDictDict optional=3DTrue
-object UserDefTwoDictDict
-    member userdef: UserDefOne optional=3DFalse
+object EventStructOne
+    member struct1: UserDefOne optional=3DFalse
     member string: str optional=3DFalse
-object UserDefUnionBase
-    base UserDefZero
-    member string: str optional=3DFalse
-    member enum1: EnumOne optional=3DFalse
-object UserDefZero
-    member integer: int optional=3DFalse
-object WrapAlternate
-    member alt: UserDefAlternate optional=3DFalse
-event __ORG.QEMU_X-EVENT __org.qemu_x-Struct
+    member enum2: EnumOne optional=3DTrue
+event EVENT_A None
+   boxed=3DFalse
+event EVENT_B None
+   boxed=3DFalse
+object q_obj_EVENT_C-arg
+    member a: int optional=3DTrue
+    member b: UserDefOne optional=3DTrue
+    member c: str optional=3DFalse
+event EVENT_C q_obj_EVENT_C-arg
+   boxed=3DFalse
+object q_obj_EVENT_D-arg
+    member a: EventStructOne optional=3DFalse
+    member b: str optional=3DFalse
+    member c: str optional=3DTrue
+    member enum3: EnumOne optional=3DTrue
+event EVENT_D q_obj_EVENT_D-arg
    boxed=3DFalse
-alternate __org.qemu_x-Alt
-    tag type
-    case __org.qemu_x-branch: str
-    case b: __org.qemu_x-Base
+event EVENT_E UserDefZero
+   boxed=3DTrue
+event EVENT_F UserDefAlternate
+   boxed=3DTrue
+enum __org.qemu_x-Enum ['__org.qemu_x-value']
 object __org.qemu_x-Base
     member __org.qemu_x-member1: __org.qemu_x-Enum optional=3DFalse
-enum __org.qemu_x-Enum ['__org.qemu_x-value']
 object __org.qemu_x-Struct
     base __org.qemu_x-Base
     member __org.qemu_x-member2: str optional=3DFalse
     member wchar-t: int optional=3DTrue
-object __org.qemu_x-Struct2
-    member array: __org.qemu_x-Union1List optional=3DFalse
+object q_obj_str-wrapper
+    member data: str optional=3DFalse
+enum __org.qemu_x-Union1Kind ['__org.qemu_x-branch']
 object __org.qemu_x-Union1
     member type: __org.qemu_x-Union1Kind optional=3DFalse
     tag type
     case __org.qemu_x-branch: q_obj_str-wrapper
-enum __org.qemu_x-Union1Kind ['__org.qemu_x-branch']
+object __org.qemu_x-Struct2
+    member array: __org.qemu_x-Union1List optional=3DFalse
 object __org.qemu_x-Union2
     base __org.qemu_x-Base
     tag __org.qemu_x-member1
     case __org.qemu_x-value: __org.qemu_x-Struct2
-command __org.qemu_x-command q_obj___org.qemu_x-command-arg -> __org.qem=
u_x-Union1
-   gen=3DTrue success_response=3DTrue boxed=3DFalse
-command boxed-struct UserDefZero -> None
-   gen=3DTrue success_response=3DTrue boxed=3DTrue
-command boxed-union UserDefNativeListUnion -> None
-   gen=3DTrue success_response=3DTrue boxed=3DTrue
-command guest-get-time q_obj_guest-get-time-arg -> int
-   gen=3DTrue success_response=3DTrue boxed=3DFalse
-command guest-sync q_obj_guest-sync-arg -> any
-   gen=3DTrue success_response=3DTrue boxed=3DFalse
-object q_empty
-object q_obj_EVENT_C-arg
-    member a: int optional=3DTrue
-    member b: UserDefOne optional=3DTrue
-    member c: str optional=3DFalse
-object q_obj_EVENT_D-arg
-    member a: EventStructOne optional=3DFalse
-    member b: str optional=3DFalse
-    member c: str optional=3DTrue
-    member enum3: EnumOne optional=3DTrue
-object q_obj_UserDefFlatUnion2-base
-    member integer: int optional=3DTrue
-    member string: str optional=3DFalse
-    member enum1: QEnumTwo optional=3DFalse
+alternate __org.qemu_x-Alt
+    tag type
+    case __org.qemu_x-branch: str
+    case b: __org.qemu_x-Base
+event __ORG.QEMU_X-EVENT __org.qemu_x-Struct
+   boxed=3DFalse
 object q_obj___org.qemu_x-command-arg
     member a: __org.qemu_x-EnumList optional=3DFalse
     member b: __org.qemu_x-StructList optional=3DFalse
     member c: __org.qemu_x-Union2 optional=3DFalse
     member d: __org.qemu_x-Alt optional=3DFalse
-object q_obj_anyList-wrapper
-    member data: anyList optional=3DFalse
-object q_obj_boolList-wrapper
-    member data: boolList optional=3DFalse
-object q_obj_guest-get-time-arg
-    member a: int optional=3DFalse
-    member b: int optional=3DTrue
-object q_obj_guest-sync-arg
-    member arg: any optional=3DFalse
-object q_obj_int16List-wrapper
-    member data: int16List optional=3DFalse
-object q_obj_int32List-wrapper
-    member data: int32List optional=3DFalse
-object q_obj_int64List-wrapper
-    member data: int64List optional=3DFalse
-object q_obj_int8List-wrapper
-    member data: int8List optional=3DFalse
-object q_obj_intList-wrapper
-    member data: intList optional=3DFalse
-object q_obj_numberList-wrapper
-    member data: numberList optional=3DFalse
-object q_obj_sizeList-wrapper
-    member data: sizeList optional=3DFalse
-object q_obj_str-wrapper
-    member data: str optional=3DFalse
-object q_obj_strList-wrapper
-    member data: strList optional=3DFalse
-object q_obj_uint16List-wrapper
-    member data: uint16List optional=3DFalse
-object q_obj_uint32List-wrapper
-    member data: uint32List optional=3DFalse
-object q_obj_uint64List-wrapper
-    member data: uint64List optional=3DFalse
-object q_obj_uint8List-wrapper
-    member data: uint8List optional=3DFalse
-object q_obj_user_def_cmd1-arg
-    member ud1a: UserDefOne optional=3DFalse
-object q_obj_user_def_cmd2-arg
-    member ud1a: UserDefOne optional=3DFalse
-    member ud1b: UserDefOne optional=3DTrue
-command user_def_cmd None -> None
-   gen=3DTrue success_response=3DTrue boxed=3DFalse
-command user_def_cmd0 Empty2 -> Empty2
-   gen=3DTrue success_response=3DTrue boxed=3DFalse
-command user_def_cmd1 q_obj_user_def_cmd1-arg -> None
-   gen=3DTrue success_response=3DTrue boxed=3DFalse
-command user_def_cmd2 q_obj_user_def_cmd2-arg -> UserDefTwo
+command __org.qemu_x-command q_obj___org.qemu_x-command-arg -> __org.qem=
u_x-Union1
    gen=3DTrue success_response=3DTrue boxed=3DFalse
--=20
2.14.3
