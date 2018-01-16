Received: from eggs.gnu.org ([2001:4830:134:3::10]:55646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ebaOY-0004zf-Ac
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 18:11:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ebaOW-0001Jc-T5
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 18:11:54 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180111205626.23291-12-f4bug@amsat.org>
References: <20180111205626.23291-1-f4bug@amsat.org>
	<20180111205626.23291-12-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 16 Jan 2018 15:11:20 -0800
Message-ID: <CAKmqyKO83wzFUZdHSPf4bjwtERaOPhPkm8K75z8V3qjjeNKm5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 11/21] hw/arm/xilinx_zynq: implement
 SDHCI Spec v2
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
>  hw/arm/xilinx_zynq.c | 64 ++++++++++++++++++++++++++++++++--------------=
------
>  1 file changed, 40 insertions(+), 24 deletions(-)
>
> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> index 1836a4ed45..9a106db7b7 100644
> --- a/hw/arm/xilinx_zynq.c
> +++ b/hw/arm/xilinx_zynq.c
> @@ -165,10 +165,8 @@ static void zynq_init(MachineState *machine)
>      MemoryRegion *address_space_mem =3D get_system_memory();
>      MemoryRegion *ext_ram =3D g_new(MemoryRegion, 1);
>      MemoryRegion *ocm_ram =3D g_new(MemoryRegion, 1);
> -    DeviceState *dev, *carddev;
> +    DeviceState *dev;
>      SysBusDevice *busdev;
> -    DriveInfo *di;
> -    BlockBackend *blk;
>      qemu_irq pic[64];
>      int n;
>
> @@ -247,27 +245,45 @@ static void zynq_init(MachineState *machine)
>      gem_init(&nd_table[0], 0xE000B000, pic[54-IRQ_OFFSET]);
>      gem_init(&nd_table[1], 0xE000C000, pic[77-IRQ_OFFSET]);
>
> -    dev =3D qdev_create(NULL, TYPE_SYSBUS_SDHCI);
> -    qdev_init_nofail(dev);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xE0100000);
> -    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[56-IRQ_OFFSET]);
> -
> -    di =3D drive_get_next(IF_SD);
> -    blk =3D di ? blk_by_legacy_dinfo(di) : NULL;
> -    carddev =3D qdev_create(qdev_get_child_bus(dev, "sd-bus"), TYPE_SD_C=
ARD);
> -    qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
> -    object_property_set_bool(OBJECT(carddev), true, "realized", &error_f=
atal);
> -
> -    dev =3D qdev_create(NULL, TYPE_SYSBUS_SDHCI);
> -    qdev_init_nofail(dev);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xE0101000);
> -    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[79-IRQ_OFFSET]);
> -
> -    di =3D drive_get_next(IF_SD);
> -    blk =3D di ? blk_by_legacy_dinfo(di) : NULL;
> -    carddev =3D qdev_create(qdev_get_child_bus(dev, "sd-bus"), TYPE_SD_C=
ARD);
> -    qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
> -    object_property_set_bool(OBJECT(carddev), true, "realized", &error_f=
atal);
> +    for (n =3D 0; n < 2; n++) {
> +        int hci_irq =3D n ? 79 : 56;
> +        hwaddr hci_addr =3D n ? 0xE0101000 : 0xE0100000;
> +        DriveInfo *di;
> +        BlockBackend *blk;
> +        DeviceState *carddev;
> +
> +        /* Compatible with:
> +         * - SD Host Controller Specification Version 2.0 Part A2
> +         * - SDIO Specification Version 2.0
> +         * - MMC Specification Version 3.31
> +         *
> +         * - SDMA (single operation DMA)
> +         * - ADMA1 (4 KB boundary limited DMA)
> +         * - ADMA2
> +         *
> +         * - up to seven functions in SD1, SD4, but does not support SPI=
 mode
> +         * - SD high-speed (SDHS) card
> +         * - SD High Capacity (SDHC) card
> +         *
> +         * - Low-speed, 1 KHz to 400 KHz
> +         * - Full-speed, 1 MHz to 50 MHz (25 MB/sec)
> +         */
> +        dev =3D qdev_create(NULL, TYPE_SYSBUS_SDHCI);
> +        qdev_prop_set_uint8(dev, "sd-spec-version", 2);
> +        qdev_prop_set_bit(dev, "adma1", true);
> +        qdev_prop_set_bit(dev, "high-speed", true);
> +        qdev_prop_set_uint16(dev, "max-block-length", 1024);
> +        qdev_init_nofail(dev);
> +        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, hci_addr);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[hci_irq - IRQ_OFF=
SET]);
> +
> +        di =3D drive_get_next(IF_SD);
> +        blk =3D di ? blk_by_legacy_dinfo(di) : NULL;
> +        carddev =3D qdev_create(qdev_get_child_bus(dev, "sd-bus"), TYPE_=
SD_CARD);
> +        qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
> +        object_property_set_bool(OBJECT(carddev), true, "realized",
> +                                 &error_fatal);
> +    }
>
>      dev =3D qdev_create(NULL, TYPE_ZYNQ_XADC);
>      qdev_init_nofail(dev);
> --
> 2.15.1
>
>
