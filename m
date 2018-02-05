Received: from eggs.gnu.org ([2001:4830:134:3::10]:52505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eih5d-0000y2-5K
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:45:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eih5V-0003WB-HQ
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:45:45 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:37953)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eih5V-0003Vu-4T
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:45:37 -0500
Received: by mail-qk0-f170.google.com with SMTP id w128so10196238qkb.5
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 05:45:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180202130336.24719-15-armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-15-armbru@redhat.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Mon, 5 Feb 2018 14:45:35 +0100
Message-ID: <CAMxuvayFe8fU5PMyX00k2tM=2-=ZQqsxd1PwMUxAFAx26chFRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH RFC 14/21] qapi: Generate in source order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, marcandre <marcandre.lureau@redhat.com>, "Blake, Eric" <eblake@redhat.com>, mdroth@linux.vnet.ibm.com

On Fri, Feb 2, 2018 at 2:03 PM, Markus Armbruster <armbru@redhat.com> wrote:
> The generators' conversion to visitors (merge commit 9e72681d16)
> changed the processing order of entities from source order to
> alphabetical order.  The next commit needs source order, so change it
> back.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi/common.py                   |   4 +-
>  tests/qapi-schema/comments.out           |   2 +-
>  tests/qapi-schema/doc-bad-section.out    |   4 +-
>  tests/qapi-schema/doc-good.out           |  32 ++--
>  tests/qapi-schema/empty.out              |   2 +-
>  tests/qapi-schema/event-case.out         |   2 +-
>  tests/qapi-schema/ident-with-escape.out  |   6 +-
>  tests/qapi-schema/include-relpath.out    |   2 +-
>  tests/qapi-schema/include-repetition.out |   2 +-
>  tests/qapi-schema/include-simple.out     |   2 +-
>  tests/qapi-schema/indented-expr.out      |   2 +-
>  tests/qapi-schema/qapi-schema-test.out   | 320 +++++++++++++++----------------
>  12 files changed, 191 insertions(+), 189 deletions(-)
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index d5b93e7381..3b97bf8702 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -1471,6 +1471,7 @@ class QAPISchema(object):
>          parser = QAPISchemaParser(open(fname, 'r'))
>          exprs = check_exprs(parser.exprs)
>          self.docs = parser.docs
> +        self._entity_list = []
>          self._entity_dict = {}
>          self._predefining = True
>          self._def_predefineds()
> @@ -1482,6 +1483,7 @@ class QAPISchema(object):
>          # Only the predefined types are allowed to not have info
>          assert ent.info or self._predefining
>          assert ent.name not in self._entity_dict
> +        self._entity_list.append(ent)
>          self._entity_dict[ent.name] = ent

Why not use the OrderedDict instead?

