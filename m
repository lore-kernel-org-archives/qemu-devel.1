Received: from eggs.gnu.org ([209.51.188.92]:38995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gmmZW-0000ax-Ey
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 16:30:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gmmZV-000196-MX
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 16:30:02 -0500
MIME-Version: 1.0
References: <20190124140519.13838-1-clg@kaod.org>
	<20190124140519.13838-4-clg@kaod.org>
In-Reply-To: <20190124140519.13838-4-clg@kaod.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 24 Jan 2019 13:29:31 -0800
Message-ID: <CAKmqyKN3xpBkB5C52RcQOvs-Ra8hmcUETP3FgGRyCntgtp_0Pg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] aspeed/smc: Add dummy data register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrew Jeffery <andrew@aj.id.au>, Alistair Francis <alistair@alistair23.me>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>

On Thu, Jan 24, 2019 at 6:06 AM C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The SMC controllers have a register containing the byte that will be
> used as dummy output. It can be modified by software.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/ssi/aspeed_smc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index 6045ca11b969..9f3b6f4b4501 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -98,8 +98,8 @@
>  /* Misc Control Register #1 */
>  #define R_MISC_CTRL1      (0x50 / 4)
>
> -/* Misc Control Register #2 */
> -#define R_MISC_CTRL2      (0x54 / 4)
> +/* SPI dummy cycle data */
> +#define R_DUMMY_DATA      (0x54 / 4)
>
>  /* DMA Control/Status Register */
>  #define R_DMA_CTRL        (0x80 / 4)
> @@ -529,7 +529,7 @@ static void aspeed_smc_flash_setup(AspeedSMCFlash *fl=
, uint32_t addr)
>       */
>      if (aspeed_smc_flash_mode(fl) =3D=3D CTRL_FREADMODE) {
>          for (i =3D 0; i < aspeed_smc_flash_dummies(fl); i++) {
> -            ssi_transfer(fl->controller->spi, 0xFF);
> +            ssi_transfer(fl->controller->spi, s->regs[R_DUMMY_DATA] & 0x=
ff);
>          }
>      }
>  }
> @@ -664,6 +664,7 @@ static uint64_t aspeed_smc_read(void *opaque, hwaddr =
addr, unsigned int size)
>          addr =3D=3D s->r_timings ||
>          addr =3D=3D s->r_ce_ctrl ||
>          addr =3D=3D R_INTR_CTRL ||
> +        addr =3D=3D R_DUMMY_DATA ||
>          (addr >=3D R_SEG_ADDR0 && addr < R_SEG_ADDR0 + s->ctrl->max_slav=
es) ||
>          (addr >=3D s->r_ctrl0 && addr < s->r_ctrl0 + s->ctrl->max_slaves=
)) {
>          return s->regs[addr];
> @@ -697,6 +698,8 @@ static void aspeed_smc_write(void *opaque, hwaddr add=
r, uint64_t data,
>          if (value !=3D s->regs[R_SEG_ADDR0 + cs]) {
>              aspeed_smc_flash_set_segment(s, cs, value);
>          }
> +    } else if (addr =3D=3D R_DUMMY_DATA) {
> +        s->regs[addr] =3D value & 0xff;
>      } else {
>          qemu_log_mask(LOG_UNIMP, "%s: not implemented: 0x%" HWADDR_PRIx =
"\n",
>                        __func__, addr);
> --
> 2.20.1
>
>
