Received: from eggs.gnu.org ([2001:4830:134:3::10]:47227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMAO2-0004vp-1F
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 05:23:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMANx-0002yK-Vl
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 05:23:38 -0500
Date: Tue, 5 Dec 2017 17:49:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171205064905.GJ3057@umbus.fritz.box>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
	<6cafcb638eb9c002b16e2459475d8ef7a2440849.1511731946.git.mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LG0Ll82vYr46+VA1"
Content-Disposition: inline
In-Reply-To: <6cafcb638eb9c002b16e2459475d8ef7a2440849.1511731946.git.mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 12/17] e500: add i2c controller to CCSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--LG0Ll82vYr46+VA1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 26, 2017 at 03:59:10PM -0600, Michael Davidsaver wrote:
> Add i2c controller found on mpc8540,
> mpc8544, and P2010 (newer ppc, unmodeled).

This adds it unconditionally.  Are there any E500 models where it
doesn't exist?

>=20
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> ---
>  hw/ppc/e500_ccsr.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/hw/ppc/e500_ccsr.c b/hw/ppc/e500_ccsr.c
> index c479ed91ee..cd8216daaf 100644
> --- a/hw/ppc/e500_ccsr.c
> +++ b/hw/ppc/e500_ccsr.c
> @@ -46,6 +46,8 @@
>  #define E500_ERR_DETECT  (0x2e40)
>  #define E500_ERR_DISABLE (0x2e44)
> =20
> +#define E500_I2C_OFFSET  (0x3000)
> +
>  #define E500_DUART_OFFSET(N) (0x4500 + (N) * 0x100)
> =20
>  #define E500_PORPLLSR    (0xE0000)
> @@ -72,6 +74,7 @@ typedef struct {
>      uint32_t ccb_freq;
> =20
>      DeviceState *pic;
> +    DeviceState *i2c;
>  } CCSRState;
> =20
>  #define TYPE_E500_CCSR "e500-ccsr"
> @@ -272,6 +275,18 @@ static void e500_ccsr_realize(DeviceState *dev, Erro=
r **errp)
>                                  sysbus_mmio_get_region(pic, 0));
>      /* Note: MPIC internal interrupts are offset by 16 */
> =20
> +    /* attach I2C controller */
> +    ccsr->i2c =3D qdev_create(NULL, "mpc8540-i2c");

Ah.. so I think I missed this on many earlier patches.  I believe
you're not generally supposed to create new subdevices at realize()
time.  Instead the device should be created at CCSR instance_init()
time (but the sub device's "realized" property will need to be set to
1 from CCSR realize()).

> +    object_property_add_child(qdev_get_machine(), "i2c[*]",
> +                              OBJECT(ccsr->i2c), NULL);
> +    qdev_init_nofail(ccsr->i2c);
> +    memory_region_add_subregion(&ccsr->iomem, E500_I2C_OFFSET,
> +                                sysbus_mmio_get_region(
> +                                    SYS_BUS_DEVICE(ccsr->i2c), 0));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(ccsr->i2c), 0,
> +                          qdev_get_gpio_in(ccsr->pic, 16 + 27));
> +
> +
>      /* DUARTS */
>      /* for mpc8540, mpc8544, and P2010 (unmodeled), the DUART reference =
clock
>       * is the CCB clock divided by 16.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LG0Ll82vYr46+VA1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlomQWEACgkQbDjKyiDZ
s5KTIxAAlv4+9J1DTqXE9WhlgXDP900nqWXwAT3AYILZcOS8K+iEUlS1MgmjJQUd
W3TQ90J1/vu9e+I+ytlu/4xLPT3/xYYNoVMmKb4iS66hfNDG+LR+0dKxNzwSrxSm
FZe7XxqfPeH5v00xqtTTRgE4l6cUgCFmO5sfddFtASSvJho5ur1hYygoFYjOa0KK
0pykfY09sO+a4DcDVG4WD19ntFoDgRedCOizrBkI1PRrbBOb6oMa1Q7oWSh/afZf
hd/kAMHo7VgyHrSgE+NJZ6tvqYrlvvG4RAYH1kg2RTptldV2N7ZBo7Yer4m5CkQJ
S4KMyBp3t1s/IAgEkK7qZlTNBuYkwVdtTFukbE0jzjVfxmWZqzyDTMne/q2Id5nq
udyRsVvdWwC/miRXZzwb30Fstbarnt8UGSftu0uTDeXzk1cc560MHghVfochelxN
e0LNrZf2WAeQCnWbd3XkSW3lyOFsMozkEYSdIha4+YI1nWL49PTYkrVwQ4SaKeRS
wEAYxL5LC8HWwuUgryFbknIQx2imeJz9IgGLoePgITW0W7Cqge0luC3QYSodHyMx
TVf+tbRGhvJB8RIGUGOJW/vvsq9ep/CsEVcDTlKF0ikBxbS6ejUGXt6qDeBHHFM5
ziJl1/UlwPHOI+/WwTm3nY2bzc8ATVmX74FDQXOJnfj0UJhLwu8=
=fbHQ
-----END PGP SIGNATURE-----

--LG0Ll82vYr46+VA1--
