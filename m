Received: from eggs.gnu.org ([2001:4830:134:3::10]:38371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dSnix-0000P2-2E
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dSniw-0006Nh-59
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:04:23 -0400
From: Max Reitz <mreitz@redhat.com>
References: <20170703122505.32017-1-mreitz@redhat.com>
	<20170703122505.32017-3-mreitz@redhat.com>
	<87r2xve509.fsf@dusky.pond.sub.org>
	<98cccb52-4fca-2625-5f69-30c348962377@redhat.com>
	<5067e305-39fe-3590-4a7c-0f0136d8e5b1@redhat.com>
	<e21524cb-a199-fa6e-11f6-8b445a1633db@redhat.com>
	<33f5a5f9-0a58-6b86-d3e1-2bee632a8493@redhat.com>
	<fabe727c-7024-9f4b-99b3-fecb5da26acf@redhat.com>
Message-ID: <986a4919-937e-3668-d94e-f71981992e87@redhat.com>
Date: Wed, 5 Jul 2017 19:04:11 +0200
MIME-Version: 1.0
In-Reply-To: <fabe727c-7024-9f4b-99b3-fecb5da26acf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Chh8ghpLOS5IXCR7LriWIbSJe4kf6LtWN"
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
--Chh8ghpLOS5IXCR7LriWIbSJe4kf6LtWN
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <986a4919-937e-3668-d94e-f71981992e87@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/5] qapi: Add qobject_is_equal()
References: <20170703122505.32017-1-mreitz@redhat.com>
 <20170703122505.32017-3-mreitz@redhat.com>
 <87r2xve509.fsf@dusky.pond.sub.org>
 <98cccb52-4fca-2625-5f69-30c348962377@redhat.com>
 <5067e305-39fe-3590-4a7c-0f0136d8e5b1@redhat.com>
 <e21524cb-a199-fa6e-11f6-8b445a1633db@redhat.com>
 <33f5a5f9-0a58-6b86-d3e1-2bee632a8493@redhat.com>
 <fabe727c-7024-9f4b-99b3-fecb5da26acf@redhat.com>
In-Reply-To: <fabe727c-7024-9f4b-99b3-fecb5da26acf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-05 19:00, Max Reitz wrote:
> On 2017-07-05 18:29, Eric Blake wrote:
>> On 07/05/2017 11:22 AM, Max Reitz wrote:
>>
>>>>>>     return (double)x =3D=3D x && x =3D=3D y;
>>>>>
>>>>> Yes, that would do, too; and spares me of having to think about how=
 well
>>>>> comparing an arbitrary double to UINT64_MAX actually works. :-)
>>>>
>>>> On second thought, this won't do, because (double)x =3D=3D x is alwa=
ys true
>>>> if x is an integer (because this will implicitly cast the second x t=
o a
>>>> double, too). However, (uint64_t)(double)x =3D=3D x should work.
>>>
>>> Hm, well, the nice thing with this is that (double)UINT64_MAX is
>>> actually UINT64_MAX + 1, and now (uint64_t)(UINT64_MAX + 1) is
>>> undefined... Urgs.
>>
>> (uint64_t)(UINT64_MAX + 1) is well-defined - it is 0.
>>
>> (Adding in unsigned integers is always well-defined - it wraps around =
on
>> mathematical overflow modulo the integer size.  You're thinking of
>> overflow addition on signed integers, which is indeed undefined)
>=20
> It's not. See the standard:

Or, well, yes, it is in this case, but I meant literally UINT64_MAX + 1,
not the uint64_t value. I meant the natural number 2^64.

Because the issue is that (double)UINT64_MAX will (or may, depending on
the environment and such) give us 2.0^64 =3D=3D 0x1p64.

And this is where the quotation I gave below comes in. When casting an
integer to a double we may end up with a value that is not representable
in the original integer type, so we cannot easily cast it back.

Max

> When a finite value of real floating type is converted to an integer
> type other than _Bool, the fractional part is discarded (i.e., the valu=
e
> is truncated toward zero). If the value of the integral part cannot be
> represented by the integer type, the behavior is undefined. [61]
>=20
> [61] The remaindering operation performed when a value of integer type
> is converted to unsigned type need not be performed when a value of rea=
l
> floating type is converted to unsigned type. Thus, the range of portabl=
e
> real floating values is (=E2=88=921, Utype_MAX+1).
>=20
> See for yourself:
>=20
> printf("%i\n", (uint64_t)(double)UINT64_MAX =3D=3D UINT64_MAX);
>=20
> This yields 1 with gcc and -O3.
>=20
>>>
>>> So I guess one thing that isn't very obvious but that should *always*=

>>> work (and is always well-defined) is this:
>>>
>>> For uint64_t: y < 0x1p64 && (uint64_t)y =3D=3D x
>>>
>>> For int64_t: y >=3D -0x1p63 && y < 0x1p63 && (int64_t)y =3D=3D x
>>
>> That's harder to read, compared to the double-cast method which is
>> well-defined after all.
>>
>>>
>>> I hope. :-/
>>>
>>> (But finally a chance to use binary exponents! Yay!)
>>
>> Justifying the use of binary exponents is going to be harder than that=
,
>> and would need a really good comment in the code, compared to just usi=
ng
>> a safe double-cast.
>=20
> It's not safe.
>=20
> Max
>=20



--Chh8ghpLOS5IXCR7LriWIbSJe4kf6LtWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZXRwLEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQKwP
B/9Cb7VD1g36guGu/CnYOiuklwXj2CAJ+Z9U3Ywa4UGV39WLv4jI81vjIHLWi9xX
sdpQ79/aj/1cso4TluZWOOOUlRcn67WRceM8twMgRL4DQNtmsDcExAPiWWojJBzx
RNyS8OhF5F1TyCykDMzqlCZZs6hK8MzgJaE6bzleOloaBPxUNpB5vAw+xPNjgH6+
FIdrm2g7i+Tk26H4oV5ku3noFpD+wjYkUXEDWbUiX4X8rATyEKlV84cEkWiekkxC
ncd59MPweoIntjfQJXDsE21YbwQ7NaiBYapdDnkS37W+JdqGOKxOJhwNZ61eAxyk
M2ihUNjj6JdHeWo1K+vluuZs
=+9UU
-----END PGP SIGNATURE-----

--Chh8ghpLOS5IXCR7LriWIbSJe4kf6LtWN--
