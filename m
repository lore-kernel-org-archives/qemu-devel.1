Received: from eggs.gnu.org ([2001:4830:134:3::10]:39842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ejqiQ-0007xR-CO
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 13:14:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ejqiL-0001Z5-LT
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 13:14:34 -0500
Received: from 17.mo7.mail-out.ovh.net ([188.165.35.227]:54938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ejqiL-0001NM-FU
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 13:14:29 -0500
Received: from player697.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 575CA8DCA9
	for <qemu-devel@nongnu.org>; Thu,  8 Feb 2018 19:14:21 +0100 (CET)
References: <20180208172202.9984-1-f4bug@amsat.org>
	<20180208172202.9984-3-f4bug@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <21f7b55b-72d3-5726-ef71-032bac16e6c8@kaod.org>
Date: Thu, 8 Feb 2018 19:14:16 +0100
MIME-Version: 1.0
In-Reply-To: <20180208172202.9984-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/arm/aspeed: simplify using the
 'unimplemented device' for aspeed_soc.io
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org

On 02/08/2018 06:22 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

This looks like a good idea. (Have you actually tried it ?=20
just asking)

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.=20

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
> index a786750e14..3d21128d47 100644
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
> - * IO handlers: simply catch any reads/writes to IO addresses that are=
n't
> - * handled by a device mapping.
> - */
> -
> -static uint64_t aspeed_soc_io_read(void *p, hwaddr offset, unsigned si=
ze)
> -{
> -    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " [%u]\n",
> -                  __func__, offset, size);
> -    return 0;
> -}
> -
> -static void aspeed_soc_io_write(void *opaque, hwaddr offset, uint64_t =
value,
> -                unsigned size)
> -{
> -    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " <- 0x%" PRIx64 " =
[%u]\n",
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
> @@ -199,10 +175,8 @@ static void aspeed_soc_realize(DeviceState *dev, E=
rror **errp)
>      Error *err =3D NULL, *local_err =3D NULL;
> =20
>      /* IO space */
> -    memory_region_init_io(&s->iomem, NULL, &aspeed_soc_io_ops, NULL,
> -            "aspeed_soc.io", ASPEED_SOC_IOMEM_SIZE);
> -    memory_region_add_subregion_overlap(get_system_memory(),
> -                                        ASPEED_SOC_IOMEM_BASE, &s->iom=
em, -1);
> +    create_unimplemented_device("aspeed_soc.io",
> +                                ASPEED_SOC_IOMEM_BASE, ASPEED_SOC_IOME=
M_SIZE);
> =20
>      /* CPU */
>      object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
>=20
