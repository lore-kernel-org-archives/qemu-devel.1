Received: from eggs.gnu.org ([2001:4830:134:3::10]:49396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYtwc-0005YT-1d
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:27:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYtwY-0003Sl-Uc
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:27:58 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:37558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYtwY-0003SW-OU
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:27:54 -0500
Received: by mail-qk0-x244.google.com with SMTP id p13so18464103qke.4
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 05:27:54 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-7-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <10f81db9-683c-acb9-049f-eb3579909b18@amsat.org>
Date: Tue, 9 Jan 2018 10:27:46 -0300
MIME-Version: 1.0
In-Reply-To: <20180109122252.17670-7-alex.bennee@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="fna7mYyeuPRyI3INt1iusRPmZMFrDH0mZ"
Subject: Re: [Qemu-devel] [PATCH v2 06/20] include/fpu/softfloat: add some
 float16 constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, richard.henderson@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fna7mYyeuPRyI3INt1iusRPmZMFrDH0mZ
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu,
 bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <10f81db9-683c-acb9-049f-eb3579909b18@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v2 06/20] include/fpu/softfloat: add some
 float16 constants
References: <20180109122252.17670-1-alex.bennee@linaro.org>
 <20180109122252.17670-7-alex.bennee@linaro.org>
In-Reply-To: <20180109122252.17670-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On 01/09/2018 09:22 AM, Alex Benn=C3=A9e wrote:
> This defines the same set of common constants for float 16 as defined
> for 32 and 64 bit floats. These are often used by target helper
> functions. I've also removed constants that are not used by anybody.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20
> ---
> v2
>   - fixup constants, remove unused onces
> ---
>  include/fpu/softfloat.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index 8ab5d0df47..e64bf62f3d 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -368,6 +368,11 @@ static inline float16 float16_set_sign(float16 a, =
int sign)
>      return make_float16((float16_val(a) & 0x7fff) | (sign << 15));
>  }
> =20
> +#define float16_zero make_float16(0)
> +#define float16_one make_float16(0x3a00)

I still disagree with this one, it seems your bits 9/10 are inverted
(mantissa msb with biased exponent lsb).

         S EEEEE TTTTTTTTTT
0x3a00 =3D 0 01110 1000000000

having:
S=3D0
E=3D0b01110=3D14
T=3D0b1000000000=3D512

I get:
(-1)^0 * 2^(14-15) * (1 + (2^-10) * 512) =3D 1 * 0.5 * (1 + 0.5) =3D 0.75=


With 0x3c00 I get:

         S EEEEE TTTTTTTTTT
0x3c00 =3D 0 01111 0000000000
S=3D0
E=3D0b01111=3D15
T=3D0b0000000000=3D0

(-1)^0 * 2^(15-15) * (1 + (2^-10) * 0) =3D 1 * 2^0 * (1 + 0) =3D 1

The rest is OK.

Changing by "#define float16_one make_float16(0x3c00)":
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> +#define float16_half make_float16(0x3800)
> +#define float16_infinity make_float16(0x7c00)
> +
>  /*--------------------------------------------------------------------=
--------
>  | The pattern for a default generated half-precision NaN.
>  *---------------------------------------------------------------------=
-------*/
> @@ -474,8 +479,6 @@ static inline float32 float32_set_sign(float32 a, i=
nt sign)
> =20
>  #define float32_zero make_float32(0)
>  #define float32_one make_float32(0x3f800000)
> -#define float32_ln2 make_float32(0x3f317218)
> -#define float32_pi make_float32(0x40490fdb)
>  #define float32_half make_float32(0x3f000000)
>  #define float32_infinity make_float32(0x7f800000)
> =20
> @@ -588,7 +591,6 @@ static inline float64 float64_set_sign(float64 a, i=
nt sign)
>  #define float64_zero make_float64(0)
>  #define float64_one make_float64(0x3ff0000000000000LL)
>  #define float64_ln2 make_float64(0x3fe62e42fefa39efLL)
> -#define float64_pi make_float64(0x400921fb54442d18LL)
>  #define float64_half make_float64(0x3fe0000000000000LL)
>  #define float64_infinity make_float64(0x7ff0000000000000LL)
> =20
>=20


--fna7mYyeuPRyI3INt1iusRPmZMFrDH0mZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlpUw1IACgkQ4+MsLN6t
wN40WA/+Mr/Yj4v9z0oPb5OQpI2fx7RU3jg3J1psb1j3ocPIf7PEXW44/NiVCo/p
iOpbaIlzszUwbOHEElQK8ConWDCtKU5azzNCqlDxHgjVh8Rjr7Uc1g8pDh0T4jub
CN61Vu7qV7UV8HToXMxuQX4cRW7P6LGgnQl3PNMJKH4qrLQa1oNMcVD1bskA+j5k
COmlYJG+ZpT9Z1B3OJ5TWU57hAO8w6SR/i0xQn5FBwibcZdCh+dCFyyBnicIvqOM
w02Wg/PvRiGp06k9qqIcbBr9JnaWjF8fc1MeqkyDp8CjNjENjlO8EM9UzckHDa3S
EPEgNMe32akIrNBAr5ChgfDKh865Zp8mPetJxn/9vvi4xzZPmb+JMxaQyc3dGrrz
iX+cZ7m3MYYOGP+ZtV2/Z5lPous59gGFkHiwRva5jU4FTdTaK6NSve5iOTIfdOVk
IyiiArcsnnzADRQyGeQqqZ8pj+GpSyEc4HoUE/DyUVQutOP2YP9yxEVr2cJD/VIq
r8n4KaBVCVwCtWY2Bftnrwvt/6ZA02eoFd7W06GogtPFD23vvLQHcMox5vXFd6MG
1CXidddSHMSlDhBQpeZObhOgWYQCXHbl0IB9py5YIYiGOZ0SXh850rdd6vykx7rc
EZSHQj9RtoQBivzK4VX6A9EHNG49/CVHAlWx/nq2YKzhvtgOOug=
=vASx
-----END PGP SIGNATURE-----

--fna7mYyeuPRyI3INt1iusRPmZMFrDH0mZ--
