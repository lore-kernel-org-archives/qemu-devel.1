Received: from eggs.gnu.org ([2001:4830:134:3::10]:50407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fvMXL-00041Z-Qe
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 08:59:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fvMPk-0001oy-Ic
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 08:51:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33534 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fvMPk-0001og-Dh
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 08:51:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D56A740201BC
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 12:51:07 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180829134043.31706-1-marcandre.lureau@redhat.com>
	<20180829134043.31706-7-marcandre.lureau@redhat.com>
Date: Thu, 30 Aug 2018 14:51:02 +0200
In-Reply-To: <20180829134043.31706-7-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 29 Aug 2018 15:40:39 +0200")
Message-ID: <87efeg3tmx.fsf@dusky.pond.sub.org>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> test_object_add_without_props() tests a bug in qmp_object_add() we
> fixed in commit e64c75a975.  Sadly, we don't have systematic
> object-add tests.  This lone test can go into qmp-cmd-test for want of
> a better home.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/qmp-cmd-test.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/tests/qmp-cmd-test.c b/tests/qmp-cmd-test.c
> index c5b70df974..3ba8f68476 100644
> --- a/tests/qmp-cmd-test.c
> +++ b/tests/qmp-cmd-test.c
> @@ -19,6 +19,15 @@
>=20=20
>  const char common_args[] =3D "-nodefaults -machine none";
>=20=20
> +static const char *get_error_class(QDict *resp)
> +{
> +    QDict *error =3D qdict_get_qdict(resp, "error");
> +    const char *desc =3D qdict_get_try_str(error, "desc");
> +
> +    g_assert(desc);
> +    return error ? qdict_get_try_str(error, "class") : NULL;
> +}
> +
>  /* Query smoke tests */
>=20=20
>  static int query_error_class(const char *cmd)

Copied from qmp-test.c.  It should be factored out instead.  Where to
put it?  libqtest.c isn't quite right, as the function could
theoretically be useful in unit tests as well, but I guess it would do
for now.

Asserting presence of "desc" makes little sense outside qmp-test.c
protocol tests, but it doesn't hurt, either.

Grep shows more possible users in tests/drive_del-test.c and
tests/test-qga.c.

> @@ -197,6 +206,24 @@ static void add_query_tests(QmpSchema *schema)
>      }
>  }
>=20=20
> +static void test_object_add_without_props(void)
> +{
> +    QTestState *qts;
> +    QDict *ret;

qmp-test.c and qmp-cmd-test.c commonly use @resp for the response.

> +
> +    qts =3D qtest_init(common_args);
> +
> +    ret =3D qtest_qmp(qts,
> +                    "{'execute': 'object-add', 'arguments':"
> +                    " {'qom-type': 'memory-backend-ram', 'id': 'ram1' } =
}");
> +    g_assert_nonnull(ret);

What's wrong with g_assert(!ret)?

> +
> +    g_assert_cmpstr(get_error_class(ret), =3D=3D, "GenericError");
> +
> +    qobject_unref(ret);

Permit me to digress.

When you expect success, you check @resp like this:

    ret =3D qdict_get_qdict(resp, "return");
    ... laborously check @ret against expectations ...

If you feel pedantically thorough, you can throw in

    g_assert(!qdict_haskey(resp, "error");

When you expect failure, you check like this:

    error =3D qdict_get_qdict(resp, "error");
    class =3D qdict_get_try_str(error, "class");
    g_assert_cmpstr(class, =3D=3D, "GenericError");

and perhaps

    g_assert(!qdict_haskey(resp, "return");

get_error_class() saves a little typing in the failure case.  It's still
an awfully verbose overall, and the checking is full of holes more often
than not.  There's got to be a better way.

> +    qtest_quit(qts);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>      QmpSchema schema;
> @@ -206,6 +233,10 @@ int main(int argc, char *argv[])
>=20=20
>      qmp_schema_init(&schema);
>      add_query_tests(&schema);
> +
> +    qtest_add_func("qmp/object-add-without-props",
> +                   test_object_add_without_props);
> +
>      ret =3D g_test_run();
>=20=20
>      qmp_schema_cleanup(&schema);

May I have a TODO comment asking for coverage of generic object-add
failure modes?
