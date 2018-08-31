Received: from eggs.gnu.org ([2001:4830:134:3::10]:59518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fvjfZ-0002wt-3y
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:41:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fvjfX-0003KP-RZ
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:41:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37094 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fvjfX-0003Iq-Jv
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:40:59 -0400
References: <1535704738-8986-1-git-send-email-thuth@redhat.com>
	<1535704738-8986-9-git-send-email-thuth@redhat.com>
	<87efeerbcu.fsf@dusky.pond.sub.org>
	<593af39a-cc9b-d4e8-7e6c-efdbbe169096@redhat.com>
	<CAJ+F1CLX15g+QOCyjaBHJN1n0oLtQCH390RivRQkTcyptWf+cw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5b4cef8c-084c-5a2b-1fb6-210388054d38@redhat.com>
Date: Fri, 31 Aug 2018 15:40:54 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLX15g+QOCyjaBHJN1n0oLtQCH390RivRQkTcyptWf+cw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 8/9] tests: add qmp/qom-set-without-value
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 2018-08-31 15:24, Marc-Andr=C3=A9 Lureau wrote:
> Hi
> On Fri, Aug 31, 2018 at 3:18 PM Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 2018-08-31 14:04, Markus Armbruster wrote:
>>> Thomas Huth <thuth@redhat.com> writes:
>>>
>>>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>>>
>>>> test_qom_set_without_value() is about a bug in infrastructure used b=
y
>>>> the QMP core, fixed in commit c489780203.  We covered the bug in
>>>> infrastructure unit tests (commit bce3035a44).  I wrote that test
>>>> earlier, to cover QMP level as well, the test could go into qmp-test=
.
>>>>
>>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>  tests/qmp-test.c | 14 ++++++++++++++
>>>>  1 file changed, 14 insertions(+)
>>>>
>>>> diff --git a/tests/qmp-test.c b/tests/qmp-test.c
>>>> index b347228..2b923f0 100644
>>>> --- a/tests/qmp-test.c
>>>> +++ b/tests/qmp-test.c
>>>> @@ -321,6 +321,19 @@ static void test_qmp_preconfig(void)
>>>>      qtest_quit(qs);
>>>>  }
>>>>
>>>> +static void test_qom_set_without_value(void)
>>>> +{
>>>> +    QTestState *qts;
>>>> +    QDict *resp;
>>>> +
>>>> +    qts =3D qtest_init(common_args);
>>>> +    resp =3D qtest_qmp(qts, "{'execute': 'qom-set', 'arguments':"
>>>> +                     " { 'path': '/machine', 'property': 'rtc-time'=
 } }");
>>>> +    g_assert_nonnull(resp);
>>>> +    qmp_assert_error_class(resp, "GenericError");
>>>> +    qtest_quit(qts);
>>>> +}
>>>> +
>>>>  int main(int argc, char *argv[])
>>>>  {
>>>>      g_test_init(&argc, &argv, NULL);
>>>> @@ -328,6 +341,7 @@ int main(int argc, char *argv[])
>>>>      qtest_add_func("qmp/protocol", test_qmp_protocol);
>>>>      qtest_add_func("qmp/oob", test_qmp_oob);
>>>>      qtest_add_func("qmp/preconfig", test_qmp_preconfig);
>>>> +    qtest_add_func("qmp/qom-set-without-value", test_qom_set_withou=
t_value);
>>>>
>>>>      return g_test_run();
>>>>  }
>>>
>>> I'm afraid you missed my objection to naming:
>>> Message-ID: <8736uvujxx.fsf@dusky.pond.sub.org>
>>> https://lists.nongnu.org/archive/html/qemu-devel/2018-08/msg06368.htm=
l
>>
>> Sorry about that, I was not on CC: for that series. I used the patches
>> from v5 where Marc-Andr=C3=A9 put me on CC:.
>>
>>> If you could work that into PULL v2, I'd be obliged.  If not, I'll ha=
ve
>>> to address it in a follow-up patch.
>>
>> IMHO the naming is not that bad ... OTOH, I think Peter might already =
be
>> away? ... so we've got plenty of time to sort this out anyway.
>> Marc-Andr=C3=A9, could you send a new version of the patch?
>=20
> Tbh, I don't care so much about the naming of the test, but (for once)
> I respectfully don't think Markus suggestion is better.
>=20
> The function checks "qom-set" without 'value' argument:
> "qom-set-without-value", no brainer..
>=20
> Naming it "invalid-arg" is so generic that I wouldn't be able what it d=
oes.

Ok, then let's keep it this way. As I said, IMHO the current naming is
not really bad, and I also don't have any suggestions for a perfect name
right now.

 Thomas
