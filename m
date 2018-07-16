Received: from eggs.gnu.org ([2001:4830:134:3::10]:34383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ff0MV-00059X-6N
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:04:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ff0MS-0002p6-2w
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:04:11 -0400
Received: from ozlabs.org ([203.11.71.1]:42057)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1ff0MR-0002nx-52
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:04:08 -0400
Date: Mon, 16 Jul 2018 19:43:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180716094310.GL2599@umbus.fritz.box>
References: <20180705182001.16537-1-mdavidsaver@gmail.com>
	<20180705182001.16537-13-mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gwtGiOGliFx8mAnm"
Content-Disposition: inline
In-Reply-To: <20180705182001.16537-13-mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 12/14] timer: ds-rtc handle CENTURY bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Antoine Mathys <barsamin@gmail.com>, qemu-devel@nongnu.org


--gwtGiOGliFx8mAnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Thu, Jul 05, 2018 at 11:19:59AM -0700, Michael Davidsaver wrote:
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/timer/ds-rtc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/timer/ds-rtc.c b/hw/timer/ds-rtc.c
> index 6d3a8b5586..9abac38628 100644
> --- a/hw/timer/ds-rtc.c
> +++ b/hw/timer/ds-rtc.c
> @@ -70,6 +70,7 @@ typedef struct DSRTCState {
>  typedef struct DSRTCClass {
>      I2CSlaveClass parent_obj;
> =20
> +    bool has_century;
>      /* actual address space size must be <=3D NVRAM_SIZE */
>      unsigned addr_size;
>      unsigned ctrl_offset;
> @@ -93,6 +94,7 @@ static const VMStateDescription vmstate_dsrtc =3D {
> =20
>  static void capture_current_time(DSRTCState *s)
>  {
> +    DSRTCClass *k =3D DSRTC_GET_CLASS(s);
>      /* Capture the current time into the secondary registers
>       * which will be actually read by the data transfer operation.
>       */
> @@ -125,7 +127,10 @@ static void capture_current_time(DSRTCState *s)
>      }
>      s->nvram[R_DATE] =3D to_bcd(now.tm_mday);
>      s->nvram[R_MONTH] =3D to_bcd(now.tm_mon + 1);
> -    s->nvram[R_YEAR] =3D to_bcd(now.tm_year - 100);
> +    s->nvram[R_YEAR] =3D to_bcd(now.tm_year % 100u);
> +
> +    ARRAY_FIELD_DP32(s->nvram, MONTH, CENTURY,
> +                     k->has_century && now.tm_year >=3D 100)
>  }
> =20
>  static void inc_regptr(DSRTCState *s)
> @@ -282,6 +287,7 @@ static void ds1338_class_init(ObjectClass *klass, voi=
d *data)
>  {
>      DSRTCClass *k =3D DSRTC_CLASS(klass);
> =20
> +    k->has_century =3D false;
>      k->addr_size =3D 0x40;
>      k->ctrl_offset =3D R_DS1338_CTRL;
>      k->ctrl_write =3D ds1338_control_write;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gwtGiOGliFx8mAnm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltMaKsACgkQbDjKyiDZ
s5Kakg/8DiFO5cccWCd5yP0MU58gN84LOd45Eq2po3LcgxXGSCpe4l03kFOlVqTt
iTEwAqvQrKStWO3Uf25VGuGezwmqSaLJ1DoRQpsX2GI2WXhdl+oasQvj9MwccTHn
aL+Ck28rhMq//wi8bCfUjT3u8KnrRAjmoz77tXoYevzxTNdoB3nGOeblDO1/9mhj
Rw5dmIWw98rf1v2oFVMWH19nPmhVRS+5VSburVQMUz/LCBQeUjLmRYFtAH8M+Qg1
mG0NQXBZFdR1ju7fr0ex1Ssa0pcOXzE9v7VzzpViWetRDDjkRIcXV/mpvxhbmpQA
OZamYbR0/FAbZt23ltfoWwtvFFDly6Wq+oiVmTOu63pyt2VY8pNfTSqhhm8lZcNX
kvXVw02U56AL/E+vqJUxpYU7fI6wbfrdgJnEaE/nQ2zzNKb+M3+V23evFJp+kcSF
abz6TufROobF0YlKBXrQojASW1j4sxmBXxvLyYCy1POpjPOayM2SZhfu4QJykiDa
A6EIb+4x27y5yqcYpSMMDb2rDnIx+OpRtega5Y4qCBseU88T1ePykqiNR+yTe090
JKaqKJIe7VkVbISgUt3pBArd6WN5oBRZ/131b15JJyk4GEf/dCATPKgG37YtpiDU
YeoSxR08lmLoE/ad/m8HC6g8rtr2iGLdc9GBXUCx/nRG7EV+eAM=
=mV/2
-----END PGP SIGNATURE-----

--gwtGiOGliFx8mAnm--
