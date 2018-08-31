Received: from eggs.gnu.org ([2001:4830:134:3::10]:57144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fvjb3-0005lR-2k
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:36:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fvjPY-0003ni-K0
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:24:29 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44616)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fvjPY-0003nO-Cz
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:24:28 -0400
Received: by mail-wr1-x442.google.com with SMTP id v16-v6so11218170wro.11
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 06:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <1535704738-8986-1-git-send-email-thuth@redhat.com>
	<1535704738-8986-9-git-send-email-thuth@redhat.com>
	<87efeerbcu.fsf@dusky.pond.sub.org>
	<593af39a-cc9b-d4e8-7e6c-efdbbe169096@redhat.com>
In-Reply-To: <593af39a-cc9b-d4e8-7e6c-efdbbe169096@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 31 Aug 2018 15:24:15 +0200
Message-ID: <CAJ+F1CLX15g+QOCyjaBHJN1n0oLtQCH390RivRQkTcyptWf+cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

Hi
On Fri, Aug 31, 2018 at 3:18 PM Thomas Huth <thuth@redhat.com> wrote:
>
> On 2018-08-31 14:04, Markus Armbruster wrote:
> > Thomas Huth <thuth@redhat.com> writes:
> >
> >> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>
> >> test_qom_set_without_value() is about a bug in infrastructure used by
> >> the QMP core, fixed in commit c489780203.  We covered the bug in
> >> infrastructure unit tests (commit bce3035a44).  I wrote that test
> >> earlier, to cover QMP level as well, the test could go into qmp-test.
> >>
> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> Reviewed-by: Thomas Huth <thuth@redhat.com>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  tests/qmp-test.c | 14 ++++++++++++++
> >>  1 file changed, 14 insertions(+)
> >>
> >> diff --git a/tests/qmp-test.c b/tests/qmp-test.c
> >> index b347228..2b923f0 100644
> >> --- a/tests/qmp-test.c
> >> +++ b/tests/qmp-test.c
> >> @@ -321,6 +321,19 @@ static void test_qmp_preconfig(void)
> >>      qtest_quit(qs);
> >>  }
> >>
> >> +static void test_qom_set_without_value(void)
> >> +{
> >> +    QTestState *qts;
> >> +    QDict *resp;
> >> +
> >> +    qts =3D qtest_init(common_args);
> >> +    resp =3D qtest_qmp(qts, "{'execute': 'qom-set', 'arguments':"
> >> +                     " { 'path': '/machine', 'property': 'rtc-time' }=
 }");
> >> +    g_assert_nonnull(resp);
> >> +    qmp_assert_error_class(resp, "GenericError");
> >> +    qtest_quit(qts);
> >> +}
> >> +
> >>  int main(int argc, char *argv[])
> >>  {
> >>      g_test_init(&argc, &argv, NULL);
> >> @@ -328,6 +341,7 @@ int main(int argc, char *argv[])
> >>      qtest_add_func("qmp/protocol", test_qmp_protocol);
> >>      qtest_add_func("qmp/oob", test_qmp_oob);
> >>      qtest_add_func("qmp/preconfig", test_qmp_preconfig);
> >> +    qtest_add_func("qmp/qom-set-without-value", test_qom_set_without_=
value);
> >>
> >>      return g_test_run();
> >>  }
> >
> > I'm afraid you missed my objection to naming:
> > Message-ID: <8736uvujxx.fsf@dusky.pond.sub.org>
> > https://lists.nongnu.org/archive/html/qemu-devel/2018-08/msg06368.html
>
> Sorry about that, I was not on CC: for that series. I used the patches
> from v5 where Marc-Andr=C3=A9 put me on CC:.
>
> > If you could work that into PULL v2, I'd be obliged.  If not, I'll have
> > to address it in a follow-up patch.
>
> IMHO the naming is not that bad ... OTOH, I think Peter might already be
> away? ... so we've got plenty of time to sort this out anyway.
> Marc-Andr=C3=A9, could you send a new version of the patch?

Tbh, I don't care so much about the naming of the test, but (for once)
I respectfully don't think Markus suggestion is better.

The function checks "qom-set" without 'value' argument:
"qom-set-without-value", no brainer..

Naming it "invalid-arg" is so generic that I wouldn't be able what it does.


--=20
Marc-Andr=C3=A9 Lureau
