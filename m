Received: from eggs.gnu.org ([2001:4830:134:3::10]:43242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ffPoo-0005St-3D
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:15:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ffPok-0002kR-T9
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:15:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51204 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ffPok-0002ik-N9
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:15:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5807D402312B
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 13:15:02 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180706121354.2021-1-marcandre.lureau@redhat.com>
	<20180706121354.2021-10-marcandre.lureau@redhat.com>
	<87zhyqe1e4.fsf@dusky.pond.sub.org>
	<CAMxuvaxL_W0_fZSfYzL9L5aGCEymcKAYSig7u84K-dzm2agPGQ@mail.gmail.com>
Date: Tue, 17 Jul 2018 15:15:00 +0200
In-Reply-To: <CAMxuvaxL_W0_fZSfYzL9L5aGCEymcKAYSig7u84K-dzm2agPGQ@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 17 Jul 2018
	11:57:32 +0200")
Message-ID: <87zhyqc8bv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 09/12] tests: add a few qemu-qmp tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi
>
> On Tue, Jul 17, 2018 at 10:01 AM, Markus Armbruster <armbru@redhat.com> w=
rote:
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>>> These 2 tests exhibited two qmp bugs that were fixed in 2.7
>>> (series from commit e64c75a9752c5d0fd64eb2e684c656a5ea7d03c6 to
>>> commit 1382d4abdf9619985e4078e37e49e487cea9935e)
>>>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>  tests/qmp-test.c | 38 ++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 38 insertions(+)
>>>
>>> diff --git a/tests/qmp-test.c b/tests/qmp-test.c
>>> index ceaf4a6789..084c5edff0 100644
>>> --- a/tests/qmp-test.c
>>> +++ b/tests/qmp-test.c
>>> @@ -249,7 +249,39 @@ static void test_qmp_oob(void)
>>>      recv_cmd_id(qts, "blocks-2");
>>>      recv_cmd_id(qts, "err-2");
>>>      cleanup_blocking_cmd();
>>> +}
>>> +
>>> +static void test_object_add_without_props(void)
>>> +{
>>> +    QTestState *qts;
>>> +    QDict *ret;
>>> +
>>> +    qts =3D qtest_init(common_args);
>>> +
>>> +    ret =3D qtest_qmp(qts, "{'execute': 'object-add',"
>>> +          " 'arguments': { 'qom-type': 'memory-backend-ram', 'id': 'ra=
m1' } }");
>>
>> Please break lines between arguments instead of within.  More of the
>> same below.
>
> Sorry I am not sure I understand what you want. It's broken between
> argument "execute" and "arguments", how do you want to change it?

The line is broken in the middle of the second argument to qtest_qmp().

Line breaks I'd like better:

    ret =3D qtest_qmp(qts,
                    "{'execute': 'object-add',"
                    " 'arguments': {'qom-type': 'memory-backend-ram',
                    "               'id': 'ram1'}}");

    ret =3D qtest_qmp(qts,
                    "{'execute': 'object-add',"
                    " 'arguments': {"
                    "    'qom-type': 'memory-backend-ram', 'id': 'ram1'}}");

    ret =3D qtest_qmp(qts,
                    "{'execute': 'object-add', 'arguments':"
                    " {'qom-type': 'memory-backend-ram', 'id': 'ram1'}}");

>>> +    g_assert_nonnull(ret);
>>> +
>>> +    g_assert_cmpstr(get_error_class(ret), =3D=3D, "GenericError");
>>> +
>>> +    qobject_unref(ret);
>>> +    qtest_quit(qts);
>>> +}
>>> +
>>> +static void test_qom_set_without_value(void)
>>> +{
>>> +    QTestState *qts;
>>> +    QDict *ret;
>>> +
>>> +    qts =3D qtest_init(common_args);
>>>
>>> +    ret =3D qtest_qmp(qts, "{'execute': 'qom-set',"
>>> +              " 'arguments': { 'path': '/machine', 'property': 'rtc-ti=
me' } }");
>>> +    g_assert_nonnull(ret);
>>> +
>>> +    g_assert_cmpstr(get_error_class(ret), =3D=3D, "GenericError");
>>> +
>>> +    qobject_unref(ret);
>>>      qtest_quit(qts);
>>>  }
>>>
>>> @@ -479,8 +511,13 @@ int main(int argc, char *argv[])
>>>
>>>      g_test_init(&argc, &argv, NULL);
>>>
>>> +    qtest_add_func("qmp/object-add-without-props",
>>> +                   test_object_add_without_props);
>>> +    qtest_add_func("qmp/qom-set-without-value",
>>> +                   test_qom_set_without_value);
>>>      qtest_add_func("qmp/protocol", test_qmp_protocol);
>>>      qtest_add_func("qmp/oob", test_qmp_oob);
>>> +
>>>      qmp_schema_init(&schema);
>>>      add_query_tests(&schema);
>>>      qtest_add_func("qmp/preconfig", test_qmp_preconfig);
>>> @@ -488,5 +525,6 @@ int main(int argc, char *argv[])
>>>      ret =3D g_test_run();
>>>
>>>      qmp_schema_cleanup(&schema);
>>> +
>>>      return ret;
>>>  }
>>
>> Is this hunk intentional?
>>
>
> no

Easy enough to drop :)

