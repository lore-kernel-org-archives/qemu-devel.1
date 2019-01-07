Received: from eggs.gnu.org ([209.51.188.92]:60794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ggVup-0005gb-RA
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:30:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ggVuo-0003zl-SW
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:30:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ggVuo-0003zT-Ke
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:30:06 -0500
References: <20190106013802.3645-1-eblake@redhat.com>
	<20190107094927.GA2442@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <96a72fff-a7ab-ca0f-2d1b-5efdc0a9868e@redhat.com>
Date: Mon, 7 Jan 2019 08:24:50 -0600
MIME-Version: 1.0
In-Reply-To: <20190107094927.GA2442@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TQHwJaO80xFCINUGGcy1zO6m7Vsaxgp6y"
Subject: Re: [Qemu-devel] [PATCH v2] osdep: Make MIN/MAX evaluate arguments
 only once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, dirty.ice.hu@gmail.com, f4bug@amsat.org, Gerd Hoffmann <kraxel@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TQHwJaO80xFCINUGGcy1zO6m7Vsaxgp6y
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, dirty.ice.hu@gmail.com, f4bug@amsat.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Message-ID: <96a72fff-a7ab-ca0f-2d1b-5efdc0a9868e@redhat.com>
Subject: Re: [PATCH v2] osdep: Make MIN/MAX evaluate arguments only once
References: <20190106013802.3645-1-eblake@redhat.com>
 <20190107094927.GA2442@work-vm>
In-Reply-To: <20190107094927.GA2442@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/7/19 3:49 AM, Dr. David Alan Gilbert wrote:
> * Eric Blake (eblake@redhat.com) wrote:
>> Add the macro QEMU_TYPEOF() to access __auto_type in new enough
>> compilers, while falling back to typeof on older compilers (the
>> fallback doesn't handle variable length arrays, but we don't use
>> those; it also expands to more text).
>>
>> Then use that macro to make MIN/MAX only evaluate their argument
>> once; this uses type promotion (by adding to 0) to work around
>> the fact that typeof(bitfield) won't compile.  However, we are
>> unable to work around gcc refusing to compile ({}) in a constant
>> context, even when only used in the dead branch of a
>> __builtin_choose_expr(),


>> +#undef MIN
>> +#define MIN(a, b)                            \
>> +    ({                                       \
>> +        QEMU_TYPEOF((a) + 0) _a =3D (a) + 0;   \
>> +        QEMU_TYPEOF((b) + 0) _b =3D (b) + 0;   \
>> +        _a < _b ? _a : _b;                   \
>> +    })
>> +#define MIN_CONST(a, b)                                         \
>> +    __builtin_choose_expr(                                      \
>> +        __builtin_constant_p(a) && __builtin_constant_p(b),     \
>> +        (a) < (b) ? (a) : (b),                                  \
>> +        __builtin_unreachable())
>=20
> Why do these need to be separate macros? Can't you just put the=20
> non-constant code in what you have as the 'builtin_unreachable' side of=

> the choose_expr:
>=20
> #define DMIN(a,b) __builtin_choose_expr(                  \
>     __builtin_constant_p(a) && __builtin_constant_p(b),   \
>     (a) < (b) ? (a) : (b),                                \
>     ({                                       \
>         QEMU_TYPEOF((a) + 0) _a =3D (a) + 0;   \
>         QEMU_TYPEOF((b) + 0) _b =3D (b) + 0;   \
>         _a < _b ? _a : _b;                   \
>     }))

Because it doesn't work - gcc treats ({}) as a syntax error inside
constant expressions, even in dead code (although 'info gcc' said that
might change in the future, we can't wait for that change).  I also
tried it as documented here:
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00715.html
hence my mention in the commit message.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--TQHwJaO80xFCINUGGcy1zO6m7Vsaxgp6y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlwzYTIACgkQ3g5py3or
ov2MJQf+KYslyFVCjuC8MXq1CnTK6XzyDe6U6MyYUNTOM5bUdf9UAa0s6VY7qCvM
z5du4BCwKkG2H3ZoAmBok6rRc3+XM6mN6/bou9N9BsjgYEN6HtMqlqi5JOG1bqKu
kXFG9CS/vmcKbR6siAYnolKOfLXRhLrDUgs1KTwVmpG7QKll60CfU6d9hUifmMwa
OLUPymjZBOBk3i1xBxY9gQNhi72nujwshS3U4i6iOw1FjPRO7W6gubTb++XWVzov
z0yoVjG1+TgM5jKVQIP1YDBSK+c9Ic0f14TqMmwnMB3+oDzWt5vfAKLruo0T7vXL
lIn13kpXLqI9fgehk40hypQyUUByuQ==
=u2/s
-----END PGP SIGNATURE-----

--TQHwJaO80xFCINUGGcy1zO6m7Vsaxgp6y--
