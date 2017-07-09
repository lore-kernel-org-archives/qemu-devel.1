Received: from eggs.gnu.org ([2001:4830:134:3::10]:45641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUFr6-0002aq-30
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 13:18:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUFr4-0004aU-Gu
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 13:18:48 -0400
References: <20170705190404.22449-1-mreitz@redhat.com>
	<20170705190404.22449-6-mreitz@redhat.com>
	<6c9acef7-aa25-d5da-50b7-d527bd51a52f@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <989126f2-5ea3-7631-f847-5d5675168f06@redhat.com>
Date: Sun, 9 Jul 2017 19:18:36 +0200
MIME-Version: 1.0
In-Reply-To: <6c9acef7-aa25-d5da-50b7-d527bd51a52f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eQQt7sAhG9iI9ALr1D39nkw4ji6NEEkee"
Subject: Re: [Qemu-devel] [PATCH v4 5/5] tests: Add check-qobject for
 equality tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eQQt7sAhG9iI9ALr1D39nkw4ji6NEEkee
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <989126f2-5ea3-7631-f847-5d5675168f06@redhat.com>
Subject: Re: [PATCH v4 5/5] tests: Add check-qobject for equality tests
References: <20170705190404.22449-1-mreitz@redhat.com>
 <20170705190404.22449-6-mreitz@redhat.com>
 <6c9acef7-aa25-d5da-50b7-d527bd51a52f@redhat.com>
In-Reply-To: <6c9acef7-aa25-d5da-50b7-d527bd51a52f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-05 22:05, Eric Blake wrote:
> On 07/05/2017 02:04 PM, Max Reitz wrote:
>> Add a new test file (check-qobject.c) for unit tests that concern
>> QObjects as a whole.
>>
>> Its only purpose for now is to test the qobject_is_equal() function.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/Makefile.include |   4 +-
>>  qobject/qnum.c         |  16 +-
>>  tests/check-qobject.c  | 404 ++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  3 files changed, 417 insertions(+), 7 deletions(-)
>>  create mode 100644 tests/check-qobject.c
>>
>=20
>> +++ b/qobject/qnum.c
>> @@ -217,12 +217,16 @@ QNum *qobject_to_qnum(const QObject *obj)
>>  /**
>>   * qnum_is_equal(): Test whether the two QNums are equal
>>   *
>> - * Negative integers are never considered equal to unsigned integers.=

>> - * Doubles are only considered equal to integers if their fractional
>> - * part is zero and their integral part is exactly equal to the
>> - * integer.  Because doubles have limited precision, there are
>> - * therefore integers which do not have an equal double (e.g.
>> - * INT64_MAX).
>> + * This comparison is done independently of the internal
>> + * representation.  Any two numbers are considered equal if they are
>> + * mathmatically equal, that means:
>=20
> s/mathmatically/mathematically/
>=20
>> + * - Negative integers are never considered equal to unsigned
>> + *   integers.
>> + * - Floating point values are only considered equal to integers if
>> + *   their fractional part is zero and their integral part is exactly=

>> + *   equal to the integer.  Because doubles have limited precision,
>> + *   there are therefore integers which do not have an equal floating=

>> + *   point value (e.g. INT64_MAX).
>>   */
>=20
>> +static void qobject_is_equal_num_test(void)
>> +{
>> +    QNum *u0, *i0, *d0, *d0p25, *dnan, *um42, *im42, *dm42;
>=20
> Given my comments on 2/5, do you want a dinf?

If you give me an idea on what to do with them other to compare that one
infinite float equals another, sure.  I wouldn't know how which integers
to compare them against, though.

>=20
>> +    QNum *umax, *imax, *umax_exact, *umax_exact_p1;
>> +    QNum *dumax, *dimax, *dumax_exact, *dumax_exact_p1;
>> +    QString *s0, *s_empty;
>> +    QBool *bfalse;
>> +
>> +    u0 =3D qnum_from_uint(0u);
>> +    i0 =3D qnum_from_int(0);
>> +    d0 =3D qnum_from_double(0.0);
>> +    d0p25 =3D qnum_from_double(0.25);
>> +    dnan =3D qnum_from_double(0.0 / 0.0);
>=20
> Are there compilers that complain if we open-code division by zero
> instead of using NAN from <math.h> (similarly, if you test infinity, I'=
d
> use the INFINITY macro instead of an open-coded computation)

Hm, true, it may trap, right? Well, why not use NAN then, sure.

>> +    um42 =3D qnum_from_uint((uint64_t)-42);
>> +    im42 =3D qnum_from_int(-42);
>> +    dm42 =3D qnum_from_int(-42.0);
>> +
>> +    /* 2^64 - 1: Not exactly representable as a double (needs 64 bits=

>> +     * of precision, but double only has 53).  The double equivalent
>> +     * may be either 2^64 or 2^64 - 2^11. */
>> +    umax =3D qnum_from_uint(UINT64_MAX);
>> +
>> +    /* 2^63 - 1: Not exactly representable as a double (needs 63 bits=

>> +     * of precision, but double only has 53).  The double equivalent
>> +     * may be either 2^63 or 2^63 - 2^10. */
>> +    imax =3D qnum_from_int(INT64_MAX);
>> +    /* 2^64 - 2^11: Exactly representable as a double (the least
>> +     * significant 11 bits are set to 0, so we only need the 53 bits
>> +     * of precision double offers).  This is the maximum value which
>> +     * is exactly representable both as a uint64_t and a double. */
>> +    umax_exact =3D qnum_from_uint(UINT64_MAX - 0x7ff);
>> +
>> +    /* 2^64 - 2^11 + 1: Not exactly representable as a double (needs
>> +     * 64 bits again), but whereas (double)UINT64_MAX may be rounded
>> +     * up to 2^64, this will most likely be rounded down to
>> +     * 2^64 - 2^11. */
>> +    umax_exact_p1 =3D qnum_from_uint(UINT64_MAX - 0x7ff + 1);
>=20
> Nice.
>=20
>> +
>> +    dumax =3D qnum_from_double((double)qnum_get_uint(umax));
>> +    dimax =3D qnum_from_double((double)qnum_get_int(imax));
>> +    dumax_exact =3D qnum_from_double((double)qnum_get_uint(umax_exact=
));
>> +    dumax_exact_p1 =3D qnum_from_double((double)qnum_get_uint(umax_ex=
act_p1));
>=20
> Compiler-dependent what values (some) of these doubles hold.

Yep.

>> +
>> +    s0 =3D qstring_from_str("0");
>> +    s_empty =3D qstring_new();
>> +    bfalse =3D qbool_from_bool(false);
>> +
>> +    /* The internal representation should not matter, as long as the
>> +     * precision is sufficient */
>> +    test_equality(true, u0, i0, d0);
>> +
>> +    /* No automatic type conversion */
>> +    test_equality(false, u0, s0, s_empty, bfalse, qnull(), NULL);
>> +    test_equality(false, i0, s0, s_empty, bfalse, qnull(), NULL);
>> +    test_equality(false, d0, s0, s_empty, bfalse, qnull(), NULL);
>> +
>> +    /* Do not round */
>> +    test_equality(false, u0, d0p25);
>> +    test_equality(false, i0, d0p25);
>> +
>> +    /* Do not assume any object is equal to itself -- note however
>> +     * that NaN cannot occur in a JSON object anyway. */
>> +    g_assert(qobject_is_equal(QOBJECT(dnan), QOBJECT(dnan)) =3D=3D fa=
lse);
>=20
> If you test infinity, that also cannot occur in JSON objects.
>=20
>> +
>> +    /* No unsigned overflow */
>> +    test_equality(false, um42, im42);
>> +    test_equality(false, um42, dm42);
>> +    test_equality(true, im42, dm42);
>> +
>> +
>> +    /*
>> +     * Floating point values must match integers exactly to be
>> +     * considered equal; it does not suffice that converting the
>> +     * integer to a double yields the same value.
>> +     * Each of the following four tests follows the same pattern:
>> +     * 1. Check that both QNum objects compare unequal because they
>> +     *    are (mathematically).  The third test is an exception,
>> +     *    because here they are indeed equal.
>> +     * 2. Check that when converting the integer QNum to a double,
>> +     *    that value is equal to the double QNum.  We can thus see
>> +     *    that the QNum comparison does not simply convert the
>> +     *    integer to a floating point value (in a potentially lossy
>> +     *    operation).
>> +     * 3. Sanity checks: Check that the double QNum has the expected
>> +     *    value (which may be one of two in case it was rounded; the
>> +     *    exact result is then implementation-defined).
>> +     *    If there are multiple valid values, check that they are
>> +     *    distinct values when represented as double (just proving
>> +     *    that our assumptions about the precision of doubles are
>> +     *    correct).
>> +     *
>> +     * The first two tests are interesting because they may involve a=

>> +     * double value which is out of the uint64_t or int64_t range,
>> +     * respectively (if it is rounded to 2^64 or 2^63 during
>> +     * conversion).
>> +     *
>> +     * Since both are intended to involve rounding the value up durin=
g
>> +     * conversion, we also have the fourth test which is indended to
>=20
> s/indended/intended/
>=20
>> +     * test behavior if the value was rounded down. This is the fourt=
h
>> +     * test.
>> +     *
>> +     * The third test simply proves that the value used in the fourth=

>> +     * test is indeed just one above a number that can be exactly
>> +     * represented in a double.
>> +     */
>> +
>> +    test_equality(false, umax, dumax);
>> +    g_assert(qnum_get_double(umax) =3D=3D qnum_get_double(dumax));
>> +    g_assert(qnum_get_double(dumax) =3D=3D 0x1p64 ||
>> +             qnum_get_double(dumax) =3D=3D 0x1p64 - 0x1p11);
>> +    g_assert(0x1p64 !=3D 0x1p64 - 0x1p11);
>> +
>> +    test_equality(false, imax, dimax);
>> +    g_assert(qnum_get_double(imax) =3D=3D qnum_get_double(dimax));
>> +    g_assert(qnum_get_double(dimax) =3D=3D 0x1p63 ||
>> +             qnum_get_double(dimax) =3D=3D 0x1p63 - 0x1p10);
>> +    g_assert(0x1p63 !=3D 0x1p63 - 0x1p10);
>> +
>> +    test_equality(true, umax_exact, dumax_exact);
>> +    g_assert(qnum_get_double(umax_exact) =3D=3D qnum_get_double(dumax=
_exact));
>> +    g_assert(qnum_get_double(dumax_exact) =3D=3D 0x1p64 - 0x1p11);
>> +
>> +    test_equality(false, umax_exact_p1, dumax_exact_p1);
>> +    g_assert(qnum_get_double(umax_exact_p1) =3D=3D qnum_get_double(du=
max_exact_p1));
>> +    g_assert(qnum_get_double(dumax_exact_p1) =3D=3D 0x1p64 ||
>> +             qnum_get_double(dumax_exact_p1) =3D=3D 0x1p64 - 0x1p11);=

>> +    g_assert(0x1p64 !=3D 0x1p64 - 0x1p11);
>=20
> Okay, and you catered to the indeterminate nature of the compiler
> rounding pointed out earlier in the creation of the various doubles.
>=20
> So all-in-all, you may want to add tests for infinity (given the
> undefined nature of casting infinity to integer and any impact to commi=
t
> 2/5), but what you have looks good:
> Reviewed-by: Eric Blake <eblake@redhat.com>

Adding infinity sounds good, but I wouldn't know what tests to do with
it...   So unless I come up with something, I'll at least make the test
use NAN and fix the spelling issues.

Thanks!

Max


--eQQt7sAhG9iI9ALr1D39nkw4ji6NEEkee
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZYmVsEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQD8i
CADCSeEubU0Th2oRFRM1WWBYX8C1WGGsKMLm/2ig5xmMhXeSkk1ZWOFHkrBqSLcp
Jb4iZax1Ph3O7PavY6zy4jjvPWoYam4Okbk1KLml3BcH9GJVUSawK+wosS4is/9n
iMz1u5t23JFRLST0uctQ19usB7h/SeOO/ThI/fKKN0QyBNq1NAiRxnVt9UtWnPxJ
tJUr5PfnpHyvQIY/ktDVcxdjdOhgIqtiLVz22haijGuqdo7yYfsHk75k1jBB6JGW
X3uQcrp9eo6obzoFF1+RqleSOG1KlgJx3BbQwVKSYosLp9fW2nwXcNPx09ZPGYwD
O5PPnaZ1sBLwPcJ3Y4aocH7x
=zx/R
-----END PGP SIGNATURE-----

--eQQt7sAhG9iI9ALr1D39nkw4ji6NEEkee--
