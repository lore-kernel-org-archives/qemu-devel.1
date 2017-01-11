Received: from eggs.gnu.org ([2001:4830:134:3::10]:56590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cRMFP-0007bT-NC
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:59:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cRMFK-0003Le-Hj
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:59:39 -0500
Received: from relay6-d.mail.gandi.net ([2001:4b98:c:538::198]:49778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1cRMFK-0003LU-8t
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:59:34 -0500
References: <20170111165225.3357-1-jcd@tribudubois.net>
From: Jean-Christophe DUBOIS <jcd@tribudubois.net>
Message-ID: <9796fd7c-0c66-6aa6-a7bd-59aff8c1fa46@tribudubois.net>
Date: Wed, 11 Jan 2017 17:59:29 +0100
MIME-Version: 1.0
In-Reply-To: <20170111165225.3357-1-jcd@tribudubois.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5] hw/ssi/imx_spi.c: fix CS handling
 during SPI access.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mar.krzeminski@gmail.com
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

Marcin,

I think that things have changed enough so that you could check again 
this version.

JC

Le 11/01/2017 à 17:52, Jean-Christophe Dubois a écrit :
> The i.MX SPI device was not de-asserting the CS line at the end of
> memory access.
>
> This triggered a SIGSEGV in Qemu when the sabrelite emulator was acessing
> a SPI flash memory.
>
> Whith this path the CS signal is correctly asserted and deasserted arround
> memory access.
>
> Assertion level is now based on SPI device configuration.
>
> This was tested by:
> * booting linux on Sabrelite Qemu emulator.
> * booting xvisor on Sabrelite Qemu emultor.
>
> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
> Acked-by: Marcin Krzemiński <mar.krzeminski@gmail.com>
> ---
>
> Changes since v1:
> * Fix coding style issue.
>
> Changes since v2:
> * get SS line polarity from config reg.
>
> Changes since v3:
> * Fix imx_spi_channel_pol() after review
>
> Changes since v4:
> * Fix the handling of CS signal in case of multi master burst.
> * added a field to the state object
> * bump up version_if for state object
> * Add a post_load handler
>
>   hw/ssi/imx_spi.c         | 135 ++++++++++++++++++++++++++++++++++-------------
>   include/hw/ssi/imx_spi.h |   4 ++
>   2 files changed, 103 insertions(+), 36 deletions(-)
>
> diff --git a/hw/ssi/imx_spi.c b/hw/ssi/imx_spi.c
> index e4e395f..202a77b 100644
> --- a/hw/ssi/imx_spi.c
> +++ b/hw/ssi/imx_spi.c
> @@ -56,19 +56,6 @@ static const char *imx_spi_reg_name(uint32_t reg)
>       }
>   }
>   
> -static const VMStateDescription vmstate_imx_spi = {
> -    .name = TYPE_IMX_SPI,
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> -    .fields = (VMStateField[]) {
> -        VMSTATE_FIFO32(tx_fifo, IMXSPIState),
> -        VMSTATE_FIFO32(rx_fifo, IMXSPIState),
> -        VMSTATE_INT16(burst_length, IMXSPIState),
> -        VMSTATE_UINT32_ARRAY(regs, IMXSPIState, ECSPI_MAX),
> -        VMSTATE_END_OF_LIST()
> -    },
> -};
> -
>   static void imx_spi_txfifo_reset(IMXSPIState *s)
>   {
>       fifo32_reset(&s->tx_fifo);
> @@ -119,6 +106,32 @@ static void imx_spi_update_irq(IMXSPIState *s)
>       DPRINTF("IRQ level is %d\n", level);
>   }
>   
> +static int imx_spi_post_load(void *opaque, int version_id)
> +{
> +    IMXSPIState *s = (IMXSPIState *)opaque;
> +
> +    imx_spi_update_irq(s);
> +
> +    /* TODO: We should also restore the CS line level */
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_imx_spi = {
> +    .name = TYPE_IMX_SPI,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_FIFO32(tx_fifo, IMXSPIState),
> +        VMSTATE_FIFO32(rx_fifo, IMXSPIState),
> +        VMSTATE_INT16(burst_length, IMXSPIState),
> +        VMSTATE_UINT32_ARRAY(regs, IMXSPIState, ECSPI_MAX),
> +        VMSTATE_INT16(txfifo_burst_count, IMXSPIState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +    .post_load = imx_spi_post_load,
> +};
> +
>   static uint8_t imx_spi_selected_channel(IMXSPIState *s)
>   {
>       return EXTRACT(s->regs[ECSPI_CONREG], ECSPI_CONREG_CHANNEL_SELECT);
> @@ -141,6 +154,18 @@ static bool imx_spi_channel_is_master(IMXSPIState *s)
>       return (mode & (1 << imx_spi_selected_channel(s))) ? true : false;
>   }
>   
> +static uint8_t imx_spi_channel_pol(IMXSPIState *s, uint8_t channel)
> +{
> +    uint8_t pol = EXTRACT(s->regs[ECSPI_CONFIGREG], ECSPI_CONFIGREG_SS_POL);
> +
> +    return pol & (1 << channel) ? 1 : 0;
> +}
> +
> +static uint8_t imx_spi_current_channel_pol(IMXSPIState *s)
> +{
> +    return imx_spi_channel_pol(s, imx_spi_selected_channel(s));
> +}
> +
>   static bool imx_spi_is_multiple_master_burst(IMXSPIState *s)
>   {
>       uint8_t wave = EXTRACT(s->regs[ECSPI_CONFIGREG], ECSPI_CONFIGREG_SS_CTL);
> @@ -152,24 +177,34 @@ static bool imx_spi_is_multiple_master_burst(IMXSPIState *s)
>   
>   static void imx_spi_flush_txfifo(IMXSPIState *s)
>   {
> -    uint32_t tx;
> -    uint32_t rx;
> -
>       DPRINTF("Begin: TX Fifo Size = %d, RX Fifo Size = %d\n",
>               fifo32_num_used(&s->tx_fifo), fifo32_num_used(&s->rx_fifo));
>   
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
> +
>       while (!fifo32_is_empty(&s->tx_fifo)) {
> -        int tx_burst = 0;
> -        int index = 0;
> +        uint32_t tx;
> +        uint32_t rx = 0;
> +        uint32_t tx_burst = 0;
> +        uint32_t index = 0;
>   
>           if (s->burst_length <= 0) {
>               s->burst_length = imx_spi_burst_length(s);
>   
>               DPRINTF("Burst length = %d\n", s->burst_length);
>   
> -            if (imx_spi_is_multiple_master_burst(s)) {
> -                s->regs[ECSPI_CONREG] |= ECSPI_CONREG_XCH;
> -            }
> +            /* Activate the requested CS line if not already active */
> +            qemu_set_irq(s->cs_lines[imx_spi_selected_channel(s)],
> +                         imx_spi_current_channel_pol(s));
>           }
>   
>           tx = fifo32_pop(&s->tx_fifo);
> @@ -178,8 +213,6 @@ static void imx_spi_flush_txfifo(IMXSPIState *s)
>   
>           tx_burst = MIN(s->burst_length, 32);
>   
> -        rx = 0;
> -
>           while (tx_burst) {
>               uint8_t byte = tx & 0xff;
>   
> @@ -208,17 +241,20 @@ static void imx_spi_flush_txfifo(IMXSPIState *s)
>           }
>   
>           if (s->burst_length <= 0) {
> -            s->regs[ECSPI_CONREG] &= ~ECSPI_CONREG_XCH;
> -
>               if (!imx_spi_is_multiple_master_burst(s)) {
> -                s->regs[ECSPI_STATREG] |= ECSPI_STATREG_TC;
> -                break;
> +                /*
> +                 * If we are not in muti master mode we need to
> +                 * deselect SS lines at each burst
> +                 */
> +                qemu_set_irq(s->cs_lines[imx_spi_selected_channel(s)],
> +                            !imx_spi_current_channel_pol(s));
>               }
>           }
>       }
>   
>       if (fifo32_is_empty(&s->tx_fifo)) {
>           s->regs[ECSPI_STATREG] |= ECSPI_STATREG_TC;
> +        s->regs[ECSPI_CONREG] &= ~ECSPI_CONREG_XCH;
>       }
>   
>       /* TODO: We should also use TDR and RDR bits */
> @@ -243,6 +279,7 @@ static void imx_spi_reset(DeviceState *dev)
>       imx_spi_update_irq(s);
>   
>       s->burst_length = 0;
> +    s->txfifo_burst_count = 0;
>   }
>   
>   static uint64_t imx_spi_read(void *opaque, hwaddr offset, unsigned size)
> @@ -346,28 +383,29 @@ static void imx_spi_write(void *opaque, hwaddr offset, uint64_t value,
>       case ECSPI_STATREG:
>           /* the RO and TC bits are write-one-to-clear */
>           value &= ECSPI_STATREG_RO | ECSPI_STATREG_TC;
> -        s->regs[ECSPI_STATREG] &= ~value;
> +        s->regs[index] &= ~value;
>   
>           break;
>       case ECSPI_CONREG:
> -        s->regs[ECSPI_CONREG] = value;
> +        s->regs[index] = value;
>   
>           if (!imx_spi_is_enabled(s)) {
> +            uint32_t i;
> +
>               /* device is disabled, so this is a reset */
>               imx_spi_reset(DEVICE(s));
> +
> +            /* Disable all CS lines */
> +            for (i = 0; i < 4; i++) {
> +                qemu_set_irq(s->cs_lines[i], !imx_spi_channel_pol(s, i));
> +            }
> +
>               return;
>           }
>   
>           if (imx_spi_channel_is_master(s)) {
> -            int i;
> -
>               /* We are in master mode */
>   
> -            for (i = 0; i < 4; i++) {
> -                qemu_set_irq(s->cs_lines[i],
> -                             i == imx_spi_selected_channel(s) ? 0 : 1);
> -            }
> -
>               if ((value & change_mask & ECSPI_CONREG_SMC) &&
>                   !fifo32_is_empty(&s->tx_fifo)) {
>                   /* SMC bit is set and TX FIFO has some slots filled in */
> @@ -380,6 +418,30 @@ static void imx_spi_write(void *opaque, hwaddr offset, uint64_t value,
>           }
>   
>           break;
> +    case ECSPI_INTREG:
> +        s->regs[index] = value;
> +
> +        /* Disable CS lines */
> +        if ((value == 0) && (s->txfifo_burst_count > 1)) {
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
> +            s->txfifo_burst_count = 0;
> +        }
> +
> +        break;
>       default:
>           s->regs[index] = value;
>   
> @@ -425,6 +487,7 @@ static void imx_spi_realize(DeviceState *dev, Error **errp)
>       }
>   
>       s->burst_length = 0;
> +    s->txfifo_burst_count = 0;
>   
>       fifo32_create(&s->tx_fifo, ECSPI_FIFO_SIZE);
>       fifo32_create(&s->rx_fifo, ECSPI_FIFO_SIZE);
> diff --git a/include/hw/ssi/imx_spi.h b/include/hw/ssi/imx_spi.h
> index 7103953..cfebd07 100644
> --- a/include/hw/ssi/imx_spi.h
> +++ b/include/hw/ssi/imx_spi.h
> @@ -46,6 +46,8 @@
>   /* ECSPI_CONFIGREG */
>   #define ECSPI_CONFIGREG_SS_CTL_SHIFT 8
>   #define ECSPI_CONFIGREG_SS_CTL_LENGTH 4
> +#define ECSPI_CONFIGREG_SS_POL_SHIFT 12
> +#define ECSPI_CONFIGREG_SS_POL_LENGTH 4
>   
>   /* ECSPI_INTREG */
>   #define ECSPI_INTREG_TEEN (1 << 0)
> @@ -98,6 +100,8 @@ typedef struct IMXSPIState {
>       Fifo32 tx_fifo;
>   
>       int16_t burst_length;
> +
> +    int16_t txfifo_burst_count;
>   } IMXSPIState;
>   
>   #endif /* IMX_SPI_H */
