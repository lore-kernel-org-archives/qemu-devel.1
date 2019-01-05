Received: from eggsout.gnu.org ([209.51.188.92]:36967 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfn22-0001K4-Jo
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 09:34:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfn1x-0003Zh-VG
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 09:34:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gfn1x-0003ZK-KN
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 09:34:29 -0500
References: <20190104153951.32306-1-eblake@redhat.com>
	<4e30c442-6ddc-2988-160e-168dec552966@gmail.com>
	<758d4c6d-75a3-df55-9128-dad29259da4e@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6521a91d-d44f-6116-fd7b-2be7fbac9853@redhat.com>
Date: Sat, 5 Jan 2019 08:34:26 -0600
MIME-Version: 1.0
In-Reply-To: <758d4c6d-75a3-df55-9128-dad29259da4e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="E873hblAXHmSbMfSuiCRaHcBNLU9nNJyJ"
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
--E873hblAXHmSbMfSuiCRaHcBNLU9nNJyJ
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>,
 qemu-devel@nongnu.org
Message-ID: <6521a91d-d44f-6116-fd7b-2be7fbac9853@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH] osdep: Make MIN/MAX evaluate arguments
 only once
References: <20190104153951.32306-1-eblake@redhat.com>
 <4e30c442-6ddc-2988-160e-168dec552966@gmail.com>
 <758d4c6d-75a3-df55-9128-dad29259da4e@redhat.com>
In-Reply-To: <758d4c6d-75a3-df55-9128-dad29259da4e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/5/19 7:48 AM, Eric Blake wrote:

> I'm fine keeping the name MIN/MAX for the common use, but we'd need a
> second pair, maybe named MIN_CONST/MAX_CONST, for use in contexts that
> require a constant (there, both arguments are evaluated twice because i=
t
> is the naive implementation, but that is harmless because both argument=
s
> are constant and the macro is then usable in places where the smart
> MIN/MAX are not).  I don't know if trying to use __builtin_constant_p i=
n
> the const version would also be worthwhile.  In fact, if
> __builtin_constant_p is powerful enough, perhaps we could use it to
> force a single macro to expand to the naive version if both arguments
> are constant and the smart version otherwise.  I'll give that a shot.

Alas, even though __builtin_constant_p can let the compiler overlook
SOME cases of non-constant code (as in __builtin_constant_p(0 && foo())
returning 1), it is not powerful enough to ignore the dead branch:

$ cat foo.c
#define MIN(a, b)                                               \
    (__builtin_constant_p(a) && __builtin_constant_p(b) ?       \
     (a) < (b) ? (a) : (b) :                                    \
     ({                                                         \
         __auto_type _a =3D (a) + 0;                              \
         __auto_type _b =3D (b) + 0;                              \
         _a < _b ? _a : _b;                                     \
     }))

char x[MIN(1, 2)];

int
main(int argc, char **argv)
{
    return MIN(argc, 0);
}
$ gcc -o foo -Wall foo.c
foo.c:4:6: error: braced-group within expression allowed only inside a
function
      ({                                                         \
      ^
foo.c:10:8: note: in expansion of macro =E2=80=98MIN=E2=80=99
 char x[MIN(1, 2)];
        ^~~

If anyone can come up with a workaround for single-macro usage, be my
guest.  Otherwise, I'm going with the two-macro solution, with MIN/MAX
for common use, and MIN_CONST/MAX_CONST for constant-context use.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--E873hblAXHmSbMfSuiCRaHcBNLU9nNJyJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlwwwHIACgkQ3g5py3or
ov1nYAf9G2LjN+ixAYW3u5zsliGX8l+jE+dAJnyLwM5Y+n+Zx1lNpZCPfmznIehi
sx5xHUvkHYz20NCutPkU6H5D/kN8xExLaw94byAFbrpnkxHchGlecY42m0K6ji5K
rIhFVpOp8iCyVj2SJsqr6amYLsWPWz0vO5nDsZV0b5C+mHTt/ATAUGhmEBmkqqT1
frNnYH08IwMUysjodxzsYJ0Qx23o0y1k8dLIxb43TNYziNcqyvpKBLwWgePEsOuf
dslVqaEEz8ya9TXJ4V8j4onGtRzRIZ14wOR1zWJDQykt4MD9Vx0SiUuv67wmMGdo
7tNnu7rPDS2BMFm4E+tU6FDivWJIIA==
=wV9/
-----END PGP SIGNATURE-----

--E873hblAXHmSbMfSuiCRaHcBNLU9nNJyJ--