>
>      def lookup_entity(self, name, typ=None):
> @@ -1685,7 +1687,7 @@ class QAPISchema(object):
>
>      def visit(self, visitor):
>          visitor.visit_begin(self)
> -        for (name, entity) in sorted(self._entity_dict.items()):
> +        for entity in self._entity_list:
>              if visitor.visit_needed(entity):
>                  entity.visit(visitor)
>          visitor.visit_end()
> diff --git a/tests/qapi-schema/comments.out b/tests/qapi-schema/comments.out
> index 17e652535c..0261ddf202 100644
> --- a/tests/qapi-schema/comments.out
> +++ b/tests/qapi-schema/comments.out
> @@ -1,4 +1,4 @@
> +object q_empty
>  enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
>      prefix QTYPE
>  enum Status ['good', 'bad', 'ugly']
> -object q_empty
> diff --git a/tests/qapi-schema/doc-bad-section.out b/tests/qapi-schema/doc-bad-section.out
> index 089bde1381..23bf8c71ab 100644
> --- a/tests/qapi-schema/doc-bad-section.out
> +++ b/tests/qapi-schema/doc-bad-section.out
> @@ -1,7 +1,7 @@
> -enum Enum ['one', 'two']
> +object q_empty
>  enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
>      prefix QTYPE
> -object q_empty
> +enum Enum ['one', 'two']
>  doc symbol=Enum
>      body=
>  == Produces *invalid* texinfo
> diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
> index 1d2c250527..0c07301f07 100644
> --- a/tests/qapi-schema/doc-good.out
> +++ b/tests/qapi-schema/doc-good.out
> @@ -1,35 +1,35 @@
> +object q_empty
> +enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
> +    prefix QTYPE
> +enum Enum ['one', 'two']
>  object Base
>      member base1: Enum optional=False
> -enum Enum ['one', 'two']
> +object Variant1
> +    member var1: str optional=False
> +object Variant2
>  object Object
>      base Base
>      tag base1
>      case one: Variant1
>      case two: Variant2
> -enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
> -    prefix QTYPE
> +object q_obj_Variant1-wrapper
> +    member data: Variant1 optional=False
> +object q_obj_Variant2-wrapper
> +    member data: Variant2 optional=False
> +enum SugaredUnionKind ['one', 'two']
>  object SugaredUnion
>      member type: SugaredUnionKind optional=False
>      tag type
>      case one: q_obj_Variant1-wrapper
>      case two: q_obj_Variant2-wrapper
> -enum SugaredUnionKind ['one', 'two']
> -object Variant1
> -    member var1: str optional=False
> -object Variant2
> -command cmd q_obj_cmd-arg -> Object
> -   gen=True success_response=True boxed=False
> -command cmd-boxed Object -> None
> -   gen=True success_response=True boxed=True
> -object q_empty
> -object q_obj_Variant1-wrapper
> -    member data: Variant1 optional=False
> -object q_obj_Variant2-wrapper
> -    member data: Variant2 optional=False
>  object q_obj_cmd-arg
>      member arg1: int optional=False
>      member arg2: str optional=True
>      member arg3: bool optional=False
> +command cmd q_obj_cmd-arg -> Object
> +   gen=True success_response=True boxed=False
> +command cmd-boxed Object -> None
> +   gen=True success_response=True boxed=True
>  doc freeform
>      body=
>  = Section
> diff --git a/tests/qapi-schema/empty.out b/tests/qapi-schema/empty.out
> index 40b886ddae..0ec234eec4 100644
> --- a/tests/qapi-schema/empty.out
> +++ b/tests/qapi-schema/empty.out
> @@ -1,3 +1,3 @@
> +object q_empty
>  enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
>      prefix QTYPE
> -object q_empty
> diff --git a/tests/qapi-schema/event-case.out b/tests/qapi-schema/event-case.out
> index 313c0fe7be..110571b793 100644
> --- a/tests/qapi-schema/event-case.out
> +++ b/tests/qapi-schema/event-case.out
> @@ -1,5 +1,5 @@
> +object q_empty
>  enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
>      prefix QTYPE
>  event oops None
>     boxed=False
> -object q_empty
> diff --git a/tests/qapi-schema/ident-with-escape.out b/tests/qapi-schema/ident-with-escape.out
> index b5637cb2e0..8336aa7629 100644
> --- a/tests/qapi-schema/ident-with-escape.out
> +++ b/tests/qapi-schema/ident-with-escape.out
> @@ -1,7 +1,7 @@
> +object q_empty
>  enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
>      prefix QTYPE
> -command fooA q_obj_fooA-arg -> None
> -   gen=True success_response=True boxed=False
> -object q_empty
>  object q_obj_fooA-arg
>      member bar1: str optional=False
> +command fooA q_obj_fooA-arg -> None
> +   gen=True success_response=True boxed=False
> diff --git a/tests/qapi-schema/include-relpath.out b/tests/qapi-schema/include-relpath.out
> index 17e652535c..0261ddf202 100644
> --- a/tests/qapi-schema/include-relpath.out
> +++ b/tests/qapi-schema/include-relpath.out
> @@ -1,4 +1,4 @@
> +object q_empty
>  enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
>      prefix QTYPE
>  enum Status ['good', 'bad', 'ugly']
> -object q_empty
> diff --git a/tests/qapi-schema/include-repetition.out b/tests/qapi-schema/include-repetition.out
> index 17e652535c..0261ddf202 100644
> --- a/tests/qapi-schema/include-repetition.out
> +++ b/tests/qapi-schema/include-repetition.out
> @@ -1,4 +1,4 @@
> +object q_empty
>  enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
>      prefix QTYPE
>  enum Status ['good', 'bad', 'ugly']
> -object q_empty
> diff --git a/tests/qapi-schema/include-simple.out b/tests/qapi-schema/include-simple.out
> index 17e652535c..0261ddf202 100644
> --- a/tests/qapi-schema/include-simple.out
> +++ b/tests/qapi-schema/include-simple.out
> @@ -1,4 +1,4 @@
> +object q_empty
>  enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
>      prefix QTYPE
>  enum Status ['good', 'bad', 'ugly']
> -object q_empty
> diff --git a/tests/qapi-schema/indented-expr.out b/tests/qapi-schema/indented-expr.out
> index 586795f44d..34de8be426 100644
> --- a/tests/qapi-schema/indented-expr.out
> +++ b/tests/qapi-schema/indented-expr.out
> @@ -1,7 +1,7 @@
> +object q_empty
>  enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
>      prefix QTYPE
>  command eins None -> None
>     gen=True success_response=True boxed=False
> -object q_empty
>  command zwei None -> None
>     gen=True success_response=True boxed=False
> diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
> index 3b1e9082d3..50706b0136 100644
> --- a/tests/qapi-schema/qapi-schema-test.out
> +++ b/tests/qapi-schema/qapi-schema-test.out
> @@ -1,87 +1,129 @@
> -alternate AltEnumBool
> -    tag type
> -    case e: EnumOne
> -    case b: bool
> -alternate AltEnumInt
> -    tag type
> -    case e: EnumOne
> -    case i: int
> -alternate AltEnumNum
> -    tag type
> -    case e: EnumOne
> -    case n: number
> -alternate AltNumEnum
> -    tag type
> -    case n: number
> -    case e: EnumOne
> -alternate AltStrObj
> -    tag type
> -    case s: str
> -    case o: TestStruct
> -event EVENT_A None
> -   boxed=False
> -event EVENT_B None
> -   boxed=False
> -event EVENT_C q_obj_EVENT_C-arg
> -   boxed=False
> -event EVENT_D q_obj_EVENT_D-arg
> -   boxed=False
> -event EVENT_E UserDefZero
> -   boxed=True
> -event EVENT_F UserDefAlternate
> -   boxed=True
> +object q_empty
> +enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
> +    prefix QTYPE
> +object TestStruct
> +    member integer: int optional=False
> +    member boolean: bool optional=False
> +    member string: str optional=False
> +object NestedEnumsOne
> +    member enum1: EnumOne optional=False
> +    member enum2: EnumOne optional=True
> +    member enum3: EnumOne optional=False
> +    member enum4: EnumOne optional=True
> +enum MyEnum []
>  object Empty1
>  object Empty2
>      base Empty1
> +command user_def_cmd0 Empty2 -> Empty2
> +   gen=True success_response=True boxed=False
> +enum QEnumTwo ['value1', 'value2']
> +    prefix QENUM_TWO
> +object UserDefOne
> +    base UserDefZero
> +    member string: str optional=False
> +    member enum1: EnumOne optional=True
>  enum EnumOne ['value1', 'value2', 'value3']
> -object EventStructOne
> -    member struct1: UserDefOne optional=False
> +object UserDefZero
> +    member integer: int optional=False
> +object UserDefTwoDictDict
> +    member userdef: UserDefOne optional=False
>      member string: str optional=False
> -    member enum2: EnumOne optional=True
> +object UserDefTwoDict
> +    member string1: str optional=False
> +    member dict2: UserDefTwoDictDict optional=False
> +    member dict3: UserDefTwoDictDict optional=True
> +object UserDefTwo
> +    member string0: str optional=False
> +    member dict1: UserDefTwoDict optional=False
>  object ForceArrays
>      member unused1: UserDefOneList optional=False
>      member unused2: UserDefTwoList optional=False
>      member unused3: TestStructList optional=False
> -enum MyEnum []
> -object NestedEnumsOne
> -    member enum1: EnumOne optional=False
> -    member enum2: EnumOne optional=True
> -    member enum3: EnumOne optional=False
> -    member enum4: EnumOne optional=True
> -enum QEnumTwo ['value1', 'value2']
> -    prefix QENUM_TWO
> -enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
> -    prefix QTYPE
> -object TestStruct
> -    member integer: int optional=False
> -    member boolean: bool optional=False
> -    member string: str optional=False
>  object UserDefA
>      member boolean: bool optional=False
>      member a_b: int optional=True
> -alternate UserDefAlternate
> -    tag type
> -    case udfu: UserDefFlatUnion
> -    case e: EnumOne
> -    case i: int
> -    case n: null
>  object UserDefB
>      member intb: int optional=False
>      member a-b: bool optional=True
> -object UserDefC
> -    member string1: str optional=False
> -    member string2: str optional=False
>  object UserDefFlatUnion
>      base UserDefUnionBase
>      tag enum1
>      case value1: UserDefA
>      case value2: UserDefB
>      case value3: UserDefB
> +object UserDefUnionBase
> +    base UserDefZero
> +    member string: str optional=False
> +    member enum1: EnumOne optional=False
> +object q_obj_UserDefFlatUnion2-base
> +    member integer: int optional=True
> +    member string: str optional=False
> +    member enum1: QEnumTwo optional=False
>  object UserDefFlatUnion2
>      base q_obj_UserDefFlatUnion2-base
>      tag enum1
>      case value1: UserDefC
>      case value2: UserDefB
> +object WrapAlternate
> +    member alt: UserDefAlternate optional=False
> +alternate UserDefAlternate
> +    tag type
> +    case udfu: UserDefFlatUnion
> +    case e: EnumOne
> +    case i: int
> +    case n: null
> +object UserDefC
> +    member string1: str optional=False
> +    member string2: str optional=False
> +alternate AltEnumBool
> +    tag type
> +    case e: EnumOne
> +    case b: bool
> +alternate AltEnumNum
> +    tag type
> +    case e: EnumOne
> +    case n: number
> +alternate AltNumEnum
> +    tag type
> +    case n: number
> +    case e: EnumOne
> +alternate AltEnumInt
> +    tag type
> +    case e: EnumOne
> +    case i: int
> +alternate AltStrObj
> +    tag type
> +    case s: str
> +    case o: TestStruct
> +object q_obj_intList-wrapper
> +    member data: intList optional=False
> +object q_obj_int8List-wrapper
> +    member data: int8List optional=False
> +object q_obj_int16List-wrapper
> +    member data: int16List optional=False
> +object q_obj_int32List-wrapper
> +    member data: int32List optional=False
> +object q_obj_int64List-wrapper
> +    member data: int64List optional=False
> +object q_obj_uint8List-wrapper
> +    member data: uint8List optional=False
> +object q_obj_uint16List-wrapper
> +    member data: uint16List optional=False
> +object q_obj_uint32List-wrapper
> +    member data: uint32List optional=False
> +object q_obj_uint64List-wrapper
> +    member data: uint64List optional=False
> +object q_obj_numberList-wrapper
> +    member data: numberList optional=False
> +object q_obj_boolList-wrapper
> +    member data: boolList optional=False
> +object q_obj_strList-wrapper
> +    member data: strList optional=False
> +object q_obj_sizeList-wrapper
> +    member data: sizeList optional=False
> +object q_obj_anyList-wrapper
> +    member data: anyList optional=False
> +enum UserDefNativeListUnionKind ['integer', 's8', 's16', 's32', 's64', 'u8', 'u16', 'u32', 'u64', 'number', 'boolean', 'string', 'sizes', 'any']
>  object UserDefNativeListUnion
>      member type: UserDefNativeListUnionKind optional=False
>      tag type
> @@ -99,133 +141,91 @@ object UserDefNativeListUnion
>      case string: q_obj_strList-wrapper
>      case sizes: q_obj_sizeList-wrapper
>      case any: q_obj_anyList-wrapper
> -enum UserDefNativeListUnionKind ['integer', 's8', 's16', 's32', 's64', 'u8', 'u16', 'u32', 'u64', 'number', 'boolean', 'string', 'sizes', 'any']
> -object UserDefOne
> -    base UserDefZero
> -    member string: str optional=False
> -    member enum1: EnumOne optional=True
> +command user_def_cmd None -> None
> +   gen=True success_response=True boxed=False
> +object q_obj_user_def_cmd1-arg
> +    member ud1a: UserDefOne optional=False
> +command user_def_cmd1 q_obj_user_def_cmd1-arg -> None
> +   gen=True success_response=True boxed=False
> +object q_obj_user_def_cmd2-arg
> +    member ud1a: UserDefOne optional=False
> +    member ud1b: UserDefOne optional=True
> +command user_def_cmd2 q_obj_user_def_cmd2-arg -> UserDefTwo
> +   gen=True success_response=True boxed=False
> +object q_obj_guest-get-time-arg
> +    member a: int optional=False
> +    member b: int optional=True
> +command guest-get-time q_obj_guest-get-time-arg -> int
> +   gen=True success_response=True boxed=False
> +object q_obj_guest-sync-arg
> +    member arg: any optional=False
> +command guest-sync q_obj_guest-sync-arg -> any
> +   gen=True success_response=True boxed=False
> +command boxed-struct UserDefZero -> None
> +   gen=True success_response=True boxed=True
> +command boxed-union UserDefNativeListUnion -> None
> +   gen=True success_response=True boxed=True
>  object UserDefOptions
>      member i64: intList optional=True
>      member u64: uint64List optional=True
>      member u16: uint16List optional=True
>      member i64x: int optional=True
>      member u64x: uint64 optional=True
> -object UserDefTwo
> -    member string0: str optional=False
> -    member dict1: UserDefTwoDict optional=False
> -object UserDefTwoDict
> -    member string1: str optional=False
> -    member dict2: UserDefTwoDictDict optional=False
> -    member dict3: UserDefTwoDictDict optional=True
> -object UserDefTwoDictDict
> -    member userdef: UserDefOne optional=False
> +object EventStructOne
> +    member struct1: UserDefOne optional=False
>      member string: str optional=False
> -object UserDefUnionBase
> -    base UserDefZero
> -    member string: str optional=False
> -    member enum1: EnumOne optional=False
> -object UserDefZero
> -    member integer: int optional=False
> -object WrapAlternate
> -    member alt: UserDefAlternate optional=False
> -event __ORG.QEMU_X-EVENT __org.qemu_x-Struct
> +    member enum2: EnumOne optional=True
> +event EVENT_A None
> +   boxed=False
> +event EVENT_B None
> +   boxed=False
> +object q_obj_EVENT_C-arg
> +    member a: int optional=True
> +    member b: UserDefOne optional=True
> +    member c: str optional=False
> +event EVENT_C q_obj_EVENT_C-arg
> +   boxed=False
> +object q_obj_EVENT_D-arg
> +    member a: EventStructOne optional=False
> +    member b: str optional=False
> +    member c: str optional=True
> +    member enum3: EnumOne optional=True
> +event EVENT_D q_obj_EVENT_D-arg
>     boxed=False
> -alternate __org.qemu_x-Alt
> -    tag type
> -    case __org.qemu_x-branch: str
> -    case b: __org.qemu_x-Base
> +event EVENT_E UserDefZero
> +   boxed=True
> +event EVENT_F UserDefAlternate
> +   boxed=True
> +enum __org.qemu_x-Enum ['__org.qemu_x-value']
>  object __org.qemu_x-Base
>      member __org.qemu_x-member1: __org.qemu_x-Enum optional=False
> -enum __org.qemu_x-Enum ['__org.qemu_x-value']
>  object __org.qemu_x-Struct
>      base __org.qemu_x-Base
>      member __org.qemu_x-member2: str optional=False
>      member wchar-t: int optional=True
> -object __org.qemu_x-Struct2
> -    member array: __org.qemu_x-Union1List optional=False
> +object q_obj_str-wrapper
> +    member data: str optional=False
> +enum __org.qemu_x-Union1Kind ['__org.qemu_x-branch']
>  object __org.qemu_x-Union1
>      member type: __org.qemu_x-Union1Kind optional=False
>      tag type
>      case __org.qemu_x-branch: q_obj_str-wrapper
> -enum __org.qemu_x-Union1Kind ['__org.qemu_x-branch']
> +object __org.qemu_x-Struct2
> +    member array: __org.qemu_x-Union1List optional=False
>  object __org.qemu_x-Union2
>      base __org.qemu_x-Base
>      tag __org.qemu_x-member1
>      case __org.qemu_x-value: __org.qemu_x-Struct2
> -command __org.qemu_x-command q_obj___org.qemu_x-command-arg -> __org.qemu_x-Union1
> -   gen=True success_response=True boxed=False
> -command boxed-struct UserDefZero -> None
> -   gen=True success_response=True boxed=True
> -command boxed-union UserDefNativeListUnion -> None
> -   gen=True success_response=True boxed=True
> -command guest-get-time q_obj_guest-get-time-arg -> int
> -   gen=True success_response=True boxed=False
> -command guest-sync q_obj_guest-sync-arg -> any
> -   gen=True success_response=True boxed=False
> -object q_empty
> -object q_obj_EVENT_C-arg
> -    member a: int optional=True
> -    member b: UserDefOne optional=True
> -    member c: str optional=False
> -object q_obj_EVENT_D-arg
> -    member a: EventStructOne optional=False
> -    member b: str optional=False
> -    member c: str optional=True
> -    member enum3: EnumOne optional=True
> -object q_obj_UserDefFlatUnion2-base
> -    member integer: int optional=True
> -    member string: str optional=False
> -    member enum1: QEnumTwo optional=False
> +alternate __org.qemu_x-Alt
> +    tag type
> +    case __org.qemu_x-branch: str
> +    case b: __org.qemu_x-Base
> +event __ORG.QEMU_X-EVENT __org.qemu_x-Struct
> +   boxed=False
>  object q_obj___org.qemu_x-command-arg
>      member a: __org.qemu_x-EnumList optional=False
>      member b: __org.qemu_x-StructList optional=False
>      member c: __org.qemu_x-Union2 optional=False
>      member d: __org.qemu_x-Alt optional=False
> -object q_obj_anyList-wrapper
> -    member data: anyList optional=False
> -object q_obj_boolList-wrapper
> -    member data: boolList optional=False
> -object q_obj_guest-get-time-arg
> -    member a: int optional=False
> -    member b: int optional=True
> -object q_obj_guest-sync-arg
> -    member arg: any optional=False
> -object q_obj_int16List-wrapper
> -    member data: int16List optional=False
> -object q_obj_int32List-wrapper
> -    member data: int32List optional=False
> -object q_obj_int64List-wrapper
> -    member data: int64List optional=False
> -object q_obj_int8List-wrapper
> -    member data: int8List optional=False
> -object q_obj_intList-wrapper
> -    member data: intList optional=False
> -object q_obj_numberList-wrapper
> -    member data: numberList optional=False
> -object q_obj_sizeList-wrapper
> -    member data: sizeList optional=False
> -object q_obj_str-wrapper
> -    member data: str optional=False
> -object q_obj_strList-wrapper
> -    member data: strList optional=False
> -object q_obj_uint16List-wrapper
> -    member data: uint16List optional=False
> -object q_obj_uint32List-wrapper
> -    member data: uint32List optional=False
> -object q_obj_uint64List-wrapper
> -    member data: uint64List optional=False
> -object q_obj_uint8List-wrapper
> -    member data: uint8List optional=False
> -object q_obj_user_def_cmd1-arg
> -    member ud1a: UserDefOne optional=False
> -object q_obj_user_def_cmd2-arg
> -    member ud1a: UserDefOne optional=False
> -    member ud1b: UserDefOne optional=True
> -command user_def_cmd None -> None
> -   gen=True success_response=True boxed=False
> -command user_def_cmd0 Empty2 -> Empty2
> -   gen=True success_response=True boxed=False
> -command user_def_cmd1 q_obj_user_def_cmd1-arg -> None
> -   gen=True success_response=True boxed=False
> -command user_def_cmd2 q_obj_user_def_cmd2-arg -> UserDefTwo
> +command __org.qemu_x-command q_obj___org.qemu_x-command-arg -> __org.qemu_x-Union1
>     gen=True success_response=True boxed=False
> --
> 2.13.6
>
