Received: from eggs.gnu.org ([2001:4830:134:3::10]:37805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dSnfi-0007ZV-Tj
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:01:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dSnfh-0005Dq-Sv
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:01:03 -0400
References: <20170703122505.32017-1-mreitz@redhat.com>
	<20170703122505.32017-3-mreitz@redhat.com>
	<87r2xve509.fsf@dusky.pond.sub.org>
	<98cccb52-4fca-2625-5f69-30c348962377@redhat.com>
	<5067e305-39fe-3590-4a7c-0f0136d8e5b1@redhat.com>
	<e21524cb-a199-fa6e-11f6-8b445a1633db@redhat.com>
	<33f5a5f9-0a58-6b86-d3e1-2bee632a8493@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <fabe727c-7024-9f4b-99b3-fecb5da26acf@redhat.com>
Date: Wed, 5 Jul 2017 19:00:45 +0200
MIME-Version: 1.0
In-Reply-To: <33f5a5f9-0a58-6b86-d3e1-2bee632a8493@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="k5kWdDk0QDbmpQDWknACp0G28kEOT7M5p"
Subject: Re: [Qemu-devel] [PATCH v3 2/5] qapi: Add qobject_is_equal()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k5kWdDk0QDbmpQDWknACp0G28kEOT7M5p
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <fabe727c-7024-9f4b-99b3-fecb5da26acf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/5] qapi: Add qobject_is_equal()
References: <20170703122505.32017-1-mreitz@redhat.com>
 <20170703122505.32017-3-mreitz@redhat.com>
 <87r2xve509.fsf@dusky.pond.sub.org>
 <98cccb52-4fca-2625-5f69-30c348962377@redhat.com>
 <5067e305-39fe-3590-4a7c-0f0136d8e5b1@redhat.com>
 <e21524cb-a199-fa6e-11f6-8b445a1633db@redhat.com>
 <33f5a5f9-0a58-6b86-d3e1-2bee632a8493@redhat.com>
In-Reply-To: <33f5a5f9-0a58-6b86-d3e1-2bee632a8493@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-05 18:29, Eric Blake wrote:
> On 07/05/2017 11:22 AM, Max Reitz wrote:
>=20
>>>>>     return (double)x =3D=3D x && x =3D=3D y;
>>>>
>>>> Yes, that would do, too; and spares me of having to think about how =
well
>>>> comparing an arbitrary double to UINT64_MAX actually works. :-)
>>>
>>> On second thought, this won't do, because (double)x =3D=3D x is alway=
s true
>>> if x is an integer (because this will implicitly cast the second x to=
 a
>>> double, too). However, (uint64_t)(double)x =3D=3D x should work.
>>
>> Hm, well, the nice thing with this is that (double)UINT64_MAX is
>> actually UINT64_MAX + 1, and now (uint64_t)(UINT64_MAX + 1) is
>> undefined... Urgs.
>=20
> (uint64_t)(UINT64_MAX + 1) is well-defined - it is 0.
>=20
> (Adding in unsigned integers is always well-defined - it wraps around o=
n
> mathematical overflow modulo the integer size.  You're thinking of
> overflow addition on signed integers, which is indeed undefined)

It's not. See the standard:

When a finite value of real floating type is converted to an integer
type other than _Bool, the fractional part is discarded (i.e., the value
is truncated toward zero). If the value of the integral part cannot be
represented by the integer type, the behavior is undefined. [61]

[61] The remaindering operation performed when a value of integer type
is converted to unsigned type need not be performed when a value of real
floating type is converted to unsigned type. Thus, the range of portable
real floating values is (=E2=88=921, Utype_MAX+1).

See for yourself:

printf("%i\n", (uint64_t)(double)UINT64_MAX =3D=3D UINT64_MAX);

This yields 1 with gcc and -O3.

>>
>> So I guess one thing that isn't very obvious but that should *always*
>> work (and is always well-defined) is this:
>>
>> For uint64_t: y < 0x1p64 && (uint64_t)y =3D=3D x
>>
>> For int64_t: y >=3D -0x1p63 && y < 0x1p63 && (int64_t)y =3D=3D x
>=20
> That's harder to read, compared to the double-cast method which is
> well-defined after all.
>=20
>>
>> I hope. :-/
>>
>> (But finally a chance to use binary exponents! Yay!)
>=20
> Justifying the use of binary exponents is going to be harder than that,=

> and would need a really good comment in the code, compared to just usin=
g
> a safe double-cast.

It's not safe.

Max


--k5kWdDk0QDbmpQDWknACp0G28kEOT7M5p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZXRs+EhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQJB5
B/0SLEdCtdJS7MRFSI8BsF1q/XRKoYSLnnFgVJoBbvTHmgwHYwOiz07EnRN/qMyf
RUigxR7REf3h87vTNbUXzZfbPJjgP9q8/1SMjU8dEDoR+oblojWuJF14Ot91uMd4
Z7onouX3yIoSWGzKBOp2XXUxfAp9PiNOpU2+VuZbSXCMOP2am2hAc6BR2be0QovO
2NFo4W+M1XZEJS+DW46sPvTArol5Pqv1NIXT0BRfMeQ7E+r1fBRjI+asL/hYEmFA
dhkVcdxgxwC9wPq8/FKypAFbAe5LITaD9YXcG53oOVyB5KZg4IB20F8bMenYGET5
CxeEFKdsE/PHXHMjZVAtAyF5
=s/ES
-----END PGP SIGNATURE-----

--k5kWdDk0QDbmpQDWknACp0G28kEOT7M5p--
