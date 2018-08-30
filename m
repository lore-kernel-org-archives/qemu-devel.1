Received: from eggs.gnu.org ([2001:4830:134:3::10]:53877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fvPCS-0006Y2-Kb
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:49:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fvP5W-0002l8-2X
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:42:26 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33089)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fvP5V-0002km-Ra
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:42:26 -0400
Received: by mail-wm0-x241.google.com with SMTP id i134-v6so2151314wmf.0
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 08:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180829134043.31706-1-marcandre.lureau@redhat.com>
	<20180829134043.31706-8-marcandre.lureau@redhat.com>
	<878t4o3szg.fsf@dusky.pond.sub.org>
In-Reply-To: <878t4o3szg.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 30 Aug 2018 17:42:13 +0200
Message-ID: <CAJ+F1CL=WEDZUCbNnrm_mm6sX3sLOcnJ3CHNj9Ec8gHmUYCYbg@mail.gmail.com>
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
Cc: QEMU <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>

Hi

On Thu, Aug 30, 2018 at 3:05 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > test_qom_set_without_value() is about a bug in infrastructure used by
> > the QMP core, fixed in commit c489780203.  We covered the bug in
> > infrastructure unit tests (commit bce3035a44).  I wrote that test
> > earlier, to cover QMP level as well, the test could go into qmp-test.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  tests/qmp-test.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/tests/qmp-test.c b/tests/qmp-test.c
> > index 4ae2245484..fdfe73b6d2 100644
> > --- a/tests/qmp-test.c
> > +++ b/tests/qmp-test.c
> > @@ -348,6 +348,23 @@ static void test_qmp_preconfig(void)
> >      qtest_quit(qs);
> >  }
> >
> > +static void test_qom_set_without_value(void)
> > +{
> > +    QTestState *qts;
> > +    QDict *ret;
> > +
> > +    qts =3D qtest_init(common_args);
> > +
> > +    ret =3D qtest_qmp(qts, "{'execute': 'qom-set', 'arguments':"
> > +                    " { 'path': '/machine', 'property': 'rtc-time' } }=
");
> > +    g_assert_nonnull(ret);
> > +
> > +    g_assert_cmpstr(get_error_class(ret), =3D=3D, "GenericError");
> > +
> > +    qobject_unref(ret);
> > +    qtest_quit(qts);
> > +}
> > +
> >  int main(int argc, char *argv[])
> >  {
> >      g_test_init(&argc, &argv, NULL);
> > @@ -355,6 +372,7 @@ int main(int argc, char *argv[])
> >      qtest_add_func("qmp/protocol", test_qmp_protocol);
> >      qtest_add_func("qmp/oob", test_qmp_oob);
> >      qtest_add_func("qmp/preconfig", test_qmp_preconfig);
> > +    qtest_add_func("qmp/qom-set-without-value", test_qom_set_without_v=
alue);
> >
> >      return g_test_run();
> >  }
>
> What we're testing here is a missing 'any' parameter.  The test should
> be named accordingly.  Perhaps:
>
>        qtest_add_func("qmp/missing-any", test_missing_any);

Eh, the inner visitor fix was about an 'any' parameter missing.

But the test is more about about checking the behaviour of qom-set
without 'value' argument. I would not rename it based on the internal
bug that was fixed.

--=20
Marc-Andr=C3=A9 Lureau
