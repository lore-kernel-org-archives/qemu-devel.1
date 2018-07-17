Received: from eggs.gnu.org ([2001:4830:134:3::10]:34705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ffKvs-0000fZ-FE
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 04:02:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ffKvm-0003yh-Br
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 04:02:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42410 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ffKvm-0003y1-6A
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 04:01:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9DD31402315B
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 08:01:57 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180706121354.2021-1-marcandre.lureau@redhat.com>
	<20180706121354.2021-10-marcandre.lureau@redhat.com>
Date: Tue, 17 Jul 2018 10:01:55 +0200
In-Reply-To: <20180706121354.2021-10-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Fri, 6 Jul 2018 14:13:51 +0200")
Message-ID: <87zhyqe1e4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com

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
> index ceaf4a6789..084c5edff0 100644
> --- a/tests/qmp-test.c
> +++ b/tests/qmp-test.c
> @@ -249,7 +249,39 @@ static void test_qmp_oob(void)
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
> +
> +    ret =3D qtest_qmp(qts, "{'execute': 'object-add',"
> +          " 'arguments': { 'qom-type': 'memory-backend-ram', 'id': 'ram1=
' } }");

Please break lines between arguments instead of within.  More of the
same below.

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
>=20=20
> +    ret =3D qtest_qmp(qts, "{'execute': 'qom-set',"
> +              " 'arguments': { 'path': '/machine', 'property': 'rtc-time=
' } }");
> +    g_assert_nonnull(ret);
> +
> +    g_assert_cmpstr(get_error_class(ret), =3D=3D, "GenericError");
> +
> +    qobject_unref(ret);
>      qtest_quit(qts);
>  }
>=20=20
> @@ -479,8 +511,13 @@ int main(int argc, char *argv[])
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
> @@ -488,5 +525,6 @@ int main(int argc, char *argv[])
>      ret =3D g_test_run();
>=20=20
>      qmp_schema_cleanup(&schema);
> +
>      return ret;
>  }

Is this hunk intentional?

Taking a step back: the test cases look good, but is this file an
appropriate home?  The file comment states it's about "QMP protocol test
cases".  These test cases test commands, not the protocol.

I figure test_qom_set_without_value() belongs to qom-test.c.

test_object_add_without_props() could go into a memory backend test
collection, or an object-add test collection.  Sadly, neither exists.
We could have a qmp command test collection as a home of last resort.
Temptation to just throw a few random test cases there instead of
covering (a set of related) commands with a proper test case collection.

As is, your patch turns qmp-test.c into such a home of last resort.  If
that's what we want, we should update the file comment.  But I think I'd
rather have a separate qmp-cmd-test.c.

Thoughts?
