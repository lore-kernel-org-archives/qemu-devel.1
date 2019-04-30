Received: from eggs.gnu.org ([209.51.188.92]:34213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLa6q-0002JH-Vl
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:16:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLa6p-0001Tn-VR
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:16:16 -0400
References: <cover.1556650594.git.alistair.francis@wdc.com>
	<81a342ee886cf0f63cdbfc8573b14dd2d41de42d.1556650594.git.alistair.francis@wdc.com>
	<c95d2923-45b2-9acf-9cc6-aa4b9e102e48@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4f41ed2c-b49b-e1f5-e9a3-ad08e16ac77e@redhat.com>
Date: Tue, 30 Apr 2019 16:16:09 -0500
MIME-Version: 1.0
In-Reply-To: <c95d2923-45b2-9acf-9cc6-aa4b9e102e48@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Z9jDQZOMUGE2BvnCeYiC0foZSvyV0Yu1q"
Subject: Re: [Qemu-devel] [PATCH v1 1/5] util/qemu-sockets: Fix GCC 9 build
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, "alistair23@gmail.com" <alistair23@gmail.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "laurent@vivier.eu" <laurent@vivier.eu>, "kraxel@redhat.com" <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Z9jDQZOMUGE2BvnCeYiC0foZSvyV0Yu1q
From: Eric Blake <eblake@redhat.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "kraxel@redhat.com" <kraxel@redhat.com>
Message-ID: <4f41ed2c-b49b-e1f5-e9a3-ad08e16ac77e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 1/5] util/qemu-sockets: Fix GCC 9 build
 warnings
References: <cover.1556650594.git.alistair.francis@wdc.com>
 <81a342ee886cf0f63cdbfc8573b14dd2d41de42d.1556650594.git.alistair.francis@wdc.com>
 <c95d2923-45b2-9acf-9cc6-aa4b9e102e48@redhat.com>
In-Reply-To: <c95d2923-45b2-9acf-9cc6-aa4b9e102e48@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/30/19 3:25 PM, Eric Blake wrote:
> On 4/30/19 3:08 PM, Alistair Francis wrote:
>> Fix this warning when building with GCC9 on Fedora 30:
>> In function =E2=80=98strncpy=E2=80=99,
>>     inlined from =E2=80=98unix_connect_saddr.isra.0=E2=80=99 at util/q=
emu-sockets.c:925:5:
>> /usr/include/bits/string_fortified.h:106:10: error: =E2=80=98__builtin=
_strncpy=E2=80=99 specified bound 108 equals destination size [-Werror=3D=
stringop-truncation]
>>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos =
(__dest));
>>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~
>> In function =E2=80=98strncpy=E2=80=99,
>>     inlined from =E2=80=98unix_listen_saddr.isra.0=E2=80=99 at util/qe=
mu-sockets.c:880:5:
>>

>> -    strncpy(un.sun_path, path, sizeof(un.sun_path));
>> +    strncpy(un.sun_path, path, sizeof(un.sun_path) - 1);
>=20
> NACK. Linux allows you to use the full width of un.sun_path (a NUL
> terminator is required if you copy less than that, but not if you use
> the full width). Rather, we may need to mark path as a potential
> nonstring to silence the warning, or use memcpy instead of strncpy, or
> some other workaround.  (Sadly, this is one of those odd places where
> strncpy is actually the right function to use, but there are so many
> other places where strncpy is used incorrectly that it has turned into =
a
> battle to use it here)

We don't have control over un (that's from the libc system headers), but
does adding the QEMU_NONSTRING attribute to our declaration of path
serve to silence the warning?

In short, I think most of this series should look at the use of the
QEMU_NONSTRING macro, as that macro goes hand-in-hand with strncpy() for
informing the compiler exactly when we know that we are copying
something that has fixed length and may or may not be NUL-terminated.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Z9jDQZOMUGE2BvnCeYiC0foZSvyV0Yu1q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzIuxoACgkQp6FrSiUn
Q2rWYQf/Q4nYmkou+dWU9DitVGpgy/cXjq2lQfcCPrHHhI3HsnQpNuqFPiEPgqVt
/b52B62d72jqs2jGZatT54ahC7qxpTi22dgXwSwYLGtZ8KGXkPeUzNgXpDlxzRoS
96PaaAC0zFK19vJLubKpGmD8Nj3ogRQqX1RwzZRnpYCAqReISKWIf32fUe0c6L6H
ABnKdXzMcR2/AH8ezzBGc7IwnQ5vyv8a+yWgXqM8IRnx8ZsN0+WD0FmQJ0g7Cw9x
+1Z1oyr0sz/USn4+lF8pvu7NHRngm7ZRK91wd4gvQC8CPy+/conrkXsaSi2/ZLku
+w3d+MX9m09auTsxDTmKzpRMe0YmQA==
=pYPr
-----END PGP SIGNATURE-----

--Z9jDQZOMUGE2BvnCeYiC0foZSvyV0Yu1q--
