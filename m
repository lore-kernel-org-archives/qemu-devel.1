Received: from eggs.gnu.org ([209.51.188.92]:53024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLZVW-0002ST-74
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLZK1-0005cU-OJ
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:25:50 -0400
References: <cover.1556650594.git.alistair.francis@wdc.com>
	<81a342ee886cf0f63cdbfc8573b14dd2d41de42d.1556650594.git.alistair.francis@wdc.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c95d2923-45b2-9acf-9cc6-aa4b9e102e48@redhat.com>
Date: Tue, 30 Apr 2019 15:25:42 -0500
MIME-Version: 1.0
In-Reply-To: <81a342ee886cf0f63cdbfc8573b14dd2d41de42d.1556650594.git.alistair.francis@wdc.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vwUTT9KnyvxvWWJtIqBsVFwUDYzqyS7Kk"
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "laurent@vivier.eu" <laurent@vivier.eu>, "kraxel@redhat.com" <kraxel@redhat.com>, "alistair23@gmail.com" <alistair23@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vwUTT9KnyvxvWWJtIqBsVFwUDYzqyS7Kk
From: Eric Blake <eblake@redhat.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>
Message-ID: <c95d2923-45b2-9acf-9cc6-aa4b9e102e48@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 1/5] util/qemu-sockets: Fix GCC 9 build
 warnings
References: <cover.1556650594.git.alistair.francis@wdc.com>
 <81a342ee886cf0f63cdbfc8573b14dd2d41de42d.1556650594.git.alistair.francis@wdc.com>
In-Reply-To: <81a342ee886cf0f63cdbfc8573b14dd2d41de42d.1556650594.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/30/19 3:08 PM, Alistair Francis wrote:
> Fix this warning when building with GCC9 on Fedora 30:
> In function =E2=80=98strncpy=E2=80=99,
>     inlined from =E2=80=98unix_connect_saddr.isra.0=E2=80=99 at util/qe=
mu-sockets.c:925:5:
> /usr/include/bits/string_fortified.h:106:10: error: =E2=80=98__builtin_=
strncpy=E2=80=99 specified bound 108 equals destination size [-Werror=3Ds=
tringop-truncation]
>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (=
__dest));
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
> In function =E2=80=98strncpy=E2=80=99,
>     inlined from =E2=80=98unix_listen_saddr.isra.0=E2=80=99 at util/qem=
u-sockets.c:880:5:
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  util/qemu-sockets.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index 9705051690..4322652428 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -877,7 +877,7 @@ static int unix_listen_saddr(UnixSocketAddress *sad=
dr,
> =20
>      memset(&un, 0, sizeof(un));
>      un.sun_family =3D AF_UNIX;
> -    strncpy(un.sun_path, path, sizeof(un.sun_path));
> +    strncpy(un.sun_path, path, sizeof(un.sun_path) - 1);

NACK. Linux allows you to use the full width of un.sun_path (a NUL
terminator is required if you copy less than that, but not if you use
the full width). Rather, we may need to mark path as a potential
nonstring to silence the warning, or use memcpy instead of strncpy, or
some other workaround.  (Sadly, this is one of those odd places where
strncpy is actually the right function to use, but there are so many
other places where strncpy is used incorrectly that it has turned into a
battle to use it here)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--vwUTT9KnyvxvWWJtIqBsVFwUDYzqyS7Kk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzIr0cACgkQp6FrSiUn
Q2qhfAf6A4XRQzZYPJPr+0k1Qi6GF9T/qwSr5w10n2GyZ3ZGSAWHdr4Qt/Le3x3h
PeW5oEgFiKYJFF1I0TZV4Ul1+XVvhljrflVoTxfOHqfUVMwDwaz6rSzOweiIcuhJ
JFsIzJOZRQO+EY7Eus8v2JEs994yviqOjf+ZzxMQogztwtw4EywjLR/KWgLaTCKO
sDO7zUZG/YWqqzyrLiL5SgWVA6BPYHcEKPkNCTWA7Pnsf8e//KB2c+MSi0CNAJMJ
LLqcjOPG2ABR9mUU/tvZFiZBAZ0m+yPC+gtgg36bBt4DlsLGDig2+82dHvBjCaM/
H7p+HiuZdz8cZ/UJqF9UrrzNwDH9UQ==
=kYAw
-----END PGP SIGNATURE-----

--vwUTT9KnyvxvWWJtIqBsVFwUDYzqyS7Kk--
