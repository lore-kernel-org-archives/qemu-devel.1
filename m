Received: from eggs.gnu.org ([2001:4830:134:3::10]:33506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePzuv-0001PA-NQ
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 19:01:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePzuu-0004X4-Q5
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 19:01:25 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171214020025.4004-3-f4bug@amsat.org>
References: <20171214020025.4004-1-f4bug@amsat.org>
	<20171214020025.4004-3-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 15 Dec 2017 16:00:52 -0800
Message-ID: <CAKmqyKOmR_qrmVAA=CLMUp-AZK-Xz_HYP1wMVO+AWuK973p0kA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/8] sdhci: some ARM boards do support
 SD_HOST_SPECv3_VERS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Andrzej Zaborowski <balrogg@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Clement Deschamps <clement.deschamps@antfield.fr>, Jean-Christophe Dubois <jcd@tribudubois.net>, =?UTF-8?Q?Gr=C3=A9gory_Estrade?= <gregory.estrade@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

On Wed, Dec 13, 2017 at 6:00 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> set the property with object_property_set_uint() or qdev_prop_set_uint8()=
.
>
> [Zynq part based on a patch from Alistair Francis <alistair.francis@xilin=
x.com>
>  from qemu/xilinx tag xilinx-v2015.2]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/arm/bcm2835_peripherals.c | 7 +++++++
>  hw/arm/fsl-imx6.c            | 6 ++++++
>  hw/arm/xilinx_zynq.c         | 2 ++
>  3 files changed, 15 insertions(+)
>
> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
> index 60a0eec4d1..e686725015 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -264,6 +264,13 @@ static void bcm2835_peripherals_realize(DeviceState =
*dev, Error **errp)
>          return;
>      }
>
> +    object_property_set_uint(OBJECT(&s->sdhci), SD_HOST_SPECv3_VERS,
> +                             "sd-spec-version", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
>      object_property_set_bool(OBJECT(&s->sdhci), true, "realized", &err);
>      if (err) {
>          error_propagate(errp, err);
> diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
> index 59ef33efa9..c474e707af 100644
> --- a/hw/arm/fsl-imx6.c
> +++ b/hw/arm/fsl-imx6.c
> @@ -348,6 +348,12 @@ static void fsl_imx6_realize(DeviceState *dev, Error=
 **errp)
>              { FSL_IMX6_uSDHC4_ADDR, FSL_IMX6_uSDHC4_IRQ },
>          };
>
> +        object_property_set_uint(OBJECT(&s->esdhc[i]), SD_HOST_SPECv3_VE=
RS,
> +                                 "sd-spec-version", &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
>          object_property_set_bool(OBJECT(&s->esdhc[i]), true, "realized",=
 &err);
>          if (err) {
>              error_propagate(errp, err);
> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> index 9275ae6daf..0292feea74 100644
> --- a/hw/arm/xilinx_zynq.c
> +++ b/hw/arm/xilinx_zynq.c
> @@ -250,6 +250,7 @@ static void zynq_init(MachineState *machine)
>
>      dev =3D qdev_create(NULL, TYPE_SYSBUS_SDHCI);
>      qdev_prop_set_string(dev, "sd-bus-name", "sd.0");
> +    qdev_prop_set_uint8(dev, "sd-spec-version", SD_HOST_SPECv3_VERS);
>      qdev_init_nofail(dev);
>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xE0100000);
>      sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[56-IRQ_OFFSET]);
> @@ -262,6 +263,7 @@ static void zynq_init(MachineState *machine)
>      object_property_set_bool(OBJECT(carddev), true, "realized", &error_f=
atal);
>
>      dev =3D qdev_create(NULL, TYPE_SYSBUS_SDHCI);
> +    qdev_prop_set_uint8(dev, "sd-spec-version", SD_HOST_SPECv3_VERS);
>      qdev_prop_set_string(dev, "sd-bus-name", "sd.1");
>      qdev_init_nofail(dev);
>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xE0101000);
> --
> 2.15.1
>
>
