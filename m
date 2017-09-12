Received: from eggs.gnu.org ([2001:4830:134:3::10]:56303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drsTH-000832-Br
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:11:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drsTF-0003mK-Tq
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:11:51 -0400
References: <20170912144459.11359-1-pbonzini@redhat.com>
	<20170912144459.11359-5-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7d63b366-37a4-bfbe-790b-9a1ceb0d2893@redhat.com>
Date: Tue, 12 Sep 2017 16:11:42 -0500
MIME-Version: 1.0
In-Reply-To: <20170912144459.11359-5-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Mcm8lEoXGD9SN7ThmrEPf0A2bkLUlkgi7"
Subject: Re: [Qemu-devel] [PATCH 04/10] qemu-iotests: cleanup and fix search
 for programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Mcm8lEoXGD9SN7ThmrEPf0A2bkLUlkgi7
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <7d63b366-37a4-bfbe-790b-9a1ceb0d2893@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/10] qemu-iotests: cleanup and fix search
 for programs
References: <20170912144459.11359-1-pbonzini@redhat.com>
 <20170912144459.11359-5-pbonzini@redhat.com>
In-Reply-To: <20170912144459.11359-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/12/2017 09:44 AM, Paolo Bonzini wrote:
> Instead of ./check failing when a binary is missing, we try each test
> case now and each one fails with tons of test case diffs.  Also, all th=
e
> variables were initialized by "check" prior to "common" being sourced,
> and then (uselessly) checked for emptiness again in "check".
>=20
> Centralize the search for programs in "common" (which will soon be
> one with "check"), including the "realpath" invocation which can be don=
e
> just once in "check" rather than in the tests.
>=20
> For qnio_server, move the detection to "common", simplifying
> set_prog_path to stop handling the unused second argument, and
> embedding the "realpath" pass.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/qemu-iotests/check         | 41 ---------------------
>  tests/qemu-iotests/common        | 77 ++++++++++++++++++++++++++++++++=
+++++---
>  tests/qemu-iotests/common.config | 61 +------------------------------
>  3 files changed, 73 insertions(+), 106 deletions(-)
>=20

> +++ b/tests/qemu-iotests/common
> @@ -37,6 +37,17 @@ _full_platform_details()
>      echo "$os/$platform $host $kernel"
>  }
> =20
> +# $1 =3D prog to look for
> +set_prog_path()
> +{
> +    p=3D`command -v $1 2> /dev/null`

Are we sure that $1 will always respond to -v sanely?

> +    if [ -n "$p" -a -x "$p" ]; then

[ ... -a ... ] should never be used; there are cases where it is
inherently ambiguous (even if it happens to work here, because we know
our shell is bash and because $p is not likely to contain text that
throws off the parser).  Please spell that either:

if [ -n "$p" ] && [ -x "$p" ]; then
if [[ -n $p && -x $p ]]; then

(that is, I don't mind if you rely on bash's [[]] in which case you can
use less typing, but if you stick to [], then you should use code that
can be pasted to other shells)

> +then
> +    if [ -x "$build_iotests/qemu" ]; then
> +        export QEMU_PROG=3D"$build_iotests/qemu"
> +    elif [ -x "$build_root/$arch-softmmu/qemu-system-$arch" ]; then
> +        export QEMU_PROG=3D"$build_root/$arch-softmmu/qemu-system-$arc=
h"
> +    else
> +        pushd "$build_root" > /dev/null

Shouldn't you check for failure to change directories?

> +++ b/tests/qemu-iotests/common.config
> @@ -22,6 +22,7 @@ export LANG=3DC
>  PATH=3D".:$PATH"
> =20
>  HOSTOS=3D`uname -s`
> +arch=3D`uname -m`

As long as we're touching this, should we prefer $() instead of ``?

> =20
>  export PWD=3D`pwd`
> =20
> @@ -30,28 +31,6 @@ export _QEMU_HANDLE=3D0
>  # make sure we have a standard umask
>  umask 022
> =20
> -# $1 =3D prog to look for, $2* =3D default pathnames if not found in $=
PATH
> -set_prog_path()
> -{
> -    p=3D`command -v $1 2> /dev/null`
> -    if [ -n "$p" -a -x "$p" ]; then

Urrgh - your use of [ -a ] was pre-existing, and you just moved it.
Still worth fixing, though (either here or in a separate cleanup patch).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Mcm8lEoXGD9SN7ThmrEPf0A2bkLUlkgi7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm4TY4ACgkQp6FrSiUn
Q2omGQgApcXGey0Cmwdc/3I88X3X3h3t5ckF9z4EFwoUvQ0sqrUH/gugtf3cRLn5
294RVxNxAF0EoHd5SNtz1yyt9yMqxI6jvD3R0NMh+PBZd+0G4dqdqHoQlzHzpVWd
pY2yIlV2ZGmkE1IEjPkBJOLoiUw7H1i5XEQBQO4YRd65gXQh7szXr5SsIWw9FTrZ
RvswnmOjn7t2ZDOOuSCgeUtwMoSp/ISh4Em9FwIAPEbIWcfiurIRWQbHdgNiRkDl
kjs9HEdQUpH5AR+yjh8IHDQMpmqKg4kZ68EZb4d25Hvowy+fgAgcm4/ier78tVxo
lkmS1phablEYKeZbxfvsVcY1yBUfvw==
=2L2Z
-----END PGP SIGNATURE-----

--Mcm8lEoXGD9SN7ThmrEPf0A2bkLUlkgi7--
