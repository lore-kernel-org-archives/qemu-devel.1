Received: from eggs.gnu.org ([2001:4830:134:3::10]:41493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnkAw-0001rK-In
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 08:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnkAs-0003po-Lz
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 08:36:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33876 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fnkAs-0003oJ-GD
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 08:36:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0F33D402332F
	for <qemu-devel@nongnu.org>; Thu,  9 Aug 2018 12:36:18 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180719184111.5129-1-marcandre.lureau@redhat.com>
	<20180719184111.5129-16-marcandre.lureau@redhat.com>
Date: Thu, 09 Aug 2018 14:36:16 +0200
In-Reply-To: <20180719184111.5129-16-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 19 Jul 2018 20:41:08 +0200")
Message-ID: <87mutviunz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 15/18] tests: add a few qemu-qmp tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> These 2 tests exhibited two qmp bugs that were fixed in 2.7
> (series from commit e64c75a9752c5d0fd64eb2e684c656a5ea7d03c6 to
> commit 1382d4abdf9619985e4078e37e49e487cea9935e)
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/qmp-test.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/tests/qmp-test.c b/tests/qmp-test.c
> index b9774084f8..54611e587f 100644
> --- a/tests/qmp-test.c
> +++ b/tests/qmp-test.c
> @@ -249,7 +249,40 @@ static void test_qmp_oob(void)
>      recv_cmd_id(qts, "blocks-2");
>      recv_cmd_id(qts, "err-2");
>      cleanup_blocking_cmd();
> +}
> +
> +static void test_object_add_without_props(void)
> +{
> +    QTestState *qts;
> +    QDict *ret;
> +
> +    qts =3D qtest_init(common_args);
>=20=20
> +    ret =3D qtest_qmp(qts,
> +                    "{'execute': 'object-add', 'arguments':"
> +                    " {'qom-type': 'memory-backend-ram', 'id': 'ram1' } =
}");
> +    g_assert_nonnull(ret);
> +
> +    g_assert_cmpstr(get_error_class(ret), =3D=3D, "GenericError");
> +
> +    qobject_unref(ret);
> +    qtest_quit(qts);
> +}
> +
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
>      qtest_quit(qts);
>  }
>=20=20
> @@ -479,8 +512,13 @@ int main(int argc, char *argv[])
>=20=20
>      g_test_init(&argc, &argv, NULL);
>=20=20
> +    qtest_add_func("qmp/object-add-without-props",
> +                   test_object_add_without_props);
> +    qtest_add_func("qmp/qom-set-without-value",
> +                   test_qom_set_without_value);
>      qtest_add_func("qmp/protocol", test_qmp_protocol);
>      qtest_add_func("qmp/oob", test_qmp_oob);
> +
>      qmp_schema_init(&schema);
>      add_query_tests(&schema);
>      qtest_add_func("qmp/preconfig", test_qmp_preconfig);

I've since moved tests that aren't protocol-related into qmp-cmd-test.

As discussed in review of v1, test_object_add_without_props() isn't
protocol-related.  It tests a bug in qmp_object_add() we fixed in commit
e64c75a975.  Sadly, we don't have systematic object-add tests.  This
lone test can go into qmp-cmd-test for want of a better home.

test_qom_set_without_value() isn't about qom-set, it's about a bug in
infrastructure used by the QMP core, fixed in commit c489780203.  We
covered the bug in infrastructure unit tests (commit bce3035a44).  If we
want to test it at the QMP level as well, the test could go into
qmp-test.  Do we want to?

In my quick rebase, I added both tests to qmp-cmd-test.c out of
laziness.
