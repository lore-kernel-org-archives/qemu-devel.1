Received: from eggs.gnu.org ([2001:4830:134:3::10]:45116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1el1Kj-000679-DU
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 18:46:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1el1Ki-0006Mu-1r
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 18:46:57 -0500
Message-ID: <1518392803.10440.4.camel@aj.id.au>
From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 12 Feb 2018 10:16:43 +1030
In-Reply-To: <20180209085755.30414-3-f4bug@amsat.org>
References: <20180209085755.30414-1-f4bug@amsat.org>
	<20180209085755.30414-3-f4bug@amsat.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-TpvD1ofaHkNBfHlCabic"
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/arm/aspeed: simplify using the
 'unimplemented device' for aspeed_soc.io
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org


--=-TpvD1ofaHkNBfHlCabic
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-02-09 at 05:57 -0300, Philippe Mathieu-Daud=C3=A9 wrote:
> (qemu) info mtree
>  address-space: cpu-memory-0
>    0000000000000000-ffffffffffffffff (prio 0, i/o): system
>      0000000000000000-0000000007ffffff (prio 0, rom): aspeed.boot_rom
> -    000000001e600000-000000001e7fffff (prio -1, i/o): aspeed_soc.io
> +    000000001e600000-000000001e7fffff (prio -1000, i/o): aspeed_soc.io
>      000000001e620000-000000001e6200ff (prio 0, i/o): aspeed.smc.ast2500-=
fmc
>      000000001e630000-000000001e6300ff (prio 0, i/o): aspeed.smc.ast2500-=
spi1
>      000000001e631000-000000001e6310ff (prio 0, i/o): aspeed.smc.ast2500-=
spi2
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  include/hw/arm/aspeed_soc.h |  1 -
>  hw/arm/aspeed_soc.c         | 32 +++-----------------------------
>  2 files changed, 3 insertions(+), 30 deletions(-)
>=20
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index f26914a2b9..11ec0179db 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -31,7 +31,6 @@ typedef struct AspeedSoCState {
> =20
>      /*< public >*/
>      ARMCPU cpu;
> -    MemoryRegion iomem;
>      MemoryRegion sram;
>      AspeedVICState vic;
>      AspeedTimerCtrlState timerctrl;
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index 2a5d041b3b..30d25f8b06 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -15,6 +15,7 @@
>  #include "qemu-common.h"
>  #include "cpu.h"
>  #include "exec/address-spaces.h"
> +#include "hw/misc/unimp.h"
>  #include "hw/arm/aspeed_soc.h"
>  #include "hw/char/serial.h"
>  #include "qemu/log.h"
> @@ -99,31 +100,6 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
>      },
>  };
> =20
> -/*
> - * IO handlers: simply catch any reads/writes to IO addresses that aren'=
t
> - * handled by a device mapping.
> - */
> -
> -static uint64_t aspeed_soc_io_read(void *p, hwaddr offset, unsigned size=
)
> -{
> -    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " [%u]\n",
> -                  __func__, offset, size);
> -    return 0;
> -}
> -
> -static void aspeed_soc_io_write(void *opaque, hwaddr offset, uint64_t va=
lue,
> -                unsigned size)
> -{
> -    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " <- 0x%" PRIx64 " [%=
u]\n",
> -                  __func__, offset, value, size);
> -}
> -
> -static const MemoryRegionOps aspeed_soc_io_ops =3D {
> -    .read =3D aspeed_soc_io_read,
> -    .write =3D aspeed_soc_io_write,
> -    .endianness =3D DEVICE_LITTLE_ENDIAN,
> -};
> -
>  static void aspeed_soc_init(Object *obj)
>  {
>      AspeedSoCState *s =3D ASPEED_SOC(obj);
> @@ -199,10 +175,8 @@ static void aspeed_soc_realize(DeviceState *dev, Err=
or **errp)
>      Error *err =3D NULL, *local_err =3D NULL;
> =20
>      /* IO space */
> -    memory_region_init_io(&s->iomem, NULL, &aspeed_soc_io_ops, NULL,
> -            "aspeed_soc.io", ASPEED_SOC_IOMEM_SIZE);
> -    memory_region_add_subregion_overlap(get_system_memory(),
> -                                        ASPEED_SOC_IOMEM_BASE, &s->iomem=
, -1);
> +    create_unimplemented_device("aspeed_soc.io",
> +                                ASPEED_SOC_IOMEM_BASE, ASPEED_SOC_IOMEM_=
SIZE);
> =20
>      /* CPU */
>      object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
--=-TpvD1ofaHkNBfHlCabic
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJagNXjAAoJEJ0dnzgO5LT5/LQQAIn/fCv07xrGvbCdMHuMppvU
699TnfphyNyrL0NzCOBHa77X5X5BShHfoAav8v4HPKaWIK1Exm3AV302GezZ0/hy
qwW2AyV332HqvjzcoEPj8kNAh8skcq8EhuclebJPcSWt50eQeE6ep8uA5sBqGMe+
M0cPxs+mDCDi/YsbSFUwAJ1X5ACgBFh89867Z/42oqHHo6vtwmEGIvEaKtX1VW9C
Fh7ziHjhecyDQvntQ9Ms4a/ZuKoOA7nSCx93nLv8Kens8qXpyNu6lZ8rtM2iZt7b
XISMdM98ymxhebbFHIpLowj8MAPp0vVyPhdtb85PEiRqE+2EdYujOQngBK62ACeR
jrq29dhuKCBxF3LGm9y3EV1zGNOCHIQCRHnYjzkh763NOECwTsAE/FqedtummTe8
IYiot3v9TkDsKOV6h0owqDWXInqynk5xpLBCqtm0WJmg02+ol7dhjUEYptsarKNr
GJ7KJyMC+qrbP6u89BCDQrjgJoNyfV12R5D7A7MaadlbVCK5ct6RrbrcITjWi/1i
KJ4AJyJSxttooGQMhhM1h1SIA74VKhiMYlbbhchtqHWV4ZuqVE1wrxXHfLE8TN4e
mXr6KMe8JNVnzv+65trcZ0lvdnDVckEDX9LApPXmtf4ykLJK+urt1xhjiJXQtzYw
wNX4cQRNmMq+ubMsGaiJ
=rM6u
-----END PGP SIGNATURE-----

--=-TpvD1ofaHkNBfHlCabic--
