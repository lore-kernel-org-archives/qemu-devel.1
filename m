Received: from eggs.gnu.org ([2001:4830:134:3::10]:54491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ffMjj-0000DC-O9
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 05:57:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ffMje-0007ZO-Tn
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 05:57:39 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33503)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1ffMje-0007Z0-Nk
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 05:57:34 -0400
Received: by mail-it0-f65.google.com with SMTP id y124-v6so14109829itc.0
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 02:57:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87zhyqe1e4.fsf@dusky.pond.sub.org>
References: <20180706121354.2021-1-marcandre.lureau@redhat.com>
	<20180706121354.2021-10-marcandre.lureau@redhat.com>
	<87zhyqe1e4.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Jul 2018 11:57:32 +0200
Message-ID: <CAMxuvaxL_W0_fZSfYzL9L5aGCEymcKAYSig7u84K-dzm2agPGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>

Hi

On Tue, Jul 17, 2018 at 10:01 AM, Markus Armbruster <armbru@redhat.com> wro=
te:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> These 2 tests exhibited two qmp bugs that were fixed in 2.7
>> (series from commit e64c75a9752c5d0fd64eb2e684c656a5ea7d03c6 to
>> commit 1382d4abdf9619985e4078e37e49e487cea9935e)
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  tests/qmp-test.c | 38 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>>
>> diff --git a/tests/qmp-test.c b/tests/qmp-test.c
>> index ceaf4a6789..084c5edff0 100644
>> --- a/tests/qmp-test.c
>> +++ b/tests/qmp-test.c
>> @@ -249,7 +249,39 @@ static void test_qmp_oob(void)
>>      recv_cmd_id(qts, "blocks-2");
>>      recv_cmd_id(qts, "err-2");
>>      cleanup_blocking_cmd();
>> +}
>> +
>> +static void test_object_add_without_props(void)
>> +{
>> +    QTestState *qts;
>> +    QDict *ret;
>> +
>> +    qts =3D qtest_init(common_args);
>> +
>> +    ret =3D qtest_qmp(qts, "{'execute': 'object-add',"
>> +          " 'arguments': { 'qom-type': 'memory-backend-ram', 'id': 'ram=
1' } }");
>
> Please break lines between arguments instead of within.  More of the
> same below.

Sorry I am not sure I understand what you want. It's broken between
argument "execute" and "arguments", how do you want to change it?

>
>> +    g_assert_nonnull(ret);
>> +
>> +    g_assert_cmpstr(get_error_class(ret), =3D=3D, "GenericError");
>> +
>> +    qobject_unref(ret);
>> +    qtest_quit(qts);
>> +}
>> +
>> +static void test_qom_set_without_value(void)
>> +{
>> +    QTestState *qts;
>> +    QDict *ret;
>> +
>> +    qts =3D qtest_init(common_args);
>>
>> +    ret =3D qtest_qmp(qts, "{'execute': 'qom-set',"
>> +              " 'arguments': { 'path': '/machine', 'property': 'rtc-tim=
e' } }");
>> +    g_assert_nonnull(ret);
>> +
>> +    g_assert_cmpstr(get_error_class(ret), =3D=3D, "GenericError");
>> +
>> +    qobject_unref(ret);
>>      qtest_quit(qts);
>>  }
>>
>> @@ -479,8 +511,13 @@ int main(int argc, char *argv[])
>>
>>      g_test_init(&argc, &argv, NULL);
>>
>> +    qtest_add_func("qmp/object-add-without-props",
>> +                   test_object_add_without_props);
>> +    qtest_add_func("qmp/qom-set-without-value",
>> +                   test_qom_set_without_value);
>>      qtest_add_func("qmp/protocol", test_qmp_protocol);
>>      qtest_add_func("qmp/oob", test_qmp_oob);
>> +
>>      qmp_schema_init(&schema);
>>      add_query_tests(&schema);
>>      qtest_add_func("qmp/preconfig", test_qmp_preconfig);
>> @@ -488,5 +525,6 @@ int main(int argc, char *argv[])
>>      ret =3D g_test_run();
>>
>>      qmp_schema_cleanup(&schema);
>> +
>>      return ret;
>>  }
>
> Is this hunk intentional?
>

no

> Taking a step back: the test cases look good, but is this file an
> appropriate home?  The file comment states it's about "QMP protocol test
> cases".  These test cases test commands, not the protocol.

Actually, the tests were written to test the qapi/qmp fixes mentionned
in commit message. So they were more "protocol" related than command
related.

>
> I figure test_qom_set_without_value() belongs to qom-test.c.
>
> test_object_add_without_props() could go into a memory backend test
> collection, or an object-add test collection.  Sadly, neither exists.
> We could have a qmp command test collection as a home of last resort.
> Temptation to just throw a few random test cases there instead of
> covering (a set of related) commands with a proper test case collection.
>
> As is, your patch turns qmp-test.c into such a home of last resort.  If
> that's what we want, we should update the file comment.  But I think I'd
> rather have a separate qmp-cmd-test.c.
>
> Thoughts?

It's somewhat blurry lines to me, it would be simpler to just use qmp-test.
