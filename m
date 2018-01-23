Received: from eggs.gnu.org ([2001:4830:134:3::10]:45575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ee7NC-0006Nl-SY
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:49:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ee7N9-0006mw-OA
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:48:58 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180123030630.26613-11-f4bug@amsat.org>
References: <20180123030630.26613-1-f4bug@amsat.org>
	<20180123030630.26613-11-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 23 Jan 2018 14:48:23 -0800
Message-ID: <CAKmqyKN-XiVF754_6vOYZqh3pQx9LP+NdV7vdNxKU4V3Y1W1aA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 10/14] hw/arm/xilinx_zynqmp: fix the
 capabilities/spec version to match the datasheet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, "open list:Xilinx ZynqMP" <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

On Mon, Jan 22, 2018 at 7:06 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> checking Xilinx datasheet "UG1085" (v1.7)
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/arm/xlnx-zynqmp.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index 325642058b..33d5fe53d8 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -50,6 +50,8 @@
>  #define DPDMA_ADDR          0xfd4c0000
>  #define DPDMA_IRQ           116
>
> +#define SDHCI_CAPABILITIES  0x280737ec6481 /* Datasheet: UG1085 (v1.7) *=
/
> +
>  static const uint64_t gem_addr[XLNX_ZYNQMP_NUM_GEMS] =3D {
>      0xFF0B0000, 0xFF0C0000, 0xFF0D0000, 0xFF0E0000,
>  };
> @@ -381,22 +383,27 @@ static void xlnx_zynqmp_realize(DeviceState *dev, E=
rror **errp)
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->sata), 0, gic_spi[SATA_INTR]);
>
>      for (i =3D 0; i < XLNX_ZYNQMP_NUM_SDHCI; i++) {
> -        char *bus_name;
> -
> -        object_property_set_bool(OBJECT(&s->sdhci[i]), true,
> -                                 "realized", &err);
> +        char *bus_name =3D g_strdup_printf("sd-bus%d", i);
> +        SysBusDevice *sbd =3D SYS_BUS_DEVICE(&s->sdhci[i]);
> +        Object *sdhci =3D OBJECT(&s->sdhci[i]);
> +
> +        /* Compatible with:
> +         * - SD Host Controller Specification Version 3.00
> +         * - SDIO Specification Version 3.0
> +         * - eMMC Specification Version 4.51
> +         */
> +        object_property_set_uint(sdhci, 3, "sd-spec-version", &err);
> +        object_property_set_uint(sdhci, SDHCI_CAPABILITIES, "capareg", &=
err);
> +        object_property_set_bool(sdhci, true, "realized", &err);
>          if (err) {
>              error_propagate(errp, err);
>              return;
>          }
> -        sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci[i]), 0,
> -                        sdhci_addr[i]);
> -        sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci[i]), 0,
> -                           gic_spi[sdhci_intr[i]]);
> +        sysbus_mmio_map(sbd, 0, sdhci_addr[i]);
> +        sysbus_connect_irq(sbd, 0, gic_spi[sdhci_intr[i]]);
> +
>          /* Alias controller SD bus to the SoC itself */
> -        bus_name =3D g_strdup_printf("sd-bus%d", i);
> -        object_property_add_alias(OBJECT(s), bus_name,
> -                                  OBJECT(&s->sdhci[i]), "sd-bus",
> +        object_property_add_alias(OBJECT(s), bus_name, sdhci, "sd-bus",
>                                    &error_abort);
>          g_free(bus_name);
>      }
> --
> 2.15.1
>
>
