Received: from eggs.gnu.org ([2001:4830:134:3::10]:49248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dSmoY-0005Lx-0j
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:06:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dSmoW-0004U8-TG
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:06:06 -0400
From: Max Reitz <mreitz@redhat.com>
References: <20170703122505.32017-1-mreitz@redhat.com>
	<20170703122505.32017-3-mreitz@redhat.com>
	<87r2xve509.fsf@dusky.pond.sub.org>
	<98cccb52-4fca-2625-5f69-30c348962377@redhat.com>
Message-ID: <5067e305-39fe-3590-4a7c-0f0136d8e5b1@redhat.com>
Date: Wed, 5 Jul 2017 18:05:52 +0200
MIME-Version: 1.0
In-Reply-To: <98cccb52-4fca-2625-5f69-30c348962377@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ebObc6uPWbhuM9b5SsvxTptSATo9CF6Rl"
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
--ebObc6uPWbhuM9b5SsvxTptSATo9CF6Rl
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <5067e305-39fe-3590-4a7c-0f0136d8e5b1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/5] qapi: Add qobject_is_equal()
References: <20170703122505.32017-1-mreitz@redhat.com>
 <20170703122505.32017-3-mreitz@redhat.com>
 <87r2xve509.fsf@dusky.pond.sub.org>
 <98cccb52-4fca-2625-5f69-30c348962377@redhat.com>
In-Reply-To: <98cccb52-4fca-2625-5f69-30c348962377@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-05 15:48, Max Reitz wrote:
> On 2017-07-05 09:07, Markus Armbruster wrote:
>> Max Reitz <mreitz@redhat.com> writes:
>>
>>> This generic function (along with its implementations for different
>>> types) determines whether two QObjects are equal.
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> [...]
>>> diff --git a/qobject/qnum.c b/qobject/qnum.c
>>> index 476e81c..784d061 100644
>>> --- a/qobject/qnum.c
>>> +++ b/qobject/qnum.c
>>> @@ -213,6 +213,59 @@ QNum *qobject_to_qnum(const QObject *obj)
>>>  }
>>> =20
>>>  /**
>>> + * qnum_is_equal(): Test whether the two QNums are equal
>>> + */
>>> +bool qnum_is_equal(const QObject *x, const QObject *y)
>>> +{
>>> +    QNum *num_x =3D qobject_to_qnum(x);
>>> +    QNum *num_y =3D qobject_to_qnum(y);
>>> +
>>> +    switch (num_x->kind) {
>>> +    case QNUM_I64:
>>> +        switch (num_y->kind) {
>>> +        case QNUM_I64:
>>> +            /* Comparison in native int64_t type */
>>> +            return num_x->u.i64 =3D=3D num_y->u.i64;
>>> +        case QNUM_U64:
>>> +            /* Implicit conversion of x to uin64_t, so we have to
>>> +             * check its sign before */
>>> +            return num_x->u.i64 >=3D 0 && num_x->u.i64 =3D=3D num_y-=
>u.u64;
>>> +        case QNUM_DOUBLE:
>>> +            /* Implicit conversion of x to double; no overflow
>>> +             * possible */
>>> +            return num_x->u.i64 =3D=3D num_y->u.dbl;
>>
>> Overflow is impossible, but loss of precision is possible:
>>
>>     (double)9007199254740993ull =3D=3D 9007199254740992.0
>>
>> yields true.  Is this what we want?
>=20
> I'd argue that yes, because the floating point value represents
> basically all of the values which are "equal" to it.
>=20
> But I don't have a string opinion. I guess the alternative would be to
> convert the double to an integer instead and check for overflows before=
?
>=20
>>> +        }
>>> +        abort();
>>> +    case QNUM_U64:
>>> +        switch (num_y->kind) {
>>> +        case QNUM_I64:
>>> +            return qnum_is_equal(y, x);
>>> +        case QNUM_U64:
>>> +            /* Comparison in native uint64_t type */
>>> +            return num_x->u.u64 =3D=3D num_y->u.u64;
>>> +        case QNUM_DOUBLE:
>>> +            /* Implicit conversion of x to double; no overflow
>>> +             * possible */
>>> +            return num_x->u.u64 =3D=3D num_y->u.dbl;
>>
>> Similar loss of precision.
>>
>>> +        }
>>> +        abort();
>>> +    case QNUM_DOUBLE:
>>> +        switch (num_y->kind) {
>>> +        case QNUM_I64:
>>> +            return qnum_is_equal(y, x);
>>> +        case QNUM_U64:
>>> +            return qnum_is_equal(y, x);
>>> +        case QNUM_DOUBLE:
>>> +            /* Comparison in native double type */
>>> +            return num_x->u.dbl =3D=3D num_y->u.dbl;
>>> +        }
>>> +        abort();
>>> +    }
>>> +
>>> +    abort();
>>> +}
>>
>> I think there's more than one sane interpretations of "is equal",
>> including:
>>
>> * The mathematical numbers represented by @x and @y are equal.
>>
>> * @x and @y have the same contents, i.e. same kind and u.
>>
>> * @x and @y are the same object (listed for completeness; we don't nee=
d
>>   a function to compare pointers).
>>
>> Your patch implements yet another one.  Which one do we want, and why?=

>=20
> Mine is the first one, except that I think that a floating point value
> does not represent a single number but just some number in a range.
>=20
>> The second is easier to implement than the first.
>=20
> It seems much less useful, though.
>=20
>> If we really want the first, you need to fix the loss of precision bug=
s.
>=20
> I'm not sure, but I don't mind either, so...
>=20
>> I guess the obvious fix is
>>
>>     return (double)x =3D=3D x && x =3D=3D y;
>=20
> Yes, that would do, too; and spares me of having to think about how wel=
l
> comparing an arbitrary double to UINT64_MAX actually works. :-)

On second thought, this won't do, because (double)x =3D=3D x is always tr=
ue
if x is an integer (because this will implicitly cast the second x to a
double, too). However, (uint64_t)(double)x =3D=3D x should work.

Max

>=20
>> Note that this is what you do for mixed signedness: first check @x is
>> exactly representable in @y's type, then compare in @y's type.
>>
>> Regardless of which one we pick, the function comment needs to explain=
=2E
>=20
> OK, will do.
>=20
> Max
>=20
>>> +
>>> +/**
>>>   * qnum_destroy_obj(): Free all memory allocated by a
>>>   * QNum object
>>>   */
>> [...]
>>
>> Remainder of the patch looks good to me.
>>
>=20
>=20



--ebObc6uPWbhuM9b5SsvxTptSATo9CF6Rl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZXQ5gEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQK/w
B/9nsCDxY33gtiiRslg7HsQMA99LhiMHcX1/tXQFeH3zDWf2ucOxLyMqWwJ+LOli
OSNdUz9GmgIIqvDH/UYLATmC7+sJJMYotwtDa0Pb30qRKwP51urGuo1o4Nw/V73b
Kho13DrsySAISNjeTcjU1FGA/uDBS7AMsBSKmnuaNmsZ8E3cZRUan5Aciph+050y
GTlgieaYT9lEEmYidl1DwLNkx3jMHUTGAs7D1ajfiekSB3ob4ks4S9n/B/KISZeg
3/WIHiyPtlRALFHwv0VyiximiWToh4tPMKciEyAZDixJ0UwwnVwgMB2KIvXSM8VV
h3FeQ8UcOeMc3lD1iqVD/HtM
=jmy8
-----END PGP SIGNATURE-----

--ebObc6uPWbhuM9b5SsvxTptSATo9CF6Rl--
