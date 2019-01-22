Received: from eggs.gnu.org ([209.51.188.92]:37024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gm5qy-0002Fc-DV
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 18:53:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gm5qx-0004h9-0o
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 18:53:12 -0500
MIME-Version: 1.0
References: <20190121154928.32065-1-clg@kaod.org>
In-Reply-To: <20190121154928.32065-1-clg@kaod.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 22 Jan 2019 15:52:41 -0800
Message-ID: <CAKmqyKM4N=4dyH2Az9s0sct3s=8Jj15W6zJM0ea6r4yA28FkAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] aspeed/smc: snoop SPI transfers to fake
 dummy cycles
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrew Jeffery <andrew@aj.id.au>, Francisco Iglesias <frasse.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>

On Mon, Jan 21, 2019 at 7:50 AM C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The m25p80 models dummy cycles using byte transfers. This works well
> when the transfers are initiated by the QEMU model of a SPI controller
> but when these are initiated by the OS, it breaks emulation.
>
> Snoop the SPI transfer to catch commands requiring dummy cycles and
> replace them with byte transfers compatible with the m25p80 model.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  I have had few hacks to work around this problem, Andrew also, but I
>  think that the model for the Xilinx Zynq SPI controller has an
>  elegant solution.
>
>  Tested with on different Linux kernels (OpenBMC, 5.0.0-rcX) and
>  different Linux drivers doing fast read SPI transfers in User
>  mode. It would be good to give the patch a try on other proprietary
>  Firmwares using the USER command mode to access the flash.
>
>  include/hw/ssi/aspeed_smc.h |   3 +
>  hw/ssi/aspeed_smc.c         | 115 +++++++++++++++++++++++++++++++++++-
>  2 files changed, 115 insertions(+), 3 deletions(-)
>
> diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
> index b8b2dfbec280..f3909440d53c 100644
> --- a/include/hw/ssi/aspeed_smc.h
> +++ b/include/hw/ssi/aspeed_smc.h
> @@ -104,6 +104,9 @@ typedef struct AspeedSMCState {
>      AddressSpace dma_as;
>
>      AspeedSMCFlash *flashes;
> +
> +    uint8_t snoop_index;
> +    uint8_t snoop_dummies;
>  } AspeedSMCState;
>
>  #endif /* ASPEED_SMC_H */
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index 0dc22e44cfd4..69683aca61b7 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -166,6 +166,9 @@
>  /* Flash opcodes. */
>  #define SPI_OP_READ       0x03    /* Read data bytes (low frequency) */
>
> +#define SNOOP_OFF         0xFF
> +#define SNOOP_START       0x0
> +
>  /*
>   * Default segments mapping addresses and size for each slave per
>   * controller. These can be changed when board is initialized with the
> @@ -587,6 +590,101 @@ static uint64_t aspeed_smc_flash_read(void *opaque,=
 hwaddr addr, unsigned size)
>      return ret;
>  }
>
> +/*
> + * TODO (clg@kaod.org): stolen from xilinx_spips.c. Should move to a
> + * common include header.
> + */
> +typedef enum {
> +    READ =3D 0x3,         READ_4 =3D 0x13,
> +    FAST_READ =3D 0xb,    FAST_READ_4 =3D 0x0c,
> +    DOR =3D 0x3b,         DOR_4 =3D 0x3c,
> +    QOR =3D 0x6b,         QOR_4 =3D 0x6c,
> +    DIOR =3D 0xbb,        DIOR_4 =3D 0xbc,
> +    QIOR =3D 0xeb,        QIOR_4 =3D 0xec,
> +
> +    PP =3D 0x2,           PP_4 =3D 0x12,
> +    DPP =3D 0xa2,
> +    QPP =3D 0x32,         QPP_4 =3D 0x34,
> +} FlashCMD;
> +
> +static int aspeed_smc_num_dummies(uint8_t command)
> +{
> +    switch (command) { /* check for dummies */
> +    case READ: /* no dummy bytes/cycles */
> +    case PP:
> +    case DPP:
> +    case QPP:
> +    case READ_4:
> +    case PP_4:
> +    case QPP_4:
> +        return 0;
> +    case FAST_READ:
> +    case DOR:
> +    case QOR:
> +    case DOR_4:
> +    case QOR_4:
> +        return 1;
> +    case DIOR:
> +    case FAST_READ_4:
> +    case DIOR_4:
> +        return 2;
> +    case QIOR:
> +    case QIOR_4:
> +        return 4;
> +    default:
> +        return -1;
> +    }
> +}
> +
> +static bool aspeed_smc_do_snoop(AspeedSMCFlash *fl,  uint64_t data,
> +                                unsigned size)
> +{
> +    AspeedSMCState *s =3D fl->controller;
> +    uint8_t addr_width =3D aspeed_smc_flash_is_4byte(fl) ? 4 : 3;
> +
> +    if (s->snoop_index =3D=3D SNOOP_OFF) {
> +        return false; /* Do nothing */
> +
> +    } else if (s->snoop_index =3D=3D SNOOP_START) {
> +        uint8_t cmd =3D data & 0xff;
> +        int ndummies =3D aspeed_smc_num_dummies(cmd);
> +
> +        /*
> +         * No dummy cycles are expected with the current command. Turn
> +         * off snooping and let the transfer proceed normally.
> +         */
> +        if (ndummies <=3D 0) {
> +            s->snoop_index =3D SNOOP_OFF;
> +            return false;
> +        }
> +
> +        s->snoop_dummies =3D ndummies * 8;
> +
> +    } else if (s->snoop_index >=3D addr_width + 1) {
> +
> +        /* The SPI transfer has reached the dummy cycles sequence */
> +        for (; s->snoop_dummies; s->snoop_dummies--) {
> +            ssi_transfer(s->spi, s->regs[R_DUMMY_DATA] & 0xff);
> +        }
> +
> +        /* If no more dummy cycles are expected, turn off snooping */
> +        if (!s->snoop_dummies) {
> +            s->snoop_index =3D SNOOP_OFF;
> +        } else {
> +            s->snoop_index +=3D size;
> +        }
> +
> +        /*
> +         * Dummy cycles have been faked already. Ignore the current
> +         * SPI transfer
> +         */
> +        return true;
> +    }
> +
> +    s->snoop_index +=3D size;
> +    return false;
> +}
> +
>  static void aspeed_smc_flash_write(void *opaque, hwaddr addr, uint64_t d=
ata,
>                                     unsigned size)
>  {
> @@ -602,6 +700,10 @@ static void aspeed_smc_flash_write(void *opaque, hwa=
ddr addr, uint64_t data,
>
>      switch (aspeed_smc_flash_mode(fl)) {
>      case CTRL_USERMODE:
> +        if (aspeed_smc_do_snoop(fl, data, size)) {
> +            break;
> +        }
> +
>          for (i =3D 0; i < size; i++) {
>              ssi_transfer(s->spi, (data >> (8 * i)) & 0xff);
>          }
> @@ -634,7 +736,9 @@ static const MemoryRegionOps aspeed_smc_flash_ops =3D=
 {
>
>  static void aspeed_smc_flash_update_cs(AspeedSMCFlash *fl)
>  {
> -    const AspeedSMCState *s =3D fl->controller;
> +    AspeedSMCState *s =3D fl->controller;
> +
> +    s->snoop_index =3D aspeed_smc_is_ce_stop_active(fl) ? SNOOP_OFF : SN=
OOP_START;
>
>      qemu_set_irq(s->cs_lines[fl->id], aspeed_smc_is_ce_stop_active(fl));
>  }
> @@ -670,6 +774,9 @@ static void aspeed_smc_reset(DeviceState *d)
>      if (s->ctrl->segments =3D=3D aspeed_segments_fmc) {
>          s->regs[s->r_conf] |=3D (CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE0=
);
>      }
> +
> +    s->snoop_index =3D SNOOP_OFF;
> +    s->snoop_dummies =3D 0;
>  }
>
>  static uint64_t aspeed_smc_read(void *opaque, hwaddr addr, unsigned int =
size)
> @@ -1100,10 +1207,12 @@ static void aspeed_smc_realize(DeviceState *dev, =
Error **errp)
>
>  static const VMStateDescription vmstate_aspeed_smc =3D {
>      .name =3D "aspeed.smc",
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> +    .version_id =3D 2,
> +    .minimum_version_id =3D 2,
>      .fields =3D (VMStateField[]) {
>          VMSTATE_UINT32_ARRAY(regs, AspeedSMCState, ASPEED_SMC_R_MAX),
> +        VMSTATE_UINT8(snoop_index, AspeedSMCState),
> +        VMSTATE_UINT8(snoop_dummies, AspeedSMCState),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> --
> 2.20.1
>
>
