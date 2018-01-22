Received: from eggs.gnu.org ([2001:4830:134:3::10]:40225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eda6T-0000PF-Ee
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:17:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eda6S-0001zu-Fm
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:17:29 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:46384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eda6S-0001zA-AZ
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:17:28 -0500
Received: by mail-ot0-x243.google.com with SMTP id t35so7114013otd.13
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 03:17:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180117213458.17560-1-frasse.iglesias@gmail.com>
References: <20180117213458.17560-1-frasse.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2018 11:17:07 +0000
Message-ID: <CAFEAcA_XPr2ehGTDpP9ctzVQRv2xb9Bv3bQvE2YusVGpaUuyzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] xilinx_spips: Correct usage of an
 uninitialized local variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Francisco Iglesias <frasse.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgari@xilinx.com>, Alistair Francis <alistai@xilinx.com>, Francisco Iglesias <francisco.iglesias@feimtech.se>

On 17 January 2018 at 21:34, Francisco Iglesias
<frasse.iglesias@gmail.com> wrote:
> Coverity found that the variable tx_rx in the function
> xilinx_spips_flush_txfifo was being used uninitialized (CID 1383841). This
> patch corrects this by always initializing tx_rx to zeros.
>
> Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
>
> ---
> v2. Add a sanity check on the num_busses property when realizing the
>     devices.
> ---
>  hw/ssi/xilinx_spips.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index 85c5d0c..12f1de9 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -210,6 +210,9 @@
>  #define SNOOP_NONE 0xEE
>  #define SNOOP_STRIPING 0
>
> +#define MIN_NUM_BUSSES 1
> +#define MAX_NUM_BUSSES 2
> +
>  static inline int num_effective_busses(XilinxSPIPS *s)
>  {
>      return (s->regs[R_LQSPI_CFG] & LQSPI_CFG_SEP_BUS &&
> @@ -573,7 +576,7 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
>      for (;;) {
>          int i;
>          uint8_t tx = 0;
> -        uint8_t tx_rx[num_effective_busses(s)];
> +        uint8_t tx_rx[MAX_NUM_BUSSES] = { 0 };
>          uint8_t dummy_cycles = 0;
>          uint8_t addr_length;
>
> @@ -1221,6 +1224,14 @@ static void xilinx_spips_realize(DeviceState *dev, Error **errp)
>
>      DB_PRINT_L(0, "realized spips\n");
>
> +    if (s->num_busses < MIN_NUM_BUSSES || s->num_busses > MAX_NUM_BUSSES) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Invalid number of spi busses requested, "
> +                      "will default to use one bus\n",
> +                      __func__);
> +        s->num_busses = 1;

Realize functions should report errors in their parameters via the Error**
parameter (which will cause the realize operation to fail, which the caller
can deal with appropriately). Here's an example from the realize function
for the GICv3:

    if (s->num_irq > GICV3_MAXIRQ) {
        error_setg(errp,
                   "requested %u interrupt lines exceeds GIC maximum %d",
                   s->num_irq, GICV3_MAXIRQ);
        return;
    }

(Note no trailing \n required for error_setg strings, unlike qemu_log_mask.)

thanks
-- PMM
