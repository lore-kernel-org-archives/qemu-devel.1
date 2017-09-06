Received: from eggs.gnu.org ([2001:4830:134:3::10]:55142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpYdE-0007vs-UB
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:36:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpYdB-0001MY-Ls
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:36:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dpYdB-0001ML-DY
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:36:29 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-16-marcandre.lureau@redhat.com>
	<87r2vmh9vz.fsf@dusky.pond.sub.org>
	<CAJ+F1CLBorjUwHAuUA_+mOJrCdXUtLWyUVd+jppXn1mTZWZhDg@mail.gmail.com>
Date: Wed, 06 Sep 2017 13:36:26 +0200
In-Reply-To: <CAJ+F1CLBorjUwHAuUA_+mOJrCdXUtLWyUVd+jppXn1mTZWZhDg@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 5 Sep 2017
	15:58:12 +0200")
Message-ID: <87k21cawjp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 15/54] qapi: add 'if' to top-level
 expressions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Mon, Sep 4, 2017 at 3:27 PM, Markus Armbruster <armbru@redhat.com> wro=
te:
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>>> Accept 'if' key in top-level elements, accepted as string or list of
>>> string type. The following patches will modify the test visitor to
>>> check the value is correctly saved, and generate #if/#endif code (as a
>>> single #if/endif line or a series for a list).
>>>
>>> Example of 'if' key:
>>> { 'struct': 'TestIfStruct', 'data': { 'foo': 'int' },                  =
                                                                           =
                                                                  'if': 'de=
fined(TEST_IF_STRUCT)' }
>>
>> Lost line break?
>
> yes
>
>>
>>> A following patch for qapi-code-gen.txt will provide more complete
>>> documentation for 'if' usage.
>>>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
[...]
>>> diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema=
/qapi-schema-test.out
>>> index 3b1e9082d3..7fbaea19bc 100644
>>> --- a/tests/qapi-schema/qapi-schema-test.out
>>> +++ b/tests/qapi-schema/qapi-schema-test.out
>>> @@ -52,6 +52,22 @@ enum QEnumTwo ['value1', 'value2']
>>>      prefix QENUM_TWO
>>>  enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbo=
ol']
>>>      prefix QTYPE
>>> +alternate TestIfAlternate
>>> +    tag type
>>> +    case foo: int
>>> +    case bar: TestStruct
>>> +command TestIfCmd q_obj_TestIfCmd-arg -> None
>>> +   gen=3DTrue success_response=3DTrue boxed=3DFalse
>>> +enum TestIfEnum ['foo', 'bar']
>>> +event TestIfEvent q_obj_TestIfEvent-arg
>>> +   boxed=3DFalse
>>> +object TestIfStruct
>>> +    member foo: int optional=3DFalse
>>> +object TestIfUnion
>>> +    member type: TestIfUnionKind optional=3DFalse
>>> +    tag type
>>> +    case foo: q_obj_TestStruct-wrapper
>>> +enum TestIfUnionKind ['foo']
>>>  object TestStruct
>>>      member integer: int optional=3DFalse
>>>      member boolean: bool optional=3DFalse
>>> @@ -172,6 +188,12 @@ object q_obj_EVENT_D-arg
>>>      member b: str optional=3DFalse
>>>      member c: str optional=3DTrue
>>>      member enum3: EnumOne optional=3DTrue
>>> +object q_obj_TestIfCmd-arg
>>> +    member foo: TestIfStruct optional=3DFalse
>>> +object q_obj_TestIfEvent-arg
>>> +    member foo: TestIfStruct optional=3DFalse
>>> +object q_obj_TestStruct-wrapper
>>> +    member data: TestStruct optional=3DFalse
>>>  object q_obj_UserDefFlatUnion2-base
>>>      member integer: int optional=3DTrue
>>>      member string: str optional=3DFalse
>>
>> The conditionals aren't visible in qapi-schema-test.out.  They should
>> be.
>>
>
> That's a follow-up patch "qapi: add 'ifcond' to visitor methods"

Which I've since found %-}

Similarly, the generated code is for now *unconditional*.  Later patches
generate the conditionals.

Let's point this out in the commit message.

Remember, your poor, ignorant reviewer squints at your patches through a
toiler paper tube, and may need your help to see the bigger picture.

>> *Much* easier to review than its predecessor PATCH 07/26.  Appreciated!
