Received: from eggs.gnu.org ([2001:4830:134:3::10]:59482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cOSjL-0000Xx-Rm
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 12:18:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cOSjG-00004r-Ts
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 12:18:35 -0500
Received: from mail-wj0-x244.google.com ([2a00:1450:400c:c01::244]:33190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mar.krzeminski@gmail.com>)
	id 1cOSjG-0008WO-N0
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 12:18:30 -0500
Received: by mail-wj0-x244.google.com with SMTP id kp2so72611310wjc.0
	for <qemu-devel@nongnu.org>; Tue, 03 Jan 2017 09:18:30 -0800 (PST)
References: <20170102211104.4753-1-jcd@tribudubois.net>
From: "mar.krzeminski" <mar.krzeminski@gmail.com>
Message-ID: <0dbadac5-5e70-df78-ce0f-6aceaba8da14@gmail.com>
Date: Tue, 3 Jan 2017 18:18:27 +0100
MIME-Version: 1.0
In-Reply-To: <20170102211104.4753-1-jcd@tribudubois.net>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] [i.MX] fix CS handling during SPI
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

Hello JC,

W dniu 02.01.2017 o 22:11, Jean-Christophe Dubois pisze:
> The i.MX SPI device was not de-asserting the CS line at the end of
> memory access.
>
> This triggered a SIGSEGV in Qemu when the sabrelite emulator was acessing
> a SPI flash memory.
>
> Whit this path the CS signal is correctly asserted and deasserted arround
> memory access.
This code assume, that iMX SPI does not support devices which
are active when CS signal is asserted. I have not read datasheet,
but if iMX SPI can support such devices I think it could be better to
implement such functionality in model - even if currently in Qemu you 
will not use it.
If you will stick in deasserted CS line as active, please see comments 
below.
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
>   hw/ssi/imx_spi.c | 33 ++++++++++++++++++++++-----------
>   1 file changed, 22 insertions(+), 11 deletions(-)
>
> diff --git a/hw/ssi/imx_spi.c b/hw/ssi/imx_spi.c
> index e4e395f..c2d293c 100644
> --- a/hw/ssi/imx_spi.c
> +++ b/hw/ssi/imx_spi.c
> @@ -152,13 +152,20 @@ static bool imx_spi_is_multiple_master_burst(IMXSPIState *s)
>   
>   static void imx_spi_flush_txfifo(IMXSPIState *s)
>   {
> -    uint32_t tx;
> -    uint32_t rx;
> +    uint32_t i;
>   
>       DPRINTF("Begin: TX Fifo Size = %d, RX Fifo Size = %d\n",
>               fifo32_num_used(&s->tx_fifo), fifo32_num_used(&s->rx_fifo));
>   
> +    /* Activate the requested CS line */
> +    for (i = 0; i < 4; i++) {
> +        qemu_set_irq(s->cs_lines[i],
> +                     i == imx_spi_selected_channel(s) ? 0 : 1);
> +    }
Since you are setting to 1 all cs lines in reset, this loop could be
removed, and only selected cs line could be de-asserted.
> +
>       while (!fifo32_is_empty(&s->tx_fifo)) {
> +        uint32_t tx;
> +        uint32_t rx = 0;
>           int tx_burst = 0;
>           int index = 0;
>   
> @@ -178,8 +185,6 @@ static void imx_spi_flush_txfifo(IMXSPIState *s)
>   
>           tx_burst = MIN(s->burst_length, 32);
>   
> -        rx = 0;
> -
>           while (tx_burst) {
>               uint8_t byte = tx & 0xff;
>   
> @@ -221,6 +226,13 @@ static void imx_spi_flush_txfifo(IMXSPIState *s)
>           s->regs[ECSPI_STATREG] |= ECSPI_STATREG_TC;
>       }
>   
> +    /* Deselect all SS lines if transfert if completed */
> +    if (s->regs[ECSPI_STATREG] & ECSPI_STATREG_TC) {
> +        for (i = 0; i < 4; i++) {
> +            qemu_set_irq(s->cs_lines[i], 1);
> +        }
> +    }
> +
Same as above.

Thanks,
Marcin
>       /* TODO: We should also use TDR and RDR bits */
>   
>       DPRINTF("End: TX Fifo Size = %d, RX Fifo Size = %d\n",
> @@ -230,6 +242,7 @@ static void imx_spi_flush_txfifo(IMXSPIState *s)
>   static void imx_spi_reset(DeviceState *dev)
>   {
>       IMXSPIState *s = IMX_SPI(dev);
> +    uint32_t i;
>   
>       DPRINTF("\n");
>   
> @@ -243,6 +256,11 @@ static void imx_spi_reset(DeviceState *dev)
>       imx_spi_update_irq(s);
>   
>       s->burst_length = 0;
> +
> +    /* Disable all CS lines */
> +    for (i = 0; i < 4; i++) {
> +        qemu_set_irq(s->cs_lines[i], 1);
> +    }
>   }
>   
>   static uint64_t imx_spi_read(void *opaque, hwaddr offset, unsigned size)
> @@ -359,15 +377,8 @@ static void imx_spi_write(void *opaque, hwaddr offset, uint64_t value,
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
