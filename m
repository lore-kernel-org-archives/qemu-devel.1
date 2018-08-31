Received: from eggs.gnu.org ([2001:4830:134:3::10]:36272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fvd65-0000DY-P7
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 02:40:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fvcx4-0001QX-W9
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 02:30:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36086 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fvcx4-0001NX-Ou
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 02:30:38 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180829134043.31706-1-marcandre.lureau@redhat.com>
	<20180829134043.31706-8-marcandre.lureau@redhat.com>
	<878t4o3szg.fsf@dusky.pond.sub.org>
	<CAJ+F1CL=WEDZUCbNnrm_mm6sX3sLOcnJ3CHNj9Ec8gHmUYCYbg@mail.gmail.com>
Date: Fri, 31 Aug 2018 08:30:34 +0200
In-Reply-To: <CAJ+F1CL=WEDZUCbNnrm_mm6sX3sLOcnJ3CHNj9Ec8gHmUYCYbg@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 30 Aug 2018
	17:42:13 +0200")
Message-ID: <8736uvujxx.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Thu, Aug 30, 2018 at 3:05 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > test_qom_set_without_value() is about a bug in infrastructure used by
>> > the QMP core, fixed in commit c489780203.  We covered the bug in
>> > infrastructure unit tests (commit bce3035a44).  I wrote that test
>> > earlier, to cover QMP level as well, the test could go into qmp-test.
>> >
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > ---
>> >  tests/qmp-test.c | 18 ++++++++++++++++++
>> >  1 file changed, 18 insertions(+)
>> >
>> > diff --git a/tests/qmp-test.c b/tests/qmp-test.c
>> > index 4ae2245484..fdfe73b6d2 100644
>> > --- a/tests/qmp-test.c
>> > +++ b/tests/qmp-test.c
>> > @@ -348,6 +348,23 @@ static void test_qmp_preconfig(void)
>> >      qtest_quit(qs);
>> >  }
>> >
>> > +static void test_qom_set_without_value(void)
>> > +{
>> > +    QTestState *qts;
>> > +    QDict *ret;
>> > +
>> > +    qts =3D qtest_init(common_args);
>> > +
>> > +    ret =3D qtest_qmp(qts, "{'execute': 'qom-set', 'arguments':"
>> > +                    " { 'path': '/machine', 'property': 'rtc-time' } =
}");
>> > +    g_assert_nonnull(ret);
>> > +
>> > +    g_assert_cmpstr(get_error_class(ret), =3D=3D, "GenericError");
>> > +
>> > +    qobject_unref(ret);
>> > +    qtest_quit(qts);
>> > +}
>> > +
>> >  int main(int argc, char *argv[])
>> >  {
>> >      g_test_init(&argc, &argv, NULL);
>> > @@ -355,6 +372,7 @@ int main(int argc, char *argv[])
>> >      qtest_add_func("qmp/protocol", test_qmp_protocol);
>> >      qtest_add_func("qmp/oob", test_qmp_oob);
>> >      qtest_add_func("qmp/preconfig", test_qmp_preconfig);
>> > +    qtest_add_func("qmp/qom-set-without-value", test_qom_set_without_=
value);
>> >
>> >      return g_test_run();
>> >  }
>>
>> What we're testing here is a missing 'any' parameter.  The test should
>> be named accordingly.  Perhaps:
>>
>>        qtest_add_func("qmp/missing-any", test_missing_any);
>
> Eh, the inner visitor fix was about an 'any' parameter missing.
>
> But the test is more about about checking the behaviour of qom-set
> without 'value' argument. I would not rename it based on the internal
> bug that was fixed.

Missing arguments are caught by the QObject input visitor on behalf of
the generated command marshalling code.  The command handler isn't
called then.  Thus, qom-set doesn't get to behave!  All the test really
tests is that

* the visitor behaves (redundant with test-qobject-input-visitor.c's
  test_visitor_in_fail_struct_missing()),

* the generated marshalling code handles visitor failure (I guess that's
  worth covering here),

* and the QMP core handles command failure (redundant with numerous
  other tests, but covering it here once more won't hurt).

The test could just as well any other command with a mandatory argument
of type 'any', such as qom-set or object-add.

Same for arguments of inadmissible JSON type.

Having written all this, I now think the test should be named
"qmp/invalid-arg".
