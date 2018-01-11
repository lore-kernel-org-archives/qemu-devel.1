Received: from eggs.gnu.org ([2001:4830:134:3::10]:40576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZcj3-0002OY-M1
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:16:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZcj2-00041e-LT
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:16:57 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:42826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZcj2-00040P-GL
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:16:56 -0500
Received: by mail-ot0-x243.google.com with SMTP id s3so2037389otc.9
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 05:16:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171126231634.9531-8-frasse.iglesias@gmail.com>
References: <20171126231634.9531-1-frasse.iglesias@gmail.com>
	<20171126231634.9531-8-frasse.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 13:16:34 +0000
Message-ID: <CAFEAcA-Z2-M88JS7n+zW1AgA99gmeT-cj90BjbEzYEN95c6Zuw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v9 07/13] xilinx_spips: Add support for RX
 discard and RX drain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Francisco Iglesias <frasse.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgari@xilinx.com>, alistai@xilinx.com, francisco.iglesias@feimtech.se, =?UTF-8?Q?Marcin_Krzemi=C5=84ski?= <mar.krzeminski@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 26 November 2017 at 23:16, Francisco Iglesias
<frasse.iglesias@gmail.com> wrote:
> Add support for the RX discard and RX drain functionality. Also transmit
> one byte per dummy cycle (to the flash memories) with commands that require
> these.
>
> Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Hi. Coverity (CID 1383841) complains that this change introduces
a use of an uninitialized local variable:


>  static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
>  {
>      int debug_level = 0;
> +    XilinxQSPIPS *q = (XilinxQSPIPS *) object_dynamic_cast(OBJECT(s),
> +                                                           TYPE_XILINX_QSPIPS);
>
>      for (;;) {
>          int i;
>          uint8_t tx = 0;
>          uint8_t tx_rx[num_effective_busses(s)];

tx_rx[] is the variable in question.

> +        uint8_t dummy_cycles = 0;
> +        uint8_t addr_length;
>
>          if (fifo8_is_empty(&s->tx_fifo)) {
>              if (!(s->regs[R_LQSPI_CFG] & LQSPI_CFG_LQ_MODE)) {
> @@ -258,54 +336,102 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
>                  tx_rx[i] = fifo8_pop(&s->tx_fifo);
>              }
>              stripe8(tx_rx, num_effective_busses(s), false);
> -        } else {
> +        } else if (s->snoop_state >= SNOOP_ADDR) {
>              tx = fifo8_pop(&s->tx_fifo);
>              for (i = 0; i < num_effective_busses(s); ++i) {
>                  tx_rx[i] = tx;
>              }
> +        } else {
> +            /* Extract a dummy byte and generate dummy cycles according to the
> +             * link state */
> +            tx = fifo8_pop(&s->tx_fifo);
> +            dummy_cycles = 8 / s->link_state;
>          }

Before this if...else ladder was changed, each branch of it
filled in the whole tx_rx[] array. But the new else {} case
does not do that...

>          for (i = 0; i < num_effective_busses(s); ++i) {
>              int bus = num_effective_busses(s) - 1 - i;
> -            DB_PRINT_L(debug_level, "tx = %02x\n", tx_rx[i]);
> -            tx_rx[i] = ssi_transfer(s->spi[bus], (uint32_t)tx_rx[i]);
> -            DB_PRINT_L(debug_level, "rx = %02x\n", tx_rx[i]);
> +            if (dummy_cycles) {
> +                int d;
> +                for (d = 0; d < dummy_cycles; ++d) {
> +                    tx_rx[0] = ssi_transfer(s->spi[bus], (uint32_t)tx_rx[0]);
> +                }
> +            } else {
> +                DB_PRINT_L(debug_level, "tx = %02x\n", tx_rx[i]);
> +                tx_rx[i] = ssi_transfer(s->spi[bus], (uint32_t)tx_rx[i]);
> +                DB_PRINT_L(debug_level, "rx = %02x\n", tx_rx[i]);
> +            }

...and subsequent code, both introduced in this patch and code
already present, will read the tx_rx[] array.

Could one of you have a look at this and determine what the right
fix is, please?

thanks
-- PMM