>> Taking a step back: the test cases look good, but is this file an
>> appropriate home?  The file comment states it's about "QMP protocol test
>> cases".  These test cases test commands, not the protocol.
>
> Actually, the tests were written to test the qapi/qmp fixes mentionned
> in commit message. So they were more "protocol" related than command
> related.

Let's see...

1. test_object_add_without_props() tests the bug fixed in commit
   e64c75a975 "qmp: fix object-add assert() without props"

   object-add's parameter @props is optional, qmp_object_add() fails to
   default it to {}, which user_creatable_add_type() requires.  This is
   a bug in the command handler.  It went unnoticed because object-add
   lacks systematic tests.  You add one test case, which is welcome, but
   what we really want is at systematic coverage of all paths through
   qmp_object_add().

   Aside: we want that for every QMP command.  We have it for next to
   none of them.

   Anyway, neither the bug nor its test are about the QMP protocol.

2. test_qom_set_without_value() tests the bug fixed in commit c489780203
   "qapi: Fix crash when 'any' or 'null' parameter is missing"

   The QMP input visitor neglects to check qmp_input_get_object() for
   failure.  The bug is *not* in qom-set; qom-set is merely part of the
   reproducer.  You're right, this case is 'more "protocol" related than
   command related.'

   We do have tests for the QMP input visitor.  You fixed them to cover
   this case in the very next commit bce3035a44
   "tests/test-qmp-input-strict: Cover missing struct members".  That's
   a unit test.

   Should we test it once more at the QMP level in a qtest?  If yes,
   then we should test all the errors the visitor should report once
   there, shouldn't we?  Mind, I'm not saying *you* should.

>>
>> I figure test_qom_set_without_value() belongs to qom-test.c.
>>
>> test_object_add_without_props() could go into a memory backend test
>> collection, or an object-add test collection.  Sadly, neither exists.
>> We could have a qmp command test collection as a home of last resort.
>> Temptation to just throw a few random test cases there instead of
>> covering (a set of related) commands with a proper test case collection.
>>
>> As is, your patch turns qmp-test.c into such a home of last resort.  If
>> that's what we want, we should update the file comment.  But I think I'd
>> rather have a separate qmp-cmd-test.c.
>>
>> Thoughts?
>
> It's somewhat blurry lines to me, it would be simpler to just use qmp-tes=
t.

Simpler, yes, but creating a new file isn't really hard, either.

In current master, qmp-test.c has just under 500 lines.  It's already
one of the larger files in tests/.  Certainly not too big, but I'd
prefer to keep it focused.

I defocused it some myself when I added the query smoke tests (commit
e4a426e75e tests/qmp-test: Add generic, basic test of query commands).
It was simpler to just use qmp-test.  I shouldn't have.

I'll prepare a patch to split qmp-test.c into a command-independent part
(protocol, infrastructure) and a part about commands.
