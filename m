Received: from eggs.gnu.org ([208.118.235.92]:48053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fviHO-0001M2-VS
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 08:12:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fviAA-00075C-7W
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 08:04:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44414 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fviAA-000750-2H
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 08:04:30 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1535704738-8986-1-git-send-email-thuth@redhat.com>
	<1535704738-8986-9-git-send-email-thuth@redhat.com>
Date: Fri, 31 Aug 2018 14:04:17 +0200
In-Reply-To: <1535704738-8986-9-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Fri, 31 Aug 2018 10:38:57 +0200")
Message-ID: <87efeerbcu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Thomas Huth <thuth@redhat.com> writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> test_qom_set_without_value() is about a bug in infrastructure used by
> the QMP core, fixed in commit c489780203.  We covered the bug in
> infrastructure unit tests (commit bce3035a44).  I wrote that test
> earlier, to cover QMP level as well, the test could go into qmp-test.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qmp-test.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/tests/qmp-test.c b/tests/qmp-test.c
> index b347228..2b923f0 100644
> --- a/tests/qmp-test.c
> +++ b/tests/qmp-test.c
> @@ -321,6 +321,19 @@ static void test_qmp_preconfig(void)
>      qtest_quit(qs);
>  }
>=20=20
> +static void test_qom_set_without_value(void)
> +{
> +    QTestState *qts;
> +    QDict *resp;
> +
> +    qts =3D qtest_init(common_args);
> +    resp =3D qtest_qmp(qts, "{'execute': 'qom-set', 'arguments':"
> +                     " { 'path': '/machine', 'property': 'rtc-time' } }"=
);
> +    g_assert_nonnull(resp);
> +    qmp_assert_error_class(resp, "GenericError");
> +    qtest_quit(qts);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>      g_test_init(&argc, &argv, NULL);
> @@ -328,6 +341,7 @@ int main(int argc, char *argv[])
>      qtest_add_func("qmp/protocol", test_qmp_protocol);
>      qtest_add_func("qmp/oob", test_qmp_oob);
>      qtest_add_func("qmp/preconfig", test_qmp_preconfig);
> +    qtest_add_func("qmp/qom-set-without-value", test_qom_set_without_val=
ue);
>=20=20
>      return g_test_run();
>  }

I'm afraid you missed my objection to naming:
Message-ID: <8736uvujxx.fsf@dusky.pond.sub.org>
https://lists.nongnu.org/archive/html/qemu-devel/2018-08/msg06368.html

If you could work that into PULL v2, I'd be obliged.  If not, I'll have
to address it in a follow-up patch.
