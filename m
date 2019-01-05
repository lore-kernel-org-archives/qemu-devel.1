Received: from eggsout.gnu.org ([209.51.188.92]:52842 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfmJT-0005hQ-E0
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 08:48:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfmJO-00063o-9g
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 08:48:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gfmJK-00062Q-Kt
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 08:48:24 -0500
References: <20190104153951.32306-1-eblake@redhat.com>
	<4e30c442-6ddc-2988-160e-168dec552966@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <758d4c6d-75a3-df55-9128-dad29259da4e@redhat.com>
Date: Sat, 5 Jan 2019 07:48:19 -0600
MIME-Version: 1.0
In-Reply-To: <4e30c442-6ddc-2988-160e-168dec552966@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mKj5g2jzcLp75259p4zE5gpkgsJDaCnXm"
Subject: Re: [Qemu-devel] [RFC PATCH] osdep: Make MIN/MAX evaluate arguments
 only once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mKj5g2jzcLp75259p4zE5gpkgsJDaCnXm
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>,
 qemu-devel@nongnu.org
Message-ID: <758d4c6d-75a3-df55-9128-dad29259da4e@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH] osdep: Make MIN/MAX evaluate arguments
 only once
References: <20190104153951.32306-1-eblake@redhat.com>
 <4e30c442-6ddc-2988-160e-168dec552966@gmail.com>
In-Reply-To: <4e30c442-6ddc-2988-160e-168dec552966@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/4/19 6:23 PM, Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3 wrote:
> Hi,
>=20
> I have a similar patch in my queue[1]
>=20

Sorry for not noticing that thread.


>>  #ifndef MIN
>> -#define MIN(a, b) (((a) < (b)) ? (a) : (b))

The old version is at least named in ALL_CAPS, to warn the user that it
is a macro and may have side effects due to multiple evaluations.

>> +#define MIN(a, b)              \
>> +    ({                         \
>> +        __auto_type _a =3D (a);  \
>> +        __auto_type _b =3D (b);  \
>> +        _a < _b ? _a : _b;     \
>> +    })
>>  #endif


> I tried this[2], but apparently random linux headers define their own
> MIN/MAX and in case this version won't be used.

Indeed; changing

#ifndef MIN

to

#undef MIN

forces us to use our version rather than inheriting something, at which
point...

> And the version above
> with __auto_type and statement expression doesn't work on bitfields and=

> when not in functions (for example struct XHCIState has
>     USBPort  uports[MAX(MAXPORTS_2, MAXPORTS_3)];
> as one of its member).

Yeah, I ran into that on libvirt as well.  It's a real bummer that
__auto_type can't be used in constant expressions; I don't know if C11
generics can be used to come up with an alternative that still qualifies
as a constant expression.

Quoting your other mail:

>> /home/dirty_ice/qemu/include/qemu/osdep.h:240:5: error: =E2=80=98__aut=
o_type=E2=80=99
>> used with a bit-field initializer
>> /home/dirty_ice/qemu/include/qemu/osdep.h:247:35: error: braced-group
>> within expression allowed only inside a function
>>=20
>> The first one is fixable with an explicit cast (ugly but works),

Or by writing:

__auto_type _a =3D (a) + 0;
typeof((a) + 0) _a =3D (a) + 0;

to force type promotion of the bitfield 'a' (no casts needed, either at
the caller or in the macro).  Since we are doing ?: between a and b, we
end up with integer promotion anyways (that is, MIN(char, char) still
results in int, and that's unchanged regardless of naive or smart
implementation of the macro; the only way to get MIN(char, char) to
result in char is with typeof, although I don't see any strong reasons
why making the macro return an unpromoted value would ever be useful).

>> but the
>> second one is more problematic. It means we can't write stuff like
>>=20
>> USBPort  uports[MAX(MAXPORTS_2, MAXPORTS_3)];
>>=20
>> when not in a function. So we either need a dumb version of MIN/MAX, o=
r
>> scrape the idea altogether.

I'm fine keeping the name MIN/MAX for the common use, but we'd need a
second pair, maybe named MIN_CONST/MAX_CONST, for use in contexts that
require a constant (there, both arguments are evaluated twice because it
is the naive implementation, but that is harmless because both arguments
are constant and the macro is then usable in places where the smart
MIN/MAX are not).  I don't know if trying to use __builtin_constant_p in
the const version would also be worthwhile.  In fact, if
__builtin_constant_p is powerful enough, perhaps we could use it to
force a single macro to expand to the naive version if both arguments
are constant and the smart version otherwise.  I'll give that a shot.

> It only works because currently glib/gmacros.h or
> sys/param.h defines it's own MIN/MAX which is identical to the old vers=
ion.
>=20
> Now that I think about it, instead of undefining the old macro or only
> conditionally defining it, maybe the best course of action would be to
> rename MIN/MAX to something more unique so it won't clash with random
> system headers.

No, if we want smart MIN/MAX, we merely undefine whatever random junk
got inherited from the system.  If we rename anything, it should be the
constant version for use where the smart version is semantically prohibit=
ed.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--mKj5g2jzcLp75259p4zE5gpkgsJDaCnXm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlwwtaMACgkQ3g5py3or
ov1pbgf/W70lMcWcB6Eo+m756NcrFsTJ4vdPU41tqbVmgBKBMp7OPQQs5ePy1uG5
OcX0NufDGVVjrj8LmHU8mTvTn3cO+8WkXBuyn4GbaT4KqhoXehroQILTxYI/1qjt
7zF9c8qDEgHFs9ct/Jt9vHCX6sENccHGBumcZ+tZ3AzIZLS1wEr2zknk+F6hHmDS
tTlJ63FRtp9Wc20ThQMKJYAqIGzb0QhGEQWu4mcuJR//Pp86q50qwwB6fhB8Ca/N
NDXJXass4mR8qwbDHcAuTNuhymV/YPTQe5AD2/V7jRrMvxTiaspnDDU3ZKVNfHDS
IGHYf3hVX8zP/ZHVH1NfUqmbbogHSA==
=5LoP
-----END PGP SIGNATURE-----

--mKj5g2jzcLp75259p4zE5gpkgsJDaCnXm--
