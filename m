Received: from eggs.gnu.org ([209.51.188.92]:42862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gsyVV-0002pC-QT
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 18:27:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gsyVM-00034q-T7
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 18:27:25 -0500
Date: Mon, 11 Feb 2019 10:16:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190210231629.GB7230@umbus.fritz.box>
References: <20190210174421.22062-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Content-Disposition: inline
In-Reply-To: <20190210174421.22062-1-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH] cuda: decrease time delay before raising
 VIA SR interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, hsp.cat7@gmail.com


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 10, 2019 at 05:44:21PM +0000, Mark Cave-Ayland wrote:
> In order to handle a race condition in MacOS 9, a delay was introduced wh=
en
> raising the VIA SR interrupt inspired by similar code in MacOnLinux.
>=20
> During original testing of the MacOS 9 patches it was found that the 30us
> delay used in MacOnLinux did not work reliably within QEMU, and a value of
> 300us was required to function correctly.
>=20
> Recent experiments have shown that the previous reliability issues are no
> longer present, and this value can be reduced down to 20us with no appare=
nt
> ill effects in my local tests. This has the benefit of considerably impro=
ving
> the responsiveness of the ADB keyboard and mouse with the guest.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to ppc-for-4.0, thanks.

> ---
>  hw/misc/macio/cuda.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>=20
> diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
> index c4f7a2f39b..3febacdd1e 100644
> --- a/hw/misc/macio/cuda.c
> +++ b/hw/misc/macio/cuda.c
> @@ -97,17 +97,8 @@ static void cuda_set_sr_int(void *opaque)
> =20
>  static void cuda_delay_set_sr_int(CUDAState *s)
>  {
> -    MOS6522CUDAState *mcs =3D &s->mos6522_cuda;
> -    MOS6522State *ms =3D MOS6522(mcs);
> -    MOS6522DeviceClass *mdc =3D MOS6522_DEVICE_GET_CLASS(ms);
>      int64_t expire;
> =20
> -    if (ms->dirb =3D=3D 0xff || s->sr_delay_ns =3D=3D 0) {
> -        /* Disabled or not in Mac OS, fire the IRQ directly */
> -        mdc->set_sr_int(ms);
> -        return;
> -    }
> -
>      trace_cuda_delay_set_sr_int();
> =20
>      expire =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + s->sr_delay_ns;
> @@ -542,7 +533,7 @@ static void cuda_realize(DeviceState *dev, Error **er=
rp)
>      s->tick_offset =3D (uint32_t)mktimegm(&tm) + RTC_OFFSET;
> =20
>      s->sr_delay_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_set_sr_i=
nt, s);
> -    s->sr_delay_ns =3D 300 * SCALE_US;
> +    s->sr_delay_ns =3D 20 * SCALE_US;
> =20
>      s->adb_poll_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_adb_poll=
, s);
>      s->adb_poll_mask =3D 0xffff;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxgsMsACgkQbDjKyiDZ
s5K/ChAAvUOAnzdGCmCfk7dfJw+PkLgfZ74oQVYrgntk0SxUE2JqF8b2wt9x9JWb
0yEfmd8Js/tZmEnSl09Z+Omt6T4KzPyWf8khFhE9XdUvhHy18zkl7Ck7LDoCj/3c
BSZ9ch3X/ZdslJE6UjThiivcv1CQPsHTdF0KNmxsxMnTlsFJM3ObcPViEe/ujzOR
aWXhFyrtXqMJWVmLIXMe8m5zqYLvVeEiA/FC0Rm+WO/LLEMUGFjDsjBxJ6kZ0Ji5
Y3NYSzJI4Sv4/oRXZoWzCVRSvqJGBRuzuH06kSHGLsgHpFQ537YMHU3vu2YyeT1x
8gVJBeBvE2/0i21z4X9UwTe5KdYJNG1jCCuuU8wWwCTsBs4VE2LMwwYXLhc0WgE4
+pe/cGVIALOGfT1jSz1/7XPB5acpSWXtKVsI7JNR5A4OZb7Um1dLGIvYuXbHVLHP
uHnTNJxLea6jIZr/SsPPzJKLgkAscJmkDL+mVX6fuJPsAYnvrBXnihxCwQzVdJOS
hT5UMpxIvXxdpxBm20SAWyQYzDOh9nRaX4MdYjaByRq2iI2xmp2RXMcaPljdyIG3
OHoaQtSP+S5zbbAv9DIyGfPs5pLQ6OPVWBDJHrdiq+flnvblObQhdN3Ur/VrFkoA
JIZqBUqEFjN/E9eDYyxuWafhMwuNCdGDiut6KHe8OMyRlwCwtY8=
=jYI1
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
