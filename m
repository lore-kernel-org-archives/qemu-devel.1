Received: from eggs.gnu.org ([2001:4830:134:3::10]:60231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fO03R-0002pi-3j
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fO03M-0002yc-WD
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:18:13 -0400
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
	<20180426161958.2872-4-rkagan@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f924aadb-35b1-ee72-1040-fdeee5baefaf@redhat.com>
Date: Wed, 30 May 2018 14:17:55 +0200
MIME-Version: 1.0
In-Reply-To: <20180426161958.2872-4-rkagan@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="K5sMsGFsQrFtNqQFgbpW4hU5yhX7OZ7aX"
Subject: Re: [Qemu-devel] [PATCH 03/17] iotests: ask qemu for supported
 formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--K5sMsGFsQrFtNqQFgbpW4hU5yhX7OZ7aX
From: Max Reitz <mreitz@redhat.com>
To: Roman Kagan <rkagan@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <f924aadb-35b1-ee72-1040-fdeee5baefaf@redhat.com>
Subject: Re: [PATCH 03/17] iotests: ask qemu for supported formats
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
 <20180426161958.2872-4-rkagan@virtuozzo.com>
In-Reply-To: <20180426161958.2872-4-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-26 18:19, Roman Kagan wrote:
> Add helper functions to query the block drivers actually supported by
> QEMU using "-drive format=3D?".  This allows to skip certain tests that=

> require drivers not built in or whitelisted in QEMU.
>=20
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> ---
>  tests/qemu-iotests/common.rc  | 19 +++++++++++++++++++
>  tests/qemu-iotests/iotests.py | 30 +++++++++++++++++++++++++++---
>  2 files changed, 46 insertions(+), 3 deletions(-)

[...]

> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests=
=2Epy
> index e2abf0cb53..698ef2b2c0 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py

[...]

> @@ -550,13 +561,26 @@ def verify_cache_mode(supported_cache_modes=3D[])=
:
>      if supported_cache_modes and (cachemode not in supported_cache_mod=
es):
>          notrun('not suitable for this cache mode: %s' % cachemode)
> =20
> +rw_formats =3D None
> +
> +def supports_format(format_name):
> +    format_message =3D qemu_pipe('-drive', 'format=3D?')
> +    global rw_formats
> +    if rw_formats is None:
> +        rw_formats =3D format_message.splitlines()[0].split(':')[1].sp=
lit()

Isn't it sufficient to call qemu_pipe() only if rw_formats is None?

The rest looks good.

Max

> +    return format_name in rw_formats
> +
> +def require_formats(*formats):
> +    for fmt in formats:
> +        if not supports_format(fmt):
> +            notrun('%s does not support format %s' % (qemu_prog, fmt))=

> +
>  def supports_quorum():
> -    return 'quorum' in qemu_img_pipe('--help')
> +    return supports_format('quorum')
> =20
>  def verify_quorum():
>      '''Skip test suite if quorum support is not available'''
> -    if not supports_quorum():
> -        notrun('quorum support missing')
> +    require_formats('quorum')
> =20
>  def main(supported_fmts=3D[], supported_oses=3D['linux'], supported_ca=
che_modes=3D[],
>           unsupported_fmts=3D[]):
>=20



--K5sMsGFsQrFtNqQFgbpW4hU5yhX7OZ7aX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsOlnMACgkQ9AfbAGHV
z0DgSAf/Sn6rM7LaoZewvqkg9svLpSeMkzEcMu1sLQgj08PDcRmEWjPwcS4HAJyd
KUjftsJrfnUXDddbb5+VtbPrChaBKAMdlrxAM6aOONeqbSIlzlA/xejT6kN+vXTC
91um7rYBiFPlulOWpkc8K6pD+jgmYkOK7a1RhpFOSOHthSGpDZ7ynYaYRCP7F64j
fCIzg8A2HaJH/Rne0ByNTu8rDyrZFaS6ys085oH1w38u74wCRjYZl7EbuMtlRPr7
Yoaott4YHN5K7x6Xu5UWKIfTT/UbLA1tdn6Nq0euCX5ekCUG9zhCj35q0kxeljMx
zK4BODXK8I2i7eTTcrye04bWNMwDqw==
=gmGA
-----END PGP SIGNATURE-----

--K5sMsGFsQrFtNqQFgbpW4hU5yhX7OZ7aX--
