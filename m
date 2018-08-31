Received: from eggs.gnu.org ([2001:4830:134:3::10]:40589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fvdDN-0005pI-RG
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 02:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fvdDK-0008Pv-Kj
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 02:47:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48132 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fvdDK-0008Pl-Cf
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 02:47:26 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180829134043.31706-1-marcandre.lureau@redhat.com>
	<20180829134043.31706-7-marcandre.lureau@redhat.com>
	<87efeg3tmx.fsf@dusky.pond.sub.org>
	<CAJ+F1CJTG-7gRAf8pfnVHxpTf3u_-ST9P8r8LWFfbm2E1wqrGQ@mail.gmail.com>
Date: Fri, 31 Aug 2018 08:47:22 +0200
In-Reply-To: <CAJ+F1CJTG-7gRAf8pfnVHxpTf3u_-ST9P8r8LWFfbm2E1wqrGQ@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 30 Aug 2018
	17:23:23 +0200")
Message-ID: <87sh2vt4lh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 06/10] tests: add
 qmp/object-add-without-props test
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
> On Thu, Aug 30, 2018 at 3:01 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > test_object_add_without_props() tests a bug in qmp_object_add() we
>> > fixed in commit e64c75a975.  Sadly, we don't have systematic
>> > object-add tests.  This lone test can go into qmp-cmd-test for want of
>> > a better home.
>> >
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > ---
>> >  tests/qmp-cmd-test.c | 31 +++++++++++++++++++++++++++++++
>> >  1 file changed, 31 insertions(+)
>> >
>> > diff --git a/tests/qmp-cmd-test.c b/tests/qmp-cmd-test.c
>> > index c5b70df974..3ba8f68476 100644
>> > --- a/tests/qmp-cmd-test.c
>> > +++ b/tests/qmp-cmd-test.c
>> > @@ -19,6 +19,15 @@
>> >
>> >  const char common_args[] =3D "-nodefaults -machine none";
>> >
>> > +static const char *get_error_class(QDict *resp)
>> > +{
>> > +    QDict *error =3D qdict_get_qdict(resp, "error");
>> > +    const char *desc =3D qdict_get_try_str(error, "desc");
>> > +
>> > +    g_assert(desc);
>> > +    return error ? qdict_get_try_str(error, "class") : NULL;
>> > +}
>> > +
>> >  /* Query smoke tests */
>> >
>> >  static int query_error_class(const char *cmd)
>>
>> Copied from qmp-test.c.  It should be factored out instead.  Where to
>> put it?  libqtest.c isn't quite right, as the function could
>> theoretically be useful in unit tests as well, but I guess it would do
>> for now.
>>
>> Asserting presence of "desc" makes little sense outside qmp-test.c
>> protocol tests, but it doesn't hurt, either.
>>
>> Grep shows more possible users in tests/drive_del-test.c and
>> tests/test-qga.c.
>
> ok
>
>>
>> > @@ -197,6 +206,24 @@ static void add_query_tests(QmpSchema *schema)
>> >      }
>> >  }
>> >
>> > +static void test_object_add_without_props(void)
>> > +{
>> > +    QTestState *qts;
>> > +    QDict *ret;
>>
>> qmp-test.c and qmp-cmd-test.c commonly use @resp for the response.
>
> ok
>
>>
>> > +
>> > +    qts =3D qtest_init(common_args);
>> > +
>> > +    ret =3D qtest_qmp(qts,
>> > +                    "{'execute': 'object-add', 'arguments':"
>> > +                    " {'qom-type': 'memory-backend-ram', 'id': 'ram1'=
 } }");
>> > +    g_assert_nonnull(ret);
>>
>> What's wrong with g_assert(!ret)?
>
> nothing wrong, but g_assert_nonnull is slightly more readable, both in
> code and in error produced.

I beg to differ.  assert(!ret) is idiomatic C.

I file g_assert_nonnull() under "redundant crap GLib dumps into my
limited identifier memory just because it can", along with similar
beauties g_assert_false(), guint, gconstpointer, ...

>> > +
>> > +    g_assert_cmpstr(get_error_class(ret), =3D=3D, "GenericError");
>> > +
>> > +    qobject_unref(ret);
>>
>> Permit me to digress.
>>
>> When you expect success, you check @resp like this:
>>
>>     ret =3D qdict_get_qdict(resp, "return");
>>     ... laborously check @ret against expectations ...
>>
>> If you feel pedantically thorough, you can throw in
>>
>>     g_assert(!qdict_haskey(resp, "error");
>>
>> When you expect failure, you check like this:
>>
>>     error =3D qdict_get_qdict(resp, "error");
>>     class =3D qdict_get_try_str(error, "class");
>>     g_assert_cmpstr(class, =3D=3D, "GenericError");
>>
>> and perhaps
>>
>>     g_assert(!qdict_haskey(resp, "return");
>>
>> get_error_class() saves a little typing in the failure case.  It's still
>> an awfully verbose overall, and the checking is full of holes more often
>> than not.  There's got to be a better way.
>>
>
> what about?
> /**
>  * qmp_assert_error_class:
>  * @rsp: QMP response to check for error
>  * @class: an error class
>  *
>  * Assert the response has the given error class and discard @rsp.
>  */
> void qmp_assert_error_class(QDict *rsp, const char *class)
> {
>     QDict *error =3D qdict_get_qdict(rsp, "error");
>
>     g_assert_cmpstr(qdict_get_try_str(error, "class"), =3D=3D, class);
>     g_assert_nonnull(qdict_get_try_str(error, "desc"));
>     g_assert_null(qdict_get(error, "return"));
>
>     qobject_unref(rsp);
> }

Drawback: the assertion messages no longer point to the test that broke.
Do we care?

>> > +    qtest_quit(qts);
>> > +}
>> > +
>> >  int main(int argc, char *argv[])
>> >  {
>> >      QmpSchema schema;
>> > @@ -206,6 +233,10 @@ int main(int argc, char *argv[])
>> >
>> >      qmp_schema_init(&schema);
>> >      add_query_tests(&schema);
>> > +
>> > +    qtest_add_func("qmp/object-add-without-props",
>> > +                   test_object_add_without_props);
>> > +
>> >      ret =3D g_test_run();
>> >
>> >      qmp_schema_cleanup(&schema);
>>
>> May I have a TODO comment asking for coverage of generic object-add
>> failure modes?
>
> You mean checking for other kind of failures? ok

Yes.  Your commit message admits "we don't have systematic object-add
tests".  The TODO comment copies that to the code.  It only asks for
negative tests, because these are the only generic ones (I think), and
object-specific tests should go elsewhere.
