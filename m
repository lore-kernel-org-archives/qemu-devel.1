Received: from eggs.gnu.org ([2001:4830:134:3::10]:60905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ee94x-0003Hp-BT
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 19:39:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ee93t-0008DE-6v
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 19:38:15 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180123020820.1288-17-f4bug@amsat.org>
References: <20180123020820.1288-1-f4bug@amsat.org>
	<20180123020820.1288-17-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 23 Jan 2018 16:36:36 -0800
Message-ID: <CAKmqyKMDrb2VJsndm1X1Bk_iPmLJ_MpSAx6DJqJ49_d1B7-3Dw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 16/16] hw/arm/xilinx_zynq: fix the
 capabilities register to match the datasheet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Kevin O'Connor <kevin@koconnor.net>, "open list:Xilinx Zynq" <qemu-arm@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

On Mon, Jan 22, 2018 at 6:08 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> checking Xilinx datasheet "UG585" (v1.12.1)
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/arm/xilinx_zynq.c | 53 ++++++++++++++++++++++++++++------------------=
------
>  tests/sdhci-test.c   |  5 +++++
>  2 files changed, 34 insertions(+), 24 deletions(-)
>
> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> index 1836a4ed45..0f76333770 100644
> --- a/hw/arm/xilinx_zynq.c
> +++ b/hw/arm/xilinx_zynq.c
> @@ -61,6 +61,8 @@ static const int dma_irqs[8] =3D {
>  #define SLCR_XILINX_UNLOCK_KEY  0xdf0d
>  #define SLCR_XILINX_LOCK_KEY    0x767b
>
> +#define ZYNQ_SDHCI_CAPABILITIES 0x69ec0080  /* Datasheet: UG585 (v1.12.1=
) */
> +
>  #define ARMV7_IMM16(x) (extract32((x),  0, 12) | \
>                          extract32((x), 12,  4) << 16)
>
> @@ -165,10 +167,8 @@ static void zynq_init(MachineState *machine)
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
> @@ -247,27 +247,32 @@ static void zynq_init(MachineState *machine)
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
> +         */
> +        dev =3D qdev_create(NULL, TYPE_SYSBUS_SDHCI);
> +        qdev_prop_set_uint8(dev, "sd-spec-version", 2);
> +        qdev_prop_set_uint64(dev, "capareg", ZYNQ_SDHCI_CAPABILITIES);
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
> diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
> index 094e0570e1..aae2cfc1b5 100644
> --- a/tests/sdhci-test.c
> +++ b/tests/sdhci-test.c
> @@ -41,6 +41,11 @@ static const struct sdhci_t {
>      /* Exynos4210 */
>      { "arm",    "smdkc210",
>          {0x12510000, 2, 0,  {1, 0x5e80080} } },
> +
> +    /* Zynq-7000 */
> +    { "arm",    "xilinx-zynq-a9",   /* Datasheet: UG585 (v1.12.1) */
> +        {0xe0100000, 2, 0,  {1, 0x69ec0080} } },
> +
>  };
>
>  static struct {
> --
> 2.15.1
>
>
