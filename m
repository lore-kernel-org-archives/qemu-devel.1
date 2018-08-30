Received: from eggs.gnu.org ([2001:4830:134:3::10]:55463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fvMdQ-0000G0-Ux
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 09:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fvMdM-0001Jd-VC
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 09:05:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34726 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fvMdM-0001JU-Qh
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 09:05:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 421C840241CB
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 13:05:12 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180829134043.31706-1-marcandre.lureau@redhat.com>
	<20180829134043.31706-8-marcandre.lureau@redhat.com>
Date: Thu, 30 Aug 2018 15:05:07 +0200
In-Reply-To: <20180829134043.31706-8-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 29 Aug 2018 15:40:40 +0200")
Message-ID: <878t4o3szg.fsf@dusky.pond.sub.org>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> test_qom_set_without_value() is about a bug in infrastructure used by
> the QMP core, fixed in commit c489780203.  We covered the bug in
> infrastructure unit tests (commit bce3035a44).  I wrote that test
> earlier, to cover QMP level as well, the test could go into qmp-test.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/qmp-test.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/tests/qmp-test.c b/tests/qmp-test.c
> index 4ae2245484..fdfe73b6d2 100644
> --- a/tests/qmp-test.c
> +++ b/tests/qmp-test.c
> @@ -348,6 +348,23 @@ static void test_qmp_preconfig(void)
>      qtest_quit(qs);
>  }
>=20=20
> +static void test_qom_set_without_value(void)
> +{
> +    QTestState *qts;
> +    QDict *ret;
> +
> +    qts =3D qtest_init(common_args);
> +
> +    ret =3D qtest_qmp(qts, "{'execute': 'qom-set', 'arguments':"
> +                    " { 'path': '/machine', 'property': 'rtc-time' } }");
> +    g_assert_nonnull(ret);
> +
> +    g_assert_cmpstr(get_error_class(ret), =3D=3D, "GenericError");
> +
> +    qobject_unref(ret);
> +    qtest_quit(qts);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>      g_test_init(&argc, &argv, NULL);
> @@ -355,6 +372,7 @@ int main(int argc, char *argv[])
>      qtest_add_func("qmp/protocol", test_qmp_protocol);
>      qtest_add_func("qmp/oob", test_qmp_oob);
>      qtest_add_func("qmp/preconfig", test_qmp_preconfig);
> +    qtest_add_func("qmp/qom-set-without-value", test_qom_set_without_val=
ue);
>=20=20
>      return g_test_run();
>  }

What we're testing here is a missing 'any' parameter.  The test should
be named accordingly.  Perhaps:

       qtest_add_func("qmp/missing-any", test_missing_any);

I can't bring myself to care for this test.  There are countless ways to
run a command with invalid parameters, and this is just one.  The only
thing that sets it apart is it used to tickle a visitor bug we've long
fixed, complete with a unit test to prevent regressions.  But the cost
of carrying the test is pretty low, so if you really want it, then
taking it without further argument is probably cheaper even if it's as
redundant as I suspect it is.
