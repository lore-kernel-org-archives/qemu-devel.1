Received: from eggs.gnu.org ([2001:4830:134:3::10]:56244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d5Xnb-0007IM-8K
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:25:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d5XnX-0003rz-UF
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:25:03 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:36385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d5XnX-0003pT-KC
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:24:59 -0400
Received: by mail-wr0-x243.google.com with SMTP id v42so17426349wrc.3
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 06:24:59 -0700 (PDT)
Date: Tue, 2 May 2017 14:24:56 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170502132456.GD22502@stefanha-x1.localdomain>
References: <20170420121639.32685-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
Content-Disposition: inline
In-Reply-To: <20170420121639.32685-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] dist: create separate dist with
 bundled roms/libs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 20, 2017 at 01:16:39PM +0100, Daniel P. Berrange wrote:
> The qemu-XXXX.tar.bz2 currently contains bundled copies of the pixman
> and dtc codebases, as well as pre-built ROM binaries and their sources.
>=20
> Many OS distros want to build & ship ROMs separately to ensure license
> compliance. Similarly they'll build pixman/dtc code independantly to
> allow sharing with the rest of the distro. Thus they'll never use these
> bundled files. A further complication is that these bundled files create
> extra auditing work for distros when applying for export compliance,
> particularly when the bundled files contain crypto code. This burden
> applies merely by having the files in the tar.bz2, even if they're not
> built into the binaries. If we ever want to include UEFI ROMs for x86
> or AArch64, then the size of the QEMU dist will increase significantly
> more.
>=20
> The bundled ROMs though are fairly useful to end-users who are building
> QEMU themselves and don't want to worry about figuring out the right
> BIOS bits to build manually, so they shouldn't be dropped entirely.
>=20
> This change thus alters 'make dist' to generate two release archives
>=20
>  - qemu-XXX.tar.bz2 - minimal archive with only QEMU source code
>  - qemu-bundled-XXX.tar.bz2 - QEMU source, plus bundled ROMs & libs
>=20
> NB1, as it stands this change breaks "make install" since that assumes
> existance of the pre-built ROMs in tree.

It would be good to fix this so that a minimal dist can build and
install successfully.

> NB2, an alternative approach would be:
>=20
>  - qemu-XXX.tar.bz2 - minimal archive with only QEMU source code
>  - qemu-roms-XXX.tar.bz2 - only bundled ROMs
>=20
> and thus never ship a tar.bz2 that contains everything together,
> and stop shipping pixman/dtc entirely.

I'm not familiar with the reasons for the existing dist approach.
Hopefully someone who is will speak up.

The safest solution is to generate a new tarball
qemu-minimal-XXX.tar.bz2.  That way existing build processes continue to
work as expected.  Anyone who wants the minimal tarball can grab that
instead of the existing dist tarball.

> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  Makefile             |  5 ++++-
>  scripts/make-release | 36 ++++++++++++++++++++++++++++++++----
>  2 files changed, 36 insertions(+), 5 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 6c359b2..78f7c0c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -503,7 +503,10 @@ clean:
> =20
>  VERSION ?=3D $(shell cat VERSION)
> =20
> -dist: qemu-$(VERSION).tar.bz2
> +dist: qemu-$(VERSION).tar.bz2 qemu-bundled-$(VERSION).tar.bz2
> +
> +qemu-bundled-%.tar.bz2:
> +	$(SRC_PATH)/scripts/make-release "$(SRC_PATH)" "$(patsubst qemu-bundled=
-%.tar.bz2,%,$@)" --bundled
> =20
>  qemu-%.tar.bz2:
>  	$(SRC_PATH)/scripts/make-release "$(SRC_PATH)" "$(patsubst qemu-%.tar.b=
z2,%,$@)"
> diff --git a/scripts/make-release b/scripts/make-release
> index fa6323f..8e4a653 100755
> --- a/scripts/make-release
> +++ b/scripts/make-release
> @@ -12,14 +12,42 @@
> =20
>  src=3D"$1"
>  version=3D"$2"
> +shift
> +shift
> +bundled=3Dno
> +
> +for opt do
> +  case "$opt" in
> +      --bundled)
> +	  bundled=3Dyes
> +	  ;;
> +      *)
> +	  echo "Unknown arg '$opt'"
> +	  exit 1
> +  esac
> +done
> +
>  destination=3Dqemu-${version}
> +if test "$bundled" =3D "yes"
> +then
> +    archive=3Dqemu-bundled-${version}.tar.bz2
> +else
> +    archive=3Dqemu-${version}.tar.bz2
> +fi
> =20
>  git clone "${src}" ${destination}
>  pushd ${destination}
>  git checkout "v${version}"
> -git submodule update --init
> -(cd roms/seabios && git describe --tags --long --dirty > .version)
> -rm -rf .git roms/*/.git dtc/.git pixman/.git
> +if test "$bundled" =3D "yes"
> +then
> +    git submodule update --init
> +    (cd roms/seabios && git describe --tags --long --dirty > .version)
> +    rm -rf .git roms/*/.git dtc/.git pixman/.git
> +else
> +    rm -rf .git roms dtc pixman
> +    rm -f pc-bios/*.{rom,bin} pc-bios/{openbios*,u-boot.s500}
> +fi
> +
>  popd
> -tar cfj ${destination}.tar.bz2 ${destination}
> +tar cfj ${archive} ${destination}
>  rm -rf ${destination}
> --=20
> 2.9.3
>=20
>=20

--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCIioAAoJEJykq7OBq3PISDgIAIVNZNdtfpvq1eWKE9Rw9u7K
aUuKbUTuVmUy0xVpLWQ0LhgMA9jCccOpDFSd6STVBdEYHEIK0aSS6mTtjQSqUrNj
o7waSOE9df8/3KqnJw5sBCkU/b30BalR+j0eB3ojNblLy8WQIRMBMcEaa0vq0e9a
jOpFz6VIuk8RjeYbTEoWct15Zhw1sqPePIuoOA9T09loXoU/GhSDCEqcv2L/nMOJ
UVMa+Ly3jbDK+VYmBdvB+3B6EQsJxbXKCDEUICoWomNCtZM8PDjONQxFte9iAVIs
m6KOj7PquK0498zDp73qwN69DdvpCu/O/17Na7A0T63qoQWkEPO3fLKz+AYM4LM=
=JEq2
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--
