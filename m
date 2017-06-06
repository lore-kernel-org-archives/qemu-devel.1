Received: from eggs.gnu.org ([2001:4830:134:3::10]:60534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIJqH-0007g1-I9
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 15:08:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIJqE-0004Jp-Dy
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 15:08:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dIJqE-0004JR-5f
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 15:08:34 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
	<20170531135709.345-9-marcandre.lureau@redhat.com>
	<87o9u7re8c.fsf@dusky.pond.sub.org>
	<CAJ+F1CKve9_W2q4CvBnbHdoyrie6rjNub1q0Nds9MGrcOGpZ_Q@mail.gmail.com>
Date: Tue, 06 Jun 2017 21:08:31 +0200
In-Reply-To: <CAJ+F1CKve9_W2q4CvBnbHdoyrie6rjNub1q0Nds9MGrcOGpZ_Q@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 06 Jun 2017
	16:14:39 +0000")
Message-ID: <87d1ahexxs.fsf@dusky.pond.sub.org>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Thu, Jun 1, 2017 at 6:10 PM Markus Armbruster <armbru@redhat.com> wrot=
e:
>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > Suggested by Markus Armbruster:
>> >
>> > We should systematically cover the integers, in particular the
>> > boundaries (because that's where bugs like to hide):
>> >
>> > * Integers in [-2^63,0) can be visited with visit_type_int() and
>> >   visit_type_number().
>> >
>> > * Integers in [0,2^63) can be visited with visit_type_int(),
>> >   visit_type_uint64() and visit_type_number().
>> >
>> > * Integers in [2^63,2^64) can be visited with visit_type_uint64() and
>> >   visit_type_number().
>> >
>> > * Integers outside [-2^63,2^53) can be visited with visit_type_number(=
).
>> >
>> > In any case, visit_type_number() loses precision beyond 53 bits.
>> >
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
[...]
>> > @@ -260,6 +272,26 @@ static void test_visitor_in_number(TestInputVisit=
orData *data,
>> >      g_assert_cmpfloat(res, =3D=3D, value);
>> >  }
>> >
>> > +static void test_visitor_in_large_number(TestInputVisitorData *data,
>> > +                                         const void *unused)
>> > +{
>> > +    Error *err =3D NULL;
>> > +    double res =3D 0;
>> > +    int64_t i64;
>> > +    uint64_t u64;
>> > +    Visitor *v;
>> > +
>> > +    v =3D visitor_input_test_init(data, "-18446744073709551616"); /* =
-2^64 */
>> > +
>> > +    visit_type_number(v, NULL, &res, &error_abort);
>>
>> Shouldn't we check res has the expected value?
>>
>>
> Is the precision loss during conversion  going to be the same on all arch=
s?

Yes.  Precision is 53 bits on all hosts that matter, because double is
IEEE 754 / IEC 60559 double precision on all hosts that matter.

For pedantic portability, you may guard with #ifdef __STDC_IEC_559__.
ISO/IEC 9899 =C2=A76.8.10 Predefined macro names:

       __STDC_IEC_559__ The   integer   constant   1,  intended  to
                indicate conformance to the specifications in annex
                F (IEC 60559 floating-point arithmetic).

Annex F (normative) section F.2 Types:

         -- The double type matches the IEC 60559 double format.

I wouldn't bother.
