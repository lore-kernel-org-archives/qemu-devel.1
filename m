Received: from eggs.gnu.org ([2001:4830:134:3::10]:36547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eaA3U-0001gp-DQ
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 19:52:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eaA3T-0004m5-Eo
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 19:52:16 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180111205626.23291-16-f4bug@amsat.org>
References: <20180111205626.23291-1-f4bug@amsat.org>
	<20180111205626.23291-16-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 12 Jan 2018 16:51:43 -0800
Message-ID: <CAKmqyKNWsr6JjSHSTgpEaCnzZi2btJ4by_og-Ueyodzxy+HJoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 15/21] hw/arm/xilinx_zynqmp: implement
 SDHCI Spec v3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, =?UTF-8?Q?Gr=C3=A9gory_Estrade?= <gregory.estrade@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Jean-Christophe Dubois <jcd@tribudubois.net>, Sai Pavan Boddu <saipava@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>, Clement Deschamps <clement.deschamps@antfield.fr>, Andrew Baumann <Andrew.Baumann@microsoft.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

On Thu, Jan 11, 2018 at 12:56 PM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/arm/xlnx-zynqmp.c | 38 +++++++++++++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 11 deletions(-)
>
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index 325642058b..dacf89c566 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -381,22 +381,38 @@ static void xlnx_zynqmp_realize(DeviceState *dev, E=
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
> +         *
> +         * Host clock rate variable between 0 and 208 MHz
> +         * Transfers the data in SDR104, SDR50, DDR50 modes
> +         * (SDR104 mode: up to 832Mbits/s using 4 parallel data lines)
> +         * Transfers the data in 1 bit and 4 bit SD modes
> +         * UHS speed modes, 1.8V
> +         * voltage switch, tuning commands
> +         */
> +        object_property_set_uint(sdhci, 3, "sd-spec-version", &err);
> +        object_property_set_bool(sdhci, true, "suspend", &err);
> +        object_property_set_bool(sdhci, true, "1v8", &err);
> +        object_property_set_bool(sdhci, true, "64bit", &err);
> +        object_property_set_uint(sdhci, 0b111, "bus-speed", &err);
> +        object_property_set_uint(sdhci, 0b111, "driver-strength", &err);
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
