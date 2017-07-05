Received: from eggs.gnu.org ([2001:4830:134:3::10]:55461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dSn50-0006mh-Hn
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:23:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dSn4z-0004PI-Dp
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:23:06 -0400
From: Max Reitz <mreitz@redhat.com>
References: <20170703122505.32017-1-mreitz@redhat.com>
	<20170703122505.32017-3-mreitz@redhat.com>
	<87r2xve509.fsf@dusky.pond.sub.org>
	<98cccb52-4fca-2625-5f69-30c348962377@redhat.com>
	<5067e305-39fe-3590-4a7c-0f0136d8e5b1@redhat.com>
Message-ID: <e21524cb-a199-fa6e-11f6-8b445a1633db@redhat.com>
Date: Wed, 5 Jul 2017 18:22:55 +0200
MIME-Version: 1.0
In-Reply-To: <5067e305-39fe-3590-4a7c-0f0136d8e5b1@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fsdtqEqGuD5Svpt5UTscRmNI9hrCqSN8W"
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
--fsdtqEqGuD5Svpt5UTscRmNI9hrCqSN8W
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <e21524cb-a199-fa6e-11f6-8b445a1633db@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/5] qapi: Add qobject_is_equal()
References: <20170703122505.32017-1-mreitz@redhat.com>
 <20170703122505.32017-3-mreitz@redhat.com>
 <87r2xve509.fsf@dusky.pond.sub.org>
 <98cccb52-4fca-2625-5f69-30c348962377@redhat.com>
 <5067e305-39fe-3590-4a7c-0f0136d8e5b1@redhat.com>
In-Reply-To: <5067e305-39fe-3590-4a7c-0f0136d8e5b1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-05 18:05, Max Reitz wrote:
> On 2017-07-05 15:48, Max Reitz wrote:
>> On 2017-07-05 09:07, Markus Armbruster wrote:
>>> Max Reitz <mreitz@redhat.com> writes:
>>>
>>>> This generic function (along with its implementations for different
>>>> types) determines whether two QObjects are equal.
>>>>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> [...]
>>>> diff --git a/qobject/qnum.c b/qobject/qnum.c
>>>> index 476e81c..784d061 100644
>>>> --- a/qobject/qnum.c
>>>> +++ b/qobject/qnum.c
>>>> @@ -213,6 +213,59 @@ QNum *qobject_to_qnum(const QObject *obj)
>>>>  }
>>>> =20
>>>>  /**
>>>> + * qnum_is_equal(): Test whether the two QNums are equal
>>>> + */
>>>> +bool qnum_is_equal(const QObject *x, const QObject *y)
>>>> +{
>>>> +    QNum *num_x =3D qobject_to_qnum(x);
>>>> +    QNum *num_y =3D qobject_to_qnum(y);
>>>> +
>>>> +    switch (num_x->kind) {
>>>> +    case QNUM_I64:
>>>> +        switch (num_y->kind) {
>>>> +        case QNUM_I64:
>>>> +            /* Comparison in native int64_t type */
>>>> +            return num_x->u.i64 =3D=3D num_y->u.i64;
>>>> +        case QNUM_U64:
>>>> +            /* Implicit conversion of x to uin64_t, so we have to
>>>> +             * check its sign before */
>>>> +            return num_x->u.i64 >=3D 0 && num_x->u.i64 =3D=3D num_y=
->u.u64;
>>>> +        case QNUM_DOUBLE:
>>>> +            /* Implicit conversion of x to double; no overflow
>>>> +             * possible */
>>>> +            return num_x->u.i64 =3D=3D num_y->u.dbl;
>>>
>>> Overflow is impossible, but loss of precision is possible:
>>>
>>>     (double)9007199254740993ull =3D=3D 9007199254740992.0
>>>
>>> yields true.  Is this what we want?
>>
>> I'd argue that yes, because the floating point value represents
>> basically all of the values which are "equal" to it.
>>
>> But I don't have a string opinion. I guess the alternative would be to=

>> convert the double to an integer instead and check for overflows befor=
e?
>>
>>>> +        }
>>>> +        abort();
>>>> +    case QNUM_U64:
>>>> +        switch (num_y->kind) {
>>>> +        case QNUM_I64:
>>>> +            return qnum_is_equal(y, x);
>>>> +        case QNUM_U64:
>>>> +            /* Comparison in native uint64_t type */
>>>> +            return num_x->u.u64 =3D=3D num_y->u.u64;
>>>> +        case QNUM_DOUBLE:
>>>> +            /* Implicit conversion of x to double; no overflow
>>>> +             * possible */
>>>> +            return num_x->u.u64 =3D=3D num_y->u.dbl;
>>>
>>> Similar loss of precision.
>>>
>>>> +        }
>>>> +        abort();
>>>> +    case QNUM_DOUBLE:
>>>> +        switch (num_y->kind) {
>>>> +        case QNUM_I64:
>>>> +            return qnum_is_equal(y, x);
>>>> +        case QNUM_U64:
>>>> +            return qnum_is_equal(y, x);
>>>> +        case QNUM_DOUBLE:
>>>> +            /* Comparison in native double type */
>>>> +            return num_x->u.dbl =3D=3D num_y->u.dbl;
>>>> +        }
>>>> +        abort();
>>>> +    }
>>>> +
>>>> +    abort();
>>>> +}
>>>
>>> I think there's more than one sane interpretations of "is equal",
>>> including:
>>>
>>> * The mathematical numbers represented by @x and @y are equal.
>>>
>>> * @x and @y have the same contents, i.e. same kind and u.
>>>
>>> * @x and @y are the same object (listed for completeness; we don't ne=
ed
>>>   a function to compare pointers).
>>>
>>> Your patch implements yet another one.  Which one do we want, and why=
?
>>
>> Mine is the first one, except that I think that a floating point value=

