Received: from eggs.gnu.org ([2001:4830:134:3::10]:33058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cOsc2-0001yt-Ao
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:56:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cOsbz-0008Fj-7r
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:56:46 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:35077)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mar.krzeminski@gmail.com>)
	id 1cOsby-0008Eg-Sm
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:56:43 -0500
Received: by mail-lf0-x242.google.com with SMTP id x140so31608360lfa.2
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 12:56:41 -0800 (PST)
References: <20170103203502.25907-1-jcd@tribudubois.net>
From: "mar.krzeminski" <mar.krzeminski@gmail.com>
Message-ID: <66b3383c-65bc-f993-d25e-9871489039de@gmail.com>
Date: Wed, 4 Jan 2017 21:56:37 +0100
MIME-Version: 1.0
In-Reply-To: <20170103203502.25907-1-jcd@tribudubois.net>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3] [i.MX] fix CS handling during SPI
 access.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-devel@nongnu.org, peter.maydell@linaro.org



W dniu 03.01.2017 o 21:35, Jean-Christophe Dubois pisze:
> The i.MX SPI device was not de-asserting the CS line at the end of
> memory access.
>
> This triggered a SIGSEGV in Qemu when the sabrelite emulator was acessing
> a SPI flash memory.
>
> Whit this path the CS signal is correctly asserted and deasserted arround
> memory access.
>
> Assertion level is now based on SPI device configuration.
>
> This was tested by:
> * booting linux on Sabrelite Qemu emulator.
> * booting xvisor on Sabrelite Qemu emultor.
>
> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
> ---
>
> Changes since v1:
> * Fix coding style issue.
>
> Changes since v2:
> * get SS line polarity from config reg.
>
>   hw/ssi/imx_spi.c         | 42 ++++++++++++++++++++++++++++++------------
>   include/hw/ssi/imx_spi.h |  2 ++
>   2 files changed, 32 insertions(+), 12 deletions(-)
>
> diff --git a/hw/ssi/imx_spi.c b/hw/ssi/imx_spi.c
> index e4e395f..3cbf279 100644
> --- a/hw/ssi/imx_spi.c
> +++ b/hw/ssi/imx_spi.c
> @@ -141,6 +141,18 @@ static bool imx_spi_channel_is_master(IMXSPIState *s)
>       return (mode & (1 << imx_spi_selected_channel(s))) ? true : false;
>   }
>   
> +static uint8_t imx_spi_channel_pol(IMXSPIState *s, uint8_t channel)
> +{
channel variable is unused. Should be instead of 
imx_spi_selected_channel() call?
> +    uint8_t pol = EXTRACT(s->regs[ECSPI_CONFIGREG], ECSPI_CONFIGREG_SS_POL);
> +
> +    return pol & (1 << imx_spi_selected_channel(s)) ? 1 : 0;
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
> @@ -152,13 +164,16 @@ static bool imx_spi_is_multiple_master_burst(IMXSPIState *s)
>   
>   static void imx_spi_flush_txfifo(IMXSPIState *s)
>   {
> -    uint32_t tx;
> -    uint32_t rx;
> -
>       DPRINTF("Begin: TX Fifo Size = %d, RX Fifo Size = %d\n",
>               fifo32_num_used(&s->tx_fifo), fifo32_num_used(&s->rx_fifo));
>   
> +    /* Activate the requested CS line */
> +    qemu_set_irq(s->cs_lines[imx_spi_selected_channel(s)],
> +                 imx_spi_current_channel_pol(s));
> +
>       while (!fifo32_is_empty(&s->tx_fifo)) {
> +        uint32_t tx;
> +        uint32_t rx = 0;
>           int tx_burst = 0;
>           int index = 0;
>   
> @@ -178,8 +193,6 @@ static void imx_spi_flush_txfifo(IMXSPIState *s)
>   
>           tx_burst = MIN(s->burst_length, 32);
>   
> -        rx = 0;
> -
>           while (tx_burst) {
>               uint8_t byte = tx & 0xff;
>   
> @@ -221,6 +234,12 @@ static void imx_spi_flush_txfifo(IMXSPIState *s)
>           s->regs[ECSPI_STATREG] |= ECSPI_STATREG_TC;
>       }
>   
> +    /* Deselect all SS lines if transfert if completed */
> +    if (s->regs[ECSPI_STATREG] & ECSPI_STATREG_TC) {
> +        qemu_set_irq(s->cs_lines[imx_spi_selected_channel(s)],
> +                     !imx_spi_current_channel_pol(s));
> +    }
> +
>       /* TODO: We should also use TDR and RDR bits */
>   
>       DPRINTF("End: TX Fifo Size = %d, RX Fifo Size = %d\n",
> @@ -230,6 +249,7 @@ static void imx_spi_flush_txfifo(IMXSPIState *s)
>   static void imx_spi_reset(DeviceState *dev)
>   {
>       IMXSPIState *s = IMX_SPI(dev);
> +    uint32_t i;
>   
>       DPRINTF("\n");
>   
> @@ -243,6 +263,11 @@ static void imx_spi_reset(DeviceState *dev)
>       imx_spi_update_irq(s);
>   
>       s->burst_length = 0;
> +
> +    /* Disable all CS lines */
> +    for (i = 0; i < 4; i++) {
> +        qemu_set_irq(s->cs_lines[i], !imx_spi_channel_pol(s, i));
> +    }
Please make sure that in HW ECSPI_CONFIGREG_SS_POL bits are 0's after 
reset/power up (defaults).

Otherwise Acked-by: Marcin Krzemiñski <mar.krzeminski@gmail.com>

Thanks,
Marcin
>   }
>   
>   static uint64_t imx_spi_read(void *opaque, hwaddr offset, unsigned size)
> @@ -359,15 +384,8 @@ static void imx_spi_write(void *opaque, hwaddr offset, uint64_t value,
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
> diff --git a/include/hw/ssi/imx_spi.h b/include/hw/ssi/imx_spi.h
> index 7103953..b9b9819 100644
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
