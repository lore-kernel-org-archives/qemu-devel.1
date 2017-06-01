Received: from eggs.gnu.org ([2001:4830:134:3::10]:33319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dGQnd-0004jj-32
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:10:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dGQnZ-0003tR-Np
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:10:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dGQnZ-0003sz-FY
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:10:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4073C4E4C3
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 14:10:00 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
	<20170531135709.345-9-marcandre.lureau@redhat.com>
Date: Thu, 01 Jun 2017 16:09:55 +0200
In-Reply-To: <20170531135709.345-9-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 31 May 2017 17:56:32 +0400")
Message-ID: <87o9u7re8c.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 08/45] tests: add more int/number ranges
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

> Suggested by Markus Armbruster:
>
> We should systematically cover the integers, in particular the
> boundaries (because that's where bugs like to hide):
>
> * Integers in [-2^63,0) can be visited with visit_type_int() and
>   visit_type_number().
>
> * Integers in [0,2^63) can be visited with visit_type_int(),
>   visit_type_uint64() and visit_type_number().
>
> * Integers in [2^63,2^64) can be visited with visit_type_uint64() and
>   visit_type_number().
>
> * Integers outside [-2^63,2^53) can be visited with visit_type_number().
>
> In any case, visit_type_number() loses precision beyond 53 bits.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/test-qobject-input-visitor.c | 38 ++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
> index 83d663d11d..f2ed3161af 100644
> --- a/tests/test-qobject-input-visitor.c
> +++ b/tests/test-qobject-input-visitor.c
> @@ -102,11 +102,11 @@ static Visitor *visitor_input_test_init_raw(TestInp=
utVisitorData *data,
>  {
>      return visitor_input_test_init_internal(data, false, json_string, NU=
LL);
>  }
> -

Whoops.

>  static void test_visitor_in_int(TestInputVisitorData *data,
>                                  const void *unused)
>  {
>      int64_t res =3D 0;
> +    double dbl;
>      int value =3D -42;
>      Visitor *v;
>=20=20
> @@ -114,6 +114,9 @@ static void test_visitor_in_int(TestInputVisitorData =
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
> @@ -121,6 +124,8 @@ static void test_visitor_in_uint(TestInputVisitorData=
 *data,
>  {
>      Error *err =3D NULL;
>      uint64_t res =3D 0;
> +    int64_t i64;
> +    double dbl;
>      int value =3D 42;
>      Visitor *v;
>=20=20
> @@ -129,8 +134,13 @@ static void test_visitor_in_uint(TestInputVisitorDat=
a *data,
>      visit_type_uint64(v, NULL, &res, &error_abort);
>      g_assert_cmpuint(res, =3D=3D, (uint64_t)value);
>=20=20
> -    /* BUG: value between INT64_MIN and -1 accepted modulo 2^64 */
> +    visit_type_int(v, NULL, &i64, &error_abort);
> +    g_assert_cmpint(i64, =3D=3D, value);
>=20=20
> +    visit_type_number(v, NULL, &dbl, &error_abort);
> +    g_assert_cmpfloat(dbl, =3D=3D, value);
> +
> +    /* BUG: value between INT64_MIN and -1 accepted modulo 2^64 */
>      v =3D visitor_input_test_init(data, "%d", -value);
>=20=20
>      visit_type_uint64(v, NULL, &res, &error_abort);
> @@ -142,6 +152,8 @@ static void test_visitor_in_uint(TestInputVisitorData=
 *data,
>=20=20
>      visit_type_uint64(v, NULL, &res, &err);
>      error_free_or_abort(&err);
> +
> +    visit_type_number(v, NULL, &dbl, &error_abort);
>  }
>=20=20
>  static void test_visitor_in_int_overflow(TestInputVisitorData *data,
> @@ -260,6 +272,26 @@ static void test_visitor_in_number(TestInputVisitorD=
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

Shouldn't we check res has the expected value?

> +
> +    visit_type_int(v, NULL, &i64, &err);
> +    error_free_or_abort(&err);
> +
> +    visit_type_uint64(v, NULL, &u64, &err);
> +    error_free_or_abort(&err);
> +}

Not sure this is worth its own test.  But then I'm never sure whether to
write heaps of small tests, or few larger ones.  You decide.

> +
>  static void test_visitor_in_number_keyval(TestInputVisitorData *data,
>                                            const void *unused)
>  {
> @@ -1253,6 +1285,8 @@ int main(int argc, char **argv)
>                             NULL, test_visitor_in_bool_str_fail);
>      input_visitor_test_add("/visitor/input/number",
>                             NULL, test_visitor_in_number);
> +    input_visitor_test_add("/visitor/input/large_number",
> +                           NULL, test_visitor_in_large_number);
>      input_visitor_test_add("/visitor/input/number_keyval",
>                             NULL, test_visitor_in_number_keyval);
>      input_visitor_test_add("/visitor/input/number_str_keyval",

The new tests are welcome, but they don't "systematically cover the
integers".  The easiest fix is to adjust the commit message's claims
down:

    tests: Add more int/number ranges checks

    Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
