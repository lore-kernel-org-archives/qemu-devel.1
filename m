Received: from eggs.gnu.org ([2001:4830:134:3::10]:58585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciTQa-0005b6-7Y
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:05:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciTQY-00029n-TT
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:05:56 -0500
Date: Mon, 27 Feb 2017 17:24:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170227062401.GX17615@umbus.fritz.box>
References: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
	<89c541d2bd6259c237900c3918ca0a3cfccccb90.1487829585.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1X1uH+Y+uHyMJls4"
Content-Disposition: inline
In-Reply-To: <89c541d2bd6259c237900c3918ca0a3cfccccb90.1487829585.git.sam.bobroff@au1.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 02/12]
 scripts/update-linux-headers.sh: refactor extra files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, sjitindarsingh@gmail.com


--1X1uH+Y+uHyMJls4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2017 at 04:59:55PM +1100, Sam Bobroff wrote:
> Refactor the architecture specific code to make it easier
> to add new special case files.
>=20
> There should be no change in functionality.
>=20
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> v2:
>=20
> I've factored the script to make it easier to add new files.
>=20
>  scripts/update-linux-headers.sh | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
>=20
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-heade=
rs.sh
> index ef11a8ab42..c75c30da1b 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -76,28 +76,25 @@ for arch in $ARCHLIST; do
>      fi
> =20
>      make -C "$linux" INSTALL_HDR_PATH=3D"$tmpdir" ARCH=3D$arch headers_i=
nstall
> +    ARCH_EXTRA=3D
> +    ARCH_STD_EXTRA=3D
> +    case "$arch" in
> +        powerpc) ARCH_EXTRA=3Depapr_hcalls.h ;;
> +        s390) ARCH_STD_EXTRA=3D"kvm_virtio.h virtio-ccw.h" ;;
> +        x86) ARCH_EXTRA=3D"unistd_32.h unistd_x32.h unistd_64.h" ARCH_ST=
D_EXTRA=3D"hyperv.h" ;;
> +    esac
> =20
>      rm -rf "$output/linux-headers/asm-$arch"
>      mkdir -p "$output/linux-headers/asm-$arch"
> -    for header in kvm.h kvm_para.h unistd.h; do
> +    for header in kvm.h kvm_para.h unistd.h $ARCH_EXTRA; do
>          cp "$tmpdir/include/asm/$header" "$output/linux-headers/asm-$arc=
h"
>      done
> -    if [ $arch =3D powerpc ]; then
> -        cp "$tmpdir/include/asm/epapr_hcalls.h" "$output/linux-headers/a=
sm-powerpc/"
> -    fi
> =20
>      rm -rf "$output/include/standard-headers/asm-$arch"
>      mkdir -p "$output/include/standard-headers/asm-$arch"
> -    if [ $arch =3D s390 ]; then
> -        cp_portable "$tmpdir/include/asm/kvm_virtio.h" "$output/include/=
standard-headers/asm-s390/"
> -        cp_portable "$tmpdir/include/asm/virtio-ccw.h" "$output/include/=
standard-headers/asm-s390/"
> -    fi
> -    if [ $arch =3D x86 ]; then
> -        cp_portable "$tmpdir/include/asm/hyperv.h" "$output/include/stan=
dard-headers/asm-x86/"
> -        cp "$tmpdir/include/asm/unistd_32.h" "$output/linux-headers/asm-=
x86/"
> -        cp "$tmpdir/include/asm/unistd_x32.h" "$output/linux-headers/asm=
-x86/"
> -        cp "$tmpdir/include/asm/unistd_64.h" "$output/linux-headers/asm-=
x86/"
> -    fi
> +    for header in $ARCH_STD_EXTRA; do
> +        cp_portable "$tmpdir/include/asm/$header" "$output/include/stand=
ard-headers/asm-$arch/"
> +    done
>  done
> =20
>  rm -rf "$output/linux-headers/linux"

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1X1uH+Y+uHyMJls4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYs8YBAAoJEGw4ysog2bOSWNQQAKgqWNObRwdakCosnFVU5qhl
AdivALWVUDpbjlIVZvdf9nL0dtfd4rBdEFpUs0FYiL7nw4K+Vccd862rP6QGjQwi
CpS7g1C6tzXRLFfDWFGBubWtdhlOU0j3VtoqnZ/Vdc85B+UyYrI4lu2ywrQvnuAC
wMhR5ZPlnOtca5mB0E/b96f15KB6wFOQWa17jQTfU8cv6pPISL4QGh6k0eMky+q9
mUsG17Nt/60Z+rPNsjny+NtTyMUepo12runHlpbP5WPFnFovrmjuUTaiX1QmOxmn
LxAaMynPW8LvzlAgE6cDQDu4oW4GAxyuHJjirF35mu0OgRkD1NLkXC/HYmCIQAou
wIvJwM4XiLt1k6/l1Z2wkPhsbL4af0Cp/Pfce3pTjbk+s0urQjQp4iq8xUPHM1dd
zLb1Qio0UKl9aPMSY4xgz2Xc8Iw/jpero3anDKtHfcAZQ3erXoTO3IORrXrQmY2j
XbizlbcFIu8/YVG6qT3qHTXP6kuFeNSKubBPKsLTIBtbvJt5XM3Sq3TZhhN97Cn9
QTLyn3Cy6vjRwrIcA8/qhYi+4DW9VJQnx6OKfcNIhiHJ2bDuQ+vQ5OOSSX6ImcY4
Ubi/EYuhr6fJ5Afc1Oj0uF25VKkAFGL7JcYLBd779l4tt+8ocuDwdfUgCr5zEbRT
e1QkdZ+bUaMrBD8VrHZ1
=2fAG
-----END PGP SIGNATURE-----

--1X1uH+Y+uHyMJls4--
