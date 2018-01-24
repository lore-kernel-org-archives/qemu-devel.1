Received: from eggs.gnu.org ([2001:4830:134:3::10]:51575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeJW8-0004dP-Ck
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 06:47:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeJW7-00027e-Cm
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 06:47:00 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180124101358.GA5028@bogon.m.sigxcpu.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <73ef36b3-8fc3-0115-3ce6-7a632ae27127@amsat.org>
Date: Wed, 24 Jan 2018 08:46:47 -0300
MIME-Version: 1.0
In-Reply-To: <20180124101358.GA5028@bogon.m.sigxcpu.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="3fwCpU1hKONuIHidrWlU4iUthzPNAFb8L"
Subject: Re: [Qemu-devel] [PATCH] linux-user: Fix register used for 6th and
 7th syscall argument on aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>, Laurent Vivier <laurent@vivier.eu>
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3fwCpU1hKONuIHidrWlU4iUthzPNAFb8L
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Message-ID: <73ef36b3-8fc3-0115-3ce6-7a632ae27127@amsat.org>
Subject: Re: [PATCH] linux-user: Fix register used for 6th and 7th syscall
 argument on aarch64
References: <20180124101358.GA5028@bogon.m.sigxcpu.org>
In-Reply-To: <20180124101358.GA5028@bogon.m.sigxcpu.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I spent the night studying linux-user end figured out the same correct
fix. Just checking morning ML before sending the patch :)

Mine had "Suggested-by: Laurent Vivier <laurent@vivier.eu>" since he
said on IRC "gdb will help" and indeed single stepping before the
syscall the bug was obvious.

On 01/24/2018 07:13 AM, Guido G=C3=BCnther wrote:
> Unbreaks the testcase from
>=20
>     http://lists.nongnu.org/archive/html/qemu-arm/2018-01/msg00514.html=

>=20
> Thanks to Laurent Vivier for spotting the 7th one.
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  linux-user/host/aarch64/safe-syscall.inc.S | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/linux-user/host/aarch64/safe-syscall.inc.S b/linux-user/ho=
st/aarch64/safe-syscall.inc.S
> index 58a2329b37..bc1f5a9792 100644
> --- a/linux-user/host/aarch64/safe-syscall.inc.S
> +++ b/linux-user/host/aarch64/safe-syscall.inc.S
> @@ -36,7 +36,7 @@ safe_syscall_base:
>  	 *               and return the result in x0
>  	 * and the syscall instruction needs
>  	 *               x8 =3D=3D syscall number
> -	 *               x0 ... x7 =3D=3D syscall arguments
> +	 *               x0 ... x6 =3D=3D syscall arguments
>  	 *               and returns the result in x0
>  	 * Shuffle everything around appropriately.
>  	 */
> @@ -47,8 +47,8 @@ safe_syscall_base:
>  	mov	x2, x4
>  	mov	x3, x5
>  	mov	x4, x6
> -	mov	x6, x7
> -	ldr	x7, [sp]
> +	mov	x5, x7
> +	ldr	x6, [sp]
> =20
>  	/* This next sequence of code works in conjunction with the
>  	 * rewind_if_safe_syscall_function(). If a signal is taken
>=20


--3fwCpU1hKONuIHidrWlU4iUthzPNAFb8L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlpocicACgkQ4+MsLN6t
wN6hmhAAm0yyxZhorU/uwioYzlfpw2ZIHS/2RevpiQeSe4yLFlumvAfA20RMAAZ3
MxxSOCdUkXWXrP/aKQSYBCo/Wru4bhVX9bJHiw8EBj0KkrTqAR4D5C6ngS0vb+2z
BegUDz1PhBaLIuFojZ09odGJla90kjrfpkOfYja6lde2DiaYGR/MPMwX+IUT1q9c
ixwbGC3xJKGWs5WJP7ldpMTDbNALuUmo0Z2iOjLcsVAvkPdM2oSL2ER93Hvb3Zfx
h1b5067Y8C/3cxJZEOilKq211EilzQmlPkJTfoFP9+tkDjJvYbW2P2yFDmMGzWNT
t3hXrvLRO5P5/7gVVq3BiwU/zHCFzImNP1hqGFozZBJS1LrQlmbympWKjOLGnHSg
YjPT1bAFWWzd8B9CiScXeyPzcBFOIPgmFprvTKVWCmUkShEBLLsU10Gf/CP70Y40
Rk7vgwzczmM266L1EqN9Z3Uq0yLtREwCXAO5ykvaXmduwSnAJaLPfugLyESHmgz4
WqP7Eq/JBPY8kkl4HmK1adKPGasbYzaOVjo5Ec1KTeeohGRhIyZChxYdkZcoYSvG
XE1gjBkpSE3+MJGLhX3ZP0ydk1YASd2EDl1NR12WFi7BCnWJ1P3BeS1nQrC0F+v4
2fa6aFv112P6v72xdLCDpcCHwnzgWNN0SOztrJtMJ+AT3q5gSys=
=IKBM
-----END PGP SIGNATURE-----

--3fwCpU1hKONuIHidrWlU4iUthzPNAFb8L--
