Received: from eggs.gnu.org ([2001:4830:134:3::10]:41489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIyqe-0004cg-15
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:55:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIyqZ-0002ii-Tb
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:55:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dIyqZ-0002i1-M6
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:55:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A16E7F6AA
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 14:55:38 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170607163635.17635-1-marcandre.lureau@redhat.com>
	<20170607163635.17635-5-marcandre.lureau@redhat.com>
Date: Thu, 08 Jun 2017 16:55:34 +0200
In-Reply-To: <20170607163635.17635-5-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 7 Jun 2017 20:35:56 +0400")
Message-ID: <8760g67cm1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 04/43] tests: add more int/number ranges
 checks
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

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/test-qobject-input-visitor.c | 38 ++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
> index 83d663d11d..3a6ce2226c 100644
> --- a/tests/test-qobject-input-visitor.c
> +++ b/tests/test-qobject-input-visitor.c
> @@ -107,6 +107,7 @@ static void test_visitor_in_int(TestInputVisitorData =
*data,
>                                  const void *unused)
>  {
>      int64_t res =3D 0;
> +    double dbl;
>      int value =3D -42;
>      Visitor *v;
>=20=20
> @@ -114,6 +115,9 @@ static void test_visitor_in_int(TestInputVisitorData =
*data,
>=20=20
>      visit_type_int(v, NULL, &res, &error_abort);
>      g_assert_cmpint(res, =3D=3D, value);
> +
> +    visit_type_number(v, NULL, &dbl, &error_abort);
> +    g_assert_cmpfloat(dbl, =3D=3D, -42.0);
>  }
>=20=20
>  static void test_visitor_in_uint(TestInputVisitorData *data,
> @@ -121,6 +125,8 @@ static void test_visitor_in_uint(TestInputVisitorData=
 *data,
>  {
>      Error *err =3D NULL;
>      uint64_t res =3D 0;
> +    int64_t i64;
> +    double dbl;
>      int value =3D 42;
>      Visitor *v;
>=20=20
> @@ -129,8 +135,13 @@ static void test_visitor_in_uint(TestInputVisitorDat=
a *data,
>      visit_type_uint64(v, NULL, &res, &error_abort);
>      g_assert_cmpuint(res, =3D=3D, (uint64_t)value);
>=20=20
> -    /* BUG: value between INT64_MIN and -1 accepted modulo 2^64 */
> +    visit_type_int(v, NULL, &i64, &error_abort);
> +    g_assert_cmpint(i64, =3D=3D, value);
> +
> +    visit_type_number(v, NULL, &dbl, &error_abort);
> +    g_assert_cmpfloat(dbl, =3D=3D, value);
>=20=20
> +    /* BUG: value between INT64_MIN and -1 accepted modulo 2^64 */
>      v =3D visitor_input_test_init(data, "%d", -value);
>=20=20
>      visit_type_uint64(v, NULL, &res, &error_abort);
> @@ -142,6 +153,8 @@ static void test_visitor_in_uint(TestInputVisitorData=
 *data,
>=20=20
>      visit_type_uint64(v, NULL, &res, &err);
>      error_free_or_abort(&err);
> +
> +    visit_type_number(v, NULL, &dbl, &error_abort);

Please test the expected value, like you do for the other
visit_type_number() you add.

>  }
>=20=20
>  static void test_visitor_in_int_overflow(TestInputVisitorData *data,
> @@ -260,6 +273,27 @@ static void test_visitor_in_number(TestInputVisitorD=
ata *data,
>      g_assert_cmpfloat(res, =3D=3D, value);
>  }
>=20=20
> +static void test_visitor_in_large_number(TestInputVisitorData *data,
> +                                         const void *unused)
> +{
> +    Error *err =3D NULL;
> +    double res =3D 0;
> +    int64_t i64;
> +    uint64_t u64;
> +    Visitor *v;
> +
> +    v =3D visitor_input_test_init(data, "-18446744073709551616"); /* -2^=
64 */
> +
> +    visit_type_number(v, NULL, &res, &error_abort);
> +    g_assert_cmpfloat(res, =3D=3D, -18446744073709552e3);
> +
> +    visit_type_int(v, NULL, &i64, &err);
> +    error_free_or_abort(&err);
> +
> +    visit_type_uint64(v, NULL, &u64, &err);
> +    error_free_or_abort(&err);
> +}
> +
>  static void test_visitor_in_number_keyval(TestInputVisitorData *data,
>                                            const void *unused)
>  {
> @@ -1253,6 +1287,8 @@ int main(int argc, char **argv)
>                             NULL, test_visitor_in_bool_str_fail);
>      input_visitor_test_add("/visitor/input/number",
>                             NULL, test_visitor_in_number);
> +    input_visitor_test_add("/visitor/input/large_number",
> +                           NULL, test_visitor_in_large_number);
>      input_visitor_test_add("/visitor/input/number_keyval",
>                             NULL, test_visitor_in_number_keyval);
>      input_visitor_test_add("/visitor/input/number_str_keyval",

With test_visitor_in_uint() tightened:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
