Received: from eggs.gnu.org ([2001:4830:134:3::10]:34507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTAzH-0004UZ-1J
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:22:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTAzF-0007Bx-LG
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:22:31 -0500
Received: from mail-vk0-x234.google.com ([2607:f8b0:400c:c05::234]:36422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cTAzF-0007Bq-8I
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:22:29 -0500
Received: by mail-vk0-x234.google.com with SMTP id t8so77060316vke.3
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 09:22:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170111200019.31314-1-jcd@tribudubois.net>
References: <20170111200019.31314-1-jcd@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jan 2017 17:22:08 +0000
Message-ID: <CAFEAcA8nRyp2CmbXKkf7HnRHZp=xxFEhRBt6r67FJ1KOukP9gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6] hw/ssi/imx_spi.c: fix CS handling
 during SPI access.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Marcin_Krzemi=C5=84ski?= <mar.krzeminski@gmail.com>

On 11 January 2017 at 20:00, Jean-Christophe Dubois <jcd@tribudubois.net> w=
rote:
> The i.MX SPI device was not de-asserting the CS line at the end of
> memory access.
>
> This triggered a SIGSEGV in Qemu when the sabrelite emulator was acessing
> a SPI flash memory.
>
> Whith this path the CS signal is correctly asserted and deasserted arroun=
d
> memory access.
>
> Assertion level is now based on SPI device configuration.
>
> This was tested by:
> * booting linux on Sabrelite Qemu emulator.
> * booting xvisor on Sabrelite Qemu emultor.
>
> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
> Acked-by: Marcin Krzemi=C5=84ski <mar.krzeminski@gmail.com>

>  hw/ssi/imx_spi.c         | 148 ++++++++++++++++++++++++++++++++++++-----=
------
>  include/hw/ssi/imx_spi.h |   4 ++
>  2 files changed, 117 insertions(+), 35 deletions(-)
>
> diff --git a/hw/ssi/imx_spi.c b/hw/ssi/imx_spi.c
> index e4e395f..d54c145 100644
> --- a/hw/ssi/imx_spi.c
> +++ b/hw/ssi/imx_spi.c
> @@ -56,19 +56,6 @@ static const char *imx_spi_reg_name(uint32_t reg)
>      }
>  }
>
> -static const VMStateDescription vmstate_imx_spi =3D {
> -    .name =3D TYPE_IMX_SPI,
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> -    .fields =3D (VMStateField[]) {
> -        VMSTATE_FIFO32(tx_fifo, IMXSPIState),
> -        VMSTATE_FIFO32(rx_fifo, IMXSPIState),
> -        VMSTATE_INT16(burst_length, IMXSPIState),
> -        VMSTATE_UINT32_ARRAY(regs, IMXSPIState, ECSPI_MAX),
> -        VMSTATE_END_OF_LIST()
> -    },
> -};
> -
>  static void imx_spi_txfifo_reset(IMXSPIState *s)
>  {
>      fifo32_reset(&s->tx_fifo);
> @@ -119,6 +106,32 @@ static void imx_spi_update_irq(IMXSPIState *s)
>      DPRINTF("IRQ level is %d\n", level);
>  }
>
> +static int imx_spi_post_load(void *opaque, int version_id)
> +{
> +    IMXSPIState *s =3D (IMXSPIState *)opaque;
> +
> +    imx_spi_update_irq(s);
> +
> +    /* TODO: We should also restore the CS line level */

I don't think you should need to do anything here -- if
this device's state has been restored and the state at
the other end of the line has been restored, there's nothing
else to do. It's like reset, you don't want to be asserting
irq lines in post_load.

> +    if (imx_spi_is_multiple_master_burst(s)) {
> +        /*
> +         * If we are in multi master burst mode we need to call this
> +         * function at least 2 times before deselecting the CS line.
> +         * In practice the transfert ends (and the CS is deselected)
> +         * when the guest write 0 to the INT reg (according to linux
> +         * driver code).
> +         */
> +        s->txfifo_burst_count++;
> +    }

> @@ -380,6 +433,30 @@ static void imx_spi_write(void *opaque, hwaddr offse=
t, uint64_t value,
>          }
>
>          break;
> +    case ECSPI_INTREG:
> +        s->regs[index] =3D value;
> +
> +        /* Disable CS lines */
> +        if ((value =3D=3D 0) && (s->txfifo_burst_count > 1)) {
> +            /*
> +             * When 0 is writen to the INT register (disabling all
> +             * interrupts) we need to deselect the device CS line.
> +             * But only if the txfifo function has been called at
> +             * least twice.
> +             * Note: This seems a bit hacky and I would preffer to
> +             * rely on something else to deselect the CS line. But it
> +             * works correctly with the linux driver.
> +             */
> +
> +            /* Deactivate the current CS line */
> +            qemu_set_irq(s->cs_lines[imx_spi_selected_channel(s)],
> +                         !imx_spi_current_channel_pol(s));
> +
> +            /* reset the txfifo count to 0 */
> +            s->txfifo_burst_count =3D 0;
> +        }

I think this is a bad idea. We have one or two devices which have
similar kinds of hacky code in them that knows what the Linux
driver does. The problem is then twofold:
 (1) if the Linux driver changes then the hacks break
 (2) it's almost impossible to remove the hacks later, because
     the reasoning behind them (which guest kernels are affected,
     etc) gets lost and you don't know whether you're going to
     break previously-working setups if you try to remove the
     hack code

I think we really should try to get this right from the start
(ie "behave like the hardware does").

thanks
-- PMM
