Received: from eggs.gnu.org ([2001:4830:134:3::10]:56249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1e80Kb-0001Xv-A8
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 04:49:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1e80Ka-00016f-8Q
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 04:49:33 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:51049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1e80KZ-000168-VD
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 04:49:32 -0400
Received: by mail-wr0-x244.google.com with SMTP id p96so5483664wrb.7
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 01:49:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171027055612.2488-14-frasse.iglesias@gmail.com>
References: <20171027055612.2488-1-frasse.iglesias@gmail.com>
	<20171027055612.2488-14-frasse.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 27 Oct 2017 10:49:00 +0200
Message-ID: <CAKmqyKPh9VXd554dGtBiMeXHvmWLZ8C7+saLJ5Bv+PFVNpqgoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 13/13] xlnx-zcu102: Add support for the
 ZynqMP QSPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Francisco Iglesias <frasse.iglesias@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Edgar Iglesias <edgari@xilinx.com>, Alistair Francis <alistai@xilinx.com>, francisco.iglesias@feimtech.se, "mar.krzeminski" <mar.krzeminski@gmail.com>

On Fri, Oct 27, 2017 at 7:56 AM, Francisco Iglesias
<frasse.iglesias@gmail.com> wrote:
> Add support for the ZynqMP QSPI (consisting of the Generic QSPI and Legacy
> QSPI) and connect Numonyx n25q512a11 flashes to it.
>
> Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> ---
>  hw/arm/xlnx-zcu102.c         | 23 +++++++++++++++++++++++
>  hw/arm/xlnx-zynqmp.c         | 24 ++++++++++++++++++++++++
>  include/hw/arm/xlnx-zynqmp.h |  5 +++++
>  3 files changed, 52 insertions(+)
>
> diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
> index 519a16e..7d61972 100644
> --- a/hw/arm/xlnx-zcu102.c
> +++ b/hw/arm/xlnx-zcu102.c
> @@ -150,6 +150,29 @@ static void xlnx_zynqmp_init(XlnxZCU102 *s, MachineState *machine)
>          sysbus_connect_irq(SYS_BUS_DEVICE(&s->soc.spi[i]), 1, cs_line);
>      }
>
> +    for (i = 0; i < XLNX_ZYNQMP_NUM_QSPI_FLASH; i++) {
> +        SSIBus *spi_bus;
> +        DeviceState *flash_dev;
> +        qemu_irq cs_line;
> +        DriveInfo *dinfo = drive_get_next(IF_MTD);
> +        int bus = i / XLNX_ZYNQMP_NUM_QSPI_BUS_CS;
> +        gchar *bus_name = g_strdup_printf("qspi%d", bus);
> +
> +        spi_bus = (SSIBus *)qdev_get_child_bus(DEVICE(&s->soc), bus_name);
> +        g_free(bus_name);
> +
> +        flash_dev = ssi_create_slave_no_init(spi_bus, "n25q512a11");
> +        if (dinfo) {
> +            qdev_prop_set_drive(flash_dev, "drive", blk_by_legacy_dinfo(dinfo),
> +                                &error_fatal);
> +        }
> +        qdev_init_nofail(flash_dev);
> +
> +        cs_line = qdev_get_gpio_in_named(flash_dev, SSI_GPIO_CS, 0);
> +
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->soc.qspi), i + 1, cs_line);
> +    }
> +
>      /* TODO create and connect IDE devices for ide_drive_get() */
>
>      xlnx_zcu102_binfo.ram_size = ram_size;
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index d4b6560..f7c8b4b 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -40,6 +40,10 @@
>  #define SATA_ADDR           0xFD0C0000
>  #define SATA_NUM_PORTS      2
>
> +#define QSPI_ADDR           0xff0f0000
> +#define LQSPI_ADDR          0xc0000000
> +#define QSPI_IRQ            15
> +
>  #define DP_ADDR             0xfd4a0000
>  #define DP_IRQ              113
>
> @@ -169,6 +173,9 @@ static void xlnx_zynqmp_init(Object *obj)
>          qdev_set_parent_bus(DEVICE(&s->spi[i]), sysbus_get_default());
>      }
>
> +    object_initialize(&s->qspi, sizeof(s->qspi), TYPE_XLNX_ZYNQMP_QSPIPS);
> +    qdev_set_parent_bus(DEVICE(&s->qspi), sysbus_get_default());
> +
>      object_initialize(&s->dp, sizeof(s->dp), TYPE_XLNX_DP);
>      qdev_set_parent_bus(DEVICE(&s->dp), sysbus_get_default());
>
> @@ -405,6 +412,23 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>          g_free(bus_name);
>      }
>
> +    object_property_set_bool(OBJECT(&s->qspi), true, "realized", &err);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->qspi), 0, QSPI_ADDR);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->qspi), 1, LQSPI_ADDR);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->qspi), 0, gic_spi[QSPI_IRQ]);

New line here

> +    for (i = 0; i < XLNX_ZYNQMP_NUM_QSPI_BUS; i++) {
> +        gchar *bus_name;
> +        gchar *target_bus;

New line here

> +        /* Alias controller SPI bus to the SoC itself */
> +        bus_name = g_strdup_printf("qspi%d", i);
> +        target_bus = g_strdup_printf("spi%d", i);
> +        object_property_add_alias(OBJECT(s), bus_name,
> +                                  OBJECT(&s->qspi), target_bus,

Why do we alias qspi to spi?

Alistair

> +                                  &error_abort);
> +        g_free(bus_name);
> +        g_free(target_bus);
> +    }
> +
>      object_property_set_bool(OBJECT(&s->dp), true, "realized", &err);
>      if (err) {
>          error_propagate(errp, err);
> diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
> index 6eff81a..3e6fb9b 100644
> --- a/include/hw/arm/xlnx-zynqmp.h
> +++ b/include/hw/arm/xlnx-zynqmp.h
> @@ -40,6 +40,10 @@
>  #define XLNX_ZYNQMP_NUM_SDHCI 2
>  #define XLNX_ZYNQMP_NUM_SPIS 2
>
> +#define XLNX_ZYNQMP_NUM_QSPI_BUS 2
> +#define XLNX_ZYNQMP_NUM_QSPI_BUS_CS 2
> +#define XLNX_ZYNQMP_NUM_QSPI_FLASH 4
> +
>  #define XLNX_ZYNQMP_NUM_OCM_BANKS 4
>  #define XLNX_ZYNQMP_OCM_RAM_0_ADDRESS 0xFFFC0000
>  #define XLNX_ZYNQMP_OCM_RAM_SIZE 0x10000
> @@ -83,6 +87,7 @@ typedef struct XlnxZynqMPState {
>      SysbusAHCIState sata;
>      SDHCIState sdhci[XLNX_ZYNQMP_NUM_SDHCI];
>      XilinxSPIPS spi[XLNX_ZYNQMP_NUM_SPIS];
> +    XlnxZynqMPQSPIPS qspi;
>      XlnxDPState dp;
>      XlnxDPDMAState dpdma;
>
> --
> 2.9.3
>
>
