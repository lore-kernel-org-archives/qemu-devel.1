Received: from eggs.gnu.org ([2001:4830:134:3::10]:48751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSl5P-0008VG-KP
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSl5O-0005nl-KA
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:15:23 -0400
References: <20170703122505.32017-1-mreitz@redhat.com>
	<20170703122505.32017-3-mreitz@redhat.com>
	<87r2xve509.fsf@dusky.pond.sub.org>
	<98cccb52-4fca-2625-5f69-30c348962377@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7e9bdf55-c11d-e7cd-d92b-5ccef7e48d3c@redhat.com>
Date: Wed, 5 Jul 2017 09:15:09 -0500
MIME-Version: 1.0
In-Reply-To: <98cccb52-4fca-2625-5f69-30c348962377@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wwrOvVrvTKWEUTX2qJoaDD23I0A6mSACB"
Subject: Re: [Qemu-devel] [PATCH v3 2/5] qapi: Add qobject_is_equal()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wwrOvVrvTKWEUTX2qJoaDD23I0A6mSACB
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <7e9bdf55-c11d-e7cd-d92b-5ccef7e48d3c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/5] qapi: Add qobject_is_equal()
References: <20170703122505.32017-1-mreitz@redhat.com>
 <20170703122505.32017-3-mreitz@redhat.com>
 <87r2xve509.fsf@dusky.pond.sub.org>
 <98cccb52-4fca-2625-5f69-30c348962377@redhat.com>
In-Reply-To: <98cccb52-4fca-2625-5f69-30c348962377@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/05/2017 08:48 AM, Max Reitz wrote:
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

But the problem is that we CAN represent the fully-precise number as an
integer, so having multiple distinct integers that compare differently
against each other, but equal to the same double, is awkward.

>=20
> But I don't have a string opinion. I guess the alternative would be to
> convert the double to an integer instead and check for overflows before=
?

That's the solution Markus gave, and I'm in favor of the tighter check:

>=20
>> I guess the obvious fix is
>>
>>     return (double)x =3D=3D x && x =3D=3D y;
>=20
> Yes, that would do, too; and spares me of having to think about how wel=
l
> comparing an arbitrary double to UINT64_MAX actually works. :-)

It basically says that we are unwilling to declare an integer equivalent
to the double if the double loses precision when trying to store the
integer.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wwrOvVrvTKWEUTX2qJoaDD23I0A6mSACB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZXPRtAAoJEKeha0olJ0Nq40AH/jGyRxRQeVUJjoMvNjtAK0db
7n5odUS0G2UE/zP6gIv9/7LxHk5pVNOrKmjCo3A8fGIflyMPXKpOI8amRkgS4JAq
TW4IBeRhsVG5mkvgLc5lz07kaKhH77C0PbkOY4D1bFXjXPWclMvKaaKYL+TZIIRb
D0UHZPP8TLAGK6Fka0sSGTNcVWn2b2tOrWR016YKSsIqYeReESZDF9NgDTdy4cfl
NcsYkLhUheHfxst3dhjPQpsOilyLhqwVpuBKzHboD5P0VFA1j4lZ1uI2mQ4Cncjo
j0xyiwsnRK9GWvSC4E9qhRDzAaZcQJ/0/0bMqCLU33SCq5+noaleuG5pK8p/hZ0=
=9h4R
-----END PGP SIGNATURE-----

--wwrOvVrvTKWEUTX2qJoaDD23I0A6mSACB--
