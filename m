Received: from eggs.gnu.org ([2001:4830:134:3::10]:46700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dS3z8-00081l-Nd
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:14:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dS3z7-00048V-Lh
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:14:02 -0400
References: <20170703122505.32017-1-mreitz@redhat.com>
	<20170703122505.32017-6-mreitz@redhat.com>
	<78e9f722-b6b8-ed94-cf1e-4760059b077f@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2994bfb3-b442-c6e2-a600-a2644ad2331f@redhat.com>
Date: Mon, 3 Jul 2017 18:13:50 +0200
MIME-Version: 1.0
In-Reply-To: <78e9f722-b6b8-ed94-cf1e-4760059b077f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sVDc8VR4WFek1i0v3G3IqI326dJLSsJNJ"
Subject: Re: [Qemu-devel] [PATCH v3 5/5] tests: Add check-qobject for
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sVDc8VR4WFek1i0v3G3IqI326dJLSsJNJ
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <2994bfb3-b442-c6e2-a600-a2644ad2331f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/5] tests: Add check-qobject for equality
 tests
References: <20170703122505.32017-1-mreitz@redhat.com>
 <20170703122505.32017-6-mreitz@redhat.com>
 <78e9f722-b6b8-ed94-cf1e-4760059b077f@redhat.com>
In-Reply-To: <78e9f722-b6b8-ed94-cf1e-4760059b077f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-03 16:15, Eric Blake wrote:
> On 07/03/2017 07:25 AM, Max Reitz wrote:
>> Add a new test file (check-qobject.c) for unit tests that concern
>> QObjects as a whole.
>>
>> Its only purpose for now is to test the qobject_is_equal() function.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/Makefile.include |   4 +-
>>  tests/check-qobject.c  | 312 ++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  2 files changed, 315 insertions(+), 1 deletion(-)
>>  create mode 100644 tests/check-qobject.c
>>
>=20
>> + * Note that qobject_is_equal() is not really an equivalence relation=
,
>> + * so this function may not be used for all objects (reflexivity is
>> + * not guaranteed).
>=20
> May be worth expanding the comment to mention NaN in QNum as the culpri=
t
> for this fact.

True.

>> +static void do_test_equality(bool expected, ...)
>> +{
>> +    va_list ap_count, ap_extract;
>> +    QObject **args;
>> +    int arg_count =3D 0;
>> +    int i, j;
>> +
>> +    va_start(ap_count, expected);
>> +    va_copy(ap_extract, ap_count);
>> +    while (va_arg(ap_count, QObject *) !=3D &_test_equality_end_of_ar=
guments) {
>=20
> Here, you're careful to allow a NULL argument,
>=20
>=20
>> +static void do_free_all(int _, ...)
>> +{
>> +    va_list ap;
>> +    QObject *obj;
>> +
>> +    va_start(ap, _);
>> +    while ((obj =3D va_arg(ap, QObject *)) !=3D NULL) {
>> +        qobject_decref(obj);
>> +    }
>=20
> Here, you stop on the first NULL, and aren't checking for the special
> sentinel that can't be freed.
>=20
>> +    va_end(ap);
>> +}
>> +
>> +#define free_all(...) \
>> +    do_free_all(0, __VA_ARGS__, NULL)
>=20
> Then again, you don't pass the special sentinel. So as long as NULL is
> the last argument(s) on any test that passes NULL (rather than an
> intermediate argument), you don't need to use the sentinel, and stoppin=
g
> iteration on the first NULL is okay.  A bit magic, but I can live with =
it.

I don't mind using the sentinel here, too, but passing NULL doesn't make
much sense here. It does for test_equality(), though.

>> +
>> +static void qobject_is_equal_null_test(void)
>> +{
>> +    test_equality(false, qnull(), NULL);
>> +}
>=20
> Where do you test_equality(true, NULL, NULL) ?

Automatically in do_test_equality().

(It automatically tests whether all arguments are equal to itself --
which is why I can't use it to test NaN.)

>> +
>> +static void qobject_is_equal_num_test(void)
>> +{
>> +    QNum *u0, *i0, *d0, *d0p25, *dnan, *um42, *im42, *dm42;
>> +    QString *s0, *s_empty;
>> +    QBool *bfalse;
>> +
>> +    u0 =3D qnum_from_uint(0u);
>> +    i0 =3D qnum_from_int(0);
>> +    d0 =3D qnum_from_double(0.0);
>> +    d0p25 =3D qnum_from_double(0.25);
>> +    dnan =3D qnum_from_double(0.0 / 0.0);
>=20
> Ah, so you ARE testing NaN as a QNum, even though it can't occur in
> JSON.  Might be worth a comment.

Sure, why not.

>> +
>> +    /* Containing an NaN value will make this dict compare unequal to=

>=20
> s/an/a/ (if you pronounce it "nan" or "not-a-number") (but I guess no
> change if you pronounce it "en-a-en")

I pronounce it en-a-en, but I don't know whether that's the usual way. ;-=
)

> There might be some improvements to add, but as written the test is
> reasonable, and some testing is better than none, so:
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

Max


--sVDc8VR4WFek1i0v3G3IqI326dJLSsJNJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZWm0+EhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQAG6
CACVaXSJigtHsHs7NasiZSl+Ny40EpcqWjiDtcKYeLBqqPEpXWrrlM209Y9RSkds
1ADjvHJIATSkQLrMPISEsDdM8s3FdZXDzm8rBic4Ff1rSJpYeVL599DA+eRZby+Z
LWq1fVd/uqA2YxxXaYqzpWYVmiG0BgzZXbGntawtDx1GZa4mzR4hggcVDoa0Xmgu
K0ESEPjFYqgKmjlkVEmbIQxC2FeiKOFasIFnjRYYBV3xu3aUMfoatazxKBxnVuUN
pEYglJBzJdBtgIxFM4tDV10BRF8NwWdedUgRWhW3MzaVyN7WOG4MhsPakBk31CYP
tBYGOrLZlFsXjo++6Mj++EBz
=aZJG
-----END PGP SIGNATURE-----

--sVDc8VR4WFek1i0v3G3IqI326dJLSsJNJ--
