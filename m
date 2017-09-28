Received: from eggs.gnu.org ([2001:4830:134:3::10]:46081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxdA8-0000Cr-WF
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 14:03:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxdA5-0002Ba-Rz
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 14:03:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dxdA5-0002Aw-JM
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 14:03:49 -0400
References: <20170928120621.30288-1-berrange@redhat.com>
	<20170928120621.30288-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <723de7c1-e617-923c-6e69-561577f0fe1a@redhat.com>
Date: Thu, 28 Sep 2017 13:03:41 -0500
MIME-Version: 1.0
In-Reply-To: <20170928120621.30288-3-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8goO7fkCSMeLuhraeSevIdfULUP6RN7mD"
Subject: Re: [Qemu-devel] [PATCH v7 2/6] docker: don't rely on submodules
 existing in the main checkout
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8goO7fkCSMeLuhraeSevIdfULUP6RN7mD
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <723de7c1-e617-923c-6e69-561577f0fe1a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 2/6] docker: don't rely on submodules
 existing in the main checkout
References: <20170928120621.30288-1-berrange@redhat.com>
 <20170928120621.30288-3-berrange@redhat.com>
In-Reply-To: <20170928120621.30288-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/28/2017 07:06 AM, Daniel P. Berrange wrote:
> When building the tarball to pass into the docker/vm test image,
> the code relies on the git submodules being checked out in the
> main checkout.
>=20
> ie if the developer has not run 'git submodule update --init dtc'
> many of the docker tests will fail due to the libfdt package not

'dtc' vs. 'libfdt' - is one of the acronyms wrong?

> being present in the test images. Patchew manually checks out the
> dtc submodule in the main git checkout, but this is a bad idea.
>=20
> When running tests we want to have a predictable set of submodules
> included in the source that's tested. The build environment is
> completely independant of the developers host OS, so the submodules

s/independant/independent/

> the developer has checked out should not be considered relevant for
> the tests.
>=20
> This changes the archive-source.sh script so that it clones the
> current git checkout into a temporary directory, checks out a
> fixed set of submodules, builds the tarball and finally removes
> the temporary git clone.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  scripts/archive-source.sh | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
>=20

> +++ b/scripts/archive-source.sh

> +# We want a predictable list of submodules for builds, that is
> +# independant of what the developer currently has initialized

and again

> +# in their checkout, because the build environment is completely
> +# different to the host OS.
> +submodules=3D"dtc"
> =20
>  if test $? -ne 0; then
>      error "git submodule command failed"
> @@ -28,6 +34,21 @@ fi
> =20
>  trap "status=3D$?; rm -f \"$list_file\"; exit \$status" 0 1 2 3 15
> =20
> +if git diff-index --quiet HEAD -- &>/dev/null
> +then
> +    HEAD=3DHEAD
> +else
> +    HEAD=3D`git stash create`
> +fi
> +git clone --shared . "$vroot_dir"

set -e is not in effect; do you need error checking here?

> +here=3D`pwd`

$PWD is cheaper than spawning a subprocess for `pwd`.

> +cd "$vroot_dir"

Definitely need error checking here.

> +git checkout $HEAD
> +
> +for sm in $submodules; do
> +    git submodule update --init $sm
> +done
> +
>  if test -n "$submodules"; then
>      {
>          git ls-files || error "git ls-files failed"
> @@ -48,4 +69,7 @@ fi
> =20
>  tar -cf "$tar_file" -T "$list_file" || error "failed to create tar fil=
e"
> =20
> +cd "$here"

and again here

> +rm -rf "$vroot_dir"
> +
>  exit 0
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--8goO7fkCSMeLuhraeSevIdfULUP6RN7mD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnNOX0ACgkQp6FrSiUn
Q2qmhQf/YXaQ/deqxuqH6rw2SKK4ha80zQJor9sWPtG35zdUFZSi1SD9hmDFDp/X
yMYlKwWd3Ko7b9oDW0ox2msG18c92SuuNa6x2wbF/rB8Af1gs2xbYLCJiVhpqCM9
st4swY93iYXkxGEnEL6l3OR4Vk8tpx472Lp3vGhpxJPEgkXQaY7e9V2jMJ5aNp6G
1rhC9f0Drkg2D1MQxiRam/A1lTFOhPL8j1MaXUCswVjdj+41kAAuc5KBE+x+XfBC
0J7ebAUIeazpnBkhkX7RwZXV1l7WvtRl+Nobo1FnaEeBihgXs3X8w2DKjEvRRIq5
3qPUVw9qDQv0WS9zVaRIcSe1P4xgmw==
=xJuY
-----END PGP SIGNATURE-----

--8goO7fkCSMeLuhraeSevIdfULUP6RN7mD--