>> does not represent a single number but just some number in a range.
>>
>>> The second is easier to implement than the first.
>>
>> It seems much less useful, though.
>>
>>> If we really want the first, you need to fix the loss of precision bu=
gs.
>>
>> I'm not sure, but I don't mind either, so...
>>
>>> I guess the obvious fix is
>>>
>>>     return (double)x =3D=3D x && x =3D=3D y;
>>
>> Yes, that would do, too; and spares me of having to think about how we=
ll
>> comparing an arbitrary double to UINT64_MAX actually works. :-)
>=20
> On second thought, this won't do, because (double)x =3D=3D x is always =
true
> if x is an integer (because this will implicitly cast the second x to a=

> double, too). However, (uint64_t)(double)x =3D=3D x should work.

Hm, well, the nice thing with this is that (double)UINT64_MAX is
actually UINT64_MAX + 1, and now (uint64_t)(UINT64_MAX + 1) is
undefined... Urgs.

So I guess one thing that isn't very obvious but that should *always*
work (and is always well-defined) is this:

For uint64_t: y < 0x1p64 && (uint64_t)y =3D=3D x

For int64_t: y >=3D -0x1p63 && y < 0x1p63 && (int64_t)y =3D=3D x

I hope. :-/

(But finally a chance to use binary exponents! Yay!)

Max


--fsdtqEqGuD5Svpt5UTscRmNI9hrCqSN8W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZXRJfEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQGj4
B/4jGskmkiNiDwVzayIuyH/Ug/D3JvFtk1HSsQmyJxCtFYWb1puedswx8CJNka8D
wYYZqIzrRDHfnoGkmlgWXN/jzzx7BmILqFjZt0JG49Wr7bBJlp+AgPglyS+vE/9C
cietJzuiAfYcaKvRcUICfFfKglH4JD6wpz5wsAdsgGWElQqUT5O4JwbYejEuGcZw
vPhRd+rGEgVsw9rsIQfDn+nNV9PAFUQUZLXuj1BX3GEHBzs6srY8/50WkrRLhCGb
WGDkj70b6gSR58C8uH5yx9kheB+xH5KlF7XUh0GN3cdOMYpnYzi+H4iOUIMRK6L2
77Xb5WvdU0jhZXY/a8oAjJRT
=RAkB
-----END PGP SIGNATURE-----

--fsdtqEqGuD5Svpt5UTscRmNI9hrCqSN8W--
