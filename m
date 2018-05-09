Received: from eggs.gnu.org ([2001:4830:134:3::10]:60213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGGE9-0005eK-WA
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:57:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGGE5-00055y-AD
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:57:18 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:32843)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGGE5-00054K-1a
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:57:13 -0400
Received: by mail-qt0-x242.google.com with SMTP id e8-v6so39103531qth.0
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 20:57:12 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180424222103.19946-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a5dd8355-d9aa-fe01-c64e-fe2c06f02c2a@amsat.org>
Date: Wed, 9 May 2018 00:57:02 -0300
MIME-Version: 1.0
In-Reply-To: <20180424222103.19946-1-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="KFjXBgGv5z1nVdqWUP2n5XF9oS6wzHUC2"
Subject: Re: [Qemu-devel] [PATCH v4] loader: Fix misaligned member access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Paul Burton <paul.burton@mips.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KFjXBgGv5z1nVdqWUP2n5XF9oS6wzHUC2
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paul Burton <paul.burton@mips.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Message-ID: <a5dd8355-d9aa-fe01-c64e-fe2c06f02c2a@amsat.org>
Subject: Re: [PATCH v4] loader: Fix misaligned member access
References: <20180424222103.19946-1-f4bug@amsat.org>
In-Reply-To: <20180424222103.19946-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Peter, Paolo,

On 04/24/2018 07:21 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> The libfdt does not guarantee than fdt_getprop() returns a pointer
> aligned to the property size.
>=20
> Assuming the base of the fdt is aligned, a 32-bit property returns
> a 32-bit aligned pointer. This is however not guaranteed for 64-bit
> properties, where 64-bit loads might trigger unaligned access.
>=20
> Fix the 64-bit access using the ldst (host) API, which uses a local
> copy on the stack, thus guaranteeing a safe aligned access.
>=20
> This fixes the following ASan warning:
>=20
>   $ qemu-system-mips64el -M boston -kernel vmlinux.gz.itb -nographic
>   hw/core/loader-fit.c:108:17: runtime error: load of misaligned addres=
s 0x7f95cd7e4264 for type 'fdt64_t', which requires 8 byte alignment
>   0x7f95cd7e4264: note: pointer points here
>     00 00 00 3e ff ff ff ff  80 7d 2a c0 00 00 00 01  68 61 73 68 40 30=
 00 00  00 00 00 03 00 00 00 14
>                 ^
>=20
> Reported-by: AddressSanitizer
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> v4: do not change the 32-bit access, use ldq_he_p() for the 64-bit acce=
ss
> v3: do not use memcpy(), incorrectly change ldl_he_p()
> v2: do not change the 32-bit access, use memcpy(), add comments (David =
Gibson)
> v1: use memcpy()
>=20
>  hw/core/loader-fit.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
> index 0c4a7207f4..ed4140061b 100644
> --- a/hw/core/loader-fit.c
> +++ b/hw/core/loader-fit.c
> @@ -102,10 +102,17 @@ static int fit_image_addr(const void *itb, int im=
g, const char *name,
> =20
>      switch (len) {
>      case 4:
> +        /* Assuming the base of the fdt is aligned, then fdt_getprop()=

> +         * returns 32-bit aligned properties, so this load is guarante=
ed
> +         * to be 32-bit aligned.
> +         */
>          *addr =3D fdt32_to_cpu(*(fdt32_t *)prop);
>          return 0;
>      case 8:
> -        *addr =3D fdt64_to_cpu(*(fdt64_t *)prop);
> +        /* Since the property is not guaranteed to be 64-bit aligned,
> +         * use ldq_he_p()'s stack to avoid an unaligned load.
> +         */
> +        *addr =3D fdt64_to_cpu(ldq_he_p(prop));
>          return 0;
>      default:
>          error_printf("invalid %s address length %d\n", name, len);
>=20

The FIT loader is MIPS specific, but since this patch is FDT related,
can it go via your ARM or MISC tree?

Thanks,

Phil.


--KFjXBgGv5z1nVdqWUP2n5XF9oS6wzHUC2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlrycY4ACgkQ4+MsLN6t
wN6iKRAAiuajZGBocr7EjSLSyJcGsda9UY2/XIayw8Qgwix3C+G2jqwbfkgb8orp
As7SOx7B7gKIU0eo5omlpIiTkpeaPpVg2xSWfWifogDGnVVI8r+e+Y/6yR+Ix2E8
RbLpIMEA+rk4XdTiQngQuV3zY4B97dMPfJDDVImpiKHUSb9kZtXB+YU/ySQEy6Jv
+UgTBZktsbpk1jnTw+ufz7V9pF6z7tDFtp16x6G9b6WQV6n3hI4t9JPnh4/335FA
r75FA7POlakc52NfqECqsPnHJeZKiaHW4kobb9euhbzx3biNNWNsth0pRYEfHjuK
4MYgoXCAhRoi5NyQVwC18IlcK/HSW1ELVW20+BWb8o5CCqoeJypSiCp0T0NISDwA
5IHgV60uJd5PWm3U9usI5J18J29URNiygUt2RqFtcIx34MkeYBr49tckoKit60a+
R4eaLRn4pB/2SQCG5g5qNv12fJMAWPm4WZ33/fdLzz5wNf8gh5eUzREIsfM18YWs
BMhSZv5bevrccKCHtM53nny+6b9S4s7dCJPWk1U34ZTjWNqHkyO0Qs9Pqs6r9v1t
fcaGn8syO5MEBbDVfhJ/QJA26KD+lEZ6fe/aJUF1J7q1fJElzw+KAT9jLvLdNeMl
eQYpwcKEXcIAKOEZRL9GFP2UASFQiGyDzAWM9b5coheeh2yjB1w=
=xYOw
-----END PGP SIGNATURE-----

--KFjXBgGv5z1nVdqWUP2n5XF9oS6wzHUC2--
