Received: from eggs.gnu.org ([2001:4830:134:3::10]:47886)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1eXSil-0004p3-CI
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 09:11:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1eXSii-0000y9-3p
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 09:11:43 -0500
Received: from mout.gmx.net ([212.227.17.21]:54161)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1eXSih-0000wx-P0
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 09:11:40 -0500
References: <23118.26328.811644.330716@guava.gson.org>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <99b0636b-9b37-4e4e-b066-6c2aff8b5f1f@gmx.com>
Date: Fri, 5 Jan 2018 15:14:04 +0100
MIME-Version: 1.0
In-Reply-To: <23118.26328.811644.330716@guava.gson.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4gIUKhk4chxdRdNiWomP0kf2ee4Ii8oLq"
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: check for posix_memalign in
 configure script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andreas Gustafsson <gson@gson.org>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4gIUKhk4chxdRdNiWomP0kf2ee4Ii8oLq
From: Kamil Rytarowski <n54@gmx.com>
To: Andreas Gustafsson <gson@gson.org>, qemu-devel@nongnu.org
Message-ID: <99b0636b-9b37-4e4e-b066-6c2aff8b5f1f@gmx.com>
Subject: Re: [PATCH] oslib-posix: check for posix_memalign in configure script
References: <23118.26328.811644.330716@guava.gson.org>
In-Reply-To: <23118.26328.811644.330716@guava.gson.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.01.2018 18:39, Andreas Gustafsson wrote:
> Check for the presence of posix_memalign() in the configure script,
> not using "defined(_POSIX_C_SOURCE) && !defined(__sun__)".  This
> lets qemu use posix_memalign() on NetBSD versions that have it,
> instead of falling back to valloc() which is wasteful when the
> required alignment is smaller than a page.
>=20
> Signed-off-by: Andreas Gustafsson <gson@gson.org>

Reviewed-by: Kamil Rytarowski <n54@gmx.com>

> ---
>  configure          | 19 +++++++++++++++++++
>  util/oslib-posix.c |  2 +-
>  2 files changed, 20 insertions(+), 1 deletion(-)
>=20
> diff --git a/configure b/configure
> index 100309c33f..9f8580332a 100755
> --- a/configure
> +++ b/configure
> @@ -4573,6 +4573,21 @@ if compile_prog "" "" ; then
>      posix_madvise=3Dyes
>  fi
> =20
> +##########################################
> +# check if we have posix_memalign()
> +
> +posix_memalign=3Dno
> +cat > $TMPC << EOF
> +#include <stdlib.h>
> +int main(void) {
> +    void *p;
> +    return posix_memalign(&p, 8, 8);
> +}
> +EOF
> +if compile_prog "" "" ; then
> +    posix_memalign=3Dyes
> +fi
> +
>  ##########################################
>  # check if we have posix_syslog
> =20
> @@ -5542,6 +5557,7 @@ echo "preadv support    $preadv"
>  echo "fdatasync         $fdatasync"
>  echo "madvise           $madvise"
>  echo "posix_madvise     $posix_madvise"
> +echo "posix_memalign    $posix_memalign"
>  echo "libcap-ng support $cap_ng"
>  echo "vhost-net support $vhost_net"
>  echo "vhost-scsi support $vhost_scsi"
> @@ -6015,6 +6031,9 @@ fi
>  if test "$posix_madvise" =3D "yes" ; then
>    echo "CONFIG_POSIX_MADVISE=3Dy" >> $config_host_mak
>  fi
> +if test "$posix_memalign" =3D "yes" ; then
> +  echo "CONFIG_POSIX_MEMALIGN=3Dy" >> $config_host_mak
> +fi
> =20
>  if test "$spice" =3D "yes" ; then
>    echo "CONFIG_SPICE=3Dy" >> $config_host_mak
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 77369c92ce..4655bc1f89 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -105,7 +105,7 @@ void *qemu_try_memalign(size_t alignment, size_t si=
ze)
>          alignment =3D sizeof(void*);
>      }
> =20
> -#if defined(_POSIX_C_SOURCE) && !defined(__sun__)
> +#if defined(CONFIG_POSIX_MEMALIGN)
>      int ret;
>      ret =3D posix_memalign(&ptr, alignment, size);
>      if (ret !=3D 0) {
>=20



--4gIUKhk4chxdRdNiWomP0kf2ee4Ii8oLq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlpPiDQMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZsGEIQAKpcbmEBeqcDlVGneUrZDBkw6+tdMpUqbbMagQeG
SDCeOT4e9qKqfPLkjYMs82sN4uxtC39wDB2HUjqH2+NGnZ8PB8tPi1fE9+xtW/ab
1OlB9NSwGN80DDo2IiEJj2Xq6IxCjuUEh6buFbu7eZS5DDixLscZVhtZ8EG/8ZWt
Ph/tyGWxJ+XLqgUsKNDgRQkKrKN1hGFQqCauU+6n7vaFHFc+K+D+uVbRTDqX2JV7
eZ1bfrhpqGWE7A55TnTOQoV4A8oPK+h8bS6C251jsY5okJpGxSs+3baPa7nJvINn
LER/RNY9YNDV/53jkhLHBpgHgnhHlIqBCV9pcdHwt0pJMbFgbPkCWVFnDPBiD/rP
bJG7I8Vvs7sW5KiS7h90Zz5SoF61jr+1j/p57NnhxV0BPIPbbNZHqNWf5P6uzJ8p
jWPEcGaS3grfkvzulKTnE57xWsC/GxHRQVG0ZTDBX/LHkrgTf+xj+4e90G+/gswz
m/ILVidYM7U84+wlIjBWo8/espcOhXx3YESOREJVU9lG1hq7n0oizgdzMqIj5gwc
mULjRyaQwzoC+b7Np5lasNe6tkblbWcWNfabPjGpHJ5GCKKLR587WMt66mFaS4j4
vEgcnc/NJeStUgBLYZy6yapPKzCaMiq0OXmIJyHDDq1HB/c2y1Hq7BvYm2pv6Z8h
5AxP
=UymX
-----END PGP SIGNATURE-----

--4gIUKhk4chxdRdNiWomP0kf2ee4Ii8oLq--
