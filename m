Received: from eggs.gnu.org ([2001:4830:134:3::10]:41344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dIH88-0001cA-Uc
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:14:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dIH87-0005Uw-Cx
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:14:52 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:35408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dIH87-0005Ui-0j
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:14:51 -0400
Received: by mail-lf0-x241.google.com with SMTP id v20so9225401lfa.2
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 09:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
	<20170531135709.345-9-marcandre.lureau@redhat.com>
	<87o9u7re8c.fsf@dusky.pond.sub.org>
In-Reply-To: <87o9u7re8c.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 06 Jun 2017 16:14:39 +0000
Message-ID: <CAJ+F1CKve9_W2q4CvBnbHdoyrie6rjNub1q0Nds9MGrcOGpZ_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

Hi

On Thu, Jun 1, 2017 at 6:10 PM Markus Armbruster <armbru@redhat.com> wrote:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Suggested by Markus Armbruster:
> >
> > We should systematically cover the integers, in particular the
> > boundaries (because that's where bugs like to hide):
> >
> > * Integers in [-2^63,0) can be visited with visit_type_int() and
> >   visit_type_number().
> >
> > * Integers in [0,2^63) can be visited with visit_type_int(),
> >   visit_type_uint64() and visit_type_number().
> >
> > * Integers in [2^63,2^64) can be visited with visit_type_uint64() and
> >   visit_type_number().
> >
> > * Integers outside [-2^63,2^53) can be visited with visit_type_number()=
.
> >
> > In any case, visit_type_number() loses precision beyond 53 bits.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  tests/test-qobject-input-visitor.c | 38
> ++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 36 insertions(+), 2 deletions(-)
> >
> > diff --git a/tests/test-qobject-input-visitor.c
> b/tests/test-qobject-input-visitor.c
> > index 83d663d11d..f2ed3161af 100644
> > --- a/tests/test-qobject-input-visitor.c
> > +++ b/tests/test-qobject-input-visitor.c
> > @@ -102,11 +102,11 @@ static Visitor
> *visitor_input_test_init_raw(TestInputVisitorData *data,
> >  {
> >      return visitor_input_test_init_internal(data, false, json_string,
> NULL);
> >  }
> > -
>
> Whoops.
>
> >  static void test_visitor_in_int(TestInputVisitorData *data,
> >                                  const void *unused)
> >  {
> >      int64_t res =3D 0;
> > +    double dbl;
> >      int value =3D -42;
> >      Visitor *v;
> >
> > @@ -114,6 +114,9 @@ static void test_visitor_in_int(TestInputVisitorDat=
a
> *data,
> >
> >      visit_type_int(v, NULL, &res, &error_abort);
> >      g_assert_cmpint(res, =3D=3D, value);
> > +
> > +    visit_type_number(v, NULL, &dbl, &error_abort);
> > +    g_assert_cmpfloat(dbl, =3D=3D, -42.0);
> >  }
> >
> >  static void test_visitor_in_uint(TestInputVisitorData *data,
> > @@ -121,6 +124,8 @@ static void
> test_visitor_in_uint(TestInputVisitorData *data,
> >  {
> >      Error *err =3D NULL;
> >      uint64_t res =3D 0;
> > +    int64_t i64;
> > +    double dbl;
> >      int value =3D 42;
> >      Visitor *v;
> >
> > @@ -129,8 +134,13 @@ static void
> test_visitor_in_uint(TestInputVisitorData *data,
> >      visit_type_uint64(v, NULL, &res, &error_abort);
> >      g_assert_cmpuint(res, =3D=3D, (uint64_t)value);
> >
> > -    /* BUG: value between INT64_MIN and -1 accepted modulo 2^64 */
> > +    visit_type_int(v, NULL, &i64, &error_abort);
> > +    g_assert_cmpint(i64, =3D=3D, value);
> >
> > +    visit_type_number(v, NULL, &dbl, &error_abort);
> > +    g_assert_cmpfloat(dbl, =3D=3D, value);
> > +
> > +    /* BUG: value between INT64_MIN and -1 accepted modulo 2^64 */
> >      v =3D visitor_input_test_init(data, "%d", -value);
> >
> >      visit_type_uint64(v, NULL, &res, &error_abort);
> > @@ -142,6 +152,8 @@ static void
> test_visitor_in_uint(TestInputVisitorData *data,
> >
> >      visit_type_uint64(v, NULL, &res, &err);
> >      error_free_or_abort(&err);
> > +
> > +    visit_type_number(v, NULL, &dbl, &error_abort);
> >  }
> >
> >  static void test_visitor_in_int_overflow(TestInputVisitorData *data,
> > @@ -260,6 +272,26 @@ static void
> test_visitor_in_number(TestInputVisitorData *data,
> >      g_assert_cmpfloat(res, =3D=3D, value);
> >  }
> >
> > +static void test_visitor_in_large_number(TestInputVisitorData *data,
> > +                                         const void *unused)
> > +{
> > +    Error *err =3D NULL;
> > +    double res =3D 0;
> > +    int64_t i64;
> > +    uint64_t u64;
> > +    Visitor *v;
> > +
> > +    v =3D visitor_input_test_init(data, "-18446744073709551616"); /*
> -2^64 */
> > +
> > +    visit_type_number(v, NULL, &res, &error_abort);
>
> Shouldn't we check res has the expected value?
>
>
Is the precision loss during conversion  going to be the same on all archs?
--=20
Marc-Andr=C3=A9 Lureau
