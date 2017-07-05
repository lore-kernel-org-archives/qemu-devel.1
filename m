Received: from eggs.gnu.org ([2001:4830:134:3::10]:42043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dSkg0-0007NK-OI
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:49:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dSkfz-0000hA-Ms
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:49:08 -0400
References: <20170703122505.32017-1-mreitz@redhat.com>
	<20170703122505.32017-3-mreitz@redhat.com>
	<87r2xve509.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <98cccb52-4fca-2625-5f69-30c348962377@redhat.com>
Date: Wed, 5 Jul 2017 15:48:53 +0200
MIME-Version: 1.0
In-Reply-To: <87r2xve509.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="i3HEqbS87ogv1uoCEo1UGG3xltB2Ecfxe"
Subject: Re: [Qemu-devel] [PATCH v3 2/5] qapi: Add qobject_is_equal()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i3HEqbS87ogv1uoCEo1UGG3xltB2Ecfxe
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <98cccb52-4fca-2625-5f69-30c348962377@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/5] qapi: Add qobject_is_equal()
References: <20170703122505.32017-1-mreitz@redhat.com>
 <20170703122505.32017-3-mreitz@redhat.com>
 <87r2xve509.fsf@dusky.pond.sub.org>
In-Reply-To: <87r2xve509.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-05 09:07, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> This generic function (along with its implementations for different
>> types) determines whether two QObjects are equal.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
> [...]
>> diff --git a/qobject/qnum.c b/qobject/qnum.c
>> index 476e81c..784d061 100644
>> --- a/qobject/qnum.c
>> +++ b/qobject/qnum.c
>> @@ -213,6 +213,59 @@ QNum *qobject_to_qnum(const QObject *obj)
>>  }
>> =20
>>  /**
>> + * qnum_is_equal(): Test whether the two QNums are equal
>> + */
>> +bool qnum_is_equal(const QObject *x, const QObject *y)
>> +{
>> +    QNum *num_x =3D qobject_to_qnum(x);
>> +    QNum *num_y =3D qobject_to_qnum(y);
>> +
>> +    switch (num_x->kind) {
>> +    case QNUM_I64:
>> +        switch (num_y->kind) {
>> +        case QNUM_I64:
>> +            /* Comparison in native int64_t type */
>> +            return num_x->u.i64 =3D=3D num_y->u.i64;
>> +        case QNUM_U64:
>> +            /* Implicit conversion of x to uin64_t, so we have to
>> +             * check its sign before */
>> +            return num_x->u.i64 >=3D 0 && num_x->u.i64 =3D=3D num_y->=
u.u64;
>> +        case QNUM_DOUBLE:
>> +            /* Implicit conversion of x to double; no overflow
>> +             * possible */
>> +            return num_x->u.i64 =3D=3D num_y->u.dbl;
>=20
> Overflow is impossible, but loss of precision is possible:
>=20
>     (double)9007199254740993ull =3D=3D 9007199254740992.0
>=20
> yields true.  Is this what we want?

I'd argue that yes, because the floating point value represents
basically all of the values which are "equal" to it.

But I don't have a string opinion. I guess the alternative would be to
convert the double to an integer instead and check for overflows before?

>> +        }
>> +        abort();
>> +    case QNUM_U64:
>> +        switch (num_y->kind) {
>> +        case QNUM_I64:
>> +            return qnum_is_equal(y, x);
>> +        case QNUM_U64:
>> +            /* Comparison in native uint64_t type */
>> +            return num_x->u.u64 =3D=3D num_y->u.u64;
>> +        case QNUM_DOUBLE:
>> +            /* Implicit conversion of x to double; no overflow
>> +             * possible */
>> +            return num_x->u.u64 =3D=3D num_y->u.dbl;
>=20
> Similar loss of precision.
>=20
>> +        }
>> +        abort();
>> +    case QNUM_DOUBLE:
>> +        switch (num_y->kind) {
>> +        case QNUM_I64:
>> +            return qnum_is_equal(y, x);
>> +        case QNUM_U64:
>> +            return qnum_is_equal(y, x);
>> +        case QNUM_DOUBLE:
>> +            /* Comparison in native double type */
>> +            return num_x->u.dbl =3D=3D num_y->u.dbl;
>> +        }
>> +        abort();
>> +    }
>> +
>> +    abort();
>> +}
>=20
> I think there's more than one sane interpretations of "is equal",
> including:
>=20
> * The mathematical numbers represented by @x and @y are equal.
>=20
> * @x and @y have the same contents, i.e. same kind and u.
>=20
> * @x and @y are the same object (listed for completeness; we don't need=

>   a function to compare pointers).
>=20
> Your patch implements yet another one.  Which one do we want, and why?

Mine is the first one, except that I think that a floating point value
does not represent a single number but just some number in a range.

> The second is easier to implement than the first.

It seems much less useful, though.

> If we really want the first, you need to fix the loss of precision bugs=
=2E

I'm not sure, but I don't mind either, so...

> I guess the obvious fix is
>=20
>     return (double)x =3D=3D x && x =3D=3D y;

Yes, that would do, too; and spares me of having to think about how well
comparing an arbitrary double to UINT64_MAX actually works. :-)

> Note that this is what you do for mixed signedness: first check @x is
> exactly representable in @y's type, then compare in @y's type.
>=20
> Regardless of which one we pick, the function comment needs to explain.=


OK, will do.

Max

>> +
>> +/**
>>   * qnum_destroy_obj(): Free all memory allocated by a
>>   * QNum object
>>   */
> [...]
>=20
> Remainder of the patch looks good to me.
>=20



--i3HEqbS87ogv1uoCEo1UGG3xltB2Ecfxe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZXO5FEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQJmr
B/9bYrRHKHs9DqBzKtvK1EAqLynlVOb2Vgu+VCNGAhY+ob4R2oz+fEGt1NPl9/sa
QPs615ewpyHkiGAXkIWhIg9ZCS0OSYnO7um1GeAWqdUiSEkwy6n8H8Mxcz+PD0gu
brwyI4F1+sZ/a/zZBP1wWRMafO0jApVEIdf3KU5iyE6nntH7JHS3DP/EwB4mBIBh
fygh4eEKAD3r2iJy/2L3eLtfASD2RQcVvY5V791yunrEz+lZR+eipnGSVs3oh8+J
zdelFdViO+Dljb+G7LbOddARbQBtc+2JvvPkFojf3Qj/l4M0d8wHhWr0rDT0xWfg
oMtmOgfhK0Gq5tn63tfCTjQ+
=oopK
-----END PGP SIGNATURE-----

--i3HEqbS87ogv1uoCEo1UGG3xltB2Ecfxe--
