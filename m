Received: from eggs.gnu.org ([2001:4830:134:3::10]:57033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fvMic-0003uK-5n
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 09:10:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fvMiY-0003F3-88
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 09:10:38 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1fvMiY-0003Em-2k
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 09:10:34 -0400
Received: by mail-io0-f195.google.com with SMTP id r196-v6so7500224iod.0
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 06:10:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <878t4o3szg.fsf@dusky.pond.sub.org>
References: <20180829134043.31706-1-marcandre.lureau@redhat.com>
	<20180829134043.31706-8-marcandre.lureau@redhat.com>
	<878t4o3szg.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Aug 2018 15:10:32 +0200
Message-ID: <CAMxuvax0GspDU5WYtLbE0RP=8YaOoRbUF8gmPmuf_NNcQKXDXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 07/10] tests: add
 qmp/qom-set-without-value test
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

On Thu, Aug 30, 2018 at 3:05 PM, Markus Armbruster <armbru@redhat.com> wrot=
e:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> test_qom_set_without_value() is about a bug in infrastructure used by
>> the QMP core, fixed in commit c489780203.  We covered the bug in
>> infrastructure unit tests (commit bce3035a44).  I wrote that test
>> earlier, to cover QMP level as well, the test could go into qmp-test.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  tests/qmp-test.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/tests/qmp-test.c b/tests/qmp-test.c
>> index 4ae2245484..fdfe73b6d2 100644
>> --- a/tests/qmp-test.c
>> +++ b/tests/qmp-test.c
>> @@ -348,6 +348,23 @@ static void test_qmp_preconfig(void)
>>      qtest_quit(qs);
>>  }
>>
>> +static void test_qom_set_without_value(void)
>> +{
>> +    QTestState *qts;
>> +    QDict *ret;
>> +
>> +    qts =3D qtest_init(common_args);
>> +
>> +    ret =3D qtest_qmp(qts, "{'execute': 'qom-set', 'arguments':"
>> +                    " { 'path': '/machine', 'property': 'rtc-time' } }"=
);
>> +    g_assert_nonnull(ret);
>> +
>> +    g_assert_cmpstr(get_error_class(ret), =3D=3D, "GenericError");
>> +
>> +    qobject_unref(ret);
>> +    qtest_quit(qts);
>> +}
>> +
>>  int main(int argc, char *argv[])
>>  {
>>      g_test_init(&argc, &argv, NULL);
>> @@ -355,6 +372,7 @@ int main(int argc, char *argv[])
>>      qtest_add_func("qmp/protocol", test_qmp_protocol);
>>      qtest_add_func("qmp/oob", test_qmp_oob);
>>      qtest_add_func("qmp/preconfig", test_qmp_preconfig);
>> +    qtest_add_func("qmp/qom-set-without-value", test_qom_set_without_va=
lue);
>>
>>      return g_test_run();
>>  }
>
> What we're testing here is a missing 'any' parameter.  The test should
> be named accordingly.  Perhaps:
>
>        qtest_add_func("qmp/missing-any", test_missing_any);
>
> I can't bring myself to care for this test.  There are countless ways to
> run a command with invalid parameters, and this is just one.  The only
> thing that sets it apart is it used to tickle a visitor bug we've long
> fixed, complete with a unit test to prevent regressions.  But the cost
> of carrying the test is pretty low, so if you really want it, then
> taking it without further argument is probably cheaper even if it's as
> redundant as I suspect it is.

Yes, I would rather have it than drop it. It covers the QMP level as well.
